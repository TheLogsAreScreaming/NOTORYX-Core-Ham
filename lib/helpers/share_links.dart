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
  final Uri uri;
  try {
    uri = Uri.parse(match.group(0)!);
  } on FormatException {
    return null;
  }
  final key = uri.queryParameters['public_key'] ?? '';
  if (!RegExp(r'^[0-9a-fA-F]{64}$').hasMatch(key)) return null;
  final type = int.tryParse(uri.queryParameters['type'] ?? '1') ?? 1;
  if (type < advTypeChat || type > advTypeSensor) return null;
  final name = (uri.queryParameters['name'] ?? '').trim();
  return ContactLink(
    name.isEmpty ? 'Unnamed contact' : name,
    hex2Uint8List(key),
    type,
  );
}

/// The app's map-marker message (`m:<lat>,<lon>|<label>|`), which chats
/// show as a location card and the map as a shared marker.
String positionMarker(double lat, double lon, String label) =>
    'm:${lat.toStringAsFixed(6)},${lon.toStringAsFixed(6)}|${label.replaceAll('|', '/')}|';
