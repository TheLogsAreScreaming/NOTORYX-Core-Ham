import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/regional_preset.dart';
import '../services/regional_preset_service.dart';
import '../helpers/snack_bar_builder.dart';

/// "Your area's mesh uses…" with Review and Not now, shown when the radio
/// doesn't match the local mesh's published settings.
class RegionalPresetBanner extends StatelessWidget {
  const RegionalPresetBanner({super.key});

  @override
  Widget build(BuildContext context) {
    // Hidden where the service isn't provided (tests, previews).
    final service = context.watch<RegionalPresetService?>();
    final preset = service?.active;
    if (service == null || preset == null || !service.shouldOffer) {
      return const SizedBox.shrink();
    }
    final scheme = Theme.of(context).colorScheme;
    return Card(
      key: const ValueKey('regional-preset-banner'),
      color: scheme.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.settings_input_antenna,
                  color: scheme.onTertiaryContainer,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${preset.name} mesh settings',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: scheme.onTertiaryContainer,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              preset.fromMap
                  ? 'Most nodes around here${preset.nodeCount == null ? '' : ' (${preset.nodeCount} on the MeshCore map)'} use ${preset.summary}. Your radio is set differently, so you may not hear them.'
                  : 'The local mesh uses ${preset.summary}. Your radio is set differently, so you may not hear it.',
              style: TextStyle(color: scheme.onTertiaryContainer),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Wrap(
                spacing: 4,
                children: [
                  TextButton(
                    onPressed: service.dismiss,
                    child: const Text('Not now'),
                  ),
                  FilledButton.tonal(
                    onPressed: () => reviewRegionalPreset(context, preset),
                    child: const Text('Review'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shows exactly what will change, then applies [preset] to the radio.
Future<void> reviewRegionalPreset(
  BuildContext context,
  RegionalPreset preset,
) async {
  final service = context.read<RegionalPresetService>();
  final messenger = ScaffoldMessenger.of(context);
  final changes = service.active == preset
      ? service.differences
      : preset.differences(service.radio);
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Use ${preset.name} settings?'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (changes.isEmpty)
              const Text('Your radio already uses these settings.')
            else
              for (final c in changes)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text('• $c'),
                ),
            if (preset.notes.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(preset.notes),
            ],
            const SizedBox(height: 8),
            Text(
              '${preset.fromMap ? 'Reported by node owners on the MeshCore map, not checked on air. ' : ''}'
              'Updated ${preset.updated}. After switching you will only hear radios that use the same settings. Transmit power${preset.pathHashBytes == null ? ' and path hash size are' : ' is'} not changed.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: changes.isEmpty
              ? null
              : () => Navigator.pop(context, true),
          child: const Text('Apply to radio'),
        ),
      ],
    ),
  );
  if (ok != true) return;
  try {
    await service.apply(preset);
    messenger.showSnackBar(
      meshSnackBar(content: Text('Radio set to ${preset.name} settings.')),
    );
  } catch (e) {
    messenger.showSnackBar(
      meshSnackBar(content: Text('Could not change the radio: $e')),
    );
  }
}

/// Settings row: which area's settings to follow, and when the list was
/// last checked.
class RegionalPresetTile extends StatelessWidget {
  const RegionalPresetTile({super.key});

  @override
  Widget build(BuildContext context) {
    final service = context.watch<RegionalPresetService?>();
    if (service == null) return const SizedBox.shrink();
    final active = service.active;
    final auto = service.selection == RegionalPresetService.auto;
    final subtitle = active == null
        ? (auto
              ? 'No listed area around you.'
              : 'Chosen area is no longer listed.')
        : '${auto ? 'Auto: ' : ''}${active.name} • ${active.summary}';
    return ListTile(
      key: const ValueKey('regional-preset-tile'),
      leading: const Icon(Icons.public),
      title: const Text('Local mesh settings'),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _choose(context, service),
    );
  }

  Future<void> _choose(
    BuildContext context,
    RegionalPresetService service,
  ) async {
    final picked = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Local mesh settings'),
        children: [
          RadioGroup<String>(
            groupValue: service.selection,
            onChanged: (v) => Navigator.pop(context, v),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const RadioListTile<String>(
                  value: RegionalPresetService.auto,
                  title: Text('Automatic'),
                  subtitle: Text("From your radio's or phone's position"),
                ),
                for (final p in service.presets)
                  RadioListTile<String>(
                    value: p.id,
                    title: Text(p.name),
                    subtitle: Text(
                      p.fromMap ? '${p.summary} · MeshCore map' : p.summary,
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
            child: Text(
              service.lastChecked == null
                  ? 'Using the saved list. It updates from GitHub when online.'
                  : 'List checked ${TimeOfDay.fromDateTime(service.lastChecked!).format(context)}. Areas are added by pull request.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
    if (picked == null) return;
    await service.select(picked);
    final preset = service.active;
    if (preset != null && service.differences.isNotEmpty && context.mounted) {
      await reviewRegionalPreset(context, preset);
    }
  }
}
