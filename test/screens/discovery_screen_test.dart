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

Contact _node(int n, String name) => Contact(
  publicKey: Uint8List.fromList(List.filled(32, n)),
  name: name,
  type: advTypeRepeater,
  path: Uint8List(0),
  pathLength: 0,
  lastSeen: DateTime.now().subtract(Duration(minutes: n)),
  // Heard, not yet added to the radio.
  isActive: false,
);

class _Radio extends MeshCoreConnector {
  _Radio({List<Contact>? found}) : found = found ?? [_ridge];
  final List<Contact> found;
  final imported = <String>[];
  bool connected = false;
  int max = 350;
  @override
  bool get isConnected => connected;
  @override
  int get maxContacts => max;
  @override
  List<Contact> get contacts => const [];
  @override
  List<Contact> get discoveredContacts => found;
  @override
  Future<bool> importDiscoveredContact(Contact contact) async {
    imported.add(contact.name);
    return true;
  }
}

Future<_Radio> _pump(WidgetTester tester, [_Radio? given]) async {
  final radio = given ?? _Radio();
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

  testWidgets('long-press selects contacts, and Add selected adds them all', (
    tester,
  ) async {
    final radio = _Radio(
      found: [_node(1, 'Alpha'), _node(2, 'Bravo'), _node(3, 'Charlie')],
    )..connected = true;
    await _pump(tester, radio);
    await tester.longPress(find.text('Alpha'));
    await tester.pumpAndSettle();
    expect(find.text('1 selected'), findsOneWidget);
    expect(find.byType(Checkbox), findsNWidgets(3));
    await tester.tap(find.text('Bravo'));
    await tester.pumpAndSettle();
    expect(find.text('2 selected'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('discovered-select-all')));
    await tester.pumpAndSettle();
    expect(find.text('3 selected'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('discovered-add-selected')));
    await tester.pumpAndSettle();
    expect(find.text('Add 3 contacts?'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('discovered-add-many-confirm')));
    await tester.pumpAndSettle();
    expect(radio.imported, unorderedEquals(['Alpha', 'Bravo', 'Charlie']));
    expect(find.text('Contacts added: 3'), findsOneWidget);
    expect(find.byType(Checkbox), findsNothing);
  });

  testWidgets('Add all shown stops at the room left on the radio', (
    tester,
  ) async {
    final radio =
        _Radio(
            found: [_node(1, 'Alpha'), _node(2, 'Bravo'), _node(3, 'Charlie')],
          )
          ..connected = true
          ..max = 2;
    await _pump(tester, radio);
    await tester.tap(find.byKey(const ValueKey('discovered-menu')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('discovered-add-all')));
    await tester.pumpAndSettle();
    expect(
      find.text(
        'Your radio has room for 2 more contacts, so only the first 2 of 3 '
        'will be added.',
      ),
      findsOneWidget,
    );
    await tester.tap(find.byKey(const ValueKey('discovered-add-many-confirm')));
    await tester.pumpAndSettle();
    expect(radio.imported, ['Alpha', 'Bravo']);
  });

  testWidgets('a full radio says so instead of adding', (tester) async {
    final radio = _Radio(found: [_node(1, 'Alpha')])
      ..connected = true
      ..max = 0;
    await _pump(tester, radio);
    await tester.tap(find.byKey(const ValueKey('discovered-menu')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('discovered-add-all')));
    await tester.pumpAndSettle();
    expect(radio.imported, isEmpty);
    expect(find.textContaining('contact list is full'), findsOneWidget);
  });
}
