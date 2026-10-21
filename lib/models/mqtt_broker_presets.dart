/// Broker choices are suggestions only, not endorsements or live services.
/// Users must confirm their network's hostname, authentication and topics.
class MqttBrokerPreset {
  const MqttBrokerPreset({
    required this.name,
    required this.host,
    required this.port,
    this.tls = true,
    this.webSocket = false,
  });

  final String name;
  final String host;
  final int port;
  final bool tls;
  final bool webSocket;
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

  static const choices = <MqttBrokerPreset>[custom, local];
}
