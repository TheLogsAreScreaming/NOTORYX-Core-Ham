/// Places where 47 CFR §97.303 limits the bands the ham firmware uses.
///
/// These are coarse checks to prompt the operator, not a legal answer: they
/// use the rule's boxes as written, and the radio's reported position. Check
/// the current text of §97.303 for where you are.
library;

/// A latitude/longitude box (west longitudes negative).
class _Box {
  const _Box(this.south, this.north, this.west, this.east);
  final double south, north, west, east;

  bool contains(double lat, double lon) =>
      lat >= south && lat <= north && lon >= west && lon <= east;
}

// §97.303(g)(2): no amateur transmissions on 902-928 MHz from these parts of
// Colorado and Wyoming, and of Texas and New Mexico.
const _coloradoWyoming = _Box(39.0, 42.0, -108.0, -103.0);
const _texasNewMexico = _Box(31 + 41 / 60, 34.5, -(107.5), -(104 + 11 / 60));

/// What may limit transmitting where the radio is.
enum LocationCaution {
  /// No position, so nothing could be checked.
  positionUnknown,

  /// Inside a §97.303(g) area where amateurs may not use 902-928 MHz.
  exclusion33cm,

  /// 420-430 MHz far enough north that Line A may apply.
  lineA,
}

/// Cautions for transmitting on [mhz] from [lat], [lon]. Empty when nothing
/// applies.
List<LocationCaution> locationCautions(double mhz, double? lat, double? lon) {
  if (lat == null || lon == null || (lat == 0 && lon == 0)) {
    return const [LocationCaution.positionUnknown];
  }
  return [
    if (mhz >= 902 &&
        mhz <= 928 &&
        (_coloradoWyoming.contains(lat, lon) ||
            _texasNewMexico.contains(lat, lon)))
      LocationCaution.exclusion33cm,
    // Line A runs roughly parallel to the Canadian border, about 50-100 miles
    // south of it. North of it, 420-430 MHz isn't available to amateurs.
    if (mhz >= 420 && mhz < 430 && lat >= 41.0) LocationCaution.lineA,
  ];
}
