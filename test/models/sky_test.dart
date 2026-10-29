import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/sky.dart';

void main() {
  void near(DateTime actual, DateTime expected) => expect(
    actual.difference(expected).inMinutes.abs(),
    lessThanOrEqualTo(4),
    reason: '$actual vs $expected',
  );

  test('Seattle solstice sunrise and sunset match published times', () {
    // 21 Jun 2026: sunrise 05:11, sunset 21:11 PDT (UTC-7).
    final day = sunTimes(47.61, -122.33, DateTime(2026, 6, 21));
    expect(day, isA<SunRiseSet>());
    final s = day as SunRiseSet;
    near(s.sunrise, DateTime.utc(2026, 6, 21, 12, 11));
    near(s.sunset, DateTime.utc(2026, 6, 22, 4, 11));
  });

  test('polar day and night have no sunrise', () {
    expect(sunTimes(69.65, 18.96, DateTime(2026, 6, 21)), isA<SunAlwaysUp>());
    expect(
      sunTimes(69.65, 18.96, DateTime(2026, 12, 21)),
      isA<SunAlwaysDown>(),
    );
  });

  test('moon phase matches known full and new moons', () {
    final full = moonPhase(DateTime.utc(2024, 1, 25, 17, 54));
    expect(full.illumination, greaterThan(0.98));
    expect(full.name, 'full moon');
    final fresh = moonPhase(DateTime.utc(2024, 1, 11, 11, 57));
    expect(fresh.illumination, lessThan(0.02));
    expect(fresh.name, 'new moon');
  });
}
