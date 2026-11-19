import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/app_settings.dart';
import '../models/range_rings.dart';
import '../theme/mesh_theme.dart';

/// Distance rings around [centre], sized to the visible view: four rings,
/// a label on each at its north point, eight faint spokes and N/E/S/W tags
/// just outside the outer ring. Put it in a [FlutterMap]'s children; it
/// resizes as the view moves.
class RangeRingsLayer extends StatelessWidget {
  const RangeRingsLayer({
    super.key,
    required this.centre,
    required this.units,
    required this.dark,
  });

  final LatLng centre;
  final UnitSystem units;

  /// Whether the map is under a dark overlay, for the label colours.
  final bool dark;

  static const _compass = ['N', 'E', 'S', 'W'];

  @override
  Widget build(BuildContext context) {
    final camera = MapCamera.of(context);
    final bounds = camera.visibleBounds;
    final view = camera.center;
    const distance = Distance();
    final toEdge = math.min(
      distance.as(LengthUnit.Meter, view, LatLng(view.latitude, bounds.east)),
      distance.as(LengthUnit.Meter, view, LatLng(bounds.north, view.longitude)),
    );
    final radii = ringRadii(toEdge, units);
    final outer = radii.last;
    final line = dark ? MapPalette.textPrimary : MapPalette.panelDark;
    final labelStyle = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: dark ? MapPalette.textPrimary : MapPalette.panelDark,
    );
    final chip = dark ? MapPalette.panelDark : MapPalette.panelLight;

    Marker tag(LatLng point, String text, {double width = 72}) => Marker(
      point: point,
      width: width,
      height: 20,
      child: IgnorePointer(
        child: Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: chip.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(MeshRadii.sm),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(text, style: labelStyle, maxLines: 1),
            ),
          ),
        ),
      ),
    );

    return ExcludeSemantics(
      child: Stack(
        children: [
          PolylineLayer(
            polylines: [
              for (var bearing = 0.0; bearing < 360; bearing += 45)
                Polyline(
                  points: [centre, pointAt(centre, outer, bearing)],
                  color: line.withValues(alpha: 0.25),
                  strokeWidth: 1,
                ),
            ],
          ),
          CircleLayer(
            circles: [
              for (final r in radii)
                CircleMarker(
                  point: centre,
                  radius: r,
                  useRadiusInMeter: true,
                  color: Colors.transparent,
                  borderColor: line.withValues(alpha: 0.6),
                  borderStrokeWidth: 1.5,
                ),
            ],
          ),
          MarkerLayer(
            markers: [
              for (final r in radii)
                tag(pointAt(centre, r, 0), ringLabel(r, units)),
              for (var i = 0; i < _compass.length; i++)
                tag(
                  pointAt(centre, outer * 1.12, i * 90.0),
                  _compass[i],
                  width: 24,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
