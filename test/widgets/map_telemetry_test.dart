import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/helpers/cayenne_lpp.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/services/node_telemetry_store.dart';
import 'package:meshcore_open/widgets/map_telemetry.dart';

void main() {
  test(
    'cluster members have no individual badges until selected or unclustered',
    () {
      Contact node(int key, double latitude) => Contact(
        publicKey: Uint8List.fromList(List.filled(32, key)),
        name: '$key',
        type: 1,
        pathLength: -1,
        path: Uint8List(0),
        lastSeen: DateTime.now(),
        latitude: latitude,
        longitude: -74.01,
      );
      final a = node(1, 40.001), b = node(2, 40.002), c = node(3, 41.1);
      expect(telemetryIndividualNodes([a, b, c], cellDegrees: 0.1), [c]);
      expect(
        telemetryIndividualNodes(
          [a, b, c],
          cellDegrees: 0.1,
          selectedKey: a.publicKeyHex,
        ),
        [a, b, c],
      );
      expect(telemetryIndividualNodes([a, b, c]), [a, b, c]);
    },
  );
  testWidgets(
    'layer shows visible recent readings and hides expired or offscreen nodes',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      var now = DateTime.utc(2026, 10, 30, 12);
      final store = NodeTelemetryStore(prefs, clock: () => now)
        ..setScope('a' * 64);
      final settings = AppSettingsService();
      final controller = MapController();
      final near = Contact(
        publicKey: Uint8List.fromList(List.filled(32, 1)),
        name: 'Near',
        type: 1,
        pathLength: -1,
        path: Uint8List(0),
        lastSeen: now,
        latitude: 40,
        longitude: -74,
      );
      final far = Contact(
        publicKey: Uint8List.fromList(List.filled(32, 2)),
        name: 'Far',
        type: 1,
        pathLength: -1,
        path: Uint8List(0),
        lastSeen: now,
        latitude: 0.1,
        longitude: 1,
      );
      for (final c in [near, far]) {
        store.record(c.publicKeyHex, [
          {'channel': 1, 'type': CayenneLpp.lppTemperature, 'value': 21},
        ], source: TelemetrySource.telemetry);
      }
      var enabled = true;
      late StateSetter toggle;
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<NodeTelemetryStore?>.value(value: store),
            ChangeNotifierProvider.value(value: settings),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: StatefulBuilder(
              builder: (context, setState) {
                toggle = setState;
                return Scaffold(
                  body: FlutterMap(
                    mapController: controller,
                    options: const MapOptions(
                      initialCenter: LatLng(40, -74),
                      initialZoom: 14,
                    ),
                    children: [
                      if (enabled)
                        MapTelemetryLayer(
                          contacts: [near, far],
                          metric: TelemetryMetric.temperature,
                          onSelect: (_) {},
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('21.0 °C'), findsOneWidget);
      toggle(() => enabled = false);
      await tester.pump();
      expect(find.text('21.0 °C'), findsNothing);
      toggle(() => enabled = true);
      await tester.pump();
      now = now.add(const Duration(hours: 24));
      await tester.pump(const Duration(minutes: 1));
      expect(find.text('21.0 °C'), findsNothing);
      await tester.pumpWidget(const SizedBox());
      controller.dispose();
      store.dispose();
      settings.dispose();
    },
  );

  for (final width in [320.0, 720.0]) {
    testWidgets('node telemetry fits $width px wide at 2x text', (
      tester,
    ) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final now = DateTime.utc(2026, 10, 30, 12);
      final store = NodeTelemetryStore(prefs, clock: () => now)
        ..setScope('a' * 64);
      final settings = AppSettingsService();
      final radio = MeshCoreConnector();
      final node = Contact(
        publicKey: Uint8List.fromList(List.filled(32, 1)),
        name: 'Ridge',
        type: 1,
        pathLength: -1,
        path: Uint8List(0),
        lastSeen: now,
      );
      store.record(node.publicKeyHex, [
        {'channel': 1, 'type': CayenneLpp.lppTemperature, 'value': 21},
        {'channel': 1, 'type': CayenneLpp.lppVoltage, 'value': 4.1},
        {'channel': 2, 'type': CayenneLpp.lppRelativeHumidity, 'value': 40},
      ], source: TelemetrySource.telemetry);
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<NodeTelemetryStore?>.value(value: store),
            ChangeNotifierProvider.value(value: settings),
            ChangeNotifierProvider<MeshCoreConnector>.value(value: radio),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: MediaQuery(
              data: MediaQueryData(
                size: Size(width, 900),
                textScaler: const TextScaler.linear(2),
              ),
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: NodeTelemetrySection(contact: node),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
      final title = tester.getRect(find.text('Telemetry'));
      final refresh = tester.getRect(
        find.byKey(const ValueKey('node-telemetry-refresh')),
      );
      if (width < 400) {
        expect(refresh.top, greaterThanOrEqualTo(title.bottom));
      } else {
        expect(refresh.top, lessThan(title.bottom));
      }
      await tester.pumpWidget(const SizedBox());
      store.dispose();
      settings.dispose();
      radio.dispose();
    });
  }
}
