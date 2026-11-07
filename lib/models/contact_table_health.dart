import 'contact.dart';

/// How full the radio's contact table is.
enum ContactTableLevel { ok, nearlyFull, full }

/// The radio's contact table use, judged against the limit it reports.
///
/// The radio holds a fixed number of contacts. Once full it either replaces
/// the least recently heard non-favorite ("overwrite oldest") or stops adding
/// contacts it hears, so the user is warned before that point.
class ContactTableHealth {
  const ContactTableHealth({
    required this.used,
    required this.max,
    required this.overwriteOldest,
  });

  /// Share of the table at which the warning starts.
  static const double nearlyFullFraction = 0.9;

  /// Contacts the radio currently holds.
  final int used;

  /// The most contacts the radio can hold.
  final int max;

  /// Whether the radio replaces its oldest contact when full.
  final bool overwriteOldest;

  /// Share of the table in use, from 0 to 1.
  double get fraction => max <= 0 ? 0 : (used / max).clamp(0, 1).toDouble();

  /// Share in use as a whole percentage, rounded down so 89.9% never reads
  /// as 90%.
  int get percent => (fraction * 100).floor();

  ContactTableLevel get level {
    if (max <= 0) return ContactTableLevel.ok;
    if (used >= max) return ContactTableLevel.full;
    if (fraction >= nearlyFullFraction) return ContactTableLevel.nearlyFull;
    return ContactTableLevel.ok;
  }

  /// Whether the user should be told about the table's fullness.
  bool get needsAttention => level != ContactTableLevel.ok;
}

/// Contacts worth removing to free space, least recently heard first.
///
/// Favorites are never suggested. The caller decides what to remove; nothing
/// here removes anything.
List<Contact> contactRemovalSuggestions(Iterable<Contact> contacts) {
  final candidates = [
    for (final c in contacts)
      if (!c.isFavorite) c,
  ];
  candidates.sort((a, b) {
    final byHeard = a.lastSeen.compareTo(b.lastSeen);
    if (byHeard != 0) return byHeard;
    return a.name.toLowerCase().compareTo(b.name.toLowerCase());
  });
  return candidates;
}
