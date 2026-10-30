import '../theme/mesh_theme.dart';
import 'package:flutter/material.dart';
import '../l10n/l10n.dart';
import '../widgets/instrument.dart';
import '../widgets/tactical_glass_panel.dart';

import 'antenna_coverage_screen.dart';
import 'antenna_hunt_screen.dart';
import 'bastion_about_screen.dart';
import 'path_graph_screen.dart';
import 'encrypted_backup_screen.dart';
import 'field_guide_screen.dart';
import 'bastion_field_ops_screen.dart';
import 'bastion_diagnostics_screen.dart';
import 'bastion_field_stats_screen.dart';
import 'bastion_map_hub_screen.dart';
import 'bastion_path_hub_screen.dart';
import 'bastion_repeater_tools_screen.dart';
import 'coverage_hex_screen.dart';
import 'prefix_tool_screen.dart';
import 'repeater_ping_screen.dart';
import 'settings_screen.dart';
import 'track_log_screen.dart';
import '../utils/platform_info.dart';

/// The More tab: settings and app items as a list, then the field tools as
/// grouped two-column grids.
class BastionToolsScreen extends StatelessWidget {
  const BastionToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    void open(Widget screen) =>
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));

    return Scaffold(
      backgroundColor: MeshPalette.bg,
      appBar: AppBar(
        backgroundColor: MeshPalette.bg,
        foregroundColor: MeshPalette.ink,
        titleSpacing: MeshSpace.lg,
        title: Text(l10n.nav_more),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.only(bottom: MeshSpace.xxl),
          children: [
            InstrumentLabel(l10n.tools_groupApp),
            InstrumentRow(
              icon: Icons.tune_rounded,
              title: l10n.settings_title,
              onTap: () => open(const SettingsScreen()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MeshSpace.lg),
              child: TacticalGlassPanel(
                blur: false,
                child: InstrumentRow(
                  icon: Icons.lock_outline,
                  title: l10n.bastionTools_backup,
                  subtitle: l10n.bastionTools_backupHint,
                  onTap: () => open(const EncryptedBackupScreen()),
                ),
              ),
            ),
            InstrumentRow(
              icon: Icons.menu_book_outlined,
              title: l10n.guide_title,
              subtitle: l10n.guide_subtitle,
              onTap: () => open(const FieldGuideScreen()),
            ),
            InstrumentRow(
              icon: Icons.info_outline_rounded,
              title: l10n.bastionTools_about,
              subtitle: l10n.bastionTools_aboutHint,
              onTap: () => open(const BastionAboutScreen()),
            ),
            InstrumentLabel(l10n.tools_groupField),
            InstrumentRow(
              icon: Icons.backpack_outlined,
              title: l10n.bastion_fieldOps,
              subtitle: l10n.bastionTools_fieldOpsHint,
              onTap: () => open(const BastionFieldOpsScreen()),
            ),
            InstrumentRow(
              icon: Icons.analytics_outlined,
              title: l10n.bastion_fieldStats,
              subtitle: l10n.bastionTools_statsHint,
              onTap: () => open(const BastionFieldStatsScreen()),
            ),
            InstrumentRow(
              icon: Icons.timeline,
              title: l10n.trackLog_title,
              subtitle: l10n.trackLog_subtitle,
              onTap: () => open(const TrackLogScreen()),
            ),
            InstrumentRow(
              icon: Icons.monitor_heart_outlined,
              title: l10n.bastionTools_diagnostics,
              subtitle: l10n.bastionTools_diagnosticsHint,
              onTap: () => open(const BastionDiagnosticsScreen()),
            ),
            InstrumentLabel(l10n.tools_groupMaps),
            InstrumentRow(
              icon: Icons.map_outlined,
              title: l10n.bastion_mapCoverage,
              subtitle: l10n.bastionTools_mapHint,
              onTap: () => open(const BastionMapHubScreen()),
            ),
            InstrumentRow(
              icon: Icons.cell_tower,
              title: l10n.tools_antenna,
              subtitle: l10n.tools_antennaHint,
              onTap: () => open(const AntennaCoverageScreen()),
            ),
            if (!PlatformInfo.isWeb)
              InstrumentRow(
                icon: Icons.hexagon_outlined,
                title: l10n.coverageHex_title,
                subtitle: l10n.coverageHex_toolSubtitle,
                onTap: () => open(const CoverageHexScreen()),
              ),
            InstrumentLabel(l10n.tools_groupRouting),
            InstrumentRow(
              icon: Icons.route_rounded,
              title: l10n.bastionTools_pathAnalysis,
              subtitle: l10n.bastionTools_pathHint,
              onTap: () => open(const BastionPathHubScreen()),
            ),
            InstrumentRow(
              icon: Icons.account_tree_outlined,
              title: l10n.tools_pathGraph,
              subtitle: l10n.tools_pathGraphHint,
              onTap: () => open(const PathGraphScreen()),
            ),
            InstrumentRow(
              icon: Icons.cell_tower_rounded,
              title: l10n.bastion_repeaterTools,
              subtitle: l10n.bastionTools_repeaterHint,
              onTap: () => open(const BastionRepeaterToolsScreen()),
            ),
            InstrumentRow(
              icon: Icons.network_ping,
              title: l10n.ping_title,
              subtitle: l10n.ping_toolSubtitle,
              onTap: () => open(const RepeaterPingScreen()),
            ),
            InstrumentRow(
              icon: Icons.track_changes,
              title: l10n.hunt_title,
              subtitle: l10n.hunt_toolSubtitle,
              onTap: () => open(const AntennaHuntScreen()),
            ),
            InstrumentRow(
              icon: Icons.fingerprint,
              title: l10n.prefixTool_title,
              subtitle: l10n.prefixTool_subtitle,
              onTap: () => open(const PrefixToolScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
