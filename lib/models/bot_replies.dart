import 'dart:math' as math;

import '../helpers/path_helper.dart';
import 'sky.dart';

/// Rolls dice for `!dice`: no argument is one six-sided die; `2d6`, `d20`
/// or `20` pick the count and sides. Null when the argument doesn't parse
/// or asks for more than 10 dice or fewer than 2 / more than 1000 sides.
String? rollDice(String args, math.Random random) {
  final arg = args.trim().toLowerCase();
  var count = 1;
  var sides = 6;
  final dice = RegExp(r'^(\d*)d(\d+)$').firstMatch(arg);
  if (dice != null) {
    count = dice.group(1)!.isEmpty ? 1 : int.parse(dice.group(1)!);
    sides = int.parse(dice.group(2)!);
  } else if (RegExp(r'^\d+$').hasMatch(arg)) {
    sides = int.parse(arg);
  } else if (arg.isNotEmpty) {
    return null;
  }
  if (count < 1 || count > 10 || sides < 2 || sides > 1000) return null;
  final rolls = [for (var i = 0; i < count; i++) random.nextInt(sides) + 1];
  if (count == 1) return 'Rolled d$sides: ${rolls.single}';
  final total = rolls.reduce((a, b) => a + b);
  return 'Rolled ${count}d$sides: ${rolls.join(' + ')} = $total';
}

/// How a direct message reached this radio, for `!trace`: "direct" or the
/// repeater IDs along the way, last repeater nearest this radio.
String traceReply(List<int> pathBytes, int? pathLength) {
  if (pathBytes.isEmpty) {
    return 'Your message reached me direct (no repeaters).';
  }
  final hops = pathLength != null && pathLength > 0 ? pathLength : null;
  final width = hops == null ? 1 : (pathBytes.length ~/ hops).clamp(1, 4);
  final ids = PathHelper.splitPathBytes(
    pathBytes,
    width,
  ).map(PathHelper.formatHopHex).toList();
  final count = ids.length;
  return 'Your message took $count hop${count == 1 ? '' : 's'}: '
      '${ids.join(' > ')}';
}

String _clock(DateTime utc) {
  final t = utc.toLocal();
  return '${t.hour.toString().padLeft(2, '0')}:'
      '${t.minute.toString().padLeft(2, '0')}';
}

/// `!sun` reply for [lat], [lon] on [now]'s day, in this phone's time zone.
String sunReply(double lat, double lon, DateTime now) {
  return switch (sunTimes(lat, lon, now)) {
    SunRiseSet(:final sunrise, :final sunset) =>
      'Sunrise ${_clock(sunrise)}, sunset ${_clock(sunset)} '
          '(at the radio, local time).',
    SunAlwaysUp() => 'The sun stays up all day here today.',
    SunAlwaysDown() => 'The sun stays down all day here today.',
  };
}

/// `!moon` reply: phase name and how much of the disc is lit.
String moonReply(DateTime now) {
  final moon = moonPhase(now);
  final name = moon.name;
  return 'Moon: ${name[0].toUpperCase()}${name.substring(1)}, '
      '${(moon.illumination * 100).round()}% lit.';
}

/// Current conditions from Open-Meteo, as the `!weather` reply shows them.
class WeatherNow {
  final double temperatureC;
  final int weatherCode;
  final double windKmh;
  final int humidity;
  final DateTime fetchedAt;

  const WeatherNow({
    required this.temperatureC,
    required this.weatherCode,
    required this.windKmh,
    required this.humidity,
    required this.fetchedAt,
  });

  /// Parses Open-Meteo's `current` block, or null when it's missing.
  static WeatherNow? fromOpenMeteo(Map<String, dynamic> json, DateTime now) {
    final current = json['current'];
    if (current is! Map) return null;
    final temp = current['temperature_2m'];
    final code = current['weather_code'];
    final wind = current['wind_speed_10m'];
    final humidity = current['relative_humidity_2m'];
    if (temp is! num || code is! num || wind is! num || humidity is! num) {
      return null;
    }
    return WeatherNow(
      temperatureC: temp.toDouble(),
      weatherCode: code.toInt(),
      windKmh: wind.toDouble(),
      humidity: humidity.round(),
      fetchedAt: now,
    );
  }

  /// A few words for a WMO weather code.
  static String describe(int code) => switch (code) {
    0 => 'clear',
    1 => 'mostly clear',
    2 => 'partly cloudy',
    3 => 'overcast',
    45 || 48 => 'fog',
    51 || 53 || 55 => 'drizzle',
    56 || 57 => 'freezing drizzle',
    61 => 'light rain',
    63 => 'rain',
    65 => 'heavy rain',
    66 || 67 => 'freezing rain',
    71 => 'light snow',
    73 => 'snow',
    75 => 'heavy snow',
    77 => 'snow grains',
    80 || 81 || 82 => 'rain showers',
    85 || 86 => 'snow showers',
    95 => 'thunderstorm',
    96 || 99 => 'thunderstorm with hail',
    _ => 'unknown conditions',
  };

  /// The `!weather` reply, in both °C and °F.
  String reply(DateTime now) {
    final f = (temperatureC * 9 / 5 + 32).round();
    final age = now.difference(fetchedAt).inMinutes;
    return 'Weather near the radio: ${temperatureC.round()}°C/$f°F, '
        '${describe(weatherCode)}, wind ${windKmh.round()} km/h, '
        '$humidity% humidity${age >= 5 ? ' ($age min ago)' : ''}.';
  }
}
