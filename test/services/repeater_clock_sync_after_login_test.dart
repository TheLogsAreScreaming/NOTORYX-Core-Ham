import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/services/repeater_clock_sync.dart';

void main() {
  final now = DateTime.utc(2026, 11, 25, 12);

  test('how far behind the repeater clock is', () {
    expect(
      RepeaterClockSync.behindBy(DateTime.utc(2024, 5, 15), now)!.inDays,
      greaterThan(900),
    );
    expect(RepeaterClockSync.behindBy(null, now), isNull);
  });

  test('syncs only when on and the clock is off by over a minute', () {
    const off = Duration(days: 900);
    const close = Duration(seconds: 20);
    expect(RepeaterClockSync.shouldSync(enabled: true, behind: off), isTrue);
    expect(
      RepeaterClockSync.shouldSync(enabled: true, behind: -off),
      isTrue,
      reason: 'ahead: still worth a try, the reply says it cannot go back',
    );
    expect(RepeaterClockSync.shouldSync(enabled: true, behind: close), isFalse);
    expect(RepeaterClockSync.shouldSync(enabled: true, behind: null), isTrue);
    expect(RepeaterClockSync.shouldSync(enabled: false, behind: off), isFalse);
  });

  test('a wrong clock is pointed out when automatic sync is off', () {
    expect(
      RepeaterClockSync.shouldNotify(
        enabled: false,
        behind: const Duration(hours: 1),
      ),
      isTrue,
    );
    expect(
      RepeaterClockSync.shouldNotify(
        enabled: false,
        behind: const Duration(minutes: 2),
      ),
      isFalse,
    );
    expect(
      RepeaterClockSync.shouldNotify(
        enabled: true,
        behind: const Duration(days: 1),
      ),
      isFalse,
    );
    expect(
      RepeaterClockSync.shouldNotify(enabled: false, behind: null),
      isFalse,
    );
  });

  test('reads the repeater reply', () {
    expect(
      RepeaterClockSync.resultOf('OK - clock set: 20:15 - 23/11/2026 UTC'),
      RepeaterClockSyncResult.set,
    );
    expect(
      RepeaterClockSync.resultOf('(ERR: clock cannot go backwards)'),
      RepeaterClockSyncResult.ahead,
    );
    expect(
      RepeaterClockSync.resultOf('Unknown command'),
      RepeaterClockSyncResult.failed,
    );
    expect(RepeaterClockSync.resultOf(null), RepeaterClockSyncResult.failed);
  });
}
