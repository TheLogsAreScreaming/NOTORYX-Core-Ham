import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../connector/meshcore_connector.dart';
import '../models/contact.dart';

class CoverageObservation {
  final DateTime timestamp;
  final String nodeKey;
  final String nodeName;
  final String nodeType;
  final int pathLength;
  final String pathHex;
  final double? nodeLatitude;
  final double? nodeLongitude;
  final double? recorderLatitude;
  final double? recorderLongitude;
  final int? rssiDbm;
  final double? snrDb;
  final int? noiseFloorDbm;
  final int? radioSnapshotAgeMs;
  final int? frequencyHz;
  final int? bandwidthHz;
  final int? spreadingFactor;
  final int? codingRate;
  final String transport;

  const CoverageObservation({
    required this.timestamp,
    required this.nodeKey,
    required this.nodeName,
    required this.nodeType,
    required this.pathLength,
    required this.pathHex,
    this.nodeLatitude,
    this.nodeLongitude,
    this.recorderLatitude,
    this.recorderLongitude,
    this.rssiDbm,
    this.snrDb,
    this.noiseFloorDbm,
    this.radioSnapshotAgeMs,
    this.frequencyHz,
    this.bandwidthHz,
    this.spreadingFactor,
    this.codingRate,
    required this.transport,
  });

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp.toIso8601String(),
        'node_key': nodeKey,
        'node_name': nodeName,
        'node_type': nodeType,
        'path_length': pathLength,
        'path_hex': pathHex,
        'node_latitude': nodeLatitude,
        'node_longitude': nodeLongitude,
        'recorder_latitude': recorderLatitude,
        'recorder_longitude': recorderLongitude,
        'rssi_dbm': rssiDbm,
        'snr_db': snrDb,
        'noise_floor_dbm': noiseFloorDbm,
        'radio_snapshot_age_ms': radioSnapshotAgeMs,
        'frequency_hz': frequencyHz,
        'bandwidth_hz': bandwidthHz,
        'spreading_factor': spreadingFactor,
        'coding_rate': codingRate,
        'transport': transport,
      };

  factory CoverageObservation.fromJson(Map<String, dynamic> json) {
    return CoverageObservation(
      timestamp: DateTime.parse(json['timestamp'] as String),
      nodeKey: (json['node_key'] as String?) ?? '',
      nodeName: (json['node_name'] as String?) ?? 'Unknown',
      nodeType: (json['node_type'] as String?) ?? 'Unknown',
      pathLength: (json['path_length'] as num?)?.toInt() ?? -1,
      pathHex: (json['path_hex'] as String?) ?? '',
      nodeLatitude: (json['node_latitude'] as num?)?.toDouble(),
      nodeLongitude: (json['node_longitude'] as num?)?.toDouble(),
      recorderLatitude: (json['recorder_latitude'] as num?)?.toDouble(),
      recorderLongitude: (json['recorder_longitude'] as num?)?.toDouble(),
      rssiDbm: (json['rssi_dbm'] as num?)?.toInt(),
      snrDb: (json['snr_db'] as num?)?.toDouble(),
      noiseFloorDbm: (json['noise_floor_dbm'] as num?)?.toInt(),
      radioSnapshotAgeMs: (json['radio_snapshot_age_ms'] as num?)?.toInt(),
      frequencyHz: (json['frequency_hz'] as num?)?.toInt(),
      bandwidthHz: (json['bandwidth_hz'] as num?)?.toInt(),
      spreadingFactor: (json['spreading_factor'] as num?)?.toInt(),
      codingRate: (json['coding_rate'] as num?)?.toInt(),
      transport: (json['transport'] as String?) ?? 'unknown',
    );
  }
}

class CoverageCaptureSession {
  final String id;
  final DateTime startedAt;
  final DateTime? endedAt;
  final List<CoverageObservation> observations;

  const CoverageCaptureSession({
    required this.id,
    required this.startedAt,
    this.endedAt,
    required this.observations,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'started_at': startedAt.toIso8601String(),
        'ended_at': endedAt?.toIso8601String(),
        'observations': observations.map((o) => o.toJson()).toList(),
      };
}

class CoverageCaptureService extends ChangeNotifier {
  static const _historyKey = 'bastion_coverage_sessions_v1';
  static const _activeKey = 'bastion_coverage_active_v1';
  static const _maxSavedSessions = 20;

  MeshCoreConnector? _connector;
  bool _recording = false;
  String? _sessionId;
  DateTime? _startedAt;
  DateTime? _endedAt;
  final List<CoverageObservation> _observations = [];
  final Map<String, DateTime> _lastCapturedSeen = {};
  Timer? _persistTimer;

  bool get recording => _recording;
  DateTime? get startedAt => _startedAt;
  DateTime? get endedAt => _endedAt;
  List<CoverageObservation> get observations =>
      List.unmodifiable(_observations);
  int get uniqueNodes => _observations.map((e) => e.nodeKey).toSet().length;

  void attach(MeshCoreConnector connector) {
    if (identical(_connector, connector)) return;
    _connector?.removeListener(_onConnectorChanged);
    _connector = connector;
    connector.addListener(_onConnectorChanged);
  }

  Future<void> start() async {
    final connector = _connector;
    if (connector == null || !connector.isConnected) {
      throw StateError('Connect a radio before starting coverage capture.');
    }
    _recording = true;
    _sessionId = const Uuid().v4();
    _startedAt = DateTime.now();
    _endedAt = null;
    _observations.clear();
    _lastCapturedSeen.clear();
    await _persistActive();
    notifyListeners();
    _onConnectorChanged();
  }

  Future<void> stop() async {
    if (!_recording) return;
    _recording = false;
    _endedAt = DateTime.now();
    _persistTimer?.cancel();
    _persistTimer = null;
    await _saveCompletedSession();
    await _clearActive();
    notifyListeners();
  }

  void _onConnectorChanged() {
    if (!_recording) return;
    final connector = _connector;
    final started = _startedAt;
    if (connector == null || started == null || !connector.isConnected) return;

    bool changed = false;
    for (final contact in connector.allContactsUnfiltered) {
      if (!contact.isActive) continue;
      if (contact.lastSeen.isBefore(started)) continue;
      final previous = _lastCapturedSeen[contact.publicKeyHex];
      if (previous != null && !contact.lastSeen.isAfter(previous)) continue;

      _lastCapturedSeen[contact.publicKeyHex] = contact.lastSeen;
      _observations.add(_buildObservation(connector, contact));
      changed = true;
    }

    if (changed) {
      _schedulePersist();
      notifyListeners();
    }
  }

  CoverageObservation _buildObservation(
    MeshCoreConnector connector,
    Contact contact,
  ) {
    final stats = connector.latestRadioStats;
    final now = DateTime.now();
    final statsAge = stats == null
        ? null
        : now.difference(stats.receivedAt).inMilliseconds.clamp(0, 1 << 31);
    final pathHex = contact.path
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join()
        .toUpperCase();

    return CoverageObservation(
      timestamp: now,
      nodeKey: contact.publicKeyHex,
      nodeName: contact.name,
      nodeType: contact.typeLabelRaw,
      pathLength: contact.pathLength,
      pathHex: pathHex,
      nodeLatitude: contact.latitude,
      nodeLongitude: contact.longitude,
      recorderLatitude: connector.selfLatitude,
      recorderLongitude: connector.selfLongitude,
      rssiDbm: stats?.lastRssiDbm,
      snrDb: stats?.lastSnrDb,
      noiseFloorDbm: stats?.noiseFloorDbm,
      radioSnapshotAgeMs: statsAge,
      frequencyHz: connector.currentFreqHz,
      bandwidthHz: connector.currentBwHz,
      spreadingFactor: connector.currentSf,
      codingRate: connector.currentCr,
      transport: connector.activeTransport.name,
    );
  }

  void _schedulePersist() {
    _persistTimer?.cancel();
    _persistTimer = Timer(const Duration(seconds: 1), () {
      unawaited(_persistActive());
    });
  }

  Future<void> _persistActive() async {
    if (_sessionId == null || _startedAt == null) return;
    final prefs = await SharedPreferences.getInstance();
    final payload = CoverageCaptureSession(
      id: _sessionId!,
      startedAt: _startedAt!,
      endedAt: _endedAt,
      observations: List.of(_observations),
    ).toJson();
    await prefs.setString(_activeKey, jsonEncode(payload));
  }

  Future<void> _clearActive() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_activeKey);
  }

  Future<void> _saveCompletedSession() async {
    if (_sessionId == null || _startedAt == null) return;
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(_historyKey) ?? <String>[];
    final payload = jsonEncode(
      CoverageCaptureSession(
        id: _sessionId!,
        startedAt: _startedAt!,
        endedAt: _endedAt,
        observations: List.of(_observations),
      ).toJson(),
    );
    final updated = <String>[payload, ...existing];
    if (updated.length > _maxSavedSessions) {
      updated.removeRange(_maxSavedSessions, updated.length);
    }
    await prefs.setStringList(_historyKey, updated);
  }

  Future<String> exportJson() async {
    final file = await _createExportFile('json');
    final payload = CoverageCaptureSession(
      id: _sessionId ?? const Uuid().v4(),
      startedAt: _startedAt ?? DateTime.now(),
      endedAt: _endedAt,
      observations: List.of(_observations),
    ).toJson();
    await file.writeAsString(
      const JsonEncoder.withIndent('  ').convert(payload),
      flush: true,
    );
    return file.path;
  }

  Future<String> exportCsv() async {
    final file = await _createExportFile('csv');
    final out = StringBuffer();
    out.writeln(
      'timestamp,node_key,node_name,node_type,path_length,path_hex,'
      'node_latitude,node_longitude,recorder_latitude,recorder_longitude,'
      'rssi_dbm,snr_db,noise_floor_dbm,radio_snapshot_age_ms,'
      'frequency_hz,bandwidth_hz,spreading_factor,coding_rate,transport',
    );
    for (final o in _observations) {
      out.writeln([
        o.timestamp.toIso8601String(),
        o.nodeKey,
        o.nodeName,
        o.nodeType,
        o.pathLength,
        o.pathHex,
        o.nodeLatitude,
        o.nodeLongitude,
        o.recorderLatitude,
        o.recorderLongitude,
        o.rssiDbm,
        o.snrDb,
        o.noiseFloorDbm,
        o.radioSnapshotAgeMs,
        o.frequencyHz,
        o.bandwidthHz,
        o.spreadingFactor,
        o.codingRate,
        o.transport,
      ].map(_csv).join(','));
    }
    await file.writeAsString(out.toString(), flush: true);
    return file.path;
  }

  Future<File> _createExportFile(String extension) async {
    final dir = await getTemporaryDirectory();
    final stamp = (_startedAt ?? DateTime.now())
        .toIso8601String()
        .replaceAll(':', '-')
        .replaceAll('.', '-');
    return File('${dir.path}/bastion-coverage-$stamp.$extension');
  }

  String _csv(Object? value) {
    if (value == null) return '';
    final text = value.toString();
    if (!text.contains(',') && !text.contains('"') && !text.contains('\n')) {
      return text;
    }
    return '"${text.replaceAll('"', '""')}"';
  }

  @override
  void dispose() {
    _persistTimer?.cancel();
    _connector?.removeListener(_onConnectorChanged);
    super.dispose();
  }
}
