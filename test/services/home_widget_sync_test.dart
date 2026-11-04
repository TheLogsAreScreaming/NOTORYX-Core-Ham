import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/services/home_widget_sync.dart';

class _Bridge implements HomeWidgetBridge {
  final saved = <String, String>{};
  int updates = 0;
  Uri? launch;
  final clicked = StreamController<Uri?>.broadcast();

  @override
  Future<void> save(String key, String value) async => saved[key] = value;
  @override
  Future<void> update() async => updates++;
  @override
  Future<Uri?> initialLaunch() async => launch;
  @override
  Stream<Uri?> get clicks => clicked.stream;
}

void main() {
  final en = lookupAppLocalizations(const Locale('en'));

  test('widget values follow the radio and the app language', () {
    final off = homeWidgetValues(
      t: en,
      connected: false,
      radioName: null,
      batteryPercent: 80,
      unread: 3,
    );
    expect(off['radio'], 'NOTORYX Core Ham');
    expect(off['status'], en.connections_statusNotConnected);
    expect(off['battery'], '—', reason: 'stale battery is not shown');
    expect(off['unread'], '3');
    final on = homeWidgetValues(
      t: lookupAppLocalizations(const Locale('de')),
      connected: true,
      radioName: 'Trail Lead',
      batteryPercent: 78,
      unread: 0,
    );
    expect(on['radio'], 'Trail Lead');
    expect(on['battery'], '78%');
    expect(on['lbl_checkin'], isNot(en.shortcuts_checkIn));
  });

  test('only notoryx widget links are acted on', () {
    expect(
      homeWidgetActionFor(Uri.parse('notoryx://widget/checkin')),
      HomeWidgetAction.checkIn,
    );
    expect(
      homeWidgetActionFor(Uri.parse('notoryx://widget/sos')),
      HomeWidgetAction.sos,
    );
    expect(
      homeWidgetActionFor(Uri.parse('notoryx://widget/open')),
      HomeWidgetAction.open,
    );
    expect(homeWidgetActionFor(Uri.parse('https://evil.example/sos')), isNull);
    expect(homeWidgetActionFor(null), isNull);
  });

  testWidgets('taps open check-in review or home, never sending', (
    tester,
  ) async {
    final nav = GlobalKey<NavigatorState>();
    final bridge = _Bridge();
    final sync = HomeWidgetSync(
      MeshCoreConnector(),
      nav,
      bridge: bridge,
      screenFor: (s) => Text('screen:${s.name}'),
    );
    await tester.pumpWidget(
      MaterialApp(navigatorKey: nav, home: const Text('home')),
    );
    await sync.start();
    expect(bridge.updates, 1);
    await sync.push();
    expect(bridge.updates, 1, reason: 'unchanged values are not re-sent');

    bridge.clicked.add(Uri.parse('notoryx://widget/checkin'));
    await tester.pumpAndSettle();
    expect(find.text('screen:checkIn'), findsOneWidget);

    bridge.clicked.add(Uri.parse('notoryx://widget/sos'));
    await tester.pumpAndSettle();
    expect(find.text('home'), findsOneWidget);
    expect(find.text('screen:checkIn'), findsNothing);
    sync.dispose();
    await bridge.clicked.close();
  });
}
