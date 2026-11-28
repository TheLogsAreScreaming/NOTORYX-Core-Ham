import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/models/region_scope.dart';
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

  // MQTT observers share what radios log: ham frames with their station ID.
  void ingest(Uint8List raw) => connector.ingestMqttRawPacket(onAir(raw));

  void radioRx(Uint8List raw) => connector.handleFrameForTest([
    pushCodeLogRxData,
    0x1C, // SNR
    0xA4, // RSSI
    ...onAir(raw),
  ]);

  test('adds a channel message heard via MQTT', () {
    ingest(groupTextPacket(psk: psk, text: 'Alice: summit at noon', path: [3]));
    final messages = connector.getChannelMessages(channel);
    expect(messages, hasLength(1));
    expect(messages.single.senderName, 'Alice');
    expect(messages.single.text, 'summit at noon');
    expect(messages.single.isOutgoing, isFalse);
  });

  test('ignores stock MeshCore packets without a station ID', () {
    connector.ingestMqttRawPacket(
      groupTextPacket(psk: psk, text: 'Alice: Part 15 mesh'),
    );
    expect(connector.getChannelMessages(channel), isEmpty);
  });

  test('ignores packets for channels the user has not joined', () {
    ingest(groupTextPacket(psk: Uint8List(16), text: 'Bob: elsewhere'));
    expect(connector.getChannelMessages(channel), isEmpty);
  });

  test('does not count MQTT copies as radio repeats', () {
    final raw = groupTextPacket(psk: psk, text: 'Alice: hi');
    radioRx(raw);
    ingest(raw);
    ingest(groupTextPacket(psk: psk, text: 'Alice: hi', path: [5, 6]));
    final messages = connector.getChannelMessages(channel);
    expect(messages, hasLength(1));
    expect(messages.single.repeatCount, 0);

    radioRx(groupTextPacket(psk: psk, text: 'Alice: hi', path: [5]));
    expect(connector.getChannelMessages(channel).single.repeatCount, 1);
  });

  test('flags a message first heard via MQTT', () {
    ingest(groupTextPacket(psk: psk, text: 'Alice: summit', path: [3]));
    final message = connector.getChannelMessages(channel).single;
    expect(message.viaMqtt, isTrue);
    expect(message.repeatCount, 0);
  });

  test('radio copy after MQTT clears the flag without counting a repeat', () {
    ingest(groupTextPacket(psk: psk, text: 'Alice: summit', path: [3, 4]));
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
    ingest(raw);
    final message = connector.getChannelMessages(channel).single;
    expect(message.viaMqtt, isFalse);
    expect(message.repeatCount, 0);
  });

  test('radio-only messages are never flagged', () {
    radioRx(groupTextPacket(psk: psk, text: 'Alice: summit'));
    expect(connector.getChannelMessages(channel).single.viaMqtt, isFalse);
  });

  test('ignores garbage without throwing', () {
    ingest(Uint8List.fromList([0x15]));
    ingest(Uint8List.fromList([0x15, 0x3F, 1]));
    expect(connector.getChannelMessages(channel), isEmpty);
  });

  /// [raw] re-sent as a region-scoped flood, with [region]'s transport code.
  Uint8List scoped(Uint8List raw, String region) {
    final pathLen = raw[1];
    final payload = Uint8List.fromList(raw.sublist(2 + pathLen));
    final code = regionTransportCode(regionKey(region), 5, payload);
    return Uint8List.fromList([
      0x14, // transport flood, GRP_TXT
      code & 0xFF,
      code >> 8,
      0,
      0,
      ...raw.sublist(1),
    ]);
  }

  test('a region-scoped post is tagged with its region', () {
    connector.debugRegionNames = {'usa', 'us-ne', 'ct'};
    radioRx(
      scoped(
        groupTextPacket(psk: psk, text: 'Alice: trail open', path: [3]),
        'ct',
      ),
    );
    final message = connector.getChannelMessages(channel).single;
    expect(message.text, 'trail open');
    expect(message.region, 'ct');
  });

  test('an unknown region shows as regional, an unscoped post as none', () {
    connector.debugRegionNames = {'ct'};
    radioRx(
      scoped(
        groupTextPacket(psk: psk, text: 'Alice: one', timestamp: 1760000001),
        'elsewhere',
      ),
    );
    radioRx(groupTextPacket(psk: psk, text: 'Bob: two', timestamp: 1760000002));
    final messages = connector.getChannelMessages(channel);
    expect(messages.firstWhere((m) => m.text == 'one').region, unknownRegion);
    expect(messages.firstWhere((m) => m.text == 'two').region, isNull);
  });
}
