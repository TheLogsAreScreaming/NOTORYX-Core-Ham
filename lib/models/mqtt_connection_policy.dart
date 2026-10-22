import 'mqtt_broker_settings.dart';
import 'mqtt_notice.dart';

/// Prevents accidental cleartext broker connections by default.
class MqttConnectionPolicy {
  const MqttConnectionPolicy();

  /// English text of [check], or null if the connection is allowed.
  String? validate(
    MqttBrokerSettings settings, {
    bool allowInsecureLocalBroker = false,
  }) => check(
    settings,
    allowInsecureLocalBroker: allowInsecureLocalBroker,
  )?.english;

  /// Why [settings] may not be used, or null if they may.
  MqttNotice? check(
    MqttBrokerSettings settings, {
    bool allowInsecureLocalBroker = false,
  }) {
    final error = settings.check();
    if (error != null) return error;
    if (settings.useTls) return null;
    if (!allowInsecureLocalBroker) {
      return const MqttNotice(MqttNoticeKind.tlsRequired);
    }
    final host = settings.host.trim().toLowerCase();
    if (host == 'localhost' ||
        host == '127.0.0.1' ||
        host.endsWith('.local') ||
        host.startsWith('192.168.') ||
        host.startsWith('10.')) {
      return null;
    }
    return const MqttNotice(MqttNoticeKind.cleartextLocalOnly);
  }
}
