import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/regional_preset.dart';
import 'package:meshcore_open/services/regional_preset_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:meshcore_open/widgets/regional_preset_banner.dart';

String _doc({String updated = '2026-10-17', double freq = 919.5}) =>
    jsonEncode({
      'version': 1,
      'regions': [
        {
          'id': 'us-philadelphia',
          'name': 'Philadelphia',
          'center': [39.9526, -75.1652],
          'radiusKm': 100,
          'frequencyMHz': freq,
          'bandwidthKHz': 500,
          'spreadingFactor': 10,
          'codingRate': 5,
          'pathHashBytes': 2,
          'updated': updated,
        },
        {
          'id': 'broken',
          'name': 'Bad',
          'center': [0, 0],
        },
      ],
    });

/// A radio in Philadelphia still on the old US defaults.
class _Radio extends MeshCoreConnector {
  final sent = <Uint8List>[];
  double lat = 39.98, lon = -75.20;
  @override
  bool get isConnected => true;
  @override
  double? get selfLatitude => lat;
  @override
  double? get selfLongitude => lon;
  @override
  int? get currentFreqHz => 911000;
  @override
  int? get currentBwHz => 62500;
  @override
  int? get currentSf => 7;
  @override
  int? get currentCr => 5;
  @override
  Future<void> sendFrame(
    Uint8List frame, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async => sent.add(frame);
  @override
  Future<void> refreshDeviceInfo() async {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('the bundled list is a valid ham document with no areas yet', () {
    final source = File('assets/regional_presets.json').readAsStringSync();
    expect(jsonDecode(source)['version'], 1);
    expect(parseRegionalPresets(source), isEmpty);
  });

  test('areas outside the ham bands are skipped', () {
    expect(parseRegionalPresets(_doc(freq: 869.525)), isEmpty);
    expect(parseRegionalPresets(_doc(freq: 915.0)), hasLength(1));
  });

  test('invalid entries and documents are skipped', () {
    expect(parseRegionalPresets(_doc()), hasLength(1));
    expect(parseRegionalPresets('nope'), isEmpty);
    expect(
      parseRegionalPresets(jsonEncode({'version': 3, 'regions': []})),
      isEmpty,
    );
  });

  test('the bundled ham list parses and has no areas yet', () {
    // Ham ships only coordinated amateur areas; MeshCore map areas (Part 15)
    // don't belong in it.
    final source = File('assets/regional_presets.json').readAsStringSync();
    expect(parseRegionalPresets(source), isEmpty);
  });

  test('version 2: missing path hash is unknown, version 1: it is 1', () {
    Map<String, dynamic> area() => {
      'id': 'map-x',
      'name': 'Phoenix, Arizona',
      'center': [33.45, -112.07],
      'radiusKm': 150,
      'frequencyMHz': 908.205,
      'bandwidthKHz': 62.5,
      'spreadingFactor': 9,
      'codingRate': 8,
      'updated': '2026-11-06',
      'source': 'map',
      'nodes': 219,
    };
    final v2 = parseRegionalPresets(
      jsonEncode({
        'version': 2,
        'regions': [area()],
      }),
    ).single;
    expect(v2.pathHashBytes, isNull);
    expect(v2.fromMap, isTrue);
    expect(v2.nodeCount, 219);
    expect(v2.summary, '908.205 MHz · BW62.5 · SF9 · CR8');
    expect(
      v2.differences(
        const RadioSettingsState(
          frequencyMHz: 908.205,
          bandwidthKHz: 62.5,
          spreadingFactor: 9,
          codingRate: 8,
          pathHashBytes: 2,
        ),
      ),
      isEmpty,
    );
    final v1 = parseRegionalPresets(
      jsonEncode({
        'version': 1,
        'regions': [area()],
      }),
    ).single;
    expect(v1.pathHashBytes, 1);
  });

  test('area by position, and what would change', () {
    final presets = parseRegionalPresets(_doc());
    expect(
      presetForPosition(presets, const LatLng(40.0, -75.3))?.name,
      'Philadelphia',
    );
    expect(presetForPosition(presets, const LatLng(34.05, -118.24)), isNull);
    final diffs = presets.first.differences(
      const RadioSettingsState(
        frequencyMHz: 911,
        bandwidthKHz: 62.5,
        spreadingFactor: 7,
        codingRate: 5,
        pathHashBytes: 1,
      ),
    );
    expect(diffs, [
      'Frequency 911.000 → 919.500 MHz',
      'Bandwidth 62.5 → 500 kHz',
      'Spreading factor 7 → 10',
      'Path hash 1-byte → 2-byte',
    ]);
  });

  group('service', () {
    late _Radio radio;
    late List<String> alerts;
    late String remote;

    LatLng? phone;

    RegionalPresetService make() => RegionalPresetService(
      radio,
      httpClient: MockClient((_) async => http.Response(remote, 200)),
      loadBundled: () async => _doc(),
      phonePosition: () async => phone,
      notify: (m) async {
        alerts.add(m);
        return true;
      },
    );

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      PrefsManager.reset();
      await PrefsManager.initialize();
      radio = _Radio();
      alerts = [];
      remote = _doc();
      phone = null;
    });
    tearDown(() => radio.dispose());

    test('offers the local settings until dismissed', () async {
      final s = make();
      await s.start();
      await s.refresh();
      expect(s.active?.name, 'Philadelphia');
      expect(s.shouldOffer, isTrue);
      await s.dismiss();
      expect(s.shouldOffer, isFalse);
      s.dispose();
    });

    test('applying sends radio params in kHz/Hz and the path mode', () async {
      final s = make();
      await s.start();
      await s.apply(s.active!);
      final params = radio.sent.firstWhere((f) => f[0] == cmdSetRadioParams);
      expect(params, buildSetRadioParamsFrame(919500, 500000, 10, 5));
      expect(radio.sent.last, buildSetPathHashModeFrame(1));
      expect(radio.pathHashByteWidth, 2);
      s.dispose();
    });

    test('an area changing its settings raises one alert', () async {
      final s = make();
      await s.start();
      await s.refresh(); // first sight: no alert
      expect(alerts, isEmpty);
      remote = _doc(updated: '2026-11-01', freq: 919.7);
      await s.refresh();
      expect(alerts.single, startsWith('Philadelphia mesh settings changed'));
      await s.refresh();
      expect(alerts, hasLength(1));
      s.dispose();
    });

    test('outside every area there is nothing to offer', () async {
      radio.lat = 34.05;
      radio.lon = -118.24;
      final s = make();
      await s.start();
      expect(s.active, isNull);
      expect(s.shouldOffer, isFalse);
      await s.select('us-philadelphia');
      expect(s.active?.name, 'Philadelphia');
      s.dispose();
    });

    test(
      'without a radio position, the phone position picks the area',
      () async {
        radio.lat = 0;
        radio.lon = 0;
        final s = make();
        await s.start();
        expect(s.active, isNull);
        s.dispose();
        phone = const LatLng(40.0, -75.3);
        final s2 = make();
        await s2.start();
        expect(s2.active?.name, 'Philadelphia');
        s2.dispose();
      },
    );

    test('the radio position wins over the phone', () async {
      phone = const LatLng(34.05, -118.24);
      final s = make();
      await s.start();
      expect(s.active?.name, 'Philadelphia');
      s.dispose();
    });

    test('a map area without path hash sends no path hash command', () async {
      remote = jsonEncode({
        'version': 2,
        'regions': [
          {
            'id': 'map-phl',
            'name': 'Philadelphia area',
            'center': [39.95, -75.17],
            'radiusKm': 100,
            'frequencyMHz': 919.5,
            'bandwidthKHz': 500,
            'spreadingFactor': 10,
            'codingRate': 5,
            'updated': '2026-11-06',
            'source': 'map',
          },
        ],
      });
      final s = make();
      await s.start();
      await s.refresh();
      expect(s.active?.id, 'map-phl');
      await s.apply(s.active!);
      expect(radio.sent.where((f) => f[0] == cmdSetRadioParams), hasLength(1));
      expect(
        radio.sent.any((f) => f[0] == buildSetPathHashModeFrame(0)[0]),
        isFalse,
      );
      s.dispose();
    });

    testWidgets('banner → review → apply', (tester) async {
      final s = make();
      await tester.runAsync(s.start);
      await tester.pumpWidget(
        ChangeNotifierProvider<RegionalPresetService?>.value(
          value: s,
          child: const MaterialApp(
            home: Scaffold(body: RegionalPresetBanner()),
          ),
        ),
      );
      expect(find.text('Philadelphia mesh settings'), findsOneWidget);
      await tester.tap(find.text('Review'));
      await tester.pumpAndSettle();
      expect(find.text('• Frequency 911.000 → 919.500 MHz'), findsOneWidget);
      await tester.tap(find.text('Apply to radio'));
      await tester.pumpAndSettle();
      expect(radio.sent.any((f) => f[0] == cmdSetRadioParams), isTrue);
      s.dispose();
    });
  });
}
