import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:meshcore_open/models/app_settings.dart';
import 'package:meshcore_open/widgets/range_rings_layer.dart';

void main() {
  Future<void> pump(WidgetTester tester, UnitSystem units) async {
    await tester.binding.setSurfaceSize(const Size(400, 400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    const here = LatLng(52.0, 5.0);
    await tester.pumpWidget(
      MaterialApp(
        home: FlutterMap(
          options: const MapOptions(initialCenter: here, initialZoom: 13),
          children: [RangeRingsLayer(centre: here, units: units, dark: false)],
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('draws four rings, labels and compass tags', (tester) async {
    await pump(tester, UnitSystem.metric);
    final circles = tester.widget<CircleLayer>(find.byType(CircleLayer));
    expect(circles.circles, hasLength(4));
    final spokes = tester.widget<PolylineLayer>(find.byType(PolylineLayer));
    expect(spokes.polylines, hasLength(8));
    for (final tag in ['N', 'E', 'S', 'W']) {
      expect(find.text(tag), findsOneWidget);
    }
    expect(find.textContaining(RegExp(r'^\d+(\.\d+)? k?m$')), findsNWidgets(4));
  });

  testWidgets('imperial labels are in miles', (tester) async {
    await pump(tester, UnitSystem.imperial);
    expect(find.textContaining(RegExp(r' mi$')), findsNWidgets(4));
  });
}
