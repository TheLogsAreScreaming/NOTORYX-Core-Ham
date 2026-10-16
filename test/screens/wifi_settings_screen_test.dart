import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/screens/companion_cli_screen.dart';
import 'package:meshcore_open/screens/wifi_settings_screen.dart';
import 'package:provider/provider.dart';

class _Cli {
  _Cli(this.replies);

  final Map<String, String> replies;
  final List<String> commands = [];

  Future<String> call(String command) async {
    commands.add(command);
    final reply = replies[command];
    if (reply != null) return reply;
    if (command.startsWith('set wifi.')) return '> ok (reboot to apply)';
    if (command == 'reboot') return Completer<String>().future;
    return 'Unknown command';
  }
}

Widget _app(Widget home) => ChangeNotifierProvider<MeshCoreConnector>(
  create: (_) => MeshCoreConnector(),
  child: MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  ),
);

final _wifiBoard = {
  'get wifi.enabled': '> 1',
  'get wifi.ssid': '> Basecamp',
  'get wifi.status': '> connected',
  'get wifi.ip': '> 192.168.4.20',
};

void main() {
  testWidgets('boards without WiFi say so', (tester) async {
    final cli = _Cli({});
    await tester.pumpWidget(_app(WifiSettingsScreen(run: cli.call)));
    await tester.pumpAndSettle();

    expect(find.textContaining("doesn't include WiFi"), findsOneWidget);
    expect(cli.commands, ['get wifi.enabled']);
  });

  testWidgets('shows the current network and status', (tester) async {
    final cli = _Cli(_wifiBoard);
    await tester.pumpWidget(_app(WifiSettingsScreen(run: cli.call)));
    await tester.pumpAndSettle();

    expect(find.text('Basecamp'), findsOneWidget);
    expect(find.text('Connected · 192.168.4.20'), findsOneWidget);
    // Nothing changed yet, so Save is disabled; the password is never read.
    expect(
      tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Save'))
          .onPressed,
      isNull,
    );
    expect(cli.commands, isNot(contains('get wifi.pwd')));
  });

  testWidgets('saves only what changed, then offers a restart', (tester) async {
    final cli = _Cli(_wifiBoard);
    await tester.pumpWidget(_app(WifiSettingsScreen(run: cli.call)));
    await tester.pumpAndSettle();
    cli.commands.clear();

    await tester.enterText(
      find.widgetWithText(TextField, 'Basecamp'),
      'Ridge Hut',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Password'),
      'secret pass',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    expect(cli.commands, [
      'set wifi.ssid Ridge Hut',
      'set wifi.pwd secret pass',
    ]);
    expect(find.textContaining('Restart the radio to apply'), findsOneWidget);

    await tester.tap(find.widgetWithText(TextButton, 'Restart radio'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Restart radio'));
    await tester.pump();
    expect(cli.commands.last, 'reboot');
  });

  testWidgets('command line shows replies and missing replies', (tester) async {
    Future<String> run(String command) async {
      if (command == 'reboot') throw TimeoutException('no reply');
      return 'v1.18.0 (Build: 15-Oct-2026)';
    }

    await tester.pumpWidget(_app(CompanionCliScreen(run: run)));
    await tester.tap(find.widgetWithText(ActionChip, 'ver'));
    await tester.pumpAndSettle();
    expect(find.text('v1.18.0 (Build: 15-Oct-2026)'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'reboot');
    await tester.testTextInput.receiveAction(TextInputAction.send);
    await tester.pumpAndSettle();
    expect(find.textContaining('No reply'), findsOneWidget);
  });
}
