import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/path_graph.dart';

final _t = DateTime.utc(2026, 10, 16, 13);

PathObservation _path(List<String> hops, {String source = 'test'}) =>
    PathObservation(
      hops: hops,
      width: hops.first.length ~/ 2,
      at: _t,
      source: source,
    );

Contact _repeater(String keyHexPrefix, String name) {
  final hex = keyHexPrefix.padRight(64, '0');
  return Contact(
    publicKey: Uint8List.fromList([
      for (var i = 0; i < 64; i += 2)
        int.parse(hex.substring(i, i + 2), radix: 16),
    ]),
    name: name,
    type: advTypeRepeater,
    pathLength: -1,
    path: Uint8List(0),
    lastSeen: _t,
  );
}

void main() {
  test('splits raw path bytes by hash width', () {
    final o = PathObservation.fromBytes(
      [0xab, 0x12, 0xcd, 0x34],
      width: 2,
      at: _t,
      source: 's',
    );
    expect(o.hops, ['AB12', 'CD34']);
    expect(
      PathObservation.fromBytes(
        [0xab, 0xcd],
        width: 1,
        at: _t,
        source: 's',
      ).hops,
      ['AB', 'CD'],
    );
  });

  test('a 1-byte hop with only one known longer prefix is upgraded', () {
    final g = PathGraph.build([
      _path(['AB12', 'CD34']),
      _path(['AB']),
    ]);
    expect(g.resolvedPaths.last, ['AB12']);
    expect(g.upgradedHops, 1);
    expect(g.nodes['AB12']!.relays, 2);
  });

  test('neighbours from longer paths tell two "AB" repeaters apart', () {
    final g = PathGraph.build([
      // Multi-byte paths reveal two repeaters starting AB, each with its own
      // neighbour.
      _path(['AB12', 'CD34']),
      _path(['EF56', 'AB99']),
      // Short paths: AB next to CD is AB12; AB next to EF is AB99.
      _path(['AB', 'CD']),
      _path(['EF', 'AB']),
    ]);
    expect(g.resolvedPaths[2], ['AB12', 'CD34']);
    expect(g.resolvedPaths[3], ['EF56', 'AB99']);
    expect(g.ambiguousHops, 0);
  });

  test('a short hop with nothing to go on stays ambiguous', () {
    final g = PathGraph.build([
      _path(['AB12', 'CD34']),
      _path(['AB99', 'CD77']),
      _path(['AB']),
    ]);
    expect(g.resolvedPaths.last, ['AB']);
    expect(g.nodes['AB']!.ambiguous, isTrue);
    expect(g.nodes['AB']!.label, 'AB?');
    expect(g.ambiguousHops, 1);
  });

  test('2- and 3-byte prefixes of one repeater merge and take its name', () {
    final g = PathGraph.build(
      [
        _path(['AB12', 'CD34']),
        _path(['AB12EE']),
      ],
      contacts: [_repeater('AB12EE', 'Ridge')],
    );
    expect(g.nodes.containsKey('AB12'), isFalse);
    expect(g.nodes['AB12EE']!.relays, 2);
    expect(g.nodes['AB12EE']!.label, 'Ridge');
  });

  test('flows end at you and columns count hops back from you', () {
    final g = PathGraph.build([
      _path(['AB12', 'CD34']),
      _path(['EF56', 'CD34']),
      _path(['CD34']),
    ]);
    final toMe = g.links.firstWhere((l) => l.to == pathGraphSelf);
    expect(toMe.from, 'CD34');
    expect(toMe.count, 3);
    final cols = g.columns();
    expect(cols[0], [pathGraphSelf]);
    expect(cols[1], ['CD34']);
    expect(cols[2].toSet(), {'AB12', 'EF56'});
    expect(g.busiest.first.id, 'CD34');
  });
}
