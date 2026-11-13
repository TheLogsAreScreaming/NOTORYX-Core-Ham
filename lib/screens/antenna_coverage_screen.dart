import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_protocol.dart';
import '../connector/meshcore_connector.dart';
import '../models/coverage_sweep.dart';
import '../services/line_of_sight_service.dart';
import '../services/map_tile_cache_service.dart';
import '../theme/mesh_theme.dart';
import '../widgets/ember_backdrop.dart';

/// Estimates where an antenna could reach with terrain line of sight:
/// 36 bearings sampled out to a chosen radius against terrain heights.
class AntennaCoverageScreen extends StatefulWidget {
  /// Replaces the online terrain service (tests).
  final LineOfSightService? service;
  const AntennaCoverageScreen({super.key, this.service});

  @override
  State<AntennaCoverageScreen> createState() => _AntennaCoverageScreenState();
}

class _AntennaCoverageScreenState extends State<AntennaCoverageScreen> {
  late final LineOfSightService _service =
      widget.service ?? LineOfSightService();
  final _map = MapController();
  LatLng? _origin;
  bool _fromRadio = false;
  double _height = antennaHeights[1];
  int _radiusKm = coverageRadiiKm[1];
  CoverageResult? _result;
  bool _running = false;
  int _run = 0;

  @override
  void initState() {
    super.initState();
    final c = context.read<MeshCoreConnector>();
    final lat = c.selfLatitude, lon = c.selfLongitude;
    if (lat != null && lon != null && !(lat == 0 && lon == 0)) {
      _origin = LatLng(lat, lon);
      _fromRadio = true;
    }
  }

  @override
  void dispose() {
    if (widget.service == null) _service.dispose();
    super.dispose();
  }

  double? _frequencyMHz(MeshCoreConnector c) =>
      radioFrequencyMHz(c.currentFreqHz);

  CoverageRadio? _radioSettings(MeshCoreConnector c) {
    final freq = _frequencyMHz(c);
    final power = c.currentTxPower;
    final bw = c.currentBwHz;
    final sf = c.currentSf;
    if (freq == null || power == null || bw == null || sf == null) return null;
    return CoverageRadio(
      txPowerDbm: power,
      frequencyMHz: freq,
      bandwidthHz: bw,
      spreadingFactor: sf,
    );
  }

  String _summary(CoverageResult r) {
    if (r.radio == null) {
      return 'Line of sight to ${(r.visibleFraction * 100).round()}% of sampled points • farthest ${(r.maxReachMeters / 1000).toStringAsFixed(1)} km';
    }
    final strong = (r.fractionAt(SignalLevel.strong) * 100).round();
    final marginal = (r.fractionAt(SignalLevel.marginal) * 100).round();
    return 'Estimated signal: strong to $strong% of the area, marginal to $marginal%, usable up to ${(r.maxSignalReachMeters / 1000).toStringAsFixed(1)} km.';
  }

  Future<void> _analyze() async {
    final origin = _origin;
    if (origin == null) return;
    final run = ++_run;
    final connector = context.read<MeshCoreConnector>();
    final freq = _frequencyMHz(connector);
    final radio = _radioSettings(connector);
    setState(() => _running = true);
    final result = await _service.analyzeCoverage(
      origin,
      antennaHeightMeters: _height,
      radiusMeters: _radiusKm * 1000.0,
      frequencyMHz: freq,
      radio: radio,
    );
    if (!mounted || run != _run) return;
    setState(() {
      _result = result;
      _running = false;
    });
  }

  void _setOrigin(LatLng p) => setState(() {
    _origin = p;
    _fromRadio = false;
    _result = null;
  });

  @override
  Widget build(BuildContext context) {
    final tiles = context.read<MapTileCacheService>();
    final result = _result;
    final origin = _origin;
    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: const Text('Antenna coverage'),
        ),
        body: Column(
          children: [
            Expanded(
              child: FlutterMap(
                mapController: _map,
                options: MapOptions(
                  initialCenter: origin ?? const LatLng(39.5, -98.35),
                  initialZoom: origin == null ? 3 : 11,
                  interactionOptions: const InteractionOptions(
                    flags: ~InteractiveFlag.rotate,
                  ),
                  onLongPress: (_, p) => _setOrigin(p),
                ),
                children: [
                  tiles.buildTileLayer(context),
                  if (origin != null)
                    CircleLayer(
                      circles: [
                        CircleMarker(
                          point: origin,
                          radius: _radiusKm * 1000.0,
                          useRadiusInMeter: true,
                          color: Colors.transparent,
                          borderColor: MapPalette.selected,
                          borderStrokeWidth: 1.5,
                        ),
                      ],
                    ),
                  if (result != null && result.error == null)
                    CircleLayer(
                      key: const ValueKey('coverage-points'),
                      circles: _coverageDots(result),
                    ),
                  if (origin != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: origin,
                          width: 36,
                          height: 36,
                          child: const Icon(
                            Icons.cell_tower,
                            color: MapPalette.cluster,
                            size: 32,
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
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      origin == null
                          ? 'Long-press the map to place the antenna.'
                          : _fromRadio
                          ? "Antenna at your radio's position. Long-press the map to move it."
                          : 'Antenna placed on the map. Long-press to move it.',
                    ),
                    const SizedBox(height: 8),
                    _choices<double>(
                      'Antenna height',
                      antennaHeights,
                      _height,
                      (h) => '${h.toStringAsFixed(0)} m',
                      (h) => setState(() {
                        _height = h;
                        _result = null;
                      }),
                    ),
                    _choices<int>(
                      'Radius',
                      coverageRadiiKm,
                      _radiusKm,
                      (r) => '$r km',
                      (r) => setState(() {
                        _radiusKm = r;
                        _result = null;
                      }),
                    ),
                    const SizedBox(height: 8),
                    FilledButton.icon(
                      key: const ValueKey('analyze-coverage'),
                      onPressed: origin == null || _running ? null : _analyze,
                      icon: _running
                          ? const SizedBox.square(
                              dimension: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.radar),
                      label: Text(
                        _running ? 'Checking terrain…' : 'Estimate coverage',
                      ),
                    ),
                    if (result != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        result.error != null
                            ? 'Terrain heights could not be loaded. This needs an internet connection the first time.'
                            : _summary(result),
                        key: const ValueKey('coverage-summary'),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      result?.radio != null
                          ? 'Large green dots: strong signal. Small orange dots: marginal. A rough estimate from terrain and your radio settings, assuming 2 dBi antennas. Trees and buildings are not included, so real range is often shorter.'
                          : 'Connect a radio for signal estimates. Green dots have terrain line of sight to a handheld radio (1.5 m). A rough estimate, not a guarantee.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Colour never stands alone: marginal dots are also smaller.
  List<CircleMarker> _coverageDots(CoverageResult result) {
    final radio = result.radio;
    final dots = <CircleMarker>[];
    for (final ray in result.rays) {
      for (var i = 0; i < ray.points.length; i++) {
        if (radio == null) {
          if (ray.visible[i]) dots.add(_dot(ray.points[i], true));
          continue;
        }
        final dbm = ray.signalDbm[i];
        if (dbm == null) continue;
        final level = radio.levelOf(dbm);
        if (level != SignalLevel.none) {
          dots.add(_dot(ray.points[i], level == SignalLevel.strong));
        }
      }
    }
    return dots;
  }

  CircleMarker _dot(LatLng point, bool strong) => CircleMarker(
    point: point,
    radius: strong ? 5 : 3,
    color: (strong ? MapPalette.online : MeshPalette.warn).withValues(
      alpha: .75,
    ),
  );

  Widget _choices<T>(
    String label,
    List<T> values,
    T selected,
    String Function(T) text,
    ValueChanged<T> onSelected,
  ) => Padding(
    padding: const EdgeInsets.only(top: 6),
    child: Row(
      children: [
        SizedBox(width: 110, child: Text(label)),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final v in values)
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: ChoiceChip(
                      label: Text(text(v)),
                      selected: v == selected,
                      onSelected: _running ? null : (_) => onSelected(v),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
