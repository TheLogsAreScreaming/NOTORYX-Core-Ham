// End-to-end check of the flood corridor protocol against usrflo's MeshCore
// simulator running the corridor firmware. Skipped unless MCSIM=1.
//
// Simulator setup (macOS/Linux, needs Rust and clang):
//   git clone https://github.com/usrflo/mcsim && cd mcsim && rmdir MeshCore
//   git clone -b feature/flood-corridor https://github.com/usrflo/MeshCore
//   cargo build --release
//   ./target/release/mcsim run examples/topologies/corridor_demo_app.yaml
// Avoid --trace: it logs every timer tick and grows by gigabytes per hour.
//
// Then: MCSIM=1 flutter test test/integration/flood_corridor_sim_test.dart
//
// Topology: Alice (tcp 9300) reaches Bob (tcp 9301) only through the
// repeaters R_in_H then R_in_V; R_out_SW and R_out_N hear Alice directly.
// Verified against usrflo/MeshCore ab947662.
library;

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/flood_corridor.dart';
import 'package:meshcore_open/services/usb_serial_frame_codec.dart';

const _alicePort = 9300;
const _bobPort = 9301;
const _alice = (lat: 47.6100, lon: -122.4000);
const _bob = (lat: 47.7400, lon: -122.2500);
const _publicChannel = 0;

class _Radio {
  _Radio._(this._socket) {
    _socket.listen((bytes) {
      for (final packet in _decoder.ingest(Uint8List.fromList(bytes))) {
        if (!packet.isRxFrame) continue;
        final code = packet.payload.isEmpty ? -1 : packet.payload[0];
        if (code == respCodeChannelMsgRecv ||
            code == respCodeChannelMsgRecvV3) {
          channelTexts.add(String.fromCharCodes(packet.payload));
        }
        _frames.add(packet.payload);
      }
    });
  }

  final Socket _socket;
  final _decoder = UsbSerialFrameDecoder();
  final _frames = StreamController<Uint8List>.broadcast();

  /// Every channel message seen on this connection. The simulator's own agent
  /// shares the UART and may fetch messages before we ask, so record them all.
  final List<String> channelTexts = [];

  static Future<_Radio> connect(int port) async =>
      _Radio._(await Socket.connect(InternetAddress.loopbackIPv4, port));

  Future<Uint8List> request(
    Uint8List frame,
    Set<int> replyCodes, {
    Duration timeout = const Duration(seconds: 5),
  }) {
    final reply = _frames.stream.firstWhere(
      (f) => f.isNotEmpty && replyCodes.contains(f[0]),
    );
    _socket.add(wrapUsbSerialTxFrame(frame));
    return reply.timeout(timeout);
  }

  Future<void> close() async {
    await _socket.close();
    await _frames.close();
  }
}

/// Polls [radio]'s message queue for up to [within] and returns every channel
/// text seen on the connection; stops early once one contains [until].
Future<List<String>> _receivedChannelTexts(
  _Radio radio,
  Duration within, {
  String? until,
}) async {
  final deadline = DateTime.now().add(within);
  while (DateTime.now().isBefore(deadline)) {
    if (until != null && radio.channelTexts.any((t) => t.contains(until))) {
      break;
    }
    await radio.request(buildSyncNextMessageFrame(), {
      respCodeChannelMsgRecv,
      respCodeChannelMsgRecvV3,
      respCodeContactMsgRecv,
      respCodeContactMsgRecvV3,
      respCodeNoMoreMessages,
    });
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
  return radio.channelTexts;
}

void main() {
  final enabled = Platform.environment['MCSIM'] == '1';
  late _Radio alice;
  late _Radio bob;

  setUpAll(() async {
    if (!enabled) return;
    alice = await _Radio.connect(_alicePort);
    bob = await _Radio.connect(_bobPort);
    for (final radio in [alice, bob]) {
      await radio.request(buildAppStartFrame(), {respCodeSelfInfo});
    }
    await alice.request(buildSetAdvertLatLonFrame(_alice.lat, _alice.lon), {
      respCodeOk,
    });
    await _receivedChannelTexts(bob, const Duration(seconds: 1));
  });

  tearDownAll(() async {
    if (!enabled) return;
    await alice.close();
    await bob.close();
  });

  test('detection probe gets a corridor region reply', () async {
    final reply = await alice.request(buildGetCorridorRegionFrame(), {
      respCodeCorridorRegion,
      respCodeErr,
    });
    expect(reply[0], respCodeCorridorRegion);
    expect(parseCorridorRegionFrame(reply), isNotNull);
  }, skip: !enabled);

  test('corridor region round-trips and resets', () async {
    await alice.request(buildSetCorridorRegionFrame('#sim-test'), {respCodeOk});
    var reply = await alice.request(buildGetCorridorRegionFrame(), {
      respCodeCorridorRegion,
    });
    expect(parseCorridorRegionFrame(reply), 'sim-test');

    await alice.request(buildSetCorridorRegionFrame(''), {respCodeOk});
    reply = await alice.request(buildGetCorridorRegionFrame(), {
      respCodeCorridorRegion,
    });
    expect(parseCorridorRegionFrame(reply), '');
  }, skip: !enabled);

  test('proposes a corridor from Alice to Bob', () async {
    final reply = await alice.request(
      buildProposeCorridorFrame(_bob.lat, _bob.lon),
      {respCodeProposeCorridor, respCodeErr},
    );
    expect(reply[0], respCodeProposeCorridor);
    final proposal = parseCorridorProposalFrame(reply)!;
    expect(proposal.triples.length, greaterThanOrEqualTo(2));
    expect(proposal.triples.first.lat, closeTo(_alice.lat, 0.02));
    expect(proposal.triples.last.lat, closeTo(_bob.lat, 0.02));
    expect(proposal.triples.last.lon, closeTo(_bob.lon, 0.02));
  }, skip: !enabled);

  test(
    'a corridor along the path delivers to Bob',
    () async {
      final reply = await alice.request(
        buildProposeCorridorFrame(_bob.lat, _bob.lon),
        {respCodeProposeCorridor},
      );
      final corridor = parseCorridorProposalFrame(reply)!.triples;
      await alice.request(
        buildSendChannelTextMsgCorridorFrame(
          _publicChannel,
          'corridor-hit',
          corridor,
        ),
        {respCodeOk},
      );
      final texts = await _receivedChannelTexts(
        bob,
        const Duration(seconds: 20),
        until: 'corridor-hit',
      );
      expect(texts.any((t) => t.contains('corridor-hit')), isTrue);
    },
    timeout: const Timeout(Duration(seconds: 60)),
    skip: !enabled,
  );

  test(
    'a corridor that excludes the repeaters does not reach Bob',
    () async {
      // 1 km around Alice: R_in_H (~7 km away) is outside and must not forward.
      final corridor = [
        CorridorTriple(lat: _alice.lat, lon: _alice.lon, radiusCode: 0),
      ];
      await alice.request(
        buildSendChannelTextMsgCorridorFrame(
          _publicChannel,
          'corridor-miss',
          corridor,
          flags: corridorFlagFailClosed,
        ),
        {respCodeOk},
      );
      final texts = await _receivedChannelTexts(
        bob,
        const Duration(seconds: 20),
        until: 'corridor-miss',
      );
      expect(texts.any((t) => t.contains('corridor-miss')), isFalse);
    },
    timeout: const Timeout(Duration(seconds: 60)),
    skip: !enabled,
  );
}
