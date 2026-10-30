import 'dart:async';

import '../theme/mesh_theme.dart';
import '../widgets/notoryx_logo.dart';
import '../widgets/tactical_glass_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/l10n.dart';
import '../services/field_ops_service.dart';
import '../models/field_ops.dart';
import '../helpers/direct_heard_name.dart';
import '../services/corescope.dart';
import '../services/direct_repeater_service.dart';
import '../widgets/instrument.dart';
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

  static String _transport(MeshCoreTransportType t) => switch (t) {
    MeshCoreTransportType.bluetooth => 'BLE',
    MeshCoreTransportType.usb => 'USB',
    MeshCoreTransportType.tcp => 'TCP',
  };

  @override
  Widget build(BuildContext context) {
    final c = context.watch<MeshCoreConnector>();
    final stats = c.latestRadioStats;
    final ops = context.watch<FieldOpsService>();
    final heard = context.watch<DirectRepeaterService?>()?.best() ?? const [];
    final l10n = context.l10n;
    final online = c.isConnected;
    final checkInReason = checkInUnavailableReason(
      ready: ops.ready,
      storageError: ops.error != null,
      active: ops.trip.active,
      connected: online,
      busy: ops.busy,
      selectedContacts: ops.trip.members.length,
      availableContacts: ops.members.length,
      l10n: l10n,
    );
    void open(Widget screen) =>
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
    final volts = c.batteryMillivolts == null || !online
        ? '—'
        : (c.batteryMillivolts! / 1000).toStringAsFixed(2);
    final snr = stats == null || !online
        ? null
        : (stats.lastSnrDb as num).toDouble();
    final checkInHint =
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
                        )));

    return Scaffold(
      backgroundColor: MeshPalette.bg,
      bottomNavigationBar: const QuickSwitchBar(current: MainTab.home),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: MeshSpace.xxl),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MeshSpace.lg,
                MeshSpace.md,
                MeshSpace.xs,
                MeshSpace.md,
              ),
              child: Row(
                children: [
                  const NotoryxLogo(size: 26),
                  const SizedBox(width: MeshSpace.sm),
                  Expanded(
                    child: Text(
                      online ? c.deviceDisplayName : l10n.scanner_notConnected,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: MeshPalette.ink,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    online ? '● ${_transport(c.activeTransport)}' : '○ offline',
                    style: MeshTheme.mono(
                      fontSize: 12.5,
                      color: online ? MeshPalette.signal : MeshPalette.ink4,
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.bastionHome_aboutTooltip,
                    onPressed: () => open(const BastionAboutScreen()),
                    icon: Icon(
                      Icons.info_outline_rounded,
                      size: 20,
                      color: MeshPalette.ink4,
                    ),
                  ),
                ],
              ),
            ),
            const RegionalPresetBanner(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MeshSpace.lg),
              child: TacticalGlassPanel(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: ReadoutStrip([
                  Readout(volts, l10n.radioOverview_battery),
                  Readout(
                    snr == null ? '—' : snr.toStringAsFixed(1),
                    'SNR',
                    color: snr == null
                        ? null
                        : MeshTheme.snrColor(snr, blocked: false),
                  ),
                  Readout(
                    stats == null || !online ? '—' : '${stats.lastRssiDbm}',
                    'RSSI',
                  ),
                  Readout('${c.contacts.length}', l10n.bastion_nodes),
                ]),
              ),
            ),
            if (!online)
              InstrumentRow(
                icon: Icons.bluetooth_searching_rounded,
                title: l10n.bastionHome_connectRadio,
                subtitle: l10n.bastionHome_connectRadioHint,
                titleColor: MeshPalette.accent,
                onTap: () => openConnectionSetup(context),
              ),
            InstrumentLabel(l10n.routes_nearbyTitle),
            if (heard.isEmpty)
              InstrumentRow(
                title: l10n.routes_nearbyEmptyTitle,
                titleColor: MeshPalette.ink3,
              )
            else
              for (final h in heard.take(3))
                InstrumentRow(
                  title:
                      heardNameWithOnline(
                        c,
                        context.watch<AnalyzerService?>(),
                        h.id,
                      ) ??
                      l10n.routes_repeaterWithId(directHeardShortId(h.id)),
                  trailing: SignalReadout(h.snrAverage),
                  onTap: () => open(const BastionPathHubScreen()),
                ),
            InstrumentLabel(l10n.fieldOps_tabTrip),
            InstrumentRow(
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
              onTap: () => open(const BastionFieldOpsScreen()),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MeshSpace.lg,
                MeshSpace.md,
                MeshSpace.lg,
                0,
              ),
              child: ops.sos.active
                  ? const SosPanel()
                  : Row(
                      children: [
                        Expanded(
                          child: InstrumentButton(
                            key: const ValueKey('home-check-in'),
                            label: l10n.shortcuts_checkIn,
                            icon: Icons.check_circle_outline,
                            // Only a missing radio or loading blocks this;
                            // missing contacts or a stopped trip are sorted
                            // out on tap.
                            onPressed: hardBlockReason(ops) == null
                                ? () {
                                    HapticFeedback.selectionClick();
                                    unawaited(_checkIn(context, ops));
                                  }
                                : null,
                          ),
                        ),
                        const SizedBox(width: MeshSpace.sm),
                        const Expanded(child: SosPanel(compact: true)),
                      ],
                    ),
            ),
            if (!ops.sos.active)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  MeshSpace.lg,
                  MeshSpace.sm,
                  MeshSpace.lg,
                  0,
                ),
                child: Text(
                  '$checkInHint ${sosHint(context, ops)}',
                  style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
                ),
              ),
            InstrumentLabel(l10n.bastionHome_fieldTools),
            if (online)
              InstrumentRow(
                icon: Icons.monitor_heart_outlined,
                title: l10n.bastionHome_liveDiagnostics,
                onTap: () => open(const BastionDiagnosticsScreen()),
              ),
            InstrumentRow(
              icon: Icons.radar_rounded,
              title: l10n.bastionHome_meshDiscovery,
              onTap: () => open(const DiscoveryScreen()),
            ),
            InstrumentRow(
              icon: Icons.map_outlined,
              title: l10n.bastion_mapCoverage,
              onTap: () => open(const BastionMapHubScreen()),
            ),
            InstrumentRow(
              icon: Icons.route_rounded,
              title: l10n.bastion_routeIntelligence,
              onTap: () => open(const BastionPathHubScreen()),
            ),
            InstrumentRow(
              icon: Icons.cell_tower_rounded,
              title: l10n.bastion_repeaterTools,
              onTap: () => open(const BastionRepeaterToolsScreen()),
            ),
            InstrumentRow(
              icon: Icons.analytics_outlined,
              title: l10n.bastion_fieldStats,
              onTap: () => open(const BastionFieldStatsScreen()),
            ),
            InstrumentRow(
              icon: Icons.explore_outlined,
              title: l10n.bastionHome_getStarted,
              onTap: () => open(const BastionSetupScreen()),
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
