import 'dart:convert';

import '../../utils/app_logger.dart';
import '../prefs_manager.dart';
import 'message_db.dart';

final Map<String, Future<bool>> _imports = {};

/// Copies [scope]'s message history from SharedPreferences into [db] once,
/// and returns whether the database now holds it. The preference keys are
/// left in place, so an older build still finds its history.
Future<bool> ensureScopeImported(MessageDb db, String scope) {
  if (db.isMigrated(scope)) return Future.value(true);
  return _imports[scope] ??= Future(() {
    final ok = importScopeFromPrefs(db, scope);
    if (!ok) _imports.remove(scope);
    return ok;
  });
}

/// Forgets in-flight imports; for tests.
void resetImportsForTest() => _imports.clear();

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
