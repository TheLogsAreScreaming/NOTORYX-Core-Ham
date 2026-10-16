import 'dart:math';

import '../connector/meshcore_protocol.dart';
import 'contact.dart';

/// One path a message took to reach this radio: repeater hash prefixes in
/// travel order (first = the repeater nearest the sender, last = the one
/// nearest us), each [width] bytes, as uppercase hex.
class PathObservation {
  final List<String> hops;
  final int width;
  final DateTime at;

  /// Who sent it ("Alex on #weather"), for the per-path list.
  final String source;

  const PathObservation({
    required this.hops,
    required this.width,
    required this.at,
    required this.source,
  });

  /// Splits raw path bytes into [width]-byte hops.
  factory PathObservation.fromBytes(
    List<int> bytes, {
    required int width,
    required DateTime at,
    required String source,
  }) {
    final w = width.clamp(1, 4);
    final hops = <String>[
      for (var i = 0; i + w <= bytes.length; i += w)
        bytes
            .sublist(i, i + w)
            .map((b) => b.toRadixString(16).padLeft(2, '0'))
            .join()
            .toUpperCase(),
    ];
    return PathObservation(hops: hops, width: w, at: at, source: source);
  }
}

/// A repeater in the graph, identified by the longest hash prefix we could
/// pin it to.
class PathNode {
  /// Hex prefix, 2 characters per byte ("A1", "A1B2").
  final String id;

  /// The repeater's name when exactly one known repeater matches [id].
  final String? name;

  /// Times this node relayed an observed message.
  final int relays;

  /// True when a short hop could not be told apart from other repeaters
  /// sharing its prefix.
  final bool ambiguous;

  const PathNode({
    required this.id,
    this.name,
    required this.relays,
    this.ambiguous = false,
  });

  String get label => name ?? (ambiguous ? '$id?' : id);
}

/// A flow between two adjacent hops (or the last hop and us).
class PathLink {
  final String from;
  final String to;
  final int count;
  const PathLink(this.from, this.to, this.count);
}

/// The node id used for this radio, the end of every path.
const pathGraphSelf = 'YOU';

/// Every observed path combined into one graph. Short (1-byte) hops are
/// resolved using what longer (2- and 3-byte) paths revealed about the
/// same repeaters and their neighbours, then known contacts.
class PathGraph {
  final Map<String, PathNode> nodes;
  final List<PathLink> links;

  /// Each observation's hops after resolution, aligned with the input.
  final List<List<String>> resolvedPaths;

  /// How many 1-byte hops were resolved to a longer prefix.
  final int upgradedHops;

  /// How many hops stayed ambiguous.
  final int ambiguousHops;

  const PathGraph({
    required this.nodes,
    required this.links,
    required this.resolvedPaths,
    required this.upgradedHops,
    required this.ambiguousHops,
  });

  static PathGraph build(
    List<PathObservation> observations, {
    List<Contact> contacts = const [],
  }) {
    final repeaterKeys = <String, String>{}; // full hex key -> name
    for (final c in contacts) {
      if (c.type == advTypeRepeater || c.type == advTypeRoom) {
        repeaterKeys[c.publicKeyHex.toUpperCase()] = c.name;
      }
    }
    List<String> matching(String prefix) => [
      for (final k in repeaterKeys.keys)
        if (k.startsWith(prefix)) k,
    ];

    // 1. Learn from multi-byte paths: which longer prefixes exist, and which
    //    ones sit next to each other.
    final longer = <String, Set<String>>{}; // first byte -> longer prefixes
    final adjacency = <String, Map<String, int>>{};
    void link(String a, String b) {
      adjacency.putIfAbsent(a, () => {})[b] = (adjacency[a]![b] ?? 0) + 1;
      adjacency.putIfAbsent(b, () => {})[a] = (adjacency[b]![a] ?? 0) + 1;
    }

    for (final o in observations.where((o) => o.width > 1)) {
      for (var i = 0; i < o.hops.length; i++) {
        longer.putIfAbsent(o.hops[i].substring(0, 2), () => {}).add(o.hops[i]);
        if (i > 0) link(o.hops[i - 1], o.hops[i]);
      }
    }
    // Known repeaters count as longer prefixes too (their 3-byte prefix).
    for (final k in repeaterKeys.keys) {
      longer.putIfAbsent(k.substring(0, 2), () => {}).add(k.substring(0, 6));
    }

    // The same repeater can appear as "AB12" in one path and "AB1234" in
    // another: fold every prefix into the longest one it starts.
    final alias = <String, String>{};
    for (final set in longer.values) {
      final sorted = set.toList()..sort((a, b) => b.length.compareTo(a.length));
      for (final shortP in sorted) {
        final into = sorted.where(
          (l) => l.length > shortP.length && l.startsWith(shortP),
        );
        // Only fold when there is one longer match; otherwise it's ambiguous.
        if (into.length == 1) alias[shortP] = into.first;
      }
    }
    String canon(String id) {
      var c = id;
      while (alias.containsKey(c)) {
        c = alias[c]!;
      }
      return c;
    }

    for (final key in longer.keys.toList()) {
      longer[key] = longer[key]!.map(canon).toSet();
    }
    final merged = <String, Map<String, int>>{};
    for (final a in adjacency.entries) {
      final m = merged.putIfAbsent(canon(a.key), () => {});
      for (final b in a.value.entries) {
        m[canon(b.key)] = (m[canon(b.key)] ?? 0) + b.value;
      }
    }
    adjacency
      ..clear()
      ..addAll(merged);

    String? pick(String hop, String? neighbourA, String? neighbourB) {
      final options = longer[hop];
      if (options == null || options.isEmpty) return null;
      if (options.length == 1) return options.first;
      int score(String candidate) {
        var s = 0;
        for (final n in [neighbourA, neighbourB]) {
          if (n == null) continue;
          for (final e in (adjacency[candidate] ?? {}).entries) {
            if (e.key.startsWith(n) || n.startsWith(e.key)) s += e.value;
          }
        }
        return s;
      }

      final ranked = options.toList()
        ..sort((a, b) => score(b).compareTo(score(a)));
      final best = score(ranked.first);
      if (best == 0) return null;
      if (ranked.length > 1 && score(ranked[1]) == best) return null;
      return ranked.first;
    }

    // 2. Resolve each path. Longer hops are kept; 1-byte hops are upgraded
    //    when their neighbours make the choice clear.
    var upgraded = 0;
    var ambiguousCount = 0;
    final ambiguous = <String>{};
    final resolved = <List<String>>[];
    for (final o in observations) {
      final hops = [for (final h in o.hops) h.length > 2 ? canon(h) : h];
      if (o.width == 1) {
        // Two passes so a resolved neighbour can help the next hop.
        for (var pass = 0; pass < 2; pass++) {
          for (var i = 0; i < hops.length; i++) {
            if (hops[i].length > 2) continue;
            final prev = i > 0 ? hops[i - 1] : null;
            final next = i < hops.length - 1 ? hops[i + 1] : null;
            final choice = pick(o.hops[i], prev, next);
            if (choice != null) {
              hops[i] = choice;
              upgraded++;
            }
          }
        }
        for (final h in hops) {
          if (h.length == 2 && (longer[h]?.length ?? 0) > 1) {
            ambiguous.add(h);
            ambiguousCount++;
          }
        }
      }
      resolved.add(hops);
    }

    // 3. Count relays and links.
    final relays = <String, int>{};
    final linkCounts = <String, int>{};
    for (final hops in resolved) {
      for (var i = 0; i < hops.length; i++) {
        relays[hops[i]] = (relays[hops[i]] ?? 0) + 1;
        final to = i == hops.length - 1 ? pathGraphSelf : hops[i + 1];
        final key = '${hops[i]}>$to';
        linkCounts[key] = (linkCounts[key] ?? 0) + 1;
      }
    }
    final nodes = <String, PathNode>{
      for (final e in relays.entries)
        e.key: PathNode(
          id: e.key,
          relays: e.value,
          ambiguous: ambiguous.contains(e.key),
          name: () {
            final m = matching(e.key);
            return m.length == 1 ? repeaterKeys[m.first] : null;
          }(),
        ),
      pathGraphSelf: PathNode(
        id: pathGraphSelf,
        name: 'You',
        relays: resolved.where((h) => h.isNotEmpty).length,
      ),
    };
    final links = [
      for (final e in linkCounts.entries)
        PathLink(e.key.split('>')[0], e.key.split('>')[1], e.value),
    ]..sort((a, b) => b.count.compareTo(a.count));

    return PathGraph(
      nodes: nodes,
      links: links,
      resolvedPaths: resolved,
      upgradedHops: upgraded,
      ambiguousHops: ambiguousCount,
    );
  }

  /// Repeaters ranked by how many observed messages they relayed.
  List<PathNode> get busiest =>
      nodes.values.where((n) => n.id != pathGraphSelf).toList()
        ..sort((a, b) => b.relays.compareTo(a.relays));

  /// Sankey columns: column 0 is you, column 1 the last hops before you,
  /// and so on outward, up to [maxDepth]. A repeater sits in the column
  /// where it most often appears.
  List<List<String>> columns({int maxDepth = 5}) {
    final depthVotes = <String, Map<int, int>>{};
    for (final hops in resolvedPaths) {
      for (var i = 0; i < hops.length; i++) {
        final depth = min(hops.length - i, maxDepth);
        final v = depthVotes.putIfAbsent(hops[i], () => {});
        v[depth] = (v[depth] ?? 0) + 1;
      }
    }
    final out = List.generate(maxDepth + 1, (_) => <String>[]);
    out[0].add(pathGraphSelf);
    for (final e in depthVotes.entries) {
      final depth = e.value.entries
          .reduce((a, b) => b.value > a.value ? b : a)
          .key;
      out[depth].add(e.key);
    }
    for (final col in out) {
      col.sort(
        (a, b) => (nodes[b]?.relays ?? 0).compareTo(nodes[a]?.relays ?? 0),
      );
    }
    while (out.length > 1 && out.last.isEmpty) {
      out.removeLast();
    }
    return out;
  }
}
