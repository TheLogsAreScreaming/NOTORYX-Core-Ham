import 'dart:typed_data';

/// A raw packet the connected radio heard (PUSH_CODE_LOG_RX_DATA).
class RadioRxPacket {
  const RadioRxPacket({
    required this.raw,
    required this.snr,
    required this.rssi,
    required this.receivedAt,
    this.fromSelf = false,
    this.station,
  });

  final Uint8List raw;
  final double snr;
  final int rssi;
  final DateTime receivedAt;

  /// Whether this looks like this radio's own traffic: its advert, a channel
  /// message it sent, or a direct packet whose source hash matches it. The
  /// one-byte source hash can match other nodes too, which errs toward
  /// keeping traffic private.
  final bool fromSelf;

  /// Call sign of the station that transmitted this frame (the sender, or
  /// the repeater that relayed it), from the amateur station ID.
  final String? station;
}
