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

/// Cautions for transmitting on [mhz] from [lat], [lon]. Empty when nothing
/// applies; one entry asking for a position when it's unknown.
List<String> locationCautions(double mhz, double? lat, double? lon) {
  if (lat == null || lon == null || (lat == 0 && lon == 0)) {
    return ['Position unknown: check §97.303 for limits where you operate.'];
  }
  final cautions = <String>[];
  if (mhz >= 902 && mhz <= 928) {
    if (_coloradoWyoming.contains(lat, lon) ||
        _texasNewMexico.contains(lat, lon)) {
      cautions.add(
        'This area appears to be inside a §97.303(g) exclusion: amateur '
        'stations may not transmit on 33 cm here.',
      );
    }
  }
  // Line A runs roughly parallel to the Canadian border, about 50-100 miles
  // south of it. North of it, 420-430 MHz isn't available to amateurs.
  if (mhz >= 420 && mhz < 430 && lat >= 41.0) {
    cautions.add(
      'If you are north of Line A (near the Canadian border), 420–430 MHz '
      "isn't available. Check §97.303.",
    );
  }
  return cautions;
}
