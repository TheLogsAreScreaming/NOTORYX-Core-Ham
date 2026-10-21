import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/mqtt_broker_settings.dart';
import 'package:meshcore_open/models/mqtt_mesh_packet.dart';
import 'package:meshcore_open/models/mqtt_publish_policy.dart';
import 'package:meshcore_open/models/radio_rx_packet.dart';

import '../support/mesh_packet_fixtures.dart';

MeshPacketInfo _ofType(int type, {int route = 1}) => MeshPacketInfo.tryParse(
  Uint8List.fromList([(type << 2) | route, 0, 0xAA, 0xBB]),
)!;

void main() {
  const policy = MqttPublishPolicy();
  const on = MqttPublishSettings(enabled: true);

  test('shares nothing until enabled', () {
    expect(
      policy.check(
        _ofType(0x04),
        fromSelf: false,
        settings: const MqttPublishSettings(),
      ),
      MqttPublishSkip.disabled,
    );
  });

  test('shares public mesh traffic once enabled', () {
    for (final type in MqttPublishPolicy.sharedTypes) {
      expect(
        policy.check(_ofType(type), fromSelf: false, settings: on),
        isNull,
        reason: 'type $type',
      );
    }
  });

  test('holds back direct traffic unless allowed', () {
    for (final type in MqttPublishPolicy.directTypes) {
      expect(
        policy.check(_ofType(type), fromSelf: false, settings: on),
        MqttPublishSkip.directTraffic,
      );
      expect(
        policy.check(
          _ofType(type),
          fromSelf: false,
          settings: const MqttPublishSettings(
            enabled: true,
            includeDirectTraffic: true,
          ),
        ),
        isNull,
      );
    }
  });

  test('holds back own traffic unless allowed', () {
    expect(
      policy.check(_ofType(0x04), fromSelf: true, settings: on),
      MqttPublishSkip.ownTraffic,
    );
    expect(
      policy.check(
        _ofType(0x04),
        fromSelf: true,
        settings: const MqttPublishSettings(
          enabled: true,
          includeOwnTraffic: true,
        ),
      ),
      isNull,
    );
  });

  test('never shares custom or unassigned payload types', () {
    const everything = MqttPublishSettings(
      enabled: true,
      includeDirectTraffic: true,
      includeOwnTraffic: true,
    );
    for (final type in [0x0C, 0x0D, 0x0E, 0x0F]) {
      expect(
        policy.check(_ofType(type), fromSelf: false, settings: everything),
        MqttPublishSkip.privateType,
      );
    }
  });

  test('builds the publish topic only with a region and key', () {
    const settings = MqttBrokerSettings(
      host: 'b.test',
      port: 8883,
      region: 'PHL',
    );
    expect(
      MqttPacketTopics.publishFor(settings, 'ABCD'),
      'meshcore/PHL/ABCD/packets',
    );
    expect(
      MqttPacketTopics.publishFor(
        const MqttBrokerSettings(host: 'b.test', port: 8883),
        'ABCD',
      ),
      isNull,
    );
    expect(MqttPacketTopics.publishFor(settings, ''), isNull);
  });

  test('encodes the meshcoretomqtt observer format', () {
    final raw = groupTextPacket(
      psk: Uint8List(16),
      text: 'Alice: hi',
      path: [4, 5],
    );
    final info = MeshPacketInfo.tryParse(raw)!;
    final bytes = encodeObserverPacket(
      RadioRxPacket(
        raw: raw,
        snr: 6.75,
        rssi: -101,
        receivedAt: DateTime.utc(2026, 10, 21, 18, 5, 9),
      ),
      info,
      origin: 'Base camp',
      originId: 'ABCDEF',
    );
    final json = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
    expect(json['type'], 'PACKET');
    expect(json['direction'], 'rx');
    expect(json['origin'], 'Base camp');
    expect(json['origin_id'], 'ABCDEF');
    expect(json['timestamp'], '2026-10-21T18:05:09.000Z');
    expect(json['time'], '18:05:09');
    expect(json['date'], '21/10/2026');
    expect(json['route'], 'F');
    expect(json['packet_type'], '5');
    expect(json['len'], '${raw.length}');
    expect(json['payload_len'], '${info.payload.length}');
    expect(json['SNR'], '7');
    expect(json['RSSI'], '-101');
    expect(json['hash'], info.hash.toUpperCase());
    expect(json['raw'], hex(raw).toUpperCase());

    final parsed = MqttMeshPacket.tryParse(
      'meshcore/PHL/ABCDEF/packets',
      bytes,
    )!;
    expect(parsed.raw, raw);
    expect(parsed.hash, info.hash);
    expect(parsed.observerName, 'Base camp');
    expect(parsed.rssi, -101);
  });
}
