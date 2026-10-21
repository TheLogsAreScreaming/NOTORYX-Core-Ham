import 'mqtt_broker_settings.dart';

/// Serializes only non-secret broker configuration.
class MqttSettingsCodec {
  const MqttSettingsCodec();

  Map<String, Object> encode(MqttBrokerSettings settings) {
    return {
      'host': settings.host,
      'port': settings.port,
      'useTls': settings.useTls,
      'useWebSocket': settings.useWebSocket,
      'webSocketPath': settings.webSocketPath,
      'topicPrefix': settings.topicPrefix,
    };
  }

  MqttBrokerSettings? decode(Map<String, dynamic> data) {
    try {
      final settings = MqttBrokerSettings(
        host: data['host'] as String,
        port: data['port'] as int,
        useTls: data['useTls'] as bool? ?? true,
        useWebSocket: data['useWebSocket'] as bool? ?? false,
        webSocketPath: data['webSocketPath'] as String? ?? '/mqtt',
        topicPrefix: data['topicPrefix'] as String? ?? 'meshcore',
      );
      return settings.validate() == null ? settings : null;
    } on Object {
      return null;
    }
  }
}
