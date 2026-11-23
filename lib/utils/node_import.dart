import 'dart:convert';
import 'dart:typed_data';

import '../connector/meshcore_protocol.dart';
import '../helpers/share_links.dart';

/// One node read from an import file. Only the public key is certain; the
/// rest is whatever the file had.
class ImportedNode {
  ImportedNode({
    required this.publicKey,
    this.name,
    this.type,
    this.latitude,
    this.longitude,
    this.lastSeen,
  });

  final Uint8List publicKey;
  String? name;
  int? type;
  double? latitude;
  double? longitude;
  DateTime? lastSeen;

  String get publicKeyHex => pubKeyToHex(publicKey);

  /// Fills what this entry lacks from [other], the same node seen again.
  void mergeFrom(ImportedNode other) {
    name ??= other.name;
    type ??= other.type;
    if (latitude == null || longitude == null) {
      latitude = other.latitude;
      longitude = other.longitude;
    }
    final seen = other.lastSeen;
    if (seen != null && (lastSeen == null || seen.isAfter(lastSeen!))) {
      lastSeen = seen;
    }
  }
}

/// Reads nodes from text another app (or this one) exported. Understands:
///
/// * a JSON list of nodes, or an object holding one under `nodes`,
///   `contacts`, `discovered` or `data`;
/// * CSV with a header row that has a public key column;
/// * lines of contact links (`meshcore://contact/add?…`), full adverts
///   (`meshcore://<hex>`) or bare 64-character public keys.
///
/// Field names are matched loosely (`public_key`, `publicKey`, `pubkey`,
/// `key`; `lat`/`latitude`; `lon`/`lng`/`longitude`; `last_seen`,
/// `lastSeen`, `last_advert`, `last_heard`). A node listed twice is merged.
/// Entries without a valid 32-byte key are skipped.
List<ImportedNode> parseNodeImport(String text) {
  final trimmed = text.trim().replaceFirst('﻿', '');
  if (trimmed.isEmpty) return const [];

  List<ImportedNode> nodes;
  if (trimmed.startsWith('[') || trimmed.startsWith('{')) {
    nodes = _fromJson(trimmed);
  } else if (_looksLikeCsv(trimmed)) {
    nodes = _fromCsv(trimmed);
  } else {
    nodes = _fromLines(trimmed);
  }

  final byKey = <String, ImportedNode>{};
  for (final node in nodes) {
    final existing = byKey[node.publicKeyHex];
    if (existing == null) {
      byKey[node.publicKeyHex] = node;
    } else {
      existing.mergeFrom(node);
    }
  }
  return byKey.values.toList();
}

const _keyFields = ['public_key', 'publickey', 'pubkey', 'pub_key', 'key'];
const _nameFields = ['name', 'adv_name', 'advname', 'node_name', 'long_name'];
const _typeFields = ['type', 'adv_type', 'node_type', 'kind', 'role'];
const _latFields = ['lat', 'latitude', 'adv_lat'];
const _lonFields = ['lon', 'lng', 'long', 'longitude', 'adv_lon'];
const _seenFields = [
  'last_seen',
  'lastseen',
  'last_advert',
  'lastadvert',
  'last_heard',
  'lastheard',
  'updated_at',
  'timestamp',
];

String _norm(String field) =>
    field.trim().toLowerCase().replaceAll(RegExp(r'[\s-]'), '_');

Object? _pick(Map<String, Object?> row, List<String> fields) {
  for (final f in fields) {
    final v = row[f] ?? row[f.replaceAll('_', '')];
    if (v != null && !(v is String && v.trim().isEmpty)) return v;
  }
  return null;
}

ImportedNode? _fromRow(Map<String, Object?> raw) {
  final row = {for (final e in raw.entries) _norm(e.key): e.value};
  final key = _decodeKey(_pick(row, _keyFields));
  if (key == null) return null;
  final name = _pick(row, _nameFields)?.toString().trim();
  var lat = _toDouble(_pick(row, _latFields));
  var lon = _toDouble(_pick(row, _lonFields));
  if (!_validPosition(lat, lon)) {
    lat = null;
    lon = null;
  }
  return ImportedNode(
    publicKey: key,
    name: (name == null || name.isEmpty) ? null : name,
    type: _toType(_pick(row, _typeFields)),
    latitude: lat,
    longitude: lon,
    lastSeen: _toTime(_pick(row, _seenFields)),
  );
}

List<ImportedNode> _fromJson(String text) {
  Object? data;
  try {
    data = jsonDecode(text);
  } on FormatException {
    return _fromLines(text);
  }
  if (data is Map) {
    final inner =
        data['nodes'] ?? data['contacts'] ?? data['discovered'] ?? data['data'];
    if (inner is List) {
      data = inner;
    } else if (inner is Map) {
      data = inner.values.toList();
    } else {
      data = [data];
    }
  }
  if (data is! List) return const [];
  return [
    for (final entry in data)
      if (entry is Map) ?_fromRow(entry.cast<String, Object?>()),
  ];
}

bool _looksLikeCsv(String text) {
  final header = text.split(RegExp(r'\r?\n')).first;
  if (!header.contains(',') && !header.contains(';')) return false;
  final cells = _splitCsvLine(header, _csvDelimiter(header)).map(_norm);
  return cells.any(
    (c) => _keyFields.contains(c) || _keyFields.contains(c.replaceAll('_', '')),
  );
}

String _csvDelimiter(String header) =>
    header.split(';').length > header.split(',').length ? ';' : ',';

List<ImportedNode> _fromCsv(String text) {
  final lines = text
      .split(RegExp(r'\r?\n'))
      .where((l) => l.trim().isNotEmpty)
      .toList();
  final delimiter = _csvDelimiter(lines.first);
  final header = _splitCsvLine(lines.first, delimiter);
  return [
    for (final line in lines.skip(1))
      ?_fromRow({
        for (final (i, cell) in _splitCsvLine(line, delimiter).indexed)
          if (i < header.length) header[i]: cell,
      }),
  ];
}

/// Splits one CSV line, honouring double-quoted cells.
List<String> _splitCsvLine(String line, String delimiter) {
  final cells = <String>[];
  final cell = StringBuffer();
  var quoted = false;
  for (var i = 0; i < line.length; i++) {
    final ch = line[i];
    if (quoted) {
      if (ch == '"') {
        if (i + 1 < line.length && line[i + 1] == '"') {
          cell.write('"');
          i++;
        } else {
          quoted = false;
        }
      } else {
        cell.write(ch);
      }
    } else if (ch == '"') {
      quoted = true;
    } else if (ch == delimiter) {
      cells.add(cell.toString().trim());
      cell.clear();
    } else {
      cell.write(ch);
    }
  }
  cells.add(cell.toString().trim());
  return cells;
}

List<ImportedNode> _fromLines(String text) {
  final nodes = <ImportedNode>[];
  for (final line in text.split(RegExp(r'\r?\n'))) {
    final l = line.trim();
    if (l.isEmpty) continue;
    final link = parseContactLink(l);
    if (link != null) {
      nodes.add(
        ImportedNode(
          publicKey: link.publicKey,
          name: link.name == 'Unnamed contact' ? null : link.name,
          type: link.type,
        ),
      );
      continue;
    }
    final advert = RegExp(
      r'meshcore://([0-9a-f]+)',
      caseSensitive: false,
    ).firstMatch(l);
    if (advert != null) {
      final node = parseAdvertImport(advert.group(1)!);
      if (node != null) nodes.add(node);
      continue;
    }
    for (final m in RegExp(r'\b[0-9a-fA-F]{64}\b').allMatches(l)) {
      nodes.add(ImportedNode(publicKey: hex2Uint8List(m.group(0)!)));
    }
  }
  return nodes;
}

/// The node in a full advert packet given as hex, or null if it isn't one.
/// Layout: `[header][transport codes x4 if transport route][path len][path]`
/// then `[public key x32][time x4][signature x64][flags][lat x4, lon x4 if
/// 0x10][feature x2 if 0x20][feature x2 if 0x40][name if 0x80]`.
ImportedNode? parseAdvertImport(String hex) {
  if (hex.length.isOdd) return null;
  final raw = hex2Uint8List(hex);
  try {
    final header = raw[0];
    if ((header >> 2) & 0x0F != 0x04) return null;
    var i = 1;
    final route = header & 0x03;
    if (route == 0x00 || route == 0x03) i += 4;
    final pathLen = raw[i++];
    i += (pathLen & 0x3F) * (((pathLen >> 6) & 0x03) + 1);
    final p = Uint8List.sublistView(raw, i);
    if (p.length < 101) return null;
    final key = Uint8List.fromList(p.sublist(0, 32));
    final time = ByteData.sublistView(p, 32, 36).getUint32(0, Endian.little);
    final flags = p[100];
    var j = 101;
    double? lat;
    double? lon;
    if (flags & 0x10 != 0) {
      final d = ByteData.sublistView(p, j, j + 8);
      lat = d.getInt32(0, Endian.little) / 1e6;
      lon = d.getInt32(4, Endian.little) / 1e6;
      j += 8;
      if (!_validPosition(lat, lon)) {
        lat = null;
        lon = null;
      }
    }
    if (flags & 0x20 != 0) j += 2;
    if (flags & 0x40 != 0) j += 2;
    String? name;
    if (flags & 0x80 != 0 && j < p.length) {
      name = utf8
          .decode(
            p.sublist(j).takeWhile((b) => b != 0).toList(),
            allowMalformed: true,
          )
          .trim();
      if (name.isEmpty) name = null;
    }
    final type = flags & 0x0F;
    return ImportedNode(
      publicKey: key,
      name: name,
      type: type >= 1 && type <= 4 ? type : null,
      latitude: lat,
      longitude: lon,
      lastSeen: time == 0
          ? null
          : DateTime.fromMillisecondsSinceEpoch(time * 1000, isUtc: true),
    );
  } on RangeError {
    return null;
  }
}

Uint8List? _decodeKey(Object? value) {
  if (value == null) return null;
  final s = value.toString().trim();
  final hex = s.replaceAll(RegExp(r'[\s:]'), '');
  if (RegExp(r'^[0-9a-fA-F]{64}$').hasMatch(hex)) return hex2Uint8List(hex);
  try {
    final bytes = base64Decode(s);
    if (bytes.length == 32) return Uint8List.fromList(bytes);
  } on FormatException {
    // Not base64 either.
  }
  return null;
}

double? _toDouble(Object? v) => switch (v) {
  num n => n.toDouble(),
  String s => double.tryParse(s.trim()),
  _ => null,
};

bool _validPosition(double? lat, double? lon) =>
    lat != null &&
    lon != null &&
    lat.abs() <= 90 &&
    lon.abs() <= 180 &&
    !(lat == 0 && lon == 0);

int? _toType(Object? v) {
  if (v is num) {
    final t = v.toInt();
    return t >= 1 && t <= 4 ? t : null;
  }
  final s = v?.toString().trim().toLowerCase();
  if (s == null || s.isEmpty) return null;
  final n = int.tryParse(s);
  if (n != null) return n >= 1 && n <= 4 ? n : null;
  if (s.contains('repeat')) return advTypeRepeater;
  if (s.contains('room')) return advTypeRoom;
  if (s.contains('sensor')) return advTypeSensor;
  if (s.contains('chat') ||
      s.contains('companion') ||
      s.contains('client') ||
      s.contains('contact')) {
    return advTypeChat;
  }
  return null;
}

/// Seconds, milliseconds or an ISO date; null when it can't be read or is in
/// the future (a wrong clock), so the node isn't shown as just heard.
DateTime? _toTime(Object? v) {
  DateTime? t;
  if (v is num || (v is String && RegExp(r'^\d+(\.\d+)?$').hasMatch(v))) {
    final n = v is num ? v : num.parse(v as String);
    if (n <= 0) return null;
    final ms = n > 1e12 ? n.toInt() : (n * 1000).toInt();
    t = DateTime.fromMillisecondsSinceEpoch(ms, isUtc: true);
  } else if (v is String) {
    t = DateTime.tryParse(v.trim());
  }
  if (t == null) return null;
  if (t.isAfter(DateTime.now().add(const Duration(days: 1)))) return null;
  return t;
}
