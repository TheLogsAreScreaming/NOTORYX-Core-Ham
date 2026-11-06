import 'dart:convert';
import 'dart:typed_data';

import '../connector/meshcore_protocol.dart';
import 'radio_settings.dart';

/// One set of LoRa settings to listen on: a MeshCore preset, a local mesh
/// or a network you saved. A radio only hears packets sent with exactly its
/// own frequency, bandwidth, spreading factor and coding rate, so each of
/// these is a separate network as far as the radio is concerned.
class ScanTarget {
  const ScanTarget({
    required this.name,
    required this.freqKHz,
    required this.bwHz,
    required this.sf,
    required this.cr,
  });

  final String name;

  /// Frequency in kHz and bandwidth in Hz, as CMD_SET_RADIO_PARAMS takes
  /// them.
  final int freqKHz;
  final int bwHz;
  final int sf;
  final int cr;

  factory ScanTarget.fromPreset(String name, RadioSettings s) => ScanTarget(
    name: name,
    freqKHz: s.frequencyHz,
    bwHz: s.bandwidthHz,
    sf: s.sf,
    cr: s.cr,
  );

  double get frequencyMHz => freqKHz / 1000;

  /// The settings alone, without the name: two targets with the same
  /// signature are the same network on air.
  String get signature => '$freqKHz|$bwHz|$sf|$cr';

  bool sameSettings(ScanTarget other) => signature == other.signature;

  /// "914.875 MHz · 250 kHz · SF10 · CR 4/5"
  String get summary {
    final bw = bwHz % 1000 == 0
        ? '${bwHz ~/ 1000}'
        : (bwHz / 1000).toStringAsFixed(bwHz % 100 == 0 ? 1 : 2);
    return '${frequencyMHz.toStringAsFixed(3)} MHz · $bw kHz · SF$sf · CR 4/$cr';
  }

  ScanTarget withName(String name) =>
      ScanTarget(name: name, freqKHz: freqKHz, bwHz: bwHz, sf: sf, cr: cr);

  Map<String, dynamic> toJson() => {
    'name': name,
    'freqKHz': freqKHz,
    'bwHz': bwHz,
    'sf': sf,
    'cr': cr,
  };

  static ScanTarget? fromJson(Object? j) {
    if (j is! Map) return null;
    final name = j['name'], f = j['freqKHz'], b = j['bwHz'];
    final sf = j['sf'], cr = j['cr'];
    if (name is! String || f is! int || b is! int || sf is! int || cr is! int) {
      return null;
    }
    final t = ScanTarget(name: name, freqKHz: f, bwHz: b, sf: sf, cr: cr);
    return t.isValid ? t : null;
  }

  /// Within what MeshCore radios accept.
  bool get isValid =>
      freqKHz >= 150000 &&
      freqKHz <= 2500000 &&
      bwHz >= 7000 &&
      bwHz <= 500000 &&
      sf >= 5 &&
      sf <= 12 &&
      cr >= 5 &&
      cr <= 8;
}

/// A node heard on a scanned network, from its advert.
class HeardNode {
  const HeardNode({required this.key, this.name, this.type});

  /// The first 4 bytes of its public key, as hex.
  final String key;
  final String? name;

  /// The MeshCore advert type (1 chat, 2 repeater, 3 room, 4 sensor).
  final int? type;

  Map<String, dynamic> toJson() => {
    'key': key,
    if (name != null) 'name': name,
    if (type != null) 'type': type,
  };

  static HeardNode? fromJson(Object? j) {
    if (j is! Map || j['key'] is! String) return null;
    return HeardNode(
      key: j['key'] as String,
      name: j['name'] is String ? j['name'] as String : null,
      type: j['type'] is int ? j['type'] as int : null,
    );
  }
}

/// One time a network was heard: where, when, and what was on it.
class NetworkSighting {
  const NetworkSighting({
    required this.target,
    required this.at,
    required this.packets,
    required this.bestSnr,
    required this.bestRssi,
    this.latitude,
    this.longitude,
    this.nodes = const [],
  });

  final ScanTarget target;
  final DateTime at;
  final double? latitude;
  final double? longitude;
  final int packets;
  final double bestSnr;
  final int bestRssi;
  final List<HeardNode> nodes;

  bool get hasLocation => latitude != null && longitude != null;

  Map<String, dynamic> toJson() => {
    'target': target.toJson(),
    'at': at.toUtc().toIso8601String(),
    if (latitude != null) 'lat': latitude,
    if (longitude != null) 'lon': longitude,
    'packets': packets,
    'snr': bestSnr,
    'rssi': bestRssi,
    'nodes': [for (final n in nodes) n.toJson()],
  };

  static NetworkSighting? fromJson(Object? j) {
    if (j is! Map) return null;
    final target = ScanTarget.fromJson(j['target']);
    final at = j['at'] is String ? DateTime.tryParse(j['at'] as String) : null;
    final packets = j['packets'], snr = j['snr'], rssi = j['rssi'];
    if (target == null ||
        at == null ||
        packets is! int ||
        snr is! num ||
        rssi is! int) {
      return null;
    }
    return NetworkSighting(
      target: target,
      at: at,
      latitude: (j['lat'] as num?)?.toDouble(),
      longitude: (j['lon'] as num?)?.toDouble(),
      packets: packets,
      bestSnr: snr.toDouble(),
      bestRssi: rssi,
      nodes: [
        for (final n in j['nodes'] as List? ?? const []) ?HeardNode.fromJson(n),
      ],
    );
  }
}

/// Builds sightings from the packets heard while listening on one target.
class SightingBuilder {
  SightingBuilder(this.target);

  final ScanTarget target;
  int packets = 0;
  double? bestSnr;
  int? bestRssi;
  final Map<String, HeardNode> _nodes = {};

  void add(Uint8List raw, double snr, int rssi) {
    _signal(snr, rssi);
    final node = parseAdvertNode(raw);
    if (node != null) _nodes[node.key] = node;
  }

  /// A node that answered a quick scan's discover ping. Its name comes
  /// later, if it also sends an advert.
  void addReply(DiscoverAnswer a) {
    _signal(a.snr, a.rssi);
    _nodes.putIfAbsent(a.key, () => HeardNode(key: a.key, type: a.type));
  }

  void _signal(double snr, int rssi) {
    packets++;
    if (bestSnr == null || snr > bestSnr!) bestSnr = snr;
    if (bestRssi == null || rssi > bestRssi!) bestRssi = rssi;
  }

  /// Null when nothing was heard.
  NetworkSighting? build(DateTime at, {double? latitude, double? longitude}) {
    if (packets == 0) return null;
    return NetworkSighting(
      target: target,
      at: at,
      latitude: latitude,
      longitude: longitude,
      packets: packets,
      bestSnr: bestSnr!,
      bestRssi: bestRssi!,
      nodes: _nodes.values.toList(),
    );
  }
}

const _payloadTypeAdvert = 0x04;

/// The node behind a raw advert packet, or null for any other packet.
/// Packet: `[header][transport codes x4 if transport route][path len]
/// [path][payload]`. Advert payload: `[public key x32][time x4]
/// [signature x64][flags][lat x4, lon x4 if 0x10][feature x2 if 0x20]
/// [feature x2 if 0x40][name if 0x80]`.
HeardNode? parseAdvertNode(Uint8List raw) {
  try {
    if (raw.isEmpty) return null;
    final header = raw[0];
    if ((header >> 2) & 0x0F != _payloadTypeAdvert) return null;
    var i = 1;
    final route = header & 0x03;
    if (route == 0x00 || route == 0x03) i += 4;
    final pathLen = raw[i++];
    i += (pathLen & 0x3F) * (((pathLen >> 6) & 0x03) + 1);
    final payload = Uint8List.sublistView(raw, i);
    if (payload.length < 101) return null;
    final key = payload
        .sublist(0, 4)
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join();
    final flags = payload[100];
    var j = 101;
    if (flags & 0x10 != 0) j += 8;
    if (flags & 0x20 != 0) j += 2;
    if (flags & 0x40 != 0) j += 2;
    String? name;
    if (flags & 0x80 != 0 && j < payload.length) {
      final bytes = payload.sublist(j).takeWhile((b) => b != 0).toList();
      name = utf8.decode(bytes, allowMalformed: true).trim();
      if (name.isEmpty) name = null;
    }
    final type = flags & 0x0F;
    return HeardNode(key: key, name: name, type: type == 0 ? null : type);
  } on RangeError {
    return null;
  }
}

/// The log as CSV, one row per sighting, newest first.
String networkLogCsv(List<NetworkSighting> log) {
  String q(String s) {
    // Quote every text cell, and stop spreadsheet formulas.
    final safe = RegExp(r'^[=+\-@]').hasMatch(s) ? "'$s" : s;
    return '"${safe.replaceAll('"', '""')}"';
  }

  final b = StringBuffer(
    'time_utc,network,frequency_mhz,bandwidth_khz,sf,cr,latitude,'
    'longitude,packets,best_snr_db,best_rssi_dbm,nodes\n',
  );
  for (final s in log) {
    final t = s.target;
    b.writeln(
      [
        s.at.toUtc().toIso8601String(),
        q(t.name),
        t.frequencyMHz.toStringAsFixed(3),
        (t.bwHz / 1000).toString(),
        t.sf,
        t.cr,
        s.latitude?.toStringAsFixed(6) ?? '',
        s.longitude?.toStringAsFixed(6) ?? '',
        s.packets,
        s.bestSnr.toStringAsFixed(1),
        s.bestRssi,
        q(s.nodes.map((n) => n.name ?? n.key).join('; ')),
      ].join(','),
    );
  }
  return b.toString();
}

/// The log's located sightings as GPX waypoints.
String networkLogGpx(List<NetworkSighting> log) {
  String x(String s) => s
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;');
  final b = StringBuffer(
    '<?xml version="1.0" encoding="UTF-8"?>\n'
    '<gpx version="1.1" creator="NOTORYX Core" '
    'xmlns="http://www.topografix.com/GPX/1/1">\n',
  );
  for (final s in log.where((s) => s.hasLocation)) {
    b
      ..writeln(
        '  <wpt lat="${s.latitude!.toStringAsFixed(6)}" '
        'lon="${s.longitude!.toStringAsFixed(6)}">',
      )
      ..writeln('    <time>${s.at.toUtc().toIso8601String()}</time>')
      ..writeln('    <name>${x(s.target.name)}</name>')
      ..writeln(
        '    <desc>${x('${s.target.summary} · ${s.packets} packets · '
        'SNR ${s.bestSnr.toStringAsFixed(1)} dB')}</desc>',
      )
      ..writeln('  </wpt>');
  }
  b.writeln('</gpx>');
  return b.toString();
}

/// An answer to a discover ping: who answered and how well we heard it.
class DiscoverAnswer {
  const DiscoverAnswer({
    required this.key,
    required this.type,
    required this.snr,
    required this.rssi,
  });

  /// The first 4 bytes of its public key, as hex, like [HeardNode.key].
  final String key;
  final int type;
  final double snr;
  final int rssi;
}

/// A node's answer to the discover request tagged [tag], from a
/// PUSH_CODE_CONTROL_DATA frame:
/// `[code][snr×4][rssi][path len][type][snr there×4][tag u32][key prefix]`.
/// Any node type counts. Null for anything else.
DiscoverAnswer? parseDiscoverAnswer(Uint8List frame, int tag) {
  if (frame.length < 14 || frame[0] != pushCodeControlData) return null;
  final type = frame[4];
  if ((type >> 4) & 0x0F != controlSubtypeDiscoverResp) return null;
  final data = ByteData.sublistView(frame);
  if (data.getUint32(6, Endian.little) != tag) return null;
  final key = frame
      .sublist(10, 14)
      .map((b) => b.toRadixString(16).padLeft(2, '0'))
      .join();
  final nodeType = type & 0x0F;
  return DiscoverAnswer(
    key: key,
    type: nodeType,
    snr: data.getInt8(1) / 4,
    rssi: data.getInt8(2),
  );
}
