import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';
import '../services/app_settings_service.dart';

/// Lists blocked channel senders, each with an Unblock button.
Future<void> showBlockedSendersSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    builder: (_) => const BlockedSendersSheet(),
  );
}

/// The blocked-senders list, kept in step with settings as names are
/// unblocked.
class BlockedSendersSheet extends StatelessWidget {
  const BlockedSendersSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final service = context.watch<AppSettingsService>();
    final names = service.settings.blockedSenders.toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.7,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
            child: Text(
              l10n.block_listTitle,
              style: theme.textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
            child: Text(l10n.block_listHint, style: theme.textTheme.bodySmall),
          ),
          const Divider(height: 1),
          if (names.isEmpty)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Center(child: Text(l10n.block_listEmpty)),
            )
          else
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: names.length,
                itemBuilder: (context, i) => ListTile(
                  key: ValueKey('blocked-${names[i]}'),
                  leading: const Icon(Icons.block),
                  title: Text(names[i]),
                  trailing: TextButton(
                    onPressed: () => unawaited(service.unblockSender(names[i])),
                    child: Text(l10n.block_unblock),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
