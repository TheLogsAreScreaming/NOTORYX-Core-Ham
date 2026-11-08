import 'package:flutter/material.dart';

import '../connector/meshcore_protocol.dart';
import '../connector/meshcore_connector.dart';
import '../helpers/snack_bar_builder.dart';
import '../l10n/l10n.dart';
import '../theme/mesh_theme.dart';
import 'battery_indicator.dart';
import 'mesh_ui.dart';
import 'radio_stats_entry.dart';

/// "910.525 MHz · SF7 · BW62.5 · CR5 · 22 dBm", or null before the radio
/// has reported its settings.
String? radioSettingsLine(MeshCoreConnector connector) {
  final freq = radioFrequencyMHz(connector.currentFreqHz);
  final bw = connector.currentBwHz;
  final sf = connector.currentSf;
  final cr = connector.currentCr;
  final tx = connector.currentTxPower;
  if (freq == null) return null;
  String trim(double v) => v
      .toStringAsFixed(3)
      .replaceFirst(RegExp(r'0+$'), '')
      .replaceFirst(RegExp(r'\.$'), '');
  return [
    '${trim(freq)}\u00A0MHz',
    if (sf != null) 'SF$sf',
    if (bw != null) 'BW${trim(bw / 1000)}',
    if (cr != null) 'CR$cr',
    if (tx != null) '$tx\u00A0dBm',
  ].join(' · '); // Units stay attached to their numbers when wrapping.
}

/// Top of the Radio tab: the connected radio's identity, battery and radio
/// parameters, plus the two actions people reach for most.
class RadioOverviewCard extends StatelessWidget {
  final MeshCoreConnector connector;

  const RadioOverviewCard({super.key, required this.connector});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final percent = connector.batteryPercent;
    final battery = batteryUiForPercent(percent);
    final firmware = connector.firmwareVersionString;
    final radioLine = radioSettingsLine(connector);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MeshCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer,
                      borderRadius: BorderRadius.circular(MeshRadii.md),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.settings_input_antenna,
                      color: scheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          connector.deviceDisplayName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (firmware != null && firmware.isNotEmpty)
                          Text(
                            l10n.radioOverview_firmware(firmware),
                            style: TextStyle(
                              fontSize: 14,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  _ConnectedChip(label: l10n.common_connected),
                ],
              ),
              if (percent != null) ...[
                const SizedBox(height: 14),
                Row(
                  children: [
                    Icon(
                      battery.icon,
                      size: 20,
                      color: battery.color ?? scheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      l10n.radioOverview_battery,
                      style: TextStyle(
                        fontSize: 14,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '$percent%',
                      style: MeshTheme.mono(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: scheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ],
              if (radioLine != null) ...[
                const SizedBox(height: 10),
                Text(
                  radioLine,
                  style: MeshTheme.mono(
                    fontSize: 13,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                  ),
                  onPressed: () => showAdvertChoice(context, connector),
                  icon: const Icon(Icons.cell_tower),
                  label: Text(l10n.radioOverview_sendAdvert),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                  ),
                  onPressed: connector.supportsCompanionRadioStats
                      ? () => pushCompanionRadioStatsScreen(context)
                      : null,
                  icon: const Icon(Icons.sensors_outlined),
                  label: Text(l10n.radioOverview_stats),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ConnectedChip extends StatelessWidget {
  final String label;

  const _ConnectedChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: MeshPalette.signal.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(MeshRadii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: MeshPalette.signal,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: MeshPalette.signal,
            ),
          ),
        ],
      ),
    );
  }
}

/// Asks how far the advert should go, then sends it: zero-hop reaches only
/// radios that hear this one directly; flood is passed on by repeaters.
Future<void> showAdvertChoice(
  BuildContext context,
  MeshCoreConnector connector,
) async {
  final l10n = context.l10n;
  final flood = await showMeshSheet<bool>(
    context,
    builder: (sheet) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetHeader(title: l10n.radioOverview_sendAdvert),
          ListTile(
            key: const ValueKey('advert-zero-hop'),
            leading: const Icon(Icons.connect_without_contact),
            title: Text(l10n.contacts_zeroHopAdvert),
            subtitle: Text(l10n.advert_zeroHopHint),
            onTap: () => Navigator.of(sheet).pop(false),
          ),
          ListTile(
            key: const ValueKey('advert-flood'),
            leading: const Icon(Icons.cell_tower),
            title: Text(l10n.contacts_floodAdvert),
            subtitle: Text(l10n.advert_floodHint),
            onTap: () => Navigator.of(sheet).pop(true),
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
  if (flood == null || !context.mounted) return;
  await connector.sendSelfAdvert(flood: flood);
  if (!context.mounted) return;
  showDismissibleSnackBar(
    context,
    content: Text(l10n.settings_advertisementSent),
  );
}
