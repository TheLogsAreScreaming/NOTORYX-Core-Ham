import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../models/regional_preset.dart';
import '../storage/prefs_manager.dart';
import 'notification_service.dart';

/// Where the shared list lives; the app also bundles a copy. It is in the
/// public releases repository because this source repository is private.
const regionalPresetsUrl =
    'https://raw.githubusercontent.com/TheLogsAreScreaming/NOTORYX-Core-Ham-Releases/main/regional_presets.json';

/// Keeps the list of local mesh radio settings up to date, works out which
/// area the radio is in, and offers that area's settings when the radio
/// doesn't match them or the area changes them.
class RegionalPresetService extends ChangeNotifier {
  final MeshCoreConnector _connector;
  final http.Client _http;
  final Future<String> Function() _loadBundled;
  final Future<bool> Function(String message) _notify;
  final Future<LatLng?> Function() _phonePosition;

  /// The phone's last known position, used when the radio has none.
  LatLng? _phone;

  static const _cacheKey = 'regional_presets_cache';
  static const _selectedKey = 'regional_preset_selected';
  static const _dismissedKey = 'regional_preset_dismissed';
  static const _seenKey = 'regional_preset_seen';

  /// "auto" picks the area from the radio's position.
  static const auto = 'auto';

  List<RegionalPreset> presets = const [];
  DateTime? lastChecked;
  bool _disposed = false;
  Timer? _timer;

  RegionalPresetService(
    this._connector, {
    http.Client? httpClient,
    Future<String> Function()? loadBundled,
    Future<bool> Function(String message)? notify,
    Future<LatLng?> Function()? phonePosition,
  }) : _phonePosition = phonePosition ?? _lastKnownPhonePosition,
       _http = httpClient ?? http.Client(),
       _loadBundled =
           loadBundled ??
           (() => rootBundle.loadString('assets/regional_presets.json')),
       _notify = notify ?? NotificationService().showFieldAlert {
    _connector.addListener(_notifyListeners);
  }

  String? _pref(String key) {
    try {
      return PrefsManager.instance.getString(key);
    } on StateError {
      return null;
    }
  }

  Future<void> _setPref(String key, String value) async {
    try {
      await PrefsManager.instance.setString(key, value);
    } on StateError {
      // Storage not ready; the choice lasts for this session only.
    }
  }

  /// Loads the cached (or bundled) list, then checks GitHub now and every
  /// 12 hours.
  Future<void> start() async {
    final cached = _pref(_cacheKey);
    final fromCache = cached == null
        ? const <RegionalPreset>[]
        : parseRegionalPresets(cached);
    presets = fromCache.isNotEmpty
        ? fromCache
        : parseRegionalPresets(await _loadBundled());
    _notifyListeners();
    await _updatePhonePosition();
    unawaited(refresh());
    _timer = Timer.periodic(const Duration(hours: 12), (_) async {
      await _updatePhonePosition();
      unawaited(refresh());
    });
  }

  /// Fetches the latest list. Keeps the current one if offline or invalid.
  Future<void> refresh() async {
    try {
      final res = await _http
          .get(Uri.parse(regionalPresetsUrl))
          .timeout(const Duration(seconds: 15));
      if (res.statusCode != 200) return;
      final fresh = parseRegionalPresets(res.body);
      if (fresh.isEmpty) return;
      presets = fresh;
      lastChecked = DateTime.now();
      await _setPref(_cacheKey, res.body);
      await _announceChange();
      _notifyListeners();
    } catch (e) {
      debugPrint('Regional presets not refreshed: $e');
    }
  }

  /// "auto" or a preset id.
  String get selection => _pref(_selectedKey) ?? auto;

  Future<void> select(String idOrAuto) async {
    await _setPref(_selectedKey, idOrAuto);
    _notifyListeners();
  }

  /// The area in use: the chosen one, or the one around the radio.
  RegionalPreset? get active {
    final sel = selection;
    if (sel != auto) {
      for (final p in presets) {
        if (p.id == sel) return p;
      }
      return null;
    }
    final lat = _connector.selfLatitude, lon = _connector.selfLongitude;
    final radioKnown = lat != null && lon != null && !(lat == 0 && lon == 0);
    return presetForPosition(presets, radioKnown ? LatLng(lat, lon) : _phone);
  }

  Future<void> _updatePhonePosition() async {
    try {
      final p = await _phonePosition();
      if (p == null) return;
      _phone = p;
      _notifyListeners();
    } catch (e) {
      debugPrint('Phone position unavailable: $e');
    }
  }

  /// The phone's last known fix, only if location permission was already
  /// granted elsewhere in the app; this never asks for it.
  static Future<LatLng?> _lastKnownPhonePosition() async {
    final permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      return null;
    }
    final p = await Geolocator.getLastKnownPosition();
    return p == null ? null : LatLng(p.latitude, p.longitude);
  }

  RadioSettingsState get radio {
    final cr = _connector.currentCr;
    final bw = _connector.currentBwHz;
    return RadioSettingsState(
      frequencyMHz: radioFrequencyMHz(_connector.currentFreqHz),
      bandwidthKHz: bw == null ? null : bw / 1000,
      spreadingFactor: _connector.currentSf,
      // Older firmware reports 1–4 for 4/5–4/8.
      codingRate: cr == null ? null : (cr <= 4 ? cr + 4 : cr),
      pathHashBytes: _connector.isConnected
          ? _connector.pathHashByteWidth
          : null,
    );
  }

  /// What the radio would change to match the active area.
  List<String> get differences =>
      active?.differences(radio) ?? const <String>[];

  /// Whether to show the "your area uses…" banner.
  bool get shouldOffer {
    final p = active;
    if (p == null || !_connector.isConnected) return false;
    if (_pref(_dismissedKey) == p.signature) return false;
    return differences.isNotEmpty;
  }

  /// Hides the banner until the area changes its settings.
  Future<void> dismiss() async {
    final p = active;
    if (p == null) return;
    await _setPref(_dismissedKey, p.signature);
    _notifyListeners();
  }

  /// Sets the radio to [preset]: frequency, bandwidth, spreading factor and
  /// coding rate in one command, then the path hash mode when the preset
  /// knows it. Transmit power is left as it is.
  Future<void> apply(RegionalPreset preset) async {
    if (!_connector.isConnected) {
      throw StateError('Connect your radio first.');
    }
    await _connector.sendFrame(
      buildSetRadioParamsFrame(
        (preset.frequencyMHz * 1000).round(), // kHz
        (preset.bandwidthKHz * 1000).round(), // Hz
        preset.spreadingFactor,
        preset.codingRate,
      ),
    );
    final hash = preset.pathHashBytes;
    if (hash != null) await _connector.setPathHashMode(hash - 1);
    await _connector.refreshDeviceInfo();
    await _setPref(_seenKey, preset.signature);
    _notifyListeners();
  }

  /// A phone notification when the active area's settings change.
  Future<void> _announceChange() async {
    final p = active;
    if (p == null) return;
    final seen = _pref(_seenKey);
    if (seen == p.signature) return;
    await _setPref(_seenKey, p.signature);
    // The first time an area is seen isn't a change; only announce updates.
    if (seen == null || !seen.startsWith('${p.id}|')) return;
    await _notify('${p.name} mesh settings changed: ${p.summary}');
  }

  void _notifyListeners() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _timer?.cancel();
    _connector.removeListener(_notifyListeners);
    super.dispose();
  }
}
