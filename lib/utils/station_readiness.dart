import '../models/operator_profile.dart';
import 'amateur_radio.dart';

/// The first thing stopping this station from transmitting legally, checked
/// in order of importance: setup, then the radio's name (no call sign, no
/// transmission), then its band.
enum StationReadiness {
  /// Call sign, licence class or the coordination acknowledgment is missing.
  setupIncomplete,

  /// The connected radio's node name does not start with the call sign.
  nameMismatch,

  /// The connected radio is tuned outside 420–450 / 902–928 MHz.
  outOfBand,

  /// Setup is done and the radio's name and band check out.
  ready,
}

/// Works out [StationReadiness] for a connected radio named [nodeName] on
/// [freqKhz]. A radio that has not reported its name or frequency yet is not
/// held against the operator.
StationReadiness stationReadiness(
  OperatorProfile profile, {
  String? nodeName,
  int? freqKhz,
}) {
  if (!profile.isComplete) return StationReadiness.setupIncomplete;
  if (nodeName != null && !profile.matchesNodeName(nodeName)) {
    return StationReadiness.nameMismatch;
  }
  if (freqKhz != null && !isAmateurFrequencyMHz(freqKhz / 1000.0)) {
    return StationReadiness.outOfBand;
  }
  return StationReadiness.ready;
}
