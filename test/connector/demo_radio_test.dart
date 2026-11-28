import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/demo_companion.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/saved_radio.dart';
import 'package:meshcore_open/storage/contact_discovery_store.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _waitFor(
  String what,
  bool Function() condition, {
  Duration timeout = const Duration(seconds: 15),
}) async {
  final deadline = DateTime.now().add(timeout);
  while (!condition()) {
    if (DateTime.now().isAfter(deadline)) {
      throw StateError('Timed out waiting for $what');
    }
    await Future<void>.delayed(const Duration(milliseconds: 50));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    final tmp = Directory.systemTemp.createTempSync('demo_radio').path;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (call) async => tmp,
        );
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
  });

  test('only the demo host opens the demo radio', () {
    expect(isDemoRadioHost('demo.notoryx'), isTrue);
    expect(isDemoRadioHost(' Demo.Notoryx '), isTrue);
    expect(isDemoRadioHost('192.168.1.2'), isFalse);
  });

  test(
    'the app connects to the demo radio and shows its nodes and history',
    () async {
      final connector = MeshCoreConnector();
      addTearDown(connector.disconnect);
      await connector.connectTcp(host: demoRadioHost, port: 1);
      await _waitFor('step 1', () => connector.isConnected);
      expect(connector.isDemoRadio, isTrue);
      await _waitFor('step 2', () => connector.selfName == 'Demo Radio');

      await _waitFor('step 3', () => connector.contacts.length >= 5);
      expect(
        connector.contacts.map((c) => c.name),
        containsAll(['Ridge Relay', 'Camp North', 'Trailhead']),
      );

      await _waitFor('step 4', () => connector.channels.length >= 2);
      final public = connector.channels.firstWhere((c) => c.index == 0);
      await _waitFor(
        'step 5',
        () => connector.getChannelMessages(public).length >= 4,
      );
      final now = DateTime.now();
      for (final m in connector.getChannelMessages(public)) {
        expect(m.isOutgoing, isFalse);
        expect(m.timestamp.isBefore(now), isTrue);
      }

      final camp = connector.contacts.firstWhere((c) => c.name == 'Camp North');
      await _waitFor('step 6', () => connector.getMessages(camp).length >= 2);

      expect(
        SavedRadio.load(PrefsManager.instance),
        isNull,
        reason: 'the demo is never saved as a radio',
      );
      expect(connector.reconnectTarget, isNull);
    },
    timeout: const Timeout(Duration(seconds: 60)),
  );

  test(
    'a real heard-node list is never shown in the demo and is kept on disk',
    () async {
      Contact real(int i) => Contact(
        publicKey: Uint8List(32)
          ..[0] = 0xA0 + i
          ..[1] = i,
        name: 'Real node $i',
        type: 2,
        flags: 0,
        pathLength: -1,
        path: Uint8List(0),
        lastSeen: DateTime.now().subtract(Duration(minutes: i)),
        lastMessageAt: DateTime.now(),
      );
      final store = ContactDiscoveryStore();
      await store.saveContacts([for (var i = 0; i < 3; i++) real(i)]);

      final connector = MeshCoreConnector();
      await connector.connectTcp(host: demoRadioHost, port: 1);
      await _waitFor('demo contacts', () => connector.contacts.length >= 5);
      await Future<void>.delayed(const Duration(milliseconds: 500));

      expect(
        connector.discoveredContacts.map((c) => c.name),
        everyElement(isNot(startsWith('Real node'))),
      );
      expect(
        connector.allContacts.map((c) => c.name),
        isNot(contains(startsWith('Real node'))),
      );
      expect(connector.directRepeaters, isEmpty);
      expect(connector.latestRadioStats, isNull);

      await connector.disconnect();
      expect(connector.isDemoRadio, isFalse);

      final kept = await store.loadContacts();
      expect(
        kept.map((c) => c.name),
        unorderedEquals(['Real node 0', 'Real node 1', 'Real node 2']),
        reason: 'the demo must not overwrite the real list',
      );
    },
    timeout: const Timeout(Duration(seconds: 60)),
  );
}
