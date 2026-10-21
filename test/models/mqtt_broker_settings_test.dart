import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/mqtt_broker_settings.dart';

void main() {
  test('accepts a TLS broker with a plain topic prefix', () {
    const settings = MqttBrokerSettings(
      host: 'broker.example.org',
      port: 8883,
    );
    expect(settings.validate(), isNull);
    expect(settings.transportLabel, 'MQTTS');
  });

  test('rejects credentials embedded in the broker host', () {
    const settings = MqttBrokerSettings(
      host: 'user:password@broker.example.org',
      port: 8883,
    );
    expect(settings.validate(), isNotNull);
  });

  test('rejects invalid port and wildcard topics', () {
    const invalidPort = MqttBrokerSettings(host: 'broker.test', port: 0);
    const wildcard = MqttBrokerSettings(
      host: 'broker.test',
      port: 8883,
      topicPrefix: 'meshcore/#',
    );
    expect(invalidPort.validate(), isNotNull);
    expect(wildcard.validate(), isNotNull);
  });

  test('requires a valid WebSocket path', () {
    const invalid = MqttBrokerSettings(
      host: 'broker.test',
      port: 443,
      useWebSocket: true,
      webSocketPath: 'mqtt',
    );
    const valid = MqttBrokerSettings(
      host: 'broker.test',
      port: 443,
      useWebSocket: true,
    );
    expect(invalid.validate(), isNotNull);
    expect(valid.validate(), isNull);
    expect(valid.transportLabel, 'WSS');
  });
}
