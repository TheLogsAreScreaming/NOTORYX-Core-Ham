import 'dart:math' as math;

/// How positions are written out for the user.
enum CoordinateFormat {
  /// 40.68925, -74.04450
  decimal('decimal'),

  /// 40°41'21.3"N 74°02'40.2"W
  dms('dms'),

  /// 18T 580734 4504695
  utm('utm'),

  /// 18T WL 80734 04695
  mgrs('mgrs');

  const CoordinateFormat(this.value);

  /// The stored settings value.
  final String value;

  static CoordinateFormat parse(Object? raw) =>
      CoordinateFormat.values.firstWhere(
        (f) => f.value == raw,
        orElse: () => CoordinateFormat.decimal,
      );
}

/// A WGS84 position in the Universal Transverse Mercator grid.
class UtmCoordinate {
  const UtmCoordinate({
    required this.zone,
    required this.band,
    required this.easting,
    required this.northing,
  });

  /// Longitude zone, 1 to 60.
  final int zone;

  /// Latitude band letter, C to X (no I or O).
  final String band;

  /// Metres east, including the 500 km false easting.
  final double easting;

  /// Metres north, including the 10,000 km false northing in the south.
  final double northing;

  @override
  String toString() => '$zone$band ${easting.floor()} ${northing.floor()}';
}

const double _a = 6378137.0;
const double _f = 1 / 298.257223563;
const double _k0 = 0.9996;
const String _bands = 'CDEFGHJKLMNPQRSTUVWXX';

/// [lat], [lon] in UTM, or null outside 80°S to 84°N, where the polar grid
/// (UPS) would apply instead.
UtmCoordinate? toUtm(double lat, double lon) {
  if (lat.isNaN || lon.isNaN || lat < -80 || lat > 84) return null;
  var lng = ((lon + 180) % 360 + 360) % 360 - 180;
  if (lng == 180) lng = -180;

  var zone = ((lng + 180) / 6).floor() + 1;
  if (zone > 60) zone = 60;
  // Norway and Svalbard exceptions.
  if (lat >= 56 && lat < 64 && lng >= 3 && lng < 12) zone = 32;
  if (lat >= 72) {
    if (lng >= 0 && lng < 9) {
      zone = 31;
    } else if (lng >= 9 && lng < 21) {
      zone = 33;
    } else if (lng >= 21 && lng < 33) {
      zone = 35;
    } else if (lng >= 33 && lng < 42) {
      zone = 37;
    }
  }

  final e2 = _f * (2 - _f);
  final e4 = e2 * e2;
  final e6 = e4 * e2;
  final ep2 = e2 / (1 - e2);
  final phi = lat * math.pi / 180;
  final lam = lng * math.pi / 180;
  final lam0 = ((zone - 1) * 6 - 180 + 3) * math.pi / 180;

  final sinPhi = math.sin(phi);
  final cosPhi = math.cos(phi);
  final tanPhi = math.tan(phi);
  final n = _a / math.sqrt(1 - e2 * sinPhi * sinPhi);
  final t = tanPhi * tanPhi;
  final c = ep2 * cosPhi * cosPhi;
  final aa = cosPhi * (lam - lam0);
  final m =
      _a *
      ((1 - e2 / 4 - 3 * e4 / 64 - 5 * e6 / 256) * phi -
          (3 * e2 / 8 + 3 * e4 / 32 + 45 * e6 / 1024) * math.sin(2 * phi) +
          (15 * e4 / 256 + 45 * e6 / 1024) * math.sin(4 * phi) -
          (35 * e6 / 3072) * math.sin(6 * phi));

  final a2 = aa * aa;
  final a3 = a2 * aa;
  final a4 = a3 * aa;
  final a5 = a4 * aa;
  final a6 = a5 * aa;
  final easting =
      _k0 *
          n *
          (aa +
              (1 - t + c) * a3 / 6 +
              (5 - 18 * t + t * t + 72 * c - 58 * ep2) * a5 / 120) +
      500000;
  var northing =
      _k0 *
      (m +
          n *
              tanPhi *
              (a2 / 2 +
                  (5 - t + 9 * c + 4 * c * c) * a4 / 24 +
                  (61 - 58 * t + t * t + 600 * c - 330 * ep2) * a6 / 720));
  if (lat < 0) northing += 10000000;

  final bandIndex = ((lat + 80) / 8).floor().clamp(0, _bands.length - 1);
  return UtmCoordinate(
    zone: zone,
    band: _bands[bandIndex],
    easting: easting,
    northing: northing,
  );
}

const List<String> _mgrsColumns = ['ABCDEFGH', 'JKLMNPQR', 'STUVWXYZ'];
const String _mgrsRows = 'ABCDEFGHJKLMNPQRSTUV';

/// [lat], [lon] as a 1-metre MGRS reference such as "18T WL 80734 04695",
/// or null where UTM doesn't apply.
String? toMgrs(double lat, double lon) {
  final utm = toUtm(lat, lon);
  if (utm == null) return null;
  final set = (utm.zone - 1) % 3;
  final col100k = (utm.easting / 100000).floor();
  final colLetters = _mgrsColumns[set];
  final colIndex = (col100k - 1).clamp(0, colLetters.length - 1);
  final row100k = (utm.northing / 100000).floor();
  final rowOffset = utm.zone.isEven ? 5 : 0;
  final rowLetter = _mgrsRows[(row100k + rowOffset) % _mgrsRows.length];
  final e = (utm.easting.floor() % 100000).toString().padLeft(5, '0');
  final nn = (utm.northing.floor() % 100000).toString().padLeft(5, '0');
  return '${utm.zone}${utm.band} ${colLetters[colIndex]}$rowLetter $e $nn';
}

/// [lat], [lon] in degrees, minutes and seconds, for example
/// 40°41'21.3"N 74°02'40.2"W.
String toDms(double lat, double lon) {
  String part(double v, String pos, String neg) {
    final hemi = v < 0 ? neg : pos;
    var totalTenths = (v.abs() * 36000).round();
    final deg = totalTenths ~/ 36000;
    totalTenths -= deg * 36000;
    final min = totalTenths ~/ 600;
    final secTenths = totalTenths - min * 600;
    final sec = (secTenths / 10).toStringAsFixed(1).padLeft(4, '0');
    return "$deg°${min.toString().padLeft(2, '0')}'$sec\"$hemi";
  }

  return '${part(lat, 'N', 'S')} ${part(lon, 'E', 'W')}';
}

/// [lat], [lon] in [format]. UTM and MGRS fall back to decimal near the
/// poles, where they don't apply.
String formatCoordinate(double lat, double lon, CoordinateFormat format) {
  switch (format) {
    case CoordinateFormat.decimal:
      return '${lat.toStringAsFixed(5)}, ${lon.toStringAsFixed(5)}';
    case CoordinateFormat.dms:
      return toDms(lat, lon);
    case CoordinateFormat.utm:
      return toUtm(lat, lon)?.toString() ??
          formatCoordinate(lat, lon, CoordinateFormat.decimal);
    case CoordinateFormat.mgrs:
      return toMgrs(lat, lon) ??
          formatCoordinate(lat, lon, CoordinateFormat.decimal);
  }
}
