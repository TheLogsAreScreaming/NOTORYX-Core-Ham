/// The math behind the map's range rings: how far apart they sit, what
/// each one says, and where points on them fall.
library;

import 'dart:math' as math;

import 'package:flutter/painting.dart';
import 'package:latlong2/latlong.dart';

import 'app_settings.dart';

/// How many rings are drawn.
const rangeRingCount = 4;

/// Metres in one statute mile.
const metresPerMile = 1609.344;

/// The smallest metric ring step, in metres.
const minMetricStep = 10.0;

/// The smallest imperial ring step, in miles.
const minImperialStep = 0.1;

/// The step values tried in each power of ten, smallest first.
///
/// Finer than the classic 1-2-5 so the rings fill at least two thirds of
/// the space they have: rounding 4.9 down to 2 left them at 40%.
const niceMantissas = [1.0, 1.5, 2.0, 2.5, 3.0, 4.0, 5.0, 6.0, 8.0];

/// Rounds [raw] down to the nearest [niceMantissas] value × 10^n (1, 1.5,
/// 2, 2.5, 3, 4, 5, 6 or 8), and never below [minStep]. A non-finite or
/// non-positive [raw] gives [minStep].
double niceStep(double raw, {required double minStep}) {
  if (!raw.isFinite || raw <= minStep) return minStep;
  final exponent = (math.log(raw) / math.ln10).floor();
  final magnitude = math.pow(10, exponent).toDouble();
  // A tiny tolerance so 0.5 or 2000 isn't floored to the step below by a
  // rounding error in log/pow.
  final mantissa = raw / magnitude + 1e-9;
  var digit = niceMantissas.first;
  if (mantissa >= 10) {
    digit = 10;
  } else {
    for (final m in niceMantissas) {
      if (mantissa >= m) digit = m;
    }
  }
  final step = _clean(digit * magnitude);
  return step < minStep ? minStep : step;
}

/// The [rangeRingCount] ring radii, in metres, for a view whose centre is
/// [viewRadiusMetres] from its nearer edge.
///
/// The spacing is a quarter of that distance rounded down by [niceStep]:
/// metres from 10 m up when [units] is metric, miles from 0.1 mi up when
/// it is imperial.
List<double> ringRadii(double viewRadiusMetres, UnitSystem units) {
  final quarter = viewRadiusMetres / rangeRingCount;
  final stepMetres = switch (units) {
    UnitSystem.metric => niceStep(quarter, minStep: minMetricStep),
    UnitSystem.imperial =>
      niceStep(quarter / metresPerMile, minStep: minImperialStep) *
          metresPerMile,
  };
  return [for (var i = 1; i <= rangeRingCount; i++) stepMetres * i];
}

/// The label for a ring [metres] out: "200 m", "1.5 km", "0.3 mi", "2 mi".
String ringLabel(double metres, UnitSystem units) {
  switch (units) {
    case UnitSystem.metric:
      if (metres < 1000) return '${metres.round()} m';
      return '${_trim(metres / 1000)} km';
    case UnitSystem.imperial:
      return '${_trim(metres / metresPerMile)} mi';
  }
}

/// The point [metres] from [centre] on the compass [bearing] (degrees,
/// 0 = north, clockwise), on the same sphere the map's circles use.
LatLng pointAt(LatLng centre, double metres, double bearing) =>
    const Distance().offset(centre, metres, bearing);

/// The bearings tried, in order, for a ring's label: north first, then
/// the directions nearest it, south last.
const labelBearings = [0.0, 45.0, 315.0, 90.0, 270.0, 135.0, 225.0, 180.0];

/// The part of a [view] not covered by the map's overlays: the view less
/// [insets]. When the insets leave nothing, the whole view.
Rect unobscuredArea(Size view, EdgeInsets insets) {
  final area = insets.deflateRect(Offset.zero & view);
  if (area.width <= 0 || area.height <= 0) return Offset.zero & view;
  return area;
}

/// Whether a label of [size] centred on [point] lies wholly inside [area].
bool labelFits(Offset point, Size size, Rect area) {
  final half = Offset(size.width / 2, size.height / 2);
  final topLeft = point - half, bottomRight = point + half;
  return topLeft.dx >= area.left &&
      topLeft.dy >= area.top &&
      bottomRight.dx <= area.right &&
      bottomRight.dy <= area.bottom;
}

/// The first of [bearings] at which a label of [size] fits inside [area],
/// where [toScreen] gives the label's screen point at a bearing; null when
/// it fits at none, so the label is left out rather than drawn hidden.
double? visibleLabelBearing(
  Offset Function(double bearing) toScreen,
  Size size,
  Rect area, {
  List<double> bearings = labelBearings,
}) {
  for (final bearing in bearings) {
    if (labelFits(toScreen(bearing), size, area)) return bearing;
  }
  return null;
}

/// [value] with at most two decimals and no trailing zeros.
String _trim(double value) {
  final fixed = value.toStringAsFixed(2);
  return fixed.replaceFirst(RegExp(r'\.?0+$'), '');
}

/// Drops float noise such as 0.30000000000000004.
double _clean(double value) => double.parse(value.toStringAsPrecision(12));
