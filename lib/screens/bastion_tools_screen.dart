import 'package:flutter/material.dart';

import 'bastion_about_screen.dart';
import 'bastion_field_ops_screen.dart';
import 'bastion_diagnostics_screen.dart';
import 'bastion_field_stats_screen.dart';
import 'bastion_map_hub_screen.dart';
import 'bastion_path_hub_screen.dart';
import 'bastion_repeater_tools_screen.dart';

class BastionToolsScreen extends StatelessWidget {
  const BastionToolsScreen({super.key});

  static const _cyan = Color(0xFF8AB6AA);
  static const _bg = Color(0xFF182126);
  static const _panel = Color(0xFF202D33);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: const Color(0xFFE4E6DF),
        titleSpacing: 16,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BASTION',
              style: TextStyle(
                color: _cyan,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.7,
              ),
            ),
            Text(
              'Field Tools',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
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
              Icons.backpack_outlined,
              'TRIP + FIELD OPERATIONS',
              'Check-ins, readiness, Field Log, automations and comparisons',
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
              'MAP + COVERAGE',
              'Live map, capture sessions, offline map tools and regions',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BastionMapHubScreen()),
              ),
            ),
            const SizedBox(height: 12),
            _tool(
              context,
              Icons.route_rounded,
              'PATH ANALYSIS',
              'Routes, discovery and path intelligence',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BastionPathHubScreen()),
              ),
            ),
            const SizedBox(height: 12),
            _tool(
              context,
              Icons.cell_tower_rounded,
              'REPEATER TOOLS',
              'Status, login, telemetry, neighbors and administration',
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
              'FIELD STATS',
              'Live mesh counts and contact activity',
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
              Icons.monitor_heart_rounded,
              'DIAGNOSTICS',
              'Radio health, device information, raw frames and export',
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
              'ABOUT + CREDITS',
              'Bastion version, independence statement and open-source licenses',
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
                      style: const TextStyle(
                        color: Color(0xFFE4E6DF),
                        fontWeight: FontWeight.w900,
                        letterSpacing: .4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFFADBEB7),
                        fontSize: 12.5,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: _cyan),
            ],
          ),
        ),
      ),
    );
  }
}
