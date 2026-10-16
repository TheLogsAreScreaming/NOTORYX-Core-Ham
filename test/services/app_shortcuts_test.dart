import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:meshcore_open/screens/bastion_field_ops_screen.dart';
import 'package:meshcore_open/services/app_shortcuts.dart';

class _FakeActions extends QuickActions {
  QuickActionHandler? handler;
  List<ShortcutItem> items = [];
  @override
  Future<void> initialize(QuickActionHandler handler) async =>
      this.handler = handler;
  @override
  Future<void> setShortcutItems(List<ShortcutItem> items) async =>
      this.items = items;
}

void main() {
  test('shortcut types round-trip and check in reviews before sending', () {
    for (final s in AppShortcut.values) {
      expect(AppShortcut.fromType(s.type), s);
    }
    expect(AppShortcut.fromType('nope'), isNull);
    final checkIn = shortcutScreen(AppShortcut.checkIn);
    expect(checkIn, isA<BastionFieldOpsScreen>());
    expect((checkIn as BastionFieldOpsScreen).initialCheckIn, isTrue);
    expect(
      (shortcutScreen(AppShortcut.trip) as BastionFieldOpsScreen)
          .initialCheckIn,
      isFalse,
    );
  });

  testWidgets('installs four shortcuts and opens the chosen screen on top', (
    tester,
  ) async {
    final nav = GlobalKey<NavigatorState>();
    final actions = _FakeActions();
    final shortcuts = AppShortcuts(
      nav,
      actions: actions,
      screenFor: (s) => Text('screen:${s.name}'),
    );
    await shortcuts.install();
    expect(actions.items.map((i) => i.localizedTitle), [
      'Check in',
      'Trip',
      'Chats',
      'Map',
    ]);

    // Used before the app has a navigator (a cold start): waits a frame.
    actions.handler!('bastion.map');
    await tester.pumpWidget(
      MaterialApp(navigatorKey: nav, home: const Text('home')),
    );
    await tester.pumpAndSettle();
    expect(find.text('screen:map'), findsOneWidget);

    // A second shortcut replaces the first rather than stacking up.
    actions.handler!('bastion.trip');
    await tester.pumpAndSettle();
    expect(find.text('screen:trip'), findsOneWidget);
    expect(find.text('screen:map'), findsNothing);
    nav.currentState!.pop();
    await tester.pumpAndSettle();
    expect(find.text('home'), findsOneWidget);
  });
}
