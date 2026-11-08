import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../connector/meshcore_connector.dart';
import '../models/contact.dart';
import '../models/message.dart';
import '../models/station_log.dart';
import '../storage/prefs_manager.dart';
import '../utils/amateur_radio.dart';
import '../utils/app_logger.dart';

/// Keeps the station log: every direct message sent to or received from a
/// station whose node name starts with a call sign. Stored on this device
/// only; nothing here is sent anywhere unless the user exports it.
class StationLogService extends ChangeNotifier {
  StationLogService(this._connector, {DateTime Function()? clock})
    : _clock = clock ?? DateTime.now;

  static const _prefKey = 'ham_station_log';

  final MeshCoreConnector _connector;
  final DateTime Function() _clock;
  final _subs = <StreamSubscription<Object>>[];
  List<StationLogEntry> _log = const [];

  /// Entries, newest first.
  List<StationLogEntry> get entries => _log;

  /// Loads the saved log and starts logging.
  void start() {
    _load();
    _subs
      ..add(_connector.receivedDirectMessages.listen(_received))
      ..add(_connector.sentDirectMessages.listen(_sent));
  }

  void _load() {
    final stored = PrefsManager.instance.getString(_prefKey);
    if (stored == null) return;
    try {
      _log = [
        for (final j in jsonDecode(stored) as List)
          ?StationLogEntry.fromJson(j),
      ];
    } catch (e) {
      // Set the unreadable copy aside before new entries replace it.
      appLogger.warn('Station log unreadable, kept a copy: $e', tag: 'Ham');
      unawaited(
        PrefsManager.instance.setString('${_prefKey}_unreadable', stored),
      );
    }
  }

  void _received(Message m) {
    if (m.isCli) return;
    final contact = _connector.getContactByPubKeyHex(m.senderKeyHex);
    if (contact != null) _record(contact, outgoing: false);
  }

  void _sent(Contact contact) => _record(contact, outgoing: true);

  void _record(Contact contact, {required bool outgoing}) {
    final call = callsignOf(contact.name);
    if (call == null) return;
    _log = logMessage(
      _log,
      call: call,
      at: _clock(),
      outgoing: outgoing,
      freqKhz: _connector.currentFreqHz,
    );
    notifyListeners();
    unawaited(_save());
  }

  /// Deletes every entry.
  Future<void> clear() async {
    _log = const [];
    notifyListeners();
    await PrefsManager.instance.remove(_prefKey);
  }

  Future<void> _save() => PrefsManager.instance.setString(
    _prefKey,
    jsonEncode([for (final e in _log) e.toJson()]),
  );

  @override
  void dispose() {
    for (final s in _subs) {
      unawaited(s.cancel());
    }
    super.dispose();
  }
}
