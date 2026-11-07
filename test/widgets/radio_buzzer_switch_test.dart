import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/widgets/radio_buzzer_switch.dart';

Widget _app(Future<String> Function(String) run) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(body: RadioBuzzerSwitch(run: run)),
);

void main() {
  testWidgets('shows the buzzer state and turns it off', (tester) async {
    final sent = <String>[];
    var state = 'on';
    await tester.pumpWidget(
      _app((cmd) async {
        sent.add(cmd);
        if (cmd == 'get buzzer') return '> $state';
        state = cmd.endsWith('off') ? 'off' : 'on';
        return 'OK';
      }),
    );
    await tester.pumpAndSettle();
    final sw = find.byKey(const ValueKey('radio-buzzer'));
    expect(tester.widget<SwitchListTile>(sw).value, isTrue);
    await tester.tap(sw);
    await tester.pumpAndSettle();
    expect(sent.last, 'set buzzer off');
    expect(tester.widget<SwitchListTile>(sw).value, isFalse);
  });

  testWidgets('stays hidden on a radio without a buzzer', (tester) async {
    await tester.pumpWidget(_app((cmd) async => 'Unknown command'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('radio-buzzer')), findsNothing);
  });

  testWidgets('a refused change flips back and says so', (tester) async {
    await tester.pumpWidget(
      _app((cmd) async => cmd == 'get buzzer' ? '> off' : 'Error'),
    );
    await tester.pumpAndSettle();
    final sw = find.byKey(const ValueKey('radio-buzzer'));
    await tester.tap(sw);
    await tester.pumpAndSettle();
    expect(tester.widget<SwitchListTile>(sw).value, isFalse);
    expect(find.textContaining("didn't accept"), findsOneWidget);
  });
}
