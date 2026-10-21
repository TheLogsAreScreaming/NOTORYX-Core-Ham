import '../models/mqtt_broker_settings.dart';

/// Why a broker connection attempt failed. Never carries broker replies,
/// credentials or packet contents.
enum MqttConnectFailure {
  badCredentials,
  notAuthorized,
  rejected,
  unreachable,
  tls,
  unsupportedTransport,
}

extension MqttConnectFailureInfo on MqttConnectFailure {
  /// Stable category for [MqttConnectionDiagnostics.lastErrorCategory].
  String get category => name;

  String get message => switch (this) {
    MqttConnectFailure.badCredentials =>
      'The broker rejected the username or password.',
    MqttConnectFailure.notAuthorized =>
      'This account is not authorized on the broker.',
    MqttConnectFailure.rejected => 'The broker refused the connection.',
    MqttConnectFailure.unreachable => 'The broker could not be reached.',
    MqttConnectFailure.tls =>
      'The secure (TLS) connection could not be established.',
    MqttConnectFailure.unsupportedTransport =>
      'This platform only supports MQTT over WebSocket.',
  };

  /// Only network-level failures are worth retrying automatically; a wrong
  /// password or a TLS error won't fix itself.
  bool get retryable => this == MqttConnectFailure.unreachable;
}

/// One broker session. Implementations wrap a concrete MQTT client so the
/// service can be tested without a network.
abstract class MqttTransport {
  /// Connects and returns null on success, or why it failed.
  Future<MqttConnectFailure?> connect({String? username, String? password});

  /// Closes the session. Does not trigger [onConnectionLost].
  void disconnect();

  /// Called when an established session drops without [disconnect].
  set onConnectionLost(void Function()? callback);
}

typedef MqttTransportFactory =
    MqttTransport Function(MqttBrokerSettings settings, String clientId);
