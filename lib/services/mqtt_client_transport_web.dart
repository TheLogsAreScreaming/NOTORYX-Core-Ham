import 'dart:async';
import 'dart:typed_data';

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

  @override
  void subscribe(String topic) {}

  @override
  set onMessage(MqttMessageHandler? handler) {}

  @override
  set onSubscribeFailed(void Function(String topic)? callback) {}
}

/// WebSocket broker sessions via [MqttBrowserClient].
class MqttClientTransport implements MqttTransport {
  MqttClientTransport(MqttBrokerSettings settings, String clientId)
    : _client = _buildClient(settings, clientId) {
    _client.onDisconnected = _handleDisconnected;
    _client.onSubscribeFail = (topic) => _onSubscribeFailed?.call(topic);
  }

  final MqttBrowserClient _client;
  void Function()? _onConnectionLost;
  MqttMessageHandler? _onMessage;
  void Function(String topic)? _onSubscribeFailed;
  StreamSubscription<List<MqttReceivedMessage<MqttMessage>>>? _updates;
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
  set onMessage(MqttMessageHandler? handler) => _onMessage = handler;

  @override
  set onSubscribeFailed(void Function(String topic)? callback) =>
      _onSubscribeFailed = callback;

  @override
  void subscribe(String topic) {
    _updates ??= _client.updates?.listen(_handleUpdates);
    _client.subscribe(topic, MqttQos.atMostOnce);
  }

  void _handleUpdates(List<MqttReceivedMessage<MqttMessage>> messages) {
    final handler = _onMessage;
    if (handler == null) return;
    for (final received in messages) {
      final message = received.payload;
      if (message is! MqttPublishMessage) continue;
      handler(
        received.topic,
        Uint8List.fromList(message.payload.message.toList()),
      );
    }
  }

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
    unawaited(_updates?.cancel());
    _updates = null;
    _established = false;
    _client.disconnect();
  }
}
