import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../connector/meshcore_connector.dart';
import '../models/bot_replies.dart';
import '../storage/prefs_manager.dart';

/// A National Weather Service alert worth posting to the mesh.
class NwsAlert {
  /// Stable key: the same event ending at the same time is one alert, even
  /// when NWS reissues it as an update with a new ID.
  final String key;
  final String event;
  final String severity;
  final String area;
  final DateTime? ends;

  const NwsAlert({
    required this.key,
    required this.event,
    required this.severity,
    required this.area,
    this.ends,
  });
}

/// Severe and extreme alerts (and moderate ones when [includeModerate])
/// from an NWS `alerts/active` GeoJSON response. Tests, exercises and
/// cancellations are left out.
List<NwsAlert> parseNwsAlerts(
  Map<String, dynamic> json, {
  bool includeModerate = false,
}) {
  final wanted = {'Extreme', 'Severe', if (includeModerate) 'Moderate'};
  final alerts = <NwsAlert>[];
  for (final feature in json['features'] as List? ?? const []) {
    if (feature is! Map) continue;
    final p = feature['properties'];
    if (p is! Map) continue;
    if (p['status'] != 'Actual' || p['messageType'] == 'Cancel') continue;
    final severity = p['severity'];
    final event = p['event'];
    if (severity is! String || !wanted.contains(severity)) continue;
    if (event is! String || event.isEmpty) continue;
    final endsRaw = (p['ends'] ?? p['expires']) as String?;
    final ends = endsRaw == null ? null : DateTime.tryParse(endsRaw);
    alerts.add(
      NwsAlert(
        key: '$event|${endsRaw ?? p['id']}',
        event: event,
        severity: severity,
        area: (p['areaDesc'] as String? ?? '').trim(),
        ends: ends,
      ),
    );
  }
  return alerts;
}

/// Prefix on every alert this app posts, so readers know it's automatic.
const alertPrefix = '[NOTORYX Alert] ';

/// The channel text for [alert], cut to [maxBytes] of UTF-8 at a character
/// boundary so it fits one mesh message.
String formatNwsAlert(NwsAlert alert, {int maxBytes = 140}) {
  final ends = alert.ends?.toLocal();
  final until = ends == null
      ? ''
      : ' until ${ends.hour.toString().padLeft(2, '0')}:'
            '${ends.minute.toString().padLeft(2, '0')}';
  final text =
      '$alertPrefix${alert.event}$until'
      '${alert.area.isEmpty ? '' : ': ${alert.area}'}';
  if (utf8.encode(text).length <= maxBytes) return text;
  final runes = text.runes.toList();
  while (runes.isNotEmpty &&
      utf8.encode('${String.fromCharCodes(runes)}…').length > maxBytes) {
    runes.removeLast();
  }
  return '${String.fromCharCodes(runes).trimRight()}…';
}

/// Where and how weather alerts get posted.
class WeatherAlertSettings {
  final bool enabled;
  final int? channelIndex;
  final bool includeModerate;

  const WeatherAlertSettings({
    this.enabled = false,
    this.channelIndex,
    this.includeModerate = false,
  });

  WeatherAlertSettings copyWith({
    bool? enabled,
    int? channelIndex,
    bool? includeModerate,
  }) => WeatherAlertSettings(
    enabled: enabled ?? this.enabled,
    channelIndex: channelIndex ?? this.channelIndex,
    includeModerate: includeModerate ?? this.includeModerate,
  );

  Map<String, dynamic> toJson() => {
    'enabled': enabled,
    'channelIndex': channelIndex,
    'includeModerate': includeModerate,
  };

  factory WeatherAlertSettings.fromJson(Map<String, dynamic> json) =>
      WeatherAlertSettings(
        enabled: json['enabled'] as bool? ?? false,
        channelIndex: json['channelIndex'] as int?,
        includeModerate: json['includeModerate'] as bool? ?? false,
      );
}

/// Current weather for the bot's `!weather` command (Open-Meteo) and
/// National Weather Service alerts posted to a chosen channel. Both use the
/// radio's GPS position, rounded to about 1 km before it leaves the phone,
/// and both need the phone to have internet.
class WeatherService extends ChangeNotifier {
  WeatherService(
    this.connector, {
    http.Client? client,
    DateTime Function()? clock,
  }) : _client = client ?? http.Client(),
       _now = clock ?? DateTime.now;

  final MeshCoreConnector connector;
  final http.Client _client;
  final DateTime Function() _now;

  static const _prefsKey = 'notoryx_weather_alerts_v1';
  static const _postedKey = 'notoryx_weather_alerts_posted_v1';
  static const pollEvery = Duration(minutes: 10);
  static const weatherMaxAge = Duration(minutes: 30);

  WeatherNow? _current;
  WeatherAlertSettings _settings = const WeatherAlertSettings();
  final Map<String, DateTime> _posted = {};
  Timer? _timer;
  Future<void>? _checking;
  DateTime? _lastCheck;
  String? _lastError;
  bool _disposed = false;

  WeatherNow? get current => _current;
  WeatherAlertSettings get settings => _settings;
  DateTime? get lastCheck => _lastCheck;
  String? get lastError => _lastError;

  /// The radio's position rounded to two decimals (about 1 km), or null
  /// when it hasn't reported one.
  ({double lat, double lon})? get position {
    final lat = connector.selfLatitude, lon = connector.selfLongitude;
    if (lat == null || lon == null || (lat == 0 && lon == 0)) return null;
    double r(double v) => (v * 100).roundToDouble() / 100;
    return (lat: r(lat), lon: r(lon));
  }

  Future<void> load() async {
    final prefs = PrefsManager.instance;
    try {
      final saved = prefs.getString(_prefsKey);
      if (saved != null) {
        _settings = WeatherAlertSettings.fromJson(
          jsonDecode(saved) as Map<String, dynamic>,
        );
      }
      final posted = prefs.getString(_postedKey);
      if (posted != null) {
        (jsonDecode(posted) as Map<String, dynamic>).forEach((k, v) {
          final until = DateTime.tryParse(v as String);
          if (until != null) _posted[k] = until;
        });
      }
    } catch (_) {
      _settings = const WeatherAlertSettings();
    }
    _schedule();
    _notify();
  }

  Future<void> saveSettings(WeatherAlertSettings settings) async {
    _settings = settings;
    _schedule();
    _notify();
    await PrefsManager.instance.setString(
      _prefsKey,
      jsonEncode(settings.toJson()),
    );
    if (settings.enabled) unawaited(checkAlerts());
  }

  void _schedule() {
    _timer?.cancel();
    _timer = _settings.enabled
        ? Timer.periodic(pollEvery, (_) => unawaited(checkAlerts()))
        : null;
  }

  /// Current conditions, fetched when the cached ones are older than
  /// [weatherMaxAge]. Null without a radio position or internet.
  Future<WeatherNow?> weather() async {
    final cached = _current;
    if (cached != null && _now().difference(cached.fetchedAt) < weatherMaxAge) {
      return cached;
    }
    final pos = position;
    if (pos == null) return cached;
    try {
      final uri = Uri.https('api.open-meteo.com', '/v1/forecast', {
        'latitude': '${pos.lat}',
        'longitude': '${pos.lon}',
        'current':
            'temperature_2m,weather_code,wind_speed_10m,relative_humidity_2m',
      });
      final res = await _client.get(uri).timeout(const Duration(seconds: 8));
      if (res.statusCode != 200) return cached;
      final now = WeatherNow.fromOpenMeteo(
        jsonDecode(res.body) as Map<String, dynamic>,
        _now(),
      );
      if (now != null) {
        _current = now;
        _notify();
      }
      return _current;
    } catch (_) {
      return cached;
    }
  }

  /// Fetches active NWS alerts for the radio's position and posts new ones
  /// to the chosen channel, at most three per check. A check already in
  /// flight is shared, so the same alert can't be posted twice.
  Future<void> checkAlerts() {
    return _checking ??= _check().whenComplete(() => _checking = null);
  }

  Future<void> _check() async {
    if (!_settings.enabled || _disposed) return;
    final pos = position;
    final channelIndex = _settings.channelIndex;
    if (pos == null) {
      _setStatus('The radio hasn’t reported a GPS position yet.');
      return;
    }
    if (channelIndex == null) {
      _setStatus('Choose a channel to post alerts to.');
      return;
    }
    final channel = connector.channels
        .where((c) => c.index == channelIndex && !c.isEmpty)
        .firstOrNull;
    if (channel == null) {
      _setStatus('The chosen channel no longer exists.');
      return;
    }
    List<NwsAlert> alerts;
    try {
      final uri = Uri.https('api.weather.gov', '/alerts/active', {
        'point': '${pos.lat},${pos.lon}',
      });
      final res = await _client
          .get(
            uri,
            headers: {
              'User-Agent':
                  'NOTORYX Core (github.com/TheLogsAreScreaming/notoryx-core)',
              'Accept': 'application/geo+json',
            },
          )
          .timeout(const Duration(seconds: 15));
      if (res.statusCode != 200) {
        _setStatus('Weather Service answered ${res.statusCode}.');
        return;
      }
      alerts = parseNwsAlerts(
        jsonDecode(res.body) as Map<String, dynamic>,
        includeModerate: _settings.includeModerate,
      );
    } catch (_) {
      _setStatus('Couldn’t reach the Weather Service.');
      return;
    }
    final now = _now();
    _posted.removeWhere((_, until) => until.isBefore(now));
    var sent = 0;
    for (final alert in alerts) {
      if (sent >= 3 || _posted.containsKey(alert.key)) continue;
      if (!connector.isConnected) break;
      await connector.sendChannelMessage(channel, formatNwsAlert(alert));
      _posted[alert.key] = alert.ends ?? now.add(const Duration(days: 1));
      sent++;
    }
    await PrefsManager.instance.setString(
      _postedKey,
      jsonEncode(_posted.map((k, v) => MapEntry(k, v.toIso8601String()))),
    );
    _lastCheck = now;
    _setStatus(null);
  }

  void _setStatus(String? error) {
    _lastError = error;
    _lastCheck ??= _now();
    _notify();
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _timer?.cancel();
    _client.close();
    super.dispose();
  }
}
