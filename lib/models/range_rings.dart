/// The math behind the map's range rings: how far apart they sit, what
/// each one says, and where points on them fall.
library;

import 'dart:math' as math;

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

/// Rounds [raw] down to the nearest 1, 2 or 5 × 10^n, and never below
/// [minStep]. A non-finite or non-positive [raw] gives [minStep].
double niceStep(double raw, {required double minStep}) {
  if (!raw.isFinite || raw <= minStep) return minStep;
  final exponent = (math.log(raw) / math.ln10).floor();
  final magnitude = math.pow(10, exponent).toDouble();
  // A tiny tolerance so 0.5 or 2000 isn't floored to the step below by a
  // rounding error in log/pow.
  final mantissa = raw / magnitude + 1e-9;
  final double digit;
  if (mantissa >= 10) {
    digit = 10;
  } else if (mantissa >= 5) {
    digit = 5;
  } else if (mantissa >= 2) {
    digit = 2;
  } else {
    digit = 1;
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

/// [value] with at most two decimals and no trailing zeros.
String _trim(double value) {
  final fixed = value.toStringAsFixed(2);
  return fixed.replaceFirst(RegExp(r'\.?0+$'), '');
}

/// Drops float noise such as 0.30000000000000004.
double _clean(double value) => double.parse(value.toStringAsPrecision(12));
