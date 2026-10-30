import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/region_scope.dart';

void main() {
  final payload = Uint8List.fromList(List.generate(20, (i) => i));

  test('matches an independent HMAC of MeshCore’s formula', () {
    // From Python: hmac(sha256(b"#ct")[:16], b"\x05" + bytes(range(20))),
    // first two bytes little-endian.
    expect(regionTransportCode(regionKey('ct'), 5, payload), 18725);
    expect(regionKey('#ct'), regionKey('ct'));
  });

  test('names the region whose code matches', () {
    final code = regionTransportCode(regionKey('ct'), 5, payload);
    expect(matchRegion(code, 5, payload, ['usa', 'us-ne', 'ct']), 'ct');
    expect(matchRegion(code, 5, payload, ['#ct']), 'ct');
  });

  test('a scoped packet from an unknown region is still marked', () {
    final code = regionTransportCode(regionKey('somewhere'), 5, payload);
    expect(matchRegion(code, 5, payload, ['usa', 'ct']), unknownRegion);
  });

  test('code 0 means not scoped', () {
    expect(matchRegion(0, 5, payload, ['ct']), isNull);
  });

  test('a different payload gives a different code', () {
    final other = Uint8List.fromList([...payload]..[0] = 99);
    final code = regionTransportCode(regionKey('ct'), 5, payload);
    expect(matchRegion(code, 5, other, ['ct']), unknownRegion);
  });
}
