import 'dart:async';
import 'dart:typed_data';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/saved_radio.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _radioA = 'AA:AA:AA:AA:AA:01';
const _radioB = 'BB:BB:BB:BB:BB:02';

/// Records the BLE link calls the connector makes instead of using a radio.
class _FakeBle {
  final List<String> linked = [];
  final List<String> unlinked = [];
  final Map<String, Completer<void>> gates = {};

  Future<void> link(BluetoothDevice device) {
    final id = device.remoteId.str;
    linked.add(id);
    return gates[id]?.future ?? Future.value();
  }

  Future<void> unlink(BluetoothDevice device) async {
    unlinked.add(device.remoteId.str);
    // Like flutter_blue_plus, disconnecting cancels a pending connect.
    final gate = gates.remove(device.remoteId.str);
    if (gate != null && !gate.isCompleted) {
      gate.completeError(Exception('connection canceled'));
    }
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MeshCoreConnector connector;
  late _FakeBle ble;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    ble = _FakeBle();
    connector = MeshCoreConnector()
      ..debugBleLinkOverride = ble.link
      ..debugBleUnlinkOverride = ble.unlink;
  });

  BluetoothDevice device(String id) => BluetoothDevice.fromId(id);

  group('radio identity and signal', () {
    test('tracks the last RX SNR and RSSI', () {
      expect(connector.lastRxSnr, isNull);
      connector.handleFrameForTest([pushCodeLogRxData, 0x1C, 0xA4, 0x11, 0]);
      expect(connector.lastRxSnr, 7.0);
      expect(connector.lastRxRssi, -92);
      expect(connector.lastRxSignalAt, isNotNull);

      connector.handleFrameForTest([pushCodeLogRxData, 0xF6, 0xB0, 0x11, 0]);
      expect(connector.lastRxSnr, -2.5);
      expect(connector.lastRxRssi, -80);
    });

    test('exposes a six-byte public key prefix', () {
      expect(connector.selfPublicKeyPrefixHex, isNull);
      connector.debugSetSelfIdentity(
        Uint8List.fromList(List.generate(32, (i) => 0xA0 + i)),
        'Base',
      );
      expect(connector.selfPublicKeyPrefixHex, 'a0a1a2a3a4a5');
    });

    test('describes connection errors in plain words', () {
      String describe(Object e) => MeshCoreConnector.describeConnectionError(e);
      expect(
        describe(TimeoutException('Linux connect hard-timeout after 8s')),
        'Timed out. Check that the radio is on and in range.',
      );
      expect(
        describe(StateError('Timed out waiting for SELF_INFO during connect')),
        contains('did not answer'),
      );
      expect(
        describe(Exception('MeshCore UART service not found')),
        'This device is not a MeshCore companion radio.',
      );
      expect(
        describe(Exception('Bluetooth adapter not available')),
        'Bluetooth is off',
      );
      expect(
        describe(Exception('SocketException: Connection refused')),
        'Could not reach the radio over the network.',
      );
      expect(describe(Exception('Odd failure')), 'Odd failure');
      expect(describe(Exception('x' * 400)).length, 160);
    });
  });

  group('Bluetooth adapter state', () {
    test('Bluetooth off while connected stops reconnects until it is on', () {
      fakeAsync((async) {
        connector.handleAdapterState(BluetoothAdapterState.on);
        unawaited(connector.connect(device(_radioA), displayName: 'Base'));
        async.flushMicrotasks();
        expect(connector.isConnected, isTrue);

        connector.handleAdapterState(BluetoothAdapterState.off);
        async.flushMicrotasks();
        expect(connector.isBluetoothOff, isTrue);
        expect(connector.state, MeshCoreConnectionState.disconnected);
        expect(connector.isAutoReconnectScheduled, isFalse);
        expect(connector.lastConnectionError, 'Bluetooth is off');

        // No reconnect storm while the adapter stays off.
        async.elapse(const Duration(minutes: 5));
        expect(ble.linked, [_radioA]);

        connector.handleAdapterState(BluetoothAdapterState.turningOn);
        connector.handleAdapterState(BluetoothAdapterState.on);
        expect(connector.isBluetoothOff, isFalse);
        expect(connector.isAutoReconnectScheduled, isTrue);
        expect(connector.lastConnectionError, isNull);

        async.elapse(const Duration(seconds: 1));
        async.flushMicrotasks();
        expect(ble.linked, [_radioA, _radioA]);
        expect(connector.isConnected, isTrue);

        async.elapse(const Duration(minutes: 1));
        expect(ble.linked, hasLength(2));
      });
    });

    test('off then on repeatedly schedules a single reconnect', () {
      fakeAsync((async) {
        unawaited(connector.connect(device(_radioA)));
        async.flushMicrotasks();
        for (var i = 0; i < 3; i++) {
          connector.handleAdapterState(BluetoothAdapterState.off);
          connector.handleAdapterState(BluetoothAdapterState.on);
          async.flushMicrotasks();
        }
        expect(connector.isAutoReconnectScheduled, isTrue);
        async.elapse(const Duration(seconds: 30));
        async.flushMicrotasks();
        expect(ble.linked, [_radioA, _radioA]);
        expect(connector.isConnected, isTrue);
      });
    });

    test('adapter coming on after a manual disconnect does not connect', () {
      fakeAsync((async) {
        unawaited(connector.connect(device(_radioA)));
        async.flushMicrotasks();
        unawaited(connector.disconnect());
        async.flushMicrotasks();
        connector.handleAdapterState(BluetoothAdapterState.off);
        connector.handleAdapterState(BluetoothAdapterState.on);
        async.elapse(const Duration(minutes: 1));
        expect(ble.linked, [_radioA]);
        expect(connector.isAutoReconnectScheduled, isFalse);
      });
    });
  });

  group('overlapping BLE connections', () {
    test('a new device cancels a pending connect to the old one', () async {
      ble.gates[_radioA] = Completer<void>();
      final first = connector.connect(device(_radioA));
      await pumpEventQueue();
      expect(connector.state, MeshCoreConnectionState.connecting);

      await connector.connect(device(_radioB));
      await first;

      expect(connector.isConnected, isTrue);
      expect(connector.deviceId, _radioB);
      expect(ble.linked, [_radioA, _radioB]);
      expect(ble.unlinked, [_radioA]);
    });

    test('a pending connect that finishes late is dropped, not kept', () async {
      final gate = Completer<void>();
      ble.gates[_radioA] = gate;
      // Simulate a platform that ignores the cancel and connects anyway.
      connector.debugBleUnlinkOverride = (d) async {
        ble.unlinked.add(d.remoteId.str);
      };
      final first = connector.connect(device(_radioA));
      await pumpEventQueue();
      final second = connector.connect(device(_radioB));
      await pumpEventQueue();
      gate.complete();
      await Future.wait([first, second]);

      expect(connector.deviceId, _radioB);
      expect(connector.isConnected, isTrue);
      // A was unlinked once by the switch and once more when its late connect
      // was found superseded.
      expect(ble.unlinked, [_radioA, _radioA]);
    });

    test('a new device disconnects the connected one first', () async {
      await connector.connect(device(_radioA));
      await connector.connect(device(_radioB));
      expect(connector.deviceId, _radioB);
      expect(ble.unlinked, [_radioA]);
      expect(connector.isConnected, isTrue);
    });

    test('the same device again is a no-op', () async {
      ble.gates[_radioA] = Completer<void>();
      final first = connector.connect(device(_radioA));
      await pumpEventQueue();
      await connector.connect(device(_radioA));
      ble.gates[_radioA]!.complete();
      await first;
      await connector.connect(device(_radioA));
      expect(ble.linked, [_radioA]);
      expect(ble.unlinked, isEmpty);
    });

    test('an automatic retry never replaces a live link', () async {
      await connector.connect(device(_radioA));
      await connector.connect(device(_radioB), automaticReconnect: true);
      expect(connector.deviceId, _radioA);
      expect(ble.linked, [_radioA]);
    });

    test('a disconnect during connect leaves nothing connected', () async {
      ble.gates[_radioA] = Completer<void>();
      final first = connector.connect(device(_radioA));
      await pumpEventQueue();
      await connector.disconnect();
      await first;
      expect(connector.state, MeshCoreConnectionState.disconnected);
      expect(connector.isAutoReconnectScheduled, isFalse);
    });
  });

  group('saved radio', () {
    test('remembers transport and address after connecting', () async {
      expect(connector.savedRadio, isNull);
      await connector.connect(device(_radioA), displayName: 'Base');
      await pumpEventQueue();
      final prefs = PrefsManager.instance;
      expect(prefs.getString(SavedRadio.transportKey), 'bluetooth');
      expect(prefs.getString(SavedRadio.addressKey), _radioA);
      expect(prefs.getString(SavedRadio.nameKey), 'Base');
      expect(
        connector.savedRadio,
        const SavedRadio(
          transport: SavedRadioTransport.bluetooth,
          address: _radioA,
          name: 'Base',
        ),
      );
      // Only those three keys: nothing secret is stored.
      expect(
        prefs.getKeys().where((k) => k.startsWith('last_radio')),
        hasLength(3),
      );
    });

    test('reconnects only to the saved device', () async {
      await const SavedRadio(
        transport: SavedRadioTransport.bluetooth,
        address: _radioB,
        name: 'Ridge',
      ).save(PrefsManager.instance);

      await connector.reconnectSavedRadio();
      expect(ble.linked, [_radioB]);
      expect(connector.deviceId, _radioB);
      expect(connector.deviceDisplayName, 'Ridge');
    });

    test('reconnect with nothing saved does nothing', () async {
      await connector.reconnectSavedRadio();
      expect(ble.linked, isEmpty);
      expect(connector.state, MeshCoreConnectionState.disconnected);
    });

    test('a saved radio is never connected automatically', () {
      fakeAsync((async) {
        unawaited(
          const SavedRadio(
            transport: SavedRadioTransport.bluetooth,
            address: _radioB,
            name: 'Ridge',
          ).save(PrefsManager.instance),
        );
        final fresh = MeshCoreConnector()..debugBleLinkOverride = ble.link;
        fresh.handleAdapterState(BluetoothAdapterState.off);
        fresh.handleAdapterState(BluetoothAdapterState.on);
        async.elapse(const Duration(minutes: 2));
        expect(ble.linked, isEmpty);
        expect(fresh.isAutoReconnectScheduled, isFalse);
        expect(fresh.savedRadio?.address, _radioB);
      });
    });

    test('forget clears the saved radio', () async {
      await connector.connect(device(_radioA));
      await pumpEventQueue();
      await connector.disconnect();
      await connector.forgetSavedRadio();
      expect(connector.savedRadio, isNull);
    });

    test('ignores unreadable saved values', () async {
      final prefs = PrefsManager.instance;
      await prefs.setString(SavedRadio.transportKey, 'carrier-pigeon');
      await prefs.setString(SavedRadio.addressKey, 'x');
      expect(SavedRadio.load(prefs), isNull);
      await prefs.setString(SavedRadio.transportKey, 'tcp');
      await prefs.setString(SavedRadio.addressKey, 'no-port');
      expect(SavedRadio.load(prefs), isNull);
      await prefs.setString(SavedRadio.addressKey, '10.0.0.5:5000');
      await prefs.remove(SavedRadio.nameKey);
      expect(SavedRadio.load(prefs)?.name, '10.0.0.5:5000');
    });

    test('parses TCP addresses including IPv6 hosts', () {
      expect(SavedRadio.parseTcp('10.0.0.5:5000'), (
        host: '10.0.0.5',
        port: 5000,
      ));
      expect(SavedRadio.parseTcp('fe80::1:4403'), (
        host: 'fe80::1',
        port: 4403,
      ));
      expect(SavedRadio.parseTcp('host:0'), isNull);
      expect(SavedRadio.parseTcp('host:'), isNull);
      expect(SavedRadio.parseTcp(':80'), isNull);
    });
  });
}
