import 'repeater_status_history.dart';

/// A summary of one repeater over the kept history (up to 30 days), built
/// only from status checks and neighbour lists the user already asked for.
class RepeaterReportCard {
  const RepeaterReportCard({
    required this.checks,
    required this.span,
    required this.restarts,
    required this.longestUptimeSecs,
    required this.batteryNowMv,
    required this.batteryLowMv,
    required this.batteryMvPerWeek,
    required this.noiseAvg,
    required this.noiseWorst,
    required this.newErrors,
    required this.neighboursHeard,
    required this.neighboursNew,
    required this.neighboursGone,
  });

  /// Status checks kept.
  final int checks;

  /// Time between the first and last kept check.
  final Duration span;

  /// Times the uptime went backwards between two checks.
  final int restarts;
  final int? longestUptimeSecs;
  final int? batteryNowMv;
  final int? batteryLowMv;

  /// Battery change per week, first to last reading; null with less than a
  /// day between them.
  final double? batteryMvPerWeek;
  final double? noiseAvg;
  final int? noiseWorst;

  /// Errors counted since the first check, added up across restarts.
  final int? newErrors;
  final int neighboursHeard;

  /// Neighbours first heard in the last [recent].
  final int neighboursNew;

  /// Neighbours not heard in the last [recent].
  final int neighboursGone;

  static const recent = Duration(days: 7);

  bool get isEmpty => checks == 0 && neighboursHeard == 0;

  factory RepeaterReportCard.from({
    required List<StatusSample> samples,
    required Map<String, List<SnrSample>> neighbours,
    required DateTime now,
  }) {
    var restarts = 0;
    int? lastUptime, longest, lastErrors, errors;
    for (final s in samples) {
      final up = s.uptimeSecs;
      if (up != null) {
        if (lastUptime != null && up < lastUptime) restarts++;
        lastUptime = up;
        if (longest == null || up > longest) longest = up;
      }
      final e = s.errors;
      if (e != null) {
        if (lastErrors != null) {
          // A restart resets the counter: count what it reached since.
          errors = (errors ?? 0) + (e >= lastErrors ? e - lastErrors : e);
        } else {
          errors = 0;
        }
        lastErrors = e;
      }
    }

    final battery = [
      for (final s in samples)
        if (s.batteryMv case final mv?) (at: s.at, mv: mv),
    ];
    double? perWeek;
    if (battery.length >= 2) {
      final dt = battery.last.at.difference(battery.first.at);
      if (dt >= const Duration(days: 1)) {
        perWeek =
            (battery.last.mv - battery.first.mv) /
            (dt.inMinutes / const Duration(days: 7).inMinutes);
      }
    }

    final noise = [for (final s in samples) ?s.noiseFloor];

    final since = now.subtract(recent);
    var fresh = 0, gone = 0;
    for (final list in neighbours.values) {
      if (list.isEmpty) continue;
      var first = list.first.at, last = list.first.at;
      for (final r in list) {
        if (r.at.isBefore(first)) first = r.at;
        if (r.at.isAfter(last)) last = r.at;
      }
      if (first.isAfter(since)) fresh++;
      if (last.isBefore(since)) gone++;
    }

    return RepeaterReportCard(
      checks: samples.length,
      span: samples.length < 2
          ? Duration.zero
          : samples.last.at.difference(samples.first.at),
      restarts: restarts,
      longestUptimeSecs: longest,
      batteryNowMv: battery.isEmpty ? null : battery.last.mv,
      batteryLowMv: battery.isEmpty
          ? null
          : battery.map((b) => b.mv).reduce((a, b) => a < b ? a : b),
      batteryMvPerWeek: perWeek,
      noiseAvg: noise.isEmpty
          ? null
          : noise.reduce((a, b) => a + b) / noise.length,
      noiseWorst: noise.isEmpty ? null : noise.reduce((a, b) => a > b ? a : b),
      newErrors: errors,
      neighboursHeard: neighbours.values.where((l) => l.isNotEmpty).length,
      neighboursNew: fresh,
      neighboursGone: gone,
    );
  }
}

/// The kept status checks as CSV (RFC 4180), one row per check, for a
/// spreadsheet. Times are UTC ISO-8601; empty cells mean not reported.
String statusSamplesCsv(List<StatusSample> samples) {
  final rows = <String>[
    'time_utc,battery_mv,rssi_dbm,snr_db,noise_floor_dbm,errors,uptime_s',
    for (final s in samples)
      [
        s.at.toUtc().toIso8601String(),
        s.batteryMv ?? '',
        s.rssi ?? '',
        s.snr ?? '',
        s.noiseFloor ?? '',
        s.errors ?? '',
        s.uptimeSecs ?? '',
      ].join(','),
  ];
  return '${rows.join('\r\n')}\r\n';
}
