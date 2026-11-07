import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../helpers/contact_ui.dart';
import '../l10n/l10n.dart';
import '../models/app_settings.dart';
import '../models/contact.dart';
import '../models/field_intel.dart';
import '../services/app_settings_service.dart';
import '../theme/mesh_theme.dart';
import '../widgets/ember_backdrop.dart';
import '../widgets/instrument.dart';
import '../widgets/mesh_ui.dart';
import '../widgets/node_sheet.dart';
import '../widgets/tactical_glass_panel.dart';
import 'bastion_map_hub_screen.dart';
import 'bastion_path_hub_screen.dart';
import 'networks_screen.dart';

/// Field intelligence: a live picture of the mesh around you, built from
/// the radio's contacts, routes, positions and stats. Every number opens
/// the nodes behind it.
class BastionFieldStatsScreen extends StatefulWidget {
  const BastionFieldStatsScreen({super.key});

  @override
  State<BastionFieldStatsScreen> createState() =>
      _BastionFieldStatsScreenState();
}

class _BastionFieldStatsScreenState extends State<BastionFieldStatsScreen> {
  Timer? _tick;

  @override
  void initState() {
    super.initState();
    // Ages and buckets move with the clock even when nothing new arrives.
    _tick = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _refresh());
  }

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }

  Future<void> _refresh() async {
    final c = context.read<MeshCoreConnector>();
    if (!c.isConnected) return;
    try {
      await c.requestRadioStats();
      await c.requestBatteryStatus(force: true);
    } catch (_) {
      // Readings stay as they were; the next poll tries again.
    }
  }

  /// The three nearest and two farthest, nearest first.
  List<NodeDistance> _nearAndFar(List<NodeDistance> sorted) =>
      sorted.length <= 5
      ? sorted
      : [...sorted.take(3), ...sorted.skip(sorted.length - 2)];

  String _airtime(int secs) {
    final h = secs ~/ 3600, m = (secs % 3600) ~/ 60, s = secs % 60;
    return h > 0 ? '${h}h ${m}m' : (m > 0 ? '${m}m ${s}s' : '${s}s');
  }

  String _heardLabel(HeardWhen w) {
    final l10n = context.l10n;
    return switch (w) {
      HeardWhen.quarterHour => l10n.fieldIntel_m15,
      HeardWhen.hour => l10n.fieldIntel_h1,
      HeardWhen.day => l10n.fieldIntel_h24,
      HeardWhen.older => l10n.fieldIntel_older,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final connector = context.watch<MeshCoreConnector>();
    final imperial = context.select<AppSettingsService, bool>(
      (s) => s.settings.unitSystem == UnitSystem.imperial,
    );
    final contacts = connector.contacts;
    final now = DateTime.now();
    final stats = connector.latestRadioStats;
    final batt = connector.batteryMillivolts;

    final heard = {for (final w in HeardWhen.values) w: <Contact>[]};
    final hops = {for (final b in HopBand.values) b: <Contact>[]};
    final types = <int, List<Contact>>{};
    for (final c in contacts) {
      heard[heardWhen(c.lastSeen, now)]!.add(c);
      hops[hopBand(c)]!.add(c);
      types.putIfAbsent(c.type, () => []).add(c);
    }
    final hourly = hourlyLastHeard(contacts, now);
    final lat = connector.selfLatitude, lon = connector.selfLongitude;
    final hasSelf = lat != null && lon != null && (lat != 0 || lon != 0);
    final distances = hasSelf
        ? byDistance(contacts, lat, lon)
        : const <NodeDistance>[];
    final direct = [...connector.directRepeaters]
      ..sort((a, b) => b.snr.compareTo(a.snr));
    final lowBatt = lowBatteryRepeaters(
      contacts,
      connector.getRepeaterBatteryMillivolts,
    );
    final quiet = quietFavorites(contacts, now);

    final typeRows = [
      (advTypeChat, l10n.fieldStats_chatNodes),
      (advTypeRepeater, l10n.bastion_repeaters),
      (advTypeRoom, l10n.fieldStats_rooms),
      (advTypeSensor, l10n.fieldStats_sensors),
    ];

    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: Text(l10n.fieldStats_title),
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: MeshSpace.xxl),
            children: [
              // Radio right now.
              InstrumentLabel(l10n.fieldIntel_radioNow),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MeshSpace.lg),
                child: TacticalGlassPanel(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  child: !connector.isConnected
                      ? Padding(
                          padding: const EdgeInsets.all(MeshSpace.md),
                          child: Text(
                            l10n.fieldIntel_noRadio,
                            style: TextStyle(color: MeshPalette.ink3),
                          ),
                        )
                      : Column(
                          children: [
                            ReadoutStrip([
                              Readout(
                                stats == null ? '—' : '${stats.noiseFloorDbm}',
                                l10n.fieldIntel_noise,
                              ),
                              Readout(
                                stats == null
                                    ? '—'
                                    : stats.lastSnrDb.toStringAsFixed(1),
                                l10n.fieldIntel_lastSnr,
                                color: stats == null
                                    ? null
                                    : MeshTheme.snrColor(
                                        stats.lastSnrDb,
                                        blocked: false,
                                      ),
                              ),
                              Readout(
                                stats == null ? '—' : '${stats.lastRssiDbm}',
                                l10n.fieldIntel_lastRssi,
                              ),
                              Readout(
                                batt == null
                                    ? '—'
                                    : (batt / 1000).toStringAsFixed(2),
                                l10n.fieldIntel_battery,
                              ),
                            ]),
                            if (stats != null)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  12,
                                  8,
                                  12,
                                  4,
                                ),
                                child: Text(
                                  l10n.fieldIntel_airtime(
                                    _airtime(stats.txAirSecs),
                                    _airtime(stats.rxAirSecs),
                                  ),
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: MeshPalette.ink3),
                                ),
                              ),
                          ],
                        ),
                ),
              ),

              // Who's around.
              InstrumentLabel(
                l10n.fieldIntel_whoAround,
                trailing: '${contacts.length}',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MeshSpace.lg),
                child: Row(
                  children: [
                    for (final w in HeardWhen.values) ...[
                      Expanded(
                        child: _Stat(
                          key: ValueKey('heard-${w.name}'),
                          value: '${heard[w]!.length}',
                          label: _heardLabel(w),
                          onTap: () =>
                              showNodeList(context, _heardLabel(w), heard[w]!),
                        ),
                      ),
                      if (w != HeardWhen.older)
                        const SizedBox(width: MeshSpace.sm),
                    ],
                  ],
                ),
              ),
              MeshCard(
                margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HourChart(
                      counts: hourly,
                      onTapHour: (i) => showNodeList(
                        context,
                        i == 23
                            ? l10n.fieldIntel_lastHour
                            : l10n.time_hoursAgo(23 - i),
                        heardInHour(contacts, i, now),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.fieldIntel_chartHint,
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: MeshPalette.ink3),
                    ),
                  ],
                ),
              ),

              // Node mix.
              InstrumentLabel(l10n.fieldIntel_mix),
              MeshCard(
                child: Column(
                  children: [
                    for (final (type, label) in typeRows)
                      _BarRow(
                        key: ValueKey('mix-$type'),
                        label: label,
                        count: types[type]?.length ?? 0,
                        total: contacts.length,
                        color: OkabeIto.nodeType(type),
                        onTap: () => showNodeList(
                          context,
                          label,
                          types[type] ?? const [],
                        ),
                      ),
                  ],
                ),
              ),

              // Reach.
              InstrumentLabel(l10n.fieldIntel_reach),
              MeshCard(
                child: Column(
                  children: [
                    for (final (i, b) in HopBand.values.indexed)
                      _BarRow(
                        key: ValueKey('hops-${b.name}'),
                        label: hopLabel(context.l10n, b),
                        count: hops[b]!.length,
                        total: contacts.length,
                        color: b == HopBand.unknown
                            ? MeshPalette.ink4
                            : OkabeIto.categorical[i],
                        onTap: () => showNodeList(
                          context,
                          hopLabel(context.l10n, b),
                          hops[b]!,
                        ),
                      ),
                  ],
                ),
              ),

              // Nearest and farthest.
              InstrumentLabel(l10n.fieldIntel_distance),
              if (!hasSelf || distances.isEmpty)
                MeshCard(
                  child: Text(
                    hasSelf
                        ? l10n.fieldIntel_noneLocated
                        : l10n.fieldIntel_noPosition,
                    style: TextStyle(color: MeshPalette.ink3),
                  ),
                )
              else
                MeshCard(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      for (final d in _nearAndFar(distances))
                        InstrumentRow(
                          icon: contactTypeIcon(d.contact.type),
                          title: d.contact.name,
                          subtitle: agoLabel(context.l10n, d.contact.lastSeen),
                          trailing: Text(
                            '${distanceLabel(d.km, imperial)} ${compassPoint(d.bearing)}',
                            style: MeshTheme.mono(
                              color: MeshPalette.ink,
                              fontSize: 13,
                            ),
                          ),
                          onTap: () => showNodeSheet(context, d.contact),
                          divider: false,
                        ),
                    ],
                  ),
                ),

              // Best repeaters heard directly.
              InstrumentLabel(l10n.fieldIntel_bestRepeaters),
              MeshCard(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: direct.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(MeshSpace.md),
                        child: Text(
                          l10n.fieldIntel_noneDirect,
                          style: TextStyle(color: MeshPalette.ink3),
                        ),
                      )
                    : Column(
                        children: [
                          for (final r in direct.take(5))
                            Builder(
                              builder: (context) {
                                final c = contacts
                                    .where(
                                      (c) =>
                                          c.publicKeyHex.toUpperCase() ==
                                          r.contactKeyHex?.toUpperCase(),
                                    )
                                    .firstOrNull;
                                return InstrumentRow(
                                  icon: Icons.cell_tower,
                                  title: c?.name ?? r.pubkeyPrefixHex,
                                  subtitle: agoLabel(
                                    context.l10n,
                                    r.lastUpdated,
                                  ),
                                  trailing: SignalReadout(r.snr),
                                  onTap: c == null
                                      ? null
                                      : () => showNodeSheet(context, c),
                                  divider: false,
                                );
                              },
                            ),
                        ],
                      ),
              ),

              // Needs attention.
              InstrumentLabel(l10n.fieldIntel_attention),
              MeshCard(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: lowBatt.isEmpty && quiet.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(MeshSpace.md),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              color: MeshPalette.signal,
                            ),
                            const SizedBox(width: MeshSpace.sm),
                            Text(l10n.fieldIntel_allGood),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          for (final (c, mv) in lowBatt)
                            InstrumentRow(
                              icon: Icons.battery_alert,
                              titleColor: MeshPalette.alert,
                              title: c.name,
                              subtitle: l10n.fieldIntel_lowBattery(
                                (mv / 1000).toStringAsFixed(2),
                              ),
                              onTap: () => showNodeSheet(context, c),
                              divider: false,
                            ),
                          for (final c in quiet)
                            InstrumentRow(
                              icon: Icons.star_outline,
                              title: c.name,
                              subtitle: l10n.fieldIntel_quietFavorite(
                                agoLabel(context.l10n, c.lastSeen),
                              ),
                              onTap: () => showNodeSheet(context, c),
                              divider: false,
                            ),
                        ],
                      ),
              ),

              // More tools.
              InstrumentLabel(l10n.fieldIntel_moreTools),
              for (final (icon, title, page) in [
                (
                  Icons.route_rounded,
                  l10n.bastionTools_pathAnalysis,
                  const BastionPathHubScreen() as Widget,
                ),
                (
                  Icons.map_outlined,
                  l10n.bastion_mapCoverage,
                  const BastionMapHubScreen(),
                ),
                (Icons.radar, l10n.networks_title, const NetworksScreen()),
              ])
                MeshCard(
                  onTap: () =>
                      Navigator.of(context)
                          .push(MaterialPageRoute<void>(builder: (_) => page)),
                  child: InstrumentRow(
                    icon: icon,
                    title: title,
                    trailing: Icon(
                      Icons.chevron_right,
                      color: MeshPalette.ink3,
                    ),
                    divider: false,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A big number with a label that opens the nodes behind it.
class _Stat extends StatelessWidget {
  const _Stat({
    super.key,
    required this.value,
    required this.label,
    required this.onTap,
  });

  final String value;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => MeshCard(
    margin: EdgeInsets.zero,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    onTap: onTap,
    child: Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium
              ?.copyWith(color: MeshPalette.ink, fontWeight: FontWeight.w800),
        ),
        Text(
          label,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelSmall
              ?.copyWith(color: MeshPalette.ink3),
        ),
      ],
    ),
  );
}

/// A labelled bar for one group, with its count, that opens the group.
class _BarRow extends StatelessWidget {
  const _BarRow({
    super.key,
    required this.label,
    required this.count,
    required this.total,
    required this.color,
    required this.onTap,
  });

  final String label;
  final int count;
  final int total;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: '$label, $count',
    excludeSemantics: true,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: MeshShape.minTouch),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              SizedBox(
                width: 104,
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: MeshPalette.ink2),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: total == 0 ? 0 : count / total,
                    minHeight: 10,
                    color: color,
                    backgroundColor: MeshPalette.line,
                  ),
                ),
              ),
              SizedBox(
                width: 44,
                child: Text(
                  '$count',
                  textAlign: TextAlign.right,
                  style: MeshTheme.mono(color: MeshPalette.ink, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

/// 24 bars, one per hour, tallest for the busiest hour.
class _HourChart extends StatelessWidget {
  const _HourChart({required this.counts, required this.onTapHour});

  final List<int> counts;
  final ValueChanged<int> onTapHour;

  @override
  Widget build(BuildContext context) {
    final max = counts.fold<int>(1, (m, c) => c > m ? c : m);
    return SizedBox(
      height: 72,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final (i, c) in counts.indexed)
            Expanded(
              // Bars are narrower than a finger; each still gets a spoken
              // label ("3 hours ago, 4") so screen-reader users can drill in.
              child: Semantics(
                button: true,
                label:
                    '${i == 23 ? context.l10n.fieldIntel_lastHour : context.l10n.time_hoursAgo(23 - i)}, $c',
                child: GestureDetector(
                  key: ValueKey('hour-$i'),
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onTapHour(i),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: c == 0 ? 2 : 4 + 64 * c / max,
                          decoration: BoxDecoration(
                            color: c == 0
                                ? MeshPalette.line
                                : MeshPalette.accent.withValues(
                                    alpha: i == 23 ? 1 : 0.75,
                                  ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
