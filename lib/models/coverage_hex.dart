/// Coverage mapping on a hexagon grid: what the radio heard in each H3
/// cell, and how that gets shared with coverage maps without giving away
/// exactly where the phone was.
library;

/// H3 resolution for coverage cells: about 0.9 km across, coarse enough
/// that a cell doesn't pinpoint a home.
const coverageResolution = 8;

/// Fixes less accurate than this are dropped rather than smeared across
/// the wrong cell.
const maxFixAccuracyMeters = 200.0;

/// A packet only counts if the phone had a good fix this recently.
const maxFixAge = Duration(seconds: 30);

/// Samples are grouped into buckets this long, so an upload says "heard
/// here in this quarter hour", never the exact second.
const bucketLength = Duration(minutes: 15);

/// How long unsent samples wait on the phone before they're dropped.
const keepSamplesFor = Duration(days: 7);

/// How a target sees your coverage.
enum CoveragePrivacy {
  /// Sent as soon as each 15-minute bucket closes.
  live(Duration.zero),

  /// Held for 3 hours, so the map can't show where you are right now.
  delayed(Duration(hours: 3)),

  /// Held for 24 hours, times rounded to the day, and not signed, so
  /// uploads can't be linked to each other.
  anonymous(Duration(hours: 24));

  const CoveragePrivacy(this.delay);
  final Duration delay;
}

/// What a target's endpoint expects.
enum CoverageFormat {
  /// NOTORYX's own format: H3 cell IDs only, no coordinates.
  hexagons,

  /// MeshMapper's custom-endpoint format (RX pings), with each ping placed
  /// at the centre of its cell instead of the phone's position.
  meshMapper,
}

DateTime bucketStart(DateTime time) {
  final utc = time.toUtc();
  final minutes = utc.minute - utc.minute % bucketLength.inMinutes;
  return DateTime.utc(utc.year, utc.month, utc.day, utc.hour, minutes);
}

/// Everything heard in one cell during one bucket.
class HexSample {
  final String cell;
  final DateTime bucket;
  int count;
  double bestSnr;
  int bestRssi;

  /// Repeater IDs (hex) heard directly here, strongest SNR kept.
  final Map<String, double> repeaters;

  HexSample({
    required this.cell,
    required this.bucket,
    this.count = 0,
    this.bestSnr = double.negativeInfinity,
    this.bestRssi = -999,
    Map<String, double>? repeaters,
  }) : repeaters = repeaters ?? {};

  String get key => '$cell@${bucket.toIso8601String()}';

  /// When this sample can no longer change.
  DateTime get closesAt => bucket.add(bucketLength);

  void add(double snr, int rssi, String? repeater) {
    count++;
    if (snr > bestSnr) bestSnr = snr;
    if (rssi > bestRssi) bestRssi = rssi;
    if (repeater != null) {
      final previous = repeaters[repeater];
      if (previous == null || snr > previous) repeaters[repeater] = snr;
    }
  }

  /// Whether a target with [privacy] may receive this sample at [now].
  bool dueFor(CoveragePrivacy privacy, DateTime now) =>
      !closesAt.add(privacy.delay).isAfter(now.toUtc());

  Map<String, dynamic> toJson() => {
    'cell': cell,
    'bucket': bucket.toIso8601String(),
    'count': count,
    'snr': bestSnr,
    'rssi': bestRssi,
    'repeaters': repeaters,
  };

  factory HexSample.fromJson(Map<String, dynamic> json) => HexSample(
    cell: json['cell'] as String,
    bucket: DateTime.parse(json['bucket'] as String),
    count: json['count'] as int,
    bestSnr: (json['snr'] as num).toDouble(),
    bestRssi: json['rssi'] as int,
    repeaters: (json['repeaters'] as Map<String, dynamic>).map(
      (k, v) => MapEntry(k, (v as num).toDouble()),
    ),
  );
}

/// All samples, keyed by cell and bucket.
class CoverageGrid {
  final Map<String, HexSample> samples = {};

  void record({
    required String cell,
    required DateTime time,
    required double snr,
    required int rssi,
    String? repeater,
  }) {
    final bucket = bucketStart(time);
    final sample = samples.putIfAbsent(
      '$cell@${bucket.toIso8601String()}',
      () => HexSample(cell: cell, bucket: bucket),
    );
    sample.add(snr, rssi, repeater);
  }

  /// Drops samples older than [keepSamplesFor].
  void prune(DateTime now) => samples.removeWhere(
    (_, s) => now.toUtc().difference(s.bucket) > keepSamplesFor,
  );

  /// Best SNR seen in each cell, for drawing the map.
  Map<String, double> bestByCell() {
    final best = <String, double>{};
    for (final s in samples.values) {
      final previous = best[s.cell];
      if (previous == null || s.bestSnr > previous) best[s.cell] = s.bestSnr;
    }
    return best;
  }

  List<Map<String, dynamic>> toJson() =>
      samples.values.map((s) => s.toJson()).toList();

  static CoverageGrid fromJson(List<dynamic> json) {
    final grid = CoverageGrid();
    for (final row in json) {
      final s = HexSample.fromJson(row as Map<String, dynamic>);
      grid.samples[s.key] = s;
    }
    return grid;
  }
}

/// A coverage map that takes uploads.
class CoverageTarget {
  final String id;
  final String name;
  final String url;
  final String apiKey;
  final CoverageFormat format;
  final CoveragePrivacy privacy;
  final bool enabled;

  const CoverageTarget({
    required this.id,
    required this.name,
    required this.url,
    this.apiKey = '',
    this.format = CoverageFormat.hexagons,
    this.privacy = CoveragePrivacy.delayed,
    this.enabled = true,
  });

  /// Only HTTPS endpoints are accepted, as MeshMapper also requires.
  static bool isValidUrl(String url) {
    final uri = Uri.tryParse(url.trim());
    return uri != null && uri.scheme == 'https' && uri.host.isNotEmpty;
  }

  CoverageTarget copyWith({
    String? name,
    String? url,
    String? apiKey,
    CoverageFormat? format,
    CoveragePrivacy? privacy,
    bool? enabled,
  }) => CoverageTarget(
    id: id,
    name: name ?? this.name,
    url: url ?? this.url,
    apiKey: apiKey ?? this.apiKey,
    format: format ?? this.format,
    privacy: privacy ?? this.privacy,
    enabled: enabled ?? this.enabled,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'url': url,
    'apiKey': apiKey,
    'format': format.name,
    'privacy': privacy.name,
    'enabled': enabled,
  };

  factory CoverageTarget.fromJson(Map<String, dynamic> json) => CoverageTarget(
    id: json['id'] as String,
    name: json['name'] as String,
    url: json['url'] as String,
    apiKey: json['apiKey'] as String? ?? '',
    format:
        CoverageFormat.values.asNameMap()[json['format']] ??
        CoverageFormat.hexagons,
    privacy:
        CoveragePrivacy.values.asNameMap()[json['privacy']] ??
        CoveragePrivacy.delayed,
    enabled: json['enabled'] as bool? ?? true,
  );
}

double _round2(double v) => (v * 100).roundToDouble() / 100;

/// The time a target is told about: the bucket start, or just the day for
/// anonymous targets.
DateTime _reportedTime(HexSample s, CoveragePrivacy privacy) =>
    privacy == CoveragePrivacy.anonymous
    ? DateTime.utc(s.bucket.year, s.bucket.month, s.bucket.day)
    : s.bucket;

/// Upload body in NOTORYX's hexagon format: cell IDs, never coordinates.
Map<String, dynamic> hexagonPayload(
  List<HexSample> samples,
  CoveragePrivacy privacy,
) => {
  'format': 'notoryx-coverage-hex/1',
  'resolution': coverageResolution,
  'cells': [
    for (final s in samples)
      {
        'cell': s.cell,
        'time': _reportedTime(s, privacy).toIso8601String(),
        'count': s.count,
        'best_snr': _round2(s.bestSnr),
        'best_rssi': s.bestRssi,
        'repeaters': [
          for (final e in s.repeaters.entries)
            {'id': e.key, 'snr': _round2(e.value)},
        ],
      },
  ],
};

/// Upload body in MeshMapper's custom-endpoint format: one RX ping per
/// repeater heard, placed at the cell's centre ([centerOf]).
Map<String, dynamic> meshMapperPayload(
  List<HexSample> samples,
  CoveragePrivacy privacy,
  ({double lat, double lon}) Function(String cell) centerOf,
) => {
  'data': [
    for (final s in samples)
      for (final e in s.repeaters.entries)
        {
          'type': 'RX',
          'lat': centerOf(s.cell).lat,
          'lon': centerOf(s.cell).lon,
          'timestamp': _reportedTime(s, privacy).millisecondsSinceEpoch ~/ 1000,
          'external_antenna': false,
          'noisefloor': null,
          'power': null,
          'heard_repeats':
              '${e.key.toUpperCase()}(${e.value.toStringAsFixed(2)})',
        },
  ],
};
