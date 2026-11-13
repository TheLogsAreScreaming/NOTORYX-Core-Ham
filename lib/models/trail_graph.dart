import 'dart:convert';
import 'dart:io' show gzip;
import 'dart:math';

/// Highways someone can walk along. Motorways and the like are left out.
const _walkable = {
  'path',
  'track',
  'footway',
  'bridleway',
  'cycleway',
  'steps',
  'living_street',
  'pedestrian',
  'residential',
  'service',
  'unclassified',
  'tertiary',
  'secondary',
};

/// The Overpass filter for [_walkable].
final walkableHighwayPattern = '^(${_walkable.join('|')})\$';

/// The largest area one download may cover, to respect the public server.
const maxTrailAreaKm2 = 2500.0;

/// How far from a trail a route may start or end.
const maxSnapMeters = 500.0;

const _earthRadiusMeters = 6371000.0;

double _meters(double lat1, double lon1, double lat2, double lon2) {
  const rad = pi / 180;
  final dLat = (lat2 - lat1) * rad;
  final dLon = (lon2 - lon1) * rad;
  final a =
      pow(sin(dLat / 2), 2) +
      cos(lat1 * rad) * cos(lat2 * rad) * pow(sin(dLon / 2), 2);
  return 2 * _earthRadiusMeters * asin(min(1.0, sqrt(a)));
}

/// A box on the map, in degrees.
class TrailBounds {
  const TrailBounds({
    required this.south,
    required this.west,
    required this.north,
    required this.east,
  });

  final double south, west, north, east;

  double get areaKm2 {
    final height = _meters(south, west, north, west) / 1000;
    final mid = (south + north) / 2;
    final width = _meters(mid, west, mid, east) / 1000;
    return height * width;
  }

  bool contains(double lat, double lon) =>
      lat >= south && lat <= north && lon >= west && lon <= east;
}

enum TrailRouteProblem { startTooFar, endTooFar, notConnected }

/// A route along trails, or why there isn't one.
class TrailRouteResult {
  const TrailRouteResult.found(this.points, this.meters) : problem = null;
  const TrailRouteResult.failed(TrailRouteProblem this.problem)
    : points = const [],
      meters = 0;

  /// `(lat, lon)` from start to end.
  final List<(double, double)> points;
  final double meters;
  final TrailRouteProblem? problem;
}

/// Walkable ways from OpenStreetMap as nodes and links.
class TrailGraph {
  TrailGraph._(this._lats, this._lons, this._links);

  /// Builds a graph from an Overpass `out body geom` reply. Ways marked
  /// private or closed to walkers are skipped.
  factory TrailGraph.fromOverpass(Map<String, dynamic> json) {
    final index = <int, int>{};
    final lats = <double>[], lons = <double>[];
    final links = <Set<int>>[];
    for (final element in json['elements'] as List<dynamic>? ?? const []) {
      if (element is! Map<String, dynamic> || element['type'] != 'way') {
        continue;
      }
      final tags = element['tags'] as Map<String, dynamic>? ?? const {};
      if (!_walkable.contains(tags['highway'])) continue;
      if (tags['access'] == 'private' ||
          tags['access'] == 'no' ||
          tags['foot'] == 'no' ||
          tags['foot'] == 'private') {
        continue;
      }
      final nodes = element['nodes'] as List<dynamic>?;
      final geometry = element['geometry'] as List<dynamic>?;
      if (nodes == null || geometry == null) continue;
      if (nodes.length != geometry.length) continue;
      int? previous;
      for (var i = 0; i < nodes.length; i++) {
        final at = geometry[i];
        if (at is! Map<String, dynamic>) {
          previous = null;
          continue;
        }
        final current = index.putIfAbsent(nodes[i] as int, () {
          lats.add((at['lat'] as num).toDouble());
          lons.add((at['lon'] as num).toDouble());
          links.add(<int>{});
          return lats.length - 1;
        });
        if (previous != null && previous != current) {
          links[previous].add(current);
          links[current].add(previous);
        }
        previous = current;
      }
    }
    return TrailGraph._(lats, lons, links);
  }

  /// Reads what [toBytes] wrote. Throws [FormatException] if it can't.
  factory TrailGraph.fromBytes(List<int> bytes) {
    try {
      final j = jsonDecode(utf8.decode(gzip.decode(bytes))) as Map;
      final lats = [for (final v in j['a'] as List) (v as int) / 1e6];
      final lons = [for (final v in j['o'] as List) (v as int) / 1e6];
      final links = [for (final _ in lats) <int>{}];
      final edges = j['e'] as List;
      for (var i = 0; i + 1 < edges.length; i += 2) {
        final a = edges[i] as int, b = edges[i + 1] as int;
        links[a].add(b);
        links[b].add(a);
      }
      return TrailGraph._(lats, lons, links);
    } on FormatException {
      rethrow;
    } catch (_) {
      throw const FormatException('Trail data is damaged.');
    }
  }

  final List<double> _lats, _lons;
  final List<Set<int>> _links;

  int get nodeCount => _lats.length;

  List<int> toBytes() {
    final edges = <int>[];
    for (var a = 0; a < _links.length; a++) {
      for (final b in _links[a]) {
        if (a < b) edges.addAll([a, b]);
      }
    }
    return gzip.encode(
      utf8.encode(
        jsonEncode({
          'a': [for (final v in _lats) (v * 1e6).round()],
          'o': [for (final v in _lons) (v * 1e6).round()],
          'e': edges,
        }),
      ),
    );
  }

  (int, double)? _nearest(double lat, double lon) {
    var best = -1;
    var bestMeters = double.infinity;
    for (var i = 0; i < _lats.length; i++) {
      final m = _meters(lat, lon, _lats[i], _lons[i]);
      if (m < bestMeters) {
        bestMeters = m;
        best = i;
      }
    }
    return best < 0 ? null : (best, bestMeters);
  }

  /// The shortest walk between two points, by A* over the trail network.
  TrailRouteResult route(
    double fromLat,
    double fromLon,
    double toLat,
    double toLon,
  ) {
    final start = _nearest(fromLat, fromLon);
    if (start == null || start.$2 > maxSnapMeters) {
      return const TrailRouteResult.failed(TrailRouteProblem.startTooFar);
    }
    final end = _nearest(toLat, toLon);
    if (end == null || end.$2 > maxSnapMeters) {
      return const TrailRouteResult.failed(TrailRouteProblem.endTooFar);
    }
    final goal = end.$1;
    double estimate(int n) =>
        _meters(_lats[n], _lons[n], _lats[goal], _lons[goal]);

    final walked = <int, double>{start.$1: 0};
    final cameFrom = <int, int>{};
    final open = _Heap()..push(start.$1, estimate(start.$1));
    final done = <int>{};
    while (open.isNotEmpty) {
      final current = open.pop();
      if (!done.add(current)) continue;
      if (current == goal) {
        final path = <int>[goal];
        while (cameFrom.containsKey(path.last)) {
          path.add(cameFrom[path.last]!);
        }
        return TrailRouteResult.found([
          for (final n in path.reversed) (_lats[n], _lons[n]),
        ], walked[goal]!);
      }
      for (final next in _links[current]) {
        if (done.contains(next)) continue;
        final cost =
            walked[current]! +
            _meters(_lats[current], _lons[current], _lats[next], _lons[next]);
        if (cost < (walked[next] ?? double.infinity)) {
          walked[next] = cost;
          cameFrom[next] = current;
          open.push(next, cost + estimate(next));
        }
      }
    }
    return const TrailRouteResult.failed(TrailRouteProblem.notConnected);
  }
}

class _Heap {
  final _items = <int>[];
  final _costs = <double>[];

  bool get isNotEmpty => _items.isNotEmpty;

  void push(int item, double cost) {
    _items.add(item);
    _costs.add(cost);
    var i = _items.length - 1;
    while (i > 0) {
      final parent = (i - 1) ~/ 2;
      if (_costs[parent] <= _costs[i]) break;
      _swap(i, parent);
      i = parent;
    }
  }

  int pop() {
    final top = _items.first;
    final lastItem = _items.removeLast();
    final lastCost = _costs.removeLast();
    if (_items.isEmpty) return top;
    _items[0] = lastItem;
    _costs[0] = lastCost;
    var i = 0;
    while (true) {
      final left = 2 * i + 1, right = left + 1;
      var least = i;
      if (left < _items.length && _costs[left] < _costs[least]) least = left;
      if (right < _items.length && _costs[right] < _costs[least]) least = right;
      if (least == i) return top;
      _swap(i, least);
      i = least;
    }
  }

  void _swap(int a, int b) {
    final item = _items[a];
    _items[a] = _items[b];
    _items[b] = item;
    final cost = _costs[a];
    _costs[a] = _costs[b];
    _costs[b] = cost;
  }
}
