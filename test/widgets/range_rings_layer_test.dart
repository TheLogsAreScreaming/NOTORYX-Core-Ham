import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:meshcore_open/models/app_settings.dart';
import 'package:meshcore_open/models/range_rings.dart';
import 'package:meshcore_open/widgets/range_rings_layer.dart';

void main() {
  Future<void> pump(
    WidgetTester tester,
    UnitSystem units, {
    EdgeInsets insets = EdgeInsets.zero,
  }) async {
    await tester.binding.setSurfaceSize(const Size(400, 400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    const here = LatLng(52.0, 5.0);
    await tester.pumpWidget(
      MaterialApp(
        home: FlutterMap(
          options: const MapOptions(initialCenter: here, initialZoom: 13),
          children: [
            RangeRingsLayer(
              centre: here,
              units: units,
              dark: false,
              insets: insets,
            ),
          ],
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

  testWidgets('keeps labels out from under the overlays', (tester) async {
    // A tall top bar and a wide side toolbar, as on the map screen.
    const insets = EdgeInsets.fromLTRB(64, 140, 96, 24);
    await pump(tester, UnitSystem.metric, insets: insets);
    final area = unobscuredArea(const Size(400, 400), insets);
    final labels = find.textContaining(RegExp(r'^(\d+(\.\d+)? k?m|[NESW])$'));
    expect(labels, findsWidgets);
    for (final element in labels.evaluate()) {
      final box = tester.getRect(find.byWidget(element.widget));
      expect(
        area.contains(box.topLeft) &&
            area.contains(box.bottomRight - const Offset(0.01, 0.01)),
        isTrue,
        reason: '${(element.widget as Text).data} at $box is outside $area',
      );
    }
  });
}
