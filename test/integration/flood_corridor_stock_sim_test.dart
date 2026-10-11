// Stock-firmware control for the flood corridor work: the same simulator
// topology built against upstream MeshCore (no corridor support). The app's
// connect-time probe must be answered with UNSUPPORTED_CMD without disturbing
// anything else, and ordinary channel sends must keep working.
//
// Skipped unless MCSIM_STOCK=1. Build mcsim as described in
// flood_corridor_sim_test.dart but with MeshCore from
// github.com/meshcore-dev/MeshCore (dev); at 2dbd463e the simulator's
// simulator/companion/sim_main.cpp needs MyMesh(..., *store) and begin().
library;

import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/models/channel_message.dart';
import 'package:meshcore_open/models/flood_corridor.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mcsim_radio.dart';

final bool _enabled = Platform.environment['MCSIM_STOCK'] == '1';

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
    if (!_enabled) return;
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
    if (!_enabled) return;
    await connector.disconnect();
    await bob.close();
  });

  test('reports no corridor support and completes the initial sync', () async {
    await _waitFor(() => connector.floodCorridorSupported != null);
    expect(connector.floodCorridorSupported, isFalse);
    expect(connector.corridorRegion, isNull);
    await _waitFor(() => connector.channels.isNotEmpty);
    await _waitFor(() => connector.allContacts.length >= 5);
  }, skip: !_enabled);

  test(
    'corridor sends are refused and plain sends still work',
    () async {
      final channel = connector.channels.firstWhere(
        (c) => c.index == publicChannel,
      );

      await connector.sendChannelMessageWithCorridor(channel, 'not-sent', [
        CorridorTriple(lat: aliceAt.lat, lon: aliceAt.lon, radiusCode: 7),
      ]);
      expect(
        connector.getChannelMessages(channel).any((m) => m.text == 'not-sent'),
        isFalse,
      );
      expect(await connector.proposeCorridor(bobAt.lat, bobAt.lon), isNull);

      // Not awaited: on dev, sendChannelMessage waits for RESP_CODE_SENT, but
      // firmware confirms channel texts with RESP_CODE_OK, so the call times
      // out after 5 s even though the message is sent (a pre-existing issue).
      unawaited(
        connector
            .sendChannelMessage(channel, 'stock-plain')
            .catchError((Object _) {}),
      );
      await _waitFor(
        () => connector
            .getChannelMessages(channel)
            .any(
              (m) =>
                  m.text == 'stock-plain' &&
                  m.status == ChannelMessageStatus.sent,
            ),
      );
      final texts = await receivedChannelTexts(
        bob,
        const Duration(seconds: 20),
        until: 'stock-plain',
      );
      expect(texts.any((t) => t.contains('stock-plain')), isTrue);
    },
    timeout: const Timeout(Duration(seconds: 90)),
    skip: !_enabled,
  );
}
