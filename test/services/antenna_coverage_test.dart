import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/models/coverage_sweep.dart';
import 'package:meshcore_open/screens/antenna_coverage_screen.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/services/line_of_sight_service.dart';
import 'package:meshcore_open/services/map_tile_cache_service.dart';

const _origin = LatLng(49.0, -122.0);

/// Flat ground at 100 m with a 300 m ridge 5–6 km due north of the origin.
Future<List<double?>> _terrain(List<LatLng> points, List<int> calls) async {
  calls.add(points.length);
  const d = Distance();
  return [
    for (final p in points)
      () {
        final km = d.as(LengthUnit.Meter, _origin, p) / 1000;
        final north =
            p.latitude > _origin.latitude + 0.001 &&
            (p.longitude - _origin.longitude).abs() < 0.001;
        return north && km >= 5 && km <= 6 ? 300.0 : 100.0;
      }(),
  ];
}

class _Radio extends MeshCoreConnector {
  @override
  double? get selfLatitude => _origin.latitude;
  @override
  double? get selfLongitude => _origin.longitude;
}

void main() {
  test('flat ground is visible out to the horizon', () {
    final distances = [for (var i = 1; i <= 10; i++) i * 1000.0];
    final v = visibleAlongRay(
      originGroundMeters: 100,
      antennaHeightMeters: 10,
      distances: distances,
      terrain: List.filled(10, 100),
    );
    expect(v, everyElement(isTrue));
  });

  test('a ridge hides what is behind it but not the ridge', () {
    final distances = [for (var i = 1; i <= 10; i++) i * 1000.0];
    final terrain = <double?>[100, 100, 300, 100, 100, 100, 100, 100, 100, 100];
    final v = visibleAlongRay(
      originGroundMeters: 100,
      antennaHeightMeters: 10,
      distances: distances,
      terrain: terrain,
    );
    expect(v.sublist(0, 3), [true, true, true]);
    expect(v.sublist(3), everyElement(isFalse));
  });

  test('earth curvature ends line of sight over flat ground far away', () {
    final distances = [for (var i = 1; i <= 40; i++) i * 2000.0];
    final v = visibleAlongRay(
      originGroundMeters: 0,
      antennaHeightMeters: 2,
      distances: distances,
      terrain: List.filled(40, 0),
    );
    // Two radios 2 m and 1.5 m up see roughly 11 km with k = 4/3.
    expect(v.first, isTrue);
    expect(v.last, isFalse);
    final reach = distances[v.lastIndexOf(true)];
    expect(reach, inInclusiveRange(8000, 14000));
  });

  test('missing terrain is not counted as visible', () {
    final v = visibleAlongRay(
      originGroundMeters: 0,
      antennaHeightMeters: 5,
      distances: const [1000, 2000],
      terrain: const [null, 0],
    );
    expect(v, [false, true]);
  });

  test('sweep: 36 rays, terrain fetched 100 points at a time', () async {
    final calls = <int>[];
    final service = LineOfSightService(
      elevationDataSource: (p) => _terrain(p, calls),
    );
    final r = await service.analyzeCoverage(
      _origin,
      antennaHeightMeters: 10,
      radiusMeters: 10000,
    );
    expect(r.error, isNull);
    expect(r.rays, hasLength(36));
    expect(calls, everyElement(lessThanOrEqualTo(100)));
    expect(calls.fold<int>(0, (a, b) => a + b), 1 + 36 * 30);
    final north = r.rays.first;
    expect(north.bearing, 0);
    expect(north.reachMeters, lessThan(6500));
    expect(r.rays[18].reachMeters, 10000); // due south is open
    expect(r.visibleFraction, greaterThan(0.9));
    service.dispose();
  });

  test('no terrain at the antenna is an error', () async {
    final service = LineOfSightService(
      elevationDataSource: (p) async => List<double?>.filled(p.length, null),
    );
    final r = await service.analyzeCoverage(
      _origin,
      antennaHeightMeters: 10,
      radiusMeters: 5000,
    );
    expect(r.error, LineOfSightService.errorElevationUnavailable);
    service.dispose();
  });

  testWidgets('the screen starts at the radio and shows a summary', (
    tester,
  ) async {
    final calls = <int>[];
    final settings = AppSettingsService();
    final service = LineOfSightService(
      elevationDataSource: (p) => _terrain(p, calls),
    );
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MeshCoreConnector>.value(value: _Radio()),
          ChangeNotifierProvider<MapTileCacheService>(
            create: (_) => MapTileCacheService(appSettingsService: settings),
          ),
        ],
        child: MaterialApp(home: AntennaCoverageScreen(service: service)),
      ),
    );
    expect(find.textContaining("your radio's position"), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('analyze-coverage')));
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await tester.pump();
    expect(find.byKey(const ValueKey('coverage-summary')), findsOneWidget);
    expect(find.textContaining('farthest 10.0 km'), findsOneWidget);
    service.dispose();
  });

  group('signal estimate', () {
    const radio = CoverageRadio(
      txPowerDbm: 22,
      frequencyMHz: 915,
      bandwidthHz: 250000,
      spreadingFactor: 11,
    );
    final distances = [for (var i = 1; i <= 30; i++) 1000.0 * i];

    List<double?> run(List<double?> terrain, {double antenna = 10}) =>
        signalAlongRay(
          radio: radio,
          originGroundMeters: 0,
          antennaHeightMeters: antenna,
          distances: distances,
          terrain: terrain,
        );

    test('sensitivity follows bandwidth and spreading factor', () {
      expect(radio.sensitivityDbm, closeTo(-131.5, 0.1));
      const narrow = CoverageRadio(
        txPowerDbm: 22,
        frequencyMHz: 915,
        bandwidthHz: 125000,
        spreadingFactor: 11,
      );
      expect(narrow.sensitivityDbm, lessThan(radio.sensitivityDbm));
    });

    test('knife-edge loss matches known values', () {
      expect(knifeEdgeLossDb(-1), 0);
      expect(knifeEdgeLossDb(0), closeTo(6.0, 0.2));
      expect(knifeEdgeLossDb(2.4), closeTo(20.2, 0.5));
    });

    test('signal weakens with distance over open ground', () {
      final s = run(List<double?>.filled(30, 0), antenna: 200);
      expect(s.first!, greaterThan(s.last!));
      expect(radio.levelOf(s.first!), SignalLevel.strong);
    });

    test('a ridge costs signal behind it but not before it', () {
      final flat = run(List<double?>.filled(30, 0), antenna: 200);
      final ridge = List<double?>.filled(30, 0)..[9] = 600;
      final behind = run(ridge, antenna: 200);
      expect(behind[5], closeTo(flat[5]!, 0.01));
      expect(behind[20]!, lessThan(flat[20]! - 10));
    });

    test('two ridges cost more than one', () {
      final one = List<double?>.filled(30, 0)..[9] = 600;
      final two = List<double?>.of(one)..[18] = 600;
      expect(
        run(two, antenna: 200)[25]!,
        lessThan(run(one, antenna: 200)[25]!),
      );
    });

    test('missing terrain at a point is unknown, not zero', () {
      final t = List<double?>.filled(30, 0)..[4] = null;
      final s = run(t, antenna: 200);
      expect(s[4], isNull);
      expect(s[5], isNotNull);
    });

    test('levels split on sensitivity and a 10 dB margin', () {
      final limit = radio.sensitivityDbm;
      expect(radio.levelOf(limit + 11), SignalLevel.strong);
      expect(radio.levelOf(limit + 1), SignalLevel.marginal);
      expect(radio.levelOf(limit - 1), SignalLevel.none);
    });

    test('a sweep carries estimates when radio settings are given', () async {
      final service = LineOfSightService(
        elevationDataSource: (p) async => List<double?>.filled(p.length, 0),
      );
      final r = await service.analyzeCoverage(
        _origin,
        antennaHeightMeters: 40,
        radiusMeters: 10000,
        radio: radio,
      );
      expect(r.rays.first.signalDbm, hasLength(30));
      expect(r.countAt(SignalLevel.strong), greaterThan(0));
      service.dispose();
    });
  });
}
