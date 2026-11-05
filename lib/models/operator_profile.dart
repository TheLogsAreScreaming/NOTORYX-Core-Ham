import '../utils/amateur_radio.dart';

/// US amateur licence classes that can still be held. Every one of them has
/// full privileges on 33 cm and 70 cm, so the class is recorded for the
/// operator's profile, not used to limit anything.
enum LicenseClass {
  technician('Technician'),
  general('General'),
  advanced('Advanced'),
  amateurExtra('Amateur Extra');

  const LicenseClass(this.label);
  final String label;
}

/// The licensed operator using this app, kept only on this device.
class OperatorProfile {
  const OperatorProfile({
    this.callsign = '',
    this.licenseClass,
    this.acknowledgedAt,
  });

  /// Upper-case US call sign, or empty.
  final String callsign;
  final LicenseClass? licenseClass;

  /// When the operator confirmed they hold the licence, read the coordination
  /// guide and will coordinate before transmitting; null until they do.
  final DateTime? acknowledgedAt;

  bool get hasValidCallsign => isUsCallsign(callsign);

  /// Whether the operator has finished setup: a valid call sign, a licence
  /// class and the acknowledgment.
  bool get isComplete =>
      hasValidCallsign && licenseClass != null && acknowledgedAt != null;

  /// Whether a radio's node name identifies this operator's station: it
  /// starts with their call sign.
  bool matchesNodeName(String? nodeName) =>
      nodeName != null && callsignOf(nodeName) == callsign;

  OperatorProfile copyWith({
    String? callsign,
    LicenseClass? licenseClass,
    DateTime? acknowledgedAt,
    bool clearAcknowledgment = false,
  }) => OperatorProfile(
    callsign: callsign ?? this.callsign,
    licenseClass: licenseClass ?? this.licenseClass,
    acknowledgedAt: clearAcknowledgment
        ? null
        : (acknowledgedAt ?? this.acknowledgedAt),
  );

  Map<String, dynamic> toJson() => {
    'callsign': callsign,
    if (licenseClass != null) 'licenseClass': licenseClass!.name,
    if (acknowledgedAt != null)
      'acknowledgedAt': acknowledgedAt!.toUtc().toIso8601String(),
  };

  /// Reads [json], dropping anything unreadable instead of failing.
  factory OperatorProfile.fromJson(Map<String, dynamic> json) {
    final call = (json['callsign'] as String? ?? '').trim().toUpperCase();
    final classes = {for (final c in LicenseClass.values) c.name: c};
    return OperatorProfile(
      callsign: call,
      licenseClass: classes[json['licenseClass']],
      acknowledgedAt: DateTime.tryParse(
        json['acknowledgedAt'] as String? ?? '',
      ),
    );
  }
}
