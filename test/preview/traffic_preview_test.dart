// Renders the live Traffic map overlay to a PNG for design review.
//
// Skipped unless PREVIEW_OUT is set:
//   PREVIEW_OUT=/some/dir flutter test test/preview/traffic_preview_test.dart
// No map tiles are drawn (tests have no network); the overlay is the point.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/traffic_route.dart';
import 'package:meshcore_open/services/traffic_feed.dart';
import 'package:meshcore_open/theme/mesh_theme.dart';
import 'package:meshcore_open/widgets/traffic_map.dart';

Future<void> _loadFonts() async {
  Future<void> load(String family, List<String> paths) async {
    final loader = FontLoader(family);
    for (final p in paths) {
      final bytes = File(p).readAsBytesSync();
      loader.addFont(Future.value(ByteData.view(bytes.buffer)));
    }
    await loader.load();
  }

  final sdk = Platform.environment['FLUTTER_ROOT']!;
  List<String> fontFiles(String prefix) => Directory('assets/fonts')
      .listSync()
      .whereType<File>()
      .map((f) => f.path)
      .where((p) => p.split('/').last.startsWith(prefix) && p.endsWith('.ttf'))
      .toList();
  await load('Inter', fontFiles('Inter-'));
  await load('JetBrains Mono', fontFiles('JetBrainsMono-'));
  await load('MaterialIcons', [
    '$sdk/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
  ]);
}

TrafficHop _hop(String id, String? name, double lat, double lon) => TrafficHop(
  id: id,
  name: name,
  role: TrafficHopRole.repeater,
  position: LatLng(lat, lon),
);

void main() {
  final out = Platform.environment['PREVIEW_OUT'];

  testWidgets('traffic map', skip: out == null, (tester) async {
    await _loadFonts();
    final palette = BastionTheme.fromId(
      Platform.environment['PREVIEW_THEME']?.split(',').first,
    ).palette;
    MeshPalette.current = palette;
    await tester.binding.setSurfaceSize(const Size(390, 844));
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    final route = TrafficRoute(
      kind: TrafficKind.path,
      hops: [
        TrafficHop(
          id: '1FD75D',
          role: TrafficHopRole.origin,
          position: const LatLng(40.95, -76.6),
        ),
        _hop('F5', 'North Peak', 40.7, -76.1),
        const TrafficHop(id: 'C7', role: TrafficHopRole.repeater),
        _hop('BF', null, 40.45, -75.5),
        _hop('0D', 'West Ridge', 40.2, -74.95),
        const TrafficHop(
          id: 'C0FFEE',
          role: TrafficHopRole.self,
          name: 'Base',
          position: LatLng(39.95, -74.6),
        ),
      ],
      receivedAt: DateTime.now(),
      snr: 12,
      rssi: -33,
      isFlood: true,
      hopCount: 5,
      packetHash: '00',
    );
    final advert = TrafficRoute(
      kind: TrafficKind.advert,
      hops: [
        TrafficHop(
          id: '9A21C3',
          name: 'Hilltop',
          role: TrafficHopRole.origin,
          position: const LatLng(39.6, -75.9),
        ),
        _hop('BF', null, 40.45, -75.5),
        const TrafficHop(
          id: 'C0FFEE',
          role: TrafficHopRole.self,
          position: LatLng(39.95, -74.6),
        ),
      ],
      receivedAt: DateTime.now(),
      snr: 4,
      rssi: -101,
      isFlood: true,
      hopCount: 1,
      packetHash: '01',
    );
    var now = DateTime.now();
    final feed =
        TrafficFeed(
            contacts: () => const [],
            selfPosition: () => null,
            clock: () => now,
          )
          ..addRoute(advert)
          ..addRoute(route);
    // Freeze it with the dot on the third leg.
    now = now.add(const Duration(milliseconds: 1500));
    addTearDown(feed.dispose);

    final boundary = GlobalKey();
    await tester.pumpWidget(
      RepaintBoundary(
        key: boundary,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: MeshTheme.forPalette(palette),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            backgroundColor: const Color(0xFF15171C),
            body: Stack(
              children: [
                FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(40.35, -75.6),
                    initialZoom: 7.4,
                    backgroundColor: Color(0xFF1B1E24),
                  ),
                  children: [
                    MarkerLayer(
                      markers: [
                        for (final hop in route.mapHops.skip(1).take(3))
                          Marker(
                            point: hop.position!,
                            width: 36,
                            height: 36,
                            child: Container(
                              decoration: BoxDecoration(
                                color: MapPalette.repeater,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: MapPalette.online,
                                  width: 3,
                                ),
                              ),
                              child: const Icon(
                                Icons.cell_tower,
                                color: Colors.white,
                                size: 19,
                              ),
                            ),
                          ),
                      ],
                    ),
                    TrafficRouteLayer(feed: feed),
                  ],
                ),
                Positioned(
                  right: 12,
                  top: 140,
                  child: MapToolPill(
                    items: [
                      for (final (icon, label, on) in [
                        (Icons.near_me_outlined, 'Locate', false),
                        (Icons.campaign_outlined, 'Advert', false),
                        (Icons.filter_list, 'Filter', false),
                        (Icons.route, 'Traffic', true),
                        (Icons.search, 'Search', false),
                        (Icons.open_in_full, 'Fit all', false),
                        (Icons.more_horiz, 'Options', false),
                      ])
                        MapToolItem(
                          icon: icon,
                          label: label,
                          selected: on ? true : null,
                          onPressed: () {},
                        ),
                    ],
                  ),
                ),
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 24,
                  child: TrafficRouteCard(route: route),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 16));
    await tester.runAsync(() async {
      final ro =
          boundary.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final image = await ro.toImage(pixelRatio: 2);
      final png = await image.toByteData(format: ui.ImageByteFormat.png);
      File('$out/traffic_map.png')
        ..createSync(recursive: true)
        ..writeAsBytesSync(png!.buffer.asUint8List());
    });
  });
}
