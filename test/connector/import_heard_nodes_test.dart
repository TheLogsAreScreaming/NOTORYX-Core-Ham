import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:meshcore_open/utils/node_import.dart';

ImportedNode _node(
  int b, {
  String? name,
  double? lat,
  double? lon,
  DateTime? seen,
}) => ImportedNode(
  publicKey: Uint8List.fromList(List.filled(32, b)),
  name: name,
  type: advTypeRepeater,
  latitude: lat,
  longitude: lon,
  lastSeen: seen,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
  });

  test('needs a connected radio', () async {
    final connector = MeshCoreConnector();
    expect(await connector.importHeardNodes([_node(1)]), isNull);
    expect(connector.discoveredContacts, isEmpty);
  });

  test('adds new nodes, fills gaps, skips what is already known', () async {
    final connector = MeshCoreConnector()..debugMarkConnected();
    final t1 = DateTime.utc(2026, 11, 1);
    final t2 = DateTime.utc(2026, 11, 10);

    final first = await connector.importHeardNodes([
      _node(1, name: 'Node 1', seen: t1),
      _node(2),
    ]);
    expect(first!.added, 2);
    expect(first.updated, 0);
    final unknown = connector.discoveredContacts.firstWhere(
      (c) => c.publicKey[0] == 2,
    );
    expect(unknown.name, 'Unknown');
    expect(
      unknown.lastSeen.millisecondsSinceEpoch,
      0,
      reason: 'no last-heard time sorts it last instead of "just heard"',
    );
    expect(unknown.isActive, isFalse);

    final second = await connector.importHeardNodes([
      _node(1, lat: 41.5, lon: -72.5, seen: t2), // position + newer time
      _node(1, name: 'Other name'), // nothing new
    ]);
    expect(second!.added, 0);
    expect(second.updated, 1);
    expect(second.skipped, 1);
    final one = connector.discoveredContacts.firstWhere(
      (c) => c.publicKey[0] == 1,
    );
    expect(one.name, 'Node 1', reason: 'an existing name is kept');
    expect(one.latitude, 41.5);
    expect(one.lastSeen.toUtc(), t2);
    expect(connector.discoveredContacts, hasLength(2));

    final third = await connector.importHeardNodes([_node(2, name: 'Node 2')]);
    expect(third!.updated, 1);
    expect(
      connector.discoveredContacts.firstWhere((c) => c.publicKey[0] == 2).name,
      'Node 2',
      reason: 'an unknown name is filled in',
    );
    final counts = connector.knownNodeCounts;
    expect(counts.total, 2);
    expect(counts.repeaters, 2);
    expect(counts.chats, 0);
  });
}
