import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/screens/region_setup_screen.dart';
import 'package:provider/provider.dart';

Future<void> _pump(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(500, 1600));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    ChangeNotifierProvider<MeshCoreConnector>.value(
      value: MeshCoreConnector(),
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: RegionSetupScreen(
          loadTrees: () async =>
              File('assets/region_trees.json').readAsStringSync(),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('picking Seattle shows its chain and commands', (tester) async {
    await _pump(tester);
    expect(find.text('Pick a region to see the commands.'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('region-leaf-pnw')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('sea · Seattle').last);
    await tester.pumpAndSettle();
    expect(find.text('west  ›  pnw  ›  wa  ›  w-wa  ›  sea'), findsOneWidget);
    expect(find.text('region put sea w-wa'), findsOneWidget);
    expect(find.text('region default sea'), findsOneWidget);
    expect(find.text('region save'), findsOneWidget);
    // Without a logged-in repeater the screen explains how to send.
    expect(find.byKey(const ValueKey('region-send')), findsNothing);
  });

  testWidgets('a custom chain is checked for bad names', (tester) async {
    await _pump(tester);
    await tester.tap(find.byKey(const ValueKey('region-tree')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Custom').last);
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('region-custom')),
      'west > my_town',
    );
    await tester.pumpAndSettle();
    expect(find.textContaining("isn't a valid region name"), findsOneWidget);
    expect(find.text('Pick a region to see the commands.'), findsOneWidget);
    await tester.enterText(
      find.byKey(const ValueKey('region-custom')),
      'west > my-town',
    );
    await tester.pumpAndSettle();
    expect(find.text('region put my-town west'), findsOneWidget);
  });
}
