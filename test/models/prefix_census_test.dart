import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/prefix_census.dart';

Contact _node(String name, List<int> keyStart, {int type = advTypeRepeater}) {
  final key = Uint8List(32)..setAll(0, keyStart);
  key[31] = name.hashCode & 0xff; // keep keys distinct
  return Contact(
    publicKey: key,
    name: name,
    type: type,
    pathLength: -1,
    path: Uint8List(0),
    lastSeen: DateTime(2026, 10, 28),
  );
}

void main() {
  final nodes = [
    _node('Ridge', [0x3d, 0x4a, 0x01]),
    _node('Tower', [0x3d, 0x4b, 0x02]),
    _node('Base', [0x5a, 0x10]),
    _node('Phone', [0x3d, 0x99], type: advTypeChat),
  ];

  test('groups repeaters by path ID and finds shared ones', () {
    final one = PrefixCensus.build(nodes, bytes: 1);
    expect(one.nodeCount, 3); // the phone is left out by default
    expect(one.collisions.single.key, '3D');
    expect(
      one.collisions.single.value.map((c) => c.name),
      unorderedEquals(['Ridge', 'Tower']),
    );
    final two = PrefixCensus.build(nodes, bytes: 2);
    expect(two.collisions, isEmpty);
    expect(two.byPrefix.keys, containsAll(['3D4A', '3D4B', '5A10']));
  });

  test('companions count only when asked', () {
    final census = PrefixCensus.build(nodes, bytes: 1, includeCompanions: true);
    expect(census.byPrefix['3D'], hasLength(3));
  });

  test('lookup ignores case and stray characters', () {
    final census = PrefixCensus.build(nodes, bytes: 1);
    expect(
      census.lookup('#3d').map((c) => c.name),
      unorderedEquals(['Ridge', 'Tower']),
    );
    expect(census.lookup('3d4a').single.name, 'Ridge');
    expect(census.lookup('77'), isEmpty);
    expect(census.lookup('zz'), isEmpty);
  });

  test('free IDs skip the used ones', () {
    final census = PrefixCensus.build(nodes, bytes: 1);
    expect(census.freeOneByte, hasLength(254));
    expect(census.freeOneByte, isNot(contains('3D')));
    expect(census.isFree('3d'), isFalse);
    expect(census.isFree('3E'), isTrue);
    final picks = census.suggestFree(5, random: Random(1));
    expect(picks, hasLength(5));
    expect(picks.every(census.isFree), isTrue);
    final wide = PrefixCensus.build(
      nodes,
      bytes: 2,
    ).suggestFree(4, random: Random(2));
    expect(wide.every((id) => id.length == 4), isTrue);
  });

  test('keyPrefixHex formats uppercase hex at the given width', () {
    expect(keyPrefixHex(Uint8List.fromList([0x0a, 0xbc, 0xde]), 2), '0ABC');
  });
}
