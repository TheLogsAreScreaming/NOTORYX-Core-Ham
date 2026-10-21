import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../models/mqtt_broker_settings.dart';
import 'mqtt_client_failure.dart';
import 'mqtt_transport.dart';

MqttTransport createMqttClientTransport(
  MqttBrokerSettings settings,
  String clientId,
) => settings.useWebSocket
    ? MqttClientTransport(settings, clientId)
    : const _UnsupportedTransport();

/// Browsers can't open raw TCP sockets, so web supports only ws/wss.
class _UnsupportedTransport implements MqttTransport {
  const _UnsupportedTransport();

  @override
  Future<MqttConnectFailure?> connect({
    String? username,
    String? password,
  }) async => MqttConnectFailure.unsupportedTransport;

  @override
  void disconnect() {}

  @override
  set onConnectionLost(void Function()? callback) {}
}

/// WebSocket broker sessions via [MqttBrowserClient].
class MqttClientTransport implements MqttTransport {
  MqttClientTransport(MqttBrokerSettings settings, String clientId)
    : _client = _buildClient(settings, clientId) {
    _client.onDisconnected = _handleDisconnected;
  }

  final MqttBrowserClient _client;
  void Function()? _onConnectionLost;
  bool _established = false;
  bool _closing = false;

  static MqttBrowserClient _buildClient(
    MqttBrokerSettings settings,
    String clientId,
  ) {
    final scheme = settings.useTls ? 'wss' : 'ws';
    final server = '$scheme://${settings.host.trim()}${settings.webSocketPath}';
    return MqttBrowserClient.withPort(
        server,
        clientId,
        settings.port,
        maxConnectionAttempts: 1,
      )
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
