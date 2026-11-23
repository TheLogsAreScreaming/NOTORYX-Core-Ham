import 'dart:convert';
import 'dart:typed_data';

import '../models/advert_signature.dart';
import '../models/contact.dart';
import 'discovery_file.dart';
import 'prefs_manager.dart';

/// The nodes heard on the mesh that are not contacts on the radio.
///
/// Kept in its own file (thousands of nodes are a few megabytes) rather than in
/// preferences, which are read whole at every start. A list saved in
/// preferences by an older version moves to the file on first load. The web
/// build, and tests without a file system, keep using preferences.
class ContactDiscoveryStore {
  ContactDiscoveryStore({Future<String?> Function()? directory})
    : _directory = directory ?? discoveryDirectory;

  static const String _keyPrefix = 'discovered_contacts';

  final Future<String?> Function() _directory;

  Future<List<Contact>> loadContacts() async {
    final prefs = PrefsManager.instance;
    final dir = await _directory();
    String? jsonStr;
    if (dir != null) {
      try {
        jsonStr = await readDiscoveryFile(dir);
      } on Object {
        jsonStr = null;
      }
    }
    if (jsonStr == null) {
      jsonStr = prefs.getString(_keyPrefix);
      if (jsonStr != null && dir != null) {
        // Move the old preferences copy to the file, then drop it.
        try {
          await writeDiscoveryFile(dir, jsonStr);
          await prefs.remove(_keyPrefix);
        } on Object {
          // Keep the preferences copy; the next save tries the file again.
        }
      }
    }
    if (jsonStr == null) return [];

    try {
      final jsonList = jsonDecode(jsonStr) as List<dynamic>;
      return jsonList
          .map((entry) => _fromJson(entry as Map<String, dynamic>))
          // Saved before adverts were verified: drop the corrupt ones.
          .where((c) => !looksCorrupt(c.type, c.name))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> saveContacts(List<Contact> contacts) async {
    final json = jsonEncode(contacts.map(_toJson).toList());
    final dir = await _directory();
    if (dir != null) {
      try {
        await writeDiscoveryFile(dir, json);
        return;
      } on Object {
        // Fall through to preferences rather than lose the list.
      }
    }
    await PrefsManager.instance.setString(_keyPrefix, json);
  }

  Map<String, dynamic> _toJson(Contact contact) {
    return {
      'publicKey': base64Encode(contact.publicKey),
      'name': contact.name,
      'type': contact.type,
      'flags': contact.flags,
      'pathLength': contact.pathLength,
      'path': base64Encode(contact.path),
      'pathOverride': contact.pathOverride,
      'pathOverrideBytes': contact.pathOverrideBytes != null
          ? base64Encode(contact.pathOverrideBytes!)
          : null,
      'latitude': contact.latitude,
      'longitude': contact.longitude,
      'lastSeen': contact.lastSeen.millisecondsSinceEpoch,
      'lastModified': contact.lastModified?.millisecondsSinceEpoch,
      'lastMessageAt': contact.lastMessageAt.millisecondsSinceEpoch,
      'rawPacket': contact.rawPacket != null
          ? base64Encode(contact.rawPacket!)
          : null,
    };
  }

  Contact _fromJson(Map<String, dynamic> json) {
    final lastSeenMs = json['lastSeen'] as int? ?? 0;
    final lastMessageMs = json['lastMessageAt'] as int?;
    final lastModifiedMs = json['lastModified'] as int?;

    final rawPathLength = json['pathLength'] as int? ?? -1;
    final rawPath = json['path'] != null
        ? Uint8List.fromList(base64Decode(json['path'] as String))
        : Uint8List(0);

    int decodedPathLength = rawPathLength;
    Uint8List decodedPath = rawPath;

    if (rawPathLength == 0xFF || rawPathLength < 0) {
      decodedPathLength = -1;
      decodedPath = Uint8List(0);
    } else if (rawPathLength >= 64) {
      final mode = (rawPathLength & 0xC0) >> 6;
      final hopCount = rawPathLength & 0x3F;
      final width = mode + 1;
      final byteLen = hopCount * width;
      decodedPathLength = hopCount;
      if (byteLen <= rawPath.length) {
        decodedPath = rawPath.sublist(0, byteLen);
      } else {
        decodedPath = Uint8List(0);
      }
    } else if (rawPathLength == 0) {
      decodedPath = Uint8List(0);
    }

    return Contact(
      publicKey: Uint8List.fromList(base64Decode(json['publicKey'] as String)),
      name: json['name'] as String? ?? 'Unknown',
      type: json['type'] as int? ?? 0,
      flags: json['flags'] as int? ?? 0,
      pathLength: decodedPathLength,
      path: decodedPath,
      pathOverride: json['pathOverride'] as int?,
      pathOverrideBytes: json['pathOverrideBytes'] != null
          ? Uint8List.fromList(
              base64Decode(json['pathOverrideBytes'] as String),
            )
          : null,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      lastSeen: DateTime.fromMillisecondsSinceEpoch(lastSeenMs),
      lastModified: lastModifiedMs == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(lastModifiedMs),
      lastMessageAt: DateTime.fromMillisecondsSinceEpoch(
        lastMessageMs ?? lastSeenMs,
      ),
      isActive: false,
      rawPacket: json['rawPacket'] != null
          ? Uint8List.fromList(base64Decode(json['rawPacket'] as String))
          : null,
    );
  }
}
