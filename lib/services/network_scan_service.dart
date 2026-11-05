import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../models/network_scan.dart';
import '../models/radio_settings.dart';
import '../storage/prefs_manager.dart';
import '../utils/app_logger.dart';

/// Why a scan can't start, or stopped early.
enum ScanBlock { none, noRadio, noSettings, sos, trip }

/// Finds MeshCore networks nearby by scanning: the radio switches to each
/// target's settings in turn, listens, and switches back to your own
/// network at the end. A LoRa radio only hears packets sent with exactly
/// its own settings, so this is the only way to hear other networks over
/// the air. Everything heard goes in a log with the time and place.
///
/// While scanning you're off your own mesh, so a scan won't start, and
/// stops at the next step, during an SOS or an active trip. The radio's
/// auto-add of contacts is off during a scan, so nodes on other networks
/// don't fill your contacts. Your settings are saved before the first
/// switch and put back the next time the radio connects if the app closes
/// mid-scan.
class NetworkScanService extends ChangeNotifier {
  NetworkScanService(
    this.connector, {
    bool Function()? sosActive,
    bool Function()? tripActive,
    Future<({double lat, double lon})?> Function()? locate,
    DateTime Function()? clock,
    this.settleTime = const Duration(milliseconds: 800),
  }) : _sosActive = sosActive ?? (() => false),
       _tripActive = tripActive ?? (() => false),
       _locate = locate,
       _now = clock ?? DateTime.now {
    connector.addListener(_onConnector);
  }

  final MeshCoreConnector connector;
  final bool Function() _sosActive;
  final bool Function() _tripActive;
  final Future<({double lat, double lon})?> Function()? _locate;
  final DateTime Function() _now;

  /// Time after a switch before packets count, so a packet that was
  /// arriving on the old settings isn't credited to the new ones.
  final Duration settleTime;

  static const _logKey = 'notoryx_network_log_v1';
  static const _savedKey = 'notoryx_saved_networks_v1';
  static const _restoreKey = 'notoryx_network_scan_restore_v1';
  static const maxLog = 1000;

  /// Listening times to choose from, in seconds.
  static const dwells = [30, 45, 60, 90];

  List<NetworkSighting> _log = const [];
  List<ScanTarget> _saved = const [];
  bool _running = false;
  bool _cancel = false;
  Completer<void>? _wait;
  ScanTarget? _current;
  int _step = 0, _steps = 0;
  DateTime? _stepEndsAt;
  List<NetworkSighting> _lastResults = const [];
  ScanBlock _stoppedBy = ScanBlock.none;
  bool _restoring = false;
  bool _disposed = false;

  /// Every sighting, newest first.
  List<NetworkSighting> get log => _log;
  List<ScanTarget> get saved => _saved;
  bool get running => _running;
  ScanTarget? get current => _current;
  int get step => _step;
  int get steps => _steps;
  DateTime? get stepEndsAt => _stepEndsAt;

  /// What the last finished scan heard.
  List<NetworkSighting> get lastResults => _lastResults;

  /// Why the last scan stopped early; none when it finished or was
  /// cancelled.
  ScanBlock get stoppedBy => _stoppedBy;

  /// The radio's own settings, or null before the radio reports them.
  ScanTarget? get yourNetwork {
    final f = connector.currentFreqHz, b = connector.currentBwHz;
    final sf = connector.currentSf, cr = connector.currentCr;
    if (f == null || b == null || sf == null || cr == null) return null;
    return ScanTarget(name: '', freqKHz: f, bwHz: b, sf: sf, cr: cr);
  }

  ScanBlock get block {
    if (!connector.isConnected) return ScanBlock.noRadio;
    if (yourNetwork == null) return ScanBlock.noSettings;
    if (_sosActive()) return ScanBlock.sos;
    if (_tripActive()) return ScanBlock.trip;
    return ScanBlock.none;
  }

  void load() {
    final prefs = PrefsManager.instance;
    _log = [
      for (final s in _decodeList(prefs.getString(_logKey)))
        ?NetworkSighting.fromJson(s),
    ]..sort((a, b) => b.at.compareTo(a.at));
    _saved = [
      for (final t in _decodeList(prefs.getString(_savedKey)))
        ?ScanTarget.fromJson(t),
    ];
  }

  /// Fills the log and saved networks without touching storage, for
  /// previews and tests.
  @visibleForTesting
  void debugSeed({
    List<NetworkSighting> log = const [],
    List<ScanTarget> saved = const [],
  }) {
    _log = [...log]..sort((a, b) => b.at.compareTo(a.at));
    _saved = [...saved];
    _notify();
  }

  static List<Object?> _decodeList(String? raw) {
    if (raw == null) return const [];
    try {
      final data = jsonDecode(raw);
      return data is List ? data : const [];
    } catch (_) {
      return const [];
    }
  }

  /// Presets in the same band as your radio (for example 902–928 MHz),
  /// then your saved networks, without duplicates or your own settings.
  List<ScanTarget> suggestedTargets() {
    final own = yourNetwork;
    final band = own == null ? null : _bandOf(own.freqKHz);
    final seen = <String>{?own?.signature};
    return [
      for (final (name, s) in RadioSettings.presets)
        if (band != null && _bandOf(s.frequencyHz) == band)
          if (seen.add(ScanTarget.fromPreset(name, s).signature))
            ScanTarget.fromPreset(name, s),
      for (final t in _saved)
        if (seen.add(t.signature)) t,
    ];
  }

  /// Every preset and saved network, for picking by hand.
  List<ScanTarget> allTargets() {
    final seen = <String>{};
    return [
      for (final (name, s) in RadioSettings.presets)
        if (seen.add(ScanTarget.fromPreset(name, s).signature))
          ScanTarget.fromPreset(name, s),
      for (final t in _saved)
        if (seen.add(t.signature)) t,
    ];
  }

  static const _bands = [
    (144000, 148000),
    (420000, 450000),
    (862000, 876000),
    (902000, 928000),
    (2400000, 2500000),
  ];

  static int? _bandOf(int freqKHz) {
    for (var i = 0; i < _bands.length; i++) {
      if (freqKHz >= _bands[i].$1 && freqKHz <= _bands[i].$2) return i;
    }
    return null;
  }

  /// Listens on each of [targets] for [dwell], then puts the radio back on
  /// its own settings. Returns what was heard.
  Future<List<NetworkSighting>> scan(
    List<ScanTarget> targets, {
    Duration dwell = const Duration(seconds: 45),
  }) async {
    if (_running) return const [];
    if (block != ScanBlock.none) {
      _stoppedBy = block;
      _notify();
      return const [];
    }
    final own = yourNetwork!;
    final list = [
      for (final t in targets)
        if (t.isValid && !t.sameSettings(own)) t,
    ];
    if (list.isEmpty) return const [];

    _running = true;
    _cancel = false;
    _stoppedBy = ScanBlock.none;
    _steps = list.length;
    _step = 0;
    _notify();

    await PrefsManager.instance.setString(
      _restoreKey,
      jsonEncode(own.toJson()),
    );
    final autoAdd = _autoAddState();
    final results = <NetworkSighting>[];
    SightingBuilder? builder;
    var countFrom = _now();
    final sub = connector.rxPackets.listen((p) {
      final heard = builder;
      if (heard == null || p.fromSelf) return;
      if (p.receivedAt.isBefore(countFrom)) return;
      heard.add(p.raw, p.snr, p.rssi);
    });
    try {
      if (autoAdd != null && autoAdd.anyOn) {
        await connector.sendFrame(_autoAddFrame(autoAdd, off: true));
      }
      for (final target in list) {
        final stop = _cancel ? ScanBlock.none : block;
        if (_cancel || stop != ScanBlock.none) {
          _stoppedBy = stop;
          break;
        }
        _step++;
        _current = target;
        builder = null;
        await _apply(target);
        countFrom = _now().add(settleTime);
        builder = SightingBuilder(target);
        _stepEndsAt = _now().add(dwell);
        _notify();
        await _sleep(dwell);
        final heard = builder;
        builder = null;
        if (heard.packets > 0) {
          final here = await _position();
          final s = heard.build(
            _now(),
            latitude: here?.lat,
            longitude: here?.lon,
          );
          if (s != null) {
            results.add(s);
            _log = [s, ..._log].take(maxLog).toList();
            _notify();
          }
        }
      }
    } catch (e) {
      appLogger.warn('Network scan stopped: $e', tag: 'NetworkScan');
    } finally {
      builder = null;
      await sub.cancel();
      await _restore(own);
      if (autoAdd != null && autoAdd.anyOn && connector.isConnected) {
        try {
          await connector.sendFrame(_autoAddFrame(autoAdd, off: false));
        } catch (_) {}
      }
      _running = false;
      _current = null;
      _stepEndsAt = null;
      _lastResults = results;
      await _saveLog();
      _notify();
    }
    return results;
  }

  void cancel() {
    if (!_running) return;
    _cancel = true;
    _wait?.complete();
    _wait = null;
    _notify();
  }

  Future<void> _sleep(Duration d) async {
    final wait = Completer<void>();
    _wait = wait;
    final timer = Timer(d, () {
      if (!wait.isCompleted) wait.complete();
    });
    await wait.future;
    timer.cancel();
    if (identical(_wait, wait)) _wait = null;
  }

  Future<void> _apply(ScanTarget t) => connector.sendFrame(
    buildSetRadioParamsFrame(t.freqKHz, t.bwHz, t.sf, t.cr),
  );

  /// Puts the radio back on [own] and forgets the saved copy once that
  /// worked. If the radio is gone, the copy stays for the next connect.
  Future<void> _restore(ScanTarget own) async {
    if (!connector.isConnected) return;
    try {
      await _apply(own);
      await PrefsManager.instance.remove(_restoreKey);
      await connector.refreshDeviceInfo();
    } catch (e) {
      appLogger.warn(
        'Could not restore radio settings: $e',
        tag: 'NetworkScan',
      );
    }
  }

  /// After a scan the app couldn't finish, puts the radio back as soon as
  /// it reconnects and reports its settings.
  void _onConnector() {
    if (_running || _restoring || _disposed) return;
    final raw = PrefsManager.instance.getString(_restoreKey);
    if (raw == null) return;
    final now = yourNetwork;
    if (!connector.isConnected || now == null) return;
    ScanTarget? own;
    try {
      own = ScanTarget.fromJson(jsonDecode(raw));
    } catch (_) {}
    if (own == null) {
      unawaited(PrefsManager.instance.remove(_restoreKey));
      return;
    }
    if (own.sameSettings(now)) {
      unawaited(PrefsManager.instance.remove(_restoreKey));
      return;
    }
    _restoring = true;
    unawaited(
      _restore(own).whenComplete(() {
        _restoring = false;
      }),
    );
  }

  /// Joins [target]: sets the radio to it and keeps your transmit power.
  Future<void> join(ScanTarget target) async {
    if (!connector.isConnected) throw StateError('Connect your radio first.');
    await _apply(target);
    await connector.refreshDeviceInfo();
  }

  Future<void> saveNetwork(ScanTarget t) async {
    _saved = [
      for (final s in _saved)
        if (!s.sameSettings(t)) s,
      t,
    ];
    await _persistSaved();
    _notify();
  }

  Future<void> removeSaved(ScanTarget t) async {
    _saved = [
      for (final s in _saved)
        if (!s.sameSettings(t)) s,
    ];
    await _persistSaved();
    _notify();
  }

  bool isSaved(ScanTarget t) => _saved.any((s) => s.sameSettings(t));

  Future<void> clearLog() async {
    _log = const [];
    await _saveLog();
    _notify();
  }

  /// The latest sighting of each network, newest first.
  List<NetworkSighting> latestByNetwork() {
    final seen = <String>{};
    return [
      for (final s in _log)
        if (seen.add(s.target.signature)) s,
    ];
  }

  /// How many times [t] is in the log.
  int timesHeard(ScanTarget t) =>
      _log.where((s) => s.target.sameSettings(t)).length;

  Future<({double lat, double lon})?> _position() async {
    try {
      final custom = _locate;
      if (custom != null) return await custom();
      final last = await Geolocator.getLastKnownPosition();
      if (last != null &&
          _now().difference(last.timestamp) < const Duration(minutes: 5)) {
        return (lat: last.latitude, lon: last.longitude);
      }
      final p = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 8),
        ),
      );
      return (lat: p.latitude, lon: p.longitude);
    } catch (_) {
      final lat = connector.selfLatitude, lon = connector.selfLongitude;
      if (lat == null || lon == null || (lat == 0 && lon == 0)) return null;
      return (lat: lat, lon: lon);
    }
  }

  ({bool users, bool repeaters, bool rooms, bool sensors, bool overwrite})?
  _autoAddState() {
    final u = connector.autoAddUsers, r = connector.autoAddRepeaters;
    final m = connector.autoAddRoomServers, s = connector.autoAddSensors;
    if (u == null || r == null || m == null || s == null) return null;
    return (
      users: u,
      repeaters: r,
      rooms: m,
      sensors: s,
      overwrite: connector.autoAddOverwriteOldest ?? false,
    );
  }

  static Uint8List _autoAddFrame(
    ({bool users, bool repeaters, bool rooms, bool sensors, bool overwrite})
    a, {
    required bool off,
  }) => buildSetAutoAddConfigFrame(
    autoAddChat: !off && a.users,
    autoAddRepeater: !off && a.repeaters,
    autoAddRoomServer: !off && a.rooms,
    autoAddSensor: !off && a.sensors,
    overwriteOldest: a.overwrite,
  );

  Future<void> _saveLog() => PrefsManager.instance.setString(
    _logKey,
    jsonEncode([for (final s in _log) s.toJson()]),
  );

  Future<void> _persistSaved() => PrefsManager.instance.setString(
    _savedKey,
    jsonEncode([for (final t in _saved) t.toJson()]),
  );

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _wait?.complete();
    connector.removeListener(_onConnector);
    super.dispose();
  }
}

extension
    on
        ({
          bool users,
          bool repeaters,
          bool rooms,
          bool sensors,
          bool overwrite,
        }) {
  bool get anyOn => users || repeaters || rooms || sensors;
}
