import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../connector/meshcore_connector.dart';
import '../models/day_replay.dart';
import '../models/field_intel.dart' show distanceKm;
import '../storage/prefs_manager.dart';

/// Keeps where nodes advertised themselves over the last 30 days, so a day
/// can be replayed on the map. Only positions nodes broadcast in their
/// adverts are kept, on this phone.
class PositionHistoryService extends ChangeNotifier {
  PositionHistoryService(
    this.connector, {
    DateTime Function()? clock,
    Duration tick = const Duration(seconds: 30),
  }) : _now = clock ?? DateTime.now {
    _load();
    if (tick > Duration.zero) {
      _timer = Timer.periodic(tick, (_) => unawaited(scan()));
    }
  }

  static const _key = 'position_history_v1';
  static const keep = Duration(days: 30);
  static const minMoveMetres = 25.0;

  /// A node standing still still gets a point this often while heard, so
  /// the replay shows it was there.
  static const stillEvery = Duration(minutes: 10);
  static const maxPointsPerNode = 400;

  final MeshCoreConnector connector;
  final DateTime Function() _now;
  final Map<String, List<ReplayPoint>> _points = {};
  final Map<String, DateTime> _lastHeard = {};
  Timer? _timer;
  bool _disposed = false;

  /// Each node's track, named from its contact when known.
  List<ReplayTrack> tracks() {
    final names = {
      for (final c in connector.allContacts) c.publicKeyHex: c.name,
    };
    return [
      for (final e in _points.entries)
        if (e.value.isNotEmpty)
          ReplayTrack(
            id: e.key,
            name: names[e.key] ?? e.key.substring(0, 8).toUpperCase(),
            points: List.unmodifiable(e.value),
          ),
    ];
  }

  /// Looks at every contact once and records new positions.
  Future<void> scan() async {
    if (_disposed) return;
    var changed = false;
    for (final c in connector.allContacts) {
      final lat = c.latitude, lon = c.longitude;
      if (!c.hasLocation || lat == null || lon == null) continue;
      final key = c.publicKeyHex;
      final heard = c.lastSeen;
      final before = _lastHeard[key];
      if (before != null && !heard.isAfter(before)) continue;
      _lastHeard[key] = heard;
      final list = _points[key] ??= [];
      final last = list.isEmpty ? null : list.last;
      if (last != null) {
        final moved = distanceKm(last.lat, last.lon, lat, lon) * 1000;
        if (moved < minMoveMetres && heard.difference(last.at) < stillEvery) {
          continue;
        }
        if (!heard.isAfter(last.at)) continue;
      }
      list.add(ReplayPoint(heard, lat, lon));
      if (list.length > maxPointsPerNode) list.removeAt(0);
      changed = true;
    }
    if (changed) await _save();
  }

  /// Forgets every recorded position.
  Future<void> clear() async {
    _points.clear();
    await _save();
  }

  void _load() {
    try {
      final raw = PrefsManager.instance.getString(_key);
      if (raw == null) return;
      final map = jsonDecode(raw) as Map<String, dynamic>;
      for (final e in map.entries) {
        final list = [
          for (final p in e.value as List<dynamic>)
            ReplayPoint.fromJson(p as List<dynamic>),
        ];
        _points[e.key] = list;
        if (list.isNotEmpty) _lastHeard[e.key] = list.last.at;
      }
    } on StateError {
      // Storage not ready.
    } on FormatException {
      // Unreadable; start over.
    }
  }

  Future<void> _save() async {
    final cutoff = _now().subtract(keep);
    for (final list in _points.values) {
      list.removeWhere((p) => p.at.isBefore(cutoff));
    }
    _points.removeWhere((_, list) => list.isEmpty);
    if (!_disposed) notifyListeners();
    try {
      await PrefsManager.instance.setString(
        _key,
        jsonEncode({
          for (final e in _points.entries)
            e.key: [for (final p in e.value) p.toJson()],
        }),
      );
    } on StateError {
      // Storage not ready; kept in memory.
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _timer?.cancel();
    super.dispose();
  }
}
