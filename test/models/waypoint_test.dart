import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/waypoint.dart';
import 'package:meshcore_open/screens/map_screen.dart' show parseMarkerText;
import 'package:meshcore_open/screens/waypoints_screen.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/services/waypoint_store.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const gpx = '''<?xml version="1.0" encoding="UTF-8"?>
<gpx version="1.1" creator="test" xmlns="http://www.topografix.com/GPX/1/1">
  <wpt lat="49.3500" lon="-123.1000"><ele>1200</ele><name>Hut</name><desc>Bunks for 8</desc></wpt>
  <wpt lat="49.3600" lon="-123.1100"></wpt>
  <wpt lat="95" lon="0"><name>Bad</name></wpt>
  <rte><name>Ridge walk</name>
    <rtept lat="49.30" lon="-123.10"/><rtept lat="49.31" lon="-123.11"/><rtept lat="49.32" lon="-123.12"/>
  </rte>
  <trk><name>Morning</name><trkseg>
    TRKPTS
  </trkseg></trk>
</gpx>''';

String withTrack(int n) => gpx.replaceFirst(
  'TRKPTS',
  [
    for (var i = 0; i < n; i++) '<trkpt lat="${49 + i / 10000}" lon="-123"/>',
  ].join(),
);

void main() {
  group('parseGpx', () {
    test('waypoints, routes and tracks', () {
      final r = parseGpx(withTrack(5));
      expect(r.waypoints.map((w) => w.name), ['Hut', 'Waypoint 2']);
      expect(r.waypoints.first.ele, 1200);
      expect(r.waypoints.first.note, 'Bunks for 8');
      expect(r.routes.map((x) => x.name), ['Ridge walk', 'Morning']);
      expect(r.routes.first.points, hasLength(3));
    });

    test('long tracks are thinned, keeping both ends', () {
      final r = parseGpx(withTrack(1000));
      final track = r.routes.last.points;
      expect(track, hasLength(maxRoutePoints));
      expect(track.first.lat, closeTo(49, 1e-9));
      expect(track.last.lat, closeTo(49 + 999 / 10000, 1e-9));
    });

    test('not GPX throws a FormatException', () {
      expect(() => parseGpx('hello'), throwsFormatException);
    });

    test('export and import round-trip', () {
      final first = parseGpx(withTrack(3));
      final again = parseGpx(toGpx(first.waypoints, first.routes));
      expect(again.waypoints.map((w) => w.name), ['Hut', 'Waypoint 2']);
      expect(again.routes, hasLength(2));
      expect(again.waypoints.first.lat, closeTo(49.35, 1e-9));
    });
  });

  test('marker text is what the map understands', () {
    const w = Waypoint(id: '1', name: 'Hut | north', lat: 49.35, lon: -123.1);
    final parsed = parseMarkerText(w.toMarkerText())!;
    expect(parsed.label, 'Hut / north');
    expect(parsed.position.latitude, closeTo(49.35, 1e-6));
  });

  test('route length', () {
    const a = Waypoint(id: 'a', name: 'a', lat: 0, lon: 0);
    const b = Waypoint(id: 'b', name: 'b', lat: 0, lon: 1);
    expect(routeLengthKm([a, b]), closeTo(111.19, 0.05));
  });

  group('WaypointStore', () {
    setUp(() => SharedPreferences.setMockInitialValues({}));

    test('dedupes, saves and loads', () async {
      final prefs = await SharedPreferences.getInstance();
      final store = WaypointStore(prefs);
      final added = await store.addImport(parseGpx(withTrack(3)));
      expect(added.waypoints, 2);
      expect(added.routes, 2);
      final again = await store.addImport(parseGpx(withTrack(3)));
      expect(again.waypoints, 0, reason: 'same places, same names');
      expect(
        await store.add(
          const Waypoint(id: 'x', name: 'Hut', lat: 49.35, lon: -123.1),
        ),
        isFalse,
      );
      final reloaded = WaypointStore(prefs);
      expect(reloaded.waypoints, hasLength(2));
      expect(reloaded.routes, hasLength(4));
      await reloaded.remove(reloaded.waypoints.first.id);
      await reloaded.removeRoute(reloaded.routes.first.id);
      expect(WaypointStore(prefs).waypoints, hasLength(1));
      expect(WaypointStore(prefs).routes, hasLength(3));
    });
  });

  group('screen', () {
    late WaypointStore store;
    late MeshCoreConnector radio;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      PrefsManager.reset();
      await PrefsManager.initialize();
      store = WaypointStore(await SharedPreferences.getInstance());
      radio = MeshCoreConnector();
    });
    tearDown(() => radio.dispose());

    Future<void> pump(WidgetTester tester, Widget home) => tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppSettingsService()),
          ChangeNotifierProvider<MeshCoreConnector>.value(value: radio),
          ChangeNotifierProvider<WaypointStore>.value(value: store),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: home,
        ),
      ),
    );

    testWidgets('paste GPX, then the list shows it', (tester) async {
      await pump(tester, const WaypointsScreen());
      expect(find.textContaining('No waypoints yet'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('waypoints-menu')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Paste GPX'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const ValueKey('gpx-paste')),
        withTrack(3),
      );
      await tester.tap(find.text('Import'));
      await tester.pumpAndSettle();
      expect(find.text('Added 2 waypoints and 2 routes'), findsOneWidget);
      expect(find.text('Hut'), findsOneWidget);
      expect(find.text('Ridge walk'), findsOneWidget);
      expect(find.text('Waypoints (2)'), findsOneWidget);
    });

    testWidgets('bad paste says so', (tester) async {
      await pump(tester, const WaypointsScreen());
      await tester.tap(find.byKey(const ValueKey('waypoints-menu')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Paste GPX'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const ValueKey('gpx-paste')), 'nope');
      await tester.tap(find.text('Import'));
      await tester.pumpAndSettle();
      expect(find.textContaining("isn't a GPX file"), findsOneWidget);
    });

    testWidgets('a shared marker can be saved once', (tester) async {
      await pump(
        tester,
        const Scaffold(
          body: SaveWaypointButton(
            label: 'Camp',
            lat: 49.1,
            lon: -123.2,
            color: Colors.black,
          ),
        ),
      );
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();
      expect(find.text('Saved to Waypoints'), findsOneWidget);
      expect(store.waypoints.single.name, 'Camp');
      await tester.tap(find.byType(IconButton));
      await tester.pump();
      expect(store.waypoints, hasLength(1));
    });
  });
}
