/// MQTT state is tracked separately from the physical MeshCore radio.
enum MqttConnectionStatus {
  notConfigured,
  disconnected,
  connecting,
  connected,
  reconnecting,
  error,
}

extension MqttConnectionStatusLabel on MqttConnectionStatus {
  String get label => switch (this) {
    MqttConnectionStatus.notConfigured => 'Not configured',
    MqttConnectionStatus.disconnected => 'Disconnected',
    MqttConnectionStatus.connecting => 'Connecting',
    MqttConnectionStatus.connected => 'Connected',
    MqttConnectionStatus.reconnecting => 'Reconnecting',
    MqttConnectionStatus.error => 'Connection error',
  };

  bool get isConnected => this == MqttConnectionStatus.connected;
}
