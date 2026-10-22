import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/mqtt_broker_presets.dart';
import 'package:meshcore_open/models/mqtt_broker_settings.dart';
import 'package:meshcore_open/models/mqtt_mesh_packet.dart';
import 'package:meshcore_open/models/mqtt_observer_status.dart';

void main() {
  test('status topics follow <prefix>/<region>/<KEY>/status', () {
    const settings = MqttBrokerSettings(
      host: 'b.test',
      port: 8883,
      region: 'PHL',
    );
    expect(
      MqttPacketTopics.statusFor(settings, 'AB12'),
      'meshcore/PHL/AB12/status',
    );
    expect(
      MqttPacketTopics.statusFor(
        const MqttBrokerSettings(host: 'b.test', port: 8883),
        'AB12',
      ),
      isNull,
    );
  });

  test('encodes the meshcoretomqtt status fields', () {
    final payload = encodeObserverStatus(
      MqttObserverPresence.offline,
      at: DateTime.utc(2026, 10, 21, 18, 30, 5),
      origin: 'Base 🏔',
      originId: 'AB12',
      clientVersion: 'notoryx-core/10.0.0',
    );
    expect(jsonDecode(utf8.decode(payload)), {
      'status': 'offline',
      'timestamp': '2026-10-21T18:30:05.000Z',
      'origin': 'Base 🏔',
      'origin_id': 'AB12',
      'radio': 'unknown',
      'model': 'unknown',
      'firmware_version': 'unknown',
      'client_version': 'notoryx-core/10.0.0',
    });
  });

  test('formats radio settings like the CLI get radio reply', () {
    expect(
      MqttObserverDetails.radioFrom(
        freqHz: 910525000,
        bwHz: 62500,
        sf: 7,
        cr: 5,
      ),
      '910.525,62.5,7,5',
    );
    expect(
      MqttObserverDetails.radioFrom(
        freqHz: 869000000,
        bwHz: 250000,
        sf: 11,
        cr: 5,
      ),
      '869,250,11,5',
    );
    expect(MqttObserverDetails.radioFrom(freqHz: 1, bwHz: 1, sf: 7), isNull);
  });

  test('LetsMesh presets use token sign-in over secure WebSocket', () {
    for (final preset in [
      MqttBrokerPresets.letsMeshUs,
      MqttBrokerPresets.letsMeshEu,
    ]) {
      expect(preset.port, 443);
      expect(preset.tls, isTrue);
      expect(preset.webSocket, isTrue);
      expect(preset.webSocketPath, '/');
      expect(preset.authMode, MqttAuthMode.radioToken);
      expect(preset.note, contains('community'));
      expect(preset.note, contains('not endorsed'));
      expect(MqttBrokerPresets.choices, contains(preset));
    }
    expect(MqttBrokerPresets.letsMeshUs.host, 'mqtt-us-v1.letsmesh.net');
    expect(MqttBrokerPresets.letsMeshEu.host, 'mqtt-eu-v1.letsmesh.net');
  });
}
