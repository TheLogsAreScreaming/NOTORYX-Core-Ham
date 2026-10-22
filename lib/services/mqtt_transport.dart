import 'dart:typed_data';

import '../models/mqtt_broker_settings.dart';
import '../models/mqtt_notice.dart';

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

  MqttNotice get notice => MqttNotice(switch (this) {
    MqttConnectFailure.badCredentials => MqttNoticeKind.badCredentials,
    MqttConnectFailure.notAuthorized => MqttNoticeKind.notAuthorized,
    MqttConnectFailure.rejected => MqttNoticeKind.connectionRefused,
    MqttConnectFailure.unreachable => MqttNoticeKind.unreachable,
    MqttConnectFailure.tls => MqttNoticeKind.tlsFailed,
    MqttConnectFailure.unsupportedTransport => MqttNoticeKind.webSocketOnly,
  });

  String get message => notice.english;

  /// Only network-level failures are worth retrying automatically; a wrong
  /// password or a TLS error won't fix itself.
  bool get retryable => this == MqttConnectFailure.unreachable;
}

/// A message the broker publishes for us if the session drops without a
/// clean disconnect (MQTT last will).
class MqttWill {
  const MqttWill({
    required this.topic,
    required this.payload,
    this.retain = true,
  });

  final String topic;

  /// UTF-8 text; MQTT 3.1.1 will messages are strings in mqtt_client.
  final String payload;
  final bool retain;
}

/// One broker session. Implementations wrap a concrete MQTT client so the
/// service can be tested without a network.
abstract class MqttTransport {
  /// Connects and returns null on success, or why it failed. A [will] is
  /// registered with the broker as part of the connection.
  Future<MqttConnectFailure?> connect({
    String? username,
    String? password,
    MqttWill? will,
  });

  /// Closes the session. Does not trigger [onConnectionLost].
  void disconnect();

  /// Called when an established session drops without [disconnect].
  set onConnectionLost(void Function()? callback);

  /// Subscribes at QoS 0. Call only while connected.
  void subscribe(String topic);

  /// Publishes at QoS 0, retained only if [retain]. Returns false if the
  /// session can't send right now.
  bool publish(String topic, Uint8List payload, {bool retain = false});

  /// Called for each message received on a subscribed topic.
  set onMessage(MqttMessageHandler? handler);

  /// Called when the broker refuses a subscription.
  set onSubscribeFailed(void Function(String topic)? callback);
}

typedef MqttMessageHandler = void Function(String topic, Uint8List payload);

typedef MqttTransportFactory =
    MqttTransport Function(MqttBrokerSettings settings, String clientId);
