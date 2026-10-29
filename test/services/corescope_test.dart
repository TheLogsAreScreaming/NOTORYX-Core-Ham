import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/helpers/direct_heard_name.dart';
import 'package:meshcore_open/services/corescope.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('parseTraces', () {
    test('keeps each observer once, best SNR first', () {
      final hits = parseTraces({
        'traces': [
          {
            'observer': 'AABBCCDDEEFF',
            'observer_name': 'Hilltop',
            'snr': -4.5,
            'rssi': -110,
            'path_json': '["5A","94"]',
            'time': '2026-10-28T18:00:00Z',
          },
          {'observer': 'AABBCCDDEEFF', 'observer_name': 'Hilltop', 'snr': 2.0},
          {'observer': '112233', 'snr': 7.25, 'path_json': '[]'},
          'junk',
        ],
      });
      expect(hits.map((h) => h.name), ['112233', 'Hilltop']);
      expect(hits.last.snr, 2.0);
      expect(hits.first.hops, 0);
    });

    test('counts hops and survives a broken path', () {
      final hits = parseTraces({
        'traces': [
          {'observer': 'A', 'observer_name': ' ', 'path_json': '["5A","94"]'},
          {'observer': 'B', 'path_json': 'not json'},
        ],
      });
      expect({for (final h in hits) h.name: h.hops}, {'A': 2, 'B': 0});
    });

    test('no traces is empty', () {
      expect(parseTraces({}), isEmpty);
    });
  });

  test('parseResolvedHops upper-cases IDs and keeps ambiguity', () {
    final hops = parseResolvedHops({
      'resolved': {
        '5a': {'name': 'Ridge ', 'ambiguous': true},
        '94': {'name': 'Tower'},
        'FF': {'name': ''},
        'EE': null,
      },
    });
    expect(hops.keys, ['5A', '94']);
    expect(hops['5A']!.name, 'Ridge');
    expect(hops['5A']!.ambiguous, isTrue);
    expect(hops['94']!.ambiguous, isFalse);
  });

  test('isValidUrl wants https and a host', () {
    expect(AnalyzerService.isValidUrl('https://analyzer.on8ar.eu'), isTrue);
    expect(AnalyzerService.isValidUrl('http://analyzer.on8ar.eu'), isFalse);
    expect(AnalyzerService.isValidUrl('analyzer'), isFalse);
  });

  group('AnalyzerService', () {
    final requests = <Uri>[];

    setUp(() async {
      requests.clear();
      SharedPreferences.setMockInitialValues({});
      PrefsManager.reset();
      await PrefsManager.initialize();
    });
    tearDown(PrefsManager.reset);

    AnalyzerService service(Future<http.Response> Function(Uri) respond) =>
        AnalyzerService(
          client: () => MockClient((req) {
            requests.add(req.url);
            return respond(req.url);
          }),
        )..load();

    test('observersOf: hits, none, and unreachable', () async {
      final ok = service(
        (_) async => http.Response(
          jsonEncode({
            'traces': [
              {'observer': 'A', 'observer_name': 'Hilltop', 'snr': 3},
            ],
          }),
          200,
        ),
      );
      final hits = await ok.observersOf('ABCDEF0123456789');
      expect(hits!.single.name, 'Hilltop');
      expect(
        requests.single.toString(),
        'https://analyzer.on8ar.eu/api/traces/abcdef0123456789',
      );

      final none = service((_) async => http.Response('not found', 404));
      expect(await none.observersOf('00'), isEmpty);

      final down = service((_) async => http.Response('oops', 500));
      expect(await down.observersOf('00'), isNull);

      final broken = service((_) async => throw Exception('offline'));
      expect(await broken.observersOf('00'), isNull);
    });

    test('a custom server is used and remembered', () async {
      final s = service((_) async => http.Response('{}', 200));
      await s.setUrl('https://scope.example.org//');
      expect(s.url, 'https://scope.example.org');
      await s.observersOf('aa');
      expect(requests.single.host, 'scope.example.org');
      expect((AnalyzerService()..load()).url, 'https://scope.example.org');
    });

    test('hopName stays offline until turned on', () async {
      final s = service((_) async => http.Response('{}', 200));
      expect(s.hopName('5A'), isNull);
      await Future<void>.delayed(const Duration(milliseconds: 500));
      expect(requests, isEmpty);
    });

    test('hopName batches lookups and caches the answers', () async {
      final s = service(
        (_) async => http.Response(
          jsonEncode({
            'resolved': {
              '5A': {'name': 'Ridge', 'ambiguous': true},
              '94': {'name': 'Tower'},
            },
          }),
          200,
        ),
      );
      await s.setHopLookup(true);
      var notified = 0;
      s.addListener(() => notified++);

      expect(s.hopName('5a'), isNull);
      expect(s.hopName('94'), isNull);
      expect(s.hopName('77'), isNull);
      await Future<void>.delayed(const Duration(milliseconds: 500));

      expect(requests, hasLength(1));
      expect(requests.single.queryParameters['hops'], '5A,94,77');
      expect(notified, 1);
      expect(s.hopName('5A')!.name, 'Ridge');
      expect(s.hopName('94')!.ambiguous, isFalse);
      // Unknown online too: remembered, not asked again.
      expect(s.hopName('77'), isNull);
      await Future<void>.delayed(const Duration(milliseconds: 500));
      expect(requests, hasLength(1));
      s.dispose();
    });

    test('heardNameWithOnline marks shared IDs with "?"', () async {
      final s = service(
        (_) async => http.Response(
          jsonEncode({
            'resolved': {
              '5A': {'name': 'Ridge', 'ambiguous': true},
            },
          }),
          200,
        ),
      );
      await s.setHopLookup(true);
      final radio = MeshCoreConnector();
      expect(heardNameWithOnline(radio, s, '5A'), isNull);
      await Future<void>.delayed(const Duration(milliseconds: 500));
      expect(heardNameWithOnline(radio, s, '5A'), 'Ridge?');
      expect(heardNameWithOnline(radio, null, '5A'), isNull);
      s.dispose();
    });
  });
}
