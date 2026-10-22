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

  String get message => switch (failure) {
    RadioSigningFailure.notConnected =>
      'Connect your radio to sign in with its key.',
    RadioSigningFailure.unsupported =>
      "This radio's firmware does not support signing with its key.",
    RadioSigningFailure.timeout =>
      'The radio did not answer the signing request. Its firmware may not '
          'support signing.',
    RadioSigningFailure.tooLong =>
      'The data is too long for the radio to sign.',
    RadioSigningFailure.rejected => 'The radio refused to sign the data.',
  };

  /// Whether trying again later could help, for example after the radio
  /// reconnects. Unsupported firmware won't fix itself.
  bool get retryable =>
      failure == RadioSigningFailure.notConnected ||
      failure == RadioSigningFailure.timeout;

  @override
  String toString() => 'RadioSigningException: $message';
}
