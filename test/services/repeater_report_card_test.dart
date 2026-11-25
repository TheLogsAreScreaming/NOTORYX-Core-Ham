import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/services/repeater_report_card.dart';
import 'package:meshcore_open/services/repeater_status_history.dart';

void main() {
  final t0 = DateTime(2026, 11, 1, 12);
  StatusSample s(int day, {int? mv, int? up, int? err, int? noise}) =>
      StatusSample(
        at: t0.add(Duration(days: day)),
        batteryMv: mv,
        uptimeSecs: up,
        errors: err,
        noiseFloor: noise,
      );

  test('restarts, uptime, errors across a restart, battery and noise', () {
    final card = RepeaterReportCard.from(
      samples: [
        s(0, mv: 4100, up: 1000, err: 2, noise: -110),
        s(7, mv: 4000, up: 605800, err: 5, noise: -100),
        // Restarted: uptime and the error counter start over.
        s(14, mv: 3900, up: 3600, err: 1, noise: -120),
      ],
      neighbours: const {},
      now: t0.add(const Duration(days: 14)),
    );
    expect(card.checks, 3);
    expect(card.span, const Duration(days: 14));
    expect(card.restarts, 1);
    expect(card.longestUptimeSecs, 605800);
    expect(card.newErrors, 3 + 1);
    expect(card.batteryNowMv, 3900);
    expect(card.batteryLowMv, 3900);
    expect(card.batteryMvPerWeek, closeTo(-100, 0.01));
    expect(card.noiseAvg, closeTo(-110, 0.01));
    expect(card.noiseWorst, -100);
  });

  test('neighbour churn is measured against the last week', () {
    final now = t0.add(const Duration(days: 20));
    final card = RepeaterReportCard.from(
      samples: const [],
      neighbours: {
        // Heard all along.
        'aa': [SnrSample(t0, 5), SnrSample(now, 6)],
        // First heard two days ago.
        'bb': [SnrSample(now.subtract(const Duration(days: 2)), 3)],
        // Last heard ten days ago.
        'cc': [SnrSample(now.subtract(const Duration(days: 10)), -4)],
      },
      now: now,
    );
    expect(card.neighboursHeard, 3);
    expect(card.neighboursNew, 1);
    expect(card.neighboursGone, 1);
    expect(card.isEmpty, isFalse);
  });

  test('one reading has no trend and an empty history is empty', () {
    final one = RepeaterReportCard.from(
      samples: [s(0, mv: 4000)],
      neighbours: const {},
      now: t0,
    );
    expect(one.batteryMvPerWeek, isNull);
    expect(one.span, Duration.zero);
    expect(
      RepeaterReportCard.from(
        samples: const [],
        neighbours: const {},
        now: t0,
      ).isEmpty,
      isTrue,
    );
  });

  test('CSV has a header, UTC times and empty cells for missing values', () {
    final csv = statusSamplesCsv([s(0, mv: 4100, up: 60)]);
    final lines = csv.split('\r\n');
    expect(
      lines.first,
      'time_utc,battery_mv,rssi_dbm,snr_db,noise_floor_dbm,errors,uptime_s',
    );
    expect(lines[1], endsWith('Z,4100,,,,,60'));
    expect(csv, endsWith('\r\n'));
  });
}
