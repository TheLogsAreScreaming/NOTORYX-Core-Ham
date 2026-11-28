import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../l10n/l10n.dart';
import '../models/waypoint.dart';
import '../theme/mesh_theme.dart';

/// The line drawn on the map for a saved route.
Polyline waypointRoutePolyline(WaypointRoute route) => Polyline(
  points: [for (final p in route.points) LatLng(p.lat, p.lon)],
  color: MapPalette.shared,
  strokeWidth: 3,
  borderColor: MapPalette.markerOutline,
  borderStrokeWidth: 1.5,
  pattern: StrokePattern.dashed(segments: const [10, 6]),
);

/// A saved waypoint on the map. A pin shape keeps it distinct from the round
/// node and shared-marker icons without relying on colour.
Marker waypointMapMarker(
  Waypoint waypoint, {
  required bool showLabel,
  required VoidCallback onTap,
}) => Marker(
  point: LatLng(waypoint.lat, waypoint.lon),
  width: 120,
  height: 62,
  child: Semantics(
    button: true,
    label: waypoint.name,
    excludeSemantics: true,
    child: GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.push_pin,
            size: 34,
            color: MapPalette.shared,
            shadows: [Shadow(color: MapPalette.markerShadow, blurRadius: 6)],
          ),
          if (showLabel)
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                color: MapPalette.markerShadow,
                child: Text(
                  waypoint.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
        ],
      ),
    ),
  ),
);

/// Shows a waypoint's details, with its coordinates ready to copy.
Future<void> showWaypointMapSheet(BuildContext context, Waypoint waypoint) {
  final coords =
      '${waypoint.lat.toStringAsFixed(5)}, ${waypoint.lon.toStringAsFixed(5)}';
  return showModalBottomSheet<void>(
    context: context,
    builder: (sheet) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.push_pin),
            title: Text(waypoint.name),
            subtitle: Text(
              [
                coords,
                if (waypoint.ele != null) '${waypoint.ele!.round()} m',
                if (waypoint.note.isNotEmpty) waypoint.note,
              ].join('\n'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.copy),
            title: Text(sheet.l10n.waypoints_copy),
            onTap: () async {
              final navigator = Navigator.of(sheet);
              await Clipboard.setData(ClipboardData(text: coords));
              navigator.pop();
            },
          ),
        ],
      ),
    ),
  );
}
