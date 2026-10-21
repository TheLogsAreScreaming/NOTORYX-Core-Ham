/// Validated connection settings for a future MeshCore MQTT transport.
///
/// Credentials must be managed separately in secure storage. Never serialize
/// usernames, passwords, or radio private keys into this configuration.
class MqttBrokerSettings {
  const MqttBrokerSettings({
    required this.host,
    required this.port,
    this.useTls = true,
    this.useWebSocket = false,
    this.webSocketPath = '/mqtt',
    this.topicPrefix = 'meshcore',
  });

  final String host;
  final int port;
  final bool useTls;
  final bool useWebSocket;
  final String webSocketPath;
  final String topicPrefix;

  String? validate() {
    final normalizedHost = host.trim();
    if (normalizedHost.isEmpty ||
        normalizedHost.contains(RegExp(r'\\s')) ||
        normalizedHost.contains('/') ||
        normalizedHost.contains('@') ||
        normalizedHost.contains(':')) {
      return 'Enter a hostname or IPv4 address without a scheme or port.';
    }
    if (port < 1 || port > 65535) {
      return 'Port must be between 1 and 65535.';
    }
    if (useWebSocket &&
        (!webSocketPath.startsWith('/') ||
            webSocketPath.contains('#') ||
            webSocketPath.contains('?'))) {
      return 'WebSocket path must begin with / and contain no query or fragment.';
    }
    final prefix = topicPrefix.trim();
    if (prefix.isEmpty ||
        prefix.startsWith('/') ||
        prefix.endsWith('/') ||
        prefix.contains('#') ||
        prefix.contains('+') ||
        prefix.contains(RegExp(r'\\s'))) {
      return 'Topic prefix must be a nonempty MQTT path without wildcards.';
    }
    return null;
  }

  String get transportLabel {
    if (useWebSocket) return useTls ? 'WSS' : 'WS';
    return useTls ? 'MQTTS' : 'MQTT';
  }
}
