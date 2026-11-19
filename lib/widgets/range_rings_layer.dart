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
///
/// The rings are sized to the part of the map not covered by its overlays
/// ([insets]). A ring label moves round its ring to a direction where it
/// can be seen, and a label or compass tag that would sit under an
/// overlay at every direction is left out.
class RangeRingsLayer extends StatelessWidget {
  const RangeRingsLayer({
    super.key,
    required this.centre,
    required this.units,
    required this.dark,
    this.insets = EdgeInsets.zero,
  });

  final LatLng centre;
  final UnitSystem units;

  /// Whether the map is under a dark overlay, for the label colours.
  final bool dark;

  /// How far the map's overlays (search bar, toolbar, controls) reach in
  /// from each edge of the map.
  final EdgeInsets insets;

  static const _labelSize = Size(72, 20);
  static const _compassSize = Size(24, 20);

  /// How far out the compass tags sit, as a share of the outer ring.
  static const _compassReach = 1.12;

  static const _compass = ['N', 'E', 'S', 'W'];

  @override
  Widget build(BuildContext context) {
    final camera = MapCamera.of(context);
    final area = unobscuredArea(camera.nonRotatedSize, insets);
    // Leave room past the outer ring for the compass tags.
    final half = math.max(
      1.0,
      (math.min(area.width, area.height) / 2 - _compassSize.height) /
          _compassReach,
    );
    final toEdge = const Distance().as(
      LengthUnit.Meter,
      camera.screenOffsetToLatLng(area.center),
      camera.screenOffsetToLatLng(area.center + Offset(half, 0)),
    );
    Offset onScreen(double metres, double bearing) =>
        camera.latLngToScreenOffset(pointAt(centre, metres, bearing));
    final radii = ringRadii(toEdge, units);
    final outer = radii.last;
    final line = dark ? MapPalette.textPrimary : MapPalette.panelDark;
    final labelStyle = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: dark ? MapPalette.textPrimary : MapPalette.panelDark,
    );
    final chip = dark ? MapPalette.panelDark : MapPalette.panelLight;

    Marker tag(LatLng point, String text, Size size) => Marker(
      point: point,
      width: size.width,
      height: size.height,
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
                if (visibleLabelBearing(
                      (bearing) => onScreen(r, bearing),
                      _labelSize,
                      area,
                    )
                    case final bearing?)
                  tag(
                    pointAt(centre, r, bearing),
                    ringLabel(r, units),
                    _labelSize,
                  ),
              for (var i = 0; i < _compass.length; i++)
                if (labelFits(
                  onScreen(outer * _compassReach, i * 90.0),
                  _compassSize,
                  area,
                ))
                  tag(
                    pointAt(centre, outer * _compassReach, i * 90.0),
                    _compass[i],
                    _compassSize,
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
