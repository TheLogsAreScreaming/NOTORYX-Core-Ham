import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../models/app_settings.dart';
import '../services/app_settings_service.dart';
import 'mesh_ui.dart';

/// Settings' auto-delete choice for old channel messages.
class ChannelRetentionCard extends StatelessWidget {
  const ChannelRetentionCard({super.key});

  static String label(int days) => switch (days) {
    0 => 'Never',
    365 => 'After 1 year',
    _ => 'After $days days',
  };

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettingsService>();
    return MeshCard(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: DropdownButtonFormField<int>(
        key: const ValueKey('channel-retention'),
        initialValue: settings.settings.channelMessageRetentionDays,
        decoration: const InputDecoration(
          labelText: 'Delete old channel messages',
          helperText:
              'Frees space on this phone. Direct messages are never deleted.',
          helperMaxLines: 2,
          icon: Icon(Icons.auto_delete_outlined),
        ),
        items: [
          for (final days in channelRetentionChoices)
            DropdownMenuItem(value: days, child: Text(label(days))),
        ],
        onChanged: (days) async {
          if (days == null) return;
          final connector = context.read<MeshCoreConnector>();
          final messenger = ScaffoldMessenger.of(context);
          await settings.setChannelMessageRetentionDays(days);
          final removed = await connector.pruneOldChannelMessages();
          if (removed > 0) {
            messenger.showSnackBar(
              SnackBar(
                content: Text(
                  'Deleted $removed old channel ${removed == 1 ? 'message' : 'messages'}.',
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
