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
  final candidate = match.group(0)!;
  if (RegExp(r'%(?![0-9a-fA-F]{2})').hasMatch(candidate)) return null;
  try {
    final uri = Uri.parse(candidate);
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

/// A contact read from pasted text: a contact link to preview, or a full
/// advert (`meshcore://<hex>`) for the radio to import.
sealed class PastedContact {
  const PastedContact();
}

class PastedLink extends PastedContact {
  final ContactLink link;
  const PastedLink(this.link);
}

class PastedAdvert extends PastedContact {
  final Uint8List advert;
  const PastedAdvert(this.advert);
}

/// The smallest advert packet: header, path length, key, time, signature.
const _minAdvertBytes = 98;

/// Reads a contact from pasted text. It's more forgiving than a chat card,
/// because pasted text has often been through a messenger or a note: the
/// link may sit inside other words, an advert's hex may be wrapped across
/// lines, a name may hold unencoded spaces, or it may be a bare public key.
PastedContact? parsePastedContact(String text) {
  final strict = parseContactLink(text);
  // A link that ends in its name, followed by more words on the line, is
  // most likely a name with raw spaces, which the strict reader cuts short.
  final link = RegExp(r'meshcore://contact/add\?\S+').firstMatch(text);
  final nameRunsOn =
      link != null &&
      RegExp(r'[?&]name=[^&]*$').hasMatch(link.group(0)!) &&
      text.startsWith(' ', link.end);
  if (strict != null && !nameRunsOn) return PastedLink(strict);

  // A full advert, its hex possibly broken by spaces or line wraps.
  final advert = RegExp(
    r'meshcore://\s*([0-9a-f][0-9a-f\s]*)',
    caseSensitive: false,
  ).firstMatch(text);
  final bareHex = text.replaceAll(RegExp(r'\s'), '');
  final hex = advert != null
      ? advert.group(1)!.replaceAll(RegExp(r'\s'), '')
      : RegExp(r'^[0-9a-fA-F]+$').hasMatch(bareHex)
      ? bareHex
      : '';
  if (hex.length.isEven && hex.length >= _minAdvertBytes * 2) {
    return PastedAdvert(hex2Uint8List(hex));
  }

  final loose = _looseContactLink(text);
  if (loose != null) return PastedLink(loose);
  if (strict != null) return PastedLink(strict);

  // Just a public key.
  if (RegExp(r'^[0-9a-fA-F]{64}$').hasMatch(bareHex)) {
    return PastedLink(
      ContactLink('Unnamed contact', hex2Uint8List(bareHex), advTypeChat),
    );
  }
  return null;
}

/// A contact link the strict reader turned down, such as one whose name has
/// raw spaces. Only the key has to be exact.
ContactLink? _looseContactLink(String text) {
  final start = text.toLowerCase().indexOf('meshcore://contact/add?');
  if (start < 0) return null;
  final query = text.substring(start + 'meshcore://contact/add?'.length);
  // Like the strict reader, a field given twice is ambiguous: refuse it.
  for (final field in ['name', 'public_key', 'type']) {
    if (RegExp('(?:^|&)$field=').allMatches(query).length > 1) return null;
  }
  final key = RegExp(
    r'public_key=([0-9a-fA-F]{64})(?![0-9a-fA-F])',
  ).firstMatch(query);
  if (key == null) return null;
  final type = RegExp(r'type=([1-4])(?![0-9])').firstMatch(query);
  final rawName =
      RegExp(
        r'name=([^\r\n]*?)(?=&(?:public_key|type)=|[\r\n]|$)',
      ).firstMatch(query)?.group(1) ??
      '';
  var name = rawName.replaceAll('+', ' ');
  try {
    name = Uri.decodeComponent(name);
  } on ArgumentError {
    // Keep it as typed.
  } on FormatException {
    // Keep it as typed.
  }
  name = name.trim();
  return ContactLink(
    name.isEmpty ? 'Unnamed contact' : name,
    hex2Uint8List(key.group(1)!),
    type == null ? advTypeChat : int.parse(type.group(1)!),
  );
}

/// The app's map-marker message (`m:<lat>,<lon>|<label>|`), which chats
/// show as a location card and the map as a shared marker.
String positionMarker(double lat, double lon, String label) =>
    'm:${lat.toStringAsFixed(6)},${lon.toStringAsFixed(6)}|${label.replaceAll('|', '/')}|';
