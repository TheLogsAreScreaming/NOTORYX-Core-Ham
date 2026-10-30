import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/screens/discovery_screen.dart';
import 'package:provider/provider.dart';

final _ridge = Contact(
  publicKey: Uint8List.fromList(List.generate(32, (i) => i)),
  name: 'Ridge Repeater',
  type: advTypeRepeater,
  path: Uint8List(0),
  pathLength: 0,
  lastSeen: DateTime.now(),
);

class _Radio extends MeshCoreConnector {
  final imported = <String>[];
  @override
  List<Contact> get discoveredContacts => [_ridge];
  @override
  Future<bool> importDiscoveredContact(Contact contact) async {
    imported.add(contact.name);
    return true;
  }
}

Future<_Radio> _pump(WidgetTester tester) async {
  final radio = _Radio();
  await tester.pumpWidget(
    ChangeNotifierProvider<MeshCoreConnector>.value(
      value: radio,
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: DiscoveryScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return radio;
}

void main() {
  testWidgets('each discovered contact has a visible add button', (
    tester,
  ) async {
    final radio = await _pump(tester);
    await tester.tap(find.byTooltip('Add Contact'));
    await tester.pumpAndSettle();
    expect(radio.imported, ['Ridge Repeater']);
    expect(find.text('Contact added'), findsOneWidget);
  });

  testWidgets('tapping a row opens its actions, with Add first', (
    tester,
  ) async {
    final radio = await _pump(tester);
    await tester.tap(find.text('Ridge Repeater'));
    await tester.pumpAndSettle();
    expect(radio.imported, isEmpty);
    final add = find.widgetWithText(ListTile, 'Add Contact');
    expect(add, findsOneWidget);
    expect(
      tester.getTopLeft(add).dy,
      lessThan(
        tester
            .getTopLeft(
              find.widgetWithText(ListTile, 'Copy Contact to clipboard'),
            )
            .dy,
      ),
    );
    await tester.tap(add);
    await tester.pumpAndSettle();
    expect(radio.imported, ['Ridge Repeater']);
  });

  testWidgets('a long name is readable at phone width', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await _pump(tester);
    final name = tester.renderObject<RenderParagraph>(
      find.byKey(ValueKey('discovered-name-${_ridge.publicKeyHex}')),
    );
    expect(name.didExceedMaxLines, isFalse);
    expect(tester.getSize(find.text('Ridge Repeater')).width, greaterThan(100));
  });
}
