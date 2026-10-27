import 'dart:typed_data';

import '../connector/meshcore_protocol.dart';
import '../models/contact.dart';

/// A contact shared as MeshCore's documented link,
/// `meshcore://contact/add?name=…&public_key=<64 hex>&type=<1-4>`
/// (MeshCore docs/qr_codes.md), so other MeshCore apps understand it too.
class ContactLink {
  final String name;
  final Uint8List publicKey;
  final int type;
  const ContactLink(this.name, this.publicKey, this.type);

  String get publicKeyHex => pubKeyToHex(publicKey);

  String get typeLabel => switch (type) {
    advTypeRepeater => 'Repeater',
    advTypeRoom => 'Room server',
    advTypeSensor => 'Sensor',
    _ => 'Companion',
  };
}

String contactLinkFor(Contact contact) => Uri(
  scheme: 'meshcore',
  host: 'contact',
  path: '/add',
  queryParameters: {
    'name': contact.name,
    'public_key': contact.publicKeyHex.toLowerCase(),
    'type': '${contact.type}',
  },
).toString();

/// Reads a message that is (or contains) a contact link; null otherwise.
ContactLink? parseContactLink(String text) {
  final match = RegExp(r'meshcore://contact/add\?\S+').firstMatch(text);
  if (match == null) return null;
  try {
    final uri = Uri.parse(match.group(0)!);
    if (uri.scheme != 'meshcore' ||
        uri.host != 'contact' ||
        uri.path != '/add' ||
        uri.hasFragment) {
      return null;
    }
    final params = uri.queryParametersAll;
    // Ambiguous identity fields must not silently select one of two values.
    for (final field in ['name', 'public_key', 'type']) {
      if (params[field] != null && params[field]!.length != 1) return null;
    }
    final key = uri.queryParameters['public_key'] ?? '';
    if (!RegExp(r'^[0-9a-fA-F]{64}$').hasMatch(key)) return null;
    final rawType = uri.queryParameters['type'];
    // Keep the existing companion default only when type is absent.
    if (rawType != null && !RegExp(r'^[1-4]$').hasMatch(rawType)) {
      return null;
    }
    final type = rawType == null ? advTypeChat : int.parse(rawType);
    final name = (uri.queryParameters['name'] ?? '').trim();
    return ContactLink(
      name.isEmpty ? 'Unnamed contact' : name,
      hex2Uint8List(key),
      type,
    );
  } on FormatException {
    // Query decoding can fail too (bad percent escapes or invalid UTF-8).
    return null;
  }
}

/// The app's map-marker message (`m:<lat>,<lon>|<label>|`), which chats
/// show as a location card and the map as a shared marker.
String positionMarker(double lat, double lon, String label) =>
    'm:${lat.toStringAsFixed(6)},${lon.toStringAsFixed(6)}|${label.replaceAll('|', '/')}|';
