import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

/// What a region-scoped message shows when its code matches no region name
/// this app knows: it was scoped, to a region we can't name.
const unknownRegion = '?';

/// A region's 16-byte transport key, as MeshCore derives it for a public
/// hashtag region: the first half of SHA-256 of "#name".
Uint8List regionKey(String name) {
  final tag = name.startsWith('#') ? name : '#$name';
  return Uint8List.fromList(
    sha256.convert(utf8.encode(tag)).bytes.sublist(0, 16),
  );
}

/// The transport code a packet scoped to the region keyed by [key] carries:
/// the first two bytes of HMAC-SHA256 over the payload type and payload,
/// read little-endian, with 0000 and FFFF reserved (MeshCore's
/// `TransportKey::calcTransportCode`).
int regionTransportCode(Uint8List key, int payloadType, Uint8List payload) {
  final mac = Hmac(sha256, key).convert([payloadType & 0xFF, ...payload]).bytes;
  var code = mac[0] | (mac[1] << 8);
  if (code == 0) {
    code = 1;
  } else if (code == 0xFFFF) {
    code = 0xFFFE;
  }
  return code;
}

/// The region a scoped packet was sent to, from [names] the app knows, or
/// [unknownRegion] when none matches. Null when [code] is 0: not scoped.
String? matchRegion(
  int code,
  int payloadType,
  Uint8List payload,
  Iterable<String> names,
) {
  if (code == 0) return null;
  for (final name in names) {
    if (regionTransportCode(regionKey(name), payloadType, payload) == code) {
      return name.startsWith('#') ? name.substring(1) : name;
    }
  }
  return unknownRegion;
}
