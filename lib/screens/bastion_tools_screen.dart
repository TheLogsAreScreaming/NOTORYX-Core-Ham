import '../theme/mesh_theme.dart';
import 'package:flutter/material.dart';
import '../l10n/l10n.dart';
import '../widgets/mesh_ui.dart';

import 'antenna_coverage_screen.dart';
import 'bastion_about_screen.dart';
import 'path_graph_screen.dart';
import 'encrypted_backup_screen.dart';
import 'bastion_field_ops_screen.dart';
import 'bastion_diagnostics_screen.dart';
import 'bastion_field_stats_screen.dart';
import 'bastion_map_hub_screen.dart';
import 'bastion_path_hub_screen.dart';
import 'bastion_repeater_tools_screen.dart';
import 'prefix_tool_screen.dart';
import 'settings_screen.dart';
import 'track_log_screen.dart';

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
          padding: const EdgeInsets.fromLTRB(
            MeshSpace.lg,
            MeshSpace.sm,
            MeshSpace.lg,
            MeshSpace.xxl,
          ),
          children: [
            _GroupTitle(l10n.tools_groupApp),
            MeshGroup(
              children: [
                MeshNavRow(
                  icon: Icons.tune_rounded,
                  title: l10n.settings_title,
                  onTap: () => open(const SettingsScreen()),
                ),
                MeshNavRow(
                  icon: Icons.lock_outline,
                  title: l10n.bastionTools_backup,
                  subtitle: l10n.bastionTools_backupHint,
                  onTap: () => open(const EncryptedBackupScreen()),
                ),
                MeshNavRow(
                  icon: Icons.info_outline_rounded,
                  title: l10n.bastionTools_about,
                  subtitle: l10n.bastionTools_aboutHint,
                  onTap: () => open(const BastionAboutScreen()),
                ),
              ],
            ),
            _GroupTitle(l10n.tools_groupField),
            _ToolGrid(
              children: [
                _ToolTile(
                  icon: Icons.backpack_outlined,
                  title: l10n.bastion_fieldOps,
                  subtitle: l10n.bastionTools_fieldOpsHint,
                  onTap: () => open(const BastionFieldOpsScreen()),
                ),
                _ToolTile(
                  icon: Icons.analytics_outlined,
                  title: l10n.bastion_fieldStats,
                  subtitle: l10n.bastionTools_statsHint,
                  onTap: () => open(const BastionFieldStatsScreen()),
                ),
                _ToolTile(
                  icon: Icons.timeline,
                  title: l10n.trackLog_title,
                  subtitle: l10n.trackLog_subtitle,
                  onTap: () => open(const TrackLogScreen()),
                ),
                _ToolTile(
                  icon: Icons.monitor_heart_outlined,
                  title: l10n.bastionTools_diagnostics,
                  subtitle: l10n.bastionTools_diagnosticsHint,
                  onTap: () => open(const BastionDiagnosticsScreen()),
                ),
              ],
            ),
            _GroupTitle(l10n.tools_groupMaps),
            _ToolGrid(
              children: [
                _ToolTile(
                  icon: Icons.map_outlined,
                  title: l10n.bastion_mapCoverage,
                  subtitle: l10n.bastionTools_mapHint,
                  onTap: () => open(const BastionMapHubScreen()),
                ),
                _ToolTile(
                  icon: Icons.cell_tower,
                  title: l10n.tools_antenna,
                  subtitle: l10n.tools_antennaHint,
                  onTap: () => open(const AntennaCoverageScreen()),
                ),
              ],
            ),
            _GroupTitle(l10n.tools_groupRouting),
            _ToolGrid(
              children: [
                _ToolTile(
                  icon: Icons.route_rounded,
                  title: l10n.bastionTools_pathAnalysis,
                  subtitle: l10n.bastionTools_pathHint,
                  onTap: () => open(const BastionPathHubScreen()),
                ),
                _ToolTile(
                  icon: Icons.account_tree_outlined,
                  title: l10n.tools_pathGraph,
                  subtitle: l10n.tools_pathGraphHint,
                  onTap: () => open(const PathGraphScreen()),
                ),
                _ToolTile(
                  icon: Icons.cell_tower_rounded,
                  title: l10n.bastion_repeaterTools,
                  subtitle: l10n.bastionTools_repeaterHint,
                  onTap: () => open(const BastionRepeaterToolsScreen()),
                ),
                _ToolTile(
                  icon: Icons.fingerprint,
                  title: l10n.prefixTool_title,
                  subtitle: l10n.prefixTool_subtitle,
                  onTap: () => open(const PrefixToolScreen()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupTitle extends StatelessWidget {
  const _GroupTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => SectionHeader(
    text,
    padding: const EdgeInsets.fromLTRB(
      MeshSpace.xs,
      MeshSpace.xl,
      MeshSpace.xs,
      MeshSpace.sm,
    ),
  );
}

/// Lays tiles out two per row; each row is as tall as its taller tile so
/// the grid stays even however long a translation runs.
class _ToolGrid extends StatelessWidget {
  const _ToolGrid({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i += 2) {
      if (i > 0) rows.add(const SizedBox(height: MeshSpace.sm));
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: children[i]),
              const SizedBox(width: MeshSpace.sm),
              Expanded(
                child: i + 1 < children.length
                    ? children[i + 1]
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      );
    }
    return Column(children: rows);
  }
}

class _ToolTile extends StatelessWidget {
  const _ToolTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MeshPalette.bg2,
      borderRadius: BorderRadius.circular(MeshRadii.lg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: MeshPalette.bg3,
                  borderRadius: BorderRadius.circular(MeshRadii.sm),
                ),
                child: Icon(icon, size: 20, color: MeshPalette.ink2),
              ),
              const SizedBox(height: MeshSpace.md),
              Text(
                title,
                style: TextStyle(
                  color: MeshPalette.ink,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: TextStyle(
                  color: MeshPalette.ink3,
                  fontSize: 12.5,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
