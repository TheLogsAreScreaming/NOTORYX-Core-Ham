import 'dart:ui' show Tristate;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/traffic_route.dart';
import 'package:meshcore_open/widgets/traffic_map.dart';

Widget _app(Widget child) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(body: child),
);

void main() {
  final route = TrafficRoute(
    kind: TrafficKind.path,
    hops: const [
      TrafficHop(
        id: '1FD75D',
        role: TrafficHopRole.origin,
        position: LatLng(40.6, -75.6),
      ),
      TrafficHop(id: 'F5', role: TrafficHopRole.repeater, name: 'Cellar'),
      TrafficHop(
        id: 'C7',
        role: TrafficHopRole.repeater,
        name: 'Ridge',
        position: LatLng(40.2, -75.2),
      ),
      TrafficHop(id: '', role: TrafficHopRole.self, position: LatLng(40, -75)),
    ],
    receivedAt: DateTime.now(),
    snr: 12,
    rssi: -33,
    isFlood: true,
    hopCount: 16,
    packetHash: '00',
  );

  testWidgets('the route card shows route, type, signal and legend', (
    tester,
  ) async {
    var tapped = false;
    await tester.pumpWidget(
      _app(TrafficRouteCard(route: route, onTap: () => tapped = true)),
    );
    expect(find.text('1FD75D → Cellar → Ridge → You'), findsOneWidget);
    // Ridge relayed it, so its SNR is only the last leg.
    expect(find.text('Last hop Ridge · 12 dB'), findsOneWidget);
    expect(
      find.textContaining('Flood 16 · -33 dBm · SNR 12 · 1 not on map · '),
      findsOneWidget,
    );
    expect(find.text('Not on map: Cellar'), findsOneWidget);
    // Pill plus legend entry.
    expect(find.text('Path'), findsNWidgets(2));
    for (final label in [
      'Advert',
      'Direct message',
      'Channel message',
      'Acknowledgement',
      'Trace',
    ]) {
      expect(find.text(label), findsOneWidget);
    }
    await tester.tap(find.byType(TrafficRouteCard));
    expect(tapped, isTrue);
  });

  testWidgets('with nothing heard yet the card says it is listening', (
    tester,
  ) async {
    await tester.pumpWidget(_app(const TrafficRouteCard(route: null)));
    expect(find.text('Listening for packets…'), findsOneWidget);
  });

  testWidgets('the tool pill marks the Traffic toggle', (tester) async {
    var on = false;
    await tester.pumpWidget(
      _app(
        MapToolPill(
          items: [
            MapToolItem(
              key: const ValueKey('traffic'),
              icon: Icons.route,
              label: 'Traffic',
              selected: true,
              onPressed: () => on = true,
            ),
          ],
        ),
      ),
    );
    final semantics = tester.getSemantics(
      find.byKey(const ValueKey('traffic')),
    );
    expect(semantics.flagsCollection.isToggled, Tristate.isTrue);
    await tester.tap(find.text('Traffic'));
    expect(on, isTrue);
  });

  testWidgets('the tool pill drops its labels when space is short', (
    tester,
  ) async {
    final items = [
      for (final label in ['Locate', 'Advert', 'Filter', 'Traffic'])
        MapToolItem(icon: Icons.circle, label: label, onPressed: () {}),
    ];
    Widget sized(double height) => _app(
      Align(
        alignment: Alignment.topRight,
        child: SizedBox(
          height: height,
          child: MapToolPill(items: items),
        ),
      ),
    );

    await tester.pumpWidget(sized(400));
    expect(find.text('Locate'), findsOneWidget);

    await tester.pumpWidget(sized(190));
    expect(find.text('Locate'), findsNothing);
    expect(find.byIcon(Icons.circle), findsNWidgets(4));
    expect(find.byTooltip('Locate'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
