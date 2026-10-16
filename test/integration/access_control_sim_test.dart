// End-to-end check of the Access control screen's service against simulated
// repeater and room server firmware, through the app's real connector.
// Skipped unless MCSIM_ACL is set:
//
//   ./target/release/mcsim run <app>/test/integration/access_control_topology.yaml
//   MCSIM_ACL=patched flutter test test/integration/access_control_sim_test.dart
//
// MCSIM_ACL=patched expects firmware with paged GET_ACCESS_LIST and setperm by
// key prefix; MCSIM_ACL=stock expects MeshCore v1.18.0 as released (lists stop
// at one reply, prefix role changes are refused). Restart the simulator
// between runs: the nodes keep their access lists in memory.
@Timeout(Duration(minutes: 4))
library;

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/access_control.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/services/access_control_service.dart';
import 'package:meshcore_open/services/repeater_command_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _mode = Platform.environment['MCSIM_ACL'];
final _enabled = _mode == 'patched' || _mode == 'stock';
final _patched = _mode == 'patched';
const _companionPort = 9310;
const _adminPassword = 'admin'; // mcsim's cli/password default

Future<void> _waitFor(
  bool Function() condition, {
  Duration timeout = const Duration(seconds: 60),
}) async {
  final deadline = DateTime.now().add(timeout);
  while (!condition()) {
    if (DateTime.now().isAfter(deadline)) {
      throw StateError('Timed out waiting for condition');
    }
    await Future<void>.delayed(const Duration(milliseconds: 200));
  }
}

Uint8List _randomKey(Random random) =>
    Uint8List.fromList(List.generate(32, (_) => random.nextInt(256)));

String _hex(Uint8List bytes) => pubKeyToHex(bytes);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MeshCoreConnector connector;
  late RepeaterCommandService commands;
  late AccessControlService service;
  final random = Random(42);

  Contact nodeOfType(int type) =>
      connector.allContactsUnfiltered.firstWhere((c) => c.type == type);

  // Like the app's login dialog: retry, since a reply can be lost on air.
  Future<void> login(Contact node) async {
    for (var attempt = 1; attempt <= 3; attempt++) {
      final result = Completer<int>();
      final sub = connector.receivedFrames.listen((frame) {
        if (frame.length < 2 || result.isCompleted) return;
        if (frame[0] == pushCodeLoginSuccess) result.complete(frame[1]);
        if (frame[0] == pushCodeLoginFail) result.complete(-1);
      });
      try {
        await connector.sendFrame(
          buildSendLoginFrame(node.publicKey, _adminPassword),
        );
        final isAdmin = await result.future.timeout(
          const Duration(seconds: 15),
        );
        expect(isAdmin, 1, reason: 'admin login to ${node.name}');
        return;
      } on TimeoutException {
        if (attempt == 3) rethrow;
      } finally {
        await sub.cancel();
      }
    }
  }

  // A reply can be lost on air; the screen offers Refresh for that.
  Future<AccessListResult> fetch(Contact node) async {
    for (var attempt = 1; ; attempt++) {
      try {
        return await service.fetch(node);
      } on TimeoutException {
        if (attempt == 3) rethrow;
      }
    }
  }

  setUpAll(() async {
    if (!_enabled) return;
    final tmp = Directory.systemTemp.createTempSync('mcsim_acl').path;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (call) async => tmp,
        );
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();

    connector = MeshCoreConnector();
    await connector.connectTcp(host: '127.0.0.1', port: _companionPort);
    await _waitFor(() => connector.isConnected);
    commands = RepeaterCommandService(connector);
    service = AccessControlService(connector, commands);
    // The repeater and room server advertise at boot; the companion adds
    // them as contacts.
    await _waitFor(
      () =>
          connector.allContactsUnfiltered.any(
            (c) => c.type == advTypeRepeater,
          ) &&
          connector.allContactsUnfiltered.any((c) => c.type == advTypeRoom),
      timeout: const Duration(seconds: 120),
    );
  });

  tearDownAll(() async {
    if (!_enabled) return;
    commands.dispose();
    await connector.disconnect();
  });

  group('room server', () {
    late Contact room;

    setUpAll(() async {
      if (!_enabled) return;
      room = nodeOfType(advTypeRoom);
      await login(room);
    });

    test('lists admins only', () async {
      final newAdmin = _randomKey(random);
      final member = _randomKey(random);
      await service.setRole(room, newAdmin, AclRole.admin);
      await service.setRole(room, member, AclRole.readWrite);

      final result = await fetch(room);
      final prefixes = result.entries.map((e) => _hex(e.keyPrefix)).toList();
      expect(prefixes, contains(_hex(Uint8List.sublistView(newAdmin, 0, 6))));
      expect(
        prefixes,
        isNot(contains(_hex(Uint8List.sublistView(member, 0, 6)))),
      );
      expect(result.entries.every((e) => e.role == AclRole.admin), isTrue);
    }, skip: !_enabled);
  });

  group('repeater', () {
    late Contact repeater;
    late Uint8List selfKey;

    setUpAll(() async {
      if (!_enabled) return;
      repeater = nodeOfType(advTypeRepeater);
      selfKey = connector.selfPublicKey!;
      await login(repeater);
    });

    test('lists the logged-in admin', () async {
      final result = await fetch(repeater);
      expect(result.complete, isTrue);
      final self = result.entries.where((e) => e.matches(selfKey));
      expect(self.single.role, AclRole.admin);
    }, skip: !_enabled);

    test('seed a few entries', () async {
      final listedBefore = (await fetch(repeater)).entries.length;
      for (var i = 0; i < 3; i++) {
        await service.setRole(repeater, _randomKey(random), AclRole.readOnly);
      }
      final result = await fetch(repeater);
      expect(result.entries, hasLength(listedBefore + 3));
    }, skip: !_enabled);

    test('changing a role by key prefix (newer firmware only)', () async {
      final before = await fetch(repeater);
      final target = before.entries.firstWhere(
        (e) => !e.matches(selfKey) && e.role == AclRole.readOnly,
      );
      final change = service.setRole(
        repeater,
        target.keyPrefix,
        AclRole.readWrite,
      );
      if (_patched) {
        await change;
        final after = await fetch(repeater);
        final updated = after.entries.firstWhere(
          (e) => _hex(e.keyPrefix) == _hex(target.keyPrefix),
        );
        expect(updated.role, AclRole.readWrite);
      } else {
        await expectLater(change, throwsA(isA<AccessControlException>()));
      }
    }, skip: !_enabled);

    test('a short prefix cannot change a role', () async {
      final before = await fetch(repeater);
      final target = before.entries.firstWhere((e) => !e.matches(selfKey));
      await expectLater(
        service.setRole(
          repeater,
          Uint8List.sublistView(target.keyPrefix, 0, 3),
          AclRole.admin,
        ),
        throwsA(isA<AccessControlException>()),
      );
    }, skip: !_enabled);

    test('removing by key prefix works on all firmware', () async {
      final before = await fetch(repeater);
      final target = before.entries.firstWhere((e) => !e.matches(selfKey));
      await service.setRole(repeater, target.keyPrefix, AclRole.guest);
      final after = await fetch(repeater);
      expect(
        after.entries.map((e) => _hex(e.keyPrefix)),
        isNot(contains(_hex(target.keyPrefix))),
      );
    }, skip: !_enabled);
    test(
      'a list longer than one reply is paged (or marked incomplete on stock)',
      () async {
        final listedBefore = (await fetch(repeater)).entries.length;
        final toAdd = 30 - listedBefore;
        for (var i = 0; i < toAdd; i++) {
          await service.setRole(repeater, _randomKey(random), AclRole.readOnly);
        }
        if (!_patched) {
          // v1.18 repeaters reply with 25 entries, which the companion
          // can't fit in a frame and drops: the list never arrives.
          await expectLater(
            service.fetch(repeater),
            throwsA(isA<TimeoutException>()),
          );
          return;
        }
        final result = await fetch(repeater);
        expect(result.complete, isTrue);
        expect(result.entries, hasLength(30));
        // Prefixes are unique, so paging didn't repeat or skip entries.
        final prefixes = result.entries.map((e) => _hex(e.keyPrefix)).toSet();
        expect(prefixes, hasLength(result.entries.length));
      },
      skip: !_enabled,
      timeout: const Timeout(Duration(minutes: 5)),
    );
  });
}
