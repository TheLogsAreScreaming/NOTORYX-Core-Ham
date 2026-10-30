import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/screens/bastion_tools_screen.dart';
import 'package:meshcore_open/screens/field_guide_screen.dart';

Future<void> _pump(WidgetTester tester, {double textScale = 1}) async {
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(textScaler: TextScaler.linear(textScale)),
        child: child!,
      ),
      home: const BastionToolsScreen(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('search ignores case and edge whitespace and clears', (
    tester,
  ) async {
    await _pump(tester);
    await tester.enterText(
      find.byKey(const ValueKey('tools-search')),
      '  BACKUP  ',
    );
    await tester.pumpAndSettle();
    expect(find.text('Encrypted backup'), findsOneWidget);
    expect(find.text('Settings'), findsNothing);
    expect(find.text('In the field'), findsNothing);
    await tester.tap(find.byTooltip('Clear'));
    await tester.pumpAndSettle();
    expect(find.text('Settings'), findsOneWidget);
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      isEmpty,
    );
  });

  testWidgets('search includes descriptions and shows empty state', (
    tester,
  ) async {
    await _pump(tester);
    await tester.enterText(find.byType(TextField), 'optional chat history');
    await tester.pumpAndSettle();
    expect(find.text('Encrypted backup'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'no-such-tool-xyz');
    await tester.pumpAndSettle();
    expect(find.text('No tools match your search.'), findsOneWidget);
    expect(find.text('App & settings'), findsNothing);
    await tester.tap(find.byTooltip('Clear'));
    await tester.pumpAndSettle();
    expect(find.text('No tools match your search.'), findsNothing);
  });

  testWidgets('filtered action opens its original route and retains query', (
    tester,
  ) async {
    await _pump(tester);
    await tester.enterText(find.byType(TextField), 'Field guide');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Field guide'));
    await tester.pumpAndSettle();
    expect(find.byType(FieldGuideScreen), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      'Field guide',
    );
    expect(find.text('Settings'), findsNothing);
  });

  testWidgets('search results fit narrow screens with large text', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await _pump(tester, textScale: 2);
    await tester.enterText(find.byType(TextField), 'backup');
    await tester.pumpAndSettle();
    expect(find.text('Encrypted backup'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
