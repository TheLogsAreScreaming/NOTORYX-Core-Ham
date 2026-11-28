import 'dart:convert';

import 'message_db.dart';

/// Message history inside an encrypted backup: direct and channel rows from
/// the message database, by radio scope then conversation.
class HistoryBackup {
  const HistoryBackup._();

  /// The backup entry that holds the history. Never written to settings.
  static const key = 'notoryx_history_v1';

  /// All stored history as one JSON string.
  static String encode(MessageDb db) => jsonEncode({
    for (final table in MessageTable.values) table.name: db.exportTable(table),
  });

  /// How many messages [encoded] holds; 0 if it can't be read.
  static int count(Object? encoded) {
    try {
      return _decode(encoded).values
          .expand((scopes) => scopes.values)
          .expand((conversations) => conversations.values)
          .fold(0, (sum, rows) => sum + rows.length);
    } on FormatException {
      return 0;
    }
  }

  /// Adds [encoded]'s messages to [db] and returns how many were new.
  /// Messages already on this device are kept as they are; the rest are
  /// slotted in by time. Every conversation is written in one transaction,
  /// so a failure changes nothing.
  static int restore(MessageDb db, Object? encoded) {
    final decoded = _decode(encoded);
    final writes = <ConversationRows>[];
    var added = 0;
    for (final MapEntry(key: table, value: scopes) in decoded.entries) {
      for (final MapEntry(key: scope, value: conversations) in scopes.entries) {
        for (final MapEntry(key: conversation, value: rows)
            in conversations.entries) {
          final existing = db.load(table, scope, conversation);
          final merged = merge(existing, rows);
          if (merged.length == existing.length) continue;
          added += merged.length - existing.length;
          writes.add((
            table: table,
            scope: scope,
            conversation: conversation,
            rows: merged,
          ));
        }
      }
    }
    if (writes.isNotEmpty) db.replaceMany(writes);
    return added;
  }

  /// [existing] plus the [incoming] rows it doesn't already have, oldest
  /// first. On equal times the original order is kept.
  static List<String> merge(List<String> existing, List<String> incoming) {
    final seen = {for (final row in existing) _identity(row)};
    final extra = [
      for (final row in incoming)
        if (seen.add(_identity(row))) row,
    ];
    if (extra.isEmpty) return existing;
    final all = [...existing, ...extra];
    final order = [for (var i = 0; i < all.length; i++) (i, _time(all[i]))]
      ..sort((a, b) {
        final byTime = a.$2.compareTo(b.$2);
        return byTime != 0 ? byTime : a.$1.compareTo(b.$1);
      });
    return [for (final (i, _) in order) all[i]];
  }

  /// The same message has the same id even if its status changed since.
  static String _identity(String row) {
    final json = _json(row);
    if (json == null) return 'raw:$row';
    final id = json['messageId'];
    if (id is String && id.isNotEmpty) return 'id:$id';
    return 'at:${json['timestamp']}|${json['isOutgoing']}|${json['text']}';
  }

  static int _time(String row) {
    final t = _json(row)?['timestamp'];
    return t is int ? t : 0;
  }

  static Map<String, dynamic>? _json(String row) {
    try {
      final value = jsonDecode(row);
      return value is Map<String, dynamic> ? value : null;
    } on FormatException {
      return null;
    }
  }

  static Map<MessageTable, Map<String, Map<String, List<String>>>> _decode(
    Object? encoded,
  ) {
    if (encoded is! String) throw const FormatException('No history.');
    final json = jsonDecode(encoded);
    if (json is! Map<String, dynamic>) {
      throw const FormatException('Invalid history.');
    }
    final out = <MessageTable, Map<String, Map<String, List<String>>>>{};
    for (final table in MessageTable.values) {
      final scopes = json[table.name];
      if (scopes == null) continue;
      if (scopes is! Map<String, dynamic>) {
        throw const FormatException('Invalid history.');
      }
      out[table] = {
        for (final MapEntry(key: scope, value: conversations) in scopes.entries)
          scope: _conversations(conversations),
      };
    }
    return out;
  }

  static Map<String, List<String>> _conversations(Object? value) {
    if (value is! Map<String, dynamic>) {
      throw const FormatException('Invalid history.');
    }
    return {
      for (final MapEntry(key: conversation, value: rows) in value.entries)
        conversation: switch (rows) {
          final List<dynamic> list when list.every((r) => r is String) =>
            list.cast<String>(),
          _ => throw const FormatException('Invalid history.'),
        },
    };
  }
}
