import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../models/trail_graph.dart';
import '../models/trail_place.dart';
import '../models/waypoint.dart';
import '../services/map_tile_cache_service.dart';
import '../services/trail_store.dart';
import '../services/waypoint_store.dart';
import '../theme/mesh_theme.dart';

/// Plans walking routes offline over trails downloaded by area.
class TrailRoutingScreen extends StatefulWidget {
  /// Replaces the real store (tests).
  final TrailStore? store;
  const TrailRoutingScreen({super.key, this.store});

  @override
  State<TrailRoutingScreen> createState() => _TrailRoutingScreenState();
}

class _TrailRoutingScreenState extends State<TrailRoutingScreen> {
  late final TrailStore _store = widget.store ?? TrailStore();
  final _map = MapController();
  LatLng? _start;
  LatLng? _end;
  TrailRouteResult? _route;
  String? _message;
  var _busy = false;

  @override
  void initState() {
    super.initState();
    unawaited(
      _store.load().then((_) {
        if (mounted) setState(() {});
      }),
    );
  }

  @override
  void dispose() {
    if (widget.store == null) _store.dispose();
    super.dispose();
  }

  void _tap(LatLng point) {
    setState(() {
      _message = null;
      _route = null;
      if (_start == null || _end != null) {
        _start = point;
        _end = null;
      } else {
        _end = point;
      }
    });
    if (_end != null) unawaited(_plan());
  }

  Future<void> _plan() async {
    final a = _start!, b = _end!;
    final area = _store.areaFor(
      a.latitude,
      a.longitude,
      b.latitude,
      b.longitude,
    );
    if (area == null) {
      setState(
        () => _message = 'Download an area that holds both points first.',
      );
      return;
    }
    setState(() => _busy = true);
    try {
      final graph = await _store.graphFor(area);
      final route = graph.route(
        a.latitude,
        a.longitude,
        b.latitude,
        b.longitude,
      );
      if (!mounted) return;
      setState(() {
        _route = route;
        _message = switch (route.problem) {
          null => null,
          TrailRouteProblem.startTooFar =>
            'The start is more than 500 m from a known trail.',
          TrailRouteProblem.endTooFar =>
            'The end is more than 500 m from a known trail.',
          TrailRouteProblem.notConnected =>
            'No known trails join these points.',
        };
      });
    } on FormatException {
      if (mounted) {
        setState(
          () => _message =
              'This area\'s data is damaged. Delete it and download it again.',
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  TrailBounds _visible() {
    final b = _map.camera.visibleBounds;
    return TrailBounds(
      south: b.south,
      west: b.west,
      north: b.north,
      east: b.east,
    );
  }

  Future<void> _download() async {
    final bounds = _visible();
    if (bounds.areaKm2 > maxTrailAreaKm2) {
      setState(
        () => _message =
            'Zoom in: an area can be up to ${maxTrailAreaKm2.round()} km², and this view is ${bounds.areaKm2.round()} km².',
      );
      return;
    }
    final center = _map.camera.center;
    final name =
        '${center.latitude.toStringAsFixed(2)}, ${center.longitude.toStringAsFixed(2)}';
    setState(() {
      _busy = true;
      _message = 'Downloading trails…';
    });
    try {
      final area = await _store.download(name, bounds);
      if (mounted) {
        setState(() => _message = 'Saved ${_size(area.bytes)} of trails.');
      }
    } on TrailDownloadException catch (e) {
      if (mounted) {
        setState(
          () => _message = switch (e.problem) {
            TrailDownloadProblem.tooLarge => 'Zoom in to a smaller area.',
            TrailDownloadProblem.storageFull =>
              'Trail storage is full (500 MB). Delete an area first.',
            TrailDownloadProblem.noTrails => 'No trails found in this view.',
            TrailDownloadProblem.failed =>
              'Download failed. The map server may be busy, so try again later.',
          },
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  String _size(int bytes) => bytes < 1024 * 1024
      ? '${(bytes / 1024).ceil()} KB'
      : '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';

  String _distance(double meters) => '${(meters / 1000).toStringAsFixed(1)} km';

  Future<void> _save() async {
    final route = _route;
    if (route == null || route.problem != null) return;
    final stamp = DateTime.now().microsecondsSinceEpoch;
    final store = context.read<WaypointStore>();
    final points = thin(route.points, maxRoutePoints);
    await store.addImport(
      GpxImport(const [], [
        WaypointRoute(
          id: 'trail-$stamp',
          name: 'Trail route ${_distance(route.meters)}',
          points: [
            for (final (i, p) in points.indexed)
              Waypoint(
                id: 'trail-$stamp-$i',
                name: '${i + 1}',
                lat: p.$1,
                lon: p.$2,
              ),
          ],
        ),
      ]),
    );
    if (mounted) setState(() => _message = 'Saved to your routes.');
  }

  Future<void> _search() async {
    final waypoints = context.read<WaypointStore>().waypoints;
    final places = [
      ...await _store.allPlaces(),
      for (final w in waypoints)
        TrailPlace(w.name, TrailPlaceKind.waypoint, w.lat, w.lon),
    ];
    if (!mounted) return;
    final picked = await showModalBottomSheet<TrailPlace>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _PlaceSearchSheet(places: places),
    );
    if (picked == null || !mounted) return;
    final point = LatLng(picked.lat, picked.lon);
    _map.move(point, 14);
    _tap(point);
  }

  void _showAreas() {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        builder: (sheet) => SafeArea(
          child: ListenableBuilder(
            listenable: _store,
            builder: (_, _) => ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: const Text('Downloaded areas'),
                  subtitle: Text('${_size(_store.usedBytes)} of 500 MB used'),
                ),
                for (final area in _store.areas)
                  ListTile(
                    title: Text(area.name),
                    subtitle: Text(_size(area.bytes)),
                    trailing: IconButton(
                      tooltip: 'Delete ${area.name}',
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => unawaited(_store.delete(area.id)),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tiles = context.read<MapTileCacheService>();
    final route = _route;
    final found = route != null && route.problem == null;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trail routing'),
        actions: [
          IconButton(
            tooltip: 'Search places',
            icon: const Icon(Icons.search),
            onPressed: _search,
          ),
          IconButton(
            tooltip: 'Downloaded areas',
            icon: const Icon(Icons.folder_outlined),
            onPressed: _showAreas,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: _map,
              options: MapOptions(
                initialCenter: const LatLng(39.5, -98.35),
                initialZoom: 3,
                interactionOptions: const InteractionOptions(
                  flags: ~InteractiveFlag.rotate,
                ),
                onTap: (_, p) => _tap(p),
              ),
              children: [
                tiles.buildTileLayer(context),
                PolygonLayer(
                  polygons: [
                    for (final a in _store.areas)
                      Polygon(
                        points: [
                          LatLng(a.bounds.south, a.bounds.west),
                          LatLng(a.bounds.north, a.bounds.west),
                          LatLng(a.bounds.north, a.bounds.east),
                          LatLng(a.bounds.south, a.bounds.east),
                        ],
                        color: Colors.transparent,
                        borderColor: MapPalette.selected,
                        borderStrokeWidth: 1.5,
                      ),
                  ],
                ),
                if (found)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: [
                          for (final p in route.points) LatLng(p.$1, p.$2),
                        ],
                        strokeWidth: 4,
                        color: MapPalette.online,
                      ),
                    ],
                  ),
                MarkerLayer(
                  markers: [
                    if (_start case final p?)
                      Marker(
                        point: p,
                        width: 32,
                        height: 32,
                        child: Semantics(
                          label: 'Route start',
                          child: const Icon(Icons.trip_origin, size: 28),
                        ),
                      ),
                    if (_end case final p?)
                      Marker(
                        point: p,
                        width: 32,
                        height: 32,
                        child: Semantics(
                          label: 'Route end',
                          child: const Icon(Icons.flag, size: 28),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    found
                        ? 'Route: ${_distance(route.meters)} along known trails.'
                        : _start == null
                        ? 'Tap the map for a start, then an end.'
                        : _end == null
                        ? 'Tap the map for the end.'
                        : '',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  if (_message case final m?)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(m),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _busy ? null : _download,
                          icon: const Icon(Icons.download),
                          label: const Text('Download this view'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: found && !_busy ? _save : null,
                          icon: const Icon(Icons.save_outlined),
                          label: const Text('Save route'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Trail data © OpenStreetMap contributors. It can be incomplete or out of date. Routes aren\'t checked for safety or whether they\'re passable, so don\'t use this as your only navigation.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceSearchSheet extends StatefulWidget {
  const _PlaceSearchSheet({required this.places});
  final List<TrailPlace> places;

  @override
  State<_PlaceSearchSheet> createState() => _PlaceSearchSheetState();
}

class _PlaceSearchSheetState extends State<_PlaceSearchSheet> {
  var _query = '';

  @override
  Widget build(BuildContext context) {
    final results = searchPlaces(widget.places, _query);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.7,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                key: const ValueKey('place-search'),
                autofocus: true,
                onChanged: (v) => setState(() => _query = v),
                decoration: const InputDecoration(
                  labelText: 'Search downloaded places',
                  helperText:
                      'Peaks, trailheads, water, huts, towns and your waypoints. Choosing one sets the next route point.',
                  helperMaxLines: 3,
                ),
              ),
            ),
            if (_query.trim().isNotEmpty && results.isEmpty)
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Nothing found. Search only covers downloaded areas, and areas saved before place search need downloading again.',
                ),
              ),
            Expanded(
              child: ListView(
                children: [
                  for (final place in results)
                    ListTile(
                      title: Text(place.name),
                      subtitle: Text(place.kind.label),
                      onTap: () => Navigator.of(context).pop(place),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
