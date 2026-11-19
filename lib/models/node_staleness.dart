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

/// Whether a node last heard at [lastHeard] is stale at [now].
///
/// A node with no last-heard time ([lastHeard] null, or at or before the
/// epoch, which is how the radio reports "never") is never stale, and
/// nothing is stale when [after] is null or not positive (the setting is
/// Off). A node heard exactly [after] ago is stale.
bool isStale(DateTime? lastHeard, DateTime now, Duration? after) {
  if (after == null || after <= Duration.zero) return false;
  if (lastHeard == null || lastHeard.millisecondsSinceEpoch <= 0) {
    return false;
  }
  return now.difference(lastHeard) >= after;
}
