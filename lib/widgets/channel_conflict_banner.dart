import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/l10n.dart';
import '../models/channel.dart';
import '../models/channel_conflict.dart';

/// Shown above the channel list when the radio's channels differ from the
/// app's saved copies. Opens a sheet to choose a version per slot.
class ChannelConflictBanner extends StatelessWidget {
  const ChannelConflictBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.select<MeshCoreConnector, int>(
      (c) => c.channelConflicts.length,
    );
    if (count == 0) return const SizedBox.shrink();
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Card(
        color: scheme.errorContainer,
        margin: EdgeInsets.zero,
        child: ListTile(
          leading: Icon(Icons.sync_problem, color: scheme.onErrorContainer),
          title: Text(
            l10n.channelConflict_banner(count),
            style: TextStyle(color: scheme.onErrorContainer),
          ),
          trailing: TextButton(
            onPressed: () => showChannelConflictSheet(context),
            child: Text(l10n.channelConflict_review),
          ),
          onTap: () => showChannelConflictSheet(context),
        ),
      ),
    );
  }
}

Future<void> showChannelConflictSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => const _ConflictSheet(),
  );
}

class _ConflictSheet extends StatelessWidget {
  const _ConflictSheet();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final connector = context.watch<MeshCoreConnector>();
    final conflicts = connector.channelConflicts;
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.8,
        ),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            Text(
              l10n.channelConflict_title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(l10n.channelConflict_hint),
            const SizedBox(height: 12),
            if (conflicts.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(l10n.channelConflict_allResolved),
              ),
            for (final conflict in conflicts)
              _ConflictCard(
                conflict: conflict,
                connected: connector.isConnected,
              ),
          ],
        ),
      ),
    );
  }
}

class _ConflictCard extends StatelessWidget {
  const _ConflictCard({required this.conflict, required this.connected});

  final ChannelConflict conflict;
  final bool connected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final connector = context.read<MeshCoreConnector>();
    final what = [
      if (conflict.nameDiffers) l10n.channelConflict_nameDiffers,
      if (conflict.keyDiffers) l10n.channelConflict_keyDiffers,
    ].join(' · ');
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.channelConflict_slot(conflict.index),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(what, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            _Side(label: l10n.channelConflict_onRadio, channel: conflict.radio),
            const SizedBox(height: 4),
            _Side(label: l10n.channelConflict_inApp, channel: conflict.app),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    final done = l10n.channelConflict_keptRadio(conflict.index);
                    await connector.keepRadioChannel(conflict.index);
                    messenger.showSnackBar(SnackBar(content: Text(done)));
                  },
                  child: Text(l10n.channelConflict_keepRadio),
                ),
                FilledButton(
                  onPressed: connected
                      ? () async {
                          final messenger = ScaffoldMessenger.of(context);
                          final done = l10n.channelConflict_usedApp(
                            conflict.index,
                          );
                          await connector.restoreAppChannel(conflict.index);
                          messenger.showSnackBar(SnackBar(content: Text(done)));
                        }
                      : null,
                  child: Text(l10n.channelConflict_useApp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Side extends StatelessWidget {
  const _Side({required this.label, required this.channel});

  final String label;
  final Channel? channel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = channel;
    final value = c == null
        ? l10n.channelConflict_empty
        : '${c.name.isEmpty ? '—' : c.name}  ·  '
              '${l10n.channelConflict_key(channelKeyFingerprint(c.psk))}';
    return Semantics(
      label: '$label: $value',
      excludeSemantics: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: Theme.of(context).textTheme.labelMedium),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
