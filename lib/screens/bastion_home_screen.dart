import '../theme/mesh_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../l10n/l10n.dart';
import '../services/field_ops_service.dart';
import '../models/field_ops.dart';
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

  static Color get _cyan => MeshPalette.accent;
  static Color get _bg => MeshPalette.bg;
  static Color get _panel => MeshPalette.bg2;

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

    return Scaffold(
      backgroundColor: _bg,
      bottomNavigationBar: const QuickSwitchBar(current: MainTab.home),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    border: Border.all(color: _cyan, width: 2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.fort_rounded,
                    color: MeshPalette.ink,
                    size: 31,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BASTION',
                        style: TextStyle(
                          color: MeshPalette.ink,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2.4,
                        ),
                      ),
                      Text(
                        l10n.bastion_tagline,
                        style: TextStyle(
                          color: _cyan,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        'MeshCore',
                        style: TextStyle(color: _cyan, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: l10n.bastionHome_aboutTooltip,
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const BastionAboutScreen(),
                    ),
                  ),
                  icon: Icon(
                    Icons.info_outline_rounded,
                    color: MeshPalette.ink3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            const RegionalPresetBanner(),
            _ActionCard(
              icon: Icons.explore_outlined,
              title: l10n.bastionHome_getStarted,
              subtitle: l10n.bastionHome_getStartedHint,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const BastionSetupScreen()),
              ),
            ),
            const SizedBox(height: 12),
            _connectionCard(context, c, stats),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _metric(l10n.bastion_nodes, '${c.contacts.length}'),
                ),
                const SizedBox(width: 8),
                Expanded(child: _metric(l10n.bastion_active1h, '$active')),
                const SizedBox(width: 8),
                Expanded(child: _metric(l10n.bastion_repeaters, '$repeaters')),
              ],
            ),
            const SizedBox(height: 12),
            _ActionCard(
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
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const BastionFieldOpsScreen(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              key: const ValueKey('home-check-in'),
              // Only a missing radio or loading blocks this; missing
              // contacts or a stopped trip are sorted out on tap.
              onPressed: hardBlockReason(ops) == null
                  ? () => _checkIn(context, ops)
                  : null,
              icon: const Icon(Icons.check_circle_outline),
              label: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(l10n.bastionHome_checkInOk),
              ),
            ),
            const SizedBox(height: 4),
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
              style: TextStyle(color: MeshPalette.ink3, fontSize: 12),
            ),
            const SizedBox(height: 12),
            const SosPanel(),
            const SizedBox(height: 18),
            if (!c.isConnected)
              _ActionCard(
                icon: Icons.bluetooth_searching_rounded,
                title: l10n.bastionHome_connectRadio,
                subtitle: l10n.bastionHome_connectRadioHint,
                onTap: () => openConnectionSetup(context),
              )
            else
              _ActionCard(
                icon: Icons.monitor_heart_rounded,
                title: l10n.bastionHome_liveDiagnostics,
                subtitle: l10n.bastionHome_liveDiagnosticsHint,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const BastionDiagnosticsScreen(),
                  ),
                ),
              ),
            const SizedBox(height: 12),
            _ActionCard(
              icon: Icons.radar_rounded,
              title: l10n.bastionHome_meshDiscovery,
              subtitle: l10n.bastionHome_meshDiscoveryHint,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const DiscoveryScreen()),
              ),
            ),
            const SizedBox(height: 12),
            _ActionCard(
              icon: Icons.backpack_outlined,
              title: l10n.bastion_fieldOps,
              subtitle: l10n.bastionHome_fieldOpsHint,
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const BastionFieldOpsScreen(),
                ),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              l10n.bastionHome_fieldTools,
              style: TextStyle(
                color: _cyan,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _ToolTile(
                    icon: Icons.map_rounded,
                    label: l10n.bastion_mapCoverage,
                    status: l10n.bastionHome_statusActive,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const BastionMapHubScreen(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ToolTile(
                    icon: Icons.route_rounded,
                    label: l10n.bastion_routeIntelligence,
                    status: l10n.bastionHome_statusActive,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const BastionPathHubScreen(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _ToolTile(
                    icon: Icons.cell_tower_rounded,
                    label: l10n.bastion_repeaterTools,
                    status: l10n.bastionHome_statusActive,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const BastionRepeaterToolsScreen(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _ToolTile(
                    icon: Icons.analytics_rounded,
                    label: l10n.bastion_fieldStats,
                    status: l10n.bastionHome_statusActive,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const BastionFieldStatsScreen(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'BASTION',
                style: TextStyle(
                  color: MeshPalette.ink4,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _connectionCard(
    BuildContext context,
    MeshCoreConnector c,
    dynamic stats,
  ) {
    final l10n = context.l10n;
    final battery = c.batteryMillivolts == null
        ? '—'
        : '${(c.batteryMillivolts! / 1000).toStringAsFixed(2)}V';
    final signal = stats == null
        ? 'RSSI —  •  SNR —'
        : 'RSSI ${stats.lastRssiDbm}  •  SNR ${stats.lastSnrDb.toStringAsFixed(1)}';
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _panel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: c.isConnected
              ? _cyan.withValues(alpha: .55)
              : MeshPalette.line,
        ),
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
                  color: _cyan.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  c.isConnected
                      ? Icons.radio_rounded
                      : Icons.portable_wifi_off_rounded,
                  color: _cyan,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.isConnected
                          ? l10n.bastionHome_consoleOnline
                          : l10n.bastionHome_consoleReady,
                      style: TextStyle(
                        color: MeshPalette.ink,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      c.isConnected
                          ? '${c.deviceDisplayName} • ${c.activeTransport.name.toUpperCase()}'
                          : l10n.bastionHome_consoleHint,
                      style: TextStyle(color: MeshPalette.ink3, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: c.isConnected ? _cyan : MeshPalette.line3,
                ),
              ),
            ],
          ),
          if (c.isConnected) ...[
            const SizedBox(height: 14),
            Divider(color: MeshPalette.line, height: 1),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    signal,
                    style: TextStyle(
                      color: MeshPalette.ink2,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  l10n.bastionHome_battery(battery),
                  style: TextStyle(
                    color: _cyan,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ],
        ],
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

  Widget _metric(String label, String value) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 11),
    decoration: BoxDecoration(
      color: _panel,
      borderRadius: BorderRadius.circular(13),
      border: Border.all(color: MeshPalette.line),
    ),
    child: Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: _cyan,
            fontSize: 17,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: MeshPalette.ink3,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => Material(
    color: MeshPalette.bg2,
    borderRadius: BorderRadius.circular(16),
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: MeshPalette.line),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: MeshPalette.accent.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(icon, color: MeshPalette.accent),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: MeshPalette.ink,
                      fontWeight: FontWeight.w800,
                      letterSpacing: .5,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: MeshPalette.accent),
          ],
        ),
      ),
    ),
  );
}

class _ToolTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String status;
  final VoidCallback? onTap;
  const _ToolTile({
    required this.icon,
    required this.label,
    required this.status,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) => Material(
    color: MeshPalette.bg2,
    borderRadius: BorderRadius.circular(16),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: MeshPalette.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: MeshPalette.accent),
                const Spacer(),
                Text(
                  status,
                  style: TextStyle(
                    color: MeshPalette.accent,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              label,
              style: TextStyle(
                color: MeshPalette.ink,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
