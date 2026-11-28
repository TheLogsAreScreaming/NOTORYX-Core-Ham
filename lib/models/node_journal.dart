import 'dart:math' as math;

import '../connector/meshcore_protocol.dart';

double _metersBetween(double lat1, double lon1, double lat2, double lon2) {
  const r = 6371000.0;
  double rad(double d) => d * math.pi / 180;
  final dLat = rad(lat2 - lat1), dLon = rad(lon2 - lon1);
  final h =
      math.pow(math.sin(dLat / 2), 2) +
      math.cos(rad(lat1)) *
          math.cos(rad(lat2)) *
          math.pow(math.sin(dLon / 2), 2);
  return 2 * r * math.asin(math.sqrt(h.toDouble()));
}

/// Places closer together than this count as the same spot.
const journalSpotMeters = 500.0;

/// Most distinct spots and days kept per node.
const journalMaxSpots = 20;
const journalMaxDays = 120;

String journalDay(DateTime t) {
  final l = t.toLocal();
  String two(int v) => v.toString().padLeft(2, '0');
  return '${l.year}-${two(l.month)}-${two(l.day)}';
}

/// Everything the journal has learned about one node, kept forever (until
/// the user forgets it).
class JournalEntry {
  JournalEntry({
    required this.key,
    required this.name,
    required this.type,
    required this.firstSeen,
    required this.lastSeen,
    this.sightings = 1,
    Set<String>? days,
    this.minHops,
    this.maxHops,
    List<({double lat, double lon})>? spots,
    Set<String>? tags,
    this.note = '',
    this.lastAdvert,
  }) : days = days ?? {journalDay(lastSeen)},
       spots = spots ?? [],
       tags = tags ?? {};

  /// Public key in hex.
  final String key;
  String name;
  int type;
  DateTime firstSeen;

  /// When this phone last saw the node's advert change.
  DateTime lastSeen;

  /// How many fresh adverts were seen.
  int sightings;

  /// Local days (yyyy-mm-dd) the node was heard on.
  final Set<String> days;
  int? minHops;
  int? maxHops;

  /// Distinct places the node advertised from.
  final List<({double lat, double lon})> spots;
  final Set<String> tags;
  String note;

  /// The node's own advert time last seen, to tell a fresh advert apart.
  DateTime? lastAdvert;

  bool get isRelay => type == advTypeRepeater || type == advTypeRoom;

  /// Records one look at the node. [advert] is the node's advert time;
  /// a sighting counts only when it changed. Returns whether anything
  /// changed.
  bool observe({
    required String name,
    required int type,
    required DateTime advert,
    required DateTime now,
    int? hops,
    double? lat,
    double? lon,
  }) {
    var changed = false;
    if (name.isNotEmpty && name != this.name) {
      this.name = name;
      changed = true;
    }
    if (type != this.type) {
      this.type = type;
      changed = true;
    }
    if (hops != null && hops >= 0) {
      if (minHops == null || hops < minHops!) {
        minHops = hops;
        changed = true;
      }
      if (maxHops == null || hops > maxHops!) {
        maxHops = hops;
        changed = true;
      }
    }
    if (lat != null && lon != null && addSpot(lat, lon)) changed = true;
    if (lastAdvert != advert) {
      final fresh = lastAdvert != null;
      lastAdvert = advert;
      changed = true;
      if (fresh) {
        sightings++;
        lastSeen = now;
        days.add(journalDay(now));
        if (days.length > journalMaxDays) {
          final sorted = days.toList()..sort();
          days.removeAll(sorted.take(days.length - journalMaxDays));
        }
      }
    }
    return changed;
  }

  bool addSpot(double lat, double lon) {
    if (lat == 0 && lon == 0) return false;
    final near = spots.any(
      (s) => _metersBetween(s.lat, s.lon, lat, lon) < journalSpotMeters,
    );
    if (near) return false;
    spots.add((lat: lat, lon: lon));
    if (spots.length > journalMaxSpots) spots.removeAt(0);
    return true;
  }

  /// Widest distance between any two spots, in metres.
  double get spreadMeters {
    var best = 0.0;
    for (var i = 0; i < spots.length; i++) {
      for (var j = i + 1; j < spots.length; j++) {
        best = math.max(
          best,
          _metersBetween(
            spots[i].lat,
            spots[i].lon,
            spots[j].lat,
            spots[j].lon,
          ),
        );
      }
    }
    return best;
  }

  Map<String, Object?> toJson() => {
    'key': key,
    'name': name,
    'type': type,
    'first': firstSeen.millisecondsSinceEpoch,
    'last': lastSeen.millisecondsSinceEpoch,
    'n': sightings,
    'days': days.toList(),
    'minH': minHops,
    'maxH': maxHops,
    'spots': [
      for (final s in spots) [s.lat, s.lon],
    ],
    'tags': tags.toList(),
    'note': note,
    'adv': lastAdvert?.millisecondsSinceEpoch,
  };

  static JournalEntry? fromJson(Object? json) {
    if (json is! Map) return null;
    final key = json['key'], first = json['first'], last = json['last'];
    if (key is! String || first is! int || last is! int) return null;
    final adv = json['adv'];
    return JournalEntry(
      key: key,
      name: json['name'] as String? ?? '',
      type: json['type'] as int? ?? 0,
      firstSeen: DateTime.fromMillisecondsSinceEpoch(first),
      lastSeen: DateTime.fromMillisecondsSinceEpoch(last),
      sightings: json['n'] as int? ?? 1,
      days: {...(json['days'] as List? ?? const []).whereType<String>()},
      minHops: json['minH'] as int?,
      maxHops: json['maxH'] as int?,
      spots: [
        for (final s in json['spots'] as List? ?? const [])
          if (s is List && s.length == 2 && s[0] is num && s[1] is num)
            (lat: (s[0] as num).toDouble(), lon: (s[1] as num).toDouble()),
      ],
      tags: {...(json['tags'] as List? ?? const []).whereType<String>()},
      note: json['note'] as String? ?? '',
      lastAdvert: adv is int ? DateTime.fromMillisecondsSinceEpoch(adv) : null,
    );
  }
}

/// How a node tends to behave on the mesh.
enum NodeBehaviour {
  /// A relay heard on nearly every day since it first showed up.
  steadyRelay,

  /// A person's node heard on most days.
  regular,

  /// Heard from several places far apart.
  roamer,

  /// Known for a while but heard on very few days.
  rarelyHeard,

  /// First heard within the last day.
  newcomer,

  /// Used to be heard often, silent for a week or more.
  goneQuiet,
}

/// One fact behind a behaviour label, as numbers the screen puts in words.
enum EvidenceKind {
  /// Heard on [a] of the last [b] days.
  daysHeard,

  /// First heard [a] hours ago.
  firstHeardHours,

  /// Not heard for [a] days.
  silentDays,

  /// Seen at [a] places, up to [b] km apart.
  places,

  /// [a] fresh adverts in all.
  sightings,
}

class Evidence {
  const Evidence(this.kind, this.a, [this.b = 0]);
  final EvidenceKind kind;
  final int a;
  final int b;

  @override
  bool operator ==(Object other) =>
      other is Evidence && other.kind == kind && other.a == a && other.b == b;

  @override
  int get hashCode => Object.hash(kind, a, b);

  @override
  String toString() => '${kind.name}($a, $b)';
}

/// A behaviour label with how sure the journal is (0 to 1) and why.
class BehaviourGuess {
  const BehaviourGuess(this.behaviour, this.confidence, this.evidence);
  final NodeBehaviour behaviour;
  final double confidence;
  final List<Evidence> evidence;

  int get percent => (confidence * 100).round();
}

/// Labels [e] from what the journal has seen, most certain first. Rules
/// are plain thresholds so every label can show its evidence.
List<BehaviourGuess> classifyNode(JournalEntry e, DateTime now) {
  final guesses = <BehaviourGuess>[];
  final span = math.max(1, now.difference(e.firstSeen).inHours ~/ 24 + 1);
  final heard = e.days.length;
  final ratio = math.min(1.0, heard / span);
  final silent = now.difference(e.lastSeen).inDays;
  final daysEvidence = Evidence(EvidenceKind.daysHeard, heard, span);

  final age = now.difference(e.firstSeen).inHours;
  if (age < 24) {
    guesses.add(
      BehaviourGuess(NodeBehaviour.newcomer, 0.9, [
        Evidence(EvidenceKind.firstHeardHours, age),
      ]),
    );
  }
  if (silent >= 7 && heard >= 3) {
    guesses.add(
      BehaviourGuess(NodeBehaviour.goneQuiet, math.min(1.0, silent / 14), [
        Evidence(EvidenceKind.silentDays, silent),
        daysEvidence,
      ]),
    );
  }
  if (silent < 7 && span >= 3) {
    final sure = ratio * math.min(1.0, span / 7);
    if (e.isRelay && ratio >= 0.7) {
      guesses.add(
        BehaviourGuess(NodeBehaviour.steadyRelay, sure, [
          daysEvidence,
          Evidence(EvidenceKind.sightings, e.sightings),
        ]),
      );
    } else if (!e.isRelay && ratio >= 0.5) {
      guesses.add(
        BehaviourGuess(NodeBehaviour.regular, sure, [
          daysEvidence,
          Evidence(EvidenceKind.sightings, e.sightings),
        ]),
      );
    }
  }
  if (e.spots.length >= 3 && e.spreadMeters >= 2000) {
    guesses.add(
      BehaviourGuess(
        NodeBehaviour.roamer,
        math.min(1.0, 0.3 + (e.spots.length - 2) / 4),
        [
          Evidence(
            EvidenceKind.places,
            e.spots.length,
            (e.spreadMeters / 1000).round(),
          ),
        ],
      ),
    );
  }
  if (span >= 7 && heard <= 2) {
    guesses.add(
      BehaviourGuess(
        NodeBehaviour.rarelyHeard,
        math.min(1.0, 0.4 + span / 30),
        [daysEvidence],
      ),
    );
  }
  guesses.sort((a, b) => b.confidence.compareTo(a.confidence));
  return guesses;
}

/// A node's generated mark: a symmetric 5x5 pattern and two colours, all
/// taken from the bytes of its public key so it never changes.
class NodeMarkSpec {
  const NodeMarkSpec(this.cells, this.hue, this.accentHue);

  /// 25 cells, row by row; true is filled. Columns mirror left to right.
  final List<bool> cells;

  /// Hues (0 to 360) for the filled cells and the backdrop.
  final double hue;
  final double accentHue;
}

/// FNV-1a over the key text, so any length of key works the same way.
int _fnv(String s) {
  var h = 0x811c9dc5;
  for (final c in s.codeUnits) {
    h = ((h ^ c) * 0x01000193) & 0xffffffff;
  }
  return h;
}

NodeMarkSpec nodeMarkFor(String keyHex) {
  final k = keyHex.toLowerCase();
  final a = _fnv(k), b = _fnv('$k#');
  final cells = List<bool>.filled(25, false);
  var bit = 0;
  for (var row = 0; row < 5; row++) {
    for (var col = 0; col < 3; col++) {
      final on = ((b >> bit) & 1) == 1;
      bit++;
      cells[row * 5 + col] = on;
      cells[row * 5 + (4 - col)] = on;
    }
  }
  // Never blank: light the centre when nothing else is.
  if (!cells.contains(true)) cells[12] = true;
  final hue = (a % 360).toDouble();
  return NodeMarkSpec(cells, hue, (hue + 150 + (a >> 9) % 60) % 360);
}
