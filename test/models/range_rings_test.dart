import 'dart:math' as math;

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:meshcore_open/models/app_settings.dart';
import 'package:meshcore_open/models/range_rings.dart';

void main() {
  group('niceStep', () {
    test('rounds down to 1, 1.5, 2, 2.5, 3, 4, 5, 6 or 8 × 10^n', () {
      expect(niceStep(1, minStep: 0.01), 1);
      expect(niceStep(1.49, minStep: 0.01), 1);
      expect(niceStep(1.5, minStep: 0.01), 1.5);
      expect(niceStep(1.9, minStep: 0.01), 1.5);
      expect(niceStep(2, minStep: 0.01), 2);
      expect(niceStep(2.7, minStep: 0.01), 2.5);
      expect(niceStep(3.9, minStep: 0.01), 3);
      expect(niceStep(4.99, minStep: 0.01), 4);
      expect(niceStep(5, minStep: 0.01), 5);
      expect(niceStep(7.9, minStep: 0.01), 6);
      expect(niceStep(9.99, minStep: 0.01), 8);
      expect(niceStep(10, minStep: 0.01), 10);
      expect(niceStep(730, minStep: 10), 600);
      expect(niceStep(2400, minStep: 10), 2000);
      expect(niceStep(0.37, minStep: 0.1), 0.3);
      expect(niceStep(0.5, minStep: 0.1), 0.5);
      expect(niceStep(0.3, minStep: 0.01), 0.3);
    });

    test('keeps at least two thirds of the raw value', () {
      for (var raw = 1.0; raw < 1e6; raw *= 1.013) {
        final step = niceStep(raw, minStep: 0.001);
        expect(step, lessThanOrEqualTo(raw * (1 + 1e-6)));
        expect(step / raw, greaterThanOrEqualTo(2 / 3 - 1e-6));
      }
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
      // 3 km to the edge -> 750 m -> 600 m steps.
      expect(ringRadii(3000, UnitSystem.metric), [600, 1200, 1800, 2400]);
      // 100 m to the edge -> 25 m -> 25 m steps.
      expect(ringRadii(100, UnitSystem.metric), [25, 50, 75, 100]);
    });

    test('metric steps start at 10 m', () {
      expect(ringRadii(12, UnitSystem.metric), [10, 20, 30, 40]);
    });

    test('imperial steps are whole miles-based and start at 0.1 mi', () {
      // 10 miles to the edge -> 2.5 mi -> 2.5 mi steps.
      final radii = ringRadii(10 * metresPerMile, UnitSystem.imperial);
      expect(radii.map((r) => r / metresPerMile), [
        for (final m in [2.5, 5, 7.5, 10]) closeTo(m, 1e-9),
      ]);
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

  group('unobscuredArea', () {
    test('is the view less the overlay insets', () {
      expect(
        unobscuredArea(
          const Size(400, 800),
          const EdgeInsets.fromLTRB(64, 140, 96, 24),
        ),
        const Rect.fromLTRB(64, 140, 304, 776),
      );
    });

    test('falls back to the whole view when the insets cover it', () {
      expect(
        unobscuredArea(
          const Size(100, 100),
          const EdgeInsets.fromLTRB(60, 0, 60, 0),
        ),
        const Rect.fromLTWH(0, 0, 100, 100),
      );
    });
  });

  group('labelFits', () {
    const area = Rect.fromLTRB(0, 100, 300, 500);
    const size = Size(72, 20);

    test('a label wholly inside fits', () {
      expect(labelFits(const Offset(150, 300), size, area), isTrue);
      expect(labelFits(const Offset(36, 110), size, area), isTrue);
    });

    test('a label reaching under an overlay does not fit', () {
      // Its top edge under the top bar.
      expect(labelFits(const Offset(150, 105), size, area), isFalse);
      // Its right edge under the side toolbar.
      expect(labelFits(const Offset(280, 300), size, area), isFalse);
    });
  });

  group('visibleLabelBearing', () {
    const area = Rect.fromLTRB(0, 100, 300, 500);
    const size = Size(72, 20);
    // A ring of 150 px round (150, 200): its north point is at y 50,
    // under the top bar.
    Offset ring(double bearing) {
      final rad = bearing * math.pi / 180;
      return Offset(150 + 150 * math.sin(rad), 200 - 150 * math.cos(rad));
    }

    test('north when north is visible', () {
      Offset big(double bearing) {
        final rad = bearing * math.pi / 180;
        return Offset(150 + 80 * math.sin(rad), 300 - 80 * math.cos(rad));
      }

      expect(visibleLabelBearing(big, size, area), 0);
    });

    test('moves round the ring when north is hidden', () {
      final bearing = visibleLabelBearing(ring, size, area);
      expect(bearing, isNotNull);
      expect(bearing, isNot(0));
      expect(labelFits(ring(bearing!), size, area), isTrue);
    });

    test('is null when the label fits nowhere on the ring', () {
      Offset offScreen(double bearing) => const Offset(-500, -500);
      expect(visibleLabelBearing(offScreen, size, area), isNull);
    });

    test('tries north first and south last', () {
      expect(labelBearings.first, 0);
      expect(labelBearings.last, 180);
      expect(labelBearings.toSet(), hasLength(8));
    });
  });
}
