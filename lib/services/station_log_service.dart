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
  static const _autoKey = 'ham_automated_tx_log';

  final MeshCoreConnector _connector;
  final DateTime Function() _clock;
  final _subs = <StreamSubscription<Object>>[];
  List<StationLogEntry> _log = const [];
  List<AutomatedTransmission> _automated = const [];

  /// Entries, newest first.
  List<StationLogEntry> get entries => _log;

  /// Messages automation rules sent on air, newest first.
  List<AutomatedTransmission> get automated => _automated;

  /// Loads the saved log and starts logging.
  void start() {
    _load();
    _subs
      ..add(_connector.receivedDirectMessages.listen(_received))
      ..add(_connector.sentDirectMessages.listen(_sent));
  }

  void _load() {
    _loadAutomated();
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

  void _loadAutomated() {
    final stored = PrefsManager.instance.getString(_autoKey);
    if (stored == null) return;
    try {
      _automated = [
        for (final j in jsonDecode(stored) as List)
          ?AutomatedTransmission.fromJson(j),
      ];
    } catch (e) {
      appLogger.warn('Automated log unreadable, kept a copy: $e', tag: 'Ham');
      unawaited(
        PrefsManager.instance.setString('${_autoKey}_unreadable', stored),
      );
    }
  }

  /// Records a message an automation rule just sent on air.
  Future<void> recordAutomated({
    required String rule,
    required String to,
    required String text,
    required String station,
  }) {
    final entry = AutomatedTransmission(
      at: _clock().toUtc(),
      rule: rule,
      to: to,
      text: text,
      station: station.toUpperCase(),
      freqKhz: _connector.currentFreqHz,
    );
    final out = [entry, ..._automated];
    _automated = out.length > stationLogMax
        ? out.sublist(0, stationLogMax)
        : out;
    notifyListeners();
    return PrefsManager.instance.setString(
      _autoKey,
      jsonEncode([for (final e in _automated) e.toJson()]),
    );
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
    _automated = const [];
    notifyListeners();
    await PrefsManager.instance.remove(_prefKey);
    await PrefsManager.instance.remove(_autoKey);
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
