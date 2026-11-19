import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/app_settings.dart';
import 'package:meshcore_open/models/node_staleness.dart';

void main() {
  final now = DateTime(2026, 11, 18, 12);
  const day = Duration(hours: 24);

  group('isStale', () {
    test('a node heard longer ago than the threshold is stale', () {
      expect(
        isStale(now.subtract(const Duration(hours: 25)), now, day),
        isTrue,
      );
    });

    test('a node heard exactly the threshold ago is stale', () {
      expect(isStale(now.subtract(day), now, day), isTrue);
    });

    test('a node heard recently is not stale', () {
      expect(
        isStale(now.subtract(const Duration(hours: 23)), now, day),
        isFalse,
      );
    });

    test('a node with no last-heard time is never stale', () {
      expect(isStale(null, now, day), isFalse);
      expect(
        isStale(DateTime.fromMillisecondsSinceEpoch(0), now, day),
        isFalse,
      );
    });

    test('nothing is stale when the setting is off', () {
      final old = now.subtract(const Duration(days: 30));
      expect(isStale(old, now, null), isFalse);
      expect(isStale(old, now, Duration.zero), isFalse);
    });

    test('a last-heard time in the future is not stale', () {
      expect(isStale(now.add(const Duration(hours: 2)), now, day), isFalse);
    });
  });

  group('knownLastHeard', () {
    test('the epoch (a radio reporting 0) is unknown', () {
      expect(
        knownLastHeard(DateTime.fromMillisecondsSinceEpoch(0), now),
        isNull,
      );
    });

    test('a time just after the epoch (an unset clock) is unknown', () {
      // 20 days after 1970, which showed as "stale · 20771 days ago".
      final unset = DateTime.fromMillisecondsSinceEpoch(20 * 86400 * 1000);
      expect(knownLastHeard(unset, now), isNull);
      expect(isStale(unset, now, day), isFalse);
    });

    test('a pre-2020 time is unknown', () {
      final old = DateTime.utc(2019, 12, 31, 23, 59);
      expect(knownLastHeard(old, now), isNull);
      expect(isStale(old, now, day), isFalse);
    });

    test('a time more than a day ahead is unknown', () {
      final ahead = now.add(const Duration(days: 2));
      expect(knownLastHeard(ahead, now), isNull);
      expect(isStale(ahead, now, day), isFalse);
    });

    test('a little clock drift ahead is still known', () {
      final drift = now.add(const Duration(hours: 2));
      expect(knownLastHeard(drift, now), drift);
    });

    test('a normal time is known and can be stale', () {
      final heard = DateTime(2026, 11, 10);
      expect(knownLastHeard(heard, now), heard);
      expect(isStale(heard, now, day), isTrue);
    });

    test('missing is unknown', () {
      expect(knownLastHeard(null, now), isNull);
    });
  });

  group('staleAfterFromHours', () {
    test('0 is off; hours become a duration', () {
      expect(staleAfterFromHours(0), isNull);
      expect(staleAfterFromHours(72), const Duration(days: 3));
    });

    test('the choices are Off, 1 h, 6 h, 24 h, 3 days and 7 days', () {
      expect(staleAfterChoices, [0, 1, 6, 24, 72, 168]);
    });
  });

  group('settings', () {
    test('default to 24 h and rings off, and round-trip', () {
      final defaults = AppSettings();
      expect(defaults.staleAfterHours, 24);
      expect(defaults.mapShowRangeRings, isFalse);

      final back = AppSettings.fromJson(
        AppSettings(staleAfterHours: 168, mapShowRangeRings: true).toJson(),
      );
      expect(back.staleAfterHours, 168);
      expect(back.mapShowRangeRings, isTrue);
      expect(back.copyWith(staleAfterHours: 0).mapShowRangeRings, isTrue);
    });
  });
}
