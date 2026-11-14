import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/path_history.dart';
import 'package:meshcore_open/models/route_choice.dart';

final _now = DateTime(2026, 11, 13, 12);

PathRecord _rec(
  List<int> bytes,
  int ok,
  int bad, {
  Duration ago = Duration.zero,
}) => PathRecord(
  hopCount: bytes.length,
  tripTimeMs: 1000,
  timestamp: _now.subtract(ago),
  wasFloodDiscovery: false,
  pathBytes: bytes,
  successCount: ok,
  failureCount: bad,
);

void main() {
  test('round-trip trace path goes out and back', () {
    expect(roundTripTracePath([0xA1, 0xB2, 0xC3], 1), [
      0xA1,
      0xB2,
      0xC3,
      0xB2,
      0xA1,
    ]);
    expect(roundTripTracePath([1, 2, 3, 4], 2), [1, 2, 3, 4, 1, 2]);
  });

  test('a round-trip trace gives each link both ways', () {
    // Out: me→A 4, A→B 3, B→C 2; back: C→B -1, B→A -2, A→me -3.
    final links = linksFromRoundTrip(
      ['A', 'B', 'C'],
      [4, 3, 2, -1, -2, -3],
      _now,
    );
    expect(links.map((l) => '${l.from}>${l.to}'), ['ME>A', 'A>B', 'B>C']);
    expect(links[0].link.snrOut, 4);
    expect(links[0].link.snrBack, -3);
    expect(links[2].link.snrOut, 2);
    expect(links[2].link.snrBack, -1);
    expect(links[1].link.weaker, -2);
    expect(linksFromRoundTrip(['A', 'B'], [1, 2], _now), isEmpty);
  });

  test('scores favour strong links, a good record and few hops', () {
    final strong = scoreRoute(hops: 2, weakestSnr: 8, successes: 4, now: _now);
    final weak = scoreRoute(hops: 2, weakestSnr: -12, successes: 4, now: _now);
    final failing = scoreRoute(hops: 2, weakestSnr: 8, failures: 4, now: _now);
    final long = scoreRoute(hops: 6, weakestSnr: 8, successes: 4, now: _now);
    expect(strong, greaterThan(weak));
    expect(strong, greaterThan(failing));
    expect(strong, greaterThan(long));
    expect(
      scoreRoute(
        hops: 0,
        weakestSnr: 30,
        successes: 9,
        lastUsed: _now,
        now: _now,
      ),
      100,
    );
  });

  test('options merge duplicates, mark the current one and suggest', () {
    final links = {
      routeLinkKey(routeSelfId, 'AA'): RouteLink(
        snrOut: 9,
        snrBack: 8,
        at: _now,
      ),
      routeLinkKey('AA', 'BB'): RouteLink(snrOut: 7, snrBack: 6, at: _now),
      routeLinkKey(routeSelfId, 'CC'): RouteLink(
        snrOut: -14,
        snrBack: -13,
        at: _now,
      ),
    };
    final options = buildRouteOptions(
      currentPath: [0xCC],
      history: [
        _rec([0xCC], 1, 3),
        _rec([0xAA, 0xBB], 3, 0),
        _rec([0xAA, 0xBB], 2, 0, ago: const Duration(days: 2)),
      ],
      width: 1,
      links: links,
      nameOf: (id) => id == 'AA' ? 'Hilltop' : null,
      now: _now,
    );
    expect(options, hasLength(2));
    expect(options.first.pathBytes, [0xAA, 0xBB]);
    expect(options.first.successes, 5);
    expect(options.first.hops.first.name, 'Hilltop');
    expect(options.first.weakestSnr, 6);
    expect(options.last.isCurrent, isTrue);
    expect(suggestRoute(options), same(options.first));
  });

  test('no suggestion when the current route is close to the best', () {
    final options = buildRouteOptions(
      currentPath: [0xAA],
      history: [
        _rec([0xAA], 3, 0),
        _rec([0xBB], 3, 0),
      ],
      width: 1,
      links: const {},
      nameOf: (_) => null,
      now: _now,
    );
    expect(suggestRoute(options), isNull);
  });

  test('link readings survive a save and load', () {
    final link = RouteLink(snrOut: 1.25, snrBack: -2.5, at: _now);
    final back = RouteLink.fromJson(link.toJson());
    expect(back.snrOut, 1.25);
    expect(back.snrBack, -2.5);
    expect(back.at, _now);
  });
}
