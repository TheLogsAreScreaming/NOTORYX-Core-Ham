import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/cayenne_lpp.dart';
import '../utils/app_logger.dart';

/// Where a cached measurement was observed, never an inference from node age.
enum TelemetrySource { telemetry, status, sensor, self }

enum TelemetryMetric { battery, temperature, humidity, pressure }

/// One immutable, timestamped LPP measurement. Channels remain independent.
class NodeReading {
  const NodeReading({
    required this.channel,
    required this.type,
    required this.value,
    required this.at,
    required this.source,
  });
  final int channel;
  final int type;
  final Object value;
  final DateTime at;
  final TelemetrySource source;
  String get id => '$channel:$type';
  bool staleAt(DateTime now) => now.difference(at) >= const Duration(hours: 1);
  bool expiredAt(DateTime now) =>
      now.difference(at) >= const Duration(hours: 24);
  Map<String, dynamic> get lpp => {
    'channel': channel,
    'type': type,
    'value': value,
  };
  Map<String, dynamic> toJson() => {
    ...lpp,
    'at': at.millisecondsSinceEpoch,
    'source': source.name,
  };
}

/// Bounded, local telemetry cache, isolated by the connected radio identity.
/// It never sends packets. Reading timestamps are retained across partial updates.
class NodeTelemetryStore extends ChangeNotifier {
  NodeTelemetryStore(
    this.prefs, {
    DateTime Function()? clock,
    this.maxNodes = 256,
  }) : assert(maxNodes > 0),
       _now = clock ?? DateTime.now;
  final SharedPreferences prefs;
  final DateTime Function() _now;
  final int maxNodes;
  final Map<String, Map<String, NodeReading>> _nodes = {};
  String _scope = '';
  Timer? _saveTimer;
  Future<void> _writes = Future.value();
  bool _disposed = false;
  String get scope => _scope;
  DateTime get now => _now();
  int get nodeCount => _nodes.length;

  static bool _keyValid(String key) => RegExp(r'^[0-9a-f]{64}$').hasMatch(key);
  static const _types = {
    CayenneLpp.lppVoltage,
    CayenneLpp.lppPercentage,
    CayenneLpp.lppTemperature,
    CayenneLpp.lppRelativeHumidity,
    CayenneLpp.lppBarometricPressure,
    CayenneLpp.lppLuminosity,
    CayenneLpp.lppGps,
    CayenneLpp.lppAltitude,
    CayenneLpp.lppCurrent,
    CayenneLpp.lppPower,
    CayenneLpp.lppConcentration,
  };

  static Object? _value(int type, dynamic value) {
    if (!_types.contains(type)) return null;
    if (type == CayenneLpp.lppGps) {
      if (value is! Map) return null;
      final lat = value['latitude'],
          lon = value['longitude'],
          alt = value['altitude'];
      if (lat is! num ||
          lon is! num ||
          alt is! num ||
          !lat.isFinite ||
          !lon.isFinite ||
          !alt.isFinite ||
          lat.abs() > 90 ||
          lon.abs() > 180)
        return null;
      return Map<String, dynamic>.unmodifiable({
        'latitude': lat,
        'longitude': lon,
        'altitude': alt,
      });
    }
    if (value is! num || !value.isFinite) return null;
    if ((type == CayenneLpp.lppPercentage ||
            type == CayenneLpp.lppRelativeHumidity) &&
        (value < 0 || value > 100))
      return null;
    if ((type == CayenneLpp.lppVoltage ||
            type == CayenneLpp.lppLuminosity ||
            type == CayenneLpp.lppBarometricPressure) &&
        value < 0)
      return null;
    return value;
  }

  void setScope(String key) {
    key = key.toLowerCase();
    if (!_keyValid(key)) key = '';
    if (_scope == key) return;
    unawaited(flush());
    _nodes.clear();
    _scope = key;
    if (key.isNotEmpty) {
      try {
        final raw = prefs.getString('node_telemetry_v1_$key');
        if (raw != null) {
          final data = jsonDecode(raw);
          if (data is Map) {
            for (final entry in data.entries) {
              if (entry.key is! String ||
                  !_keyValid(entry.key as String) ||
                  entry.value is! List)
                continue;
              for (final item in entry.value as List) {
                if (item is! Map ||
                    item['channel'] is! int ||
                    (item['channel'] as int) < 0 ||
                    (item['channel'] as int) > 255 ||
                    item['type'] is! int ||
                    item['at'] is! int)
                  continue;
                final value = _value(item['type'] as int, item['value']);
                if (value == null) continue;
                final at = DateTime.fromMillisecondsSinceEpoch(
                  item['at'] as int,
                );
                if (at.isAfter(now) ||
                    now.difference(at) >= const Duration(hours: 24))
                  continue;
                final sources = TelemetrySource.values.where(
                  (s) => s.name == item['source'],
                );
                if (sources.isEmpty) continue;
                _put(
                  entry.key as String,
                  NodeReading(
                    channel: item['channel'] as int,
                    type: item['type'] as int,
                    value: value,
                    at: at,
                    source: sources.first,
                  ),
                );
              }
            }
          }
        }
      } catch (e) {
        appLogger.error('Cannot load telemetry cache: $e');
      }
    }
    _trim();
    notifyListeners();
  }

  void record(
    String key,
    Iterable<Map<String, dynamic>> readings, {
    required TelemetrySource source,
    DateTime? at,
  }) {
    if (_disposed || _scope.isEmpty || !_keyValid(key)) return;
    final time = at ?? now;
    if (time.isAfter(now) || now.difference(time) >= const Duration(hours: 24))
      return;
    var changed = false;
    for (final raw in readings) {
      final type = raw['type'], channel = raw['channel'];
      if (type is! int || channel is! int || channel < 0 || channel > 255)
        continue;
      final value = _value(type, raw['value']);
      if (value == null) continue;
      changed =
          _put(
            key,
            NodeReading(
              channel: channel,
              type: type,
              value: value,
              at: time,
              source: source,
            ),
          ) ||
          changed;
    }
    if (!changed) return;
    _trim();
    _saveTimer?.cancel();
    _saveTimer = Timer(
      const Duration(milliseconds: 250),
      () => unawaited(flush()),
    );
    notifyListeners();
  }

  bool _put(String key, NodeReading reading) {
    final node = _nodes.putIfAbsent(key, () => {});
    final previous = node[reading.id];
    if (previous != null && previous.at.isAfter(reading.at)) return false;
    if (!node.containsKey(reading.id) && node.length >= 32) {
      final oldest = node.values.reduce((a, b) => a.at.isBefore(b.at) ? a : b);
      node.remove(oldest.id);
    }
    node[reading.id] = reading;
    return true;
  }

  List<NodeReading> readingsFor(String key) => List.unmodifiable(
    (_nodes[key]?.values ?? <NodeReading>[])
        .where((r) => !r.expiredAt(now))
        .toList()
      ..sort(
        (a, b) => a.channel != b.channel
            ? a.channel.compareTo(b.channel)
            : a.type.compareTo(b.type),
      ),
  );

  NodeReading? metricFor(String key, TelemetryMetric metric) {
    final types = switch (metric) {
      // An arbitrary percentage sensor is not necessarily a battery gauge.
      TelemetryMetric.battery => {CayenneLpp.lppVoltage},
      TelemetryMetric.temperature => {CayenneLpp.lppTemperature},
      TelemetryMetric.humidity => {CayenneLpp.lppRelativeHumidity},
      TelemetryMetric.pressure => {CayenneLpp.lppBarometricPressure},
    };
    final matches =
        readingsFor(key).where((r) => types.contains(r.type)).toList()
          ..sort((a, b) => b.at.compareTo(a.at));
    return matches.isEmpty ? null : matches.first;
  }

  void _trim() {
    for (final node in _nodes.values) {
      node.removeWhere((_, r) => r.expiredAt(now));
    }
    _nodes.removeWhere((_, values) => values.isEmpty);
    if (_nodes.length <= maxNodes) return;
    final keys = _nodes.keys.toList()
      ..sort((a, b) {
        DateTime newest(String key) => _nodes[key]!.values
            .map((r) => r.at)
            .reduce((a, b) => a.isAfter(b) ? a : b);
        return newest(b).compareTo(newest(a));
      });
    for (final key in keys.skip(maxNodes)) {
      _nodes.remove(key);
    }
  }

  Future<void> flush() {
    _saveTimer?.cancel();
    if (_scope.isEmpty) return _writes;
    _trim();
    final key = 'node_telemetry_v1_$_scope';
    final data = jsonEncode(
      _nodes.map(
        (key, value) =>
            MapEntry(key, value.values.map((r) => r.toJson()).toList()),
      ),
    );
    _writes = _writes
        .then((_) async {
          if (!await prefs.setString(key, data))
            throw StateError('Telemetry cache write failed');
        })
        .catchError((Object e) {
          appLogger.error('Cannot save telemetry cache: $e');
        });
    return _writes;
  }

  @override
  void dispose() {
    unawaited(flush());
    _disposed = true;
    super.dispose();
  }
}
