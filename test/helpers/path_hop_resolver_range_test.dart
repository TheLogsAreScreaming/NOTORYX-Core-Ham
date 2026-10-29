import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/helpers/path_hop_resolver.dart';
import 'package:meshcore_open/models/contact.dart';

Contact _repeater(int prefix, String name, double lat, double lon) => Contact(
  publicKey: Uint8List(32)
    ..first = prefix
    ..last = name.length,
  name: name,
  type: advTypeRepeater,
  pathLength: 0,
  path: Uint8List(0),
  latitude: lat,
  longitude: lon,
  lastSeen: DateTime.utc(2026),
);

void main() {
  const seattle = LatLng(47.6, -122.3);

  test('a lone match out of radio range stays unresolved', () {
    final hops = PathHopResolver.resolve(
      pathBytes: [0x3d],
      contacts: [_repeater(0x3d, 'Far away', 40.0, -75.0)],
      endpoint: seattle,
    );
    expect(hops.single, isNull);
  });

  test('a lone match in range resolves', () {
    final hops = PathHopResolver.resolve(
      pathBytes: [0x3d],
      contacts: [_repeater(0x3d, 'Nearby', 47.7, -122.2)],
      endpoint: seattle,
    );
    expect(hops.single?.name, 'Nearby');
  });

  test('when every shared-ID candidate is out of range, none is picked', () {
    final hops = PathHopResolver.resolve(
      pathBytes: [0x3d],
      contacts: [
        _repeater(0x3d, 'Philly', 39.95, -75.16),
        _repeater(0x3d, 'Denver', 39.74, -104.99),
      ],
      endpoint: seattle,
    );
    expect(hops.single, isNull);
  });

  test('without a known position the range check is skipped', () {
    final hops = PathHopResolver.resolve(
      pathBytes: [0x3d],
      contacts: [_repeater(0x3d, 'Far away', 40.0, -75.0)],
    );
    expect(hops.single?.name, 'Far away');
  });
}
