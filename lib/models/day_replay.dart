/// One place a node was at one time.
class ReplayPoint {
  const ReplayPoint(this.at, this.lat, this.lon);

  factory ReplayPoint.fromJson(List<dynamic> j) => ReplayPoint(
    DateTime.fromMillisecondsSinceEpoch(j[0] as int),
    (j[1] as num).toDouble(),
    (j[2] as num).toDouble(),
  );

  final DateTime at;
  final double lat;
  final double lon;

  List<dynamic> toJson() => [
    at.millisecondsSinceEpoch,
    double.parse(lat.toStringAsFixed(5)),
    double.parse(lon.toStringAsFixed(5)),
  ];
}

/// Where one node went, oldest point first.
class ReplayTrack {
  const ReplayTrack({
    required this.id,
    required this.name,
    required this.points,
    this.team = false,
  });

  final String id;
  final String name;

  /// From the team's own position posts rather than node adverts.
  final bool team;
  final List<ReplayPoint> points;

  /// The newest point at or before [t], or null when there is none yet.
  ReplayPoint? at(DateTime t) {
    var lo = 0, hi = points.length - 1, found = -1;
    while (lo <= hi) {
      final mid = (lo + hi) ~/ 2;
      if (!points[mid].at.isAfter(t)) {
        found = mid;
        lo = mid + 1;
      } else {
        hi = mid - 1;
      }
    }
    return found < 0 ? null : points[found];
  }

  /// Every point up to and including [t].
  List<ReplayPoint> trailUntil(DateTime t) =>
      points.takeWhile((p) => !p.at.isAfter(t)).toList();

  /// The part of this track that falls on [day] (local midnight).
  ReplayTrack? onDay(DateTime day) {
    final start = DateTime(day.year, day.month, day.day);
    final end = DateTime(day.year, day.month, day.day + 1);
    final kept = points
        .where((p) => !p.at.isBefore(start) && p.at.isBefore(end))
        .toList();
    if (kept.isEmpty) return null;
    return ReplayTrack(id: id, name: name, team: team, points: kept);
  }
}

/// Local midnight of each day that has at least one point, newest first.
List<DateTime> replayDays(Iterable<ReplayTrack> tracks) {
  final days = <DateTime>{
    for (final t in tracks)
      for (final p in t.points) DateTime(p.at.year, p.at.month, p.at.day),
  }.toList()..sort((a, b) => b.compareTo(a));
  return days;
}

/// The first and last time any of [tracks] has a point.
({DateTime start, DateTime end})? replaySpan(List<ReplayTrack> tracks) {
  DateTime? start, end;
  for (final t in tracks) {
    if (t.points.isEmpty) continue;
    final first = t.points.first.at, last = t.points.last.at;
    if (start == null || first.isBefore(start)) start = first;
    if (end == null || last.isAfter(end)) end = last;
  }
  if (start == null || end == null) return null;
  return (start: start, end: end);
}

/// Builds team tracks from position posts: (sender, latitude, longitude,
/// time), one track per sender.
List<ReplayTrack> teamTracks(
  Iterable<({String sender, double lat, double lon, DateTime at})> posts,
) {
  final bySender = <String, List<ReplayPoint>>{};
  for (final p in posts) {
    (bySender[p.sender] ??= []).add(ReplayPoint(p.at, p.lat, p.lon));
  }
  return [
    for (final e in bySender.entries)
      ReplayTrack(
        id: 'team:${e.key}',
        name: e.key,
        team: true,
        points: e.value..sort((a, b) => a.at.compareTo(b.at)),
      ),
  ];
}
