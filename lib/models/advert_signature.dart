import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

/// Advert payload layout: `[public key 32][timestamp 4][signature 64]
/// [app data...]`. The signature covers the key, the timestamp and the app
/// data, as MeshCore firmware signs and checks it.
const int _keyBytes = 32;
const int _signatureStart = _keyBytes + 4;
const int _appDataStart = _signatureStart + 64;

/// Whether the advert [payload] carries a valid signature from its own key.
/// A packet garbled on air or a junk MQTT copy fails, so it never becomes a
/// contact with a random key and a name made of noise.
Future<bool> verifyAdvertPayload(Uint8List payload) async {
  if (payload.length < _appDataStart) return false;
  final message = BytesBuilder(copy: false)
    ..add(payload.sublist(0, _signatureStart))
    ..add(payload.sublist(_appDataStart));
  try {
    return await Ed25519().verify(
      message.toBytes(),
      signature: Signature(
        payload.sublist(_signatureStart, _appDataStart),
        publicKey: SimplePublicKey(
          payload.sublist(0, _keyBytes),
          type: KeyPairType.ed25519,
        ),
      ),
    );
  } catch (_) {
    return false;
  }
}

/// Remembers adverts already verified, so the same advert heard through
/// several repeaters is only checked once.
class VerifiedAdverts {
  VerifiedAdverts({this.limit = 256});

  final int limit;
  final Set<String> _seen = {};

  /// The whole payload as a key: a corrupted copy of a verified advert
  /// must not match it.
  static String? _keyOf(Uint8List payload) =>
      payload.length < _appDataStart ? null : String.fromCharCodes(payload);

  Future<bool> verify(Uint8List payload) async {
    final key = _keyOf(payload);
    if (key == null) return false;
    if (_seen.contains(key)) return true;
    if (!await verifyAdvertPayload(payload)) return false;
    _seen.add(key);
    if (_seen.length > limit) _seen.remove(_seen.first);
    return true;
  }
}

/// Whether a saved contact looks like one made from a corrupt advert: a node
/// type MeshCore doesn't have, or a name with undecodable or control
/// characters.
bool looksCorrupt(int type, String name) =>
    type < 1 ||
    type > 4 ||
    name.runes.any((r) => r == 0xFFFD || r < 0x20 || r == 0x7F);
