import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/mqtt_broker_settings.dart';
import 'package:meshcore_open/models/mqtt_settings_codec.dart';

void main() {
  const codec = MqttSettingsCodec();

  test('round-trips broker settings', () {
    const settings = MqttBrokerSettings(
      host: 'broker.example.org',
      port: 443,
      useWebSocket: true,
      webSocketPath: '/ws',
      topicPrefix: 'mesh/philly',
    );
    final decoded = codec.decode(codec.encode(settings));
    expect(decoded, isNotNull);
    expect(decoded!.host, 'broker.example.org');
    expect(decoded.port, 443);
    expect(decoded.useTls, isTrue);
    expect(decoded.useWebSocket, isTrue);
    expect(decoded.webSocketPath, '/ws');
    expect(decoded.topicPrefix, 'mesh/philly');
  });

  test('encodes only non-secret keys', () {
    final data = codec.encode(
      const MqttBrokerSettings(host: 'broker.test', port: 8883),
    );
    expect(
      data.keys,
      unorderedEquals(<String>[
        'host',
        'port',
        'useTls',
        'useWebSocket',
        'webSocketPath',
        'topicPrefix',
        'region',
        'authMode',
      ]),
    );
  });

  test('round-trips the auth mode and defaults to password', () {
    const settings = MqttBrokerSettings(
      host: 'broker.test',
      port: 443,
      authMode: MqttAuthMode.radioToken,
    );
    expect(
      codec.decode(codec.encode(settings))?.authMode,
      MqttAuthMode.radioToken,
    );
    expect(
      codec.decode({'host': 'broker.test', 'port': 8883})?.authMode,
      MqttAuthMode.password,
    );
    expect(
      codec.decode({
        'host': 'b.test',
        'port': 1,
        'authMode': 'bogus',
      })?.authMode,
      MqttAuthMode.password,
    );
  });

  test('applies secure defaults for missing optional keys', () {
    final decoded = codec.decode({'host': 'broker.test', 'port': 8883});
    expect(decoded, isNotNull);
    expect(decoded!.useTls, isTrue);
    expect(decoded.useWebSocket, isFalse);
    expect(decoded.webSocketPath, '/mqtt');
    expect(decoded.topicPrefix, 'meshcore');
  });

  test('returns null for missing, mistyped or invalid data', () {
    expect(codec.decode({}), isNull);
    expect(codec.decode({'host': 'broker.test', 'port': '8883'}), isNull);
    expect(codec.decode({'host': 'user@broker.test', 'port': 8883}), isNull);
    expect(codec.decode({'host': 'broker.test', 'port': 0}), isNull);
  });
}
