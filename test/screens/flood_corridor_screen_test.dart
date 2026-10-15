import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/flood_corridor.dart';
import 'package:meshcore_open/screens/flood_corridor_screen.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/services/map_tile_cache_service.dart';
import 'package:provider/provider.dart';

class _FakeConnector extends MeshCoreConnector {
  _FakeConnector({this.supported = true, this.proposal});

  final bool supported;
  final CorridorProposal? proposal;
  bool? lastDense;

  @override
  bool? get floodCorridorSupported => supported;

  @override
  double? get selfLatitude => 49.0;

  @override
  double? get selfLongitude => -123.0;

  @override
  List<Contact> get allContacts => [
    _repeater(1, 49.25, -122.75), // on the corridor
    _repeater(2, 48.0, -121.0), // far away
  ];

  @override
  Future<CorridorProposal?> proposeCorridor(
    double lat,
    double lon, {
    bool dense = false,
  }) async {
    lastDense = dense;
    return supported ? proposal : null;
  }
}

Contact _repeater(int id, double lat, double lon) => Contact(
  publicKey: Uint8List.fromList(List.filled(32, id)),
  name: 'Repeater $id',
  type: advTypeRepeater,
  path: Uint8List(0),
  pathLength: 0,
  latitude: lat,
  longitude: lon,
  lastSeen: DateTime.now(),
);

Widget _app(MeshCoreConnector connector) {
  final settings = AppSettingsService();
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<MeshCoreConnector>.value(value: connector),
      ChangeNotifierProvider<AppSettingsService>.value(value: settings),
      ChangeNotifierProvider<MapTileCacheService>(
        create: (_) => MapTileCacheService(appSettingsService: settings),
      ),
    ],
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const FloodCorridorScreen(target: LatLng(49.5, -122.5)),
    ),
  );
}

void main() {
  final proposal = CorridorProposal(
    reason: 0x02 | 0x08,
    triples: [
      CorridorTriple(lat: 49.0, lon: -123.0, radiusCode: 4),
      CorridorTriple(lat: 49.25, lon: -122.75, radiusCode: 5),
      CorridorTriple(lat: 49.5, lon: -122.5, radiusCode: 4),
    ],
  );

  testWidgets('shows the proposed corridor summary', (tester) async {
    final connector = _FakeConnector(proposal: proposal);
    await tester.pumpWidget(_app(connector));
    await tester.pumpAndSettle();

    expect(find.text('Follows your known repeaters'), findsOneWidget);
    expect(
      find.text('3 circles · 1 of 2 known repeaters inside'),
      findsOneWidget,
    );
    expect(
      find.text('Part of the corridor has few known repeaters'),
      findsOneWidget,
    );
    expect(connector.lastDense, isFalse);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(connector.lastDense, isTrue);
  });

  testWidgets('explains unsupported firmware', (tester) async {
    await tester.pumpWidget(_app(_FakeConnector(supported: false)));
    await tester.pumpAndSettle();

    expect(
      find.text("Your radio's firmware doesn't support flood corridors."),
      findsOneWidget,
    );
  });
}
