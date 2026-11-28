/// When a node counts as stale: not heard (no advert) for a set time.
///
/// This is about how long ago a node was last heard. It is not the
/// route-stale logic in `route_health.dart`, which is about delivery.
library;

/// The "Mark nodes stale after" choices, in hours. 0 is Off.
const staleAfterChoices = [0, 1, 6, 24, 72, 168];

/// The stale threshold for a setting in hours; null when it is Off.
Duration? staleAfterFromHours(int hours) =>
    hours <= 0 ? null : Duration(hours: hours);

/// The earliest last-heard time taken as real. A radio whose clock was
/// never set reports 0 (the epoch) or a time just after it.
final earliestKnownLastHeard = DateTime.utc(2020);

/// How far ahead of [now] a last-heard time may be before it is taken as
/// a wrong clock rather than a small drift.
const maxLastHeardAhead = Duration(days: 1);

/// [lastHeard] when it is a believable time at [now]; null when it is
/// unknown: missing, before 2020 (an unset clock) or more than a day ahead.
DateTime? knownLastHeard(DateTime? lastHeard, DateTime now) {
  if (lastHeard == null) return null;
  if (lastHeard.isBefore(earliestKnownLastHeard)) return null;
  if (lastHeard.isAfter(now.add(maxLastHeardAhead))) return null;
  return lastHeard;
}

/// Whether a node last heard at [lastHeard] is stale at [now].
///
/// A node whose last-heard time is unknown (see [knownLastHeard]) is never
/// stale, and nothing is stale when [after] is null or not positive (the
/// setting is Off). A node heard exactly [after] ago is stale.
bool isStale(DateTime? lastHeard, DateTime now, Duration? after) {
  if (after == null || after <= Duration.zero) return false;
  final known = knownLastHeard(lastHeard, now);
  if (known == null) return false;
  return now.difference(known) >= after;
}
