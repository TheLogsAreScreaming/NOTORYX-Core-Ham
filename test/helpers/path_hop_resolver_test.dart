import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/helpers/path_hop_resolver.dart';
import 'package:meshcore_open/models/contact.dart';

Contact _contact({
  required int prefix,
  required String name,
  required double latitude,
  required double longitude,
  DateTime? lastSeen,
}) {
  return Contact(
    publicKey: Uint8List(32)..first = prefix,
    name: name,
    type: advTypeRepeater,
    pathLength: 0,
    path: Uint8List(0),
    latitude: latitude,
    longitude: longitude,
    lastSeen: lastSeen ?? DateTime.utc(2026),
  );
}

void main() {
  test('received paths resolve hash conflicts from the receiver backward', () {
    final nearReceiver = _contact(
      prefix: 0xAA,
      name: 'Near receiver',
      latitude: 0,
      longitude: 0.1,
    );
    final nearPreviousHop = _contact(
      prefix: 0xBB,
      name: 'Near previous hop',
      latitude: 0,
      longitude: 1.1,
    );
    final wrongConflict = _contact(
      prefix: 0xBB,
      name: 'Near receiver but wrong',
      latitude: 0,
      longitude: 0.2,
    );
    final previousHop = _contact(
      prefix: 0xCC,
      name: 'Previous hop',
      latitude: 0,
      longitude: 1,
    );

    final resolved = PathHopResolver.resolve(
      pathBytes: const [0xBB, 0xCC, 0xAA],
      contacts: [nearReceiver, nearPreviousHop, wrongConflict, previousHop],
      endpoint: const LatLng(0, 0),
      resolveFromEnd: true,
    );

    expect(resolved.map((contact) => contact?.name), [
      'Near previous hop',
      'Previous hop',
      'Near receiver',
    ]);
  });

  test('leaves conflicting hash unresolved without location evidence', () {
    final older = Contact(
      publicKey: Uint8List(32)..first = 0xAA,
      name: 'Older',
      type: advTypeRepeater,
      pathLength: 0,
      path: Uint8List(0),
      lastSeen: DateTime.utc(2025),
    );
    final newer = Contact(
      publicKey: Uint8List(32)..first = 0xAA,
      name: 'Newer',
      type: advTypeRepeater,
      pathLength: 0,
      path: Uint8List(0),
      lastSeen: DateTime.utc(2026),
    );

    final resolved = PathHopResolver.resolve(
      pathBytes: const [0xAA],
      contacts: [older, newer],
    );

    expect(resolved.single, isNull);
  });
  test('unique known repeater resolves without GPS evidence', () {
    final known = Contact(
      publicKey: Uint8List(32)..first = 0xAC,
      name: 'Known repeater',
      type: advTypeRepeater,
      pathLength: 0,
      path: Uint8List(0),
      lastSeen: DateTime.utc(2026),
    );

    final resolved = PathHopResolver.resolve(
      pathBytes: const [0xAC],
      contacts: [known],
    );

    expect(resolved.single?.name, 'Known repeater');
  });

  test('unknown hop remains unresolved', () {
    final resolved = PathHopResolver.resolve(
      pathBytes: const [0xDD],
      contacts: [],
    );

    expect(resolved, hasLength(1));
    expect(resolved.single, isNull);
  });

  test('ignores chat contacts when matching repeater hops', () {
    final chat = Contact(
      publicKey: Uint8List(32)..first = 0xAE,
      name: 'Not a repeater',
      type: advTypeChat,
      pathLength: 0,
      path: Uint8List(0),
      lastSeen: DateTime.utc(2026),
    );

    expect(
      PathHopResolver.resolve(
        pathBytes: const [0xAE],
        contacts: [chat],
      ).single,
      isNull,
    );
  });
}
