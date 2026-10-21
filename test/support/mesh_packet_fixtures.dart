import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;
import 'package:pointycastle/export.dart';

String hex(List<int> bytes) =>
    bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

/// A flood GRP_TXT packet encrypted the way companion firmware does it:
/// AES-128-ECB over zero-padded plaintext, 2-byte HMAC-SHA256 MAC.
Uint8List groupTextPacket({
  required Uint8List psk,
  required String text,
  int timestamp = 1760000000,
  List<int> path = const [],
}) {
  final body = utf8.encode(text);
  final plain = Uint8List(((5 + body.length + 1 + 15) ~/ 16) * 16)
    ..buffer.asByteData().setUint32(0, timestamp, Endian.little)
    ..[4] = 0
    ..setRange(5, 5 + body.length, body);
  final key16 = Uint8List(16)..setRange(0, psk.length.clamp(0, 16), psk);
  final cipher = ECBBlockCipher(AESEngine())..init(true, KeyParameter(key16));
  final encrypted = Uint8List(plain.length);
  for (var i = 0; i < plain.length; i += 16) {
    cipher.processBlock(plain, i, encrypted, i);
  }
  final key32 = Uint8List(32)..setRange(0, psk.length.clamp(0, 32), psk);
  final mac = crypto.Hmac(crypto.sha256, key32).convert(encrypted).bytes;
  final channelHash = crypto.sha256.convert(psk).bytes[0];
  return Uint8List.fromList([
    0x15, // flood route, GRP_TXT, version 0
    path.length,
    ...path,
    channelHash,
    mac[0],
    mac[1],
    ...encrypted,
  ]);
}

/// An observer message in the meshcoretomqtt `packets` format.
Uint8List observerMessage(
  Uint8List raw, {
  String direction = 'rx',
  String origin = 'Hilltop',
  String originId = 'AB12CD34',
}) => Uint8List.fromList(
  utf8.encode(
    jsonEncode({
      'origin': origin,
      'origin_id': originId,
      'timestamp': '2026-10-21T18:00:00Z',
      'type': 'PACKET',
      'direction': direction,
      'len': '${raw.length}',
      'packet_type': '5',
      'route': 'F',
      'raw': hex(raw).toUpperCase(),
      'SNR': '7.5',
      'RSSI': '-92',
      'hash': 'DEADBEEF',
    }),
  ),
);
