import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../utils/app_logger.dart';
import 'message_db.dart';

const _schemaVersion = 1;

Future<MessageDb?> openMessageDb() async {
  try {
    final dir = await getApplicationSupportDirectory();
    await dir.create(recursive: true);
    final db = sqlite3.open('${dir.path}${Platform.pathSeparator}messages.db');
    return _SqliteMessageDb(db);
  } catch (e) {
    appLogger.error('Message database unavailable, using preferences: $e');
    return null;
  }
}

MessageDb? openInMemoryMessageDb() => _SqliteMessageDb(sqlite3.openInMemory());

class _SqliteMessageDb implements MessageDb {
  _SqliteMessageDb(this._db) {
    _db.execute('PRAGMA journal_mode = WAL');
    _db.execute('PRAGMA synchronous = NORMAL');
    final version = _db.select('PRAGMA user_version').single.values.first;
    if (version == 0) {
      _db.execute('BEGIN');
      for (final table in MessageTable.values) {
        _db.execute(
          'CREATE TABLE IF NOT EXISTS ${table.sql} ('
          'scope TEXT NOT NULL, conversation TEXT NOT NULL, '
          'position INTEGER NOT NULL, json TEXT NOT NULL, '
          'PRIMARY KEY (scope, conversation, position)) WITHOUT ROWID',
        );
      }
      _db.execute(
        'CREATE TABLE IF NOT EXISTS migrated (scope TEXT PRIMARY KEY, '
        'at INTEGER NOT NULL)',
      );
      _db.execute('PRAGMA user_version = $_schemaVersion');
      _db.execute('COMMIT');
    }
  }

  final Database _db;

  @override
  List<String> load(MessageTable table, String scope, String conversation) => [
    for (final row in _db.select(
      'SELECT json FROM ${table.sql} WHERE scope = ? AND conversation = ? '
      'ORDER BY position',
      [scope, conversation],
    ))
      row['json'] as String,
  ];

  void _write(
    MessageTable table,
    String scope,
    String conversation,
    List<String> rows,
  ) {
    _db.execute(
      'DELETE FROM ${table.sql} WHERE scope = ? AND conversation = ?',
      [scope, conversation],
    );
    final insert = _db.prepare(
      'INSERT INTO ${table.sql} (scope, conversation, position, json) '
      'VALUES (?, ?, ?, ?)',
    );
    try {
      for (var i = 0; i < rows.length; i++) {
        insert.execute([scope, conversation, i, rows[i]]);
      }
    } finally {
      insert.close();
    }
  }

  int _count(MessageTable table, String scope, String conversation) =>
      _db.select(
            'SELECT COUNT(*) AS n FROM ${table.sql} '
            'WHERE scope = ? AND conversation = ?',
            [scope, conversation],
          ).single['n']
          as int;

  T _transaction<T>(T Function() body) {
    _db.execute('BEGIN IMMEDIATE');
    try {
      final result = body();
      _db.execute('COMMIT');
      return result;
    } catch (_) {
      _db.execute('ROLLBACK');
      rethrow;
    }
  }

  @override
  void replace(
    MessageTable table,
    String scope,
    String conversation,
    List<String> rows,
  ) => _transaction(() => _write(table, scope, conversation, rows));

  @override
  void clear(MessageTable table, String scope, String conversation) =>
      _db.execute(
        'DELETE FROM ${table.sql} WHERE scope = ? AND conversation = ?',
        [scope, conversation],
      );

  @override
  void clearScope(MessageTable table, String scope) =>
      _db.execute('DELETE FROM ${table.sql} WHERE scope = ?', [scope]);

  @override
  bool isMigrated(String scope) =>
      _db.select('SELECT 1 FROM migrated WHERE scope = ?', [scope]).isNotEmpty;

  @override
  bool importScope(
    String scope, {
    required Map<String, List<String>> direct,
    required Map<String, List<String>> channel,
  }) {
    try {
      return _transaction(() {
        for (final (table, conversations) in [
          (MessageTable.direct, direct),
          (MessageTable.channel, channel),
        ]) {
          for (final MapEntry(key: conversation, value: rows)
              in conversations.entries) {
            _write(table, scope, conversation, rows);
            if (_count(table, scope, conversation) != rows.length) {
              throw StateError('count mismatch in $conversation');
            }
          }
        }
        _db.execute(
          'INSERT OR REPLACE INTO migrated (scope, at) VALUES (?, ?)',
          [scope, DateTime.now().millisecondsSinceEpoch],
        );
        return true;
      });
    } catch (e) {
      appLogger.error('Message migration for $scope rolled back: $e');
      return false;
    }
  }

  @override
  void close() => _db.close();
}
