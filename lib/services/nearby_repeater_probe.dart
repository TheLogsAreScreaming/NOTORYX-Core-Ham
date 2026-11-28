import 'dart:async';
import 'dart:math';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../models/wardrive.dart';

/// Sends one zero-hop discover request for repeaters and collects the
/// answers that arrive within [listen].
///
/// The companion sends the request without a path, so only repeaters in
/// direct range hear it. Repeaters answer a few discover requests per
/// couple of minutes at most, so callers space tests out.
class NearbyRepeaterProbe {
  NearbyRepeaterProbe(
    this.connector, {
    this.listen = const Duration(seconds: 8),
    Random? random,
  }) : _random = random ?? Random();

  /// Minimum time between two tests.
  static const spacing = Duration(seconds: 30);

  final MeshCoreConnector connector;
  final Duration listen;
  final Random _random;

  Future<List<WardriveReply>> run() async {
    final tag = _random.nextInt(0x7FFFFFFF);
    final replies = <String, WardriveReply>{};
    final sub = connector.receivedFrames.listen((frame) {
      final reply = parseDiscoverReply(frame, tag);
      if (reply != null) replies.putIfAbsent(reply.prefix, () => reply);
    });
    try {
      await connector.sendFrame(
        buildSendControlDataFrame(
          buildDiscoveryRequestPayload(tag, prefixOnly: true),
        ),
      );
      await Future<void>.delayed(listen);
    } finally {
      await sub.cancel();
    }
    return replies.values.toList();
  }
}
