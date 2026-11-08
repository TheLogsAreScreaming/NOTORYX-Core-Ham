import 'dart:typed_data';

import '../models/network_scan.dart' show parseAdvertNode;
import 'amateur_radio.dart';

/// A direct advert whose station ID doesn't match the call sign at the start
/// of the name it advertises: the station transmitting isn't identifying as
/// the node it claims to be, or the node's name has no call sign.
class StationIdMismatch {
  const StationIdMismatch({
    required this.nodeKey,
    required this.advertName,
    required this.station,
    required this.at,
  });

  /// The first bytes of the node's public key, as hex.
  final String nodeKey;

  /// The name in the advert.
  final String advertName;

  /// The call sign in the frame's station ID.
  final String station;

  /// When the frame was heard.
  final DateTime at;

  /// The call sign [advertName] starts with, or null when it has none.
  String? get namedCall => callsignOf(advertName);

  @override
  bool operator ==(Object other) =>
      other is StationIdMismatch &&
      other.nodeKey == nodeKey &&
      other.advertName == advertName &&
      other.station == station &&
      other.at == at;

  @override
  int get hashCode => Object.hash(nodeKey, advertName, station, at);
}

/// Checks the station ID of a frame heard straight from its sender.
///
/// [raw] is the V1 packet inside an amateur frame and [station] the call
/// sign from its trailer. Only an advert heard with no hops is checked: a
/// relayed frame carries the repeater's call sign, so it says nothing about
/// the sender. Returns null when the frame isn't such an advert or when its
/// station ID matches the call sign the advertised name starts with.
StationIdMismatch? checkStationId(
  Uint8List raw,
  String station, {
  required DateTime at,
}) {
  if (station.isEmpty || _hops(raw) != 0) return null;
  final node = parseAdvertNode(raw);
  final name = node?.name;
  if (node == null || name == null || name.isEmpty) return null;
  // Compare base call signs, so an SSID ("W1AW-7") on either side matches.
  final sent = station.trim().toUpperCase();
  if (callsignOf(name) case final named?
      when named == (callsignOf(sent) ?? sent)) {
    return null;
  }
  return StationIdMismatch(
    nodeKey: node.key,
    advertName: name,
    station: sent,
    at: at,
  );
}

/// Hops in [raw]'s path, or null when the header is cut short.
int? _hops(Uint8List raw) {
  if (raw.isEmpty) return null;
  final route = raw[0] & 0x03;
  // Transport-coded routes carry 4 bytes of codes before the path length.
  final i = route == 0x00 || route == 0x03 ? 5 : 1;
  if (raw.length <= i) return null;
  return raw[i] & 0x3F;
}
