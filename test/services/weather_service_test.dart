import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/services/weather_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Radio extends MeshCoreConnector {
  double? lat = 47.6062;
  double? lon = -122.3321;
  final sent = <String>[];
  final List<Channel> list = [
    Channel(index: 2, name: '#wx', psk: Channel.derivePskFromHashtag('#wx')),
  ];

  @override
  double? get selfLatitude => lat;
  @override
  double? get selfLongitude => lon;
  @override
  bool get isConnected => true;
  @override
  List<Channel> get channels => list;
  @override
  Future<void> sendChannelMessage(
    Channel channel,
    String text, {
    String? originalText,
    String? translatedLanguageCode,
    String? translationModelId,
  }) async => sent.add(text);
}

Map<String, dynamic> _alert(
  String event,
  String severity, {
  String status = 'Actual',
  String type = 'Alert',
  String ends = '2026-10-29T06:00:00-07:00',
}) => {
  'properties': {
    'id': 'urn:$event',
    'event': event,
    'severity': severity,
    'status': status,
    'messageType': type,
    'ends': ends,
    'areaDesc': 'Seattle; Bellevue',
  },
};

void main() {
  final feed = {
    'features': [
      _alert('Winter Storm Warning', 'Severe'),
      _alert('Wind Advisory', 'Moderate'),
      _alert('Test Message', 'Extreme', status: 'Test'),
      _alert('Flood Warning', 'Severe', type: 'Cancel'),
    ],
  };

  test('only real severe alerts are kept unless moderate is asked for', () {
    expect(parseNwsAlerts(feed).map((a) => a.event), ['Winter Storm Warning']);
    expect(parseNwsAlerts(feed, includeModerate: true), hasLength(2));
  });

  test('alert text fits one mesh message', () {
    final long = NwsAlert(
      key: 'k',
      event: 'Winter Storm Warning',
      severity: 'Severe',
      area: List.filled(30, 'Long County Name').join('; '),
    );
    final text = formatNwsAlert(long);
    expect(utf8.encode(text).length, lessThanOrEqualTo(140));
    expect(text, startsWith(alertPrefix));
    expect(text, endsWith('…'));
  });

  group('posting', () {
    late _Radio radio;
    late List<Uri> requests;
    late WeatherService service;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      PrefsManager.reset();
      await PrefsManager.initialize();
      radio = _Radio();
      requests = [];
      service = WeatherService(
        radio,
        client: MockClient((req) async {
          requests.add(req.url);
          return http.Response(jsonEncode(feed), 200);
        }),
      );
      await service.load();
    });

    tearDown(() => service.dispose());

    test('posts each new alert once to the chosen channel', () async {
      await service.saveSettings(
        const WeatherAlertSettings(enabled: true, channelIndex: 2),
      );
      await service.checkAlerts();
      await service.checkAlerts();
      expect(radio.sent, hasLength(1));
      expect(radio.sent.single, contains('Winter Storm Warning'));
      // The position is rounded to about 1 km before it's sent.
      expect(requests.first.queryParameters['point'], '47.61,-122.33');
    });

    test('says why nothing was posted without a position', () async {
      radio.lat = null;
      await service.saveSettings(
        const WeatherAlertSettings(enabled: true, channelIndex: 2),
      );
      await service.checkAlerts();
      expect(radio.sent, isEmpty);
      expect(service.problem, WeatherAlertProblem.noPosition);
    });
  });
}
