import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:meshcore_open/models/app_settings.dart';
import 'package:meshcore_open/models/waypoint.dart';
import 'package:meshcore_open/widgets/waypoint_map_layer.dart';

void main() {
  const a = Waypoint(id: 'a', name: 'Camp', lat: 45.5, lon: -122.5);
  const b = Waypoint(id: 'b', name: 'Peak', lat: 45.6, lon: -122.4);

  test('a waypoint marker sits at its position', () {
    final m = waypointMapMarker(a, showLabel: false, onTap: () {});
    expect(m.point, const LatLng(45.5, -122.5));
  });

  test('a route line follows its points in order', () {
    final line = waypointRoutePolyline(
      const WaypointRoute(id: 'r', name: 'Hike', points: [a, b]),
    );
    expect(line.points, const [LatLng(45.5, -122.5), LatLng(45.6, -122.4)]);
  });

  test('the map setting defaults on and survives a round trip', () {
    expect(AppSettings().mapShowWaypoints, isTrue);
    final off = AppSettings().copyWith(mapShowWaypoints: false);
    expect(AppSettings.fromJson(off.toJson()).mapShowWaypoints, isFalse);
  });
}
