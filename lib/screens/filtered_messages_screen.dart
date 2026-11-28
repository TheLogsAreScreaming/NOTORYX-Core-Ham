import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../helpers/snack_bar_builder.dart';
import '../l10n/l10n.dart';
import '../models/channel.dart';
import '../models/channel_message.dart';
import '../widgets/adaptive_app_bar_title.dart';
import '../widgets/empty_state.dart';
import '../widgets/filtered_message_ghost.dart';

/// Recent filtered channel messages across all channels, newest first.
///
/// Message text and sender stay hidden until a row is tapped, so the list
/// can be opened without being shown the spam itself. "Not spam" puts a
/// message back in its channel and teaches the filter.
///
/// Adapted from meshcore-open (MIT).
class FilteredMessagesScreen extends StatefulWidget {
  const FilteredMessagesScreen({super.key});

  @override
  State<FilteredMessagesScreen> createState() => _FilteredMessagesScreenState();
}

/// Identity of a row: message ids don't include the channel and can collide
/// across channels, so they are scoped by the channel's filter id.
String filteredMessageRowId(Channel channel, ChannelMessage message) =>
    '${MeshCoreConnector.messageFilterChannelId(channel)}|${message.messageId}';

class _FilteredMessagesScreenState extends State<FilteredMessagesScreen> {
  final Set<String> _revealed = <String>{};

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final connector = context.watch<MeshCoreConnector>();
    final entries = connector.recentFilteredChannelMessages();
    return Scaffold(
      appBar: AppBar(
        title: AdaptiveAppBarTitle(
          l10n.messageFilter_filteredMessages(entries.length),
        ),
      ),
      body: SafeArea(
        top: false,
        child: entries.isEmpty
            ? EmptyState(
                icon: Icons.visibility_off_outlined,
                title: l10n.messageFilter_filteredMessagesEmpty,
              )
            : ListView.separated(
                itemCount: entries.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final (channel, message) = entries[i];
                  final rowId = filteredMessageRowId(channel, message);
                  final revealed = _revealed.contains(rowId);
                  final reason = messageFilterReasonLabel(
                    l10n,
                    message.filterReason,
                    message.filterDetail,
                  );
                  final channelName = channel.name.isEmpty
                      ? '#${channel.index}'
                      : channel.name;
                  return ListTile(
                    key: ValueKey(rowId),
                    leading: const Icon(Icons.visibility_off_outlined),
                    title: Text(
                      revealed
                          ? '${message.senderName}: ${message.text}'
                          : l10n.messageFilter_ghostSingle,
                      maxLines: revealed ? null : 1,
                      overflow: revealed ? null : TextOverflow.ellipsis,
                    ),
                    subtitle: Text('$channelName · $reason'),
                    onTap: () => setState(() {
                      if (!_revealed.remove(rowId)) _revealed.add(rowId);
                    }),
                    trailing: TextButton(
                      onPressed: () async {
                        await connector.markChannelMessageNotSpam(
                          channel,
                          message,
                        );
                        if (!context.mounted) return;
                        showDismissibleSnackBar(
                          context,
                          content: Text(l10n.messageFilter_markedNotSpam),
                        );
                      },
                      child: Text(l10n.messageFilter_notSpam),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
