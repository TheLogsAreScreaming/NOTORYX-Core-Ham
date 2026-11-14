import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';

/// One probe to a repeater and back: how long it took, how well the
/// repeater heard this radio, and how well this radio heard it.
class PingResult {
  final Duration roundTrip;
  final double snrThere;
  final double snrBack;
  const PingResult(this.roundTrip, this.snrThere, this.snrBack);
}

/// Parses a trace reply for [tag]: the SNR each hop heard, ending with the
/// SNR this radio heard the last hop at. Null when the frame isn't it.
List<double>? parseTraceSnrs(Uint8List frame, Uint8List tag) {
  if (frame.length < 12 || frame[0] != pushCodeTraceData) return null;
  if (!listEquals(frame.sublist(4, 8), tag)) return null;
  final pathLen = frame[2] == 0xFF ? 0 : frame[2];
  final width = 1 << (frame[3] & 0x03);
  final snrStart = 12 + pathLen;
  final snrCount = pathLen ~/ width + 1;
  if (frame.length < snrStart + snrCount) return null;
  return [
    for (var i = 0; i < snrCount; i++)
      frame[snrStart + i].toSigned(8).toDouble() / 4,
  ];
}

/// Sends one-hop path traces to a repeater this radio hears directly. The
/// trace goes out to the repeater, which notes the SNR it heard us at and
/// repeats it back, so one probe measures both directions.
class TracePinger {
  TracePinger(this.connector, {math.Random? random})
    : _random = random ?? math.Random();

  final MeshCoreConnector connector;
  final math.Random _random;
  Future<void> _busy = Future<void>.value();

  /// Probes the repeater whose public key is [repeaterKey]. Null when no
  /// reply came within [timeout]. Probes run one at a time.
  Future<PingResult?> ping(
    Uint8List repeaterKey, {
    Duration timeout = const Duration(seconds: 8),
  }) {
    final run = _busy.then((_) => _ping(repeaterKey, timeout));
    _busy = run.then((_) {}, onError: (_) {});
    return run;
  }

  Future<PingResult?> _ping(Uint8List key, Duration timeout) async {
    if (!connector.isConnected || key.length < 4) return null;
    final tagValue = _random.nextInt(1 << 31);
    final tag = Uint8List(4)
      ..buffer.asByteData().setUint32(0, tagValue, Endian.little);
    final reply = Completer<List<double>>();
    final sub = connector.receivedFrames.listen((frame) {
      final snrs = parseTraceSnrs(frame, tag);
      if (snrs != null && !reply.isCompleted) reply.complete(snrs);
    });
    final watch = Stopwatch()..start();
    try {
      // A 4-byte key prefix (flag 2) so repeaters sharing a short ID can't
      // answer for each other.
      await connector.sendFrame(
        buildTraceReq(tagValue, 0, 2, payload: key.sublist(0, 4)),
      );
      final snrs = await reply.future.timeout(timeout);
      if (snrs.length < 2) return null;
      return PingResult(watch.elapsed, snrs[0], snrs[1]);
    } on TimeoutException {
      return null;
    } finally {
      await sub.cancel();
    }
  }
}
