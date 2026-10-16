import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/access_control.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/screens/access_control_screen.dart';
import 'package:meshcore_open/services/access_control_service.dart';
import 'package:meshcore_open/services/repeater_command_service.dart';
import 'package:provider/provider.dart';

Uint8List _key(int seed) =>
    Uint8List.fromList(List.generate(32, (i) => (seed * 31 + i) & 0xFF));

Contact _contact(int seed, String name, int type) => Contact(
  publicKey: _key(seed),
  name: name,
  type: type,
  pathLength: 0,
  path: Uint8List(0),
  lastSeen: DateTime(2026, 10, 15),
);

final _sam = _contact(1, 'Sam', advTypeChat);
final _ridge = _contact(2, 'Ridge Camp', advTypeChat);
final _repeater = _contact(3, 'Hollyburn RPT', advTypeRepeater);
final _room = _contact(4, 'Basecamp Room', advTypeRoom);

AclEntry _entryFor(Uint8List key, AclRole role) => AclEntry(
  keyPrefix: Uint8List.fromList(key.sublist(0, 6)),
  permissions: role.value,
);

class _Connector extends MeshCoreConnector {
  @override
  bool get isConnected => true;
  @override
  Uint8List? get selfPublicKey => _key(9);
  @override
  List<Contact> get allContactsUnfiltered => [_sam, _ridge, _repeater, _room];
}

class _FakeService extends AccessControlService {
  _FakeService(MeshCoreConnector c, this.entries)
    : super(c, RepeaterCommandService(c));

  List<AclEntry> entries;
  final List<(Uint8List, AclRole)> changes = [];

  @override
  Future<AccessListResult> fetch(Contact node) async =>
      AccessListResult(entries: entries, complete: true);

  @override
  Future<void> setRole(Contact node, Uint8List publicKey, AclRole role) async {
    changes.add((publicKey, role));
  }
}

Widget _app(MeshCoreConnector connector, Contact node, _FakeService service) =>
    ChangeNotifierProvider<MeshCoreConnector>.value(
      value: connector,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: AccessControlScreen(node: node, service: service),
      ),
    );

void main() {
  testWidgets('lists entries by contact name, unknown nodes and self', (
    tester,
  ) async {
    final connector = _Connector();
    final service = _FakeService(connector, [
      _entryFor(_key(9), AclRole.admin),
      _entryFor(_sam.publicKey, AclRole.readOnly),
      _entryFor(_key(42), AclRole.readWrite),
    ]);
    await tester.pumpWidget(_app(connector, _repeater, service));
    await tester.pumpAndSettle();

    expect(find.text('You'), findsOneWidget);
    expect(find.text('Sam'), findsOneWidget);
    expect(find.text('Unknown node'), findsOneWidget);
    expect(find.text('Read only'), findsOneWidget);
    expect(find.text('Read & write'), findsOneWidget);
  });

  testWidgets('changes a known entry\'s role with its full key', (
    tester,
  ) async {
    final connector = _Connector();
    final service = _FakeService(connector, [
      _entryFor(_sam.publicKey, AclRole.readOnly),
    ]);
    await tester.pumpWidget(_app(connector, _repeater, service));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sam'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Admin'));
    await tester.pumpAndSettle();

    expect(service.changes.single.$1, _sam.publicKey);
    expect(service.changes.single.$2, AclRole.admin);
  });

  testWidgets('removes an unknown entry by its prefix after confirming', (
    tester,
  ) async {
    final connector = _Connector();
    final unknown = _entryFor(_key(42), AclRole.readWrite);
    final service = _FakeService(connector, [unknown]);
    await tester.pumpWidget(_app(connector, _repeater, service));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Unknown node'));
    await tester.pumpAndSettle();
    // Role changes are offered by prefix (newer firmware), with a note.
    expect(find.textContaining('Not in your contacts'), findsOneWidget);
    await tester.tap(find.text('Remove access'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Remove access'));
    await tester.pumpAndSettle();

    expect(service.changes.single.$1, unknown.keyPrefix);
    expect(service.changes.single.$2, AclRole.guest);
  });

  testWidgets('changes an unknown entry\'s role by its prefix', (tester) async {
    final connector = _Connector();
    final unknown = _entryFor(_key(42), AclRole.readOnly);
    final service = _FakeService(connector, [unknown]);
    await tester.pumpWidget(_app(connector, _repeater, service));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Unknown node'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Admin'));
    await tester.pumpAndSettle();

    expect(service.changes.single.$1, unknown.keyPrefix);
    expect(service.changes.single.$2, AclRole.admin);
  });

  testWidgets('adds a contact; room servers only offer admin', (tester) async {
    final connector = _Connector();
    final service = _FakeService(connector, [
      _entryFor(_sam.publicKey, AclRole.admin),
    ]);
    await tester.pumpWidget(_app(connector, _room, service));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();
    // Sam is already listed, and nodes that aren't people aren't offered.
    expect(find.widgetWithText(ListTile, 'Sam'), findsNothing);
    expect(find.text('Hollyburn RPT'), findsNothing);
    await tester.tap(find.text('Ridge Camp'));
    await tester.pumpAndSettle();

    expect(service.changes.single.$1, _ridge.publicKey);
    expect(service.changes.single.$2, AclRole.admin);
  });
}
