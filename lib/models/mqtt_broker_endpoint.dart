import 'mqtt_broker_settings.dart';

/// Broker transport endpoint; contains no credentials.
class MqttBrokerEndpoint {
  const MqttBrokerEndpoint(this.settings);

  final MqttBrokerSettings settings;

  String get scheme {
    if (settings.useWebSocket) return settings.useTls ? 'wss' : 'ws';
    return settings.useTls ? 'mqtts' : 'mqtt';
  }

  String get address {
    final host = settings.host.trim();
    if (settings.useWebSocket) {
      return '$scheme://$host:${settings.port}${settings.webSocketPath}';
    }
    return '$scheme://$host:${settings.port}';
  }
}
