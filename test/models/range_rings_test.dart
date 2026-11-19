import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:meshcore_open/models/app_settings.dart';
import 'package:meshcore_open/models/range_rings.dart';

void main() {
  group('niceStep', () {
    test('rounds down to 1, 2 or 5 × 10^n', () {
      expect(niceStep(1, minStep: 0.01), 1);
      expect(niceStep(1.9, minStep: 0.01), 1);
      expect(niceStep(2, minStep: 0.01), 2);
      expect(niceStep(4.99, minStep: 0.01), 2);
      expect(niceStep(5, minStep: 0.01), 5);
      expect(niceStep(9.99, minStep: 0.01), 5);
      expect(niceStep(10, minStep: 0.01), 10);
      expect(niceStep(730, minStep: 10), 500);
      expect(niceStep(2400, minStep: 10), 2000);
      expect(niceStep(0.37, minStep: 0.1), 0.2);
      expect(niceStep(0.5, minStep: 0.1), 0.5);
      expect(niceStep(0.3, minStep: 0.01), 0.2);
    });

    test('never goes below the minimum step', () {
      expect(niceStep(3, minStep: 10), 10);
      expect(niceStep(0.04, minStep: 0.1), 0.1);
      expect(niceStep(0, minStep: 10), 10);
      expect(niceStep(double.nan, minStep: 10), 10);
      expect(niceStep(double.infinity, minStep: 10), 10);
    });
  });

  group('ringRadii', () {
    test('metric: four rings at a quarter of the view, rounded down', () {
      // 3 km to the edge -> 750 m -> 500 m steps.
      expect(ringRadii(3000, UnitSystem.metric), [500, 1000, 1500, 2000]);
      // 100 m to the edge -> 25 m -> 20 m steps.
      expect(ringRadii(100, UnitSystem.metric), [20, 40, 60, 80]);
    });

    test('metric steps start at 10 m', () {
      expect(ringRadii(12, UnitSystem.metric), [10, 20, 30, 40]);
    });

    test('imperial steps are whole miles-based and start at 0.1 mi', () {
      // 10 miles to the edge -> 2.5 mi -> 2 mi steps.
      final radii = ringRadii(10 * metresPerMile, UnitSystem.imperial);
      expect(radii.map((r) => r / metresPerMile), [2, 4, 6, 8]);
      final tiny = ringRadii(50, UnitSystem.imperial);
      expect(tiny.first / metresPerMile, closeTo(0.1, 1e-9));
    });
  });

  group('ringLabel', () {
    test('metric uses m below 1 km and km above', () {
      expect(ringLabel(20, UnitSystem.metric), '20 m');
      expect(ringLabel(500, UnitSystem.metric), '500 m');
      expect(ringLabel(1000, UnitSystem.metric), '1 km');
      expect(ringLabel(1500, UnitSystem.metric), '1.5 km');
      expect(ringLabel(20000, UnitSystem.metric), '20 km');
    });

    test('imperial uses miles without float noise', () {
      expect(ringLabel(0.1 * 3 * metresPerMile, UnitSystem.imperial), '0.3 mi');
      expect(ringLabel(0.5 * metresPerMile, UnitSystem.imperial), '0.5 mi');
      expect(ringLabel(2 * metresPerMile, UnitSystem.imperial), '2 mi');
      expect(ringLabel(1.5 * metresPerMile, UnitSystem.imperial), '1.5 mi');
    });
  });

  group('pointAt', () {
    const centre = LatLng(52.0, 5.0);
    const distance = Distance();

    test('lands the given distance away', () {
      for (final bearing in [0.0, 45.0, 90.0, 180.0, 270.0]) {
        final p = pointAt(centre, 1000, bearing);
        expect(distance.as(LengthUnit.Meter, centre, p), closeTo(1000, 1));
      }
    });

    test('follows the compass', () {
      final north = pointAt(centre, 1000, 0);
      expect(north.latitude, greaterThan(centre.latitude));
      expect(north.longitude, closeTo(centre.longitude, 1e-9));
      final east = pointAt(centre, 1000, 90);
      expect(east.longitude, greaterThan(centre.longitude));
      expect(pointAt(centre, 1000, 180).latitude, lessThan(centre.latitude));
      expect(pointAt(centre, 1000, 270).longitude, lessThan(centre.longitude));
    });
  });
}
