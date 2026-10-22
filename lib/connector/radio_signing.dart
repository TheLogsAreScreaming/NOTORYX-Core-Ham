import '../models/mqtt_notice.dart';

/// Why the radio could not sign data with its own key.
enum RadioSigningFailure {
  notConnected,
  unsupported,
  timeout,
  tooLong,
  rejected,
}

/// Thrown by `MeshCoreConnector.signWithRadio`. Carries no key material.
class RadioSigningException implements Exception {
  const RadioSigningException(this.failure);

  final RadioSigningFailure failure;

  MqttNotice get notice => MqttNotice(switch (failure) {
    RadioSigningFailure.notConnected => MqttNoticeKind.radioNotConnected,
    RadioSigningFailure.unsupported => MqttNoticeKind.signingUnsupported,
    RadioSigningFailure.timeout => MqttNoticeKind.signingTimeout,
    RadioSigningFailure.tooLong => MqttNoticeKind.signingTooLong,
    RadioSigningFailure.rejected => MqttNoticeKind.signingRejected,
  });

  String get message => notice.english;

  /// Whether trying again later could help, for example after the radio
  /// reconnects. Unsupported firmware won't fix itself.
  bool get retryable =>
      failure == RadioSigningFailure.notConnected ||
      failure == RadioSigningFailure.timeout;

  @override
  String toString() => 'RadioSigningException: $message';
}
