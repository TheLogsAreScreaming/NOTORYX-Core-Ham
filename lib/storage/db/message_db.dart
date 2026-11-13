import 'message_db_stub.dart'
    if (dart.library.ffi) 'message_db_native.dart'
    as impl;

/// Which conversation table a row belongs to.
enum MessageTable {
  direct('messages'),
  channel('channel_messages');

  const MessageTable(this.sql);
  final String sql;
}

/// Message history in SQLite: one row per message, keyed by the connected
/// radio (scope) and the conversation, holding the message's JSON. Absent on
/// web, where the stores keep using SharedPreferences.
/// Whether the message database file is encrypted on disk.
enum MessageDbEncryption {
  off,
  on,

  /// Encryption was asked for or is in place, but couldn't be applied or
  /// the key couldn't be read. The file is left as it was.
  failed,
}

abstract class MessageDb {
  /// The preference asking for an encrypted database; applied at startup.
  static const encryptPrefKey = 'message_db_encrypt';

  /// What the last open actually achieved.
  static MessageDbEncryption encryptionState = MessageDbEncryption.off;

  /// The open database, or null where SQLite isn't available or failed to
  /// open (the stores then fall back to SharedPreferences).
  static Future<MessageDb?> get ready => _ready ??= impl.openMessageDb();
  static Future<MessageDb?>? _ready;

  /// Uses a fresh in-memory database; for tests.
  static MessageDb? useInMemoryForTest() {
    final db = impl.openInMemoryMessageDb();
    _ready = Future.value(db);
    return db;
  }

  /// Acts as if SQLite were unavailable (as on web); for tests.
  static void useNoneForTest() => _ready = Future.value(null);

  /// Forgets the open database; for tests.
  static void resetForTest() => _ready = null;

  /// The rows of one conversation, oldest first.
  List<String> load(MessageTable table, String scope, String conversation);

  /// Replaces one conversation's rows in a single transaction.
  void replace(
    MessageTable table,
    String scope,
    String conversation,
    List<String> rows,
  );

  void clear(MessageTable table, String scope, String conversation);

  void clearScope(MessageTable table, String scope);

  /// Whether this database is encrypted on disk.
  bool get isEncrypted;

  /// Every stored sensitive setting.
  Map<String, String> loadSecrets();

  /// Adds or replaces [values] in one transaction.
  void putSecrets(Map<String, String> values);

  void removeSecret(String key);

  void clearSecrets();

  /// Whether [scope]'s SharedPreferences history has been copied in.
  bool isMigrated(String scope);

  /// Copies [scope]'s history in one transaction and marks it migrated,
  /// after checking every conversation reads back with the same number of
  /// rows. Returns false, writing nothing, if any count differs.
  bool importScope(
    String scope, {
    required Map<String, List<String>> direct,
    required Map<String, List<String>> channel,
  });

  void close();
}
