// Drives the app's real MeshCoreConnector over TCP against the simulator's
// Alice: corridor detection on connect, then a corridor-limited channel send
// that must be marked sent and reach Bob. Skipped unless MCSIM=1; see
// flood_corridor_sim_test.dart for simulator setup.
library;

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/models/channel_message.dart';
import 'package:meshcore_open/models/flood_corridor.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mcsim_radio.dart';

Future<void> _waitFor(
  bool Function() condition, {
  Duration timeout = const Duration(seconds: 20),
}) async {
  final deadline = DateTime.now().add(timeout);
  while (!condition()) {
    if (DateTime.now().isAfter(deadline)) {
      throw StateError('Timed out waiting for condition');
    }
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MeshCoreConnector connector;
  late SimRadio bob;

  setUpAll(() async {
    if (!mcsimEnabled) return;
    final tmp = Directory.systemTemp.createTempSync('mcsim').path;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (call) async => tmp,
        );
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();

    bob = await SimRadio.connect(bobPort);
    connector = MeshCoreConnector();
    await connector.connectTcp(host: '127.0.0.1', port: alicePort);
    await _waitFor(() => connector.isConnected);
  });

  tearDownAll(() async {
    if (!mcsimEnabled) return;
    await connector.disconnect();
    await bob.close();
  });

  test('detects corridor firmware on connect', () async {
    await _waitFor(() => connector.floodCorridorSupported != null);
    expect(connector.floodCorridorSupported, isTrue);
  }, skip: !mcsimEnabled);

  test(
    'a corridor-limited channel message is marked sent and reaches Bob',
    () async {
      await _waitFor(() => connector.channels.isNotEmpty);
      final channel = connector.channels.firstWhere(
        (c) => c.index == publicChannel,
      );
      // Alice to Bob is ~18 km, so 30 km around Alice covers the relays.
      final corridor = [
        CorridorTriple(lat: aliceAt.lat, lon: aliceAt.lon, radiusCode: 7),
      ];

      await connector.sendChannelMessageWithCorridor(
        channel,
        'connector-corridor',
        corridor,
      );

      final sent = connector
          .getChannelMessages(channel)
          .lastWhere((m) => m.isOutgoing && m.text == 'connector-corridor');
      expect(sent.status, ChannelMessageStatus.sent);

      final texts = await receivedChannelTexts(
        bob,
        const Duration(seconds: 20),
        until: 'connector-corridor',
      );
      expect(texts.any((t) => t.contains('connector-corridor')), isTrue);
    },
    timeout: const Timeout(Duration(seconds: 90)),
    skip: !mcsimEnabled,
  );
}
