import 'dart:math' as math;

/// Sunrise and sunset for one day, or why there isn't one.
sealed class SunDay {
  const SunDay();
}

/// The sun rises and sets on this day (both in UTC).
class SunRiseSet extends SunDay {
  final DateTime sunrise;
  final DateTime sunset;
  const SunRiseSet(this.sunrise, this.sunset);
}

/// The sun stays up all day (midnight sun).
class SunAlwaysUp extends SunDay {
  const SunAlwaysUp();
}

/// The sun stays down all day (polar night).
class SunAlwaysDown extends SunDay {
  const SunAlwaysDown();
}

double _rad(double d) => d * math.pi / 180;
double _deg(double r) => r * 180 / math.pi;
double _julian(DateTime t) => t.millisecondsSinceEpoch / 86400000 + 2440587.5;
DateTime _fromJulian(double j) => DateTime.fromMillisecondsSinceEpoch(
  ((j - 2440587.5) * 86400000).round(),
  isUtc: true,
);

/// Sunrise and sunset on the calendar day [date] at [lat], [lon] (degrees,
/// east positive), using the sunrise equation: good to a minute or two
/// away from the poles, ignoring terrain and elevation.
SunDay sunTimes(double lat, double lon, DateTime date) {
  final noon = DateTime.utc(date.year, date.month, date.day, 12);
  final n = (_julian(noon) - 2451545.0 + 0.0008).roundToDouble();
  final jStar = n - lon / 360;
  final m = (357.5291 + 0.98560028 * jStar) % 360;
  final c =
      1.9148 * math.sin(_rad(m)) +
      0.02 * math.sin(_rad(2 * m)) +
      0.0003 * math.sin(_rad(3 * m));
  final lambda = (m + c + 180 + 102.9372) % 360;
  final transit =
      2451545.0 +
      jStar +
      0.0053 * math.sin(_rad(m)) -
      0.0069 * math.sin(_rad(2 * lambda));
  final sinDecl = math.sin(_rad(lambda)) * math.sin(_rad(23.4397));
  final cosDecl = math.cos(math.asin(sinDecl));
  final cosHour =
      (math.sin(_rad(-0.833)) - math.sin(_rad(lat)) * sinDecl) /
      (math.cos(_rad(lat)) * cosDecl);
  if (cosHour > 1) return const SunAlwaysDown();
  if (cosHour < -1) return const SunAlwaysUp();
  final hour = _deg(math.acos(cosHour));
  return SunRiseSet(
    _fromJulian(transit - hour / 360),
    _fromJulian(transit + hour / 360),
  );
}

/// The moon on a given instant: how far through its cycle and how lit.
class MoonPhase {
  /// Days since the last new moon, 0 to about 29.5.
  final double age;

  /// Fraction of the disc lit, 0 to 1.
  final double illumination;

  const MoonPhase(this.age, this.illumination);

  static const synodicMonth = 29.530588853;

  /// The eight common phase names, in order from new moon.
  String get name {
    const names = [
      'new moon',
      'waxing crescent',
      'first quarter',
      'waxing gibbous',
      'full moon',
      'waning gibbous',
      'last quarter',
      'waning crescent',
    ];
    final index = ((age / synodicMonth) * 8 + 0.5).floor() % 8;
    return names[index];
  }
}

/// The moon's phase at [time], from the mean synodic month counted from the
/// new moon of 6 Jan 2000 18:14 UTC. Within about half a day of the true
/// phase, which is plenty for a phase name and a percentage.
MoonPhase moonPhase(DateTime time) {
  const knownNewMoon = 2451550.1;
  final age = (_julian(time.toUtc()) - knownNewMoon) % MoonPhase.synodicMonth;
  final lit = (1 - math.cos(2 * math.pi * age / MoonPhase.synodicMonth)) / 2;
  return MoonPhase(age, lit);
}
