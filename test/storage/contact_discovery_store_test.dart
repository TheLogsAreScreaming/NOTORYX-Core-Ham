import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/storage/contact_discovery_store.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';

Contact _node(int i) => Contact(
  publicKey: Uint8List(32)
    ..[0] = i & 0xFF
    ..[1] = i >> 8,
  name: 'Node $i',
  type: 2,
  flags: 0,
  pathLength: -1,
  path: Uint8List(0),
  lastSeen: DateTime.fromMillisecondsSinceEpoch(1700000000000 + i * 1000),
  lastMessageAt: DateTime.fromMillisecondsSinceEpoch(1700000000000),
);

void main() {
  late Directory dir;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await PrefsManager.initialize();
    dir = await Directory.systemTemp.createTemp('discovery_store_test');
  });

  tearDown(() async {
    if (await dir.exists()) await dir.delete(recursive: true);
  });

  test('saves to its own file, not preferences, and loads it back', () async {
    final store = ContactDiscoveryStore(directory: () async => dir.path);
    await store.saveContacts([for (var i = 0; i < 3; i++) _node(i)]);

    expect(File('${dir.path}/discovered_contacts.json').existsSync(), isTrue);
    expect(PrefsManager.instance.getString('discovered_contacts'), isNull);
    final loaded = await store.loadContacts();
    expect(loaded.map((c) => c.name), ['Node 0', 'Node 1', 'Node 2']);
  });

  test('moves a list saved in preferences to the file', () async {
    final old = ContactDiscoveryStore(directory: () async => null);
    await old.saveContacts([_node(7)]);
    expect(PrefsManager.instance.getString('discovered_contacts'), isNotNull);

    final store = ContactDiscoveryStore(directory: () async => dir.path);
    final loaded = await store.loadContacts();
    expect(loaded.single.name, 'Node 7');
    expect(PrefsManager.instance.getString('discovered_contacts'), isNull);
    expect(File('${dir.path}/discovered_contacts.json').existsSync(), isTrue);
    expect((await store.loadContacts()).single.name, 'Node 7');
  });

  test('keeps thousands of nodes', () async {
    final store = ContactDiscoveryStore(directory: () async => dir.path);
    await store.saveContacts([for (var i = 0; i < 5000; i++) _node(i)]);
    expect(await store.loadContacts(), hasLength(5000));
  });

  test('without a folder it uses preferences', () async {
    final store = ContactDiscoveryStore(directory: () async => null);
    await store.saveContacts([_node(1)]);
    final saved = jsonDecode(
      PrefsManager.instance.getString('discovered_contacts')!,
    );
    expect(saved, hasLength(1));
    expect((await store.loadContacts()).single.name, 'Node 1');
  });
}
