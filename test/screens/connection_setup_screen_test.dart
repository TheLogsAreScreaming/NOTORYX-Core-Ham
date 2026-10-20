import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/screens/connection_setup_screen.dart';

void main() {
  Future<void> open(
    WidgetTester tester, {
    bool bluetooth = true,
    bool usb = true,
    ValueChanged<SetupConnection?>? onResult,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async {
                final result = await Navigator.of(context)
                    .push<SetupConnection>(
                      MaterialPageRoute(
                        builder: (_) => ConnectionSetupScreen(
                          supportsBluetooth: bluetooth,
                          supportsUsb: usb,
                        ),
                      ),
                    );
                onResult?.call(result);
              },
              child: const Text('Start'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
  }

  for (final choice in SetupConnection.values) {
    testWidgets('returns $choice only after preparation', (tester) async {
      SetupConnection? result;
      await open(tester, onResult: (value) => result = value);
      final icon = choice == SetupConnection.bluetooth
          ? Icons.bluetooth
          : Icons.usb;
      await tester.tap(find.byIcon(icon));
      await tester.pumpAndSettle();
      expect(result, isNull);
      expect(
        find.text('Check compatibility before changing firmware'),
        findsOneWidget,
      );
      await tester.ensureVisible(find.byType(FilledButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();
      expect(result, choice);
    });
  }

  testWidgets('unsupported connections stay disabled', (tester) async {
    await open(tester, bluetooth: false, usb: false);
    for (final tile in tester.widgetList<ListTile>(find.byType(ListTile))) {
      expect(tile.enabled, isFalse);
      expect(tile.onTap, isNull);
    }
    expect(find.byType(FilledButton), findsNothing);
    await tester.tap(find.text('Set up later'));
    await tester.pumpAndSettle();
    expect(find.text('Start'), findsOneWidget);
  });

  testWidgets('can change connection and cancel without connecting', (
    tester,
  ) async {
    var returned = false;
    SetupConnection? result;
    await open(
      tester,
      onResult: (value) {
        returned = true;
        result = value;
      },
    );
    await tester.tap(find.byIcon(Icons.bluetooth));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Change connection type'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Change connection type'));
    await tester.pumpAndSettle();
    expect(find.text('1. Choose a connection'), findsOneWidget);
    expect(returned, isFalse);
    await tester.ensureVisible(find.text('Set up later'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Set up later'));
    await tester.pumpAndSettle();
    expect(returned, isTrue);
    expect(result, isNull);
  });

  testWidgets('small screen and large text keep connection action reachable', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    SetupConnection? result;
    await open(tester, onResult: (value) => result = value);
    await tester.scrollUntilVisible(find.byIcon(Icons.usb), 200);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.usb));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.byType(FilledButton), 200);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();
    expect(result, SetupConnection.usb);
  });
}
