import 'dart:convert';

import '../storage/secure_prefs.dart';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/waypoint.dart';
import '../utils/app_logger.dart';

/// Saved waypoints and routes on this device, for every radio.
class WaypointStore extends ChangeNotifier {
  WaypointStore(this.prefs) {
    _load();
  }

  final SharedPreferences prefs;
  static const _key = 'waypoints_v1';
  static const maxWaypoints = 1000;
  static const maxRoutes = 100;

  final List<Waypoint> _waypoints = [];
  final List<WaypointRoute> _routes = [];

  List<Waypoint> get waypoints => List.unmodifiable(_waypoints);
  List<WaypointRoute> get routes => List.unmodifiable(_routes);

  void _load() {
    try {
      final raw = SecurePrefs.isActive
          ? SecurePrefs.getString(_key)
          : prefs.getString(_key);
      if (raw == null) return;
      final data = jsonDecode(raw);
      if (data is! Map) return;
      for (final w in data['waypoints'] as List? ?? []) {
        if (Waypoint.fromJson(w) case final p?) _waypoints.add(p);
      }
      for (final r in data['routes'] as List? ?? []) {
        if (WaypointRoute.fromJson(r) case final x?) _routes.add(x);
      }
    } catch (e) {
      appLogger.warn('Cannot load waypoints: $e');
    }
  }

  Future<void> _save() async {
    notifyListeners();
    final encoded = jsonEncode({
      'waypoints': [for (final w in _waypoints) w.toJson()],
      'routes': [for (final r in _routes) r.toJson()],
    });
    if (SecurePrefs.isActive) {
      await SecurePrefs.setString(_key, encoded);
    } else {
      await prefs.setString(_key, encoded);
    }
  }

  /// Whether a waypoint with this name is already saved within about 2 m.
  bool _has(Waypoint w) => _waypoints.any(
    (e) =>
        e.name == w.name &&
        (e.lat - w.lat).abs() < 0.00002 &&
        (e.lon - w.lon).abs() < 0.00002,
  );

  /// Saves [w] unless the same place under the same name is saved already.
  /// Returns whether it was added.
  Future<bool> add(Waypoint w) async {
    if (_has(w) || _waypoints.length >= maxWaypoints) return false;
    _waypoints.add(w);
    await _save();
    return true;
  }

  /// Adds what a GPX file held, skipping duplicates and anything over the
  /// limits. Returns how many waypoints and routes were added.
  Future<({int waypoints, int routes})> addImport(GpxImport import) async {
    var w = 0, r = 0;
    for (final p in import.waypoints) {
      if (_has(p) || _waypoints.length >= maxWaypoints) continue;
      _waypoints.add(p);
      w++;
    }
    for (final route in import.routes) {
      if (_routes.length >= maxRoutes) break;
      _routes.add(route);
      r++;
    }
    if (w + r > 0) await _save();
    return (waypoints: w, routes: r);
  }

  Future<void> remove(String id) async {
    _waypoints.removeWhere((w) => w.id == id);
    await _save();
  }

  Future<void> removeRoute(String id) async {
    _routes.removeWhere((r) => r.id == id);
    await _save();
  }
}
