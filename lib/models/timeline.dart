/// One feed of what happened on the mesh: messages, nodes showing up,
/// signal changes and places.
library;

enum TimelineKind { message, nodeJoined, signalChange, waypoint }

/// One line of the timeline. Words are added by the screen; this only
/// keeps the facts.
class TimelineEvent {
  const TimelineEvent({
    required this.kind,
    required this.at,
    required this.subject,
    this.detail,
    this.key,
    this.fromSnr,
    this.toSnr,
    this.outgoing = false,
  });

  final TimelineKind kind;
  final DateTime at;

  /// Who or what it is about: a node, a sender or a place name.
  final String subject;

  /// Message text, or the conversation it was in.
  final String? detail;

  /// Node key (hex) or waypoint ID.
  final String? key;
  final double? fromSnr;
  final double? toSnr;
  final bool outgoing;

  Map<String, Object?> toJson() => {
    'k': kind.name,
    'at': at.millisecondsSinceEpoch,
    's': subject,
    if (detail != null) 'd': detail,
    if (key != null) 'key': key,
    if (fromSnr != null) 'from': fromSnr,
    if (toSnr != null) 'to': toSnr,
    if (outgoing) 'out': true,
  };

  static TimelineEvent? fromJson(Object? json) {
    if (json is! Map) return null;
    final kind = TimelineKind.values.asNameMap()[json['k']];
    final at = json['at'], subject = json['s'];
    if (kind == null || at is! int || subject is! String) return null;
    return TimelineEvent(
      kind: kind,
      at: DateTime.fromMillisecondsSinceEpoch(at),
      subject: subject,
      detail: json['d'] as String?,
      key: json['key'] as String?,
      fromSnr: (json['from'] as num?)?.toDouble(),
      toSnr: (json['to'] as num?)?.toDouble(),
      outgoing: json['out'] == true,
    );
  }
}

/// SNR change (dB) that counts as a signal change worth a line.
const signalChangeDb = 6.0;

/// Watches each node's direct SNR and reports when it moves by
/// [signalChangeDb] or more from where it settled, so slow drift and
/// packet-to-packet jitter stay quiet.
class SignalChangeTracker {
  final Map<String, double> _baseline = {};

  /// Returns the change for [key] now heard at [snr], or null.
  ({double from, double to})? observe(String key, double snr) {
    final base = _baseline[key];
    if (base == null) {
      _baseline[key] = snr;
      return null;
    }
    if ((snr - base).abs() >= signalChangeDb) {
      _baseline[key] = snr;
      return (from: base, to: snr);
    }
    // Follow small moves slowly, so the baseline stays current.
    _baseline[key] = base * 0.8 + snr * 0.2;
    return null;
  }
}

/// Whether [text] carries a shared place (`m:<lat>,<lon>|label|`).
bool hasSharedPlace(String text) =>
    RegExp(r'(^|\s)m:-?\d{1,3}(\.\d+)?,-?\d{1,3}(\.\d+)?\|').hasMatch(text);

/// [events] newest first, keeping only [kinds] and lines containing every
/// word of [query].
List<TimelineEvent> filterTimeline(
  Iterable<TimelineEvent> events, {
  required Set<TimelineKind> kinds,
  String query = '',
}) {
  final words = query
      .toLowerCase()
      .split(RegExp(r'\s+'))
      .where((w) => w.isNotEmpty)
      .toList();
  final out = events.where((e) {
    if (!kinds.contains(e.kind)) return false;
    if (words.isEmpty) return true;
    final hay = '${e.subject} ${e.detail ?? ''}'.toLowerCase();
    return words.every(hay.contains);
  }).toList();
  out.sort((a, b) => b.at.compareTo(a.at));
  return out;
}
