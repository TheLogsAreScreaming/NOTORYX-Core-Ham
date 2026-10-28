import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../connector/meshcore_connector.dart';
import '../models/track_log.dart';
import '../utils/platform_info.dart';

/// Reads and writes the saved track log. The default keeps it in a file in
/// the app's documents folder; tests pass in memory.
abstract interface class TrackLogStorage {
  Future<String?> read();
  Future<void> write(String data);
}

class FileTrackLogStorage implements TrackLogStorage {
  Future<File> _file() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/track_log.json');
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

/// Records a breadcrumb trail from the position the radio reports (its GPS),
/// while a recording is running.
class TrackLogService extends ChangeNotifier {
  TrackLogService(
    this._connector, {
    TrackLogStorage? storage,
    this.recorder = const TrackRecorder(),
    DateTime Function()? clock,
  }) : _storage = storage ?? FileTrackLogStorage(),
       _now = clock ?? DateTime.now {
    _connector.addListener(_onConnectorChanged);
  }

  final MeshCoreConnector _connector;
  final TrackLogStorage _storage;
  final TrackRecorder recorder;
  final DateTime Function() _now;

  /// Oldest tracks are dropped beyond this many.
  static const maxTracks = 30;

  /// A running track stops taking points at this size.
  static const maxPointsPerTrack = 20000;

  /// Grid size used when [snapToGrid] is on.
  static const gridMeters = 100.0;

  List<Track> tracks = [];
  bool snapToGrid = false;
  String? _recordingId;
  bool _disposed = false;

  Track? get recording {
    for (final t in tracks) {
      if (t.id == _recordingId) return t;
    }
    return null;
  }

  bool get isRecording => recording != null;

  /// Whether the radio is reporting a position right now.
  bool get hasPosition {
    final lat = _connector.selfLatitude, lon = _connector.selfLongitude;
    return lat != null && lon != null && !(lat == 0 && lon == 0);
  }

  Future<void> load() async {
    try {
      final raw = await _storage.read();
      if (raw != null) {
        final doc = jsonDecode(raw) as Map<String, dynamic>;
        tracks = [
          for (final t in (doc['tracks'] as List? ?? const []))
            ?Track.fromJson(t),
        ];
        snapToGrid = doc['snapToGrid'] == true;
        final rec = doc['recording'];
        _recordingId = rec is String && tracks.any((t) => t.id == rec)
            ? rec
            : null;
      }
    } catch (e) {
      debugPrint('Track log not loaded: $e');
    }
    _notify();
  }

  Future<void> _save() async {
    try {
      await _storage.write(
        jsonEncode({
          'snapToGrid': snapToGrid,
          'recording': ?_recordingId,
          'tracks': [for (final t in tracks) t.toJson()],
        }),
      );
    } catch (e) {
      debugPrint('Track log not saved: $e');
    }
  }

  Future<void> start() async {
    if (isRecording) return;
    final now = _now();
    final track = Track(
      id: now.toUtc().millisecondsSinceEpoch.toString(),
      started: now,
    );
    tracks = [track, ...tracks];
    if (tracks.length > maxTracks) tracks = tracks.sublist(0, maxTracks);
    _recordingId = track.id;
    _addCurrentPosition();
    _notify();
    await _save();
  }

  Future<void> stop() async {
    final track = recording;
    if (track == null) return;
    track.ended = _now();
    _recordingId = null;
    _notify();
    await _save();
  }

  Future<void> delete(Track track) async {
    if (track.id == _recordingId) _recordingId = null;
    tracks = [
      for (final t in tracks)
        if (t.id != track.id) t,
    ];
    _notify();
    await _save();
  }

  Future<void> setSnapToGrid(bool on) async {
    snapToGrid = on;
    _notify();
    await _save();
  }

  void _onConnectorChanged() {
    if (isRecording && _addCurrentPosition()) {
      _notify();
      unawaited(_save());
    }
  }

  /// Adds the radio's position to the running track if the recorder wants
  /// it. Returns whether a point was added.
  bool _addCurrentPosition() {
    final track = recording;
    if (track == null || !hasPosition) return false;
    if (track.points.length >= maxPointsPerTrack) return false;
    var lat = _connector.selfLatitude!, lon = _connector.selfLongitude!;
    if (snapToGrid) {
      final s = snapToGridCenter(lat, lon, gridMeters);
      lat = s.latitude;
      lon = s.longitude;
    }
    final next = TrackPoint(at: _now(), lat: lat, lon: lon);
    final last = track.points.isEmpty ? null : track.points.last;
    if (!recorder.shouldRecord(last, next)) return false;
    track.points.add(next);
    return true;
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _connector.removeListener(_onConnectorChanged);
    super.dispose();
  }
}
