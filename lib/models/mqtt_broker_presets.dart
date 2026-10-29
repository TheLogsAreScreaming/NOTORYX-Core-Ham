import 'mqtt_broker_settings.dart';

/// Broker choices are suggestions only, not endorsements or live services.
/// Users must confirm their network's hostname, authentication and topics.
class MqttBrokerPreset {
  const MqttBrokerPreset({
    required this.name,
    required this.host,
    required this.port,
    this.tls = true,
    this.webSocket = false,
    this.webSocketPath = '/mqtt',
    this.authMode = MqttAuthMode.password,
    this.note,
  });

  final String name;
  final String host;
  final int port;
  final bool tls;
  final bool webSocket;
  final String webSocketPath;
  final MqttAuthMode authMode;

  /// Shown under the preset so users know who runs the service.
  final String? note;
}

class MqttBrokerPresets {
  static const custom = MqttBrokerPreset(
    name: 'Custom broker',
    host: '',
    port: 8883,
  );

  static const local = MqttBrokerPreset(
    name: 'Local broker (configure address)',
    host: '',
    port: 1883,
    tls: false,
  );

  // Settings from meshcoretomqtt's presets/letsmesh.toml: secure WebSocket on
  // 443 at path "/", signed in with a token from the node's own key.
  static const _letsMeshNote =
      'LetsMesh is a community-run MeshCore packet analyzer, not part of '
      'NOTORYX and not endorsed by it. Sharing needs your radio connected '
      'and stays off until you turn it on.';

  static const letsMeshUs = MqttBrokerPreset(
    name: 'LetsMesh analyzer (US, community)',
    host: 'mqtt-us-v1.letsmesh.net',
    port: 443,
    webSocket: true,
    webSocketPath: '/',
    authMode: MqttAuthMode.radioToken,
    note: _letsMeshNote,
  );

  static const letsMeshEu = MqttBrokerPreset(
    name: 'LetsMesh analyzer (EU, community)',
    host: 'mqtt-eu-v1.letsmesh.net',
    port: 443,
    webSocket: true,
    webSocketPath: '/',
    authMode: MqttAuthMode.radioToken,
    note: _letsMeshNote,
  );

  // Settings from meshrank.net/meshcoretomqtt/meshrank.toml: TLS on 8883,
  // no sign-in; packets go under the node's own key and region code.
  static const meshRank = MqttBrokerPreset(
    name: 'MeshRank (community)',
    host: 'meshrank.net',
    port: 8883,
    note:
        'MeshRank is a community-run MeshCore network ranking, not part '
        'of NOTORYX and not endorsed by it.',
  );

  static const choices = <MqttBrokerPreset>[
    custom,
    local,
    letsMeshUs,
    letsMeshEu,
    meshRank,
  ];
}
