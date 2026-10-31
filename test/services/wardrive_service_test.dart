import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/wardrive.dart';
import 'package:meshcore_open/services/coverage_hex_service.dart';
import 'package:meshcore_open/services/wardrive_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A repeater's reply to the discover request tagged [tag].
Uint8List reply(
  int tag,
  List<int> prefix, {
  int snrHere = 24,
  int snrThere = 12,
}) {
  final b = BytesBuilder()
    ..add([pushCodeControlData, snrHere & 0xFF, 0xA4, 0])
    ..addByte((controlSubtypeDiscoverResp << 4) | advTypeRepeater)
    ..addByte(snrThere & 0xFF);
  final t = ByteData(4)..setUint32(0, tag, Endian.little);
  b
    ..add(t.buffer.asUint8List())
    ..add(prefix);
  return b.toBytes();
}

/// Reads the tag out of a CMD_SEND_CONTROL_DATA discover request.
int tagOf(Uint8List frame) =>
    ByteData.sublistView(frame).getUint32(3, Endian.little);

class _Radio extends MeshCoreConnector {
  final frames = StreamController<Uint8List>.broadcast();
  double? lat = 41.328, lon = -73.094;
  bool connected = true;
  int sends = 0;

  /// Prefixes that answer each ping.
  List<List<int>> answering = [
    [0xFA, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07],
  ];

  @override
  bool get isConnected => connected;
  @override
  double? get selfLatitude => lat;
  @override
  double? get selfLongitude => lon;
  @override
  Stream<Uint8List> get receivedFrames => frames.stream;
  @override
  Future<void> sendFrame(
    Uint8List data, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async {
    sends++;
    final tag = tagOf(data);
    for (final p in answering) {
      scheduleMicrotask(() => frames.add(reply(tag, p)));
    }
    // Another ping's reply must be ignored.
    scheduleMicrotask(() => frames.add(reply(tag + 1, [0x99])));
  }
}

void main() {
  test('reads a repeater reply and ignores other tags and types', () {
    final frame = reply(7, [0xAB, 0xCD], snrHere: 22, snrThere: -10);
    final r = parseDiscoverReply(frame, 7)!;
    expect(r.prefix, 'abcd');
    expect(r.snrHere, 5.5);
    expect(r.snrThere, -2.5);
    expect(r.rssiHere, -92);
    expect(parseDiscoverReply(frame, 8), isNull);
    expect(parseDiscoverReply(Uint8List.fromList([0x00, 1, 2]), 7), isNull);
  });

  test('a ping’s best link is the weaker direction of its best repeater', () {
    final t0 = DateTime.utc(2026, 10, 30);
    final ping = WardrivePing(
      at: t0,
      latitude: 1,
      longitude: 2,
      replies: const [
        WardriveReply(prefix: 'a', snrThere: 2, snrHere: 9, rssiHere: -90),
        WardriveReply(prefix: 'b', snrThere: 6, snrHere: 4, rssiHere: -90),
      ],
    );
    expect(ping.bestSnr, 4);
    expect(WardrivePing(at: t0, latitude: 1, longitude: 2).bestSnr, isNull);
  });

  group('service', () {
    late _Radio radio;
    late WardriveService service;
    late StreamController<PositionFix> gps;

    setUp(() async {
      gps = StreamController<PositionFix>.broadcast();
      SharedPreferences.setMockInitialValues({});
      PrefsManager.reset();
      await PrefsManager.initialize();
      radio = _Radio();
      service = WardriveService(
        radio,
        listenWindow: const Duration(milliseconds: 30),
        fixes: () => gps.stream,
      )..load();
    });
    tearDown(() {
      service.dispose();
      unawaited(gps.close());
      PrefsManager.reset();
    });

    test('a ping records the spot and who answered', () async {
      await service.start();
      final ping = service.active!.pings.single;
      expect(ping.latitude, 41.328);
      expect(ping.replies.single.prefix, 'fa01020304050607');
      expect(service.active!.heardCount, 1);
    });

    test(
      'pings follow the phone as it moves, not where the radio started',
      () async {
        await service.start();
        gps.add(PositionFix(41.40, -73.20, 5, DateTime.now()));
        await Future<void>.delayed(Duration.zero);
        expect(service.position, (lat: 41.40, lon: -73.20));
        await service.pingNow();
        gps.add(PositionFix(41.50, -73.30, 5, DateTime.now()));
        await Future<void>.delayed(Duration.zero);
        await service.pingNow();
        final pings = service.active!.pings;
        expect(pings.map((p) => p.latitude), [41.328, 41.40, 41.50]);
        expect(pings.last.longitude, -73.30);
      },
    );

    test('without phone GPS it falls back to the radio', () async {
      gps.addError(StateError('Location permission was not granted.'));
      await service.start();
      expect(service.position, (lat: 41.328, lon: -73.094));
      expect(service.active!.pings.single.latitude, 41.328);
    });

    test('an unheard ping is still recorded, as red', () async {
      radio.answering = [];
      await service.start();
      expect(service.active!.pings.single.heard, isFalse);
    });

    test('without a GPS fix it waits instead of pinging', () async {
      radio.lat = null;
      await service.start();
      expect(radio.sends, 0);
      expect(service.wait, WardriveWait.noPosition);
      expect(service.active!.pings, isEmpty);
    });

    test('stopping saves the session; an empty one is dropped', () async {
      await service.start();
      await service.pingNow();
      await service.stop();
      expect(service.running, isFalse);
      expect(service.sessions.single.pings, hasLength(2));

      final reloaded = WardriveService(radio)..load();
      expect(reloaded.sessions.single.pings, hasLength(2));
      reloaded.dispose();

      radio.lat = null;
      await service.start();
      await service.stop();
      expect(service.sessions, hasLength(1));
    });

    test('a session can be deleted', () async {
      await service.start();
      await service.stop();
      await service.deleteSession(service.sessions.single.id);
      expect(service.sessions, isEmpty);
    });

    test('the interval can’t go below 20 s', () {
      service.setInterval(5);
      expect(service.interval, const Duration(seconds: 20));
    });
  });
}
