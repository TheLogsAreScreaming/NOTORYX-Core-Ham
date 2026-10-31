import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/models/radio_rx_packet.dart';
import 'package:meshcore_open/services/signed_posts.dart';
import 'package:meshcore_open/services/sos_relay_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/mesh_packet_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final psk = Uint8List.fromList(List.generate(16, (i) => 0xA0 + i));
  final channel = Channel(index: 1, name: 'Hike', psk: psk);
  const sosText = 'Ann: [NOTORYX SOS] Need help | 12:00 UTC';
  const stamp = 1770000000;

  late MeshCoreConnector connector;
  late StreamController<RadioRxPacket> rx;
  late List<Uint8List> sent;
  late bool canSend;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    connector = MeshCoreConnector()..debugSetChannels([channel]);
    rx = StreamController<RadioRxPacket>.broadcast(sync: true);
    sent = [];
    canSend = true;
  });

  SosRelayService relay(FakeAsync async) => SosRelayService(
    packets: rx.stream,
    decode: connector.decodeHeardChannelPacket,
    canSend: () => canSend,
    send: (raw) async => sent.add(raw),
    clock: () => DateTime(2026).add(async.elapsed),
    random: math.Random(1),
  );

  void hear(Uint8List raw, {bool fromSelf = false}) => rx.add(
    RadioRxPacket(
      raw: raw,
      snr: 5,
      rssi: -90,
      receivedAt: DateTime(2026),
      fromSelf: fromSelf,
    ),
  );

  Uint8List sos({List<int> path = const [], String text = sosText}) =>
      groupTextPacket(psk: psk, text: text, timestamp: stamp, path: path);

  Uint8List signature({int timestamp = stamp, List<int> path = const []}) =>
      groupDataPacket(
        psk: psk,
        dataType: dataTypeSignedPost,
        path: path,
        data: SignedPostPayload(
          publicKey: Uint8List.fromList(List.filled(32, 0x11)),
          timestamp: timestamp,
          signature: Uint8List.fromList(List.filled(64, 0x22)),
        ).encode(),
      );

  test('is off by default', () {
    fakeAsync((async) {
      final service = relay(async)..load();
      hear(sos());
      async.elapse(const Duration(minutes: 1));
      expect(service.enabled, isFalse);
      expect(sent, isEmpty);
    });
  });

  test('relays an SOS no repeater carried, byte for byte', () {
    fakeAsync((async) {
      final service = relay(async);
      unawaited(service.setEnabled(true));
      final packet = sos();
      hear(packet);
      async.elapse(service.waitForRepeater - const Duration(seconds: 1));
      expect(sent, isEmpty);
      async.elapse(service.maxJitter + const Duration(seconds: 1));
      expect(sent, [packet]);
      expect(service.relayed, 1);
      expect(service.lastRelayFrom, 'Ann');

      // A later copy, even the echo of the relay, isn't relayed again.
      hear(sos(path: [9]));
      async.elapse(const Duration(minutes: 1));
      expect(sent, hasLength(1));
    });
  });

  test("a repeater's copy cancels the relay", () {
    fakeAsync((async) {
      unawaited(relay(async).setEnabled(true));
      hear(sos());
      async.elapse(const Duration(seconds: 3));
      hear(sos(path: [5]));
      async.elapse(const Duration(minutes: 1));
      expect(sent, isEmpty);
    });
  });

  test("another phone's relay cancels this one", () {
    fakeAsync((async) {
      unawaited(relay(async).setEnabled(true));
      hear(sos());
      async.elapse(const Duration(seconds: 13));
      hear(sos());
      async.elapse(const Duration(minutes: 1));
      expect(sent, isEmpty);
    });
  });

  test('leaves an SOS that already came through a repeater', () {
    fakeAsync((async) {
      unawaited(relay(async).setEnabled(true));
      hear(sos(path: [5]));
      hear(signature(path: [5]));
      async.elapse(const Duration(minutes: 1));
      expect(sent, isEmpty);
    });
  });

  test('relays the SOS signature with it', () {
    fakeAsync((async) {
      unawaited(relay(async).setEnabled(true));
      final text = sos(), sig = signature();
      hear(text);
      hear(sig);
      async.elapse(const Duration(minutes: 1));
      expect(sent, unorderedEquals([text, sig]));
    });
  });

  test('ignores ordinary texts, their signatures and own traffic', () {
    fakeAsync((async) {
      unawaited(relay(async).setEnabled(true));
      hear(sos(text: 'Ann: lunch at the lake'));
      hear(signature());
      hear(sos(text: 'Me: [NOTORYX SOS] mine'), fromSelf: true);
      async.elapse(const Duration(minutes: 1));
      expect(sent, isEmpty);
    });
  });

  test('relays SOS from older Bastion releases', () {
    fakeAsync((async) {
      unawaited(relay(async).setEnabled(true));
      hear(sos(text: 'Ann: [Bastion SOS] Need help'));
      async.elapse(const Duration(minutes: 1));
      expect(sent, hasLength(1));
    });
  });

  test('turning it off drops a waiting relay', () {
    fakeAsync((async) {
      final service = relay(async);
      unawaited(service.setEnabled(true));
      hear(sos());
      async.elapse(const Duration(seconds: 5));
      unawaited(service.setEnabled(false));
      async.elapse(const Duration(minutes: 1));
      expect(sent, isEmpty);
      expect(PrefsManager.instance.getBool('notoryx_sos_relay_v1'), isFalse);
    });
  });

  test('does nothing on firmware without raw sends', () {
    fakeAsync((async) {
      canSend = false;
      final service = relay(async);
      unawaited(service.setEnabled(true));
      hear(sos());
      async.elapse(const Duration(minutes: 1));
      expect(sent, isEmpty);
      expect(service.relayed, 0);
    });
  });

  test('caps relays per ten minutes', () {
    fakeAsync((async) {
      unawaited(relay(async).setEnabled(true));
      for (var i = 0; i < SosRelayService.maxRelays + 3; i++) {
        hear(groupTextPacket(psk: psk, text: sosText, timestamp: stamp + i));
        async.elapse(const Duration(seconds: 20));
      }
      expect(sent, hasLength(SosRelayService.maxRelays));
      async.elapse(SosRelayService.rateWindow);
      hear(groupTextPacket(psk: psk, text: sosText, timestamp: stamp + 99));
      async.elapse(const Duration(seconds: 20));
      expect(sent, hasLength(SosRelayService.maxRelays + 1));
    });
  });

  test('remembers the setting', () {
    fakeAsync((async) {
      unawaited(relay(async).setEnabled(true));
      async.flushMicrotasks();
      final reloaded = relay(async)..load();
      expect(reloaded.enabled, isTrue);
      hear(sos());
      async.elapse(const Duration(minutes: 1));
      // Both instances listen, so each relays once.
      expect(sent, hasLength(2));
    });
  });
}
