import 'dart:async';

import '../theme/mesh_theme.dart';
import '../widgets/my_sensors_panel.dart';
import '../widgets/ember_backdrop.dart';
import '../widgets/notoryx_logo.dart';
import '../widgets/tactical_glass_panel.dart';
import '../widgets/glass_action_row.dart';

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
import 'licensed_operator_screen.dart';
import '../services/operator_profile_service.dart';
import '../utils/station_readiness.dart';
import '../widgets/sos_panel.dart';
import '../widgets/quick_trip_setup.dart';
import '../widgets/quick_switch_bar.dart';
import '../utils/main_tab_navigation.dart';
import '../helpers/snack_bar_builder.dart';

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
    final profile = context.watch<OperatorProfileService>().profile;
    // Nothing set up yet: lead with the guided setup instead of burying it.
    final firstRun = !online && c.contacts.isEmpty && !profile.isComplete;
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

    return EmberBackdrop(
      scene: EmberScene.home,
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                        online
                            ? c.deviceDisplayName
                            : l10n.scanner_notConnected,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: MeshPalette.ink,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      online
                          ? '● ${_transport(c.activeTransport)}'
                          : '○ offline',
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
              // 1. An active SOS outranks everything else on the screen.
              if (ops.sos.active)
                const Padding(
                  padding: EdgeInsets.fromLTRB(
                    MeshSpace.lg,
                    0,
                    MeshSpace.lg,
                    MeshSpace.md,
                  ),
                  child: SosPanel(),
                ),
              // 2. The station: radio link, signal and whether it may transmit.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MeshSpace.lg),
                child: TacticalGlassPanel(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
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
              const SizedBox(height: MeshSpace.sm),
              if (!online)
                GlassActionRow(
                  icon: Icons.bluetooth_searching_rounded,
                  title: l10n.bastionHome_connectRadio,
                  subtitle: l10n.bastionHome_connectRadioHint,
                  titleColor: MeshPalette.accent,
                  onTap: () => openConnectionSetup(context),
                ),
              const _StationRow(),
              if (firstRun)
                GlassActionRow(
                  icon: Icons.explore_outlined,
                  title: l10n.bastionHome_getStarted,
                  onTap: () => open(const BastionSetupScreen()),
                ),
              // 3. The two things people open Home to do.
              if (!ops.sos.active) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    MeshSpace.lg,
                    MeshSpace.sm,
                    MeshSpace.lg,
                    0,
                  ),
                  child: Row(
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    MeshSpace.lg,
                    MeshSpace.sm,
                    MeshSpace.lg,
                    0,
                  ),
                  child: Text(
                    '$checkInHint ${sosHint(context, ops)}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: MeshPalette.ink3),
                  ),
                ),
              ],
              // 4. The trip those check-ins belong to.
              InstrumentLabel(l10n.fieldOps_tabTrip),
              GlassActionRow(
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
              // 5. What the radio hears and senses.
              InstrumentLabel(l10n.routes_nearbyTitle),
              if (heard.isEmpty)
                GlassActionRow(
                  title: l10n.routes_nearbyEmptyTitle,
                  titleColor: MeshPalette.ink3,
                )
              else
                for (final h in heard.take(3))
                  GlassActionRow(
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
              if (online) const MySensorsPanel(),
              // 6. Everything else.
              InstrumentLabel(l10n.bastionHome_fieldTools),
              if (online)
                GlassActionRow(
                  icon: Icons.monitor_heart_outlined,
                  title: l10n.bastionHome_liveDiagnostics,
                  onTap: () => open(const BastionDiagnosticsScreen()),
                ),
              GlassActionRow(
                icon: Icons.radar_rounded,
                title: l10n.bastionHome_meshDiscovery,
                onTap: () => open(const DiscoveryScreen()),
              ),
              GlassActionRow(
                icon: Icons.map_outlined,
                title: l10n.bastion_mapCoverage,
                onTap: () => open(const BastionMapHubScreen()),
              ),
              GlassActionRow(
                icon: Icons.route_rounded,
                title: l10n.bastion_routeIntelligence,
                onTap: () => open(const BastionPathHubScreen()),
              ),
              GlassActionRow(
                icon: Icons.cell_tower_rounded,
                title: l10n.bastion_repeaterTools,
                onTap: () => open(const BastionRepeaterToolsScreen()),
              ),
              GlassActionRow(
                icon: Icons.analytics_outlined,
                title: l10n.bastion_fieldStats,
                onTap: () => open(const BastionFieldStatsScreen()),
              ),
              if (!firstRun)
                GlassActionRow(
                  icon: Icons.explore_outlined,
                  title: l10n.bastionHome_getStarted,
                  onTap: () => open(const BastionSetupScreen()),
                ),
            ],
          ),
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
        messenger.showSnackBar(meshSnackBar(content: Text(friendlyError(e))));
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

/// The licensed operator's station at a glance: the call sign and the first
/// thing (if any) stopping the radio from transmitting. Opens the Licensed
/// operator page, where each item can be fixed.
class _StationRow extends StatelessWidget {
  const _StationRow();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final status = MeshStatusColors.of(context);
    final c = context.watch<MeshCoreConnector>();
    final profile = context.watch<OperatorProfileService>().profile;
    final readiness = stationReadiness(
      profile,
      nodeName: c.selfName,
      freqKhz: c.currentFreqHz,
    );
    final online = c.isConnected;
    final title = profile.hasValidCallsign
        ? profile.callsign
        : l10n.ham_licensedOperator;
    final String subtitle;
    final bool ok;
    if (readiness == StationReadiness.setupIncomplete) {
      subtitle = l10n.ham_operatorCardIncomplete;
      ok = false;
    } else if (!online) {
      subtitle = l10n.bastionHome_stationConnectToCheck;
      ok = true;
    } else {
      subtitle = switch (readiness) {
        StationReadiness.nameMismatch => l10n.ham_bannerNameMismatch,
        StationReadiness.outOfBand => l10n.ham_bannerOutOfBand,
        _ => l10n.bastionHome_stationOk,
      };
      ok = readiness == StationReadiness.ready;
    }
    return GlassActionRow(
      key: const ValueKey('home-station'),
      icon: Icons.badge_outlined,
      title: title,
      subtitle: subtitle,
      // Shape and words carry the state too, not colour alone.
      trailing: Icon(
        ok ? Icons.check_circle_rounded : Icons.warning_amber_rounded,
        size: 20,
        color: ok ? status.success : status.warning,
        semanticLabel: ok ? l10n.ham_statusOk : l10n.ham_needsAttention,
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => const LicensedOperatorScreen()),
      ),
    );
  }
}
