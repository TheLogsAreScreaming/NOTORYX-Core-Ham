import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/cayenne_lpp.dart';
import '../utils/app_logger.dart';
import 'node_telemetry_store.dart';

/// One numeric sensor value at a moment.
@immutable
class SensorSample {
  const SensorSample(this.at, this.value);

  final DateTime at;
  final double value;

  List<num> toJson() => [at.millisecondsSinceEpoch, value];

  static SensorSample? fromJson(Object? json) {
    if (json is! List || json.length != 2) return null;
    final at = json[0], v = json[1];
    if (at is! int || v is! num || !v.isFinite) return null;
    return SensorSample(DateTime.fromMillisecondsSinceEpoch(at), v.toDouble());
  }
}

/// An alert on one sensor value: fires when a new reading goes above
/// [above] or below [below].
@immutable
class SensorThreshold {
  const SensorThreshold({this.above, this.below});

  final double? above;
  final double? below;

  bool get isEmpty => above == null && below == null;

  /// Which side [value] is outside of, or null when it's within bounds.
  bool? breaches(double value) {
    if (above != null && value > above!) return true;
    if (below != null && value < below!) return false;
    return null;
  }

  Map<String, double> toJson() => {'above': ?above, 'below': ?below};

  static SensorThreshold? fromJson(Object? json) {
    if (json is! Map) return null;
    double? d(Object? v) => v is num && v.isFinite ? v.toDouble() : null;
    final t = SensorThreshold(above: d(json['above']), below: d(json['below']));
    return t.isEmpty ? null : t;
  }
}

/// What tripped an alert.
typedef SensorAlert = ({
  String nodeKey,
  String metricId,
  int type,
  double value,
  double limit,
  bool above,
});

/// Numeric telemetry readings over the last day per node and value, for
/// sensor history charts, plus per-value alert thresholds.
///
/// It is fed by [NodeTelemetryStore] (every telemetry reply, sensor push or
/// status the app already gets), so it never asks the radio for anything.
class SensorHistoryStore extends ChangeNotifier {
  SensorHistoryStore(this.prefs, {DateTime Function()? clock, this.onAlert})
    : _now = clock ?? DateTime.now {
    _loadThresholds();
  }

  final SharedPreferences prefs;
  final DateTime Function() _now;

  /// Called when a new reading crosses a threshold.
  void Function(SensorAlert alert)? onAlert;

  static const keep = Duration(hours: 26);
  static const maxSamplesPerValue = 720;
  static const maxNodes = 64;

  /// Readings this close together replace each other.
  static const mergeWithin = Duration(seconds: 20);

  /// A threshold that fired stays quiet this long, so a value hovering at
  /// the line doesn't alert again and again.
  static const alertCooldown = Duration(minutes: 30);

  static const _thresholdKey = 'sensor_thresholds_v1';
  static String _historyKey(String scope) => 'sensor_history_v1_$scope';

  /// LPP types that have a single number worth charting.
  static const chartable = {
    CayenneLpp.lppVoltage,
    CayenneLpp.lppPercentage,
    CayenneLpp.lppTemperature,
    CayenneLpp.lppRelativeHumidity,
    CayenneLpp.lppBarometricPressure,
    CayenneLpp.lppLuminosity,
    CayenneLpp.lppAltitude,
    CayenneLpp.lppCurrent,
    CayenneLpp.lppPower,
    CayenneLpp.lppConcentration,
  };

  final Map<String, Map<String, List<SensorSample>>> _nodes = {};
  final Map<String, SensorThreshold> _thresholds = {};
  final Map<String, DateTime> _lastAlert = {};
  String _scope = '';
  Timer? _saveTimer;
  Future<void> _writes = Future.value();
  bool _disposed = false;

  DateTime get now => _now();
  String get scope => _scope;

  static bool _keyValid(String key) => RegExp(r'^[0-9a-f]{64}$').hasMatch(key);

  /// `channel:type`, the same id [NodeReading] uses.
  static String metricId(int channel, int type) => '$channel:$type';
  static int typeOf(String metricId) =>
      int.tryParse(metricId.split(':').last) ?? -1;
  static int channelOf(String metricId) =>
      int.tryParse(metricId.split(':').first) ?? -1;

  /// Values with readings for [nodeKey], by channel then type.
  List<String> metricsFor(String nodeKey) {
    final ids = (_nodes[nodeKey.toLowerCase()]?.keys ?? const <String>[])
        .toList();
    ids.sort((a, b) {
      final c = channelOf(a).compareTo(channelOf(b));
      return c != 0 ? c : typeOf(a).compareTo(typeOf(b));
    });
    return ids;
  }

  /// Readings of one value, oldest first.
  List<SensorSample> samplesFor(String nodeKey, String metricId) =>
      List.unmodifiable(_nodes[nodeKey.toLowerCase()]?[metricId] ?? const []);

  SensorThreshold? thresholdFor(String nodeKey, String metricId) =>
      _thresholds['${nodeKey.toLowerCase()}|$metricId'];

  /// Sets or clears (with null or an empty one) the alert on one value.
  Future<void> setThreshold(
    String nodeKey,
    String metricId,
    SensorThreshold? threshold,
  ) async {
    final id = '${nodeKey.toLowerCase()}|$metricId';
    if (threshold == null || threshold.isEmpty) {
      _thresholds.remove(id);
    } else {
      _thresholds[id] = threshold;
    }
    _lastAlert.remove(id);
    notifyListeners();
    await prefs.setString(
      _thresholdKey,
      jsonEncode(_thresholds.map((k, v) => MapEntry(k, v.toJson()))),
    );
  }

  void _loadThresholds() {
    try {
      final raw = prefs.getString(_thresholdKey);
      final data = raw == null ? null : jsonDecode(raw);
      if (data is! Map) return;
      for (final MapEntry(:key, :value) in data.entries) {
        if (key is! String) continue;
        final t = SensorThreshold.fromJson(value);
        if (t != null) _thresholds[key] = t;
      }
    } catch (e) {
      appLogger.error('Cannot load sensor thresholds: $e');
    }
  }

  /// Switches to the history of the radio with public key [key].
  void setScope(String key) {
    key = key.toLowerCase();
    if (!_keyValid(key)) key = '';
    if (_scope == key) return;
    unawaited(flush());
    _nodes.clear();
    _scope = key;
    if (key.isNotEmpty) _load();
    notifyListeners();
  }

  void _load() {
    try {
      final raw = prefs.getString(_historyKey(_scope));
      final data = raw == null ? null : jsonDecode(raw);
      if (data is! Map) return;
      for (final MapEntry(:key, :value) in data.entries) {
        if (key is! String || !_keyValid(key) || value is! Map) continue;
        final metrics = <String, List<SensorSample>>{};
        for (final m in value.entries) {
          if (m.key is! String || m.value is! List) continue;
          final list = [
            for (final s in m.value as List) ?SensorSample.fromJson(s),
          ];
          if (list.isNotEmpty) metrics[m.key as String] = list;
        }
        if (metrics.isNotEmpty) _nodes[key] = metrics;
      }
      _trim();
    } catch (e) {
      appLogger.error('Cannot load sensor history: $e');
    }
  }

  /// Takes the readings [NodeTelemetryStore] just accepted for [nodeKey].
  void recordReadings(String nodeKey, Iterable<NodeReading> readings) {
    nodeKey = nodeKey.toLowerCase();
    if (_disposed || _scope.isEmpty || !_keyValid(nodeKey)) return;
    var changed = false;
    for (final r in readings) {
      if (!chartable.contains(r.type)) continue;
      final v = r.value;
      if (v is! num || !v.isFinite) continue;
      changed = _add(nodeKey, r.id, r.type, r.at, v.toDouble()) || changed;
    }
    if (!changed) return;
    _trim();
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(seconds: 1), () => unawaited(flush()));
    notifyListeners();
  }

  bool _add(String nodeKey, String id, int type, DateTime at, double value) {
    if (at.isAfter(now.add(const Duration(minutes: 1)))) return false;
    final list = _nodes
        .putIfAbsent(nodeKey, () => {})
        .putIfAbsent(id, () => []);
    final previous = list.isEmpty ? null : list.last;
    final sample = SensorSample(at, value);
    if (previous != null && at.difference(previous.at).abs() < mergeWithin) {
      if (previous.value == value) return false;
      list[list.length - 1] = sample;
    } else {
      list.add(sample);
      list.sort((a, b) => a.at.compareTo(b.at));
    }
    _checkAlert(nodeKey, id, type, value, previous?.value);
    return true;
  }

  void _checkAlert(
    String nodeKey,
    String id,
    int type,
    double value,
    double? previous,
  ) {
    final key = '$nodeKey|$id';
    final threshold = _thresholds[key];
    if (threshold == null) return;
    final side = threshold.breaches(value);
    if (side == null) return;
    // Only when it crosses the line, not on every reading past it.
    if (previous != null && threshold.breaches(previous) == side) return;
    final last = _lastAlert[key];
    if (last != null && now.difference(last) < alertCooldown) return;
    _lastAlert[key] = now;
    onAlert?.call((
      nodeKey: nodeKey,
      metricId: id,
      type: type,
      value: value,
      limit: side ? threshold.above! : threshold.below!,
      above: side,
    ));
  }

  /// Forgets the history of [nodeKey] (its thresholds stay).
  void clear(String nodeKey) {
    if (_nodes.remove(nodeKey.toLowerCase()) == null) return;
    unawaited(flush());
    notifyListeners();
  }

  void _trim() {
    final cutoff = now.subtract(keep);
    for (final metrics in _nodes.values) {
      for (final list in metrics.values) {
        list.removeWhere((s) => s.at.isBefore(cutoff));
        if (list.length > maxSamplesPerValue) {
          list.removeRange(0, list.length - maxSamplesPerValue);
        }
      }
      metrics.removeWhere((_, list) => list.isEmpty);
    }
    _nodes.removeWhere((_, m) => m.isEmpty);
    if (_nodes.length <= maxNodes) return;
    DateTime newest(Map<String, List<SensorSample>> m) =>
        m.values.map((l) => l.last.at).reduce((a, b) => a.isAfter(b) ? a : b);
    final keys = _nodes.keys.toList()
      ..sort((a, b) => newest(_nodes[b]!).compareTo(newest(_nodes[a]!)));
    for (final k in keys.skip(maxNodes)) {
      _nodes.remove(k);
    }
  }

  /// Writes the current radio's history to storage.
  Future<void> flush() {
    _saveTimer?.cancel();
    if (_scope.isEmpty) return _writes;
    final key = _historyKey(_scope);
    final data = jsonEncode(
      _nodes.map(
        (node, metrics) => MapEntry(
          node,
          metrics.map((id, l) => MapEntry(id, [for (final s in l) s.toJson()])),
        ),
      ),
    );
    _writes = _writes
        .then((_) async {
          if (!await prefs.setString(key, data)) {
            throw StateError('write failed');
          }
        })
        .catchError((Object e) {
          appLogger.error('Cannot save sensor history: $e');
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
