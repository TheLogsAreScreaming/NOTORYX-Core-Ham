import 'dart:math';
import 'dart:typed_data';

import '../connector/meshcore_protocol.dart';
import 'contact.dart';

/// The first [bytes] bytes of a public key as uppercase hex, e.g. "3D4A".
/// This is the ID a node shows up as in message paths.
String keyPrefixHex(Uint8List key, int bytes) {
  final n = min(bytes, key.length);
  final buf = StringBuffer();
  for (var i = 0; i < n; i++) {
    buf.write(key[i].toRadixString(16).padLeft(2, '0'));
  }
  return buf.toString().toUpperCase();
}

/// Which path IDs the nodes this radio knows about use, at one path width:
/// who shares an ID (so paths through it are ambiguous) and which IDs are
/// still free for a new repeater.
class PrefixCensus {
  PrefixCensus._(this.bytes, this.byPrefix);

  /// Path width in bytes per hop: 1, 2 or 3.
  final int bytes;

  /// Nodes grouped by their ID at this width.
  final Map<String, List<Contact>> byPrefix;

  /// Counts the nodes in [contacts]. Only repeaters and room servers by
  /// default, since they are what forwards messages and shows up in paths;
  /// [includeCompanions] adds chat companions and sensors too.
  factory PrefixCensus.build(
    Iterable<Contact> contacts, {
    required int bytes,
    bool includeCompanions = false,
  }) {
    final width = bytes.clamp(1, 3);
    final map = <String, List<Contact>>{};
    final seenKeys = <String>{};
    for (final c in contacts) {
      if (c.publicKey.length < width) continue;
      if (!includeCompanions &&
          c.type != advTypeRepeater &&
          c.type != advTypeRoom) {
        continue;
      }
      if (!seenKeys.add(c.publicKeyHex)) continue;
      map.putIfAbsent(keyPrefixHex(c.publicKey, width), () => []).add(c);
    }
    for (final list in map.values) {
      list.sort((a, b) => b.lastSeen.compareTo(a.lastSeen));
    }
    return PrefixCensus._(width, map);
  }

  /// Number of possible IDs at this width.
  int get space => 1 << (8 * bytes);

  int get nodeCount => byPrefix.values.fold(0, (n, l) => n + l.length);

  /// IDs used by more than one node, most crowded first.
  List<MapEntry<String, List<Contact>>> get collisions {
    final out = [
      for (final e in byPrefix.entries)
        if (e.value.length > 1) e,
    ];
    out.sort((a, b) {
      final byCount = b.value.length.compareTo(a.value.length);
      return byCount != 0 ? byCount : a.key.compareTo(b.key);
    });
    return out;
  }

  /// Nodes whose ID starts with [query] (hex, any case, '#' or spaces
  /// ignored). An empty or non-hex query matches nothing.
  List<Contact> lookup(String query) {
    final q = normalizePrefixQuery(query);
    if (q.isEmpty) return const [];
    final out = [
      for (final group in byPrefix.values)
        for (final c in group)
          if (c.publicKeyHex.toUpperCase().startsWith(q)) c,
    ];
    out.sort((a, b) => b.lastSeen.compareTo(a.lastSeen));
    return out;
  }

  /// Whether no known node uses [prefix] at this width.
  bool isFree(String prefix) =>
      !byPrefix.containsKey(normalizePrefixQuery(prefix));

  /// Every free 1-byte ID in order. Only meaningful when [bytes] is 1.
  List<String> get freeOneByte => [
    for (var i = 0; i < 256; i++)
      if (isFree(i.toRadixString(16).padLeft(2, '0'))) _hex(i, 1),
  ];

  /// Up to [count] free IDs at this width, picked at random.
  List<String> suggestFree(int count, {Random? random}) {
    final rng = random ?? Random.secure();
    if (bytes == 1) {
      final free = freeOneByte..shuffle(rng);
      return free.take(count).toList();
    }
    final out = <String>{};
    var attempts = 0;
    while (out.length < count && attempts < count * 50) {
      attempts++;
      final candidate = _hex(rng.nextInt(space), bytes);
      if (isFree(candidate)) out.add(candidate);
    }
    return out.toList();
  }

  static String _hex(int value, int bytes) =>
      value.toRadixString(16).padLeft(bytes * 2, '0').toUpperCase();
}

/// Uppercase hex with '#', spaces and other non-hex characters removed.
String normalizePrefixQuery(String query) =>
    query.toUpperCase().replaceAll(RegExp(r'[^0-9A-F]'), '');
