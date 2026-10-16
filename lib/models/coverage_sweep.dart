import 'package:latlong2/latlong.dart';

const _earthRadiusMeters = 6371000.0;
const _distance = Distance();

/// Antenna heights offered, in metres above ground.
const antennaHeights = [2.0, 5.0, 10.0, 20.0, 40.0];

/// Sweep radii offered, in kilometres.
const coverageRadiiKm = [5, 10, 20, 40];

/// One bearing of a coverage sweep, outward from the antenna.
class CoverageRay {
  final double bearing;

  /// Sample points, nearest first (the antenna itself is not included).
  final List<LatLng> points;

  /// Whether a radio at receiver height at each point has line of sight to
  /// the antenna. False where terrain data is missing.
  final List<bool> visible;
  final List<double> distances;

  const CoverageRay({
    required this.bearing,
    required this.points,
    required this.visible,
    required this.distances,
  });

  /// The farthest point with line of sight, or 0 if none.
  double get reachMeters {
    for (var i = visible.length - 1; i >= 0; i--) {
      if (visible[i]) return distances[i];
    }
    return 0;
  }
}

class CoverageResult {
  final LatLng origin;
  final double antennaHeightMeters;
  final double radiusMeters;
  final List<CoverageRay> rays;

  /// Set when terrain heights couldn't be loaded at all.
  final String? error;

  const CoverageResult({
    required this.origin,
    required this.antennaHeightMeters,
    required this.radiusMeters,
    required this.rays,
    this.error,
  });

  int get _samples => rays.fold(0, (n, r) => n + r.visible.length);

  /// Share of sampled points in line of sight, 0–1.
  double get visibleFraction {
    final total = _samples;
    if (total == 0) return 0;
    final seen = rays.fold(0, (n, r) => n + r.visible.where((v) => v).length);
    return seen / total;
  }

  double get maxReachMeters =>
      rays.fold(0.0, (m, r) => r.reachMeters > m ? r.reachMeters : m);
}

/// Sample points along [bearings] evenly spaced rays from [origin], each with
/// [samples] points out to [radiusMeters].
List<List<LatLng>> sweepPoints(
  LatLng origin, {
  required double radiusMeters,
  int bearings = 36,
  int samples = 30,
}) => [
  for (var b = 0; b < bearings; b++)
    [
      for (var i = 1; i <= samples; i++)
        _distance.offset(
          origin,
          radiusMeters * i / samples,
          360.0 * b / bearings,
        ),
    ],
];

/// Viewshed along one ray: a point is visible when the sight line from the
/// antenna to a receiver standing there clears every terrain sample nearer
/// the antenna. Earth curvature is included with the effective-radius
/// [kFactor] (4/3 is standard). Null terrain counts as not visible.
List<bool> visibleAlongRay({
  required double originGroundMeters,
  required double antennaHeightMeters,
  required List<double> distances,
  required List<double?> terrain,
  double receiverHeightMeters = 1.5,
  double kFactor = 4 / 3,
}) {
  final eye = originGroundMeters + antennaHeightMeters;
  final radius = _earthRadiusMeters * kFactor;
  var steepest = double.negativeInfinity; // highest terrain angle so far
  final out = <bool>[];
  for (var i = 0; i < distances.length; i++) {
    final d = distances[i];
    final ground = terrain[i];
    if (ground == null || d <= 0) {
      out.add(false);
      continue;
    }
    final drop = d * d / (2 * radius);
    final groundAngle = (ground - drop - eye) / d;
    final targetAngle = (ground + receiverHeightMeters - drop - eye) / d;
    out.add(targetAngle >= steepest);
    if (groundAngle > steepest) steepest = groundAngle;
  }
  return out;
}
