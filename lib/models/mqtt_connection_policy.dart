import 'mqtt_broker_settings.dart';

/// Prevents accidental cleartext broker connections by default.
class MqttConnectionPolicy {
  const MqttConnectionPolicy();

  String? validate(
    MqttBrokerSettings settings, {
    bool allowInsecureLocalBroker = false,
  }) {
    final error = settings.validate();
    if (error != null) return error;
    if (settings.useTls) return null;
    if (!allowInsecureLocalBroker) {
      return 'TLS is required unless insecure local broker access is explicitly enabled.';
    }
    final host = settings.host.trim().toLowerCase();
    if (host == 'localhost' ||
        host == '127.0.0.1' ||
        host.endsWith('.local') ||
        host.startsWith('192.168.') ||
        host.startsWith('10.')) {
      return null;
    }
    return 'Cleartext MQTT is restricted to explicitly approved local hosts.';
  }
}
