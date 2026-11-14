import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/day_replay.dart';
import 'package:meshcore_open/services/position_history_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _d = DateTime(2026, 11, 13);
DateTime _t(int h, [int m = 0]) => DateTime(2026, 11, 13, h, m);

ReplayTrack _track(List<ReplayPoint> points) =>
    ReplayTrack(id: 'a', name: 'A', points: points);

class _Radio extends MeshCoreConnector {
  Contact node = _node(45.5, -122.6, _t(9));
  @override
  List<Contact> get allContacts => [node];
}

Contact _node(double lat, double lon, DateTime seen) => Contact(
  publicKey: Uint8List.fromList(List.filled(32, 0xAB)),
  name: 'Peak',
  type: advTypeChat,
  pathLength: 0,
  path: Uint8List(0),
  latitude: lat,
  longitude: lon,
  lastSeen: seen,
);

void main() {
  test('position at a time, trail and day cut', () {
    final t = _track([
      ReplayPoint(_t(8), 1, 1),
      ReplayPoint(_t(9), 2, 2),
      ReplayPoint(_t(10), 3, 3),
      ReplayPoint(_d.add(const Duration(days: 1, hours: 1)), 4, 4),
    ]);
    expect(t.at(_t(7)), isNull);
    expect(t.at(_t(9, 30))!.lat, 2);
    expect(t.at(_t(10))!.lat, 3);
    expect(t.trailUntil(_t(9, 30)).map((p) => p.lat), [1, 2]);
    expect(t.onDay(_d)!.points, hasLength(3));
    expect(replayDays([t]), [_d.add(const Duration(days: 1)), _d]);
    expect(replaySpan([t.onDay(_d)!]), (start: _t(8), end: _t(10)));
  });

  test('team tracks group posts by sender in time order', () {
    final tracks = teamTracks([
      (sender: 'Bo', lat: 2, lon: 2, at: _t(10)),
      (sender: 'Al', lat: 1, lon: 1, at: _t(9)),
      (sender: 'Bo', lat: 3, lon: 3, at: _t(8)),
    ]);
    final bo = tracks.firstWhere((t) => t.name == 'Bo');
    expect(bo.team, isTrue);
    expect(bo.points.map((p) => p.lat), [3, 2]);
  });

  group('position history', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      PrefsManager.reset();
      await PrefsManager.initialize();
    });
    tearDown(PrefsManager.reset);

    test('records moves and a still node every 10 minutes', () async {
      final radio = _Radio();
      final s = PositionHistoryService(
        radio,
        clock: () => _t(12),
        tick: Duration.zero,
      );
      await s.scan();
      await s.scan(); // Not heard again: nothing new.
      radio.node = _node(45.5, -122.6, _t(9, 5)); // Still, 5 min later.
      await s.scan();
      radio.node = _node(45.5, -122.6, _t(9, 11)); // Still, 11 min later.
      await s.scan();
      radio.node = _node(45.51, -122.6, _t(9, 12)); // Moved ~1 km.
      await s.scan();
      final track = s.tracks().single;
      expect(track.name, 'Peak');
      expect(track.points.map((p) => p.at), [_t(9), _t(9, 11), _t(9, 12)]);
      final again = PositionHistoryService(
        radio,
        clock: () => _t(12),
        tick: Duration.zero,
      );
      expect(again.tracks().single.points, hasLength(3));
      s.dispose();
      again.dispose();
      radio.dispose();
    });

    test('drops points older than 30 days', () async {
      final radio = _Radio();
      final s = PositionHistoryService(
        radio,
        clock: () => _t(9).add(const Duration(days: 31)),
        tick: Duration.zero,
      );
      await s.scan();
      expect(s.tracks(), isEmpty);
      s.dispose();
      radio.dispose();
    });
  });
}
