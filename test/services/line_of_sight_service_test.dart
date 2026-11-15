import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:meshcore_open/services/line_of_sight_service.dart';

void main() {
  List<LatLng> makePoints(int count) {
    return List<LatLng>.generate(count, (i) => LatLng(0, i * 0.00001));
  }

  test('computeFromElevations reports clear LOS on flat terrain', () {
    final points = makePoints(21);
    final elevations = List<double>.filled(points.length, 100);

    final result = LineOfSightService.computeFromElevations(
      points: points,
      elevations: elevations,
      startAntennaHeightMeters: 2,
      endAntennaHeightMeters: 2,
      kFactor: 4.0 / 3.0,
    );

    expect(result.hasData, isTrue);
    expect(result.isClear, isTrue);
    expect(result.maxObstructionMeters, equals(0));
    expect(result.firstObstructionDistanceMeters, isNull);
    expect(result.obstructions, isEmpty);
  });

  test(
    'computeFromElevations reports blocked LOS with central obstruction',
    () {
      final points = makePoints(21);
      final elevations = List<double>.filled(points.length, 100);
      elevations[10] = 300;

      final result = LineOfSightService.computeFromElevations(
        points: points,
        elevations: elevations,
        startAntennaHeightMeters: 1.5,
        endAntennaHeightMeters: 1.5,
        kFactor: 4.0 / 3.0,
      );

      expect(result.hasData, isTrue);
      expect(result.isClear, isFalse);
      expect(result.maxObstructionMeters, greaterThan(0));
      expect(result.firstObstructionDistanceMeters, isNotNull);
      expect(result.obstructions, hasLength(1));
      expect(result.obstructions.single.sampleIndex, equals(10));
      expect(result.obstructions.single.point, equals(points[10]));
    },
  );

  test('computeFromElevations groups contiguous blocked samples', () {
    final points = makePoints(21);
    final elevations = List<double>.filled(points.length, 100);
    elevations[9] = 220;
    elevations[10] = 320;
    elevations[11] = 240;

    final result = LineOfSightService.computeFromElevations(
      points: points,
      elevations: elevations,
      startAntennaHeightMeters: 1.5,
      endAntennaHeightMeters: 1.5,
      kFactor: 4.0 / 3.0,
    );

    expect(result.obstructions, hasLength(1));
    expect(result.obstructions.single.sampleIndex, equals(10));
    expect(result.obstructions.single.obstructionMeters, greaterThan(0));
  });

  test('analyzePath summarizes clear and blocked segments', () async {
    final service = LineOfSightService(
      elevationDataSource: (points) async {
        final elevations = List<double?>.filled(points.length, 100);
        if (points.first.longitude > 0.00005) {
          elevations[elevations.length ~/ 2] = 300;
        }
        return elevations;
      },
    );

    final path = [
      const LatLng(0, 0),
      const LatLng(0, 0.0001),
      const LatLng(0, 0.0002),
    ];

    final result = await service.analyzePath(path);

    expect(result.segments.length, 2);
    expect(result.clearSegments, 1);
    expect(result.blockedSegments, 1);
    expect(result.unknownSegments, 0);
  });

  group('Fresnel zone', () {
    test('radius matches the textbook value at the midpoint', () {
      // 10 km link at 915 MHz: r1 = sqrt(λ · 5000 · 5000 / 10000) ≈ 28.6 m.
      final r = LineOfSightService.fresnelRadius(
        d1: 5000,
        d2: 5000,
        frequencyMHz: 915,
      );
      expect(r, closeTo(28.62, 0.05));
    });

    test('radius is zero at the ends and for bad input', () {
      expect(
        LineOfSightService.fresnelRadius(d1: 0, d2: 1000, frequencyMHz: 915),
        0,
      );
      expect(
        LineOfSightService.fresnelRadius(d1: 1000, d2: 0, frequencyMHz: 915),
        0,
      );
      expect(
        LineOfSightService.fresnelRadius(d1: 500, d2: 500, frequencyMHz: 0),
        0,
      );
    });

    test('higher frequency gives a narrower zone', () {
      final low = LineOfSightService.fresnelRadius(
        d1: 2000,
        d2: 2000,
        frequencyMHz: 433,
      );
      final high = LineOfSightService.fresnelRadius(
        d1: 2000,
        d2: 2000,
        frequencyMHz: 915,
      );
      expect(high, lessThan(low));
    });

    List<LatLng> longPoints(int count) {
      // About 11 km end to end along the equator.
      return List<LatLng>.generate(count, (i) => LatLng(0, i * 0.005));
    }

    test('samples carry a Fresnel radius, widest in the middle', () {
      final points = longPoints(21);
      final result = LineOfSightService.computeFromElevations(
        points: points,
        elevations: List<double>.filled(points.length, 0),
        startAntennaHeightMeters: 200,
        endAntennaHeightMeters: 200,
        kFactor: 4.0 / 3.0,
        frequencyMHz: 915,
      );
      final radii = result.samples.map((s) => s.fresnelRadiusMeters).toList();
      expect(radii.first, 0);
      expect(radii.last, 0);
      expect(radii[10], greaterThan(radii[3]));
      expect(radii[10], closeTo(30, 2));
    });

    test('falls back to the 33 cm default channel with no radio frequency', () {
      final points = longPoints(21);
      final result = LineOfSightService.computeFromElevations(
        points: points,
        elevations: List<double>.filled(points.length, 0),
        startAntennaHeightMeters: 200,
        endAntennaHeightMeters: 200,
        kFactor: 4.0 / 3.0,
      );
      final mid = result.samples[10];
      final expected = LineOfSightService.fresnelRadius(
        d1: mid.distanceMeters,
        d2: result.samples.last.distanceMeters - mid.distanceMeters,
        frequencyMHz: LineOfSightService.fresnelFallbackFrequencyMHz,
      );
      expect(LineOfSightService.fresnelFallbackFrequencyMHz, 906.875);
      expect(mid.fresnelRadiusMeters, closeTo(expected, 1e-9));
    });

    test('high antennas over flat ground clear the whole zone', () {
      final points = longPoints(21);
      final result = LineOfSightService.computeFromElevations(
        points: points,
        elevations: List<double>.filled(points.length, 0),
        startAntennaHeightMeters: 200,
        endAntennaHeightMeters: 200,
        kFactor: 4.0 / 3.0,
        frequencyMHz: 915,
      );
      expect(result.isClear, isTrue);
      expect(result.worstFresnelClearance, greaterThan(1));
      expect(result.isFresnelClear, isTrue);
    });

    test('a ridge just under the beam is clear LOS but not Fresnel clear', () {
      final points = longPoints(21);
      final elevations = List<double>.filled(points.length, 0);
      final probe = LineOfSightService.computeFromElevations(
        points: points,
        elevations: elevations,
        startAntennaHeightMeters: 200,
        endAntennaHeightMeters: 200,
        kFactor: 4.0 / 3.0,
        frequencyMHz: 915,
      );
      // Raise the middle so only a few metres of the zone stay clear.
      elevations[10] = probe.samples[10].clearanceMeters - 5;
      final result = LineOfSightService.computeFromElevations(
        points: points,
        elevations: elevations,
        startAntennaHeightMeters: 200,
        endAntennaHeightMeters: 200,
        kFactor: 4.0 / 3.0,
        frequencyMHz: 915,
      );
      expect(result.isClear, isTrue);
      expect(result.worstFresnelClearance, isNotNull);
      expect(result.worstFresnelClearance!, lessThan(0.6));
      expect(result.worstFresnelClearance!, greaterThan(0));
      expect(result.isFresnelClear, isFalse);
    });

    test('blocked LOS gives a negative Fresnel clearance', () {
      final points = longPoints(21);
      final elevations = List<double>.filled(points.length, 0);
      elevations[10] = 1000;
      final result = LineOfSightService.computeFromElevations(
        points: points,
        elevations: elevations,
        startAntennaHeightMeters: 10,
        endAntennaHeightMeters: 10,
        kFactor: 4.0 / 3.0,
        frequencyMHz: 915,
      );
      expect(result.isClear, isFalse);
      expect(result.worstFresnelClearance!, lessThan(0));
    });

    test('no frequency matches a radio on 906.875 MHz', () {
      final points = longPoints(21);
      final withFreq = LineOfSightService.computeFromElevations(
        points: points,
        elevations: List<double>.filled(points.length, 0),
        kFactor: 4.0 / 3.0,
        frequencyMHz: 906.875,
      );
      final without = LineOfSightService.computeFromElevations(
        points: points,
        elevations: List<double>.filled(points.length, 0),
        kFactor: 4.0 / 3.0,
      );
      expect(
        without.samples[10].fresnelRadiusMeters,
        closeTo(withFreq.samples[10].fresnelRadiusMeters, 1e-9),
      );
    });
  });
}
