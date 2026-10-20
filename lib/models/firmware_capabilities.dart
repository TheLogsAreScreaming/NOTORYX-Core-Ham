/// Conservative capabilities advertised or positively verified by a radio.
///
/// A firmware name alone is not evidence that a command is supported.
enum RadioCapability {
  repeaterTable,
  heldMessageQueue,
  gpsPowerControl,
  batteryAlertControl,
  notificationControl,
}

class FirmwareCapabilities {
  final String? firmwareLabel;
  final Set<RadioCapability> verified;

  FirmwareCapabilities({
    this.firmwareLabel,
    Iterable<RadioCapability> verified = const [],
  }) : verified = Set.unmodifiable(verified);

  bool get isCascadeCandidate =>
      (firmwareLabel ?? '').toLowerCase().contains('cascade');

  bool supports(RadioCapability capability) => verified.contains(capability);

  /// Only use capabilities established by a successful protocol probe.
  /// Unknown firmware and Cascade-branded firmware are equally conservative.
  factory FirmwareCapabilities.fromVerifiedProbes({
    String? firmwareLabel,
    required Map<RadioCapability, bool> probeResults,
  }) {
    return FirmwareCapabilities(
      firmwareLabel: firmwareLabel,
      verified: probeResults.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key),
    );
  }
}
