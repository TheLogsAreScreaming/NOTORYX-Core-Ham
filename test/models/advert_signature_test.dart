import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/advert_signature.dart';

/// A real advert payload: `[key][timestamp][signature][app data]`, signed
/// the way MeshCore firmware signs it.
Future<Uint8List> signedAdvert(String name) async {
  final algo = Ed25519();
  final pair = await algo.newKeyPairFromSeed(List.filled(32, 7));
  final key = Uint8List.fromList((await pair.extractPublicKey()).bytes);
  final ts = Uint8List(4)
    ..buffer.asByteData().setUint32(0, 1761782400, Endian.little);
  final appData = Uint8List.fromList([0x82, ...utf8.encode(name)]);
  final signature = await algo.sign([...key, ...ts, ...appData], keyPair: pair);
  return Uint8List.fromList([...key, ...ts, ...signature.bytes, ...appData]);
}

void main() {
  test('a correctly signed advert verifies', () async {
    expect(await verifyAdvertPayload(await signedAdvert('Ridge')), isTrue);
  });

  test('a garbled name or key fails', () async {
    final advert = await signedAdvert('Ridge');
    final name = Uint8List.fromList(advert)..[advert.length - 1] ^= 0x40;
    final key = Uint8List.fromList(advert)..[3] ^= 0x01;
    expect(await verifyAdvertPayload(name), isFalse);
    expect(await verifyAdvertPayload(key), isFalse);
  });

  test('a payload too short to hold a signature fails', () async {
    expect(await verifyAdvertPayload(Uint8List(99)), isFalse);
  });

  test('the cache accepts a repeat but not a corrupted copy', () async {
    final cache = VerifiedAdverts();
    final advert = await signedAdvert('Ridge');
    expect(await cache.verify(advert), isTrue);
    expect(await cache.verify(Uint8List.fromList(advert)), isTrue);
    final bad = Uint8List.fromList(advert)..[advert.length - 1] ^= 0x40;
    expect(await cache.verify(bad), isFalse);
  });

  test('looksCorrupt flags impossible types and noise names', () {
    expect(looksCorrupt(2, 'MM5 RAK 1W'), isFalse);
    expect(looksCorrupt(1, 'Mud Cricket 🦗'), isFalse);
    expect(looksCorrupt(0, 'Ridge'), isTrue);
    expect(looksCorrupt(9, 'Ridge'), isTrue);
    expect(looksCorrupt(1, 'N��B'), isTrue);
    expect(looksCorrupt(1, 'a\u0007b'), isTrue);
  });
}
