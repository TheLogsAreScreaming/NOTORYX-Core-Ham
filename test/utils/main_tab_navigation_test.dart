import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/utils/main_tab_navigation.dart';

/// A stand-in tab screen with buttons that switch tabs like the bar does.
class _Tab extends StatelessWidget {
  final MainTab tab;
  const _Tab(this.tab);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      children: [
        Text('screen:${tab.name}'),
        for (final t in MainTab.values)
          TextButton(
            onPressed: () =>
                switchMainTab(context, t, from: tab, screenFor: _Tab.new),
            child: Text('go:${t.name}'),
          ),
      ],
    ),
  );
}

void main() {
  Future<void> go(WidgetTester tester, MainTab t) async {
    await tester.tap(find.text('go:${t.name}').last);
    await tester.pumpAndSettle();
  }

  testWidgets('home is first in the bar order', (tester) async {
    expect(MainTab.values.first, MainTab.home);
  });

  testWidgets('after connecting, HOME gets back to the Field Console', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: _Tab(MainTab.home)));
    // Connecting lands on Chats on top of home.
    await go(tester, MainTab.chats);
    expect(find.text('screen:chats'), findsOneWidget);
    // Hopping between tabs replaces the tab, keeping home underneath.
    await go(tester, MainTab.nodes);
    await go(tester, MainTab.map);
    await go(tester, MainTab.more);
    expect(find.text('screen:more'), findsOneWidget);

    await go(tester, MainTab.home);
    expect(find.text('screen:home'), findsOneWidget);
    expect(find.text('screen:map'), findsNothing);

    // From home a tab opens on top again rather than replacing home.
    await go(tester, MainTab.nodes);
    expect(find.text('screen:nodes'), findsOneWidget);
    await go(tester, MainTab.home);
    expect(find.text('screen:home'), findsOneWidget);
  });
}
