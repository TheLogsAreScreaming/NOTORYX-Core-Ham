import 'dart:convert';
import 'dart:typed_data';

import 'package:characters/characters.dart';
import 'package:crypto/crypto.dart';

import '../widgets/emoji_picker.dart';

/// Which reaction format a reaction arrived in.
///
/// [native] is ours (`r:HASH:INDEX`). [alternate] is the format another
/// MeshCore app uses: the emoji itself, `@[author]` in channels, a newline
/// and an 8-character hash of the target message.
enum ReactionHashType { native, alternate }

class ReactionInfo {
  final String targetHash;
  final String emoji;
  final ReactionHashType hashType;
  String? senderName;

  ReactionInfo({
    required this.targetHash,
    required this.emoji,
    this.hashType = ReactionHashType.native,
    this.senderName,
  });

  String identifier() {
    return '$targetHash:$emoji:${senderName ?? ""}';
  }
}

class ReactionHelper {
  /// Apply a reaction to a list of messages by matching the reaction hash.
  ///
  /// [messages] - the message list to search
  /// [reactionInfo] - the parsed reaction
  /// [getTimestampSecs] - extract timestamp seconds from a message
  /// [getSenderName] - extract sender name for hash (null for 1:1 implicit)
  /// [getMessageText] - extract message text
  /// [getReactions] - extract current reactions map
  /// [shouldSkip] - filter function to skip messages (e.g., skip outgoing for incoming reactions)
  /// [updateMessage] - callback to update the message at index with new reactions
  ///
  /// Returns whether a match was found.
  static bool applyReaction<T>({
    required List<T> messages,
    required ReactionInfo reactionInfo,
    required int Function(T) getTimestampSecs,
    required String? Function(T) getSenderName,
    required String Function(T) getMessageText,
    required Map<String, List<String?>> Function(T) getReactions,
    required bool Function(T) shouldSkip,
    updateMessage,
  }) {
    final targetHash = reactionInfo.targetHash;
    final hashFunc = switch (reactionInfo.hashType) {
      ReactionHashType.native => computeReactionHash,
      ReactionHashType.alternate =>
        (int ts, String? senderName, String text) =>
            _hashWithAuthor(computeAlternateReactionHash(ts, text), senderName),
    };
    for (int i = messages.length - 1; i >= 0; i--) {
      final msg = messages[i];
      if (shouldSkip(msg)) continue;

      final msgHash = hashFunc(
        getTimestampSecs(msg),
        getSenderName(msg),
        getMessageText(msg),
      );
      if (msgHash == targetHash) {
        final currentReactions = Map<String, List<String?>>.from(
          getReactions(msg),
        );
        (currentReactions[reactionInfo.emoji] ??= []).add(
          reactionInfo.senderName,
        );
        updateMessage(i, currentReactions);
        return true;
      }
    }
    return false;
  }

  static List<String>? _cachedEmojis;

  /// Combined list of all reaction emojis in fixed order.
  /// Order must stay stable for index compatibility.
  static List<String> get reactionEmojis {
    return _cachedEmojis ??= [
      ...EmojiPicker.quickEmojis,
      ...EmojiPicker.smileys,
      ...EmojiPicker.gestures,
      ...EmojiPicker.hearts,
      ...EmojiPicker.objects,
    ];
  }

  /// Convert emoji to 2-char hex index. Returns null if emoji not in list.
  static String? emojiToIndex(String emoji) {
    final idx = reactionEmojis.indexOf(emoji);
    if (idx < 0) return null;
    return idx.toRadixString(16).padLeft(2, '0');
  }

  /// Convert 2-char hex index to emoji. Returns null if invalid index.
  static String? indexToEmoji(String hexIndex) {
    final idx = int.tryParse(hexIndex, radix: 16);
    if (idx == null || idx < 0 || idx >= reactionEmojis.length) return null;
    return reactionEmojis[idx];
  }

  /// Compute a 4-char hex hash for a message reaction.
  /// Hash input: timestampSeconds + [senderName] + first 5 chars of text
  /// For 1:1 chats, senderName can be null (sender is implicit).
  static String computeReactionHash(
    int timestampSeconds,
    String? senderName,
    String text,
  ) {
    final first5 = text.length >= 5 ? text.substring(0, 5) : text;
    final input = senderName != null
        ? '$timestampSeconds$senderName$first5'
        : '$timestampSeconds$first5';
    // Use hashCode and take lower 16 bits, format as 4 hex chars
    final hash = input.hashCode & 0xFFFF;
    return hash.toRadixString(16).padLeft(4, '0');
  }

  /// Parses a reaction in any format we read; null if [text] is not one.
  static ReactionInfo? parseReaction(String text) {
    return parseNativeReaction(text) ??
        parseAlternateReaction(text) ??
        parseAlternateReactionLegacy(text);
  }

  /// The alternate format's hash: the first 5 bytes of
  /// SHA-256(UTF-8 text + uint32-LE timestamp), as 8 lowercase Crockford
  /// base32 characters. It does not include the author's name.
  static String computeAlternateReactionHash(
    int timestampSeconds,
    String messageText,
  ) {
    final timestamp = ByteData(4)
      ..setUint32(0, timestampSeconds, Endian.little);
    final digest = sha256.convert([
      ...utf8.encode(messageText),
      ...timestamp.buffer.asUint8List(),
    ]).bytes;
    var bits = 0;
    for (var i = 0; i < 5; i++) {
      bits = (bits << 8) | digest[i];
    }
    const alphabet = '0123456789abcdefghjkmnpqrstvwxyz';
    final out = StringBuffer();
    for (var shift = 35; shift >= 0; shift -= 5) {
      out.write(alphabet[(bits >> shift) & 0x1F]);
    }
    return out.toString();
  }

  /// The alternate format names the target's author separately from its
  /// hash, so both are compared together as `hash:author` (author empty in
  /// direct messages).
  static String _hashWithAuthor(String hash, String? author) =>
      '$hash:${author ?? ''}';

  /// Whether [text] is a single emoji, to avoid reading prose as a reaction.
  static bool _looksLikeEmoji(String text) {
    if (text.isEmpty || text.characters.length != 1) return false;
    final runes = text.runes;
    return runes.first >= 0x2000 ||
        runes.any((r) => r == 0xFE0F || r == 0x20E3);
  }

  static ReactionInfo? _alternate(String? author, String emoji, String hash) {
    if (!_looksLikeEmoji(emoji)) return null;
    return ReactionInfo(
      targetHash: _hashWithAuthor(hash.toLowerCase(), author),
      emoji: emoji,
      hashType: ReactionHashType.alternate,
    );
  }

  /// Alternate format: `@[author]` (channels only), the emoji, a newline,
  /// then the 8-character hash.
  static ReactionInfo? parseAlternateReaction(String text) {
    final match = RegExp(
      r'^(?:@\[(.*)])?(.+?)\n([a-tv-zA-TV-Z0-9]{8})$',
    ).firstMatch(text);
    if (match == null) return null;
    return _alternate(match.group(1), match.group(2)!, match.group(3)!);
  }

  /// Older version of the alternate format, with the author after the emoji.
  static ReactionInfo? parseAlternateReactionLegacy(String text) {
    final match = RegExp(
      r'^(.+?)(?:@\[(.*)])?\n([a-tv-zA-TV-Z0-9]{8})$',
    ).firstMatch(text);
    if (match == null) return null;
    return _alternate(match.group(2), match.group(1)!, match.group(3)!);
  }

  /// Parse reaction format: r:HASH:INDEX (where INDEX is 2-char hex emoji index)
  /// Returns null if text is not a valid reaction format
  static ReactionInfo? parseNativeReaction(String text) {
    final regex = RegExp(r'^r:([0-9a-f]{4}):([0-9a-f]{2})$');
    final match = regex.firstMatch(text);
    if (match == null) return null;

    final emoji = indexToEmoji(match.group(2)!);
    if (emoji == null) return null;

    return ReactionInfo(targetHash: match.group(1)!, emoji: emoji);
  }

  /// Encode a reaction message that parseReaction() can parse.
  static String encodeReaction(String hash, String emojiIndex) {
    return 'r:$hash:$emojiIndex';
  }
}
