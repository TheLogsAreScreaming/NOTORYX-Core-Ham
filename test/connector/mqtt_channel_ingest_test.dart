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

  test('flags a message first heard via MQTT', () {
    connector.ingestMqttRawPacket(
      groupTextPacket(psk: psk, text: 'Alice: summit', path: [3]),
    );
    final message = connector.getChannelMessages(channel).single;
    expect(message.viaMqtt, isTrue);
    expect(message.repeatCount, 0);
  });

  test('radio copy after MQTT clears the flag without counting a repeat', () {
    connector.ingestMqttRawPacket(
      groupTextPacket(psk: psk, text: 'Alice: summit', path: [3, 4]),
    );
    radioRx(groupTextPacket(psk: psk, text: 'Alice: summit', path: [7]));
    var message = connector.getChannelMessages(channel).single;
    expect(message.viaMqtt, isFalse);
    expect(message.repeatCount, 0);
    // The observer's path is replaced by the radio's own.
    expect(message.pathBytes, [7]);
    expect(message.pathVariants, [
      [7],
    ]);

    radioRx(groupTextPacket(psk: psk, text: 'Alice: summit', path: [7, 8]));
    message = connector.getChannelMessages(channel).single;
    expect(message.viaMqtt, isFalse);
    expect(message.repeatCount, 1);
  });

  test('MQTT copy after radio leaves the message unflagged', () {
    final raw = groupTextPacket(psk: psk, text: 'Alice: summit');
    radioRx(raw);
    connector.ingestMqttRawPacket(raw);
    final message = connector.getChannelMessages(channel).single;
    expect(message.viaMqtt, isFalse);
    expect(message.repeatCount, 0);
  });

  test('radio-only messages are never flagged', () {
    radioRx(groupTextPacket(psk: psk, text: 'Alice: summit'));
    expect(connector.getChannelMessages(channel).single.viaMqtt, isFalse);
  });

  test('ignores garbage without throwing', () {
    connector.ingestMqttRawPacket(Uint8List.fromList([0x15]));
    connector.ingestMqttRawPacket(Uint8List.fromList([0x15, 0x3F, 1]));
    expect(connector.getChannelMessages(channel), isEmpty);
  });
}
