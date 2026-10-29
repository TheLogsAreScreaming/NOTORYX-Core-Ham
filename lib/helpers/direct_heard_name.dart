import 'dart:typed_data';

import 'package:latlong2/latlong.dart';

import '../connector/meshcore_connector.dart';
import '../services/corescope.dart';
import 'path_hop_resolver.dart';

/// The name of a node heard directly, from its ID (a hop prefix or a full
/// public key in hex), or null when it can't be pinned to one known node.
String? directHeardName(MeshCoreConnector connector, String id) {
  final bytes = Uint8List.fromList([
    for (var i = 0; i + 1 < id.length; i += 2)
      int.parse(id.substring(i, i + 2), radix: 16),
  ]);
  if (bytes.length >= 32) {
    final key = id.toLowerCase();
    for (final c in connector.allContactsUnfiltered) {
      if (c.publicKeyHex.toLowerCase() == key) return c.name;
    }
    return null;
  }
  final lat = connector.selfLatitude, lon = connector.selfLongitude;
  final hop = PathHopResolver.resolve(
    pathBytes: bytes,
    contacts: connector.allContactsUnfiltered,
    endpoint: lat == null || lon == null || (lat == 0 && lon == 0)
        ? null
        : LatLng(lat, lon),
    pathHashByteWidth: bytes.length,
  );
  return hop.single?.name;
}

/// The short ID shown for a directly heard node: its first two bytes.
String directHeardShortId(String id) =>
    id.length > 6 ? id.substring(0, 4).toUpperCase() : id.toUpperCase();

/// A heard node's name from this radio's contacts, else from the online
/// analyzer when hop lookup is on ("?" when several repeaters share the
/// ID), else null.
String? heardNameWithOnline(
  MeshCoreConnector connector,
  AnalyzerService? analyzer,
  String id,
) {
  final local = directHeardName(connector, id);
  if (local != null) return local;
  final online = analyzer?.hopName(directHeardShortId(id));
  if (online == null) return null;
  return online.ambiguous ? '${online.name}?' : online.name;
}
