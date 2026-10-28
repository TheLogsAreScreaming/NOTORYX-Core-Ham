import '../theme/mesh_theme.dart';
import 'package:flutter/material.dart';
import '../l10n/l10n.dart';

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
import 'track_log_screen.dart';

class BastionToolsScreen extends StatelessWidget {
  const BastionToolsScreen({super.key});

  static Color get _cyan => MeshPalette.accent;
  static Color get _bg => MeshPalette.bg;
  static Color get _panel => MeshPalette.bg2;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: MeshPalette.ink,
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NOTORYX',
              style: TextStyle(
                color: _cyan,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.7,
              ),
            ),
            Text(
              l10n.bastionTools_title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          children: [
            _tool(
              context,
              Icons.lock_outline,
              l10n.bastionTools_backup,
              l10n.bastionTools_backupHint,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EncryptedBackupScreen(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _tool(
              context,
              Icons.backpack_outlined,
              l10n.bastion_fieldOps,
              l10n.bastionTools_fieldOpsHint,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BastionFieldOpsScreen(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _tool(
              context,
              Icons.map_rounded,
              l10n.bastion_mapCoverage,
              l10n.bastionTools_mapHint,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BastionMapHubScreen()),
              ),
            ),
            const SizedBox(height: 12),
            _tool(
              context,
              Icons.route_rounded,
              l10n.bastionTools_pathAnalysis,
              l10n.bastionTools_pathHint,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BastionPathHubScreen()),
              ),
            ),
            const SizedBox(height: 12),
            _tool(
              context,
              Icons.cell_tower_rounded,
              l10n.bastion_repeaterTools,
              l10n.bastionTools_repeaterHint,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BastionRepeaterToolsScreen(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _tool(
              context,
              Icons.analytics_rounded,
              l10n.bastion_fieldStats,
              l10n.bastionTools_statsHint,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BastionFieldStatsScreen(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _tool(
              context,
              Icons.account_tree_outlined,
              'PATH GRAPH',
              'How messages reach you: every path heard, with busiest repeaters',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PathGraphScreen()),
              ),
            ),
            const SizedBox(height: 12),
            _tool(
              context,
              Icons.timeline,
              l10n.trackLog_title.toUpperCase(),
              l10n.trackLog_subtitle,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TrackLogScreen()),
              ),
            ),
            const SizedBox(height: 12),
            _tool(
              context,
              Icons.cell_tower,
              'ANTENNA COVERAGE',
              'Estimate where an antenna can reach over the terrain',
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AntennaCoverageScreen(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _tool(
              context,
              Icons.monitor_heart_rounded,
              l10n.bastionTools_diagnostics,
              l10n.bastionTools_diagnosticsHint,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BastionDiagnosticsScreen(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _tool(
              context,
              Icons.info_outline_rounded,
              l10n.bastionTools_about,
              l10n.bastionTools_aboutHint,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BastionAboutScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tool(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Material(
      color: _panel,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _cyan.withValues(alpha: .38)),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _cyan.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: _cyan),
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
                        fontWeight: FontWeight.w900,
                        letterSpacing: .4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: MeshPalette.ink3,
                        fontSize: 12.5,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: _cyan),
            ],
          ),
        ),
      ),
    );
  }
}
