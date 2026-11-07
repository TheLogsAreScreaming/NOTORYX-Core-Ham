/// Every user-facing MQTT message, as a value the UI can localize.
enum MqttNoticeKind {
  invalidHost,
  invalidPort,
  invalidWebSocketPath,
  invalidTopicPrefix,
  invalidRegion,
  tlsRequired,
  cleartextLocalOnly,
  regionNeededToShare,
  passwordNeeded,
  noNetwork,
  subscriptionRefused,
  badCredentials,
  notAuthorized,
  connectionRefused,
  unreachable,
  tlsFailed,
  webSocketOnly,
  radioNotConnected,
  signingUnsupported,
  signingTimeout,
  signingTooLong,
  signingRejected,
}

/// A user-facing MQTT message. [detail] fills the one placeholder some kinds
/// have (the username for [MqttNoticeKind.passwordNeeded]).
///
/// [english] is for logs, diagnostics and tests; screens show the localized
/// text from `AppLocalizations.mqttNotice`.
class MqttNotice {
  const MqttNotice(this.kind, [this.detail]);

  final MqttNoticeKind kind;
  final String? detail;

  String get english => switch (kind) {
    MqttNoticeKind.invalidHost =>
      'Enter a hostname or IPv4 address without a scheme or port.',
    MqttNoticeKind.invalidPort => 'Port must be between 1 and 65535.',
    MqttNoticeKind.invalidWebSocketPath =>
      'WebSocket path must begin with / and contain no query or fragment.',
    MqttNoticeKind.invalidTopicPrefix =>
      'Topic prefix must be a nonempty MQTT path without wildcards.',
    MqttNoticeKind.invalidRegion =>
      'Region must be 2-8 letters or digits, such as PHL.',
    MqttNoticeKind.tlsRequired =>
      'TLS is required unless insecure local broker access is explicitly enabled.',
    MqttNoticeKind.cleartextLocalOnly =>
      'Cleartext MQTT is restricted to explicitly approved local hosts.',
    MqttNoticeKind.regionNeededToShare =>
      'Set a region to share packets as an observer.',
    MqttNoticeKind.passwordNeeded => 'Enter the password for $detail.',
    MqttNoticeKind.noNetwork =>
      'No network connection. MQTT reconnects when it is back.',
    MqttNoticeKind.subscriptionRefused =>
      'The broker refused the packet subscription.',
    MqttNoticeKind.badCredentials =>
      'The broker rejected the username or password.',
    MqttNoticeKind.notAuthorized =>
      'This account is not authorized on the broker.',
    MqttNoticeKind.connectionRefused => 'The broker refused the connection.',
    MqttNoticeKind.unreachable => 'The broker could not be reached.',
    MqttNoticeKind.tlsFailed =>
      'The secure (TLS) connection could not be established.',
    MqttNoticeKind.webSocketOnly =>
      'This platform only supports MQTT over WebSocket.',
    MqttNoticeKind.radioNotConnected =>
      'Connect your radio to sign in with its key.',
    MqttNoticeKind.signingUnsupported =>
      "This radio's firmware does not support signing with its key.",
    MqttNoticeKind.signingTimeout =>
      'The radio did not answer the signing request. Its firmware may not '
          'support signing.',
    MqttNoticeKind.signingTooLong =>
      'The data is too long for the radio to sign.',
    MqttNoticeKind.signingRejected => 'The radio refused to sign the data.',
  };

  @override
  bool operator ==(Object other) =>
      other is MqttNotice && other.kind == kind && other.detail == detail;

  @override
  int get hashCode => Object.hash(kind, detail);

  @override
  String toString() => english;
}
