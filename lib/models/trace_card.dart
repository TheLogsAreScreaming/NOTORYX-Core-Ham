import 'dart:math' as math;

/// One hop of a finished path trace, as the trace card shows it.
class TraceCardHop {
  const TraceCardHop({
    required this.id,
    this.name,
    this.snr,
    this.lat,
    this.lon,
    this.positionGuessed = false,
  });

  /// The hop's short ID in hex, as it appears in the path.
  final String id;

  /// The node's name when it is a known contact.
  final String? name;

  /// SNR (dB) this hop heard the previous sender at.
  final double? snr;
  final double? lat;
  final double? lon;

  /// Whether the position was estimated from neighbouring nodes.
  final bool positionGuessed;

  bool get hasPosition => lat != null && lon != null;
  String get label => (name == null || name!.trim().isEmpty) ? id : name!;
}

/// Everything a shareable trace card shows: who sent the trace, when, how
/// long the round trip took, each hop with its SNR, and the SNR the reply
/// came back at.
class TraceCard {
  const TraceCard({
    required this.sender,
    required this.sentAt,
    required this.roundTrip,
    required this.hops,
    this.target,
    this.returnSnr,
    this.senderLat,
    this.senderLon,
  });

  final String sender;
  final String? target;
  final DateTime sentAt;
  final Duration roundTrip;
  final List<TraceCardHop> hops;

  /// SNR (dB) this radio heard the last hop at.
  final double? returnSnr;
  final double? senderLat;
  final double? senderLon;

  bool get senderHasPosition => senderLat != null && senderLon != null;

  /// The round trip in map order: the sender, every hop with a position,
  /// and back to the sender. Empty without at least two places.
  List<({double lat, double lon})> get routePoints {
    final points = <({double lat, double lon})>[
      if (senderHasPosition) (lat: senderLat!, lon: senderLon!),
      for (final h in hops)
        if (h.hasPosition) (lat: h.lat!, lon: h.lon!),
      if (senderHasPosition) (lat: senderLat!, lon: senderLon!),
    ];
    final distinct = {for (final p in points) '${p.lat},${p.lon}'};
    return distinct.length < 2 ? const [] : points;
  }

  /// Great-circle length of [routePoints] in metres.
  double get routeMeters {
    final p = routePoints;
    var total = 0.0;
    for (var i = 1; i < p.length; i++) {
      total += haversineMeters(p[i - 1].lat, p[i - 1].lon, p[i].lat, p[i].lon);
    }
    return total;
  }

  /// Weakest SNR along the trace, the link most likely to fail.
  double? get weakestSnr {
    final all = [
      for (final h in hops)
        if (h.snr != null) h.snr!,
      ?returnSnr,
    ];
    return all.isEmpty ? null : all.reduce(math.min);
  }
}

double haversineMeters(double lat1, double lon1, double lat2, double lon2) {
  const r = 6371000.0;
  double rad(double d) => d * math.pi / 180;
  final dLat = rad(lat2 - lat1);
  final dLon = rad(lon2 - lon1);
  final a =
      math.pow(math.sin(dLat / 2), 2) +
      math.cos(rad(lat1)) *
          math.cos(rad(lat2)) *
          math.pow(math.sin(dLon / 2), 2);
  return 2 * r * math.asin(math.sqrt(a.toDouble()));
}

/// Places [points] in a [width] x [height] box with [padding], keeping the
/// map's proportions (longitude shrinks with latitude). Pure, so the card
/// draws the same route on every phone.
List<({double x, double y})> projectRoute(
  List<({double lat, double lon})> points, {
  required double width,
  required double height,
  double padding = 16,
}) {
  if (points.isEmpty) return const [];
  final midLat =
      points.map((p) => p.lat).reduce((a, b) => a + b) / points.length;
  final k = math.cos(midLat * math.pi / 180).abs().clamp(0.01, 1.0);
  final xs = [for (final p in points) p.lon * k];
  final ys = [for (final p in points) p.lat];
  final minX = xs.reduce(math.min), maxX = xs.reduce(math.max);
  final minY = ys.reduce(math.min), maxY = ys.reduce(math.max);
  final spanX = math.max(maxX - minX, 1e-9);
  final spanY = math.max(maxY - minY, 1e-9);
  final innerW = width - 2 * padding, innerH = height - 2 * padding;
  final scale = math.min(innerW / spanX, innerH / spanY);
  final offX = padding + (innerW - spanX * scale) / 2;
  final offY = padding + (innerH - spanY * scale) / 2;
  return [
    for (var i = 0; i < points.length; i++)
      (x: offX + (xs[i] - minX) * scale, y: offY + (maxY - ys[i]) * scale),
  ];
}
