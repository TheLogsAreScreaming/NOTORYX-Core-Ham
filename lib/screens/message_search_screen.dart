import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/l10n.dart';
import '../models/message_search.dart';
import 'channel_chat_screen.dart';
import 'chat_screen.dart';

/// Searches every saved direct and channel message on this radio.
class MessageSearchScreen extends StatefulWidget {
  const MessageSearchScreen({super.key});

  @override
  State<MessageSearchScreen> createState() => _MessageSearchScreenState();
}

class _MessageSearchScreenState extends State<MessageSearchScreen> {
  final _controller = TextEditingController();
  Timer? _debounce;
  List<SearchHit> _hits = const [];
  String _searched = '';
  bool _searching = false;
  int _generation = 0;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _changed(String text) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () => _run(text));
  }

  Future<void> _run(String query) async {
    final generation = ++_generation;
    final connector = context.read<MeshCoreConnector>();
    setState(() => _searching = true);
    final hits = await searchMessages(
      query: query,
      contacts: connector.contacts,
      channels: connector.channels,
      loadDirect: connector.loadFullConversation,
      loadChannel: connector.loadFullChannelHistory,
    );
    // A newer search started while this one ran.
    if (!mounted || generation != _generation) return;
    setState(() {
      _hits = hits;
      _searched = query;
      _searching = false;
    });
  }

  void _open(SearchHit hit) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => hit.contact != null
            ? ChatScreen(contact: hit.contact!)
            : ChannelChatScreen(channel: hit.channel!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final words = queryWords(_searched);
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          key: const ValueKey('message-search-field'),
          controller: _controller,
          autofocus: true,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: l10n.messageSearch_title,
            border: InputBorder.none,
          ),
          onChanged: _changed,
          onSubmitted: (q) {
            _debounce?.cancel();
            _run(q);
          },
        ),
        bottom: _searching
            ? const PreferredSize(
                preferredSize: Size.fromHeight(2),
                child: LinearProgressIndicator(minHeight: 2),
              )
            : null,
      ),
      body: words.isEmpty
          ? _Hint(l10n.messageSearch_intro)
          : _hits.isEmpty
          ? _Hint(l10n.messageSearch_noResults(_searched))
          : ListView.separated(
              itemCount: _hits.length + 1,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, i) {
                if (i == 0) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                    child: Text(
                      _hits.length >= 200
                          ? l10n.messageSearch_capped(200)
                          : l10n.messageSearch_count(_hits.length),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  );
                }
                final hit = _hits[i - 1];
                return ListTile(
                  leading: Icon(
                    hit.contact != null
                        ? Icons.person_outline
                        : Icons.forum_outlined,
                  ),
                  title: Text(
                    '${hit.conversation} • ${hit.sender}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text.rich(
                    highlighted(hit.text, words, Theme.of(context)),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(
                    _when(context, hit.timestamp),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  onTap: () => _open(hit),
                );
              },
            ),
    );
  }

  String _when(BuildContext context, DateTime t) {
    final local = t.toLocal();
    final now = DateTime.now();
    if (local.year == now.year &&
        local.month == now.month &&
        local.day == now.day) {
      return TimeOfDay.fromDateTime(local).format(context);
    }
    return MaterialLocalizations.of(context).formatShortMonthDay(local);
  }
}

/// [text] with the searched words in bold, accent-coloured spans.
TextSpan highlighted(String text, List<String> words, ThemeData theme) {
  final spans = <TextSpan>[];
  var at = 0;
  for (final (start, end) in highlightRanges(text, words)) {
    if (start > at) spans.add(TextSpan(text: text.substring(at, start)));
    spans.add(
      TextSpan(
        text: text.substring(start, end),
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: theme.colorScheme.primary,
        ),
      ),
    );
    at = end;
  }
  if (at < text.length) spans.add(TextSpan(text: text.substring(at)));
  return TextSpan(children: spans);
}

class _Hint extends StatelessWidget {
  final String text;
  const _Hint(this.text);

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Text(text, textAlign: TextAlign.center),
    ),
  );
}
