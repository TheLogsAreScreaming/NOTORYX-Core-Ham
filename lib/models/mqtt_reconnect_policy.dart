/// Pure reconnect scheduling, independent of the radio BLE retry timer.
class MqttReconnectPolicy {
  const MqttReconnectPolicy();

  Duration delayForAttempt(int attempt) {
    final bounded = attempt.clamp(0, 5);
    final seconds = 1 << bounded;
    return Duration(seconds: seconds);
  }

  bool shouldRetry({
    required bool manuallyDisconnected,
    required bool networkAvailable,
    required bool configured,
  }) {
    return !manuallyDisconnected && networkAvailable && configured;
  }
}
