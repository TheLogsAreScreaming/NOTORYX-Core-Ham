// Flood Corridor (MeshCore issue #1451, usrflo/MeshCore `feature/flood-corridor`).
//
// A corridor is up to [maxCorridorTriples] circles (lat, lon, radius) joined
// along a path. Corridor-aware repeaters forward a flood only when their own
// position lies inside it. Stock MeshCore firmware does not support this.

/// Radius lookup table indexed by the 4-bit radius code. Code 15 is unlimited.
/// Mirrors CORRIDOR_RADIUS_KM[] in the firmware's CorridorRadius.h.
const List<double> corridorRadiusKm = [
  1,
  2,
  3,
  5,
  8,
  12,
  20,
  30,
  50,
  80,
  120,
  200,
  300,
  500,
  800,
  double.infinity,
];

const int corridorRadiusCodeUnlimited = 15;
const int maxCorridorTriples = 8;
const int corridorTripleBytes = 4;

/// Policy flags for CMD_SEND_CHANNEL_TXT_MSG_CORRIDOR (not wire bit positions).
/// Fail-closed: repeaters with no known position drop the packet.
const int corridorFlagFailClosed = 0x01;

/// Destination zone is the last circle only; the rest is transport corridor.
const int corridorFlagDestLastTriple = 0x04;

/// One corridor circle, quantized exactly as it travels on the wire.
class CorridorTriple {
  final double lat;
  final double lon;
  final int radiusCode;

  CorridorTriple({
    required this.lat,
    required this.lon,
    required this.radiusCode,
  }) : assert(lat >= -90 && lat <= 90),
       assert(lon >= -180 && lon <= 180),
       assert(radiusCode >= 0 && radiusCode <= 15);

  double get radiusKm => corridorRadiusKm[radiusCode];
  bool get isUnlimited => radiusCode == corridorRadiusCodeUnlimited;

  /// Smallest radius code whose radius covers [km] (capped at 800 km;
  /// use [corridorRadiusCodeUnlimited] explicitly for an unlimited circle).
  static int radiusCodeFor(double km) {
    for (var code = 0; code < corridorRadiusCodeUnlimited; code++) {
      if (corridorRadiusKm[code] >= km) return code;
    }
    return corridorRadiusCodeUnlimited - 1;
  }

  /// 32-bit wire word: lat 14 bits | lon 14 bits | radius code 4 bits.
  /// Matches encodeCorridorTriple() in the firmware's CorridorCheck.h.
  int encode() {
    var latEnc = ((lat + 90) / 180 * 16383 + 0.5).floor();
    var lonEnc = ((lon + 180) / 360 * 16383 + 0.5).floor();
    if (latEnc > 16383) latEnc = 16383;
    if (lonEnc > 16383) lonEnc = 16383;
    return (latEnc << 18) | (lonEnc << 4) | (radiusCode & 0x0F);
  }

  factory CorridorTriple.decode(int word) {
    final latEnc = (word >> 18) & 0x3FFF;
    final lonEnc = (word >> 4) & 0x3FFF;
    return CorridorTriple(
      lat: latEnc / 16383 * 180 - 90,
      lon: lonEnc / 16383 * 360 - 180,
      radiusCode: word & 0x0F,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is CorridorTriple && other.encode() == encode();

  @override
  int get hashCode => encode().hashCode;

  @override
  String toString() =>
      'CorridorTriple(${lat.toStringAsFixed(4)}, ${lon.toStringAsFixed(4)}, '
      '${isUnlimited ? 'unlimited' : '${radiusKm.toStringAsFixed(0)} km'})';
}

/// A corridor the firmware proposes toward a target (RESP_CODE_PROPOSE_CORRIDOR).
class CorridorProposal {
  /// Raw reason byte: bits 0-2 tier, 0x08 thin stretch, 0x80 horizon-limited.
  final int reason;
  final List<CorridorTriple> triples;

  const CorridorProposal({required this.reason, required this.triples});

  int get tier => reason & 0x07;

  /// Part of the path has no known repeater to anchor it.
  bool get hasThinStretch => (reason & 0x08) != 0;

  /// The generator stopped before reaching the target.
  bool get isHorizonLimited => (reason & 0x80) != 0;

  bool get isEmpty => triples.isEmpty;
}
