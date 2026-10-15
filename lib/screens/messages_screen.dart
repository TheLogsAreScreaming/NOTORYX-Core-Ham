import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../helpers/gif_helper.dart';
import '../l10n/l10n.dart';
import '../models/channel.dart';
import '../models/contact.dart';
import '../theme/mesh_theme.dart';
import '../utils/disconnect_navigation_mixin.dart';
import '../utils/main_tab_navigation.dart';
import '../widgets/app_bar.dart';
import '../widgets/empty_state.dart';
import '../widgets/mesh_ui.dart';
import '../widgets/quick_switch_bar.dart';
import '../widgets/radio_status_card.dart';
import '../widgets/sync_progress_overlay.dart';
import 'channel_chat_screen.dart';
import 'channels_screen.dart';
import 'chat_screen.dart';

enum _MessagesFilter { all, direct, channels }

/// One row of the inbox: a direct conversation or a channel.
class _Conversation {
  final Contact? contact;
  final Channel? channel;
  final String title;
  final String preview;
  final DateTime? lastAt;
  final int unread;

  const _Conversation({
    this.contact,
    this.channel,
    required this.title,
    required this.preview,
    required this.lastAt,
    required this.unread,
  });

  bool get isChannel => channel != null;
}

/// The home tab: every direct conversation and channel in one list, newest
/// first, with the connected radio's status on top.
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with DisconnectNavigationMixin {
  _MessagesFilter _filter = _MessagesFilter.all;
  bool _searching = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  String _previewText(BuildContext context, String text) {
    if (text.isNotEmpty && GifHelper.parseGif(text) != null) {
      return context.l10n.chat_receivedGif;
    }
    return text.replaceAll('\n', ' ');
  }

  List<_Conversation> _directConversations(
    BuildContext context,
    MeshCoreConnector connector,
  ) {
    final l10n = context.l10n;
    final result = <_Conversation>[];
    for (final contact in connector.contacts) {
      if (contact.type != advTypeChat) continue;
      final messages = connector
          .getMessages(contact)
          .where((m) => !m.isCli)
          .toList();
      if (messages.isEmpty) continue;
      final last = messages.last;
      final text = _previewText(context, last.text);
      result.add(
        _Conversation(
          contact: contact,
          title: contact.name,
          preview: last.isOutgoing ? l10n.messages_you(text) : text,
          lastAt: last.timestamp,
          unread: connector.getUnreadCountForContactKey(contact.publicKeyHex),
        ),
      );
    }
    return result;
  }

  List<_Conversation> _channelConversations(
    BuildContext context,
    MeshCoreConnector connector,
  ) {
    final l10n = context.l10n;
    final result = <_Conversation>[];
    for (final channel in connector.channels) {
      if (channel.isEmpty) continue;
      final messages = connector.getChannelMessages(channel);
      final last = messages.isNotEmpty ? messages.last : null;
      var preview = '';
      if (last != null) {
        final text = _previewText(context, last.text);
        preview = last.isOutgoing
            ? l10n.messages_you(text)
            : '${last.senderName}: $text';
      }
      result.add(
        _Conversation(
          channel: channel,
          title: channel.name.isEmpty
              ? l10n.channels_channelIndex(channel.index)
              : channel.name,
          preview: preview,
          lastAt: last?.timestamp,
          unread: connector.getUnreadCountForChannelIndex(channel.index),
        ),
      );
    }
    return result;
  }

  List<_Conversation> _visible(
    List<_Conversation> direct,
    List<_Conversation> channels,
  ) {
    final list = switch (_filter) {
      _MessagesFilter.all => [...direct, ...channels],
      _MessagesFilter.direct => [...direct],
      _MessagesFilter.channels => [...channels],
    };
    final query = _searchController.text.trim().toLowerCase();
    if (query.isNotEmpty) {
      list.retainWhere(
        (c) =>
            c.title.toLowerCase().contains(query) ||
            c.preview.toLowerCase().contains(query),
      );
    }
    // Newest activity first; channels that never had a message keep their
    // slot order at the end.
    list.sort((a, b) {
      final at = a.lastAt;
      final bt = b.lastAt;
      if (at == null && bt == null) {
        return (a.channel?.index ?? 0).compareTo(b.channel?.index ?? 0);
      }
      if (at == null) return 1;
      if (bt == null) return -1;
      return bt.compareTo(at);
    });
    return list;
  }

  void _open(BuildContext context, _Conversation conversation) {
    HapticFeedback.selectionClick();
    final connector = context.read<MeshCoreConnector>();
    final contact = conversation.contact;
    final channel = conversation.channel;
    if (contact != null) {
      final unread = connector.getUnreadCountForContactKey(
        contact.publicKeyHex,
      );
      connector.markContactRead(contact.publicKeyHex);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              ChatScreen(contact: contact, initialUnreadCount: unread),
        ),
      );
    } else if (channel != null) {
      final unread = connector.getUnreadCountForChannelIndex(channel.index);
      connector.markChannelRead(channel.index);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              ChannelChatScreen(channel: channel, initialUnreadCount: unread),
        ),
      );
    }
  }

  void _openChannels(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ChannelsScreen()),
    );
  }

  void _showNewSheet(BuildContext context) {
    final l10n = context.l10n;
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              minTileHeight: 56,
              leading: const Icon(Icons.person_outline),
              title: Text(l10n.messages_newDirect),
              onTap: () {
                Navigator.pop(sheetContext);
                switchMainTab(context, MainTab.nodes);
              },
            ),
            ListTile(
              minTileHeight: 56,
              leading: const Icon(Icons.tag),
              title: Text(l10n.messages_newChannel),
              onTap: () {
                Navigator.pop(sheetContext);
                _openChannels(context);
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _toggleSearch() {
    setState(() {
      _searching = !_searching;
      if (!_searching) _searchController.clear();
    });
    if (_searching) _searchFocus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final connector = context.watch<MeshCoreConnector>();
    if (!checkConnectionAndNavigate(connector)) {
      return const SizedBox.shrink();
    }
    final l10n = context.l10n;
    final direct = _directConversations(context, connector);
    final channels = _channelConversations(context, connector);
    final visible = _visible(direct, channels);
    final directUnread = direct.fold<int>(0, (sum, c) => sum + c.unread);
    final channelsUnread = channels.fold<int>(0, (sum, c) => sum + c.unread);

    return PopScope(
      canPop: !connector.isConnected,
      child: Scaffold(
        appBar: AppBar(
          // The radio card below carries the node name and connection, so
          // the title skips its own subtitle and status icons.
          title: AppBarTitle(
            l10n.messages_title,
            indicators: false,
            subtitle: false,
          ),
          automaticallyImplyLeading: false,
          bottom: const SyncProgressAppBarBottom(),
          actions: [
            IconButton(
              tooltip: _searching
                  ? l10n.messages_closeSearch
                  : l10n.messages_search,
              icon: Icon(_searching ? Icons.close : Icons.search),
              onPressed: _toggleSearch,
            ),
            IconButton(
              tooltip: l10n.messages_manageChannels,
              icon: const Icon(Icons.tag),
              onPressed: () => _openChannels(context),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
              child: RadioStatusCard(
                connector: connector,
                onTap: () => switchMainTab(context, MainTab.radio),
              ),
            ),
            if (_searching)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocus,
                  textInputAction: TextInputAction.search,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: l10n.messages_searchHint,
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 4),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _filterChip(
                      _MessagesFilter.all,
                      l10n.messages_filterAll,
                      0,
                    ),
                    _filterChip(
                      _MessagesFilter.direct,
                      l10n.messages_filterDirect,
                      directUnread,
                    ),
                    _filterChip(
                      _MessagesFilter.channels,
                      l10n.messages_filterChannels,
                      channelsUnread,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: visible.isEmpty
                  ? EmptyState(
                      icon: Icons.chat_bubble_outline,
                      title: _searchController.text.trim().isNotEmpty
                          ? l10n.messages_noMatches
                          : l10n.messages_empty,
                      subtitle: _searchController.text.trim().isNotEmpty
                          ? null
                          : l10n.messages_emptyHint,
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.only(top: 4, bottom: 96),
                      itemCount: visible.length,
                      separatorBuilder: (_, _) => const Divider(indent: 72),
                      itemBuilder: (context, i) => _ConversationTile(
                        conversation: visible[i],
                        onTap: () => _open(context, visible[i]),
                      ),
                    ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showNewSheet(context),
          icon: const Icon(Icons.add),
          label: Text(l10n.messages_new),
        ),
        bottomNavigationBar: const SafeArea(
          top: false,
          child: QuickSwitchBar(current: MainTab.messages),
        ),
      ),
    );
  }

  Widget _filterChip(_MessagesFilter filter, String label, int unread) {
    final selected = _filter == filter;
    final scheme = Theme.of(context).colorScheme;
    return ChoiceChip(
      label: Text(
        unread > 0
            ? context.l10n.messages_filterWithUnread(label, unread)
            : label,
      ),
      selected: selected,
      showCheckmark: false,
      selectedColor: scheme.primary,
      labelStyle: TextStyle(
        fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
        color: selected ? scheme.onPrimary : scheme.onSurfaceVariant,
      ),
      side: BorderSide(
        color: selected ? scheme.primary : scheme.outlineVariant,
      ),
      onSelected: (_) => setState(() => _filter = filter),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final _Conversation conversation;
  final VoidCallback onTap;

  const _ConversationTile({required this.conversation, required this.onTap});

  String _time(BuildContext context, DateTime t) {
    final locale = Localizations.localeOf(context).toString();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(t.year, t.month, t.day);
    final days = today.difference(day).inDays;
    if (days <= 0) return DateFormat.Hm(locale).format(t);
    if (days == 1) return context.l10n.messages_yesterday;
    if (days < 7) return DateFormat.E(locale).format(t);
    return DateFormat.MMMd(locale).format(t);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final c = conversation;
    final hasUnread = c.unread > 0;
    final lastAt = c.lastAt;
    final timeColor = hasUnread ? scheme.primary : scheme.onSurfaceVariant;

    final Widget avatar = c.isChannel
        ? Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: hasUnread
                  ? scheme.primaryContainer
                  : scheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(MeshRadii.sm),
            ),
            alignment: Alignment.center,
            child: Icon(
              c.channel!.isPublicChannel ? Icons.public : Icons.tag,
              color: hasUnread
                  ? scheme.onPrimaryContainer
                  : scheme.onSurfaceVariant,
            ),
          )
        : AvatarCircle(name: c.title, size: 44);

    return Semantics(
      button: true,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 68),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 16, 10),
            child: Row(
              children: [
                avatar,
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              c.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: hasUnread
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                              ),
                            ),
                          ),
                          if (lastAt != null) ...[
                            const SizedBox(width: 8),
                            Text(
                              _time(context, lastAt),
                              style: TextStyle(
                                fontSize: 13,
                                color: timeColor,
                                fontWeight: hasUnread
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              c.preview,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          if (hasUnread) ...[
                            const SizedBox(width: 8),
                            _UnreadPill(count: c.unread),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UnreadPill extends StatelessWidget {
  final int count;

  const _UnreadPill({required this.count});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      label: context.l10n.messages_unreadCount(count),
      excludeSemantics: true,
      child: Container(
        constraints: const BoxConstraints(minWidth: 22),
        height: 22,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: scheme.primary,
          borderRadius: BorderRadius.circular(MeshRadii.pill),
        ),
        alignment: Alignment.center,
        child: Text(
          count > 99 ? '99+' : '$count',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: scheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
