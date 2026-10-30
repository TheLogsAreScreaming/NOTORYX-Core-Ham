import 'dart:typed_data';

import '../connector/meshcore_protocol.dart';

/// One repeater that answered a wardrive ping: how well it heard us, and
/// how well we heard its answer.
class WardriveReply {
  const WardriveReply({
    required this.prefix,
    required this.snrThere,
    required this.snrHere,
    required this.rssiHere,
  });

  /// The repeater's public key prefix, as hex.
  final String prefix;

  /// SNR (dB) the repeater heard our ping at.
  final double snrThere;

  /// SNR (dB) and RSSI (dBm) we heard its answer at.
  final double snrHere;
  final int rssiHere;

  Map<String, dynamic> toJson() => {
    'prefix': prefix,
    'snrThere': snrThere,
    'snrHere': snrHere,
    'rssiHere': rssiHere,
  };

  factory WardriveReply.fromJson(Map<String, dynamic> j) => WardriveReply(
    prefix: j['prefix'] as String? ?? '',
    snrThere: (j['snrThere'] as num?)?.toDouble() ?? 0,
    snrHere: (j['snrHere'] as num?)?.toDouble() ?? 0,
    rssiHere: (j['rssiHere'] as num?)?.toInt() ?? 0,
  );
}

/// A ping sent from one spot, and the repeaters that answered.
class WardrivePing {
  const WardrivePing({
    required this.at,
    required this.latitude,
    required this.longitude,
    this.replies = const [],
  });

  final DateTime at;
  final double latitude;
  final double longitude;
  final List<WardriveReply> replies;

  bool get heard => replies.isNotEmpty;

  /// The weaker of the two directions for the best repeater: a link is only
  /// as good as its worse side. Null when nobody answered.
  double? get bestSnr {
    double? best;
    for (final r in replies) {
      final link = r.snrThere < r.snrHere ? r.snrThere : r.snrHere;
      if (best == null || link > best) best = link;
    }
    return best;
  }

  Map<String, dynamic> toJson() => {
    'at': at.toIso8601String(),
    'lat': latitude,
    'lon': longitude,
    'replies': [for (final r in replies) r.toJson()],
  };

  factory WardrivePing.fromJson(Map<String, dynamic> j) => WardrivePing(
    at: DateTime.parse(j['at'] as String),
    latitude: (j['lat'] as num).toDouble(),
    longitude: (j['lon'] as num).toDouble(),
    replies: [
      for (final r in j['replies'] as List? ?? const [])
        WardriveReply.fromJson(Map<String, dynamic>.from(r as Map)),
    ],
  );
}

/// One drive: its pings, in order.
class WardriveSession {
  const WardriveSession({
    required this.id,
    required this.startedAt,
    this.endedAt,
    this.pings = const [],
  });

  final String id;
  final DateTime startedAt;
  final DateTime? endedAt;
  final List<WardrivePing> pings;

  int get heardCount => pings.where((p) => p.heard).length;

  WardriveSession copyWith({DateTime? endedAt, List<WardrivePing>? pings}) =>
      WardriveSession(
        id: id,
        startedAt: startedAt,
        endedAt: endedAt ?? this.endedAt,
        pings: pings ?? this.pings,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'startedAt': startedAt.toIso8601String(),
    if (endedAt != null) 'endedAt': endedAt!.toIso8601String(),
    'pings': [for (final p in pings) p.toJson()],
  };

  factory WardriveSession.fromJson(Map<String, dynamic> j) => WardriveSession(
    id: j['id'] as String,
    startedAt: DateTime.parse(j['startedAt'] as String),
    endedAt: j['endedAt'] == null
        ? null
        : DateTime.parse(j['endedAt'] as String),
    pings: [
      for (final p in j['pings'] as List? ?? const [])
        WardrivePing.fromJson(Map<String, dynamic>.from(p as Map)),
    ],
  );
}

/// A repeater's answer to the discover request tagged [tag], from a
/// PUSH_CODE_CONTROL_DATA frame:
/// `[code][snr×4][rssi][path len][type][snr there×4][tag u32][key prefix]`.
/// Null for anything else.
WardriveReply? parseDiscoverReply(Uint8List frame, int tag) {
  if (frame.length < 13 || frame[0] != pushCodeControlData) return null;
  final type = frame[4];
  if (((type >> 4) & 0x0F) != controlSubtypeDiscoverResp ||
      (type & 0x0F) != advTypeRepeater) {
    return null;
  }
  final data = ByteData.sublistView(frame);
  if (data.getUint32(6, Endian.little) != tag) return null;
  final prefix = frame.sublist(10);
  if (prefix.isEmpty) return null;
  return WardriveReply(
    prefix: prefix.map((b) => b.toRadixString(16).padLeft(2, '0')).join(),
    snrThere: data.getInt8(5) / 4,
    snrHere: data.getInt8(1) / 4,
    rssiHere: data.getInt8(2),
  );
}
