import 'dart:async';
import 'dart:convert';

import '../../utils/app_logger.dart';
import '../prefs_manager.dart';
import 'message_db.dart';

final Map<String, Future<bool>> _imports = {};

/// Copies [scope]'s message history from SharedPreferences into [db] once,
/// and returns whether the database now holds it. The preference keys are
/// left in place, so an older build still finds its history.
Future<bool> ensureScopeImported(MessageDb db, String scope) {
  if (db.isMigrated(scope)) {
    _purgeIfEncrypted(db, scope);
    return Future.value(true);
  }
  return _imports[scope] ??= Future(() {
    final ok = importScopeFromPrefs(db, scope);
    if (ok) {
      _purgeIfEncrypted(db, scope);
    } else {
      _imports.remove(scope);
    }
    return ok;
  });
}

final Set<String> _purged = {};

/// The import leaves the old preference keys for older builds, but those are
/// plaintext copies. Once the database is encrypted they must go.
void _purgeIfEncrypted(MessageDb db, String scope) {
  if (!db.isEncrypted || !_purged.add(scope)) return;
  final prefs = PrefsManager.instance;
  for (final key in prefs.getKeys().toList()) {
    final channel =
        key.startsWith('channel_messages_$scope') &&
        _channelIndex.hasMatch(key.substring('channel_messages_$scope'.length));
    final direct =
        key.startsWith('messages_$scope') &&
        _contactKey.hasMatch(key.substring('messages_$scope'.length));
    if (channel || direct) unawaited(prefs.remove(key));
  }
}

/// Forgets in-flight imports; for tests.
void resetImportsForTest() {
  _imports.clear();
  _purged.clear();
}

final _contactKey = RegExp(r'^[0-9a-fA-F]{64}$');
final _channelIndex = RegExp(r'^\d{1,3}$');

/// The synchronous import behind [ensureScopeImported].
bool importScopeFromPrefs(MessageDb db, String scope) {
  final prefs = PrefsManager.instance;
  final direct = <String, List<String>>{};
  final channel = <String, List<String>>{};
  final directPrefix = 'messages_$scope';
  final channelPrefix = 'channel_messages_$scope';
  var messages = 0;
  for (final key in prefs.getKeys()) {
    final String rest;
    final Map<String, List<String>> into;
    if (key.startsWith(channelPrefix)) {
      rest = key.substring(channelPrefix.length);
      if (!_channelIndex.hasMatch(rest)) continue;
      into = channel;
    } else if (key.startsWith(directPrefix)) {
      rest = key.substring(directPrefix.length);
      if (!_contactKey.hasMatch(rest)) continue;
      into = direct;
    } else {
      continue;
    }
    final raw = prefs.getString(key);
    if (raw == null || raw.isEmpty) continue;
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      into[rest] = [for (final m in list) jsonEncode(m)];
      messages += list.length;
    } catch (e) {
      // The old store read an unparsable value as empty; do the same.
      appLogger.warn('Skipping unreadable message history $key: $e');
    }
  }
  final ok = db.importScope(scope, direct: direct, channel: channel);
  if (ok) {
    appLogger.info(
      'Moved $messages messages in ${direct.length + channel.length} '
      'conversations to the message database',
    );
  }
  return ok;
}
