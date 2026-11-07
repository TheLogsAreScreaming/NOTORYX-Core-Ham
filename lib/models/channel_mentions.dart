import 'channel_message.dart';

/// Channel messages without those from [blocked] senders. Outgoing messages
/// are always kept.
List<ChannelMessage> withoutBlockedSenders(
  List<ChannelMessage> messages,
  Set<String> blocked,
) {
  if (blocked.isEmpty) return messages;
  return [
    for (final m in messages)
      if (m.isOutgoing || !blocked.contains(m.senderName.trim())) m,
  ];
}

/// The partial name being typed after an `@` that ends at [cursor], or null
/// when the cursor isn't in a mention.
///
/// The `@` must start the text or follow whitespace, so an email address or
/// an already inserted `@[name]` doesn't trigger suggestions. An empty
/// string means the user has just typed `@`.
String? mentionQueryAt(String text, int cursor) {
  if (cursor < 1 || cursor > text.length) return null;
  final before = text.substring(0, cursor);
  final at = before.lastIndexOf('@');
  if (at < 0) return null;
  if (at > 0 && !_isSpace(before.codeUnitAt(at - 1))) return null;
  final query = before.substring(at + 1);
  if (query.length > 32) return null;
  if (query.contains('[') || query.contains(']')) return null;
  if (query.runes.any((r) => r == 0x0A || r == 0x0D)) return null;
  // Names can contain spaces, but a mention never starts with one and two
  // spaces in a row mean the user moved on.
  if (query.startsWith(' ') || query.contains('  ')) return null;
  return query;
}

/// Names to suggest for [query]: senders heard on this channel, most recent
/// first, without duplicates, blocked senders or the user's own name.
List<String> mentionCandidates(
  List<ChannelMessage> messages,
  String query, {
  String? selfName,
  Set<String> blocked = const {},
  int limit = 6,
}) {
  final needle = query.toLowerCase();
  final self = selfName?.trim().toLowerCase();
  final seen = <String>{};
  final starts = <String>[];
  final contains = <String>[];
  for (final m in messages.reversed) {
    if (m.isOutgoing) continue;
    final name = m.senderName.trim();
    if (name.isEmpty || blocked.contains(name)) continue;
    final lower = name.toLowerCase();
    if (lower == self || !seen.add(lower)) continue;
    if (lower.startsWith(needle)) {
      starts.add(name);
    } else if (needle.isNotEmpty && lower.contains(needle)) {
      contains.add(name);
    }
  }
  return [...starts, ...contains].take(limit).toList();
}

/// Text and cursor after replacing the mention ending at [cursor] with
/// `@[name] `, the format other MeshCore apps use.
({String text, int cursor}) applyMention(String text, int cursor, String name) {
  final at = text.substring(0, cursor).lastIndexOf('@');
  final start = at < 0 ? cursor : at;
  final insert = '@[$name] ';
  var rest = text.substring(cursor);
  if (rest.startsWith(' ')) rest = rest.substring(1);
  return (
    text: text.substring(0, start) + insert + rest,
    cursor: start + insert.length,
  );
}

bool _isSpace(int c) => c == 0x20 || c == 0x0A || c == 0x0D || c == 0x09;
