import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/foundation.dart';

import '../models/channel_message.dart';
import '../models/contact.dart';

/// Signed channel posts.
///
/// A signed post is an ordinary channel text followed by one GRP_DATA
/// packet of type [dataTypeSignedPost] carrying the sender's public key, the
/// text's timestamp and an Ed25519 signature made by the radio. Apps that
/// don't know the data type drop the packet, so they see the text and no
/// clutter. The text itself is never changed.
///
/// A post whose signature doesn't check out is shown as unverified, never as
/// forged: a mangled packet, a renamed node or a different app can all cause
/// it.

/// GRP_DATA type for a post signature. 0xAE1C is images.
const int dataTypeSignedPost = 0xAE51;

const int _payloadVersion = 1;
const int signedPostPayloadBytes = 1 + 32 + 4 + 64;
const String _domain = 'notoryx-sig/1\n';

/// The bytes a post's signature covers: a domain tag, the text's timestamp
/// and the text exactly as receivers display it, prefixed by the sender's
/// name the way the radio sends it.
Uint8List signedPostInput({
  required int timestamp,
  required String senderName,
  required String text,
}) {
  final out = BytesBuilder()
    ..add(utf8.encode(_domain))
    ..add([
      timestamp & 0xFF,
      (timestamp >> 8) & 0xFF,
      (timestamp >> 16) & 0xFF,
      (timestamp >> 24) & 0xFF,
    ])
    ..add(utf8.encode('$senderName: $text'));
  return out.toBytes();
}

/// Whether [name] survives the receiver's "name: text" split unchanged, so
/// the signed name is the one receivers see. Signing a name that doesn't
/// would always show as unverified.
bool canSignAs(String name) =>
    name.isNotEmpty && name.length < 50 && !RegExp(r'[:\[\]]').hasMatch(name);

/// The signature packet: `[version][public key 32][timestamp u32 LE]
/// [signature 64]`, 101 bytes.
class SignedPostPayload {
  final Uint8List publicKey;
  final int timestamp;
  final Uint8List signature;

  SignedPostPayload({
    required this.publicKey,
    required this.timestamp,
    required this.signature,
  }) {
    if (publicKey.length != 32) {
      throw ArgumentError.value(publicKey.length, 'publicKey', 'must be 32');
    }
    if (signature.length != 64) {
      throw ArgumentError.value(signature.length, 'signature', 'must be 64');
    }
  }

  Uint8List encode() {
    final ts = ByteData(4)..setUint32(0, timestamp, Endian.little);
    return (BytesBuilder()
          ..addByte(_payloadVersion)
          ..add(publicKey)
          ..add(ts.buffer.asUint8List())
          ..add(signature))
        .toBytes();
  }

  /// The payload in [bytes], or null when it isn't a version this app
  /// understands.
  static SignedPostPayload? decode(Uint8List bytes) {
    if (bytes.length < signedPostPayloadBytes || bytes[0] != _payloadVersion) {
      return null;
    }
    final view = ByteData.sublistView(bytes);
    return SignedPostPayload(
      publicKey: Uint8List.fromList(bytes.sublist(1, 33)),
      timestamp: view.getUint32(33, Endian.little),
      signature: Uint8List.fromList(bytes.sublist(37, 101)),
    );
  }
}

/// Whether [payload] signs [text] posted by [senderName].
Future<bool> verifySignedPost(
  SignedPostPayload payload, {
  required String senderName,
  required String text,
}) async {
  try {
    return await Ed25519().verify(
      signedPostInput(
        timestamp: payload.timestamp,
        senderName: senderName,
        text: text,
      ),
      signature: Signature(
        payload.signature,
        publicKey: SimplePublicKey(
          payload.publicKey,
          type: KeyPairType.ed25519,
        ),
      ),
    );
  } catch (_) {
    return false;
  }
}

/// Signatures waiting for their text. The text and its signature are two
/// flood packets and either may arrive first, so a signature that matches
/// nothing yet is held for [maxAge].
class PendingSignatures {
  PendingSignatures({this.maxAge = const Duration(minutes: 10)});

  final Duration maxAge;
  static const _limit = 64;
  final List<({int channel, SignedPostPayload payload, DateTime at})> _held =
      [];

  void add(int channel, SignedPostPayload payload, DateTime now) {
    _prune(now);
    _held.removeWhere(
      (e) =>
          e.channel == channel &&
          listEquals(e.payload.signature, payload.signature),
    );
    _held.add((channel: channel, payload: payload, at: now));
    if (_held.length > _limit) _held.removeAt(0);
  }

  /// The held signatures for a text on [channel] sent at [timestamp].
  List<SignedPostPayload> candidates(int channel, int timestamp, DateTime now) {
    _prune(now);
    return [
      for (final e in _held)
        if (e.channel == channel && e.payload.timestamp == timestamp) e.payload,
    ];
  }

  /// Drops [payload] once a text has claimed it.
  void remove(SignedPostPayload payload) => _held.removeWhere(
    (e) => listEquals(e.payload.signature, payload.signature),
  );

  @visibleForTesting
  int get length => _held.length;

  void _prune(DateTime now) =>
      _held.removeWhere((e) => now.difference(e.at) > maxAge);
}

/// What the chat shows for a post's signature.
enum SignatureBadge {
  /// Signed by a key in your contacts.
  known,

  /// Signed, by a key you don't have as a contact.
  unknownKey,

  /// A signature came with it but didn't check out.
  unverified,
}

/// The badge for [message], or null for an unsigned post. A valid signature
/// from an unknown key that uses the name of one of your contacts is
/// treated as unverified: someone else signed under that name.
({SignatureBadge badge, String? signer})? signatureBadgeFor(
  ChannelMessage message,
  Iterable<Contact> contacts, {
  Uint8List? selfKey,
}) {
  switch (message.signature) {
    case ChannelSignature.none:
      return null;
    case ChannelSignature.invalid:
      return (badge: SignatureBadge.unverified, signer: null);
    case ChannelSignature.valid:
      final key = message.signerKey;
      if (key == null) return (badge: SignatureBadge.unverified, signer: null);
      if (selfKey != null && listEquals(key, selfKey)) {
        return (badge: SignatureBadge.known, signer: message.senderName);
      }
      for (final c in contacts) {
        if (listEquals(c.publicKey, key)) {
          return (badge: SignatureBadge.known, signer: c.name);
        }
      }
      final impersonates = contacts.any(
        (c) => c.name.trim() == message.senderName.trim(),
      );
      return impersonates
          ? (badge: SignatureBadge.unverified, signer: null)
          : (badge: SignatureBadge.unknownKey, signer: null);
  }
}
