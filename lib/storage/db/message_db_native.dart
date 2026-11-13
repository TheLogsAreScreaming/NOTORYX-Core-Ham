import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../utils/app_logger.dart';
import 'message_db.dart';
import 'message_db_key.dart';

const _schemaVersion = 1;

Future<MessageDb?> openMessageDb() async {
  try {
    final dir = await getApplicationSupportDirectory();
    await dir.create(recursive: true);
    final prefs = await SharedPreferences.getInstance();
    return await openMessageDbFile(
      '${dir.path}${Platform.pathSeparator}messages.db',
      wantEncrypted: prefs.getBool(MessageDb.encryptPrefKey) ?? false,
      vault: SecureMessageDbKeyVault(),
    );
  } catch (e) {
    MessageDb.encryptionState = MessageDbEncryption.failed;
    appLogger.error('Message database unavailable, using preferences: $e');
    return null;
  }
}

MessageDb? openInMemoryMessageDb() =>
    _SqliteMessageDb(sqlite3.openInMemory(), isEncrypted: false);

/// Whether [file] has content that isn't a plain SQLite database.
Future<bool> _looksEncrypted(File file) async {
  if (!await file.exists() || await file.length() == 0) return false;
  final head = await file.openRead(0, 15).expand((b) => b).toList();
  return String.fromCharCodes(head) != 'SQLite format 3';
}

void _applyKey(Database db, String key) => db.execute("PRAGMA key = '$key'");

/// Throws unless the open database can really be read.
void _checkReadable(Database db) =>
    db.select('SELECT count(*) FROM sqlite_master');

/// Rewrites the open file under [key], or without a key when it's empty.
/// Encryption can't change while in WAL mode, and this also folds any
/// plaintext write-ahead log into the file and removes it.
void _rekey(Database db, String key) {
  db.execute('PRAGMA wal_checkpoint(TRUNCATE)');
  db.execute('PRAGMA journal_mode = DELETE');
  db.execute("PRAGMA rekey = '$key'");
}

/// Reads the vault's key, creating and storing one if needed, and confirms
/// it reads back before anything is encrypted with it.
Future<String> _keyFor(MessageDbKeyVault vault) async {
  final existing = await vault.read();
  if (existing != null) return existing;
  final key = generateMessageDbKey();
  await vault.write(key);
  if (await vault.read() != key) throw StateError('key did not persist');
  return key;
}

/// Opens the database at [path], encrypting or decrypting it first if that
/// differs from [wantEncrypted]. If a conversion fails the file stays as it
/// was. If an encrypted file's key can't be read this returns null and the
/// file is left alone, so the history isn't lost.
Future<MessageDb?> openMessageDbFile(
  String path, {
  required bool wantEncrypted,
  required MessageDbKeyVault vault,
}) async {
  final file = File(path);
  final existing = await file.exists() && await file.length() > 0;
  var encrypted = await _looksEncrypted(file);
  String? key;
  if (encrypted) {
    key = await vault.read();
    if (key == null) {
      MessageDb.encryptionState = MessageDbEncryption.failed;
      appLogger.error('Message database key is missing');
      return null;
    }
  }
  Database open() {
    final db = sqlite3.open(path);
    try {
      if (key != null) _applyKey(db, key);
      _checkReadable(db);
      return db;
    } catch (_) {
      db.close();
      rethrow;
    }
  }

  var failed = false;
  try {
    if (wantEncrypted && !encrypted) {
      final newKey = await _keyFor(vault);
      if (existing) {
        final db = open();
        try {
          _rekey(db, newKey);
        } finally {
          db.close();
        }
      }
      key = newKey;
      encrypted = true;
    } else if (!wantEncrypted && encrypted) {
      final db = open();
      try {
        _rekey(db, '');
      } finally {
        db.close();
      }
      key = null;
      encrypted = false;
      await vault.delete();
    }
  } catch (e) {
    failed = true;
    appLogger.error('Could not change message database encryption: $e');
  }
  final db = open();
  MessageDb.encryptionState = failed
      ? MessageDbEncryption.failed
      : encrypted
      ? MessageDbEncryption.on
      : MessageDbEncryption.off;
  return _SqliteMessageDb(db, isEncrypted: encrypted);
}

class _SqliteMessageDb implements MessageDb {
  _SqliteMessageDb(this._db, {required this.isEncrypted}) {
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
    _db.execute(
      'CREATE TABLE IF NOT EXISTS secure_kv (key TEXT PRIMARY KEY, '
      'value TEXT NOT NULL) WITHOUT ROWID',
    );
  }

  final Database _db;

  @override
  final bool isEncrypted;

  @override
  Map<String, String> loadSecrets() => {
    for (final row in _db.select('SELECT key, value FROM secure_kv'))
      row['key'] as String: row['value'] as String,
  };

  @override
  void putSecrets(Map<String, String> values) {
    _db.execute('BEGIN');
    try {
      for (final entry in values.entries) {
        _db.execute(
          'INSERT OR REPLACE INTO secure_kv (key, value) VALUES (?, ?)',
          [entry.key, entry.value],
        );
      }
      _db.execute('COMMIT');
    } catch (_) {
      _db.execute('ROLLBACK');
      rethrow;
    }
  }

  @override
  void removeSecret(String key) =>
      _db.execute('DELETE FROM secure_kv WHERE key = ?', [key]);

  @override
  void clearSecrets() => _db.execute('DELETE FROM secure_kv');

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
  Map<String, Map<String, List<String>>> exportTable(MessageTable table) {
    final out = <String, Map<String, List<String>>>{};
    for (final row in _db.select(
      'SELECT scope, conversation, json FROM ${table.sql} '
      'ORDER BY scope, conversation, position',
    )) {
      out
          .putIfAbsent(row['scope'] as String, () => {})
          .putIfAbsent(row['conversation'] as String, () => [])
          .add(row['json'] as String);
    }
    return out;
  }

  @override
  void replaceMany(List<ConversationRows> writes) => _transaction(() {
    for (final w in writes) {
      _write(w.table, w.scope, w.conversation, w.rows);
    }
  });

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
