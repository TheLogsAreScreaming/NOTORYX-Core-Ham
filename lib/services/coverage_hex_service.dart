import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:h3_flutter/h3_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../connector/meshcore_connector.dart';
import '../helpers/path_helper.dart';
import '../models/coverage_hex.dart';
import '../models/direct_repeaters.dart';
import '../models/radio_rx_packet.dart';
import '../storage/prefs_manager.dart';
import '../utils/keys.dart';
import '../utils/platform_info.dart';
import 'network_monitor.dart';

/// Why mapping stopped or saved data was dropped, for the screen to word.
enum CoverageProblem { noPermission, noGps, loadFailed }

/// How the last upload to a map went.
sealed class CoverageUploadStatus {
  const CoverageUploadStatus();
}

class CoverageUploadSent extends CoverageUploadStatus {
  final int cells;
  final DateTime at;
  const CoverageUploadSent(this.cells, this.at);
}

class CoverageUploadRejected extends CoverageUploadStatus {
  final int statusCode;
  const CoverageUploadRejected(this.statusCode);
}

class CoverageUploadUnreachable extends CoverageUploadStatus {
  const CoverageUploadUnreachable();
}

/// Turns positions into coverage cells and back.
abstract class CellIndexer {
  String cellOf(double lat, double lon);
  ({double lat, double lon}) centerOf(String cell);
  List<({double lat, double lon})> boundaryOf(String cell);
}

/// [CellIndexer] on Uber's H3 grid, loaded on first use.
class H3CellIndexer implements CellIndexer {
  H3? _h3;
  H3 get _lib => _h3 ??= const H3Factory().load();

  @override
  String cellOf(double lat, double lon) => _lib
      .geoToCell(GeoCoord(lat: lat, lon: lon), coverageResolution)
      .toRadixString(16);

  @override
  ({double lat, double lon}) centerOf(String cell) {
    final c = _lib.cellToGeo(BigInt.parse(cell, radix: 16));
    return (lat: c.lat, lon: c.lon);
  }

  @override
  List<({double lat, double lon})> boundaryOf(String cell) => [
    for (final c in _lib.cellToBoundary(BigInt.parse(cell, radix: 16)))
      (lat: c.lat, lon: c.lon),
  ];
}

/// One phone GPS reading.
class PositionFix {
  final double lat;
  final double lon;
  final double accuracyMeters;
  final DateTime time;
  const PositionFix(this.lat, this.lon, this.accuracyMeters, this.time);
}

/// Where samples and upload progress are kept between launches.
abstract class CoverageStore {
  Future<String?> read();
  Future<void> write(String data);
}

class FileCoverageStore implements CoverageStore {
  Future<File> _file() async {
    final dir = await getApplicationSupportDirectory();
    return File('${dir.path}/coverage_hex.json');
  }

  @override
  Future<String?> read() async {
    if (PlatformInfo.isWeb) return null;
    final f = await _file();
    return await f.exists() ? f.readAsString() : null;
  }

  @override
  Future<void> write(String data) async {
    if (PlatformInfo.isWeb) return;
    final f = await _file();
    final tmp = File('${f.path}.tmp');
    await tmp.writeAsString(data, flush: true);
    await tmp.rename(f.path);
  }
}

/// Phone GPS while mapping is on: high accuracy, a reading every 20 m.
Stream<PositionFix> geolocatorFixes() async* {
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    throw StateError('Location permission was not granted.');
  }
  yield* Geolocator.getPositionStream(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 20,
    ),
  ).map((p) => PositionFix(p.latitude, p.longitude, p.accuracy, p.timestamp));
}

/// Coverage mapping: while on, every packet the radio hears is credited to
/// the hexagon the phone is in, and finished samples are uploaded to the
/// coverage maps you've added, each with its own privacy delay.
class CoverageHexService extends ChangeNotifier {
  CoverageHexService(
    this.connector, {
    CellIndexer? indexer,
    Stream<PositionFix> Function()? fixes,
    NetworkMonitor? network,
    CoverageStore? store,
    http.Client? client,
    DateTime Function()? clock,
  }) : _indexer = indexer ?? H3CellIndexer(),
       _fixes = fixes ?? geolocatorFixes,
       _network = network ?? ConnectivityNetworkMonitor(),
       _store = store ?? FileCoverageStore(),
       _client = client ?? http.Client(),
       _now = clock ?? DateTime.now;

  final MeshCoreConnector connector;
  final CellIndexer _indexer;
  final Stream<PositionFix> Function() _fixes;
  final NetworkMonitor _network;
  final CoverageStore _store;
  final http.Client _client;
  final DateTime Function() _now;

  static const _targetsKey = 'notoryx_coverage_targets_v1';
  static const _wifiOnlyKey = 'notoryx_coverage_wifi_only_v1';
  static const _signingKey = 'notoryx_coverage_signing_seed_v1';
  static const uploadEvery = Duration(minutes: 2);

  CoverageGrid _grid = CoverageGrid();
  final Map<String, Set<String>> _sent = {};
  List<CoverageTarget> _targets = [];
  final Map<String, CoverageUploadStatus> _targetStatus = {};
  bool _wifiOnly = true;
  bool _mapping = false;
  CoverageProblem? _problem;
  PositionFix? _fix;
  StreamSubscription<PositionFix>? _fixSub;
  StreamSubscription<RadioRxPacket>? _rxSub;
  Timer? _uploadTimer;
  Timer? _saveTimer;
  Future<void>? _uploading;
  bool _disposed = false;

  bool get mapping => _mapping;
  bool get wifiOnly => _wifiOnly;
  CoverageProblem? get problem => _problem;
  PositionFix? get fix => _fix;
  List<CoverageTarget> get targets => List.unmodifiable(_targets);
  CellIndexer get indexer => _indexer;

  /// Best SNR per cell, for the map.
  Map<String, double> get cells => _grid.bestByCell();
  int get sampleCount => _grid.samples.length;

  /// Last upload result for [targetId], or null before the first try.
  CoverageUploadStatus? statusOf(String targetId) => _targetStatus[targetId];

  /// Samples [target] will get once they're due.
  int pendingFor(CoverageTarget target) {
    final sent = _sent[target.id] ?? const {};
    return _grid.samples.values
        .where((s) => !sent.contains(s.key) && s.repeaters.isNotEmpty)
        .length;
  }

  Future<void> load() async {
    final prefs = PrefsManager.instance;
    _wifiOnly = prefs.getBool(_wifiOnlyKey) ?? true;
    try {
      final saved = prefs.getString(_targetsKey);
      if (saved != null) {
        _targets = [
          for (final t in jsonDecode(saved) as List)
            CoverageTarget.fromJson(t as Map<String, dynamic>),
        ];
      }
      final data = await _store.read();
      if (data != null) {
        final json = jsonDecode(data) as Map<String, dynamic>;
        _grid = CoverageGrid.fromJson(json['samples'] as List);
        (json['sent'] as Map<String, dynamic>? ?? {}).forEach(
          (k, v) => _sent[k] = {...(v as List).cast<String>()},
        );
      }
    } catch (_) {
      _problem = CoverageProblem.loadFailed;
    }
    _uploadTimer = Timer.periodic(uploadEvery, (_) => unawaited(upload()));
    _notify();
  }

  /// Starts or stops crediting heard packets to the phone's cell.
  Future<void> setMapping(bool on) async {
    if (on == _mapping) return;
    _mapping = on;
    _problem = null;
    if (on) {
      _fixSub = _fixes().listen(
        (fix) {
          _fix = fix;
          _notify();
        },
        onError: (Object e) {
          _problem = e is StateError
              ? CoverageProblem.noPermission
              : CoverageProblem.noGps;
          unawaited(setMapping(false));
        },
      );
      _rxSub = connector.rxPackets.listen(_onPacket);
    } else {
      await _fixSub?.cancel();
      await _rxSub?.cancel();
      _fixSub = null;
      _rxSub = null;
      _fix = null;
      await _save();
    }
    _notify();
  }

  void _onPacket(RadioRxPacket packet) {
    final fix = _fix;
    if (fix == null || packet.fromSelf) return;
    if (fix.accuracyMeters > maxFixAccuracyMeters) return;
    if (packet.receivedAt.difference(fix.time).abs() > maxFixAge) return;
    final heard = heardDirectlyFrom(packet.raw);
    _grid.record(
      cell: _indexer.cellOf(fix.lat, fix.lon),
      time: packet.receivedAt,
      snr: packet.snr,
      rssi: packet.rssi,
      repeater: heard == null ? null : PathHelper.formatHopHex(heard),
    );
    _scheduleSave();
    _notify();
  }

  @visibleForTesting
  void recordForTesting(RadioRxPacket packet) => _onPacket(packet);

  @visibleForTesting
  set fixForTesting(PositionFix fix) => _fix = fix;

  Future<void> setWifiOnly(bool value) async {
    _wifiOnly = value;
    _notify();
    await PrefsManager.instance.setBool(_wifiOnlyKey, value);
  }

  Future<void> saveTarget(CoverageTarget target) async {
    final i = _targets.indexWhere((t) => t.id == target.id);
    _targets = [..._targets];
    if (i < 0) {
      _targets.add(target);
    } else {
      _targets[i] = target;
    }
    await _saveTargets();
  }

  Future<void> removeTarget(String id) async {
    _targets = _targets.where((t) => t.id != id).toList();
    _sent.remove(id);
    _targetStatus.remove(id);
    await _saveTargets();
    await _save();
  }

  static String newTargetId() => const Uuid().v4();

  Future<void> _saveTargets() async {
    _notify();
    await PrefsManager.instance.setString(
      _targetsKey,
      jsonEncode(_targets.map((t) => t.toJson()).toList()),
    );
  }

  /// Sends every due sample to every enabled target. Samples stay queued
  /// for a target until it accepts them, so nothing is lost offline. A run
  /// already in progress is shared.
  Future<void> upload() =>
      _uploading ??= _upload().whenComplete(() => _uploading = null);

  Future<void> _upload() async {
    if (_disposed) return;
    final targets = _targets.where((t) => t.enabled).toList();
    if (targets.isEmpty) return;
    final net = await _network.current();
    if (!net.available) return;
    if (_wifiOnly &&
        !net.kinds.contains('wifi') &&
        !net.kinds.contains('ethernet') &&
        !net.kinds.contains('unknown')) {
      return;
    }
    final now = _now();
    _grid.prune(now);
    for (final target in targets) {
      final sent = _sent.putIfAbsent(target.id, () => {});
      final due = _grid.samples.values
          .where(
            (s) =>
                s.repeaters.isNotEmpty &&
                !sent.contains(s.key) &&
                s.dueFor(target.privacy, now),
          )
          .toList();
      for (var i = 0; i < due.length; i += 50) {
        final batch = due.sublist(i, (i + 50).clamp(0, due.length));
        final ok = await _post(target, batch);
        if (!ok) break;
        sent.addAll(batch.map((s) => s.key));
      }
    }
    final live = _grid.samples.keys.toSet();
    for (final keys in _sent.values) {
      keys.retainWhere(live.contains);
    }
    await _save();
    _notify();
  }

  Future<bool> _post(CoverageTarget target, List<HexSample> batch) async {
    final body = jsonEncode(switch (target.format) {
      CoverageFormat.hexagons => hexagonPayload(batch, target.privacy),
      CoverageFormat.meshMapper => meshMapperPayload(
        batch,
        target.privacy,
        _indexer.centerOf,
      ),
    });
    final headers = {
      'Content-Type': 'application/json',
      if (target.apiKey.isNotEmpty) 'X-API-Key': target.apiKey,
      // Anonymous uploads carry no key, so they can't be linked together.
      if (target.privacy != CoveragePrivacy.anonymous) ...await _sign(body),
    };
    try {
      final res = await _client
          .post(Uri.parse(target.url), headers: headers, body: body)
          .timeout(const Duration(seconds: 10));
      final ok = res.statusCode >= 200 && res.statusCode < 300;
      _targetStatus[target.id] = ok
          ? CoverageUploadSent(batch.length, _now())
          : CoverageUploadRejected(res.statusCode);
      return ok;
    } catch (_) {
      _targetStatus[target.id] = const CoverageUploadUnreachable();
      return false;
    }
  }

  SimpleKeyPair? _keyPair;

  /// Headers proving uploads come from the same (pseudonymous) mapper,
  /// signed with a key used only for coverage, never the radio identity.
  Future<Map<String, String>> _sign(String body) async {
    final algo = Ed25519();
    var keys = _keyPair;
    if (keys == null) {
      final prefs = PrefsManager.instance;
      final saved = prefs.getString(_signingKey);
      final List<int> seed;
      if (saved != null) {
        seed = base64Decode(saved);
      } else {
        seed = randomBytes(32);
        await prefs.setString(_signingKey, base64Encode(seed));
      }
      keys = _keyPair = await algo.newKeyPairFromSeed(seed);
    }
    final sig = await algo.sign(utf8.encode(body), keyPair: keys);
    final pub = await keys.extractPublicKey();
    return {
      'X-Notoryx-Key': base64Encode(pub.bytes),
      'X-Notoryx-Signature': base64Encode(sig.bytes),
    };
  }

  void _scheduleSave() {
    _saveTimer ??= Timer(const Duration(seconds: 20), () {
      _saveTimer = null;
      unawaited(_save());
    });
  }

  Future<void> _save() async {
    _saveTimer?.cancel();
    _saveTimer = null;
    try {
      await _store.write(
        jsonEncode({
          'samples': _grid.toJson(),
          'sent': _sent.map((k, v) => MapEntry(k, v.toList())),
        }),
      );
    } catch (_) {
      // A failed save keeps the samples in memory; the next save retries.
    }
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _uploadTimer?.cancel();
    _saveTimer?.cancel();
    unawaited(_fixSub?.cancel());
    unawaited(_rxSub?.cancel());
    _client.close();
    super.dispose();
  }
}
