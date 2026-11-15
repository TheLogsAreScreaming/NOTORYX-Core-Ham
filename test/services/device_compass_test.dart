import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/services/device_compass.dart';

void main() {
  group('normalizeDegrees', () {
    test('wraps into 0–360', () {
      expect(normalizeDegrees(370), 10);
      expect(normalizeDegrees(-10), 350);
      expect(normalizeDegrees(720), 0);
    });
  });

  group('turnAngle', () {
    test('right is positive, left negative', () {
      expect(turnAngle(bearing: 90, heading: 0), 90);
      expect(turnAngle(bearing: 0, heading: 90), -90);
    });

    test('takes the short way across north', () {
      expect(turnAngle(bearing: 10, heading: 350), 20);
      expect(turnAngle(bearing: 350, heading: 10), -20);
    });

    test('straight behind is 180', () {
      expect(turnAngle(bearing: 180, heading: 0).abs(), 180);
    });
  });

  group('smoothHeading', () {
    test('first reading is taken as is', () {
      expect(smoothHeading(null, 370), 10);
    });

    test('moves part way the short way round', () {
      final h = smoothHeading(350, 10, alpha: 0.5);
      expect(h, closeTo(0, 1e-9));
    });

    test('never spins the long way', () {
      var h = 355.0;
      for (var i = 0; i < 20; i++) {
        h = smoothHeading(h, 5);
        expect(h >= 355 || h <= 5, isTrue, reason: 'heading went to $h');
      }
      expect(h, closeTo(5, 0.1));
    });
  });

  test('a low accuracy reading asks for calibration', () {
    expect(
      const CompassReading(magneticHeading: 0, accuracy: 1).needsCalibration,
      isTrue,
    );
    expect(
      const CompassReading(magneticHeading: 0, accuracy: 3).needsCalibration,
      isFalse,
    );
  });
}
