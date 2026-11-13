import 'channel_message.dart';
import 'message.dart';

/// A direct message's reply, worked out from its text when it is shown.
///
/// The `@[name] ` prefix stays in the stored text, because retries and
/// delivery acks are computed from exactly what went over the air.
class DirectQuote {
  const DirectQuote({
    required this.name,
    required this.body,
    required this.originalText,
  });

  /// Who was replied to, as the sender wrote it.
  final String name;

  /// The reply without its prefix.
  final String body;

  /// The message it answers, or null when that's no longer loaded.
  final String? originalText;
}

/// The quote carried by `newestFirst[index]`, or null if it isn't a reply.
///
/// A direct chat has two people, so a reply answers the other person's most
/// recent earlier message. Like channel replies this is a best match, since
/// the wire format carries a name and not a message id.
DirectQuote? directQuoteFor(List<Message> newestFirst, int index) {
  final message = newestFirst[index];
  if (message.isCli) return null;
  final reply = ChannelMessage.parseReplyMention(message.text);
  if (reply == null) return null;
  String? original;
  for (var i = index + 1; i < newestFirst.length; i++) {
    final earlier = newestFirst[i];
    if (earlier.isOutgoing != message.isOutgoing && !earlier.isCli) {
      original =
          ChannelMessage.parseReplyMention(earlier.text)?.actualMessage ??
          earlier.text;
      break;
    }
  }
  return DirectQuote(
    name: reply.mentionedNode,
    body: reply.actualMessage,
    originalText: original,
  );
}
