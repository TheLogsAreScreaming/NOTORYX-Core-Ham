import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;

String hex(List<int> bytes) =>
    bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

/// A flood GRP_TXT packet the way the ham firmware builds it: plain text,
/// zero padded to 16-byte blocks, 2-byte HMAC-SHA256 MAC. This is the V1
/// packet the app parses; [onAir] adds what the radio actually sends.
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

/// A flood GRP_DATA packet: `[data type u16 LE][length][data]`, built like
/// [groupTextPacket].
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
  final key32 = Uint8List(32)..setRange(0, psk.length.clamp(0, 32), psk);
  final mac = crypto.Hmac(crypto.sha256, key32).convert(plain).bytes;
  final channelHash = crypto.sha256.convert(psk).bytes[0];
  return Uint8List.fromList([
    header,
    path.length,
    ...path,
    channelHash,
    mac[0],
    mac[1],
    ...plain,
  ]);
}

/// [packet] as the ham firmware puts it on air (and logs it in LOG_RX_DATA):
/// header marked payload version 2, then the station ID, zero padded to 8.
Uint8List onAir(Uint8List packet, {String station = 'W1AW'}) {
  final id = Uint8List(8)..setRange(0, station.length, ascii.encode(station));
  return Uint8List.fromList([
    (packet[0] & 0x3F) | 0x40,
    ...packet.sublist(1),
    ...id,
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
