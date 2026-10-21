import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/mqtt_broker_settings.dart';
import 'package:meshcore_open/models/mqtt_mesh_packet.dart';

import '../support/mesh_packet_fixtures.dart';

void main() {
  const topic = 'meshcore/PHL/AB12CD34/packets';
  final psk = Uint8List.fromList(List.generate(16, (i) => i));

  Uint8List json(Map<String, Object?> data) =>
      Uint8List.fromList(utf8.encode(jsonEncode(data)));

  test('parses an observer packet', () {
    final raw = groupTextPacket(psk: psk, text: 'Alice: hi', path: [1, 2]);
    final packet = MqttMeshPacket.tryParse(topic, observerMessage(raw))!;
    expect(packet.raw, raw);
    expect(packet.payloadType, 5);
    expect(packet.payloadTypeLabel, 'Channel message');
    expect(packet.routeLabel, 'Flood');
    expect(packet.hopCount, 2);
    expect(packet.payload, raw.sublist(4));
    expect(packet.region, 'PHL');
    expect(packet.observerKey, 'AB12CD34');
    expect(packet.observerName, 'Hilltop');
    expect(packet.snr, 7.5);
    expect(packet.rssi, -92);
    expect(packet.hash, hasLength(16));
  });

  test('hashes the same packet identically whatever its path', () {
    final direct = groupTextPacket(psk: psk, text: 'Alice: hi');
    final relayed = groupTextPacket(psk: psk, text: 'Alice: hi', path: [9]);
    expect(
      MqttMeshPacket.tryParse(topic, observerMessage(direct))!.hash,
      MqttMeshPacket.tryParse(topic, observerMessage(relayed))!.hash,
    );
  });

  test('skips transport codes before the path', () {
    final raw = Uint8List.fromList([0x14, 1, 2, 3, 4, 1, 0xAA, 0x01, 0x02]);
    final packet = MqttMeshPacket.tryParse(topic, observerMessage(raw))!;
    expect(packet.routeLabel, 'Transport flood');
    expect(packet.hopCount, 1);
    expect(packet.payload, [0x01, 0x02]);
  });

  test('rejects malformed or foreign messages', () {
    final raw = groupTextPacket(psk: psk, text: 'Alice: hi');
    expect(MqttMeshPacket.tryParse(topic, utf8.encode('not json')), isNull);
    expect(MqttMeshPacket.tryParse(topic, json({'type': 'STATUS'})), isNull);
    expect(
      MqttMeshPacket.tryParse(topic, observerMessage(raw, direction: 'tx')),
      isNull,
    );
    expect(
      MqttMeshPacket.tryParse(topic, json({'type': 'PACKET', 'raw': 'XYZ1'})),
      isNull,
    );
    expect(
      MqttMeshPacket.tryParse(topic, json({'type': 'PACKET', 'raw': '150'})),
      isNull,
    );
    // Path claims 5 hops but the packet ends after 1 byte of path.
    expect(
      MqttMeshPacket.tryParse(topic, json({'type': 'PACKET', 'raw': '150501'})),
      isNull,
    );
    expect(
      MqttMeshPacket.tryParse(
        topic,
        json({'type': 'PACKET', 'raw': '15${'00' * 300}'}),
      ),
      isNull,
    );
    expect(
      MqttMeshPacket.tryParse(
        topic,
        Uint8List(mqttMeshPacketMaxPayloadBytes + 1),
      ),
      isNull,
    );
  });

  test('builds the subscription from prefix and region', () {
    expect(
      MqttPacketTopics.subscriptionFor(
        const MqttBrokerSettings(host: 'b.test', port: 8883),
      ),
      'meshcore/+/+/packets',
    );
    expect(
      MqttPacketTopics.subscriptionFor(
        const MqttBrokerSettings(
          host: 'b.test',
          port: 8883,
          topicPrefix: 'mesh/us',
          region: 'PHL',
        ),
      ),
      'mesh/us/PHL/+/packets',
    );
  });

  test('validates the region code', () {
    MqttBrokerSettings withRegion(String region) =>
        MqttBrokerSettings(host: 'b.test', port: 8883, region: region);
    expect(withRegion('').validate(), isNull);
    expect(withRegion('PHL').validate(), isNull);
    expect(withRegion('P').validate(), isNotNull);
    expect(withRegion('PH/L').validate(), isNotNull);
    expect(withRegion('#').validate(), isNotNull);
  });
}
