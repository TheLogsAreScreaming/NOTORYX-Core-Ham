import 'dart:convert';

import '../utils/amateur_radio.dart';

/// Radio settings and channel names a team shares by QR code or file.
///
/// Carries no keys: only hashtag channels are shared, because their key comes
/// from the name. Transmit power is left out, since each station sets its
/// own. A frequency outside the ham firmware's bands is refused on import.
class TeamConfig {
  const TeamConfig({
    required this.freqKhz,
    required this.bandwidthHz,
    required this.spreadingFactor,
    required this.codingRate,
    this.channels = const [],
  });

  static const _type = 'notoryx-ham-team';
  static const _maxChannelBytes = 31;

  /// Frequency in kHz, as the radio reports it.
  final int freqKhz;

  /// Bandwidth, in the units the radio reports it.
  final int bandwidthHz;
  final int spreadingFactor;

  /// Coding rate as 5 to 8.
  final int codingRate;

  /// Hashtag channel names, each starting with `#`.
  final List<String> channels;

  /// Builds a config from what's on the radio, keeping only hashtag channels.
  factory TeamConfig.fromRadio({
    required int freqKhz,
    required int bandwidthHz,
    required int spreadingFactor,
    required int deviceCodingRate,
    required Iterable<String> channelNames,
  }) => TeamConfig(
    freqKhz: freqKhz,
    bandwidthHz: bandwidthHz,
    spreadingFactor: spreadingFactor,
    codingRate: deviceCodingRate <= 4 ? deviceCodingRate + 4 : deviceCodingRate,
    channels: [
      for (final n in channelNames)
        if (_validChannel(n)) n,
    ],
  );

  static bool _validChannel(Object? n) =>
      n is String &&
      n.length > 1 &&
      n.startsWith('#') &&
      utf8.encode(n).length <= _maxChannelBytes;

  String encode() => jsonEncode({
    't': _type,
    'v': 1,
    'f': freqKhz,
    'b': bandwidthHz,
    's': spreadingFactor,
    'c': codingRate,
    'ch': channels,
  });

  /// Reads shared text, or null when it isn't a valid team config, is outside
  /// the amateur bands, or carries anything other than the expected fields.
  static TeamConfig? tryParse(String text) {
    if (text.length > 4096) return null;
    final Object? decoded;
    try {
      decoded = jsonDecode(text);
    } on FormatException {
      return null;
    }
    if (decoded is! Map<String, dynamic>) return null;
    const allowed = {'t', 'v', 'f', 'b', 's', 'c', 'ch'};
    if (decoded.keys.any((k) => !allowed.contains(k))) return null;
    if (decoded['t'] != _type || decoded['v'] != 1) return null;
    final (f, b, s, c, ch) = (
      decoded['f'],
      decoded['b'],
      decoded['s'],
      decoded['c'],
      decoded['ch'],
    );
    if (f is! int || b is! int || s is! int || c is! int || ch is! List) {
      return null;
    }
    if (!isAmateurFrequencyMHz(f / 1000.0) || b <= 0) return null;
    if (s < 5 || s > 12 || c < 5 || c > 8) return null;
    if (!ch.every(_validChannel)) return null;
    return TeamConfig(
      freqKhz: f,
      bandwidthHz: b,
      spreadingFactor: s,
      codingRate: c,
      channels: ch.cast<String>().toSet().toList(),
    );
  }
}
