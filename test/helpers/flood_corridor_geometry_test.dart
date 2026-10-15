import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:meshcore_open/helpers/flood_corridor_geometry.dart';
import 'package:meshcore_open/models/flood_corridor.dart';

void main() {
  // 1 degree of latitude is 111 km in the firmware's approximation.
  const kmLat = 1 / 111;

  final single = [CorridorTriple(lat: 49, lon: -123, radiusCode: 4)]; // 8 km
  // West-east chain at the equator: 8 km radius at the west end, 20 km at the east.
  final chain = [
    CorridorTriple(lat: 0, lon: 0, radiusCode: 4),
    CorridorTriple(lat: 0, lon: 1, radiusCode: 6),
  ];

  group('isPointInCorridor', () {
    test('a single circle is a plain radius check', () {
      expect(
        isPointInCorridor(const LatLng(49 + 7.9 * kmLat, -123), single),
        isTrue,
      );
      expect(
        isPointInCorridor(const LatLng(49 + 8.1 * kmLat, -123), single),
        isFalse,
      );
    });

    test('interpolates the radius along a segment', () {
      // Midpoint radius is (8 + 20) / 2 = 14 km.
      expect(isPointInCorridor(const LatLng(13.9 * kmLat, 0.5), chain), isTrue);
      expect(
        isPointInCorridor(const LatLng(14.1 * kmLat, 0.5), chain),
        isFalse,
      );
    });

    test('accepts points beyond the ends within the end radius', () {
      expect(
        isPointInCorridor(const LatLng(0, 1 + 19.9 * kmLat), chain),
        isTrue,
      );
      expect(isPointInCorridor(const LatLng(0, -8.1 * kmLat), chain), isFalse);
    });

    test('an unlimited circle accepts everything; empty accepts nothing', () {
      final unlimited = [
        CorridorTriple(lat: 0, lon: 0, radiusCode: corridorRadiusCodeUnlimited),
      ];
      expect(isPointInCorridor(const LatLng(60, 100), unlimited), isTrue);
      expect(isPointInCorridor(const LatLng(0, 0), const []), isFalse);
    });
  });

  group('corridorSegmentPolygons', () {
    test('offsets each end by its own radius', () {
      final polygons = corridorSegmentPolygons(chain);
      expect(polygons, hasLength(1));
      final corners = polygons.single;
      expect(corners[0].latitude.abs(), closeTo(8 * kmLat, 1e-9));
      expect(corners[1].latitude.abs(), closeTo(20 * kmLat, 1e-9));
      expect(corners[2].latitude, closeTo(-corners[1].latitude, 1e-9));
      expect(corners[3].latitude, closeTo(-corners[0].latitude, 1e-9));
      expect(corners[0].longitude, closeTo(0, 1e-9));
      expect(corners[1].longitude, closeTo(1, 1e-9));
    });

    test('the outline edge matches the inside test', () {
      final edge = corridorSegmentPolygons(chain).single;
      final mid = LatLng(
        (edge[0].latitude + edge[1].latitude) / 2,
        (edge[0].longitude + edge[1].longitude) / 2,
      );
      expect(
        isPointInCorridor(LatLng(mid.latitude * 0.99, mid.longitude), chain),
        isTrue,
      );
      expect(
        isPointInCorridor(LatLng(mid.latitude * 1.01, mid.longitude), chain),
        isFalse,
      );
    });

    test('skips single circles and unlimited segments', () {
      expect(corridorSegmentPolygons(single), isEmpty);
      expect(
        corridorSegmentPolygons([
          chain.first,
          CorridorTriple(
            lat: 0,
            lon: 1,
            radiusCode: corridorRadiusCodeUnlimited,
          ),
        ]),
        isEmpty,
      );
    });
  });
}
