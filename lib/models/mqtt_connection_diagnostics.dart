import 'mqtt_connection_status.dart';

/// A safe UI snapshot: never include passwords, private keys or packet bodies.
class MqttConnectionDiagnostics {
  const MqttConnectionDiagnostics({
    required this.status,
    this.host,
    this.port,
    this.lastErrorCategory,
    this.reconnectAttempt = 0,
  });

  final MqttConnectionStatus status;
  final String? host;
  final int? port;
  final String? lastErrorCategory;
  final int reconnectAttempt;

  String get summary {
    final endpoint = host == null || port == null ? 'No broker' : '$host:$port';
    return '${status.label} — $endpoint';
  }

  Map<String, Object?> toSafeMap() {
    return {
      'status': status.label,
      'host': host,
      'port': port,
      'lastErrorCategory': lastErrorCategory,
      'reconnectAttempt': reconnectAttempt,
    };
  }
}
