import 'dart:math' as math;

import '../helpers/path_helper.dart';
import 'path_history.dart';

/// The id of this radio in link keys.
const routeSelfId = 'ME';

/// What is known about one radio link, in both directions.
class RouteLink {
  const RouteLink({this.snrOut, this.snrBack, required this.at});

  factory RouteLink.fromJson(Map<String, dynamic> j) => RouteLink(
    snrOut: (j['o'] as num?)?.toDouble(),
    snrBack: (j['b'] as num?)?.toDouble(),
    at: DateTime.fromMillisecondsSinceEpoch(j['t'] as int),
  );

  /// SNR (dB) the far end heard the near end at.
  final double? snrOut;

  /// SNR (dB) the near end heard the far end at.
  final double? snrBack;
  final DateTime at;

  /// The weaker known direction.
  double? get weaker {
    final o = snrOut, b = snrBack;
    if (o == null) return b;
    if (b == null) return o;
    return math.min(o, b);
  }

  Map<String, dynamic> toJson() => {
    if (snrOut != null) 'o': snrOut,
    if (snrBack != null) 'b': snrBack,
    't': at.millisecondsSinceEpoch,
  };
}

/// Key for the link from [from] to [to] (hop ids as upper-case hex, or
/// [routeSelfId]).
String routeLinkKey(String from, String to) => '$from>$to';

/// Reads the links an out-and-back trace measured.
///
/// The trace went through [hops] and back again, so it carries
/// `2 * hops` SNR readings: each hop on the way out, each on the way back,
/// and finally this radio. Returns one link per hop, from the previous
/// node (this radio for the first) to that hop.
List<({String from, String to, RouteLink link})> linksFromRoundTrip(
  List<String> hops,
  List<double> snrs,
  DateTime at,
) {
  final n = hops.length;
  if (n == 0 || snrs.length < 2 * n) return const [];
  return [
    for (var k = 1; k <= n; k++)
      (
        from: k == 1 ? routeSelfId : hops[k - 2],
        to: hops[k - 1],
        link: RouteLink(snrOut: snrs[k - 1], snrBack: snrs[2 * n - k], at: at),
      ),
  ];
}

/// The trace payload that goes out through [path] and comes back the same
/// way: `h1 … hn … h1`.
List<int> roundTripTracePath(List<int> path, int width) {
  final hops = PathHelper.splitPathBytes(path, width);
  return [
    for (final h in hops) ...h,
    for (final h in hops.reversed.skip(1)) ...h,
  ];
}

/// One hop of a route as the chart shows it.
class RouteHop {
  const RouteHop({required this.id, this.name, this.link});

  /// The hop's key prefix as upper-case hex.
  final String id;
  final String? name;

  /// The link into this hop from the one before, if measured.
  final RouteLink? link;
}

/// A route to a contact that the user can choose.
class RouteOption {
  const RouteOption({
    required this.pathBytes,
    required this.hops,
    required this.score,
    this.successes = 0,
    this.failures = 0,
    this.lastUsed,
    this.isCurrent = false,
  });

  final List<int> pathBytes;
  final List<RouteHop> hops;

  /// 0–100, higher is more reliable.
  final int score;
  final int successes;
  final int failures;
  final DateTime? lastUsed;
  final bool isCurrent;

  bool get isDirect => hops.isEmpty;
  int get attempts => successes + failures;

  /// The weakest measured link, or null when none is measured.
  double? get weakestSnr {
    double? weakest;
    for (final h in hops) {
      final w = h.link?.weaker;
      if (w != null && (weakest == null || w < weakest)) weakest = w;
    }
    return weakest;
  }

  int get unmeasuredLinks => hops.where((h) => h.link?.weaker == null).length;
}

/// Scores a route from 0 to 100.
///
/// - Links (40): the weakest measured link, -15 dB → 0, +10 dB → 40; 20
///   when nothing is measured. Each unmeasured link costs 3.
/// - Record (30): share of messages that got through on it; 15 untried.
/// - Length (20): 20, less 3 per hop.
/// - Recency (10): used in the last day 10, last week 5.
int scoreRoute({
  required int hops,
  double? weakestSnr,
  int unmeasuredLinks = 0,
  int successes = 0,
  int failures = 0,
  DateTime? lastUsed,
  required DateTime now,
}) {
  final links = weakestSnr == null
      ? 20.0
      : ((weakestSnr + 15) / 25).clamp(0.0, 1.0) * 40;
  final attempts = successes + failures;
  final record = attempts == 0 ? 15.0 : 30.0 * successes / attempts;
  final length = math.max(0, 20 - 3 * hops).toDouble();
  final age = lastUsed == null ? null : now.difference(lastUsed);
  final recency = age == null
      ? 0.0
      : age <= const Duration(days: 1)
      ? 10.0
      : age <= const Duration(days: 7)
      ? 5.0
      : 0.0;
  final total = links - 3 * unmeasuredLinks + record + length + recency;
  return total.round().clamp(0, 100);
}

/// Builds the routes to offer for one contact: the current one and every
/// distinct path heard for it, best first.
List<RouteOption> buildRouteOptions({
  required List<int>? currentPath,
  required List<PathRecord> history,
  required int width,
  required Map<String, RouteLink> links,
  required String? Function(String hopId) nameOf,
  required DateTime now,
}) {
  final byPath = <String, ({List<int> bytes, int ok, int bad, DateTime? at})>{};
  void add(List<int> bytes, int ok, int bad, DateTime? at) {
    final key = PathHelper.formatHopHex(bytes);
    final old = byPath[key];
    if (old == null) {
      byPath[key] = (bytes: bytes, ok: ok, bad: bad, at: at);
      return;
    }
    final latest = old.at == null || (at != null && at.isAfter(old.at!))
        ? at
        : old.at;
    byPath[key] = (
      bytes: bytes,
      ok: old.ok + ok,
      bad: old.bad + bad,
      at: latest,
    );
  }

  for (final r in history) {
    if (r.pathBytes.length % width != 0) continue;
    add(r.pathBytes, r.successCount, r.failureCount, r.timestamp);
  }
  if (currentPath != null) add(currentPath, 0, 0, null);
  final currentKey = currentPath == null
      ? null
      : PathHelper.formatHopHex(currentPath);

  final options = [
    for (final entry in byPath.entries)
      _option(
        entry.value.bytes,
        width: width,
        links: links,
        nameOf: nameOf,
        ok: entry.value.ok,
        bad: entry.value.bad,
        at: entry.value.at,
        isCurrent: entry.key == currentKey,
        now: now,
      ),
  ];
  options.sort((a, b) {
    final byScore = b.score.compareTo(a.score);
    if (byScore != 0) return byScore;
    return a.hops.length.compareTo(b.hops.length);
  });
  return options;
}

/// The hops of [path] with what is known about each link.
List<RouteHop> routeHops(
  List<int> path, {
  required int width,
  required Map<String, RouteLink> links,
  required String? Function(String hopId) nameOf,
}) {
  final ids = [
    for (final h in PathHelper.splitPathBytes(path, width))
      PathHelper.formatHopHex(h),
  ];
  return [
    for (var i = 0; i < ids.length; i++)
      RouteHop(
        id: ids[i],
        name: nameOf(ids[i]),
        link: links[routeLinkKey(i == 0 ? routeSelfId : ids[i - 1], ids[i])],
      ),
  ];
}

RouteOption _option(
  List<int> bytes, {
  required int width,
  required Map<String, RouteLink> links,
  required String? Function(String hopId) nameOf,
  required int ok,
  required int bad,
  required DateTime? at,
  required bool isCurrent,
  required DateTime now,
}) {
  final hops = routeHops(bytes, width: width, links: links, nameOf: nameOf);
  final draft = RouteOption(pathBytes: bytes, hops: hops, score: 0);
  return RouteOption(
    pathBytes: bytes,
    hops: hops,
    successes: ok,
    failures: bad,
    lastUsed: at,
    isCurrent: isCurrent,
    score: scoreRoute(
      hops: hops.length,
      weakestSnr: draft.weakestSnr,
      unmeasuredLinks: draft.unmeasuredLinks,
      successes: ok,
      failures: bad,
      lastUsed: at,
      now: now,
    ),
  );
}

/// The option worth suggesting instead of the current route: the best one,
/// when it beats the current route by at least [margin] points (or there
/// is no current route).
RouteOption? suggestRoute(List<RouteOption> options, {int margin = 10}) {
  if (options.isEmpty) return null;
  final best = options.first;
  if (best.isCurrent) return null;
  final current = options.where((o) => o.isCurrent).firstOrNull;
  if (current == null) return best;
  return best.score - current.score >= margin ? best : null;
}
