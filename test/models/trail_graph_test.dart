import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:meshcore_open/models/trail_graph.dart';
import 'package:meshcore_open/services/trail_store.dart';

Map<String, dynamic> way(
  List<int> nodes,
  List<List<double>> points, {
  Map<String, String> tags = const {'highway': 'path'},
}) => {
  'type': 'way',
  'tags': tags,
  'nodes': nodes,
  'geometry': [
    for (final p in points) {'lat': p[0], 'lon': p[1]},
  ],
};

// Two ways from A to D: short through B, long through C.
final _diamond = {
  'elements': [
    way(
      [1, 2, 4],
      [
        [40.0, -74.0],
        [40.001, -74.0],
        [40.002, -74.0],
      ],
    ),
    way(
      [1, 3, 4],
      [
        [40.0, -74.0],
        [40.001, -73.98],
        [40.002, -74.0],
      ],
    ),
  ],
};

void main() {
  final graph = TrailGraph.fromOverpass(_diamond);

  test('takes the shorter of two ways', () {
    final r = graph.route(40.0, -74.0, 40.002, -74.0);
    expect(r.problem, isNull);
    expect(r.points, hasLength(3));
    expect(r.points[1], (40.001, -74.0));
    expect(r.meters, closeTo(222, 2));
  });

  test('skips private ways and non-walkable roads', () {
    final g = TrailGraph.fromOverpass({
      'elements': [
        way(
          [1, 2],
          [
            [40.0, -74.0],
            [40.001, -74.0],
          ],
          tags: const {'highway': 'path', 'access': 'private'},
        ),
        way(
          [3, 4],
          [
            [41.0, -74.0],
            [41.001, -74.0],
          ],
          tags: const {'highway': 'motorway'},
        ),
        way(
          [5, 6],
          [
            [42.0, -74.0],
            [42.001, -74.0],
          ],
          tags: const {'highway': 'path', 'foot': 'no'},
        ),
      ],
    });
    expect(g.nodeCount, 0);
  });

  test('says when points are too far from a trail', () {
    expect(
      graph.route(41, -74, 40.002, -74).problem,
      TrailRouteProblem.startTooFar,
    );
    expect(graph.route(40, -74, 41, -74).problem, TrailRouteProblem.endTooFar);
  });

  test('says when trails do not join up', () {
    final g = TrailGraph.fromOverpass({
      'elements': [
        way(
          [1, 2],
          [
            [40.0, -74.0],
            [40.001, -74.0],
          ],
        ),
        way(
          [3, 4],
          [
            [40.0, -73.99],
            [40.001, -73.99],
          ],
        ),
      ],
    });
    expect(
      g.route(40.0, -74.0, 40.001, -73.99).problem,
      TrailRouteProblem.notConnected,
    );
  });

  test('saved bytes route the same', () {
    final back = TrailGraph.fromBytes(graph.toBytes());
    expect(back.nodeCount, graph.nodeCount);
    expect(back.route(40.0, -74.0, 40.002, -74.0).meters, closeTo(222, 2));
  });

  test('damaged bytes are refused', () {
    expect(() => TrailGraph.fromBytes([1, 2, 3]), throwsFormatException);
  });

  group('TrailStore', () {
    late Directory dir;
    const box = TrailBounds(
      south: 39.99,
      west: -74.01,
      north: 40.01,
      east: -73.97,
    );
    http.Client ok() =>
        MockClient((_) async => http.Response(jsonEncode(_diamond), 200));

    setUp(() async => dir = await Directory.systemTemp.createTemp('trails'));
    tearDown(() => dir.delete(recursive: true));

    test('saves, reloads and deletes an area', () async {
      final store = TrailStore(client: ok(), directory: dir);
      final area = await store.download('Test', box);
      final again = TrailStore(client: ok(), directory: dir);
      await again.load();
      expect(again.areas.single.name, 'Test');
      final g = await again.graphFor(again.areas.single);
      expect(g.nodeCount, 4);
      await store.delete(area.id);
      expect(store.areas, isEmpty);
      expect(dir.listSync(), isEmpty);
    });

    test(
      'refuses an area that is too big, without asking the server',
      () async {
        var asked = false;
        final store = TrailStore(
          client: MockClient((_) async {
            asked = true;
            return http.Response('{}', 200);
          }),
          directory: dir,
        );
        await expectLater(
          store.download(
            'Big',
            const TrailBounds(south: 39, west: -75, north: 41, east: -73),
          ),
          throwsA(
            isA<TrailDownloadException>().having(
              (e) => e.problem,
              'problem',
              TrailDownloadProblem.tooLarge,
            ),
          ),
        );
        expect(asked, isFalse);
      },
    );

    test('refuses past the storage limit and saves nothing', () async {
      final store = TrailStore(client: ok(), directory: dir, limitBytes: 1);
      await expectLater(
        store.download('Full', box),
        throwsA(
          isA<TrailDownloadException>().having(
            (e) => e.problem,
            'problem',
            TrailDownloadProblem.storageFull,
          ),
        ),
      );
      expect(dir.listSync(), isEmpty);
    });

    test('a server error is reported', () async {
      final store = TrailStore(
        client: MockClient((_) async => http.Response('busy', 429)),
        directory: dir,
      );
      await expectLater(
        store.download('X', box),
        throwsA(isA<TrailDownloadException>()),
      );
    });

    test('finds the area holding both points', () async {
      final store = TrailStore(client: ok(), directory: dir);
      await store.download('Test', box);
      expect(store.areaFor(40, -74, 40.002, -74), isNotNull);
      expect(store.areaFor(40, -74, 45, -74), isNull);
    });
  });
}
