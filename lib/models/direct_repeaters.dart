import 'dart:typed_data';

/// MeshCore payload type of an advert.
const _payloadTypeAdvert = 4;

/// Which node a received packet came from directly, as path-ID bytes:
/// the last hop of a flooded packet, or the sender of a zero-hop advert.
/// Null when the packet doesn't say (source-routed, malformed, or a
/// zero-hop message whose sender isn't in the clear).
Uint8List? heardDirectlyFrom(Uint8List raw) {
  if (raw.length < 2) return null;
  final header = raw[0];
  final routeType = header & 0x03;
  // Only floods carry the path walked so far; direct routes carry the path
  // still to go.
  if (routeType != 0 && routeType != 1) return null;
  var offset = 1;
  if (routeType == 0) offset += 4; // transport codes
  if (offset >= raw.length) return null;
  final pathLen = raw[offset++];
  if (pathLen == 0xFF) return null;
  final hops = pathLen & 63;
  final width = ((pathLen >> 6) & 0x03) + 1;
  final pathEnd = offset + hops * width;
  if (pathEnd > raw.length) return null;
  if (hops > 0) {
    return Uint8List.fromList(raw.sublist(pathEnd - width, pathEnd));
  }
  final payloadType = (header >> 2) & 0x0F;
  if (payloadType == _payloadTypeAdvert && raw.length >= pathEnd + 32) {
    // A zero-hop advert starts with the sender's public key.
    return Uint8List.fromList(raw.sublist(pathEnd, pathEnd + 32));
  }
  return null;
}

/// How well this radio hears one neighbouring node.
class DirectHeard {
  DirectHeard({required this.id, required double snr, required this.lastHeard})
    : snrAverage = snr,
      lastSnr = snr,
      count = 1;

  /// Path-ID bytes as uppercase hex (1-3 bytes), or a full public key when
  /// it came from a zero-hop advert.
  final String id;
  double snrAverage;
  double lastSnr;
  int count;
  DateTime lastHeard;

  /// Weight of a new reading in the running SNR average.
  static const smoothing = 0.3;

  void add(double snr, DateTime at) {
    snrAverage = snrAverage + smoothing * (snr - snrAverage);
    lastSnr = snr;
    count++;
    if (at.isAfter(lastHeard)) lastHeard = at;
  }

  /// Higher is better: the average SNR, less 1 dB for every 10 minutes
  /// since it was last heard, so a strong repeater that went quiet drops.
  double score(DateTime now) =>
      snrAverage - now.difference(lastHeard).inSeconds / 600;
}

/// The best neighbours heard within [window], best first.
List<DirectHeard> rankDirect(
  Iterable<DirectHeard> heard,
  DateTime now, {
  Duration window = const Duration(hours: 1),
  int limit = 5,
}) {
  final recent = [
    for (final h in heard)
      if (now.difference(h.lastHeard) <= window) h,
  ];
  recent.sort((a, b) => b.score(now).compareTo(a.score(now)));
  return recent.take(limit).toList();
}
