import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/bot_replies.dart';
import 'package:meshcore_open/models/bot_settings.dart';

void main() {
  test('dice rolls stay in range and reject nonsense', () {
    final random = math.Random(1);
    for (var i = 0; i < 50; i++) {
      final one = rollDice('', random)!;
      final value = int.parse(one.split(': ').last);
      expect(value, inInclusiveRange(1, 6));
    }
    expect(rollDice('20', random), startsWith('Rolled d20: '));
    expect(rollDice('d8', random), startsWith('Rolled d8: '));
    final two = rollDice('2d6', random)!;
    final parts = RegExp(r'(\d+) \+ (\d+) = (\d+)$').firstMatch(two)!;
    expect(int.parse(parts[1]!) + int.parse(parts[2]!), int.parse(parts[3]!));
    for (final bad in ['banana', '11d6', '1d1', '1d5000', '0d6', '2d']) {
      expect(rollDice(bad, random), isNull, reason: bad);
    }
  });

  test('trace names each hop at the path width', () {
    expect(traceReply(Uint8List(0), 0), contains('direct'));
    expect(
      traceReply(Uint8List.fromList([0x5a, 0x94]), 2),
      'Your message took 2 hops: 5A > 94',
    );
    expect(
      traceReply(Uint8List.fromList([0x5a, 0x10, 0x94, 0x20]), 2),
      'Your message took 2 hops: 5A10 > 9420',
    );
  });

  test('weather parses Open-Meteo and fits a bot reply', () {
    final now = DateTime(2026, 10, 28, 9);
    final weather = WeatherNow.fromOpenMeteo(
      jsonDecode(
            '{"current":{"temperature_2m":8.4,"weather_code":61,'
            '"wind_speed_10m":12.2,"relative_humidity_2m":87}}',
          )
          as Map<String, dynamic>,
      now,
    )!;
    final reply = weather.reply(now);
    expect(reply, contains('8°C/47°F'));
    expect(reply, contains('light rain'));
    expect(isValidBotResponse(reply), isTrue);
    expect(
      weather.reply(now.add(const Duration(minutes: 20))),
      contains('20 min ago'),
    );
    expect(WeatherNow.fromOpenMeteo({'current': {}}, now), isNull);
  });

  test('sun and moon replies fit a bot reply', () {
    expect(
      isValidBotResponse(sunReply(47.6, -122.3, DateTime(2026, 6, 21))),
      isTrue,
    );
    expect(sunReply(69.65, 18.96, DateTime(2026, 12, 21)), contains('down'));
    expect(isValidBotResponse(moonReply(DateTime(2026, 10, 28))), isTrue);
  });
}
