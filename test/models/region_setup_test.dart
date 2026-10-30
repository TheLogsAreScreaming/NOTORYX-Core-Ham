import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/region_setup.dart';

void main() {
  final trees = parseRegionTrees(
    File('assets/region_trees.json').readAsStringSync(),
  );
  final us = trees.firstWhere((t) => t.id == 'us');

  test('the US tree walks from a state up to the whole country', () {
    expect(us.chainFor('ct'), ['usa', 'us-ne', 'ct']);
    expect(us.chainFor('usa'), ['usa']);
    expect(us.chainFor('nope'), isEmpty);
  });

  test('the bundled trees cover every US state and Canadian province', () {
    expect(
      us.regions.values.where((r) => r.parent?.startsWith('us-') ?? false),
      hasLength(51),
    );
    final canada = trees.firstWhere((t) => t.id == 'canada');
    expect(
      canada.regions.values.where((r) => r.parent == 'canada'),
      hasLength(13),
    );
  });

  test('the tree lists parents before their children', () {
    final names = us.ordered().map((e) => e.$1.name).toList();
    expect(names.first, 'usa');
    expect(names.indexOf('us-ne'), lessThan(names.indexOf('ct')));
    final depth = {for (final (n, d) in us.ordered()) n.name: d};
    expect(depth['ct'], 2);
  });

  test('a loop in the tree does not hang', () {
    final looped = parseRegionTrees('''
{"trees": [{"id": "x", "name": "X", "regions": [
  {"name": "a", "parent": "b"}, {"name": "b", "parent": "a"}]}]}''');
    expect(looped.single.chainFor('a'), ['b', 'a']);
  });

  test('invalid region names are skipped', () {
    final t = parseRegionTrees('''
{"trees": [{"id": "x", "name": "X", "regions": [
  {"name": "Good-Not"}, {"name": "ok"}, {"name": "x", "parent": "BAD"}]}]}''');
    expect(t.single.regions.keys, ['ok']);
  });

  test('builds the commands, broadest first', () {
    expect(regionSetupCommands(['west', 'pnw', 'sea'], defaultRegion: 'sea'), [
      'region put west',
      'region put pnw west',
      'region put sea pnw',
      'region default sea',
      'region save',
    ]);
  });

  test('firmware 1.14 and unscoped blocking add their commands', () {
    expect(
      regionSetupCommands(
        ['west', 'pnw'],
        legacyFirmware: true,
        denyUnscoped: true,
      ),
      [
        'region put west',
        'region allowf west',
        'region put pnw west',
        'region allowf pnw',
        'region denyf *',
        'region save',
      ],
    );
  });

  test('typed chains are split, lowercased and de-duplicated', () {
    expect(parseRegionChain('West > PNW, wa›wa  sea'), [
      'west',
      'pnw',
      'wa',
      'sea',
    ]);
    expect(isValidRegionName('w-wa'), isTrue);
    expect(isValidRegionName('W_WA'), isFalse);
    expect(isValidRegionName('a' * 30), isFalse);
  });
}
