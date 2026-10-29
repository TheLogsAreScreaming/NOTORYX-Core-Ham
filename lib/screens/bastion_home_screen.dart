import 'dart:async';

import '../theme/mesh_theme.dart';
import '../widgets/notoryx_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../l10n/l10n.dart';
import '../services/field_ops_service.dart';
import '../models/field_ops.dart';
import '../widgets/mesh_ui.dart';
import '../widgets/regional_preset_banner.dart';
import 'bastion_about_screen.dart';
import 'bastion_field_ops_screen.dart';
import 'bastion_diagnostics_screen.dart';
import 'bastion_field_stats_screen.dart';
import 'bastion_map_hub_screen.dart';
import 'bastion_path_hub_screen.dart';
import 'bastion_repeater_tools_screen.dart';
import 'discovery_screen.dart';
import 'connection_setup_screen.dart';
import 'bastion_setup_screen.dart';
import '../widgets/sos_panel.dart';
import '../widgets/quick_trip_setup.dart';
import '../widgets/quick_switch_bar.dart';
import '../utils/main_tab_navigation.dart';

class BastionHomeScreen extends StatelessWidget {
  const BastionHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.watch<MeshCoreConnector>();
    final stats = c.latestRadioStats;
    final ops = context.watch<FieldOpsService>();
    final l10n = context.l10n;
    final checkInReason = checkInUnavailableReason(
      ready: ops.ready,
      storageError: ops.error != null,
      active: ops.trip.active,
      connected: c.isConnected,
      busy: ops.busy,
      selectedContacts: ops.trip.members.length,
      availableContacts: ops.members.length,
      l10n: l10n,
    );
    final repeaters = c.contacts.where((x) => x.type == advTypeRepeater).length;
    final active = c.contacts
        .where((x) => DateTime.now().difference(x.lastSeen).inMinutes <= 60)
        .length;
    void open(Widget screen) =>
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));

    return Scaffold(
      backgroundColor: MeshPalette.bg,
      bottomNavigationBar: const QuickSwitchBar(current: MainTab.home),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            MeshSpace.lg,
            MeshSpace.lg,
            MeshSpace.lg,
            MeshSpace.xxl,
          ),
          children: [
            Row(
              children: [
                const NotoryxLogo(size: 40),
                const SizedBox(width: MeshSpace.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NOTORYX',
                        style: TextStyle(
                          color: MeshPalette.ink,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        l10n.bastion_tagline,
                        style: TextStyle(color: MeshPalette.ink3, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: l10n.bastionHome_aboutTooltip,
                  onPressed: () => open(const BastionAboutScreen()),
                  icon: Icon(
                    Icons.info_outline_rounded,
                    color: MeshPalette.ink3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: MeshSpace.xl),
            const RegionalPresetBanner(),
            _StatusCard(
              connector: c,
              stats: stats,
              repeaters: repeaters,
              active: active,
            ),
            const SizedBox(height: MeshSpace.lg),
            SizedBox(
              height: 52,
              child: FilledButton.icon(
                key: const ValueKey('home-check-in'),
                // Only a missing radio or loading blocks this; missing
                // contacts or a stopped trip are sorted out on tap.
                onPressed: hardBlockReason(ops) == null
                    ? () {
                        HapticFeedback.selectionClick();
                        unawaited(_checkIn(context, ops));
                      }
                    : null,
                icon: const Icon(Icons.check_circle_outline),
                label: Text(
                  l10n.bastionHome_checkInOk,
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: MeshSpace.sm),
            Text(
              hardBlockReason(ops) ??
                  (!hasCheckInContacts(ops)
                      ? 'Tap to choose who gets your check-ins.'
                      : !ops.trip.active
                      ? 'Tap to start your trip and check in.'
                      : checkInReason ??
                            (ops.latestDelivery == null
                                ? l10n.bastionHome_checkInHint
                                : l10n.bastionHome_lastCheckIn(
                                    ops.latestDelivery!.headlineIn(l10n),
                                  ))),
              style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
            ),
            const SizedBox(height: MeshSpace.md),
            const SosPanel(),
            const SizedBox(height: MeshSpace.xl),
            MeshGroup(
              children: [
                MeshNavRow(
                  icon: Icons.backpack_outlined,
                  title: ops.trip.active
                      ? ops.trip.name
                      : l10n.bastionHome_planYourTrip,
                  subtitle: [
                    l10n.bastionHome_tripSummary(
                      ops.trip.active
                          ? l10n.bastionHome_tripActive
                          : l10n.bastionHome_tripStopped,
                      '${ops.members.length}',
                      '${c.getTotalUnreadCount()}',
                    ),
                    if (ops.overdueNames.isNotEmpty)
                      l10n.fieldOps_quietTooLong(ops.overdueNames.join(', ')),
                  ].join(' • '),
                  iconColor: ops.trip.active ? MeshPalette.accent : null,
                  onTap: () => open(const BastionFieldOpsScreen()),
                ),
                MeshNavRow(
                  icon: Icons.explore_outlined,
                  title: l10n.bastionHome_getStarted,
                  subtitle: l10n.bastionHome_getStartedHint,
                  onTap: () => open(const BastionSetupScreen()),
                ),
              ],
            ),
            SectionHeader(
              l10n.bastionHome_fieldTools,
              padding: const EdgeInsets.fromLTRB(
                MeshSpace.xs,
                MeshSpace.xl,
                MeshSpace.xs,
                MeshSpace.sm,
              ),
            ),
            MeshGroup(
              children: [
                if (c.isConnected)
                  MeshNavRow(
                    icon: Icons.monitor_heart_outlined,
                    title: l10n.bastionHome_liveDiagnostics,
                    subtitle: l10n.bastionHome_liveDiagnosticsHint,
                    onTap: () => open(const BastionDiagnosticsScreen()),
                  ),
                MeshNavRow(
                  icon: Icons.radar_rounded,
                  title: l10n.bastionHome_meshDiscovery,
                  subtitle: l10n.bastionHome_meshDiscoveryHint,
                  onTap: () => open(const DiscoveryScreen()),
                ),
                MeshNavRow(
                  icon: Icons.map_outlined,
                  title: l10n.bastion_mapCoverage,
                  subtitle: l10n.bastionTools_mapHint,
                  onTap: () => open(const BastionMapHubScreen()),
                ),
                MeshNavRow(
                  icon: Icons.route_rounded,
                  title: l10n.bastion_routeIntelligence,
                  subtitle: l10n.bastionTools_pathHint,
                  onTap: () => open(const BastionPathHubScreen()),
                ),
                MeshNavRow(
                  icon: Icons.cell_tower_rounded,
                  title: l10n.bastion_repeaterTools,
                  subtitle: l10n.bastionTools_repeaterHint,
                  onTap: () => open(const BastionRepeaterToolsScreen()),
                ),
                MeshNavRow(
                  icon: Icons.analytics_outlined,
                  title: l10n.bastion_fieldStats,
                  subtitle: l10n.bastionTools_statsHint,
                  onTap: () => open(const BastionFieldStatsScreen()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Check in, first choosing recipients and starting the trip if needed.
  Future<void> _checkIn(BuildContext context, FieldOpsService ops) async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    if (!hasCheckInContacts(ops)) {
      final saved = await showQuickTripSetup(context, ops, forSos: false);
      if (!saved || !hasCheckInContacts(ops)) return;
    }
    if (!ops.trip.active) {
      try {
        await ops.startTrip();
      } catch (e) {
        messenger.showSnackBar(SnackBar(content: Text('$e')));
        return;
      }
    }
    await navigator.push(
      MaterialPageRoute<void>(
        builder: (_) => const BastionFieldOpsScreen(initialCheckIn: true),
      ),
    );
  }
}

/// The radio at a glance: who you're connected to, how, and what it hears.
/// Disconnected, it becomes the way to connect one.
class _StatusCard extends StatelessWidget {
  final MeshCoreConnector connector;
  final dynamic stats;
  final int repeaters;
  final int active;

  const _StatusCard({
    required this.connector,
    required this.stats,
    required this.repeaters,
    required this.active,
  });

  static String _transport(MeshCoreTransportType t) => switch (t) {
    MeshCoreTransportType.bluetooth => 'Bluetooth',
    MeshCoreTransportType.usb => 'USB',
    MeshCoreTransportType.tcp => 'TCP',
  };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = connector;
    final online = c.isConnected;
    final details = <String>[
      if (c.batteryMillivolts != null)
        l10n.bastionHome_battery(
          '${(c.batteryMillivolts! / 1000).toStringAsFixed(2)} V',
        ),
      if (stats != null) 'RSSI ${stats.lastRssiDbm}',
      if (stats != null) 'SNR ${stats.lastSnrDb.toStringAsFixed(1)}',
    ];
    return Container(
      padding: const EdgeInsets.all(MeshSpace.lg),
      decoration: BoxDecoration(
        color: MeshPalette.bg2,
        borderRadius: BorderRadius.circular(MeshRadii.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: online ? MeshPalette.accentBg : MeshPalette.bg3,
                  borderRadius: BorderRadius.circular(MeshRadii.md),
                ),
                child: Icon(
                  online
                      ? Icons.radio_rounded
                      : Icons.portable_wifi_off_rounded,
                  color: online ? MeshPalette.accent : MeshPalette.ink3,
                ),
              ),
              const SizedBox(width: MeshSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      online
                          ? c.deviceDisplayName
                          : l10n.bastionHome_consoleReady,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: MeshPalette.ink,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    if (online)
                      Row(
                        children: [
                          PulseDot(color: MeshPalette.signal, size: 7),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              '${l10n.common_connected} · ${_transport(c.activeTransport)}',
                              style: TextStyle(
                                color: MeshPalette.ink3,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      Text(
                        l10n.bastionHome_consoleHint,
                        style: TextStyle(color: MeshPalette.ink3, fontSize: 13),
                      ),
                  ],
                ),
              ),
            ],
          ),
          if (online) ...[
            const SizedBox(height: MeshSpace.lg),
            Row(
              children: [
                Expanded(
                  child: MeshStat(
                    value: '${c.contacts.length}',
                    label: l10n.bastion_nodes,
                  ),
                ),
                Expanded(
                  child: MeshStat(
                    value: '$repeaters',
                    label: l10n.bastion_repeaters,
                  ),
                ),
                // Zero recent activity says nothing; leave the space empty.
                Expanded(
                  child: active > 0
                      ? MeshStat(value: '$active', label: l10n.bastion_active1h)
                      : const SizedBox.shrink(),
                ),
              ],
            ),
            if (details.isNotEmpty) ...[
              const SizedBox(height: MeshSpace.md),
              Text(
                details.join('  ·  '),
                style: TextStyle(
                  color: MeshPalette.ink3,
                  fontSize: 12.5,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ] else ...[
            const SizedBox(height: MeshSpace.lg),
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonalIcon(
                onPressed: () => openConnectionSetup(context),
                icon: const Icon(Icons.bluetooth_searching_rounded),
                label: Text(l10n.bastionHome_connectRadio),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
