import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meshcore_open/storage/channel_message_store.dart';
import 'package:meshcore_open/utils/keys.dart';
import 'package:meshcore_open/utils/platform_info.dart';
import 'package:meshcore_open/widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/l10n.dart';
import '../services/app_settings_service.dart';
import '../services/ui_view_state_service.dart';
import '../models/channel.dart';
import '../models/community.dart';
import '../storage/community_store.dart';
import '../theme/mesh_theme.dart';
import '../utils/dialog_utils.dart';
import '../utils/disconnect_navigation_mixin.dart';
import '../widgets/ember_backdrop.dart';
import '../widgets/list_filter_widget.dart';
import '../widgets/ui/unread_badge.dart';
import '../widgets/mesh_ui.dart';
import '../widgets/qr_code_display.dart';
import '../widgets/sync_progress_overlay.dart';
import '../widgets/instrument.dart';
import '../widgets/glass_chat_card.dart';
import '../widgets/tactical_glass_panel.dart';
import '../helpers/gif_helper.dart';
import '../helpers/snack_bar_builder.dart';
import '../utils/main_tab_navigation.dart';
import '../widgets/quick_switch_bar.dart';
import 'channel_chat_screen.dart';
import '../helpers/join_channel.dart';
import '../services/channel_discovery_service.dart';
import 'chat_screen.dart';
import 'channel_directory_screen.dart';
import 'message_search_screen.dart';
import 'community_qr_scanner_screen.dart';
import 'settings_screen.dart';
import '../widgets/ui/mesh_states.dart';

class ChannelsScreen extends StatefulWidget {
  /// Shown as the CHATS tab: no back button, and the bottom bar below.
  final bool hideBackButton;

  const ChannelsScreen({super.key, this.hideBackButton = false});

  @override
  State<ChannelsScreen> createState() => _ChannelsScreenState();
}

class _ChannelsScreenState extends State<ChannelsScreen>
    with DisconnectNavigationMixin {
  final TextEditingController _searchController = TextEditingController();
  final CommunityStore _communityStore = CommunityStore();
  final CommunityPskIndex _communityIndex = CommunityPskIndex();
  List<Community> _communities = [];
  Timer? _searchDebounce;

  ChannelMessageStore get _channelMessageStore => ChannelMessageStore();

  @override
  void initState() {
    super.initState();
    _searchController.text = context
        .read<UiViewStateService>()
        .channelsSearchText;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MeshCoreConnector>().getChannels();
      _loadCommunities();
    });
  }

  Future<void> _loadCommunities() async {
    final connector = context.read<MeshCoreConnector>();
    _communityStore.setPublicKeyHex = connector.selfPublicKeyHex;
    final communities = await _communityStore.loadCommunities();
    if (mounted) {
      setState(() {
        _communities = communities;
        _communityIndex.initialize(communities);
      });
    }
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  String _relativeTime(DateTime t) {
    final diff = DateTime.now().difference(t);
    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }

  @override
  Widget build(BuildContext context) {
    final connector = context.watch<MeshCoreConnector>();
    final viewState = context.watch<UiViewStateService>();

    final channelMessageStore = ChannelMessageStore();
    channelMessageStore.setPublicKeyHex = connector.selfPublicKeyHex;

    // Auto-navigate back to scanner if disconnected
    if (!checkConnectionAndNavigate(connector)) {
      return const SizedBox.shrink();
    }

    final isTab = widget.hideBackButton;
    return PopScope(
      // As a tab this is a root screen: the back gesture doesn't leave the
      // connected app.
      canPop: !isTab || !connector.isConnected,
      child: EmberBackdrop(
        scene: EmberScene.chats,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 0,
            title: AppBarTitle(context.l10n.channels_title),
            centerTitle: true,
            automaticallyImplyLeading: !isTab,
            bottom: const SyncProgressAppBarBottom(),
            actions: [
              IconButton(
                key: const ValueKey('open-message-search'),
                tooltip: context.l10n.messageSearch_title,
                icon: const Icon(Icons.manage_search),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => const MessageSearchScreen(),
                  ),
                ),
              ),
              PopupMenuButton(
                // onTap handlers run after the menu route pops, so they must
                // capture the screen's context — not the itemBuilder's menu
                // context, which is deactivated by then.
                itemBuilder: (menuContext) => [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Theme.of(menuContext).colorScheme.error,
                        ),
                        const SizedBox(width: 8),
                        Text(menuContext.l10n.common_disconnect),
                      ],
                    ),
                    onTap: () => _disconnect(context),
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        const Icon(Icons.groups),
                        const SizedBox(width: 8),
                        Text(menuContext.l10n.community_manageCommunities),
                      ],
                    ),
                    onTap: () => _showManageCommunitiesDialog(context),
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        const Icon(Icons.settings),
                        const SizedBox(width: 8),
                        Text(menuContext.l10n.settings_title),
                      ],
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    ),
                  ),
                ],
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await context.read<MeshCoreConnector>().getChannels(force: true);
            },
            child: () {
              final channels = connector.channels;
              final waitingForFirstChannel =
                  connector.isLoadingChannels && channels.isEmpty;

              // Only block the list while the first channel is actively loading.
              // If the initial sync aborts, show cached/partial channels instead
              // of trapping the user behind an idle spinner.
              if (waitingForFirstChannel) {
                return const Center(child: CircularProgressIndicator());
              }

              if (channels.isEmpty) {
                return ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      child: EmptyState(
                        icon: Icons.tag,
                        title: context.l10n.channels_noChannelsConfigured,
                        action: FilledButton.icon(
                          onPressed: () =>
                              _addPublicChannel(context, connector),
                          icon: const Icon(Icons.public),
                          label: Text(context.l10n.channels_addPublicChannel),
                        ),
                      ),
                    ),
                  ],
                );
              }

              final filteredChannels = _filterAndSortChannels(
                channels,
                connector,
                viewState,
              );

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: context.l10n.channels_searchChannels,
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (viewState.channelsSearchText.isNotEmpty)
                              IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchDebounce?.cancel();
                                  _searchDebounce = null;
                                  _searchController.clear();
                                  context
                                      .read<UiViewStateService>()
                                      .setChannelsSearchText('');
                                },
                              ),
                            _buildFilterButton(viewState),
                          ],
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onChanged: (value) {
                        _searchDebounce?.cancel();
                        _searchDebounce = Timer(
                          const Duration(milliseconds: 300),
                          () {
                            if (!mounted) return;
                            context
                                .read<UiViewStateService>()
                                .setChannelsSearchText(value);
                          },
                        );
                      },
                    ),
                  ),
                  const _DiscoveredTray(),
                  Expanded(
                    child: filteredChannels.isEmpty
                        ? LayoutBuilder(
                            builder: (context, constraints) => ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: constraints.maxHeight,
                                  ),
                                  child: EmptyState(
                                    icon: Icons.search_off,
                                    title:
                                        context.l10n.channels_noChannelsFound,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : (viewState.channelsSortOption ==
                                  ChannelSortOption.manual &&
                              viewState.channelsSearchText.isEmpty)
                        ? ReorderableListView.builder(
                            padding: const EdgeInsets.only(bottom: 88),
                            buildDefaultDragHandles: false,
                            footer: _DirectChats(connector: connector),
                            itemCount: filteredChannels.length,
                            onReorderItem: (oldIndex, newIndex) {
                              final reordered = List<Channel>.from(
                                filteredChannels,
                              );
                              final item = reordered.removeAt(oldIndex);
                              reordered.insert(newIndex, item);
                              unawaited(
                                connector.setChannelOrder(
                                  reordered.map((c) => c.index).toList(),
                                ),
                              );
                            },
                            itemBuilder: (context, index) {
                              final channel = filteredChannels[index];
                              return _buildChannelTile(
                                context,
                                connector,
                                channelMessageStore,
                                channel,
                                showDragHandle: true,
                                dragIndex: index,
                                listIndex: index,
                              );
                            },
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.only(bottom: 88),
                            // Direct chats follow the channels, but not while
                            // searching channels.
                            itemCount:
                                filteredChannels.length +
                                (viewState.channelsSearchText.isEmpty ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == filteredChannels.length) {
                                return _DirectChats(connector: connector);
                              }
                              final channel = filteredChannels[index];
                              return _buildChannelTile(
                                context,
                                connector,
                                channelMessageStore,
                                channel,
                                listIndex: index,
                              );
                            },
                          ),
                  ),
                ],
              );
            }(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showAddChannelDialog(context),
            tooltip: context.l10n.channels_addChannel,
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: isTab
              ? const SafeArea(
                  top: false,
                  child: QuickSwitchBar(current: MainTab.chats),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildChannelTile(
    BuildContext context,
    MeshCoreConnector connector,
    ChannelMessageStore channelMessageStore,
    Channel channel, {
    bool showDragHandle = false,
    int? dragIndex,
    int listIndex = 0,
  }) {
    final unreadCount = connector.getUnreadCountForChannel(channel);
    final isMuted = context.watch<AppSettingsService>().isChannelMuted(
      channel.name,
    );
    final scheme = Theme.of(context).colorScheme;

    // Determine icon and colors based on channel type
    IconData icon;
    final ChannelType channelType = Channel.getChannelType(
      channel,
      _communityIndex,
    );
    final bool isCommunityChannel = Channel.isCommunityChannel(channelType);
    final community = isCommunityChannel
        ? _communityIndex.getCommunityForChannel(channel)
        : null;
    // Only flood-routed channels carry a region; show it when one is set.
    String subtitle = connector.hasChannelRegion(channel.index)
        ? context.l10n.channels_regionSetTo(
            connector.getChannelRegion(channel.index),
          )
        : '';
    switch (channelType) {
      case ChannelType.communityPublic:
        icon = Icons.groups;
        if (community != null) {
          subtitle =
              '${context.l10n.community_publicChannel} • ${community.name}';
        }
      case ChannelType.communityHashtag:
        icon = Icons.groups;
        if (community != null) {
          subtitle =
              '${context.l10n.community_hashtagChannel} • ${community.name}';
        }
      case ChannelType.public:
        icon = Icons.public;
      case ChannelType.hashtag:
        icon = Icons.tag;
      case ChannelType.private:
        icon = Icons.key_outlined;
    }

    // Last message preview
    final messages = connector.getChannelMessages(channel);
    final lastMessage = messages.isNotEmpty ? messages.last : null;
    final lastMessageText = lastMessage?.text ?? '';
    final lastPreview =
        lastMessageText.isNotEmpty &&
            GifHelper.parseGif(lastMessageText) != null
        ? context.l10n.chat_receivedGif
        : lastMessageText;
    final lastTime = lastMessage?.timestamp;

    final channelLabel = channel.name.isEmpty
        ? context.l10n.channels_channelIndex(channel.index)
        : channel.name;

    return ListEntrance(
      key: ValueKey('channel_entrance_${channel.index}'),
      index: dragIndex ?? listIndex,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          MeshSpace.lg,
          0,
          MeshSpace.lg,
          MeshSpace.sm,
        ),
        child: TacticalGlassPanel(
          blur: false,
          padding: EdgeInsets.zero,
          child: InkWell(
            key: ValueKey('channel_${channel.index}'),
            onTap: () {
              HapticFeedback.selectionClick();
              final unread = connector.getUnreadCountForChannelIndex(
                channel.index,
              );
              connector.markChannelRead(channel.index);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChannelChatScreen(
                    channel: channel,
                    initialUnreadCount: unread,
                  ),
                ),
              );
            },
            onLongPress: () {
              HapticFeedback.selectionClick();
              _showChannelActions(
                this.context,
                connector,
                channelMessageStore,
                channel,
              );
            },
            onSecondaryTap: PlatformInfo.isDesktop
                ? () => _showChannelActions(
                    this.context,
                    connector,
                    channelMessageStore,
                    channel,
                  )
                : null,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: MeshSpace.lg,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: instrumentLine)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // A glyph, not an avatar: # hashtag, ◎ public, lock private.
                  SizedBox(
                    width: 22,
                    child: channelType == ChannelType.hashtag
                        ? Text(
                            '#',
                            style: MeshTheme.mono(
                              fontSize: 17,
                              color: MeshPalette.ink3,
                            ),
                          )
                        : channelType == ChannelType.public
                        ? Text(
                            '\u25CE',
                            style: MeshTheme.mono(
                              fontSize: 16,
                              color: MeshPalette.ink3,
                            ),
                          )
                        : Icon(icon, size: 17, color: MeshPalette.ink3),
                  ),
                  const SizedBox(width: 12),
                  // Title + subtitle + ch chip
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          channelLabel,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                fontSize: 15,
                                fontWeight: unreadCount > 0
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (subtitle.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: scheme.onSurfaceVariant),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        if (lastPreview.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            lastPreview,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  fontSize: 13,
                                  color: unreadCount > 0
                                      ? MeshPalette.ink2
                                      : MeshPalette.ink3,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Right side: time + unread badge + muted + drag handle
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (lastTime != null)
                        Text(
                          _relativeTime(lastTime),
                          style: MeshTheme.mono(
                            fontSize: 12,
                            color: MeshPalette.ink3,
                          ),
                        ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isMuted) ...[
                            Icon(
                              Icons.notifications_off,
                              size: 14,
                              color: scheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                          ],
                          if (unreadCount > 0) UnreadBadge(unreadCount),
                        ],
                      ),
                    ],
                  ),
                  if (showDragHandle && dragIndex != null) ...[
                    const SizedBox(width: 4),
                    ReorderableDragStartListener(
                      index: dragIndex,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: MeshSpace.sm,
                          vertical: MeshSpace.md,
                        ),
                        child: Icon(
                          Icons.drag_indicator_rounded,
                          size: 18,
                          color: MeshPalette.ink4.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showChannelActions(
    BuildContext context,
    MeshCoreConnector connector,
    ChannelMessageStore channelMessageStore,
    Channel channel,
  ) {
    final parentContext = context;
    final settingsService = context.read<AppSettingsService>();
    final isMuted = settingsService.isChannelMuted(channel.name);

    showModalBottomSheet(
      context: parentContext,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: Text(sheetContext.l10n.channels_editChannel),
              onTap: () async {
                Navigator.pop(sheetContext);
                await Future.delayed(const Duration(milliseconds: 100));
                if (parentContext.mounted) {
                  _showEditChannelDialog(parentContext, connector, channel);
                }
              },
            ),
            ListTile(
              leading: Icon(
                isMuted
                    ? Icons.notifications_outlined
                    : Icons.notifications_off_outlined,
              ),
              title: Text(
                isMuted
                    ? sheetContext.l10n.channels_unmuteChannel
                    : sheetContext.l10n.channels_muteChannel,
              ),
              onTap: () async {
                Navigator.pop(sheetContext);
                if (isMuted) {
                  await settingsService.unmuteChannel(channel.name);
                } else {
                  await settingsService.muteChannel(channel.name);
                }
              },
            ),
            ListTile(
              leading: Icon(
                Icons.delete_outline,
                color: Theme.of(sheetContext).colorScheme.error,
              ),
              title: Text(
                sheetContext.l10n.channels_deleteChannel,
                style: TextStyle(
                  color: Theme.of(sheetContext).colorScheme.error,
                ),
              ),
              onTap: () async {
                Navigator.pop(sheetContext);
                await Future.delayed(const Duration(milliseconds: 100));
                if (parentContext.mounted) {
                  _confirmDeleteChannel(
                    parentContext,
                    connector,
                    channelMessageStore,
                    channel,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _disconnect(BuildContext context) async {
    final connector = context.read<MeshCoreConnector>();
    await showDisconnectDialog(context, connector);
  }

  Widget _buildFilterButton(UiViewStateService viewState) {
    return SortFilterMenu<ChannelSortOption>(
      tooltip: context.l10n.listFilter_tooltip,
      sections: [
        SortFilterMenuSection<ChannelSortOption>(
          title: context.l10n.channels_sortBy,
          options: [
            SortFilterMenuOption<ChannelSortOption>(
              value: ChannelSortOption.manual,
              label: context.l10n.channels_sortManual,
              checked: viewState.channelsSortOption == ChannelSortOption.manual,
            ),
            SortFilterMenuOption<ChannelSortOption>(
              value: ChannelSortOption.name,
              label: context.l10n.channels_sortAZ,
              checked: viewState.channelsSortOption == ChannelSortOption.name,
            ),
            SortFilterMenuOption<ChannelSortOption>(
              value: ChannelSortOption.latestMessages,
              label: context.l10n.channels_sortLatestMessages,
              checked:
                  viewState.channelsSortOption ==
                  ChannelSortOption.latestMessages,
            ),
            SortFilterMenuOption<ChannelSortOption>(
              value: ChannelSortOption.unread,
              label: context.l10n.channels_sortUnread,
              checked: viewState.channelsSortOption == ChannelSortOption.unread,
            ),
          ],
        ),
      ],
      onSelected: (sortOption) {
        viewState.setChannelsSortOption(sortOption);
      },
    );
  }

  List<Channel> _filterAndSortChannels(
    List<Channel> channels,
    MeshCoreConnector connector,
    UiViewStateService viewState,
  ) {
    var filtered = channels.where((channel) {
      if (viewState.channelsSearchText.isEmpty) return true;
      final label = _normalizeChannelName(channel);
      return label.toLowerCase().contains(
        viewState.channelsSearchText.toLowerCase(),
      );
    }).toList();

    int compareByName(Channel a, Channel b) {
      final nameA = _normalizeChannelName(a);
      final nameB = _normalizeChannelName(b);
      return nameA.toLowerCase().compareTo(nameB.toLowerCase());
    }

    switch (viewState.channelsSortOption) {
      case ChannelSortOption.manual:
        break;
      case ChannelSortOption.latestMessages:
        filtered.sort((a, b) {
          final aMessages = connector.getChannelMessages(a);
          final bMessages = connector.getChannelMessages(b);
          final aLast = aMessages.isEmpty
              ? DateTime(1970)
              : aMessages.last.timestamp;
          final bLast = bMessages.isEmpty
              ? DateTime(1970)
              : bMessages.last.timestamp;
          final timeCompare = bLast.compareTo(aLast);
          if (timeCompare != 0) return timeCompare;
          return compareByName(a, b);
        });
        break;
      case ChannelSortOption.unread:
        filtered.sort((a, b) {
          final aUnread = connector.getUnreadCountForChannel(a);
          final bUnread = connector.getUnreadCountForChannel(b);
          final unreadCompare = bUnread.compareTo(aUnread);
          if (unreadCompare != 0) return unreadCompare;
          return compareByName(a, b);
        });
        break;
      case ChannelSortOption.name:
        filtered.sort(compareByName);
        break;
    }

    return filtered;
  }

  String _normalizeChannelName(Channel channel) {
    if (channel.name.isEmpty) {
      return 'Channel ${channel.index}'; // Fallback for sorting
    }
    final trimmed = channel.name.trim();
    if (trimmed.startsWith('#') && trimmed.length > 1) {
      return trimmed.substring(1);
    }
    return trimmed;
  }

  void _showAddChannelDialog(BuildContext context) {
    final connector = context.read<MeshCoreConnector>();
    final nextIndex = _findNextAvailableIndex(
      connector.channels,
      connector.maxChannels,
    );
    final hasPublicChannel = connector.channels.any((c) => c.isPublicChannel);
    int? selectedOption;
    final nameController = TextEditingController();
    final pskController = TextEditingController();
    final hashtagController = TextEditingController();
    bool addPublicChannel = true;
    bool isRegularHashtag = true;
    Community? selectedCommunity;

    _communityStore.setPublicKeyHex = connector.selfPublicKeyHex;

    showMeshSheet(
      context,
      builder: (sheetContext) => StatefulBuilder(
        builder: (sheetContext, setSheetState) {
          Widget buildOptionCard({
            required int optionIndex,
            required IconData icon,
            required String title,
            required String subtitle,
            bool enabled = true,
          }) {
            final isSelected = selectedOption == optionIndex;
            final cardScheme = Theme.of(sheetContext).colorScheme;
            return MeshCard(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              borderColor: isSelected && enabled
                  ? MeshPalette.accentLine
                  : null,
              color: isSelected && enabled ? MeshPalette.accentBg : null,
              onTap: enabled
                  ? () {
                      setSheetState(() {
                        selectedOption = optionIndex;
                        nameController.clear();
                        pskController.clear();
                        hashtagController.clear();
                      });
                    }
                  : null,
              child: Row(
                children: [
                  AvatarCircle(
                    name: title,
                    size: 38,
                    color: enabled
                        ? (isSelected
                              ? MeshPalette.accent
                              : cardScheme.onSurfaceVariant)
                        : cardScheme.outline,
                    icon: icon,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: Theme.of(sheetContext).textTheme.bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: enabled ? null : cardScheme.outline,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: Theme.of(sheetContext).textTheme.bodySmall
                              ?.copyWith(
                                color: enabled
                                    ? cardScheme.onSurfaceVariant
                                    : cardScheme.outline,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (enabled)
                    Icon(
                      Icons.chevron_right,
                      color: isSelected
                          ? MeshPalette.accent
                          : cardScheme.onSurfaceVariant,
                      size: 20,
                    ),
                ],
              ),
            );
          }

          Widget? buildExpandedContent(
            ChannelMessageStore channelMessageStore,
          ) {
            switch (selectedOption) {
              case 0: // Create Private Channel
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: sheetContext.l10n.channels_channelName,
                          border: const OutlineInputBorder(),
                        ),
                        maxLength: 31,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: () async {
                                final name = nameController.text.trim();
                                if (name.isEmpty) {
                                  showDismissibleSnackBar(
                                    context,
                                    content: Text(
                                      sheetContext
                                          .l10n
                                          .channels_enterChannelName,
                                    ),
                                  );
                                  return;
                                }
                                final psk = randomBytes(16);
                                Navigator.pop(sheetContext);
                                await connector.setChannel(
                                  nextIndex,
                                  name,
                                  psk,
                                );
                                await channelMessageStore.clearChannelMessages(
                                  nextIndex,
                                );
                                if (context.mounted) {
                                  showDismissibleSnackBar(
                                    context,
                                    content: Text(
                                      context.l10n.channels_channelAdded(name),
                                    ),
                                  );
                                }
                              },
                              child: Text(sheetContext.l10n.common_create),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                );

              case 1: // Join Private Channel
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: sheetContext.l10n.channels_channelName,
                          border: const OutlineInputBorder(),
                        ),
                        maxLength: 31,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: TextField(
                        controller: pskController,
                        decoration: InputDecoration(
                          labelText: sheetContext.l10n.channels_pskHex,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: () {
                                final name = nameController.text.trim();
                                final pskHex = pskController.text.trim();
                                if (name.isEmpty) {
                                  showDismissibleSnackBar(
                                    context,
                                    content: Text(
                                      sheetContext
                                          .l10n
                                          .channels_enterChannelName,
                                    ),
                                  );
                                  return;
                                }
                                Uint8List psk;
                                try {
                                  psk = Channel.parsePskHex(pskHex);
                                } on FormatException {
                                  showDismissibleSnackBar(
                                    context,
                                    content: Text(
                                      sheetContext.l10n.channels_pskMustBe32Hex,
                                    ),
                                  );
                                  return;
                                }
                                Navigator.pop(sheetContext);
                                connector.setChannel(nextIndex, name, psk);
                                if (context.mounted) {
                                  showDismissibleSnackBar(
                                    context,
                                    content: Text(
                                      context.l10n.channels_channelAdded(name),
                                    ),
                                  );
                                }
                              },
                              child: Text(sheetContext.l10n.common_add),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                );

              case 2: // Join Public Channel
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            final psk = Channel.parsePskHex(
                              Channel.publicChannelPsk,
                            );
                            Navigator.pop(sheetContext);
                            connector.setChannel(
                              nextIndex,
                              context.l10n.channels_public,
                              psk,
                            );
                            if (context.mounted) {
                              showDismissibleSnackBar(
                                context,
                                content: Text(
                                  context.l10n.channels_publicChannelAdded,
                                ),
                              );
                            }
                          },
                          child: Text(sheetContext.l10n.common_add),
                        ),
                      ),
                    ],
                  ),
                );

              case 3: // Join Hashtag Channel
                return Column(
                  children: [
                    // Only show type selection if user has communities
                    if (_communities.isNotEmpty) ...[
                      RadioGroup<bool>(
                        groupValue: isRegularHashtag,
                        onChanged: (v) => setSheetState(() {
                          if (v == null) return;
                          isRegularHashtag = v;
                          if (isRegularHashtag) {
                            selectedCommunity = null;
                          } else if (selectedCommunity == null &&
                              _communities.isNotEmpty) {
                            selectedCommunity = _communities.first;
                          }
                        }),
                        child: Column(
                          children: [
                            RadioListTile<bool>(
                              value: true,
                              title: Text(
                                sheetContext.l10n.community_regularHashtag,
                              ),
                              subtitle: Text(
                                sheetContext.l10n.community_regularHashtagDesc,
                              ),
                              dense: true,
                            ),
                            RadioListTile<bool>(
                              value: false,
                              title: Text(
                                sheetContext.l10n.community_communityHashtag,
                              ),
                              subtitle: Text(
                                sheetContext
                                    .l10n
                                    .community_communityHashtagDesc,
                              ),
                              dense: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                    // Community dropdown (only if community hashtag selected)
                    if (!isRegularHashtag && _communities.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: DropdownButtonFormField<Community>(
                          initialValue: selectedCommunity,
                          items: _communities
                              .map(
                                (c) => DropdownMenuItem(
                                  value: c,
                                  child: Text(c.name),
                                ),
                              )
                              .toList(),
                          onChanged: (c) =>
                              setSheetState(() => selectedCommunity = c),
                          decoration: InputDecoration(
                            labelText:
                                sheetContext.l10n.community_selectCommunity,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.groups),
                          ),
                        ),
                      ),
                    // Hashtag name input
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: TextField(
                        controller: hashtagController,
                        decoration: InputDecoration(
                          labelText: sheetContext.l10n.channels_enterHashtag,
                          hintText: sheetContext.l10n.channels_hashtagHint,
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.tag),
                        ),
                        maxLength: 31,
                      ),
                    ),
                    // Privacy hint for community hashtags
                    if (!isRegularHashtag)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          sheetContext.l10n.community_hashtagPrivacyHint,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(
                              sheetContext,
                            ).colorScheme.onSurfaceVariant,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: () async {
                                var hashtag = hashtagController.text.trim();
                                if (hashtag.isEmpty) {
                                  showDismissibleSnackBar(
                                    context,
                                    content: Text(
                                      sheetContext
                                          .l10n
                                          .channels_enterChannelName,
                                    ),
                                  );
                                  return;
                                }

                                // Normalize hashtag name (remove leading # if present)
                                if (hashtag.startsWith('#')) {
                                  hashtag = hashtag.substring(1);
                                }
                                final String channelName;

                                final Uint8List psk;
                                if (isRegularHashtag) {
                                  channelName = '#$hashtag';
                                  // Regular hashtag - public derivation using SHA256
                                  psk = Channel.derivePskFromHashtag(hashtag);
                                } else {
                                  // Community hashtag - HMAC derivation from community secret
                                  if (selectedCommunity == null) {
                                    showDismissibleSnackBar(
                                      sheetContext,
                                      content: Text(
                                        sheetContext
                                            .l10n
                                            .community_selectCommunity,
                                      ),
                                    );
                                    return;
                                  }
                                  channelName =
                                      '${selectedCommunity!.name} #$hashtag';
                                  psk = selectedCommunity!
                                      .deriveCommunityHashtagPsk(hashtag);
                                  // Track in community's hashtag list
                                  await _communityStore.addHashtagChannel(
                                    selectedCommunity!.id,
                                    hashtag,
                                  );
                                  _loadCommunities();
                                }

                                if (sheetContext.mounted) {
                                  Navigator.pop(sheetContext);
                                }
                                connector.setChannel(
                                  nextIndex,
                                  channelName,
                                  psk,
                                );
                                if (context.mounted) {
                                  showDismissibleSnackBar(
                                    context,
                                    content: Text(
                                      context.l10n.channels_channelAdded(
                                        channelName,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Text(sheetContext.l10n.common_add),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );

              case 4: // Scan Community QR
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () async {
                            Navigator.pop(sheetContext);
                            if (context.mounted) {
                              final result = await Navigator.push<Community>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CommunityQrScannerScreen(),
                                ),
                              );
                              // Result handled by scanner screen
                              if (result != null && context.mounted) {
                                // Community was joined, refresh might be needed
                              }
                            }
                          },
                          icon: const Icon(Icons.qr_code_scanner),
                          label: Text(sheetContext.l10n.community_scanQr),
                        ),
                      ),
                    ],
                  ),
                );

              case 5: // Create Community
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: sheetContext.l10n.community_name,
                          hintText: sheetContext.l10n.community_enterName,
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.groups),
                        ),
                        maxLength: 31,
                      ),
                    ),
                    CheckboxListTile(
                      value: addPublicChannel,
                      onChanged: (value) {
                        setSheetState(() {
                          addPublicChannel = value ?? true;
                        });
                      },
                      title: Text(sheetContext.l10n.community_addPublicChannel),
                      subtitle: Text(
                        sheetContext.l10n.community_addPublicChannelHint,
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: () async {
                                final name = nameController.text.trim();
                                final publicLabel =
                                    context.l10n.channels_public;
                                if (name.isEmpty) {
                                  showDismissibleSnackBar(
                                    context,
                                    content: Text(
                                      sheetContext.l10n.community_enterName,
                                    ),
                                  );
                                  return;
                                }

                                // Create community with random secret
                                final community = Community.create(
                                  id: const Uuid().v4(),
                                  name: name,
                                );

                                // Save to store
                                await _communityStore.addCommunity(community);

                                // Optionally add the community public channel to the device
                                if (addPublicChannel) {
                                  final psk = community
                                      .deriveCommunityPublicPsk();
                                  final channelName =
                                      '${community.name} $publicLabel';
                                  connector.setChannel(
                                    nextIndex,
                                    channelName,
                                    psk,
                                  );
                                }

                                if (sheetContext.mounted) {
                                  Navigator.pop(sheetContext);
                                }

                                // Refresh communities list
                                _loadCommunities();

                                if (context.mounted) {
                                  showDismissibleSnackBar(
                                    context,
                                    content: Text(
                                      context.l10n.community_created(name),
                                    ),
                                  );

                                  // Show QR code dialog
                                  await QrCodeShareDialog.show(
                                    context: context,
                                    data: community.toQrJson(),
                                    title: context.l10n.community_qrTitle,
                                    instructions: context.l10n
                                        .community_qrInstructions(name),
                                    embeddedImage: Image.asset(
                                      'assets/images/mesh-icon.png',
                                      width: 40,
                                      height: 40,
                                    ),
                                  );
                                }
                              },
                              child: Text(sheetContext.l10n.common_create),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                );

              default:
                return null;
            }
          }

          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.7,
            minChildSize: 0.4,
            maxChildSize: 0.95,
            builder: (_, scrollController) => Column(
              children: [
                BottomSheetHeader(title: sheetContext.l10n.channels_addChannel),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.only(bottom: 24),
                    children: [
                      MeshCard(
                        key: const ValueKey('open-channel-directory'),
                        margin: const EdgeInsets.fromLTRB(16, 4, 16, 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        color: MeshPalette.accentBg,
                        borderColor: MeshPalette.accentLine,
                        onTap: () {
                          Navigator.pop(sheetContext);
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const ChannelDirectoryScreen(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            AvatarCircle(
                              name: 'directory',
                              size: 38,
                              color: MeshPalette.accent,
                              icon: Icons.travel_explore,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    sheetContext.l10n.channelDirectory_title,
                                    style: Theme.of(sheetContext)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    sheetContext.l10n.channelDirectory_subtitle,
                                    style: Theme.of(
                                      sheetContext,
                                    ).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: MeshPalette.accent,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      buildOptionCard(
                        optionIndex: 0,
                        icon: Icons.add,
                        title: sheetContext.l10n.channels_createPrivateChannel,
                        subtitle:
                            sheetContext.l10n.channels_createPrivateChannelDesc,
                      ),
                      if (selectedOption == 0)
                        buildExpandedContent(_channelMessageStore)!,
                      buildOptionCard(
                        optionIndex: 1,
                        icon: Icons.key_outlined,
                        title: sheetContext.l10n.channels_joinPrivateChannel,
                        subtitle:
                            sheetContext.l10n.channels_joinPrivateChannelDesc,
                      ),
                      if (selectedOption == 1)
                        buildExpandedContent(_channelMessageStore)!,
                      if (!hasPublicChannel) ...[
                        buildOptionCard(
                          optionIndex: 2,
                          icon: Icons.public,
                          title: sheetContext.l10n.channels_joinPublicChannel,
                          subtitle:
                              sheetContext.l10n.channels_joinPublicChannelDesc,
                        ),
                        if (selectedOption == 2)
                          buildExpandedContent(_channelMessageStore)!,
                      ],
                      buildOptionCard(
                        optionIndex: 3,
                        icon: Icons.tag,
                        title: sheetContext.l10n.channels_joinHashtagChannel,
                        subtitle:
                            sheetContext.l10n.channels_joinHashtagChannelDesc,
                      ),
                      if (selectedOption == 3)
                        buildExpandedContent(_channelMessageStore)!,
                      buildOptionCard(
                        optionIndex: 4,
                        icon: Icons.qr_code_scanner,
                        title: sheetContext.l10n.community_scanQr,
                        subtitle: sheetContext.l10n.community_join,
                      ),
                      if (selectedOption == 4)
                        buildExpandedContent(_channelMessageStore)!,
                      buildOptionCard(
                        optionIndex: 5,
                        icon: Icons.groups,
                        title: sheetContext.l10n.community_create,
                        subtitle: sheetContext.l10n.community_createDesc,
                      ),
                      if (selectedOption == 5)
                        buildExpandedContent(_channelMessageStore)!,
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showEditChannelDialog(
    BuildContext context,
    MeshCoreConnector connector,
    Channel channel,
  ) {
    final appSettingsService = Provider.of<AppSettingsService>(
      context,
      listen: false,
    );
    final nameController = TextEditingController(text: channel.name);
    final pskController = TextEditingController(text: channel.pskHex);
    bool smazEnabled = connector.isChannelSmazEnabled(channel.index);
    bool cyr2latEnabled = connector.isChannelCyr2LatEnabled(channel.index);
    bool urlImagesEnabled = connector.isChannelUrlImagesEnabled(channel.index);
    String? selectedCyr2LatProfileId = connector.getChannelCyr2LatProfileId(
      channel.index,
    );

    showMeshSheet(
      context,
      builder: (sheetContext) => StatefulBuilder(
        builder: (sheetContext, setSheetState) => DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.65,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (_, scrollController) => Column(
            children: [
              BottomSheetHeader(
                title: sheetContext.l10n.channels_editChannelTitle(
                  channel.index,
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    const SizedBox(height: 8),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: sheetContext.l10n.channels_channelName,
                        border: const OutlineInputBorder(),
                      ),
                      maxLength: 31,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: pskController,
                      decoration: InputDecoration(
                        labelText: sheetContext.l10n.channels_pskHex,
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.casino),
                          tooltip: sheetContext.l10n.channels_generateRandomPsk,
                          onPressed: () {
                            final bytes = randomBytes(16);
                            pskController.text = Channel.formatPskHex(bytes);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(sheetContext.l10n.channels_smazCompression),
                      value: smazEnabled,
                      onChanged: (value) => setSheetState(() {
                        smazEnabled = value;
                        if (smazEnabled) {
                          cyr2latEnabled = false;
                        }
                      }),
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        sheetContext.l10n.channels_cyr2latCompression,
                      ),
                      subtitle: Text(
                        sheetContext.l10n.channels_cyr2latCompressionDscr,
                      ),
                      value: cyr2latEnabled,
                      onChanged: (value) => setSheetState(() {
                        cyr2latEnabled = value;
                        if (cyr2latEnabled) {
                          smazEnabled = false;
                        }
                      }),
                    ),
                    if (cyr2latEnabled) ...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: DropdownButtonFormField<String>(
                          initialValue: selectedCyr2LatProfileId,
                          decoration: InputDecoration(
                            labelText: sheetContext
                                .l10n
                                .channels_cyr2latSettingsSubheading,
                            border: const OutlineInputBorder(),
                          ),
                          items: appSettingsService.settings.cyr2latProfiles
                              .map((profile) {
                                return DropdownMenuItem(
                                  value: profile.id,
                                  child: Text(profile.name),
                                );
                              })
                              .toList(),
                          onChanged: (value) => setSheetState(() {
                            selectedCyr2LatProfileId = value;
                          }),
                        ),
                      ),
                    ],
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(sheetContext.l10n.urlImage_enable),
                      value: urlImagesEnabled,
                      onChanged: (value) =>
                          setSheetState(() => urlImagesEnabled = value),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(sheetContext),
                        child: Text(sheetContext.l10n.common_cancel),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () async {
                          final name = nameController.text.trim();
                          final pskHex = pskController.text.trim();

                          Uint8List psk;
                          try {
                            psk = Channel.parsePskHex(pskHex);
                          } on FormatException {
                            showDismissibleSnackBar(
                              sheetContext,
                              content: Text(
                                sheetContext.l10n.channels_pskMustBe32Hex,
                              ),
                            );
                            return;
                          }

                          Navigator.pop(sheetContext);
                          try {
                            await connector.setChannel(
                              channel.index,
                              name,
                              psk,
                            );
                            await connector.setChannelSmazEnabled(
                              channel.index,
                              smazEnabled,
                            );
                            await connector.setChannelCyr2LatEnabled(
                              channel.index,
                              cyr2latEnabled,
                            );
                            await connector.setChannelUrlImagesEnabled(
                              channel.index,
                              urlImagesEnabled,
                            );
                            await connector.setChannelCyr2LatProfileId(
                              channel.index,
                              selectedCyr2LatProfileId,
                            );
                            if (!context.mounted) return;
                            showDismissibleSnackBar(
                              context,
                              content: Text(
                                context.l10n.channels_channelUpdated(name),
                              ),
                            );
                          } catch (e, st) {
                            debugPrint(st.toString());
                            if (!context.mounted) return;
                            showDismissibleSnackBar(
                              context,
                              content: Text(
                                context.l10n.channels_channelUpdateFailed(
                                  friendlyError(e),
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(sheetContext.l10n.common_save),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDeleteChannel(
    BuildContext context,
    MeshCoreConnector connector,
    ChannelMessageStore channelMessageStore,
    Channel channel,
  ) async {
    final confirmed = await confirmDestructive(
      context,
      title: context.l10n.channels_deleteChannel,
      message: context.l10n.channels_deleteChannelConfirm(channel.name),
      confirmLabel: context.l10n.common_delete,
    );
    if (!confirmed) return;
    if (!context.mounted) return;
    try {
      await connector.deleteChannel(channel.index);

      await channelMessageStore.clearChannelMessages(channel.index);

      if (!context.mounted) return;

      showDismissibleSnackBar(
        context,
        content: Text(context.l10n.channels_channelDeleted(channel.name)),
      );
    } catch (e, st) {
      if (!context.mounted) return;

      showDismissibleSnackBar(
        context,
        content: Text(context.l10n.channels_channelDeleteFailed(channel.name)),
      );

      debugPrint('Failed to delete channel: $e\n$st');
    }
  }

  void _addPublicChannel(BuildContext context, MeshCoreConnector connector) {
    final psk = Channel.parsePskHex(Channel.publicChannelPsk);
    connector.setChannel(0, context.l10n.channels_public, psk);
    showDismissibleSnackBar(
      context,
      content: Text(context.l10n.channels_publicChannelAdded),
    );
  }

  int _findNextAvailableIndex(List<Channel> channels, int maxChannels) {
    final usedIndices = channels.map((c) => c.index).toSet();
    for (int i = 0; i < maxChannels; i++) {
      if (!usedIndices.contains(i)) return i;
    }
    return 0;
  }

  void _showManageCommunitiesDialog(BuildContext context) {
    showMeshSheet(
      context,
      builder: (sheetContext) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (_, scrollController) => Column(
          children: [
            BottomSheetHeader(
              title: sheetContext.l10n.community_manageCommunities,
            ),
            const Divider(height: 1),
            Expanded(
              child: _communities.isEmpty
                  ? EmptyState(
                      icon: Icons.groups_outlined,
                      title: sheetContext.l10n.community_noCommunities,
                      subtitle: sheetContext.l10n.community_scanOrCreate,
                    )
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: _communities.length,
                      itemBuilder: (context, index) {
                        final community = _communities[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: MeshPalette.magentaBg,
                            child: Icon(
                              Icons.groups,
                              color: MeshPalette.magenta,
                            ),
                          ),
                          title: Text(community.name),
                          subtitle: Text(
                            context.l10n.channels_communityShortId(
                              community.shortCommunityId,
                            ),
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) {
                              Navigator.pop(sheetContext);
                              // Use the screen's context: the sheet item's
                              // context is deactivated once the sheet pops.
                              if (value == 'share') {
                                _showCommunityQrDialog(this.context, community);
                              } else if (value == 'leave') {
                                _confirmLeaveCommunity(this.context, community);
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'share',
                                child: Row(
                                  children: [
                                    const Icon(Icons.qr_code),
                                    const SizedBox(width: 12),
                                    Text(context.l10n.community_showQr),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'leave',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.exit_to_app,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.error,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      context.l10n.community_delete,
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.error,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(sheetContext);
                            _showCommunityQrDialog(context, community);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCommunityQrDialog(BuildContext context, Community community) {
    QrCodeShareDialog.show(
      context: context,
      data: community.toQrJson(),
      title: context.l10n.community_qrTitle,
      instructions: context.l10n.community_qrInstructions(community.name),
      embeddedImage: Image.asset(
        'assets/images/mesh-icon.png',
        width: 40,
        height: 40,
      ),
    );
  }

  void _confirmLeaveCommunity(BuildContext context, Community community) {
    final connector = context.read<MeshCoreConnector>();

    // Find all channels that belong to this community
    List<Channel> communityChannels = [];
    final publicPskHex = Channel.formatPskHex(
      community.deriveCommunityPublicPsk(),
    );

    for (final channel in connector.channels) {
      // Check if it's the public channel
      if (channel.pskHex == publicPskHex) {
        communityChannels.add(channel);
        continue;
      }
      // Check if it's a hashtag channel
      for (final hashtag in community.hashtagChannels) {
        final hashtagPskHex = Channel.formatPskHex(
          community.deriveCommunityHashtagPsk(hashtag),
        );
        if (channel.pskHex == hashtagPskHex) {
          communityChannels.add(channel);
          break;
        }
      }
    }

    final channelCount = communityChannels.length;
    _communityStore.setPublicKeyHex = connector.selfPublicKeyHex;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(dialogContext.l10n.community_delete),
        content: Text(
          channelCount > 0
              ? '${dialogContext.l10n.community_deleteConfirm(community.name)}\n\n${dialogContext.l10n.community_deleteChannelsWarning(channelCount)}'
              : dialogContext.l10n.community_deleteConfirm(community.name),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(dialogContext.l10n.common_cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);

              // Delete all community channels from the device
              for (final channel in communityChannels) {
                await connector.deleteChannel(channel.index);
              }

              // Remove community from store
              await _communityStore.removeCommunity(community.id);
              _loadCommunities();

              if (context.mounted) {
                showDismissibleSnackBar(
                  context,
                  content: Text(context.l10n.community_deleted(community.name)),
                );
              }
            },
            child: Text(
              dialogContext.l10n.community_delete,
              style: TextStyle(
                color: Theme.of(dialogContext).colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Contacts you have a conversation with, newest first, under the channels:
/// one list for everything you read.
class _DirectChats extends StatelessWidget {
  const _DirectChats({required this.connector});

  final MeshCoreConnector connector;

  static String _clock(DateTime t) {
    final local = t.toLocal();
    final now = DateTime.now();
    if (local.year == now.year &&
        local.month == now.month &&
        local.day == now.day) {
      return '${local.hour.toString().padLeft(2, '0')}:'
          '${local.minute.toString().padLeft(2, '0')}';
    }
    return '${local.month}/${local.day}';
  }

  @override
  Widget build(BuildContext context) {
    final chats = [
      for (final c in connector.contacts)
        if (connector.getMessages(c).isNotEmpty)
          (contact: c, last: connector.getMessages(c).last),
    ]..sort((a, b) => b.last.timestamp.compareTo(a.last.timestamp));
    if (chats.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InstrumentLabel(context.l10n.messages_filterDirect),
        for (final chat in chats.take(30))
          () {
            final unread = connector.getUnreadCountForContact(chat.contact);
            final hops = chat.contact.pathLength;
            return GlassChatCard(
              unreadCount: unread,
              child: InstrumentRow(
                divider: false,
                key: ValueKey('direct_${chat.contact.publicKeyHex}'),
                title: chat.contact.name,
                subtitle: chat.last.text,
                onTap: () {
                  HapticFeedback.selectionClick();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        contact: chat.contact,
                        initialUnreadCount: unread,
                      ),
                    ),
                  );
                },
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _clock(chat.last.timestamp),
                      style: MeshTheme.mono(
                        fontSize: 12,
                        color: MeshPalette.ink3,
                      ),
                    ),
                    Text(
                      unread > 0
                          ? '$unread'
                          : hops < 0
                          ? ''
                          : hops == 0
                          ? context.l10n.chat_direct
                          : context.l10n.chat_hopsCount(hops),
                      style: MeshTheme.mono(
                        fontSize: 12,
                        fontWeight: unread > 0 ? FontWeight.w700 : null,
                        color: unread > 0
                            ? MeshPalette.accent
                            : MeshPalette.ink4,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }(),
      ],
    );
  }
}

/// Public channels heard nearby that you haven't joined, as one quiet row
/// that opens a list to join or ignore them.
class _DiscoveredTray extends StatelessWidget {
  const _DiscoveredTray();

  @override
  Widget build(BuildContext context) {
    final discovery = context.watch<ChannelDiscoveryService?>();
    final found = discovery?.discovered ?? const [];
    if (discovery == null || found.isEmpty) return const SizedBox.shrink();
    final l10n = context.l10n;
    return InstrumentRow(
      key: const ValueKey('discovered-tray'),
      icon: Icons.wifi_tethering,
      title: l10n.discovered_tray(found.length),
      subtitle: found.take(3).map((d) => d.entry.name).join(', '),
      titleColor: MeshPalette.accent,
      onTap: () => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (_) => ChangeNotifierProvider.value(
          value: discovery,
          child: const _DiscoveredSheet(),
        ),
      ),
    );
  }
}

class _DiscoveredSheet extends StatelessWidget {
  const _DiscoveredSheet();

  @override
  Widget build(BuildContext context) {
    final discovery = context.watch<ChannelDiscoveryService>();
    final connector = context.watch<MeshCoreConnector>();
    final found = discovery.discovered;
    final l10n = context.l10n;
    if (found.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) Navigator.of(context).maybePop();
      });
    }
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.75,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            InstrumentLabel(l10n.discovered_title),
            for (final d in found)
              InstrumentRow(
                key: ValueKey('discovered-${d.entry.name}'),
                title: d.entry.name,
                subtitle: [
                  if (d.entry.description.isNotEmpty) d.entry.description,
                  l10n.discovered_heard(
                    d.heard,
                    TimeOfDay.fromDateTime(
                      d.lastHeard.toLocal(),
                    ).format(context),
                  ),
                ].join(' \u00B7 '),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () => discovery.ignore([d.entry.name]),
                      child: Text(l10n.discovered_ignore),
                    ),
                    FilledButton(
                      onPressed: () =>
                          joinHashtagChannel(context, connector, d.entry.name),
                      child: Text(l10n.channelDirectory_join),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(MeshSpace.lg),
              child: Row(
                children: [
                  Expanded(
                    child: InstrumentButton(
                      label: l10n.discovered_ignoreAll,
                      onPressed: () =>
                          discovery.ignore(found.map((d) => d.entry.name)),
                    ),
                  ),
                  const SizedBox(width: MeshSpace.sm),
                  Expanded(
                    child: InstrumentButton(
                      label: l10n.discovered_joinAll,
                      onPressed: () async {
                        for (final d in found) {
                          if (!context.mounted) return;
                          final ok = await joinHashtagChannel(
                            context,
                            connector,
                            d.entry.name,
                          );
                          if (!ok) return;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MeshSpace.lg,
                0,
                MeshSpace.lg,
                MeshSpace.lg,
              ),
              child: Text(
                l10n.discovered_explainer,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: MeshPalette.ink3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
