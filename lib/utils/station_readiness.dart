import '../models/operator_profile.dart';
import 'amateur_radio.dart';

/// The first thing stopping this station from transmitting legally, checked
/// in order of importance: the radio's firmware (no setup fixes stock
/// MeshCore), setup, then the radio's name (no call sign, no transmission),
/// then its band.
enum StationReadiness {
  /// The connected radio runs stock MeshCore, which encrypts and sends no
  /// station ID, so it must not transmit on the ham bands.
  stockFirmware,

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
/// [freqKhz] running [firmwareVersion]. A radio that has not reported its
/// firmware, name or frequency yet is not held against the operator.
StationReadiness stationReadiness(
  OperatorProfile profile, {
  String? nodeName,
  int? freqKhz,
  String? firmwareVersion,
}) {
  if (isAmateurFirmware(firmwareVersion) == false) {
    return StationReadiness.stockFirmware;
  }
  if (!profile.isComplete) return StationReadiness.setupIncomplete;
  if (nodeName != null && !profile.matchesNodeName(nodeName)) {
    return StationReadiness.nameMismatch;
  }
  if (freqKhz != null && !isAmateurFrequencyMHz(freqKhz / 1000.0)) {
    return StationReadiness.outOfBand;
  }
  return StationReadiness.ready;
}
