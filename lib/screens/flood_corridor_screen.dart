import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../helpers/flood_corridor_geometry.dart';
import '../l10n/l10n.dart';
import '../models/flood_corridor.dart';
import '../services/map_tile_cache_service.dart';
import '../theme/mesh_theme.dart';
import '../widgets/app_bar.dart';

/// Shows the corridor the connected radio would use to flood toward [target].
class FloodCorridorScreen extends StatefulWidget {
  final LatLng target;

  const FloodCorridorScreen({super.key, required this.target});

  @override
  State<FloodCorridorScreen> createState() => _FloodCorridorScreenState();
}

class _FloodCorridorScreenState extends State<FloodCorridorScreen> {
  final MapController _mapController = MapController();
  CorridorProposal? _proposal;
  bool _loading = true;
  bool _moreCoverage = false;

  @override
  void initState() {
    super.initState();
    _requestProposal();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _requestProposal() async {
    setState(() => _loading = true);
    final proposal = await context.read<MeshCoreConnector>().proposeCorridor(
      widget.target.latitude,
      widget.target.longitude,
      dense: _moreCoverage,
    );
    if (!mounted) return;
    setState(() {
      _proposal = proposal;
      _loading = false;
    });
    final points = _boundsPoints(proposal);
    if (points.length > 1) {
      _mapController.fitCamera(
        CameraFit.bounds(
          bounds: LatLngBounds.fromPoints(points),
          padding: const EdgeInsets.fromLTRB(48, 48, 48, 320),
        ),
      );
    }
  }

  List<LatLng> _boundsPoints(CorridorProposal? proposal) {
    final points = [widget.target];
    for (final triple in proposal?.triples ?? const <CorridorTriple>[]) {
      if (triple.isUnlimited) continue;
      final degLat = triple.radiusKm / 111;
      points
        ..add(LatLng(triple.lat - degLat, triple.lon))
        ..add(LatLng(triple.lat + degLat, triple.lon));
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    final connector = context.watch<MeshCoreConnector>();
    final tileCache = context.read<MapTileCacheService>();
    final triples = _proposal?.triples ?? const <CorridorTriple>[];
    final self =
        connector.selfLatitude != null && connector.selfLongitude != null
        ? LatLng(connector.selfLatitude!, connector.selfLongitude!)
        : null;
    final repeaters = connector.allContacts
        .where((c) => c.type == advTypeRepeater && c.hasLocation)
        .map((c) => LatLng(c.latitude!, c.longitude!))
        .toList();
    final outline = MapPalette.selected.withValues(alpha: 0.8);

    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(context.l10n.floodCorridor_title),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: widget.target,
              initialZoom: 9,
              interactionOptions: const InteractionOptions(
                flags: ~InteractiveFlag.rotate,
              ),
            ),
            children: [
              tileCache.buildTileLayer(context),
              // One translucent group so overlapping circles and segments
              // shade as a single area instead of stacking.
              Opacity(
                opacity: 0.2,
                child: Stack(
                  children: [
                    PolygonLayer(
                      polygons: [
                        for (final points in corridorSegmentPolygons(triples))
                          Polygon(points: points, color: MapPalette.selected),
                      ],
                    ),
                    CircleLayer(circles: _circles(triples, fill: true)),
                  ],
                ),
              ),
              CircleLayer(circles: _circles(triples, outline: outline)),
              PolylineLayer(
                polylines: [
                  if (triples.length > 1)
                    Polyline(
                      points: [for (final t in triples) LatLng(t.lat, t.lon)],
                      color: outline,
                      strokeWidth: 2,
                      pattern: StrokePattern.dashed(segments: const [8, 6]),
                    ),
                ],
              ),
              MarkerLayer(
                markers: [
                  for (final point in repeaters)
                    Marker(
                      point: point,
                      width: 14,
                      height: 14,
                      child: _dot(
                        isPointInCorridor(point, triples)
                            ? MapPalette.repeater
                            : MapPalette.offline,
                      ),
                    ),
                  if (self != null)
                    Marker(
                      point: self,
                      width: 32,
                      height: 32,
                      child: const Icon(
                        Icons.person_pin_circle,
                        color: MapPalette.selected,
                        size: 32,
                      ),
                    ),
                  Marker(
                    point: widget.target,
                    width: 32,
                    height: 32,
                    alignment: Alignment.topCenter,
                    child: const Icon(
                      Icons.location_on,
                      color: MapPalette.batteryLow,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: SafeArea(
              child: _buildPanel(context, connector, repeaters, triples),
            ),
          ),
        ],
      ),
    );
  }

  List<CircleMarker> _circles(
    List<CorridorTriple> triples, {
    bool fill = false,
    Color outline = Colors.transparent,
  }) => [
    for (final t in triples)
      if (!t.isUnlimited)
        CircleMarker(
          point: LatLng(t.lat, t.lon),
          radius: t.radiusKm * 1000,
          useRadiusInMeter: true,
          color: fill ? MapPalette.selected : Colors.transparent,
          borderColor: outline,
          borderStrokeWidth: fill ? 0 : 1.5,
        ),
  ];

  Widget _dot(Color color) => DecoratedBox(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
      border: Border.all(color: MapPalette.markerOutline, width: 2),
    ),
  );

  Widget _buildPanel(
    BuildContext context,
    MeshCoreConnector connector,
    List<LatLng> repeaters,
    List<CorridorTriple> triples,
  ) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final proposal = _proposal;

    final List<Widget> lines;
    if (_loading) {
      lines = [
        Row(
          children: [
            const SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(l10n.floodCorridor_requesting)),
          ],
        ),
      ];
    } else if (connector.floodCorridorSupported != true) {
      lines = [Text(l10n.floodCorridor_unsupported)];
    } else if (proposal == null || proposal.isEmpty) {
      lines = [Text(l10n.floodCorridor_noProposal)];
    } else {
      final inside = repeaters
          .where((p) => isPointInCorridor(p, triples))
          .length;
      lines = [
        Text(
          proposal.tier == 0
              ? l10n.floodCorridor_straightLine
              : l10n.floodCorridor_followsRepeaters,
          style: textTheme.titleSmall,
        ),
        const SizedBox(height: 4),
        Text(
          '${l10n.floodCorridor_circleCount(triples.length)} · '
          '${l10n.floodCorridor_repeatersInside(inside, repeaters.length)}',
        ),
        if (proposal.isHorizonLimited)
          _warning(l10n.floodCorridor_horizonLimited),
        if (proposal.hasThinStretch) _warning(l10n.floodCorridor_thinStretch),
      ];
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...lines,
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.floodCorridor_moreCoverage),
              value: _moreCoverage,
              onChanged: _loading || connector.floodCorridorSupported != true
                  ? null
                  : (value) {
                      _moreCoverage = value;
                      _requestProposal();
                    },
            ),
            Text(l10n.floodCorridor_previewNote, style: textTheme.bodySmall),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _warning(String text) => Padding(
    padding: const EdgeInsets.only(top: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.warning_amber, size: 18, color: MapPalette.stale),
        const SizedBox(width: 6),
        Expanded(child: Text(text)),
      ],
    ),
  );
}
