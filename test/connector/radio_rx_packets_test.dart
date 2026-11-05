import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/models/radio_rx_packet.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/mesh_packet_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final selfKey = Uint8List.fromList(List.generate(32, (i) => 0x40 + i));
  final otherKey = Uint8List.fromList(List.generate(32, (i) => 0x90 + i));
  final psk = Uint8List.fromList(List.generate(16, (i) => 0xA0 + i));
  late MeshCoreConnector connector;
  late List<RadioRxPacket> heard;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    connector = MeshCoreConnector()
      ..debugSetChannels([Channel(index: 0, name: 'Hike', psk: psk)])
      ..debugSetSelfIdentity(selfKey, 'Base');
    heard = [];
    connector.rxPackets.listen(heard.add);
  });

  Future<RadioRxPacket> rx(
    Uint8List raw, {
    int snrX4 = 0x1C,
    int rssi = 0xA4,
  }) async {
    connector.handleFrameForTest([
      pushCodeLogRxData,
      snrX4,
      rssi,
      ...onAir(raw, station: 'N0RPT'),
    ]);
    await Future<void>.delayed(Duration.zero);
    return heard.last;
  }

  Uint8List advert(Uint8List key) =>
      Uint8List.fromList([0x11, 0, ...key, 1, 2, 3, 4]);

  test('emits heard packets with decoded signal', () async {
    final raw = groupTextPacket(psk: psk, text: 'Alice: hi');
    final packet = await rx(raw);
    expect(packet.raw, raw);
    expect(packet.snr, 7.0);
    expect(packet.rssi, -92);
    expect(packet.fromSelf, isFalse);
    expect(packet.station, 'N0RPT');

    expect((await rx(raw, snrX4: 0xF6)).snr, -2.5);
  });

  test('ignores stock MeshCore frames', () async {
    final before = heard.length;
    connector.handleFrameForTest([
      pushCodeLogRxData,
      0x1C,
      0xA4,
      ...groupTextPacket(psk: psk, text: 'Alice: Part 15 mesh'),
    ]);
    await Future<void>.delayed(Duration.zero);
    expect(heard.length, before);
  });

  test('recognises its own advert', () async {
    expect((await rx(advert(selfKey))).fromSelf, isTrue);
    expect((await rx(advert(otherKey))).fromSelf, isFalse);
  });

  test('recognises its own channel message by sender name', () async {
    final own = groupTextPacket(psk: psk, text: 'Base: on my way', path: [3]);
    expect((await rx(own)).fromSelf, isTrue);
    final unknownChannel = groupTextPacket(
      psk: Uint8List(16),
      text: 'Base: elsewhere',
    );
    expect((await rx(unknownChannel)).fromSelf, isFalse);
  });

  test('treats direct packets from its source hash as its own', () async {
    final fromSelf = Uint8List.fromList([
      (payloadTypeTXTMSG << 2) | 1,
      0,
      0x77,
      selfKey[0],
      9,
      9,
    ]);
    final toSelf = Uint8List.fromList([
      (payloadTypeTXTMSG << 2) | 1,
      0,
      selfKey[0],
      0x77,
      9,
      9,
    ]);
    expect((await rx(fromSelf)).fromSelf, isTrue);
    expect((await rx(toSelf)).fromSelf, isFalse);
  });
}
