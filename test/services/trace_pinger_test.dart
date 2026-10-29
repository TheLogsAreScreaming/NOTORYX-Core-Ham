import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/screens/antenna_hunt_screen.dart';
import 'package:meshcore_open/services/trace_pinger.dart';

/// A trace reply: one 4-byte hop, then SNR at the hop and SNR back, each
/// in quarter-dB.
Uint8List _reply(Uint8List tag, Uint8List hop, int snrThere, int snrBack) =>
    Uint8List.fromList([
      pushCodeTraceData,
      0,
      4,
      2,
      ...tag,
      0,
      0,
      0,
      0,
      ...hop,
      snrThere & 0xFF,
      snrBack & 0xFF,
    ]);

class _Radio extends MeshCoreConnector {
  final frames = StreamController<Uint8List>.broadcast();
  final sent = <Uint8List>[];
  bool answer = true;

  @override
  bool get isConnected => true;
  @override
  Stream<Uint8List> get receivedFrames => frames.stream;
  @override
  Future<void> sendFrame(
    Uint8List data, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async {
    sent.add(data);
    if (!answer) return;
    // [cmd][tag x4][auth x4][flag][hop x4]
    final tag = data.sublist(1, 5);
    final hop = data.sublist(10, 14);
    scheduleMicrotask(() {
      frames.add(_reply(Uint8List(4), hop, 40, 40)); // someone else's trace
      frames.add(_reply(tag, hop, 26, -22)); // 6.5 dB there, -5.5 back
    });
  }
}

void main() {
  final key = Uint8List.fromList(List.generate(32, (i) => i + 1));

  test('a ping reads both directions from its own reply', () async {
    final radio = _Radio();
    final result = await TracePinger(radio).ping(key);
    expect(result, isNotNull);
    expect(result!.snrThere, 6.5);
    expect(result.snrBack, -5.5);
    final frame = radio.sent.single;
    expect(frame[0], cmdSendTracePath);
    expect(frame[9], 2, reason: '4-byte hop prefixes');
    expect(frame.sublist(10), key.sublist(0, 4));
  });

  test('no reply times out to null', () async {
    final radio = _Radio()..answer = false;
    final result = await TracePinger(
      radio,
    ).ping(key, timeout: const Duration(milliseconds: 50));
    expect(result, isNull);
  });

  test('frames that are not this trace are ignored', () {
    final tag = Uint8List.fromList([1, 2, 3, 4]);
    expect(parseTraceSnrs(Uint8List.fromList([0x00, 1, 2]), tag), isNull);
    expect(
      parseTraceSnrs(_reply(Uint8List(4), Uint8List(4), 1, 1), tag),
      isNull,
    );
    expect(parseTraceSnrs(_reply(tag, Uint8List(4), 8, -4), tag), [2.0, -1.0]);
  });

  test('clicks speed up as the signal improves', () {
    expect(clickIntervalFor(-20).inMilliseconds, 1500);
    expect(clickIntervalFor(12).inMilliseconds, 120);
    expect(clickIntervalFor(0) < clickIntervalFor(-5), isTrue);
  });
}
