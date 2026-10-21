import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/mqtt_broker_endpoint.dart';
import 'package:meshcore_open/models/mqtt_broker_settings.dart';

void main() {
  String address(MqttBrokerSettings settings) =>
      MqttBrokerEndpoint(settings).address;

  test('builds TCP addresses with and without TLS', () {
    expect(
      address(const MqttBrokerSettings(host: 'broker.test', port: 8883)),
      'mqtts://broker.test:8883',
    );
    expect(
      address(
        const MqttBrokerSettings(
          host: 'broker.test',
          port: 1883,
          useTls: false,
        ),
      ),
      'mqtt://broker.test:1883',
    );
  });

  test('builds WebSocket addresses with the configured path', () {
    expect(
      address(
        const MqttBrokerSettings(
          host: 'broker.test',
          port: 443,
          useWebSocket: true,
          webSocketPath: '/ws',
        ),
      ),
      'wss://broker.test:443/ws',
    );
    expect(
      address(
        const MqttBrokerSettings(
          host: 'broker.test',
          port: 80,
          useTls: false,
          useWebSocket: true,
        ),
      ),
      'ws://broker.test:80/mqtt',
    );
  });

  test('trims surrounding whitespace from the host', () {
    expect(
      address(const MqttBrokerSettings(host: '  broker.test ', port: 8883)),
      'mqtts://broker.test:8883',
    );
  });
}
