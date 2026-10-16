import '../models/channel.dart';
import '../models/channel_message.dart';
import '../models/contact.dart';
import '../models/message.dart';

/// One matching message.
class SearchHit {
  /// The direct conversation, or null for a channel message.
  final Contact? contact;

  /// The channel, or null for a direct message.
  final Channel? channel;
  final String sender;
  final String text;
  final DateTime timestamp;
  final bool isOutgoing;

  const SearchHit({
    this.contact,
    this.channel,
    required this.sender,
    required this.text,
    required this.timestamp,
    required this.isOutgoing,
  });

  String get conversation =>
      contact?.name ??
      (channel!.name.isEmpty ? 'Channel ${channel!.index}' : channel!.name);
}

/// Words of [query], lowercased; empty if there is nothing to search for.
List<String> queryWords(String query) => query
    .toLowerCase()
    .split(RegExp(r'\s+'))
    .where((w) => w.isNotEmpty)
    .toList();

/// True when [text] contains every word of the query, in any order and case.
bool matchesWords(String text, List<String> words) {
  if (words.isEmpty) return false;
  final lower = text.toLowerCase();
  return words.every(lower.contains);
}

/// The ranges of [text] to highlight for [words], merged and in order.
List<(int, int)> highlightRanges(String text, List<String> words) {
  final lower = text.toLowerCase();
  final ranges = <(int, int)>[];
  for (final w in words) {
    var from = 0;
    while (true) {
      final i = lower.indexOf(w, from);
      if (i < 0) break;
      ranges.add((i, i + w.length));
      from = i + w.length;
    }
  }
  ranges.sort((a, b) => a.$1.compareTo(b.$1));
  final merged = <(int, int)>[];
  for (final r in ranges) {
    if (merged.isNotEmpty && r.$1 <= merged.last.$2) {
      final last = merged.removeLast();
      merged.add((last.$1, r.$2 > last.$2 ? r.$2 : last.$2));
    } else {
      merged.add(r);
    }
  }
  return merged;
}

/// Searches every direct conversation and channel, newest first.
Future<List<SearchHit>> searchMessages({
  required String query,
  required List<Contact> contacts,
  required List<Channel> channels,
  required Future<List<Message>> Function(Contact) loadDirect,
  required Future<List<ChannelMessage>> Function(Channel) loadChannel,
  int limit = 200,
}) async {
  final words = queryWords(query);
  if (words.isEmpty) return const [];
  final hits = <SearchHit>[];
  for (final contact in contacts) {
    for (final m in await loadDirect(contact)) {
      if (m.isCli || !matchesWords(m.text, words)) continue;
      hits.add(
        SearchHit(
          contact: contact,
          sender: m.isOutgoing ? 'You' : contact.name,
          text: m.text,
          timestamp: m.timestamp,
          isOutgoing: m.isOutgoing,
        ),
      );
    }
  }
  for (final channel in channels) {
    if (channel.isEmpty) continue;
    for (final m in await loadChannel(channel)) {
      if (!matchesWords(m.text, words)) continue;
      hits.add(
        SearchHit(
          channel: channel,
          sender: m.isOutgoing ? 'You' : m.senderName,
          text: m.text,
          timestamp: m.timestamp,
          isOutgoing: m.isOutgoing,
        ),
      );
    }
  }
  hits.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  return hits.length > limit ? hits.sublist(0, limit) : hits;
}
