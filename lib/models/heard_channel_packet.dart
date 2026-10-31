import '../services/signed_posts.dart';

/// A flood packet on one of this radio's channels, as the radio heard it
/// (LOG_RX_DATA) and decrypted with that channel's key: either a channel text
/// or a signed-post signature.
class HeardChannelPacket {
  const HeardChannelPacket({
    required this.packetHash,
    required this.hopCount,
    required this.channelIndex,
    this.senderName,
    this.text,
    this.timestamp,
    this.signedPost,
  });

  /// The firmware's packet hash (payload type + payload). Every copy of one
  /// packet has the same hash, however many repeaters it went through.
  final String packetHash;

  /// Repeaters the copy went through before this radio heard it.
  final int hopCount;
  final int channelIndex;

  /// Set for a channel text.
  final String? senderName;
  final String? text;

  /// The text's timestamp in seconds, or the signed post's.
  final int? timestamp;

  /// Set for a signed-post signature packet.
  final SignedPostPayload? signedPost;

  bool get isText => text != null;
}
