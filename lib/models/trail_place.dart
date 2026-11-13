import 'dart:convert';
import 'dart:io' show gzip;

enum TrailPlaceKind {
  peak('Peak'),
  saddle('Pass'),
  spring('Spring'),
  hut('Hut'),
  campsite('Campsite'),
  viewpoint('Viewpoint'),
  shelter('Shelter'),
  trailhead('Trailhead'),
  town('Town'),
  locality('Locality'),
  waypoint('Saved waypoint');

  const TrailPlaceKind(this.label);
  final String label;
}

/// A named place someone might search for.
class TrailPlace {
  const TrailPlace(this.name, this.kind, this.lat, this.lon);

  final String name;
  final TrailPlaceKind kind;
  final double lat;
  final double lon;
}

/// The Overpass statements that fetch [placesFromOverpass]'s nodes in [box].
String placeQueryStatements(String box) =>
    'node["name"]["natural"~"^(peak|saddle|spring)\$"]($box);'
    'node["name"]["tourism"~"^(alpine_hut|wilderness_hut|camp_site|viewpoint)\$"]($box);'
    'node["name"]["amenity"="shelter"]($box);'
    'node["name"]["highway"="trailhead"]($box);'
    'node["name"]["place"~"^(city|town|village|hamlet|locality)\$"]($box);';

TrailPlaceKind? _kindOf(Map<String, dynamic> tags) {
  switch (tags['natural']) {
    case 'peak':
      return TrailPlaceKind.peak;
    case 'saddle':
      return TrailPlaceKind.saddle;
    case 'spring':
      return TrailPlaceKind.spring;
  }
  switch (tags['tourism']) {
    case 'alpine_hut' || 'wilderness_hut':
      return TrailPlaceKind.hut;
    case 'camp_site':
      return TrailPlaceKind.campsite;
    case 'viewpoint':
      return TrailPlaceKind.viewpoint;
  }
  if (tags['amenity'] == 'shelter') return TrailPlaceKind.shelter;
  if (tags['highway'] == 'trailhead') return TrailPlaceKind.trailhead;
  switch (tags['place']) {
    case 'city' || 'town' || 'village' || 'hamlet':
      return TrailPlaceKind.town;
    case 'locality':
      return TrailPlaceKind.locality;
  }
  return null;
}

/// The named places in an Overpass reply.
List<TrailPlace> placesFromOverpass(Map<String, dynamic> json) {
  final out = <TrailPlace>[];
  for (final element in json['elements'] as List<dynamic>? ?? const []) {
    if (element is! Map<String, dynamic> || element['type'] != 'node') continue;
    final tags = element['tags'];
    final lat = element['lat'], lon = element['lon'];
    if (tags is! Map<String, dynamic> || lat is! num || lon is! num) continue;
    final name = tags['name'];
    final kind = _kindOf(tags);
    if (name is! String || name.trim().isEmpty || kind == null) continue;
    out.add(TrailPlace(name.trim(), kind, lat.toDouble(), lon.toDouble()));
  }
  return out;
}

List<int> placesToBytes(List<TrailPlace> places) => gzip.encode(
  utf8.encode(
    jsonEncode([
      for (final p in places)
        [p.name, p.kind.name, (p.lat * 1e6).round(), (p.lon * 1e6).round()],
    ]),
  ),
);

/// Reads what [placesToBytes] wrote. Throws [FormatException] if it can't.
List<TrailPlace> placesFromBytes(List<int> bytes) {
  try {
    return [
      for (final row in jsonDecode(utf8.decode(gzip.decode(bytes))) as List)
        TrailPlace(
          row[0] as String,
          TrailPlaceKind.values.byName(row[1] as String),
          (row[2] as int) / 1e6,
          (row[3] as int) / 1e6,
        ),
    ];
  } catch (_) {
    throw const FormatException('Place data is damaged.');
  }
}

const _accents = {
  'á': 'a',
  'à': 'a',
  'â': 'a',
  'ä': 'a',
  'ã': 'a',
  'å': 'a',
  'é': 'e',
  'è': 'e',
  'ê': 'e',
  'ë': 'e',
  'í': 'i',
  'ì': 'i',
  'î': 'i',
  'ï': 'i',
  'ó': 'o',
  'ò': 'o',
  'ô': 'o',
  'ö': 'o',
  'õ': 'o',
  'ú': 'u',
  'ù': 'u',
  'û': 'u',
  'ü': 'u',
  'ñ': 'n',
  'ç': 'c',
};

String _fold(String text) =>
    text.toLowerCase().split('').map((c) => _accents[c] ?? c).join();

/// Places matching [query], names starting with it first, then by name.
List<TrailPlace> searchPlaces(
  Iterable<TrailPlace> places,
  String query, {
  int limit = 30,
}) {
  final q = _fold(query.trim());
  if (q.isEmpty) return const [];
  final hits = <(bool, String, TrailPlace)>[];
  for (final p in places) {
    final name = _fold(p.name);
    if (name.contains(q)) hits.add((name.startsWith(q), name, p));
  }
  hits.sort((a, b) {
    if (a.$1 != b.$1) return a.$1 ? -1 : 1;
    return a.$2.compareTo(b.$2);
  });
  return [for (final h in hits.take(limit)) h.$3];
}
