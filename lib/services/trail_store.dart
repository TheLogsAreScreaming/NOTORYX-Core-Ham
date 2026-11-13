import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../models/trail_graph.dart';
import '../models/trail_place.dart';

// Big replies are parsed off the UI thread.
(TrailGraph, List<TrailPlace>) _parseOverpass(List<int> body) {
  final json = jsonDecode(utf8.decode(body)) as Map<String, dynamic>;
  return (TrailGraph.fromOverpass(json), placesFromOverpass(json));
}

/// Why an area couldn't be saved.
enum TrailDownloadProblem { tooLarge, storageFull, noTrails, failed }

class TrailDownloadException implements Exception {
  const TrailDownloadException(this.problem);
  final TrailDownloadProblem problem;
}

/// A downloaded area of trails.
class TrailArea {
  const TrailArea({
    required this.id,
    required this.name,
    required this.bounds,
    required this.bytes,
  });

  final String id;
  final String name;
  final TrailBounds bounds;
  final int bytes;
}

/// Downloads trails from OpenStreetMap by area and keeps them on the device.
class TrailStore extends ChangeNotifier {
  TrailStore({
    http.Client? client,
    Directory? directory,
    this.limitBytes = defaultLimitBytes,
  }) : _client = client ?? http.Client(),
       _ownsClient = client == null,
       _directory = directory;

  static const defaultLimitBytes = 500 * 1024 * 1024;
  static final _endpoint = Uri.parse('https://overpass-api.de/api/interpreter');

  final http.Client _client;
  final bool _ownsClient;
  final int limitBytes;
  Directory? _directory;
  final List<TrailArea> _areas = [];
  final Map<String, TrailGraph> _loaded = {};
  final Map<String, List<TrailPlace>> _places = {};
  var _seq = 0;

  List<TrailArea> get areas => List.unmodifiable(_areas);

  int get usedBytes => _areas.fold(0, (n, a) => n + a.bytes);

  Future<Directory> _folder() async {
    final dir =
        _directory ??
        Directory(
          '${(await getApplicationSupportDirectory()).path}'
          '${Platform.pathSeparator}trails',
        );
    _directory = dir;
    await dir.create(recursive: true);
    return dir;
  }

  /// Reads what's already downloaded.
  Future<void> load() async {
    final dir = await _folder();
    _areas.clear();
    await for (final file in dir.list()) {
      if (file is! File || !file.path.endsWith('.meta')) continue;
      try {
        final j = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
        final id = j['id'] as String;
        final data = File('${dir.path}${Platform.pathSeparator}$id.trail');
        if (!await data.exists()) continue;
        _areas.add(
          TrailArea(
            id: id,
            name: j['name'] as String,
            bounds: TrailBounds(
              south: (j['s'] as num).toDouble(),
              west: (j['w'] as num).toDouble(),
              north: (j['n'] as num).toDouble(),
              east: (j['e'] as num).toDouble(),
            ),
            bytes:
                await data.length() +
                await _lengthIfThere(
                  File('${dir.path}${Platform.pathSeparator}$id.places'),
                ),
          ),
        );
      } on FormatException {
        continue;
      } on TypeError {
        continue;
      }
    }
    notifyListeners();
  }

  /// Fetches the walkable ways in [bounds] and saves them as [name].
  Future<TrailArea> download(String name, TrailBounds bounds) async {
    if (bounds.areaKm2 > maxTrailAreaKm2) {
      throw const TrailDownloadException(TrailDownloadProblem.tooLarge);
    }
    final box = '${bounds.south},${bounds.west},${bounds.north},${bounds.east}';
    final query =
        '[out:json][timeout:90];('
        'way["highway"~"$walkableHighwayPattern"]($box);'
        '${placeQueryStatements(box)}'
        ');out body geom;';
    final TrailGraph graph;
    final List<TrailPlace> places;
    try {
      final response = await _client
          .post(
            _endpoint,
            headers: const {'User-Agent': 'NOTORYX-Core'},
            body: {'data': query},
          )
          .timeout(const Duration(seconds: 120));
      if (response.statusCode != 200) {
        throw const TrailDownloadException(TrailDownloadProblem.failed);
      }
      (graph, places) = await compute(_parseOverpass, response.bodyBytes);
    } on TrailDownloadException {
      rethrow;
    } catch (e) {
      debugPrint('Trail download failed: $e');
      throw const TrailDownloadException(TrailDownloadProblem.failed);
    }
    if (graph.nodeCount == 0 && places.isEmpty) {
      throw const TrailDownloadException(TrailDownloadProblem.noTrails);
    }
    final bytes = graph.toBytes();
    final placeBytes = placesToBytes(places);
    final size = bytes.length + placeBytes.length;
    if (usedBytes + size > limitBytes) {
      throw const TrailDownloadException(TrailDownloadProblem.storageFull);
    }
    final dir = await _folder();
    final id = '${DateTime.now().microsecondsSinceEpoch}-${_seq++}';
    final base = '${dir.path}${Platform.pathSeparator}$id';
    await File('$base.trail').writeAsBytes(bytes, flush: true);
    await File('$base.places').writeAsBytes(placeBytes, flush: true);
    await File('$base.meta').writeAsString(
      jsonEncode({
        'id': id,
        'name': name,
        's': bounds.south,
        'w': bounds.west,
        'n': bounds.north,
        'e': bounds.east,
      }),
      flush: true,
    );
    final area = TrailArea(id: id, name: name, bounds: bounds, bytes: size);
    _areas.add(area);
    _loaded[id] = graph;
    _places[id] = places;
    notifyListeners();
    return area;
  }

  Future<void> delete(String id) async {
    final dir = await _folder();
    final base = '${dir.path}${Platform.pathSeparator}$id';
    for (final path in ['$base.trail', '$base.places', '$base.meta']) {
      final file = File(path);
      if (await file.exists()) await file.delete();
    }
    _areas.removeWhere((a) => a.id == id);
    _loaded.remove(id);
    _places.remove(id);
    notifyListeners();
  }

  Future<int> _lengthIfThere(File file) async =>
      await file.exists() ? await file.length() : 0;

  /// Every place in the downloaded areas. Areas saved before place search
  /// have none until they're downloaded again.
  Future<List<TrailPlace>> allPlaces() async {
    final dir = await _folder();
    final out = <TrailPlace>[];
    for (final area in _areas) {
      var places = _places[area.id];
      if (places == null) {
        final file = File(
          '${dir.path}${Platform.pathSeparator}${area.id}.places',
        );
        try {
          places = await file.exists()
              ? placesFromBytes(await file.readAsBytes())
              : const <TrailPlace>[];
        } on FormatException {
          places = const <TrailPlace>[];
        }
        _places[area.id] = places;
      }
      out.addAll(places);
    }
    return out;
  }

  /// The downloaded area holding both points, or null.
  TrailArea? areaFor(double lat1, double lon1, double lat2, double lon2) {
    for (final area in _areas) {
      if (area.bounds.contains(lat1, lon1) &&
          area.bounds.contains(lat2, lon2)) {
        return area;
      }
    }
    return null;
  }

  Future<TrailGraph> graphFor(TrailArea area) async {
    final cached = _loaded[area.id];
    if (cached != null) return cached;
    final dir = await _folder();
    final graph = TrailGraph.fromBytes(
      await File(
        '${dir.path}${Platform.pathSeparator}${area.id}.trail',
      ).readAsBytes(),
    );
    _loaded[area.id] = graph;
    return graph;
  }

  @override
  void dispose() {
    if (_ownsClient) _client.close();
    super.dispose();
  }
}
