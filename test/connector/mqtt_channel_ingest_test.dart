import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/mesh_packet_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final psk = Uint8List.fromList(List.generate(16, (i) => 0xA0 + i));
  final channel = Channel(index: 1, name: 'Hike', psk: psk);
  late MeshCoreConnector connector;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    connector = MeshCoreConnector()..debugSetChannels([channel]);
  });

  void radioRx(Uint8List raw) => connector.handleFrameForTest([
    pushCodeLogRxData,
    0x1C, // SNR
    0xA4, // RSSI
    ...raw,
  ]);

  test('adds a channel message heard via MQTT', () {
    connector.ingestMqttRawPacket(
      groupTextPacket(psk: psk, text: 'Alice: summit at noon', path: [3]),
    );
    final messages = connector.getChannelMessages(channel);
    expect(messages, hasLength(1));
    expect(messages.single.senderName, 'Alice');
    expect(messages.single.text, 'summit at noon');
    expect(messages.single.isOutgoing, isFalse);
  });

  test('ignores packets for channels the user has not joined', () {
    connector.ingestMqttRawPacket(
      groupTextPacket(psk: Uint8List(16), text: 'Bob: elsewhere'),
    );
    expect(connector.getChannelMessages(channel), isEmpty);
  });

  test('does not count MQTT copies as radio repeats', () {
    final raw = groupTextPacket(psk: psk, text: 'Alice: hi');
    radioRx(raw);
    connector.ingestMqttRawPacket(raw);
    connector.ingestMqttRawPacket(
      groupTextPacket(psk: psk, text: 'Alice: hi', path: [5, 6]),
    );
    final messages = connector.getChannelMessages(channel);
    expect(messages, hasLength(1));
    expect(messages.single.repeatCount, 0);

    radioRx(groupTextPacket(psk: psk, text: 'Alice: hi', path: [5]));
    expect(connector.getChannelMessages(channel).single.repeatCount, 1);
  });

  test('ignores garbage without throwing', () {
    connector.ingestMqttRawPacket(Uint8List.fromList([0x15]));
    connector.ingestMqttRawPacket(Uint8List.fromList([0x15, 0x3F, 1]));
    expect(connector.getChannelMessages(channel), isEmpty);
  });
}
