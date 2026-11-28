import 'dart:math';

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

  /// Estimated received power at each point in dBm, or null where unknown.
  /// Empty when radio settings weren't available.
  final List<double?> signalDbm;

  const CoverageRay({
    required this.bearing,
    required this.points,
    required this.visible,
    required this.distances,
    this.signalDbm = const [],
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

  /// The radio settings signal was estimated with, if any.
  final CoverageRadio? radio;

  /// Set when terrain heights couldn't be loaded at all.
  final String? error;

  const CoverageResult({
    required this.origin,
    required this.antennaHeightMeters,
    required this.radiusMeters,
    required this.rays,
    this.radio,
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

  /// How many sampled points fall in [level].
  int countAt(SignalLevel level) {
    final r = radio;
    if (r == null) return 0;
    var n = 0;
    for (final ray in rays) {
      for (final dbm in ray.signalDbm) {
        if (dbm != null && r.levelOf(dbm) == level) n++;
      }
    }
    return n;
  }

  /// Share of sampled points in [level], 0–1.
  double fractionAt(SignalLevel level) =>
      _samples == 0 ? 0 : countAt(level) / _samples;

  /// The farthest point with a usable estimated signal, in metres.
  double get maxSignalReachMeters {
    final r = radio;
    if (r == null) return 0;
    var best = 0.0;
    for (final ray in rays) {
      for (var i = 0; i < ray.signalDbm.length; i++) {
        final dbm = ray.signalDbm[i];
        if (dbm != null &&
            r.levelOf(dbm) != SignalLevel.none &&
            ray.distances[i] > best) {
          best = ray.distances[i];
        }
      }
    }
    return best;
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

/// How usable an estimated signal is.
enum SignalLevel { strong, marginal, none }

/// The radio settings a signal estimate is based on.
class CoverageRadio {
  const CoverageRadio({
    required this.txPowerDbm,
    required this.frequencyMHz,
    required this.bandwidthHz,
    required this.spreadingFactor,
    this.antennaGainDbi = 2,
  });

  final int txPowerDbm;
  final double frequencyMHz;
  final int bandwidthHz;
  final int spreadingFactor;

  /// Assumed at each end, since the app can't know the real antennas.
  final double antennaGainDbi;

  /// Margin above sensitivity that counts as a strong signal.
  static const strongMarginDb = 10.0;

  /// Thermal noise, a typical receiver noise figure and the SNR LoRa needs.
  double get sensitivityDbm {
    const noiseFigureDb = 6.0;
    final sf = spreadingFactor.clamp(5, 12);
    final requiredSnr = -2.5 * (sf - 4);
    return -174 + 10 * log(bandwidthHz) / ln10 + noiseFigureDb + requiredSnr;
  }

  SignalLevel levelOf(double dbm) {
    final margin = dbm - sensitivityDbm;
    if (margin >= strongMarginDb) return SignalLevel.strong;
    return margin >= 0 ? SignalLevel.marginal : SignalLevel.none;
  }
}

/// Loss over one knife edge, from ITU-R P.526, for diffraction parameter [v].
double knifeEdgeLossDb(double v) {
  if (v <= -0.78) return 0;
  final t = v - 0.1;
  return 6.9 + 20 * log(sqrt(t * t + 1) + t) / ln10;
}

/// Estimated received power at each point along one ray: free-space loss plus
/// terrain diffraction by the Deygout method, up to three edges.
///
/// Trees, buildings and real antennas are not included, so this is a rough
/// estimate. Null terrain at a point gives null there.
List<double?> signalAlongRay({
  required CoverageRadio radio,
  required double originGroundMeters,
  required double antennaHeightMeters,
  required List<double> distances,
  required List<double?> terrain,
  double receiverHeightMeters = 1.5,
  double kFactor = 4 / 3,
}) {
  final radius = _earthRadiusMeters * kFactor;
  final wavelength = 299.792458 / radio.frequencyMHz;
  final out = <double?>[];
  for (var j = 0; j < distances.length; j++) {
    final ground = terrain[j];
    final d = distances[j];
    if (ground == null || d <= 0) {
      out.add(null);
      continue;
    }
    // Heights with the earth's curve folded in, from antenna to receiver.
    final at = <double>[0];
    final height = <double>[originGroundMeters + antennaHeightMeters];
    for (var i = 0; i < j; i++) {
      final t = terrain[i];
      if (t == null) continue;
      at.add(distances[i]);
      height.add(t - distances[i] * distances[i] / (2 * radius));
    }
    at.add(d);
    height.add(ground + receiverHeightMeters - d * d / (2 * radius));
    final spreading =
        20 * log(d / 1000) / ln10 + 20 * log(radio.frequencyMHz) / ln10 + 32.44;
    final terrainLoss = _deygout(at, height, 0, at.length - 1, wavelength, 3);
    out.add(
      radio.txPowerDbm + 2 * radio.antennaGainDbi - spreading - terrainLoss,
    );
  }
  return out;
}

double _deygout(
  List<double> at,
  List<double> height,
  int from,
  int to,
  double wavelength,
  int edgesLeft,
) {
  if (edgesLeft == 0 || to - from < 2) return 0;
  final span = at[to] - at[from];
  var worst = double.negativeInfinity;
  var edge = -1;
  for (var i = from + 1; i < to; i++) {
    final d1 = at[i] - at[from];
    final d2 = at[to] - at[i];
    final line = height[from] + (height[to] - height[from]) * d1 / span;
    final v = (height[i] - line) * sqrt(2 * span / (wavelength * d1 * d2));
    if (v > worst) {
      worst = v;
      edge = i;
    }
  }
  if (edge < 0 || worst <= -0.78) return 0;
  return knifeEdgeLossDb(worst) +
      _deygout(at, height, from, edge, wavelength, (edgesLeft - 1) ~/ 2) +
      _deygout(at, height, edge, to, wavelength, (edgesLeft - 1) ~/ 2);
}
