import '../theme/mesh_theme.dart';

import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../widgets/ember_backdrop.dart';
import '../widgets/instrument.dart';
import '../widgets/glass_action_row.dart';

import 'antenna_coverage_screen.dart';
import 'antenna_hunt_screen.dart';
import 'network_changes_screen.dart';
import 'troubleshooting_screen.dart';
import 'bastion_about_screen.dart';
import 'bot_settings_screen.dart';
import 'connection_dashboard_screen.dart';
import 'licensed_operator_screen.dart';
import 'networks_screen.dart';
import 'rx_log_screen.dart';
import 'path_graph_screen.dart';
import 'encrypted_backup_screen.dart';
import 'security_screen.dart';
import 'team_config_screen.dart';
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
import 'wardrive_screen.dart';
import '../utils/platform_info.dart';

/// Searchable, grouped entry points for app settings and field tools.
class BastionToolsScreen extends StatefulWidget {
  const BastionToolsScreen({super.key});

  @override
  State<BastionToolsScreen> createState() => _BastionToolsScreenState();
}

class _BastionToolsScreenState extends State<BastionToolsScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final groups = [
      (
        // Ham first: who is operating, and how the radio is connected.
        title: l10n.ham_yourStation,
        actions: <_ToolAction>[
          _ToolAction(
            icon: Icons.badge_outlined,
            title: l10n.ham_licensedOperator,
            subtitle: l10n.ham_operatorCardIncomplete,
            builder: (_) => const LicensedOperatorScreen(),
          ),
          _ToolAction(
            icon: Icons.settings_input_antenna,
            title: l10n.connections_title,
            subtitle: l10n.ham_connectedRadio,
            builder: (_) => const ConnectionDashboardScreen(),
          ),
        ],
      ),
      (
        title: l10n.tools_groupApp,
        actions: <_ToolAction>[
          _ToolAction(
            icon: Icons.tune_rounded,
            title: l10n.settings_title,
            builder: (_) => const SettingsScreen(),
          ),
          _ToolAction(
            icon: Icons.smart_toy_outlined,
            title: l10n.tools_bot,
            subtitle: l10n.tools_botHint,
            builder: (_) => const BotSettingsScreen(),
          ),
          _ToolAction(
            icon: Icons.lock_outline,
            title: l10n.bastionTools_backup,
            subtitle: l10n.bastionTools_backupHint,
            builder: (_) => const EncryptedBackupScreen(),
          ),
          _ToolAction(
            icon: Icons.lock_outline,
            title: l10n.security_title,
            subtitle: l10n.security_toolSubtitle,
            builder: (_) => const SecurityScreen(),
          ),
          _ToolAction(
            icon: Icons.qr_code_2,
            title: l10n.team_title,
            subtitle: l10n.team_toolSubtitle,
            builder: (_) => const TeamConfigScreen(),
          ),
          _ToolAction(
            icon: Icons.menu_book_outlined,
            title: l10n.guide_title,
            subtitle: l10n.guide_subtitle,
            builder: (_) => const FieldGuideScreen(),
          ),
        ],
      ),
      (
        title: l10n.tools_groupField,
        actions: <_ToolAction>[
          _ToolAction(
            icon: Icons.route_outlined,
            title: l10n.wardrive_title,
            subtitle: l10n.wardrive_hint,
            builder: (_) => const WardriveScreen(),
          ),
          _ToolAction(
            icon: Icons.radar,
            title: l10n.networks_title,
            subtitle: l10n.networks_hint,
            builder: (_) => const NetworksScreen(),
          ),
          _ToolAction(
            icon: Icons.backpack_outlined,
            title: l10n.bastion_fieldOps,
            subtitle: l10n.bastionTools_fieldOpsHint,
            builder: (_) => const BastionFieldOpsScreen(),
          ),
          _ToolAction(
            icon: Icons.analytics_outlined,
            title: l10n.bastion_fieldStats,
            subtitle: l10n.bastionTools_statsHint,
            builder: (_) => const BastionFieldStatsScreen(),
          ),
          _ToolAction(
            icon: Icons.timeline,
            title: l10n.trackLog_title,
            subtitle: l10n.trackLog_subtitle,
            builder: (_) => const TrackLogScreen(),
          ),
          _ToolAction(
            icon: Icons.monitor_heart_outlined,
            title: l10n.bastionTools_diagnostics,
            subtitle: l10n.bastionTools_diagnosticsHint,
            builder: (_) => const BastionDiagnosticsScreen(),
          ),
          _ToolAction(
            icon: Icons.receipt_long_outlined,
            title: l10n.rxLog_title,
            subtitle: l10n.rxLog_hint,
            builder: (_) => const RxLogScreen(),
          ),
        ],
      ),
      (
        title: l10n.tools_groupMaps,
        actions: <_ToolAction>[
          _ToolAction(
            icon: Icons.map_outlined,
            title: l10n.bastion_mapCoverage,
            subtitle: l10n.bastionTools_mapHint,
            builder: (_) => const BastionMapHubScreen(),
          ),
          _ToolAction(
            icon: Icons.cell_tower,
            title: l10n.tools_antenna,
            subtitle: l10n.tools_antennaHint,
            builder: (_) => const AntennaCoverageScreen(),
          ),
          if (!PlatformInfo.isWeb)
            _ToolAction(
              icon: Icons.hexagon_outlined,
              title: l10n.coverageHex_title,
              subtitle: l10n.coverageHex_toolSubtitle,
              builder: (_) => const CoverageHexScreen(),
            ),
        ],
      ),
      (
        title: l10n.tools_groupRouting,
        actions: <_ToolAction>[
          _ToolAction(
            icon: Icons.route_rounded,
            title: l10n.bastionTools_pathAnalysis,
            subtitle: l10n.bastionTools_pathHint,
            builder: (_) => const BastionPathHubScreen(),
          ),
          _ToolAction(
            icon: Icons.account_tree_outlined,
            title: l10n.tools_pathGraph,
            subtitle: l10n.tools_pathGraphHint,
            builder: (_) => const PathGraphScreen(),
          ),
          _ToolAction(
            icon: Icons.cell_tower_rounded,
            title: l10n.bastion_repeaterTools,
            subtitle: l10n.bastionTools_repeaterHint,
            builder: (_) => const BastionRepeaterToolsScreen(),
          ),
          _ToolAction(
            icon: Icons.notifications_active_outlined,
            title: l10n.netChange_title,
            subtitle: l10n.netChange_toolSubtitle,
            builder: (_) => const NetworkChangesScreen(),
          ),
          _ToolAction(
            icon: Icons.healing_outlined,
            title: l10n.trouble_title,
            subtitle: l10n.trouble_toolSubtitle,
            builder: (_) => const TroubleshootingScreen(),
          ),
          _ToolAction(
            icon: Icons.network_ping,
            title: l10n.ping_title,
            subtitle: l10n.ping_toolSubtitle,
            builder: (_) => const RepeaterPingScreen(),
          ),
          _ToolAction(
            icon: Icons.track_changes,
            title: l10n.hunt_title,
            subtitle: l10n.hunt_toolSubtitle,
            builder: (_) => const AntennaHuntScreen(),
          ),
          _ToolAction(
            icon: Icons.fingerprint,
            title: l10n.prefixTool_title,
            subtitle: l10n.prefixTool_subtitle,
            builder: (_) => const PrefixToolScreen(),
          ),
        ],
      ),
      // About sits on its own at the very end, under no heading.
      (
        title: null as String?,
        actions: <_ToolAction>[
          _ToolAction(
            icon: Icons.info_outline_rounded,
            title: l10n.bastionTools_about,
            subtitle: l10n.bastionTools_aboutHint,
            builder: (_) => const BastionAboutScreen(),
          ),
        ],
      ),
    ];
    final visibleGroups = [
      for (final (index, group) in groups.indexed)
        (
          title: group.title,
          hue: index,
          actions: group.actions
              .where((action) => action.matches(_query))
              .toList(),
        ),
    ].where((group) => group.actions.isNotEmpty).toList();
    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          foregroundColor: MeshPalette.ink,
          titleSpacing: MeshSpace.lg,
          title: Text(l10n.nav_more),
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(MeshSpace.lg),
                child: TextField(
                  key: const ValueKey('tools-search'),
                  controller: _searchController,
                  onChanged: (value) =>
                      setState(() => _query = value.trim().toLowerCase()),
                  decoration: InputDecoration(
                    labelText: l10n.tools_search,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isEmpty
                        ? null
                        : IconButton(
                            tooltip: l10n.common_clear,
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _query = '');
                            },
                          ),
                  ),
                ),
              ),
              Expanded(
                child: visibleGroups.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(MeshSpace.lg),
                          child: Text(
                            l10n.tools_noMatches,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : ListView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: const EdgeInsets.only(bottom: MeshSpace.xxl),
                        children: [
                          for (final group in visibleGroups) ...[
                            if (group.title case final title?)
                              InstrumentLabel(title)
                            else
                              const SizedBox(height: MeshSpace.lg),
                            for (final action in group.actions)
                              GlassActionRow(
                                icon: action.icon,
                                // Each group keeps its own color, also
                                // while searching.
                                iconColor: MeshPalette.hue(group.hue),
                                title: action.title,
                                subtitle: action.subtitle,
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(builder: action.builder),
                                ),
                              ),
                          ],
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToolAction {
  const _ToolAction({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.builder,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final WidgetBuilder builder;

  bool matches(String query) =>
      '$title ${subtitle ?? ''}'.toLowerCase().contains(query);
}
