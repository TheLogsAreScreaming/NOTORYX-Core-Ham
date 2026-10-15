import 'dart:math';

import 'package:latlong2/latlong.dart';

import '../models/flood_corridor.dart';

// Same flat-earth approximation the firmware uses in pointInCorridorSegment().
const double _kmPerDegree = 111.0;

/// Whether [point] is inside [corridor], matching the firmware's
/// isPointInCorridor(): a chain of segments whose radius is interpolated
/// linearly between neighbouring circles.
bool isPointInCorridor(LatLng point, List<CorridorTriple> corridor) {
  if (corridor.isEmpty) return false;
  if (corridor.length == 1) {
    return _inSegment(point, corridor.first, corridor.first);
  }
  for (var i = 0; i < corridor.length - 1; i++) {
    if (_inSegment(point, corridor[i], corridor[i + 1])) return true;
  }
  return false;
}

bool _inSegment(LatLng p, CorridorTriple a, CorridorTriple b) {
  if (a.isUnlimited || b.isUnlimited) return true;
  final cosLat = cos((a.lat + b.lat) / 2 * pi / 180);
  final vx = (b.lat - a.lat) * _kmPerDegree;
  final vy = (b.lon - a.lon) * cosLat * _kmPerDegree;
  final wx = (p.latitude - a.lat) * _kmPerDegree;
  final wy = (p.longitude - a.lon) * cosLat * _kmPerDegree;
  final lenSq = vx * vx + vy * vy;
  final t = lenSq < 1e-9 ? 0.0 : ((wx * vx + wy * vy) / lenSq).clamp(0.0, 1.0);
  final dx = wx - t * vx;
  final dy = wy - t * vy;
  final r = a.radiusKm + t * (b.radiusKm - a.radiusKm);
  return dx * dx + dy * dy <= r * r;
}

/// Quadrilaterals joining each pair of neighbouring circles, offset
/// perpendicular to the segment by each end's radius. Together with the
/// circles themselves they outline the area [isPointInCorridor] accepts.
List<List<LatLng>> corridorSegmentPolygons(List<CorridorTriple> corridor) {
  final polygons = <List<LatLng>>[];
  for (var i = 0; i < corridor.length - 1; i++) {
    final a = corridor[i];
    final b = corridor[i + 1];
    if (a.isUnlimited || b.isUnlimited) continue;
    final cosLat = cos((a.lat + b.lat) / 2 * pi / 180);
    final vx = (b.lat - a.lat) * _kmPerDegree;
    final vy = (b.lon - a.lon) * cosLat * _kmPerDegree;
    final len = sqrt(vx * vx + vy * vy);
    if (len < 1e-6) continue;
    // Unit normal in km space, converted back to degrees per end.
    final nx = -vy / len;
    final ny = vx / len;
    LatLng offset(CorridorTriple c, double sign) => LatLng(
      c.lat + sign * nx * c.radiusKm / _kmPerDegree,
      c.lon + sign * ny * c.radiusKm / (_kmPerDegree * cosLat),
    );
    polygons.add([offset(a, 1), offset(b, 1), offset(b, -1), offset(a, -1)]);
  }
  return polygons;
}
