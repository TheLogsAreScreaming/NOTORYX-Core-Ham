/// How trustworthy the route to a contact looks.
enum RouteHealthGrade {
  /// A route that has been working recently.
  good,

  /// A route that fails often or is long.
  weak,

  /// A route nothing has confirmed in a while; the contact may have moved.
  stale,

  /// No route is known, so messages flood.
  none,
}

/// One reason behind a grade, with its number.
enum RouteReason {
  /// No route; value unused.
  flooding,

  /// Value: hours since the route last worked.
  lastWorked,

  /// Value: failures, [RouteHealth.attempts] tries.
  failures,

  /// Value: days since the contact was last heard.
  notHeard,

  /// Value: hop count.
  longPath,
}

class RouteHealth {
  const RouteHealth(this.grade, this.reasons, {this.attempts = 0});

  final RouteHealthGrade grade;
  final List<(RouteReason, int)> reasons;
  final int attempts;

  /// Whether to warn before sending.
  bool get worthWarning =>
      grade == RouteHealthGrade.weak || grade == RouteHealthGrade.stale;
}

/// Unconfirmed for longer than this, a route is stale.
const routeStaleAfter = Duration(days: 3);

/// More hops than this makes a route weak on its own.
const routeLongHops = 5;

/// Grades the route to a contact.
///
/// [pathLength] is the contact's current route (negative: none, so flood).
/// [lastWorked] is when the route last carried a message (from path
/// history), [successes] and [failures] its record, and [lastHeard] when
/// anything was last heard from the contact.
RouteHealth assessRoute({
  required int pathLength,
  required DateTime? lastWorked,
  required int successes,
  required int failures,
  required DateTime lastHeard,
  required DateTime now,
}) {
  if (pathLength < 0) {
    return const RouteHealth(RouteHealthGrade.none, [
      (RouteReason.flooding, 0),
    ]);
  }
  final reasons = <(RouteReason, int)>[];
  final attempts = successes + failures;
  final heardDays = now.difference(lastHeard).inDays;
  final confirmed = [
    lastWorked,
    lastHeard,
  ].whereType<DateTime>().reduce((a, b) => a.isAfter(b) ? a : b);
  final stale = now.difference(confirmed) >= routeStaleAfter;
  if (lastWorked != null) {
    reasons.add((RouteReason.lastWorked, now.difference(lastWorked).inHours));
  }
  if (heardDays >= 1) reasons.add((RouteReason.notHeard, heardDays));
  final failing = attempts >= 2 && failures > successes;
  if (failures > 0) reasons.add((RouteReason.failures, failures));
  final long = pathLength > routeLongHops;
  if (long) reasons.add((RouteReason.longPath, pathLength));
  final grade = stale
      ? RouteHealthGrade.stale
      : failing || long
      ? RouteHealthGrade.weak
      : RouteHealthGrade.good;
  return RouteHealth(grade, reasons, attempts: attempts);
}
