import 'dart:async';

import '../utils/app_logger.dart';
import 'db/message_db.dart';
import 'prefs_manager.dart';

/// Preferences that hold sensitive values: contacts, channel keys, drafts,
/// waypoints and queued messages.
///
/// With encrypted history on they live in the encrypted database and leave
/// SharedPreferences. Otherwise, or if that database can't be opened, they
/// stay in SharedPreferences as before. Reads are synchronous, so callers
/// don't change: the values are held in memory after [initialize].
class SecurePrefs {
  SecurePrefs._();

  static final _sensitive = RegExp(
    r'^(contacts[0-9a-fA-F]{0,10}|channels[0-9a-fA-F]{0,10}|waypoints_v1|'
    r'offline_outbox_v1|draft_.*)$',
  );

  static MessageDb? _db;
  static Map<String, String>? _values;

  /// Whether [key] belongs in the encrypted store.
  static bool isSensitive(String key) => _sensitive.hasMatch(key);

  /// Whether values are currently kept in the encrypted database.
  static bool get isActive => _values != null;

  /// Call once at startup, after [PrefsManager.initialize].
  static Future<void> initialize() async {
    try {
      await attach(await MessageDb.ready);
    } catch (e) {
      appLogger.error('Encrypted settings unavailable: $e');
    }
  }

  /// Moves values to where the database's encryption state says they go.
  static Future<void> attach(MessageDb? db) async {
    _db = null;
    _values = null;
    if (db == null) return;
    if (db.isEncrypted) {
      await _moveIn(db);
    } else {
      await _moveOut(db);
    }
  }

  static Future<void> _moveIn(MessageDb db) async {
    final prefs = PrefsManager.instance;
    final plain = <String, String>{
      for (final key in prefs.getKeys())
        if (isSensitive(key) && prefs.get(key) is String)
          key: prefs.getString(key)!,
    };
    if (plain.isNotEmpty) {
      db.putSecrets(plain);
      final stored = db.loadSecrets();
      for (final entry in plain.entries) {
        if (stored[entry.key] != entry.value) {
          throw StateError('${entry.key} did not store correctly');
        }
      }
      // Only now is the plaintext copy safe to remove.
      for (final key in plain.keys) {
        await prefs.remove(key);
      }
    }
    _db = db;
    _values = db.loadSecrets();
  }

  /// Encryption was turned off: return values so nothing is stranded.
  static Future<void> _moveOut(MessageDb db) async {
    final stored = db.loadSecrets();
    if (stored.isEmpty) return;
    final prefs = PrefsManager.instance;
    for (final entry in stored.entries) {
      await prefs.setString(entry.key, entry.value);
    }
    db.clearSecrets();
  }

  static String? getString(String key) {
    final values = _values;
    if (values != null && isSensitive(key)) return values[key];
    return PrefsManager.instance.getString(key);
  }

  static Future<void> setString(String key, String value) async {
    final values = _values;
    if (values != null && isSensitive(key)) {
      values[key] = value;
      _db!.putSecrets({key: value});
      return;
    }
    await PrefsManager.instance.setString(key, value);
  }

  static Future<void> remove(String key) async {
    final values = _values;
    if (values != null && isSensitive(key)) {
      values.remove(key);
      _db!.removeSecret(key);
      return;
    }
    await PrefsManager.instance.remove(key);
  }

  /// Everything held in the encrypted store, for an encrypted backup.
  static Map<String, String> snapshot() => Map.of(_values ?? const {});

  /// Forgets the attached database; for tests.
  static void resetForTest() {
    _db = null;
    _values = null;
  }
}
