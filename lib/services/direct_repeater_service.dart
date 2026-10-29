import 'dart:async';

import 'package:flutter/foundation.dart';

import '../connector/meshcore_connector.dart';
import '../models/direct_repeaters.dart';
import '../models/radio_rx_packet.dart';

/// Keeps track of the nodes this radio hears directly (one hop away) and
/// how strongly, from every packet the radio receives.
class DirectRepeaterService extends ChangeNotifier {
  DirectRepeaterService(this._connector, {DateTime Function()? clock})
    : _now = clock ?? DateTime.now {
    _sub = _connector.rxPackets.listen(_onPacket);
  }

  final MeshCoreConnector _connector;
  final DateTime Function() _now;
  late final StreamSubscription<RadioRxPacket> _sub;
  final Map<String, DirectHeard> _heard = {};
  bool _disposed = false;

  /// Most neighbours kept; the least recently heard are dropped beyond it.
  static const maxTracked = 200;

  Iterable<DirectHeard> get heard => _heard.values;

  /// The best few heard in the last hour.
  List<DirectHeard> best({int limit = 5}) =>
      rankDirect(_heard.values, _now(), limit: limit);

  @visibleForTesting
  void record(RadioRxPacket packet) => _onPacket(packet);

  void _onPacket(RadioRxPacket packet) {
    if (packet.fromSelf) return;
    final from = heardDirectlyFrom(packet.raw);
    if (from == null) return;
    final id = from
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join()
        .toUpperCase();
    final at = packet.receivedAt;
    final existing = _heard[id];
    if (existing != null) {
      existing.add(packet.snr, at);
    } else {
      _heard[id] = DirectHeard(id: id, snr: packet.snr, lastHeard: at);
      if (_heard.length > maxTracked) {
        final oldest = _heard.values.reduce(
          (a, b) => a.lastHeard.isBefore(b.lastHeard) ? a : b,
        );
        _heard.remove(oldest.id);
      }
    }
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    unawaited(_sub.cancel());
    super.dispose();
  }
}
