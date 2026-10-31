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
  final plain = Uint8List(5 + body.length)
    ..buffer.asByteData().setUint32(0, timestamp, Endian.little)
    ..[4] = 0
    ..setRange(5, 5 + body.length, body);
  return _groupPacket(0x15, psk, plain, path); // flood route, GRP_TXT
}

/// A flood GRP_DATA packet: `[data type u16 LE][length][data]`, encrypted
/// like [groupTextPacket].
Uint8List groupDataPacket({
  required Uint8List psk,
  required int dataType,
  required List<int> data,
  List<int> path = const [],
}) {
  final plain = Uint8List.fromList([
    dataType & 0xFF,
    dataType >> 8,
    data.length,
    ...data,
  ]);
  return _groupPacket(0x19, psk, plain, path); // flood route, GRP_DATA
}

Uint8List _groupPacket(
  int header,
  Uint8List psk,
  Uint8List body,
  List<int> path,
) {
  // Zero-padded to whole blocks; a text keeps at least one zero terminator.
  final plain = Uint8List(((body.length + 1 + 15) ~/ 16) * 16)
    ..setRange(0, body.length, body);
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
    header,
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
