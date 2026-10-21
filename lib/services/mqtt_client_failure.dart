import 'package:mqtt_client/mqtt_client.dart';

import 'mqtt_transport.dart';

/// Maps an mqtt_client connection status to a failure, or null if connected.
MqttConnectFailure? mqttFailureFromStatus(MqttClientConnectionStatus? status) {
  if (status?.state == MqttConnectionState.connected) return null;
  return switch (status?.returnCode) {
    MqttConnectReturnCode.badUsernameOrPassword =>
      MqttConnectFailure.badCredentials,
    MqttConnectReturnCode.notAuthorized => MqttConnectFailure.notAuthorized,
    MqttConnectReturnCode.unacceptedProtocolVersion ||
    MqttConnectReturnCode.identifierRejected => MqttConnectFailure.rejected,
    _ => MqttConnectFailure.unreachable,
  };
}
