/// How the app signs in to the broker.
enum MqttAuthMode {
  /// Optional username and password from the keychain.
  password,

  /// A short-lived token signed by the connected radio's own key, with the
  /// username `v1_<public key>` (meshcoretomqtt / LetsMesh style).
  radioToken,
}

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
    this.region = '',
    this.authMode = MqttAuthMode.password,
  });

  final String host;
  final int port;
  final bool useTls;
  final bool useWebSocket;
  final String webSocketPath;
  final String topicPrefix;

  /// Observer region (usually a 3-letter IATA code) to subscribe to, or
  /// empty for every region under [topicPrefix].
  final String region;

  final MqttAuthMode authMode;

  String? validate() {
    final normalizedHost = host.trim();
    if (normalizedHost.isEmpty ||
        normalizedHost.contains(RegExp(r'\s')) ||
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
        prefix.contains(RegExp(r'\s'))) {
      return 'Topic prefix must be a nonempty MQTT path without wildcards.';
    }
    if (region.isNotEmpty && !RegExp(r'^[A-Za-z0-9]{2,8}$').hasMatch(region)) {
      return 'Region must be 2-8 letters or digits, such as PHL.';
    }
    return null;
  }

  String get transportLabel {
    if (useWebSocket) return useTls ? 'WSS' : 'WS';
    return useTls ? 'MQTTS' : 'MQTT';
  }
}
