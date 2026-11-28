import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_logger.dart';

/// What a repeater status reply carried, at the moment it arrived.
///
/// Any field can be missing: text replies come in parts, and older firmware
/// leaves some out.
@immutable
class StatusSample {
  const StatusSample({
    required this.at,
    this.batteryMv,
    this.rssi,
    this.snr,
    this.noiseFloor,
    this.errors,
    this.uptimeSecs,
  });

  final DateTime at;
  final int? batteryMv;
  final int? rssi;
  final double? snr;
  final int? noiseFloor;
  final int? errors;
  final int? uptimeSecs;

  bool get isEmpty =>
      batteryMv == null &&
      rssi == null &&
      snr == null &&
      noiseFloor == null &&
      errors == null &&
      uptimeSecs == null;

  /// This sample with [other]'s fields filled in where they're set.
  StatusSample mergedWith(StatusSample other) => StatusSample(
    at: other.at,
    batteryMv: other.batteryMv ?? batteryMv,
    rssi: other.rssi ?? rssi,
    snr: other.snr ?? snr,
    noiseFloor: other.noiseFloor ?? noiseFloor,
    errors: other.errors ?? errors,
    uptimeSecs: other.uptimeSecs ?? uptimeSecs,
  );

  double? valueOf(StatusMetric metric) => switch (metric) {
    StatusMetric.battery => batteryMv == null ? null : batteryMv! / 1000,
    StatusMetric.rssi => rssi?.toDouble(),
    StatusMetric.snr => snr,
    StatusMetric.noiseFloor => noiseFloor?.toDouble(),
    StatusMetric.errors => errors?.toDouble(),
    StatusMetric.uptime => uptimeSecs == null ? null : uptimeSecs! / 3600,
  };

  Map<String, Object> toJson() => {
    'at': at.millisecondsSinceEpoch,
    'mv': ?batteryMv,
    'rssi': ?rssi,
    'snr': ?snr,
    'nf': ?noiseFloor,
    'err': ?errors,
    'up': ?uptimeSecs,
  };

  static StatusSample? fromJson(Object? json) {
    if (json is! Map) return null;
    final at = json['at'];
    if (at is! int) return null;
    int? i(Object? v) => v is int ? v : null;
    final snr = json['snr'];
    final sample = StatusSample(
      at: DateTime.fromMillisecondsSinceEpoch(at),
      batteryMv: i(json['mv']),
      rssi: i(json['rssi']),
      snr: snr is num ? snr.toDouble() : null,
      noiseFloor: i(json['nf']),
      errors: i(json['err']),
      uptimeSecs: i(json['up']),
    );
    return sample.isEmpty ? null : sample;
  }
}

/// The values a status chart can show.
enum StatusMetric { battery, rssi, snr, noiseFloor, errors, uptime }

/// One SNR reading of a neighbour, as a repeater reported it.
@immutable
class SnrSample {
  const SnrSample(this.at, this.snr);

  final DateTime at;
  final double snr;

  Map<String, Object> toJson() => {'at': at.millisecondsSinceEpoch, 'snr': snr};

  static SnrSample? fromJson(Object? json) {
    if (json is! Map) return null;
    final at = json['at'], snr = json['snr'];
    if (at is! int || snr is! num) return null;
    return SnrSample(DateTime.fromMillisecondsSinceEpoch(at), snr.toDouble());
  }
}

/// Every status reply and neighbour list the user has asked a repeater for,
/// kept for a month per connected radio, so they can be graphed. Nothing is
/// sent over the air for this; it only keeps what already came back.
class RepeaterStatusHistory extends ChangeNotifier {
  RepeaterStatusHistory(this.prefs, {DateTime Function()? clock})
    : _now = clock ?? DateTime.now;

  final SharedPreferences prefs;
  final DateTime Function() _now;

  static const keep = Duration(days: 30);
  static const maxSamplesPerRepeater = 500;
  static const maxRepeaters = 128;
  static const maxNeighboursPerRepeater = 64;
  static const maxSnrPerNeighbour = 200;

  /// Status parts arriving this close together belong to one check.
  static const mergeWithin = Duration(minutes: 1);

  final Map<String, List<StatusSample>> _status = {};
  final Map<String, Map<String, List<SnrSample>>> _snr = {};
  String _scope = '';
  Timer? _saveTimer;
  Future<void> _writes = Future.value();
  bool _disposed = false;

  DateTime get now => _now();
  String get scope => _scope;

  static bool _keyValid(String key) => RegExp(r'^[0-9a-f]{64}$').hasMatch(key);
  static bool _prefixValid(String key) =>
      RegExp(r'^[0-9a-f]{2,64}$').hasMatch(key);
  static String _statusKey(String scope) => 'repeater_status_history_v1_$scope';
  static String _snrKey(String scope) => 'neighbour_snr_history_v1_$scope';

  /// The status checks kept for [repeaterKey], oldest first.
  List<StatusSample> statusFor(String repeaterKey) =>
      List.unmodifiable(_status[repeaterKey.toLowerCase()] ?? const []);

  /// SNR readings of [neighbourPrefix] as heard by [repeaterKey].
  List<SnrSample> snrFor(String repeaterKey, String neighbourPrefix) =>
      List.unmodifiable(
        _snr[repeaterKey.toLowerCase()]?[neighbourPrefix.toLowerCase()] ??
            const [],
      );

  /// Every neighbour [repeaterKey] has reported, by key prefix, with its
  /// SNR readings.
  Map<String, List<SnrSample>> neighboursOf(String repeaterKey) => {
    for (final e
        in (_snr[repeaterKey.toLowerCase()] ??
                const <String, List<SnrSample>>{})
            .entries)
      e.key: List.unmodifiable(e.value),
  };

  /// Switches to the history of the radio with public key [key].
  void setScope(String key) {
    key = key.toLowerCase();
    if (!_keyValid(key)) key = '';
    if (_scope == key) return;
    unawaited(flush());
    _status.clear();
    _snr.clear();
    _scope = key;
    if (key.isNotEmpty) _load();
    notifyListeners();
  }

  void _load() {
    try {
      final raw = prefs.getString(_statusKey(_scope));
      final data = raw == null ? null : jsonDecode(raw);
      if (data is Map) {
        for (final MapEntry(:key, :value) in data.entries) {
          if (key is! String || !_keyValid(key) || value is! List) continue;
          final list = [for (final s in value) ?StatusSample.fromJson(s)];
          if (list.isNotEmpty) _status[key] = list;
        }
      }
      final rawSnr = prefs.getString(_snrKey(_scope));
      final snr = rawSnr == null ? null : jsonDecode(rawSnr);
      if (snr is Map) {
        for (final MapEntry(:key, :value) in snr.entries) {
          if (key is! String || !_keyValid(key) || value is! Map) continue;
          final byNeighbour = <String, List<SnrSample>>{};
          for (final n in value.entries) {
            final prefix = n.key;
            if (prefix is! String || !_prefixValid(prefix)) continue;
            if (n.value is! List) continue;
            final list = [
              for (final s in n.value as List) ?SnrSample.fromJson(s),
            ];
            if (list.isNotEmpty) byNeighbour[prefix] = list;
          }
          if (byNeighbour.isNotEmpty) _snr[key] = byNeighbour;
        }
      }
      _trim();
    } catch (e) {
      appLogger.error('Cannot load repeater status history: $e');
    }
  }

  /// Keeps one status reply (or part of one) from [repeaterKey].
  void recordStatus(String repeaterKey, StatusSample sample) {
    repeaterKey = repeaterKey.toLowerCase();
    if (_disposed || _scope.isEmpty || !_keyValid(repeaterKey)) return;
    if (sample.isEmpty) return;
    if (sample.at.isAfter(now.add(const Duration(minutes: 1)))) return;
    final list = _status.putIfAbsent(repeaterKey, () => []);
    if (list.isNotEmpty &&
        sample.at.difference(list.last.at).abs() < mergeWithin) {
      list[list.length - 1] = list.last.mergedWith(sample);
    } else {
      list.add(sample);
      list.sort((a, b) => a.at.compareTo(b.at));
    }
    _changed();
  }

  /// Keeps the SNR of each neighbour in one neighbour list from
  /// [repeaterKey]. [neighbours] maps key prefix to (SNR, seconds since the
  /// repeater last heard it).
  void recordNeighbours(
    String repeaterKey,
    Map<String, ({double snr, int heardSecsAgo})> neighbours,
  ) {
    repeaterKey = repeaterKey.toLowerCase();
    if (_disposed || _scope.isEmpty || !_keyValid(repeaterKey)) return;
    if (neighbours.isEmpty) return;
    final byNeighbour = _snr.putIfAbsent(repeaterKey, () => {});
    final time = now;
    for (final MapEntry(:key, :value) in neighbours.entries) {
      final prefix = key.toLowerCase();
      if (!_prefixValid(prefix) || value.heardSecsAgo < 0) continue;
      final at = time.subtract(Duration(seconds: value.heardSecsAgo));
      final list = byNeighbour.putIfAbsent(prefix, () => []);
      // Asking twice reports the same last-heard packet; keep it once.
      if (list.isNotEmpty &&
          at.difference(list.last.at).abs() < mergeWithin &&
          list.last.snr == value.snr) {
        continue;
      }
      list.add(SnrSample(at, value.snr));
      list.sort((a, b) => a.at.compareTo(b.at));
    }
    _changed();
  }

  /// Forgets everything kept for [repeaterKey].
  void clear(String repeaterKey) {
    final key = repeaterKey.toLowerCase();
    final hadStatus = _status.remove(key) != null;
    final hadSnr = _snr.remove(key) != null;
    if (!hadStatus && !hadSnr) return;
    unawaited(flush());
    notifyListeners();
  }

  void _changed() {
    _trim();
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(seconds: 1), () => unawaited(flush()));
    notifyListeners();
  }

  void _trim() {
    final cutoff = now.subtract(keep);
    for (final list in _status.values) {
      list.removeWhere((s) => s.at.isBefore(cutoff));
      if (list.length > maxSamplesPerRepeater) {
        list.removeRange(0, list.length - maxSamplesPerRepeater);
      }
    }
    _status.removeWhere((_, list) => list.isEmpty);
    for (final byNeighbour in _snr.values) {
      for (final list in byNeighbour.values) {
        list.removeWhere((s) => s.at.isBefore(cutoff));
        if (list.length > maxSnrPerNeighbour) {
          list.removeRange(0, list.length - maxSnrPerNeighbour);
        }
      }
      byNeighbour.removeWhere((_, list) => list.isEmpty);
      _keepNewest(byNeighbour, maxNeighboursPerRepeater, (l) => l.last.at);
    }
    _snr.removeWhere((_, m) => m.isEmpty);
    _keepNewest(_status, maxRepeaters, (l) => l.last.at);
    _keepNewest(
      _snr,
      maxRepeaters,
      (m) =>
          m.values.map((l) => l.last.at).reduce((a, b) => a.isAfter(b) ? a : b),
    );
  }

  static void _keepNewest<T>(
    Map<String, T> map,
    int max,
    DateTime Function(T) newest,
  ) {
    if (map.length <= max) return;
    final keys = map.keys.toList()
      ..sort((a, b) => newest(map[b] as T).compareTo(newest(map[a] as T)));
    for (final key in keys.skip(max)) {
      map.remove(key);
    }
  }

  /// Writes the current radio's history to storage.
  Future<void> flush() {
    _saveTimer?.cancel();
    if (_scope.isEmpty) return _writes;
    final statusKey = _statusKey(_scope);
    final snrKey = _snrKey(_scope);
    final status = jsonEncode(
      _status.map((k, list) => MapEntry(k, [for (final s in list) s.toJson()])),
    );
    final snr = jsonEncode(
      _snr.map(
        (k, m) => MapEntry(
          k,
          m.map((n, list) => MapEntry(n, [for (final s in list) s.toJson()])),
        ),
      ),
    );
    _writes = _writes
        .then((_) async {
          if (!await prefs.setString(statusKey, status) ||
              !await prefs.setString(snrKey, snr)) {
            throw StateError('write failed');
          }
        })
        .catchError((Object e) {
          appLogger.error('Cannot save repeater status history: $e');
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
