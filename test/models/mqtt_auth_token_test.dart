import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/mqtt_auth_token.dart';

Uint8List _hex(String hex) => Uint8List.fromList([
  for (var i = 0; i < hex.length; i += 2)
    int.parse(hex.substring(i, i + 2), radix: 16),
]);

Map<String, dynamic> _json(String part) =>
    jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(part))))
        as Map<String, dynamic>;

Future<bool> _verify(String token, String publicKeyHex) {
  final parts = token.split('.');
  return Ed25519().verify(
    ascii.encode('${parts[0]}.${parts[1]}'),
    signature: Signature(
      _hex(parts[2]),
      publicKey: SimplePublicKey(_hex(publicKeyHex), type: KeyPairType.ed25519),
    ),
  );
}

void main() {
  group('meshcoretomqtt reference token', () {
    // From Cisien/meshcoretomqtt tests/test_auth_token.py, captured there from
    // meshcore-decoder: sub "test-user", iat 1776541102, one-hour expiry.
    const publicKey =
        '4852b69364572b52efa1b6bb3e6d0abed4f389a1cbfbb60a9bba2cce649caf0e';
    const reference =
        'eyJhbGciOiJFZDI1NTE5IiwidHlwIjoiSldUIn0.eyJwdWJsaWNLZXkiOiI0ODUyQjY5'
        'MzY0NTcyQjUyRUZBMUI2QkIzRTZEMEFCRUQ0RjM4OUExQ0JGQkI2MEE5QkJBMkNDRTY0'
        'OUNBRjBFIiwiaWF0IjoxNzc2NTQxMTAyLCJleHAiOjE3NzY1NDQ3MDIsInN1YiI6InRl'
        'c3QtdXNlciJ9.ADEC2AD6CD692EE266CDD83956104ADA1F742CDD19E60C3CA0A7860B'
        'C26683C8F8FB47958BB13FC82DBCF84F76B06E644D69BC715497FD1457B012534072'
        '700A';
    final issuedAt = DateTime.fromMillisecondsSinceEpoch(
      1776541102 * 1000,
      isUtc: true,
    );

    test('builds the same header, claims and encoding byte for byte', () {
      final input = MeshCoreAuthToken.signingInput(
        MeshCoreAuthToken.claims(
          publicKeyHex: publicKey,
          issuedAt: issuedAt,
          lifetime: const Duration(hours: 1),
          extra: {'sub': 'test-user'},
        ),
      );
      final parts = reference.split('.');
      expect(input, '${parts[0]}.${parts[1]}');
      expect(MeshCoreAuthToken.assemble(input, _hex(parts[2])), reference);
    });

    test('its signature verifies as Ed25519 over header.claims', () async {
      expect(await _verify(reference, publicKey), isTrue);
      final tampered = reference.replaceFirst('ADEC2AD6', 'ADEC2AD7');
      expect(await _verify(tampered, publicKey), isFalse);
    });
  });

  group('MeshCoreAuthToken.create', () {
    // RFC 8032 section 7.1, test 1.
    final seed = _hex(
      '9d61b19deffd5a60ba844af492ec2cc44449c5697b326919703bac031cae7f60',
    );
    const publicKey =
        'd75a980182b10ab7d54bfed3c964073a0ee172f3daa62325af021a68f707511a';
    final issuedAt = DateTime.utc(2026, 10, 21, 18);

    late SimpleKeyPair keyPair;
    late List<Uint8List> signed;

    setUp(() async {
      keyPair = await Ed25519().newKeyPairFromSeed(seed);
      signed = [];
    });

    Future<Uint8List> sign(Uint8List data) async {
      signed.add(data);
      final signature = await Ed25519().sign(data, keyPair: keyPair);
      return Uint8List.fromList(signature.bytes);
    }

    test('the signer matches the RFC 8032 vector', () async {
      final empty = await Ed25519().sign(const [], keyPair: keyPair);
      expect(
        empty.bytes,
        _hex(
          'e5564300c360ac729086e2cc806e828a84877f1eb8e5d974d873e06522490155'
          '5fb8821590a33bacc61e39701cf9b46bd25bf5f0595bbe24655141438e7a100b',
        ),
      );
      expect((await keyPair.extractPublicKey()).bytes, _hex(publicKey));
    });

    test('signs header.claims and appends the signature as hex', () async {
      final token = await MeshCoreAuthToken.create(
        publicKeyHex: publicKey,
        issuedAt: issuedAt,
        sign: sign,
        audience: 'mqtt-us-v1.letsmesh.net',
        client: 'notoryx-core/10.0.0',
      );
      final parts = token.split('.');
      expect(parts, hasLength(3));
      expect(token, isNot(contains('=')));
      expect(_json(parts[0]), {'alg': 'Ed25519', 'typ': 'JWT'});
      final claims = _json(parts[1]);
      expect(claims.keys.toList(), [
        'publicKey',
        'iat',
        'exp',
        'aud',
        'client',
      ]);
      expect(claims['publicKey'], publicKey.toUpperCase());
      expect(claims['iat'], issuedAt.millisecondsSinceEpoch ~/ 1000);
      expect(claims['exp'], claims['iat'] + 3600);
      expect(claims['aud'], 'mqtt-us-v1.letsmesh.net');
      expect(claims['client'], 'notoryx-core/10.0.0');
      // Only the signing input reaches the radio, as ASCII.
      expect(signed.single, ascii.encode('${parts[0]}.${parts[1]}'));
      expect(parts[2], matches(RegExp(r'^[0-9A-F]{128}$')));
      expect(await _verify(token, publicKey), isTrue);
    });

    test('leaves out claims that are not set', () async {
      final token = await MeshCoreAuthToken.create(
        publicKeyHex: publicKey,
        issuedAt: issuedAt,
        sign: sign,
        lifetime: const Duration(minutes: 10),
      );
      final claims = _json(token.split('.')[1]);
      expect(claims.keys.toList(), ['publicKey', 'iat', 'exp']);
      expect(claims['exp'], claims['iat'] + 600);
    });

    test('rejects a signature of the wrong length', () {
      expect(
        () => MeshCoreAuthToken.assemble('a.b', Uint8List(63)),
        throwsArgumentError,
      );
    });

    test('usernames are v1_ and the uppercase key', () {
      expect(MeshCoreAuthToken.usernameFor('ab12'), 'v1_AB12');
    });
  });

  group('MqttTokenRefreshPolicy', () {
    const policy = MqttTokenRefreshPolicy();
    final issued = DateTime.utc(2026, 10, 21, 18);

    test('renews five minutes before the one-hour expiry', () {
      expect(policy.refreshAt(issued), DateTime.utc(2026, 10, 21, 18, 55));
      expect(
        policy.delayUntilRefresh(issued, issued),
        const Duration(minutes: 55),
      );
      expect(
        policy.delayUntilRefresh(
          issued,
          issued.add(const Duration(minutes: 50)),
        ),
        const Duration(minutes: 5),
      );
    });

    test('a token due for renewal is no longer fresh', () {
      expect(
        policy.isFresh(issued, issued.add(const Duration(minutes: 54))),
        isTrue,
      );
      expect(
        policy.isFresh(issued, issued.add(const Duration(minutes: 55))),
        isFalse,
      );
      expect(
        policy.delayUntilRefresh(issued, issued.add(const Duration(hours: 2))),
        Duration.zero,
      );
    });
  });
}
