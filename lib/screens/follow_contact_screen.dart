import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/l10n.dart';
import '../models/contact.dart';
import '../models/field_intel.dart';
import '../models/app_settings.dart';
import '../services/app_settings_service.dart';
import '../services/follow_service.dart';
import '../services/map_tile_cache_service.dart';
import '../services/phone_location.dart';
import '../theme/mesh_theme.dart';
import '../widgets/node_sheet.dart' show distanceLabel;

/// Starts following [contact] for 15 minutes and opens the live view.
void followContact(BuildContext context, Contact contact) {
  final follow = context.read<FollowService?>();
  if (follow == null) return;
  if (!follow.isFollowing(contact.publicKeyHex)) follow.start(contact);
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => FollowContactScreen(contact: contact),
    ),
  );
}

/// A followed contact's trail on a map, with distance and bearing from you
/// and the time left.
class FollowContactScreen extends StatefulWidget {
  const FollowContactScreen({super.key, required this.contact});

  final Contact contact;

  @override
  State<FollowContactScreen> createState() => _FollowContactScreenState();
}

class _FollowContactScreenState extends State<FollowContactScreen> {
  Timer? _tick;
  PhoneFix? _phone;
  final _map = MapController();
  bool _userMoved = false;

  @override
  void initState() {
    super.initState();
    _tick = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (t.tick % 30 == 1) unawaited(_refreshPhone());
      setState(() {});
    });
  }

  Future<void> _refreshPhone() async {
    final fix = await lastKnownPhoneFix();
    if (mounted && fix != null) setState(() => _phone = fix);
  }

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }

  ({double lat, double lon})? _self(MeshCoreConnector connector) {
    final lat = connector.selfLatitude, lon = connector.selfLongitude;
    if (lat != null && lon != null && (lat != 0 || lon != 0)) {
      return (lat: lat, lon: lon);
    }
    final p = _phone;
    return p == null ? null : (lat: p.lat, lon: p.lon);
  }

  String _clock(Duration d) {
    final m = d.inMinutes, s = d.inSeconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final follow = context.watch<FollowService?>();
    final connector = context.watch<MeshCoreConnector>();
    final imperial =
        context.read<AppSettingsService>().settings.unitSystem ==
        UnitSystem.imperial;
    final following =
        follow != null && follow.isFollowing(widget.contact.publicKeyHex);
    final trail = following ? follow.trail : const <FollowPoint>[];
    final last = trail.isEmpty ? null : trail.last;
    final self = _self(connector);

    String? fromYou;
    if (last != null && self != null) {
      final km = distanceKm(self.lat, self.lon, last.lat, last.lon);
      final deg = bearingDeg(self.lat, self.lon, last.lat, last.lon);
      fromYou = l10n.follow_fromYou(
        distanceLabel(km, imperial),
        compassPoint(deg),
        deg.round(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.follow_title(widget.contact.name)),
        centerTitle: true,
        actions: [
          if (following)
            IconButton(
              tooltip: l10n.follow_askNow,
              icon: const Icon(Icons.my_location),
              onPressed: connector.isConnected
                  ? () => unawaited(follow.askNow())
                  : null,
            ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: following
                  ? _status(follow, fromYou, last)
                  : _stopped(follow),
            ),
            Expanded(child: _mapView(trail, self)),
          ],
        ),
      ),
    );
  }

  Widget _status(FollowService follow, String? fromYou, FollowPoint? last) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final age = last == null ? null : follow.now.difference(last.at);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                fromYou ??
                    (last == null
                        ? l10n.follow_waiting
                        : l10n.follow_noOwnPosition),
                style: theme.textTheme.titleMedium,
              ),
            ),
            Semantics(
              label: l10n.follow_timeLeftLabel(follow.remaining.inMinutes + 1),
              excludeSemantics: true,
              child: Chip(
                avatar: const Icon(Icons.timer_outlined, size: 18),
                label: Text(_clock(follow.remaining)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          [
            if (age != null) l10n.follow_lastFix(_ago(age)),
            l10n.follow_answers(follow.answered, follow.asked),
            l10n.follow_points(follow.trail.length),
          ].join(' · '),
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.follow_hint,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: MeshPalette.ink3,
                ),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: follow.stop,
              icon: const Icon(Icons.stop_circle_outlined),
              label: Text(l10n.follow_stop),
            ),
          ],
        ),
      ],
    );
  }

  String _ago(Duration d) {
    final l10n = context.l10n;
    if (d.inSeconds < 60) return l10n.follow_secondsAgo(d.inSeconds);
    return l10n.follow_minutesAgo(d.inMinutes);
  }

  Widget _stopped(FollowService? follow) {
    final l10n = context.l10n;
    return Row(
      children: [
        Expanded(child: Text(l10n.follow_stopped)),
        if (follow != null)
          FilledButton.icon(
            onPressed: () => follow.start(widget.contact),
            icon: const Icon(Icons.radar),
            label: Text(l10n.follow_start),
          ),
      ],
    );
  }

  Widget _mapView(List<FollowPoint> trail, ({double lat, double lon})? self) {
    final points = [for (final p in trail) LatLng(p.lat, p.lon)];
    final me = self == null ? null : LatLng(self.lat, self.lon);
    final all = [...points, ?me];
    if (all.isEmpty) {
      final c = widget.contact;
      if (c.hasLocation) all.add(LatLng(c.latitude!, c.longitude!));
    }
    if (all.isEmpty) {
      return Center(child: Text(context.l10n.follow_waiting));
    }
    if (!_userMoved && all.length > 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || _userMoved) return;
        try {
          _map.fitCamera(
            CameraFit.coordinates(
              coordinates: all,
              padding: const EdgeInsets.all(48),
              maxZoom: 17,
            ),
          );
        } catch (_) {
          // The map isn't laid out yet; the next frame fits it.
        }
      });
    }
    return FlutterMap(
      mapController: _map,
      options: MapOptions(
        initialCenter: all.last,
        initialZoom: 15,
        interactionOptions: const InteractionOptions(
          flags: ~InteractiveFlag.rotate,
        ),
        onPositionChanged: (_, hasGesture) {
          if (hasGesture) _userMoved = true;
        },
      ),
      children: [
        context.read<MapTileCacheService>().buildTileLayer(context),
        if (points.length > 1)
          PolylineLayer(
            polylines: [
              Polyline(
                points: points,
                strokeWidth: 4,
                color: MeshPalette.accent,
              ),
            ],
          ),
        if (me != null && points.isNotEmpty)
          PolylineLayer(
            polylines: [
              Polyline(
                points: [me, points.last],
                strokeWidth: 2,
                color: MeshPalette.ink3,
                pattern: StrokePattern.dashed(segments: const [8, 6]),
              ),
            ],
          ),
        MarkerLayer(
          markers: [
            for (final p in points.take(points.length - 1))
              Marker(
                point: p,
                width: 10,
                height: 10,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: MeshPalette.accent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            if (points.isNotEmpty)
              Marker(
                point: points.last,
                width: 40,
                height: 40,
                child: Icon(
                  Icons.person_pin_circle,
                  color: MeshPalette.accent,
                  size: 40,
                  semanticLabel: widget.contact.name,
                ),
              ),
            if (me != null)
              Marker(
                point: me,
                width: 28,
                height: 28,
                child: Icon(
                  Icons.navigation,
                  color: MeshPalette.signal,
                  semanticLabel: context.l10n.follow_you,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
