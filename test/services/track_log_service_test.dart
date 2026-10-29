import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/models/track_log.dart';
import 'package:meshcore_open/services/track_log_service.dart';

class _Radio extends MeshCoreConnector {
  double? lat;
  double? lon;
  @override
  double? get selfLatitude => lat;
  @override
  double? get selfLongitude => lon;

  /// The connector batches change notifications on a short timer, so wait
  /// for it to deliver.
  Future<void> moveTo(double la, double lo) async {
    lat = la;
    lon = lo;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 200));
  }
}

class _MemoryStorage implements TrackLogStorage {
  String? data;
  @override
  Future<String?> read() async => data;
  @override
  Future<void> write(String d) async => data = d;
}

void main() {
  late _Radio radio;
  late _MemoryStorage storage;
  late DateTime now;
  late TrackLogService log;

  setUp(() {
    radio = _Radio();
    storage = _MemoryStorage();
    now = DateTime.utc(2026, 10, 28, 12);
    log = TrackLogService(radio, storage: storage, clock: () => now);
  });
  tearDown(() => log.dispose());

  test('records sparse points only while recording', () async {
    await radio.moveTo(47.6, -122.3); // before Start: ignored
    await log.start();
    expect(log.recording!.points, hasLength(1)); // where we started
    now = now.add(const Duration(minutes: 1));
    await radio.moveTo(47.6001, -122.3); // ~11 m: too small
    expect(log.recording!.points, hasLength(1));
    now = now.add(const Duration(minutes: 1));
    await radio.moveTo(47.601, -122.3); // ~111 m
    expect(log.recording!.points, hasLength(2));
    now = now.add(const Duration(minutes: 16));
    await radio.moveTo(47.601, -122.3); // standing still for a while
    expect(log.recording!.points, hasLength(3));
    await log.stop();
    await radio.moveTo(48.0, -122.0);
    expect(log.tracks.single.points, hasLength(3));
    expect(log.tracks.single.distanceKm, closeTo(0.111, 0.01));
  });

  test('no GPS position means no points', () async {
    await radio.moveTo(0, 0);
    await log.start();
    expect(log.hasPosition, isFalse);
    expect(log.recording!.points, isEmpty);
  });

  test('saves and reloads tracks, settings and a running recording', () async {
    await radio.moveTo(47.6, -122.3);
    await log.setSnapToGrid(true);
    await log.start();
    final again = TrackLogService(radio, storage: storage, clock: () => now);
    addTearDown(again.dispose);
    await again.load();
    expect(again.snapToGrid, isTrue);
    expect(again.isRecording, isTrue);
    expect(again.tracks.single.points, hasLength(1));
  });

  test('snapping rounds to the middle of a ~100 m square', () {
    final a = snapToGridCenter(47.60001, -122.30001, 100);
    final b = snapToGridCenter(47.60030, -122.30030, 100);
    expect(a, b);
    expect(
      const Distance().as(LengthUnit.Meter, a, const LatLng(47.6, -122.3)),
      lessThan(100),
    );
  });

  test('GPX holds every point in one track segment', () {
    final track = Track(
      id: '1',
      started: DateTime.utc(2026, 10, 28),
      points: [
        TrackPoint(at: DateTime.utc(2026, 10, 28), lat: 47.6, lon: -122.3),
        TrackPoint(
          at: DateTime.utc(2026, 10, 28, 0, 5),
          lat: 47.61,
          lon: -122.3,
        ),
      ],
    );
    final gpx = trackToGpx(track, name: 'Test');
    expect('<trkpt'.allMatches(gpx), hasLength(2));
    expect(gpx, contains('<name>Test</name>'));
  });
}
