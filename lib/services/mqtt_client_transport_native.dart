import 'dart:io';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../models/mqtt_broker_settings.dart';
import 'mqtt_client_failure.dart';
import 'mqtt_transport.dart';

MqttTransport createMqttClientTransport(
  MqttBrokerSettings settings,
  String clientId,
) => MqttClientTransport(settings, clientId);

/// TCP, TLS and WebSocket broker sessions via [MqttServerClient].
class MqttClientTransport implements MqttTransport {
  MqttClientTransport(MqttBrokerSettings settings, String clientId)
    : _client = _buildClient(settings, clientId) {
    _client.onDisconnected = _handleDisconnected;
  }

  final MqttServerClient _client;
  void Function()? _onConnectionLost;
  bool _established = false;
  bool _closing = false;

  static MqttServerClient _buildClient(
    MqttBrokerSettings settings,
    String clientId,
  ) {
    final host = settings.host.trim();
    final server = settings.useWebSocket
        ? '${settings.useTls ? 'wss' : 'ws'}://$host${settings.webSocketPath}'
        : host;
    // Retries are owned by MqttBrokerService's reconnect policy.
    return MqttServerClient.withPort(
        server,
        clientId,
        settings.port,
        maxConnectionAttempts: 1,
      )
      ..useWebSocket = settings.useWebSocket
      ..secure = settings.useTls && !settings.useWebSocket
      ..keepAlivePeriod = 30
      ..connectTimeoutPeriod = 10000
      ..autoReconnect = false
      ..setProtocolV311()
      ..logging(on: false)
      ..connectionMessage = MqttConnectMessage()
          .withClientIdentifier(clientId)
          .startClean();
  }

  @override
  set onConnectionLost(void Function()? callback) =>
      _onConnectionLost = callback;

  @override
  Future<MqttConnectFailure?> connect({
    String? username,
    String? password,
  }) async {
    try {
      await _client.connect(username, password);
    } on HandshakeException {
      return MqttConnectFailure.tls;
    } on TlsException {
      return MqttConnectFailure.tls;
    } on NoConnectionException {
      return mqttFailureFromStatus(_client.connectionStatus) ??
          MqttConnectFailure.unreachable;
    } on Object {
      return MqttConnectFailure.unreachable;
    }
    final failure = mqttFailureFromStatus(_client.connectionStatus);
    if (failure != null) return failure;
    _established = true;
    return null;
  }

  void _handleDisconnected() {
    final wasEstablished = _established;
    _established = false;
    if (_closing || !wasEstablished) return;
    _onConnectionLost?.call();
  }

  @override
  void disconnect() {
    _closing = true;
    _established = false;
    _client.disconnect();
  }
}
