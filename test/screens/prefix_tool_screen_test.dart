import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/screens/prefix_tool_screen.dart';
import 'package:provider/provider.dart';

Contact _node(String name, List<int> keyStart) {
  final key = Uint8List(32)..setAll(0, keyStart);
  key[31] = name.length;
  return Contact(
    publicKey: key,
    name: name,
    type: advTypeRepeater,
    pathLength: -1,
    path: Uint8List(0),
    lastSeen: DateTime(2026, 10, 28),
  );
}

class _FakeConnector extends MeshCoreConnector {
  final _nodes = [
    _node('Ridge', [0x3d, 0x4a]),
    _node('Tower Hill', [0x3d, 0x4b]),
    _node('Base', [0x5a, 0x10]),
  ];
  @override
  bool get isConnected => true;
  @override
  int get pathHashByteWidth => 1;
  @override
  List<Contact> get allContactsUnfiltered => _nodes;
}

Future<void> _pump(WidgetTester tester) async {
  await tester.pumpWidget(
    ChangeNotifierProvider<MeshCoreConnector>.value(
      value: _FakeConnector(),
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: PrefixToolScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('summarises IDs and lists the shared one', (tester) async {
    await _pump(tester);
    expect(
      find.text('3 nodes known · 2 IDs in use · 1 shared'),
      findsOneWidget,
    );
    expect(find.text('254 of 256 IDs free'), findsOneWidget);
    expect(find.text('Ridge\nTower Hill'), findsOneWidget);
  });

  testWidgets('looks up an ID and offers a key when it is free', (
    tester,
  ) async {
    await _pump(tester);
    await tester.enterText(find.byKey(const ValueKey('prefix-lookup')), '5a');
    await tester.pumpAndSettle();
    expect(find.text('1 node uses 5A'), findsOneWidget);
    await tester.enterText(find.byKey(const ValueKey('prefix-lookup')), '77');
    await tester.pumpAndSettle();
    expect(find.text('No known node uses 77.'), findsOneWidget);
    expect(find.text('Make a key'), findsOneWidget);
  });

  testWidgets('switching to 2-byte IDs clears the clash', (tester) async {
    await _pump(tester);
    await tester.tap(find.text('2-byte'));
    await tester.pumpAndSettle();
    expect(
      find.text('3 nodes known · 3 IDs in use · 0 shared'),
      findsOneWidget,
    );
  });
}
