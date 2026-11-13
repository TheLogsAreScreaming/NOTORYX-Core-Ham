import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/route_health.dart';
import 'package:meshcore_open/widgets/route_health_banner.dart';
import 'package:provider/provider.dart';

final now = DateTime(2026, 11, 8, 12);

RouteHealth run({
  int hops = 2,
  Duration? workedAgo = const Duration(hours: 2),
  int ok = 4,
  int bad = 0,
  Duration heardAgo = const Duration(hours: 1),
}) => assessRoute(
  pathLength: hops,
  lastWorked: workedAgo == null ? null : now.subtract(workedAgo),
  successes: ok,
  failures: bad,
  lastHeard: now.subtract(heardAgo),
  now: now,
);

void main() {
  test('a recently working route is good', () {
    final h = run();
    expect(h.grade, RouteHealthGrade.good);
    expect(h.worthWarning, isFalse);
  });

  test('no route means flooding', () {
    expect(run(hops: -1).grade, RouteHealthGrade.none);
    expect(run(hops: -1).worthWarning, isFalse);
  });

  test('stale when nothing confirmed it for 3 days', () {
    final h = run(
      workedAgo: const Duration(days: 4),
      heardAgo: const Duration(days: 5),
    );
    expect(h.grade, RouteHealthGrade.stale);
    expect(h.worthWarning, isTrue);
    expect(h.reasons, contains((RouteReason.notHeard, 5)));
  });

  test('hearing the contact recently keeps an old route fresh', () {
    expect(
      run(workedAgo: const Duration(days: 6)).grade,
      RouteHealthGrade.good,
    );
  });

  test('weak when it fails more than it works', () {
    final h = run(ok: 1, bad: 3);
    expect(h.grade, RouteHealthGrade.weak);
    expect(h.reasons, contains((RouteReason.failures, 3)));
    expect(h.attempts, 4);
    expect(
      run(ok: 0, bad: 1).grade,
      RouteHealthGrade.good,
      reason: 'one failure is not a pattern',
    );
  });

  test('weak when longer than 5 hops', () {
    expect(run(hops: 6).grade, RouteHealthGrade.weak);
    expect(run(hops: 5).grade, RouteHealthGrade.good);
  });

  testWidgets('the banner warns on a stale route and offers a new one', (
    tester,
  ) async {
    final radio = MeshCoreConnector();
    final stale = Contact(
      publicKey: Uint8List.fromList(List.filled(32, 7)),
      name: 'Sam',
      type: advTypeChat,
      pathLength: 2,
      path: Uint8List.fromList([1, 2]),
      lastSeen: DateTime.now().subtract(const Duration(days: 5)),
    );
    await tester.pumpWidget(
      ChangeNotifierProvider<MeshCoreConnector>.value(
        value: radio,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: RouteHealthBanner(contact: stale)),
        ),
      ),
    );
    expect(find.text('The route to Sam may be out of date'), findsOneWidget);
    expect(find.textContaining('not heard from in 5 days'), findsOneWidget);
    expect(find.text('Find a new route'), findsOneWidget);
    await tester.tap(find.text('Keep this route'));
    await tester.pump();
    expect(find.byKey(const ValueKey('route-health-banner')), findsNothing);
    radio.dispose();
  });

  testWidgets('no banner for a good route', (tester) async {
    final radio = MeshCoreConnector();
    final fine = Contact(
      publicKey: Uint8List.fromList(List.filled(32, 8)),
      name: 'Alex',
      type: advTypeChat,
      pathLength: 1,
      path: Uint8List.fromList([3]),
      lastSeen: DateTime.now(),
    );
    await tester.pumpWidget(
      ChangeNotifierProvider<MeshCoreConnector>.value(
        value: radio,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: RouteHealthBanner(contact: fine)),
        ),
      ),
    );
    expect(find.byKey(const ValueKey('route-health-banner')), findsNothing);
    radio.dispose();
  });
}
