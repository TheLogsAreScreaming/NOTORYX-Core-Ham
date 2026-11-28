import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/utils/node_import.dart';

String _key(int b) =>
    List.filled(32, b.toRadixString(16).padLeft(2, '0')).join();

/// A flood advert with a position and a name.
String _advertHex(int keyByte, String name, double lat, double lon, int time) {
  final b = BytesBuilder()
    ..addByte(0x04 << 2 | 0x01) // advert, flood route
    ..addByte(0) // no path
    ..add(List.filled(32, keyByte))
    ..add((ByteData(4)..setUint32(0, time, Endian.little)).buffer.asUint8List())
    ..add(List.filled(64, 0)) // signature
    ..addByte(0x80 | 0x10 | advTypeRepeater)
    ..add(
      (ByteData(8)
            ..setInt32(0, (lat * 1e6).round(), Endian.little)
            ..setInt32(4, (lon * 1e6).round(), Endian.little))
          .buffer
          .asUint8List(),
    )
    ..add(utf8.encode(name));
  return b.toBytes().map((x) => x.toRadixString(16).padLeft(2, '0')).join();
}

void main() {
  test('JSON list with loose field names', () {
    final nodes = parseNodeImport(
      jsonEncode([
        {
          'public_key': _key(0xaa),
          'adv_name': 'Repeater A',
          'type': 'repeater',
          'lat': 41.5,
          'lon': -72.5,
          'last_seen': 1763700000,
        },
        {
          'publicKey': base64Encode(List.filled(32, 0xbb)),
          'name': 'Room B',
          'type': 3,
        },
        {'name': 'no key'},
      ]),
    );
    expect(nodes, hasLength(2));
    final a = nodes.firstWhere((n) => n.name == 'Repeater A');
    expect(a.publicKeyHex.toLowerCase(), _key(0xaa));
    expect(a.type, advTypeRepeater);
    expect(a.latitude, 41.5);
    expect(a.longitude, -72.5);
    expect(a.lastSeen!.millisecondsSinceEpoch, 1763700000 * 1000);
    expect(nodes.firstWhere((n) => n.name == 'Room B').type, advTypeRoom);
  });

  test('JSON object holding the list under "contacts"', () {
    final nodes = parseNodeImport(
      jsonEncode({
        'contacts': [
          {'key': _key(0x01), 'name': 'Node 1'},
        ],
      }),
    );
    expect(nodes.single.name, 'Node 1');
  });

  test('CSV with a header, quotes and semicolons', () {
    final csv =
        'Name;Public Key;Type;Latitude;Longitude\n'
        '"Node, quoted";${_key(0x02)};companion;0;0\n'
        'Sensor 3;${_key(0x03)};4;45.1;-70.2\n';
    final nodes = parseNodeImport(csv);
    expect(nodes, hasLength(2));
    final q = nodes.firstWhere((n) => n.name == 'Node, quoted');
    expect(q.type, advTypeChat);
    expect(q.latitude, isNull, reason: '0,0 is no position');
    expect(nodes.firstWhere((n) => n.name == 'Sensor 3').type, advTypeSensor);
  });

  test('lines of contact links, adverts and bare keys; duplicates merge', () {
    final text = [
      'meshcore://contact/add?name=Link%20Node&public_key=${_key(0x04)}&type=2',
      'meshcore://${_advertHex(0x05, 'Advert Node', 41.25, -72.75, 1763600000)}',
      _key(0x06),
      'some other text',
      _key(0x04), // the link node again, without a name
    ].join('\n');
    final nodes = parseNodeImport(text);
    expect(nodes, hasLength(3));
    final link = nodes.firstWhere(
      (n) => n.publicKeyHex.toLowerCase() == _key(0x04),
    );
    expect(link.name, 'Link Node');
    expect(link.type, advTypeRepeater);
    final advert = nodes.firstWhere((n) => n.name == 'Advert Node');
    expect(advert.type, advTypeRepeater);
    expect(advert.latitude, closeTo(41.25, 1e-6));
    expect(advert.longitude, closeTo(-72.75, 1e-6));
    expect(advert.lastSeen!.millisecondsSinceEpoch, 1763600000 * 1000);
    expect(
      nodes.firstWhere((n) => n.publicKeyHex.toLowerCase() == _key(0x06)).name,
      isNull,
    );
  });

  test('a future last-heard time is ignored', () {
    final future = DateTime.now().add(const Duration(days: 30));
    final nodes = parseNodeImport(
      jsonEncode([
        {'public_key': _key(0x07), 'last_seen': future.toIso8601String()},
      ]),
    );
    expect(nodes.single.lastSeen, isNull);
  });

  test('nothing usable gives an empty list', () {
    expect(parseNodeImport(''), isEmpty);
    expect(parseNodeImport('hello\nworld'), isEmpty);
    expect(parseNodeImport('{"nodes": []}'), isEmpty);
    expect(parseNodeImport('[{"public_key": "abc"}]'), isEmpty);
  });
}
