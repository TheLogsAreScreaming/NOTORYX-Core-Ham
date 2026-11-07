import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../l10n/l10n.dart';
import '../models/contact.dart';
import '../models/field_intel.dart';
import '../theme/mesh_theme.dart';
import '../widgets/ember_backdrop.dart';
import '../widgets/instrument.dart';
import '../widgets/mesh_ui.dart';
import '../widgets/node_sheet.dart';
import 'antenna_hunt_screen.dart';
import 'prefix_tool_screen.dart';
import 'region_setup_screen.dart';
import 'repeater_ping_screen.dart';

enum _Filter { all, recent, direct, lowBattery }

/// Repeater tools: the repeaters your radio knows, how they're doing, and
/// the tools for working on them. Tap a repeater for its details, and log
/// in from there for status, neighbours, telemetry and command line.
class BastionRepeaterToolsScreen extends StatefulWidget {
  const BastionRepeaterToolsScreen({super.key});

  @override
  State<BastionRepeaterToolsScreen> createState() =>
      _BastionRepeaterToolsScreenState();
}

class _BastionRepeaterToolsScreenState
    extends State<BastionRepeaterToolsScreen> {
  _Filter _filter = _Filter.all;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final connector = context.watch<MeshCoreConnector>();
    final now = DateTime.now();
    final repeaters = connector.contacts
        .where((c) => c.type == advTypeRepeater)
        .toList();
    final directSnr = <String, double>{
      for (final r in connector.directRepeaters)
        if (r.contactKeyHex != null) r.contactKeyHex!.toLowerCase(): r.snr,
    };
    double? snrOf(Contact c) => directSnr[c.publicKeyHex.toLowerCase()];
    int? mvOf(Contact c) =>
        connector.getRepeaterBatteryMillivolts(c.publicKeyHex);
    bool low(Contact c) {
      final mv = mvOf(c);
      return mv != null && mv > 0 && mv < lowBatteryMv;
    }

    final groups = {
      _Filter.all: repeaters,
      _Filter.recent: [
        for (final c in repeaters)
          if (now.difference(c.lastSeen) <= const Duration(hours: 1)) c,
      ],
      _Filter.direct: [
        for (final c in repeaters)
          if (snrOf(c) != null) c,
      ],
      _Filter.lowBattery: [
        for (final c in repeaters)
          if (low(c)) c,
      ],
    };
    final shown = [...groups[_filter]!]
      ..sort(
        (a, b) => _filter == _Filter.direct
            ? snrOf(b)!.compareTo(snrOf(a)!)
            : b.lastSeen.compareTo(a.lastSeen),
      );
    String label(_Filter f) => switch (f) {
      _Filter.all => l10n.repeaterTools_filterAll,
      _Filter.recent => l10n.fieldIntel_lastHour,
      _Filter.direct => l10n.repeaterTools_heardDirect,
      _Filter.lowBattery => l10n.repeaterTools_filterLowBattery,
    };

    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: Text(l10n.bastion_repeaterTools),
        ),
        body: ListView(
          padding: const EdgeInsets.only(bottom: MeshSpace.xxl),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MeshSpace.lg,
                MeshSpace.sm,
                MeshSpace.lg,
                0,
              ),
              child: Wrap(
                spacing: MeshSpace.sm,
                runSpacing: MeshSpace.sm,
                children: [
                  for (final f in _Filter.values)
                    ChoiceChip(
                      key: ValueKey('repeater-filter-${f.name}'),
                      label: Text('${label(f)} (${groups[f]!.length})'),
                      selected: _filter == f,
                      onSelected: (_) => setState(() => _filter = f),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MeshSpace.lg,
                MeshSpace.sm,
                MeshSpace.lg,
                0,
              ),
              child: Text(
                l10n.repeaterTools_hint,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: MeshPalette.ink3),
              ),
            ),
            const SizedBox(height: MeshSpace.sm),
            if (repeaters.isEmpty)
              MeshCard(
                child: Text(
                  l10n.repeaterTools_empty,
                  style: TextStyle(color: MeshPalette.ink2),
                ),
              )
            else if (shown.isEmpty)
              MeshCard(
                child: Text(
                  l10n.repeaterTools_noneMatch,
                  style: TextStyle(color: MeshPalette.ink3),
                ),
              )
            else
              for (final r in shown)
                MeshCard(
                  key: ValueKey('repeater-${r.publicKeyHex}'),
                  onTap: () => showNodeSheet(context, r),
                  child: InstrumentRow(
                    icon: Icons.cell_tower_rounded,
                    titleColor: low(r) ? MeshPalette.alert : null,
                    title: r.name.isEmpty ? l10n.repeaterTools_unnamed : r.name,
                    subtitle: [
                      hopLabel(l10n, hopBand(r)),
                      agoLabel(l10n, r.lastSeen),
                      if (mvOf(r) case final mv? when mv > 0)
                        '${(mv / 1000).toStringAsFixed(2)} V',
                    ].join(' · '),
                    trailing: snrOf(r) == null
                        ? Icon(Icons.chevron_right, color: MeshPalette.ink3)
                        : SignalReadout(snrOf(r)!),
                    divider: false,
                  ),
                ),
            InstrumentLabel(l10n.repeaterTools_toolsTitle),
            for (final (icon, title, subtitle, page) in [
              (
                Icons.network_ping,
                l10n.ping_title,
                l10n.ping_toolSubtitle,
                const RepeaterPingScreen() as Widget,
              ),
              (
                Icons.track_changes,
                l10n.hunt_title,
                l10n.hunt_toolSubtitle,
                const AntennaHuntScreen(),
              ),
              (
                Icons.fingerprint,
                l10n.prefixTool_title,
                l10n.prefixTool_subtitle,
                const PrefixToolScreen(),
              ),
              (
                Icons.public,
                l10n.regionSetup_title,
                l10n.repeaterTools_regionSetupHint,
                const RegionSetupScreen(),
              ),
            ])
              MeshCard(
                onTap: () => Navigator.of(
                  context,
                ).push(MaterialPageRoute<void>(builder: (_) => page)),
                child: InstrumentRow(
                  icon: icon,
                  title: title,
                  subtitle: subtitle,
                  trailing: Icon(Icons.chevron_right, color: MeshPalette.ink3),
                  divider: false,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
