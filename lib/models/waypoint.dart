import 'package:gpx/gpx.dart';

/// A saved place: imported from GPX, saved from a shared marker, or added
/// by hand.
class Waypoint {
  const Waypoint({
    required this.id,
    required this.name,
    required this.lat,
    required this.lon,
    this.ele,
    this.note = '',
  });

  final String id;
  final String name;
  final double lat;
  final double lon;
  final double? ele;
  final String note;

  Map<String, Object?> toJson() => {
    'id': id,
    'name': name,
    'lat': lat,
    'lon': lon,
    if (ele != null) 'ele': ele,
    if (note.isNotEmpty) 'note': note,
  };

  static Waypoint? fromJson(Object? json) {
    if (json is! Map) return null;
    final id = json['id'], name = json['name'];
    final lat = json['lat'], lon = json['lon'];
    if (id is! String || name is! String || lat is! num || lon is! num) {
      return null;
    }
    if (!validPosition(lat.toDouble(), lon.toDouble())) return null;
    return Waypoint(
      id: id,
      name: name,
      lat: lat.toDouble(),
      lon: lon.toDouble(),
      ele: (json['ele'] as num?)?.toDouble(),
      note: json['note'] as String? ?? '',
    );
  }

  /// The shared-marker text the map and chats already understand:
  /// `m:<lat>,<lon>|<label>|<flags>`, 5 decimals (about 1 m).
  String toMarkerText() {
    final label = name.replaceAll('|', '/').trim();
    return 'm:${lat.toStringAsFixed(5)},${lon.toStringAsFixed(5)}|$label|';
  }
}

/// An ordered list of points, such as a planned route.
class WaypointRoute {
  const WaypointRoute({
    required this.id,
    required this.name,
    required this.points,
  });

  final String id;
  final String name;
  final List<Waypoint> points;

  Map<String, Object?> toJson() => {
    'id': id,
    'name': name,
    'points': [for (final p in points) p.toJson()],
  };

  static WaypointRoute? fromJson(Object? json) {
    if (json is! Map) return null;
    final id = json['id'], name = json['name'], points = json['points'];
    if (id is! String || name is! String || points is! List) return null;
    final parsed = [for (final p in points) ?Waypoint.fromJson(p)];
    if (parsed.length < 2) return null;
    return WaypointRoute(id: id, name: name, points: parsed);
  }
}

bool validPosition(double lat, double lon) =>
    lat.isFinite && lon.isFinite && lat.abs() <= 90 && lon.abs() <= 180;

/// What a GPX file held.
class GpxImport {
  const GpxImport(this.waypoints, this.routes);
  final List<Waypoint> waypoints;
  final List<WaypointRoute> routes;
  bool get isEmpty => waypoints.isEmpty && routes.isEmpty;
}

/// The most points kept from one route or track; tracks are thinned evenly
/// to this, keeping both ends.
const maxRoutePoints = 200;

/// Reads waypoints, routes and tracks from GPX text. Tracks become routes,
/// thinned to [maxRoutePoints]. Points without a valid position are
/// skipped. Throws [FormatException] when the text isn't GPX.
GpxImport parseGpx(String xml, {String Function()? newId}) {
  var counter = 0;
  final id =
      newId ??
      () => 'gpx-${DateTime.now().microsecondsSinceEpoch}-${counter++}';
  final Gpx gpx;
  try {
    gpx = GpxReader().fromString(xml);
  } catch (e) {
    throw FormatException('Not a GPX file: $e');
  }
  Waypoint? point(Wpt w, String fallback) {
    final lat = w.lat, lon = w.lon;
    if (lat == null || lon == null || !validPosition(lat, lon)) return null;
    return Waypoint(
      id: id(),
      name: (w.name?.trim().isNotEmpty ?? false) ? w.name!.trim() : fallback,
      lat: lat,
      lon: lon,
      ele: w.ele,
      note: w.desc?.trim() ?? w.cmt?.trim() ?? '',
    );
  }

  final waypoints = [
    for (final (i, w) in gpx.wpts.indexed) ?point(w, 'Waypoint ${i + 1}'),
  ];
  WaypointRoute? route(String? name, List<Wpt> pts, String fallback) {
    final points = [
      for (final (i, w) in thin(pts, maxRoutePoints).indexed)
        ?point(w, '${i + 1}'),
    ];
    if (points.length < 2) return null;
    return WaypointRoute(
      id: id(),
      name: (name?.trim().isNotEmpty ?? false) ? name!.trim() : fallback,
      points: points,
    );
  }

  final routes = <WaypointRoute>[
    for (final (i, r) in gpx.rtes.indexed)
      ?route(r.name, r.rtepts, 'Route ${i + 1}'),
    for (final (i, t) in gpx.trks.indexed)
      ?route(t.name, [
        for (final s in t.trksegs) ...s.trkpts,
      ], 'Track ${i + 1}'),
  ];
  return GpxImport(waypoints, routes);
}

/// Picks up to [max] items evenly from [items], keeping the first and last.
List<T> thin<T>(List<T> items, int max) {
  if (items.length <= max) return items;
  return [
    for (var i = 0; i < max; i++)
      items[(i * (items.length - 1) / (max - 1)).round()],
  ];
}

/// Writes waypoints and routes as GPX 1.1 text.
String toGpx(List<Waypoint> waypoints, List<WaypointRoute> routes) {
  Wpt wpt(Waypoint w) => Wpt(
    lat: w.lat,
    lon: w.lon,
    ele: w.ele,
    name: w.name,
    desc: w.note.isEmpty ? null : w.note,
  );
  final gpx = Gpx()
    ..creator = 'NOTORYX Core'
    ..wpts = [for (final w in waypoints) wpt(w)]
    ..rtes = [
      for (final r in routes)
        Rte(name: r.name, rtepts: [for (final p in r.points) wpt(p)]),
    ];
  return GpxWriter().asString(gpx, pretty: true);
}
