import 'mqtt_notice.dart';

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

  /// English text of [check], or null if the settings are valid.
  String? validate() => check()?.english;

  /// Why these settings are invalid, or null if they are valid.
  MqttNotice? check() {
    final normalizedHost = host.trim();
    if (normalizedHost.isEmpty ||
        normalizedHost.contains(RegExp(r'\s')) ||
        normalizedHost.contains('/') ||
        normalizedHost.contains('@') ||
        normalizedHost.contains(':')) {
      return const MqttNotice(MqttNoticeKind.invalidHost);
    }
    if (port < 1 || port > 65535) {
      return const MqttNotice(MqttNoticeKind.invalidPort);
    }
    if (useWebSocket &&
        (!webSocketPath.startsWith('/') ||
            webSocketPath.contains('#') ||
            webSocketPath.contains('?'))) {
      return const MqttNotice(MqttNoticeKind.invalidWebSocketPath);
    }
    final prefix = topicPrefix.trim();
    if (prefix.isEmpty ||
        prefix.startsWith('/') ||
        prefix.endsWith('/') ||
        prefix.contains('#') ||
        prefix.contains('+') ||
        prefix.contains(RegExp(r'\s'))) {
      return const MqttNotice(MqttNoticeKind.invalidTopicPrefix);
    }
    if (region.isNotEmpty && !RegExp(r'^[A-Za-z0-9]{2,8}$').hasMatch(region)) {
      return const MqttNotice(MqttNoticeKind.invalidRegion);
    }
    return null;
  }

  String get transportLabel {
    if (useWebSocket) return useTls ? 'WSS' : 'WS';
    return useTls ? 'MQTTS' : 'MQTT';
  }
}
