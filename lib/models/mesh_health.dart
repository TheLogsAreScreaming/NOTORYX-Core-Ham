/// A plain grade, best first. [unknown] means there isn't data to say.
enum HealthGrade { good, fair, poor, unknown }

/// The things the mesh health card grades.
enum HealthFactor { noise, signal, busy, neighbours, delivery }

/// One graded factor, with the number behind it.
class HealthReading {
  const HealthReading(this.factor, this.grade, {this.value, this.of});

  final HealthFactor factor;
  final HealthGrade grade;

  /// The measurement: dBm, dB, percent, a count, or delivered messages.
  final num? value;

  /// For [HealthFactor.delivery]: how many were tried.
  final int? of;
}

/// The inputs, gathered by the caller.
class MeshHealthInputs {
  const MeshHealthInputs({
    this.noiseFloorDbm,
    this.lastSnrDb,
    this.busyFraction,
    required this.neighboursLastHour,
    required this.delivered,
    required this.failed,
  });

  final int? noiseFloorDbm;
  final double? lastSnrDb;

  /// Share of recent time the radio spent sending or receiving, 0–1.
  final double? busyFraction;
  final int neighboursLastHour;

  /// Direct messages in the last day that were acknowledged.
  final int delivered;

  /// Direct messages in the last day that gave up.
  final int failed;
}

/// The overall grade and each factor's reading.
class MeshHealth {
  const MeshHealth(this.overall, this.readings);

  final HealthGrade overall;
  final List<HealthReading> readings;

  /// The worst known factor, which the advice line is about; null if all
  /// are good or unknown.
  HealthReading? get weakest {
    HealthReading? worst;
    for (final r in readings) {
      if (r.grade == HealthGrade.unknown || r.grade == HealthGrade.good) {
        continue;
      }
      if (worst == null || r.grade.index > worst.grade.index) worst = r;
    }
    return worst;
  }
}

/// Fewer tries than this say nothing about delivery.
const minDeliverySample = 3;

HealthGrade _band(
  num? v, {
  required num good,
  required num fair,
  bool lowIsGood = false,
}) {
  if (v == null) return HealthGrade.unknown;
  if (lowIsGood) {
    if (v <= good) return HealthGrade.good;
    if (v <= fair) return HealthGrade.fair;
    return HealthGrade.poor;
  }
  if (v >= good) return HealthGrade.good;
  if (v >= fair) return HealthGrade.fair;
  return HealthGrade.poor;
}

/// Grades the mesh as this radio sees it. The overall grade is the worst
/// known factor, so one real problem isn't averaged away.
MeshHealth assessMeshHealth(MeshHealthInputs i) {
  final tried = i.delivered + i.failed;
  final busyPercent = i.busyFraction == null
      ? null
      : (i.busyFraction!.clamp(0.0, 1.0) * 100).round();
  final readings = [
    HealthReading(
      HealthFactor.noise,
      _band(i.noiseFloorDbm, good: -110, fair: -100, lowIsGood: true),
      value: i.noiseFloorDbm,
    ),
    HealthReading(
      HealthFactor.signal,
      _band(i.lastSnrDb, good: 5, fair: -5),
      value: i.lastSnrDb,
    ),
    HealthReading(
      HealthFactor.busy,
      _band(busyPercent, good: 10, fair: 25, lowIsGood: true),
      value: busyPercent,
    ),
    HealthReading(
      HealthFactor.neighbours,
      _band(i.neighboursLastHour, good: 3, fair: 1),
      value: i.neighboursLastHour,
    ),
    HealthReading(
      HealthFactor.delivery,
      tried < minDeliverySample
          ? HealthGrade.unknown
          : _band(i.delivered / tried, good: 0.8, fair: 0.5),
      value: i.delivered,
      of: tried,
    ),
  ];
  final known = readings.where((r) => r.grade != HealthGrade.unknown);
  final overall = known.isEmpty
      ? HealthGrade.unknown
      : known.map((r) => r.grade).reduce((a, b) => a.index >= b.index ? a : b);
  return MeshHealth(overall, readings);
}

/// Radio airtime counter samples, for how busy the channel has been.
class AirtimeSample {
  const AirtimeSample(this.at, this.airSecs);
  final DateTime at;

  /// Seconds sent plus received since the radio started.
  final int airSecs;
}

/// The share of time between the oldest and newest [samples] within
/// [window] that the radio was on air; null with too little to go on.
double? busyFraction(
  List<AirtimeSample> samples, {
  Duration window = const Duration(minutes: 15),
  Duration minSpan = const Duration(minutes: 2),
}) {
  if (samples.length < 2) return null;
  final newest = samples.last;
  final inWindow = samples
      .where((s) => newest.at.difference(s.at) <= window)
      .toList();
  if (inWindow.length < 2) return null;
  final oldest = inWindow.first;
  final span = newest.at.difference(oldest.at);
  if (span < minSpan) return null;
  final air = newest.airSecs - oldest.airSecs;
  // A radio reboot resets the counters.
  if (air < 0) return null;
  return (air / span.inSeconds).clamp(0.0, 1.0);
}
