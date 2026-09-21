import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import 'bastion_about_screen.dart';
import 'bastion_diagnostics_screen.dart';
import 'bastion_field_stats_screen.dart';
import 'bastion_map_hub_screen.dart';
import 'bastion_path_hub_screen.dart';
import 'bastion_repeater_tools_screen.dart';
import 'discovery_screen.dart';
import 'scanner_screen.dart';

class BastionHomeScreen extends StatelessWidget {
  const BastionHomeScreen({super.key});

  static const _cyan = Color(0xFF18D3D3);
  static const _bg = Color(0xFF0B0E11);
  static const _panel = Color(0xFF12171C);

  @override
  Widget build(BuildContext context) {
    final c = context.watch<MeshCoreConnector>();
    final stats = c.latestRadioStats;
    final repeaters = c.contacts.where((x) => x.type == advTypeRepeater).length;
    final active = c.contacts.where((x) => DateTime.now().difference(x.lastSeen).inMinutes <= 60).length;

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
          children: [
            Row(children: [
              Container(width: 52, height: 52, decoration: BoxDecoration(border: Border.all(color: _cyan, width: 2), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.fort_rounded, color: Colors.white, size: 31)),
              const SizedBox(width: 14),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('BASTION', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 2.4)),
                Text('BASTION  •  MESHCORE', style: TextStyle(color: _cyan, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.1)),
              ])),
              IconButton(
                tooltip: 'About Bastion',
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BastionAboutScreen())),
                icon: const Icon(Icons.info_outline_rounded, color: Color(0xFF9AA6AF)),
              ),
            ]),
            const SizedBox(height: 22),
            _connectionCard(context, c, stats),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: _metric('NODES', '${c.contacts.length}')),
              const SizedBox(width: 8),
              Expanded(child: _metric('ACTIVE 1H', '$active')),
              const SizedBox(width: 8),
              Expanded(child: _metric('REPEATERS', '$repeaters')),
            ]),
            const SizedBox(height: 18),
            if (!c.isConnected)
              _ActionCard(icon: Icons.bluetooth_searching_rounded, title: 'CONNECT RADIO', subtitle: 'Bluetooth, USB and TCP MeshCore connections', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ScannerScreen())))
            else
              _ActionCard(icon: Icons.monitor_heart_rounded, title: 'LIVE DIAGNOSTICS', subtitle: 'Radio health, signal, device and frame tools', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BastionDiagnosticsScreen()))),
            const SizedBox(height: 12),
            _ActionCard(icon: Icons.radar_rounded, title: 'MESH DISCOVERY', subtitle: 'Find nodes and inspect the mesh around you', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DiscoveryScreen()))),
            const SizedBox(height: 22),
            const Text('BASTION FIELD TOOLS', style: TextStyle(color: _cyan, fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1.4)),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(child: _ToolTile(icon: Icons.map_rounded, label: 'MAP + COVERAGE', status: 'ACTIVE', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BastionMapHubScreen())))),
              const SizedBox(width: 10),
              Expanded(child: _ToolTile(icon: Icons.route_rounded, label: 'ROUTE INTELLIGENCE', status: 'ACTIVE', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BastionPathHubScreen())))),
            ]),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(child: _ToolTile(icon: Icons.cell_tower_rounded, label: 'REPEATER TOOLS', status: 'ACTIVE', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BastionRepeaterToolsScreen())))),
              const SizedBox(width: 10),
              Expanded(child: _ToolTile(icon: Icons.analytics_rounded, label: 'FIELD STATS', status: 'ACTIVE', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BastionFieldStatsScreen())))),
            ]),
            const SizedBox(height: 24),
            const Center(child: Text('BASTION  •  BASTION', style: TextStyle(color: Color(0xFF66727D), fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.3))),
          ],
        ),
      ),
    );
  }

  Widget _connectionCard(BuildContext context, MeshCoreConnector c, dynamic stats) {
    final battery = c.batteryMillivolts == null ? '—' : '${(c.batteryMillivolts! / 1000).toStringAsFixed(2)}V';
    final signal = stats == null ? 'RSSI —  •  SNR —' : 'RSSI ${stats.lastRssiDbm}  •  SNR ${stats.lastSnrDb.toStringAsFixed(1)}';
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: _panel, borderRadius: BorderRadius.circular(18), border: Border.all(color: c.isConnected ? _cyan.withValues(alpha: .55) : const Color(0xFF26313A))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(color: _cyan.withValues(alpha: .12), borderRadius: BorderRadius.circular(13)), child: Icon(c.isConnected ? Icons.radio_rounded : Icons.portable_wifi_off_rounded, color: _cyan)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(c.isConnected ? 'FIELD CONSOLE ONLINE' : 'FIELD CONSOLE READY', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
            const SizedBox(height: 3),
            Text(c.isConnected ? '${c.deviceDisplayName} • ${c.activeTransport.name.toUpperCase()}' : 'Connect a radio to light up the live dashboard.', style: const TextStyle(color: Color(0xFF9AA6AF), fontSize: 12)),
          ])),
          Container(width: 9, height: 9, decoration: BoxDecoration(shape: BoxShape.circle, color: c.isConnected ? _cyan : const Color(0xFF56616A))),
        ]),
        if (c.isConnected) ...[
          const SizedBox(height: 14),
          const Divider(color: Color(0xFF26313A), height: 1),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: Text(signal, style: const TextStyle(color: Color(0xFFB8C1C9), fontSize: 11.5, fontWeight: FontWeight.w700))),
            Text('BAT $battery', style: const TextStyle(color: _cyan, fontSize: 11.5, fontWeight: FontWeight.w900)),
          ]),
        ],
      ]),
    );
  }

  Widget _metric(String label, String value) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 11),
    decoration: BoxDecoration(color: _panel, borderRadius: BorderRadius.circular(13), border: Border.all(color: const Color(0xFF26313A))),
    child: Column(children: [
      Text(value, style: const TextStyle(color: _cyan, fontSize: 17, fontWeight: FontWeight.w900)),
      const SizedBox(height: 3),
      Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF8D9AA4), fontSize: 8.5, fontWeight: FontWeight.w800)),
    ]),
  );
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _ActionCard({required this.icon, required this.title, required this.subtitle, required this.onTap});
  @override
  Widget build(BuildContext context) => Material(
    color: const Color(0xFF12171C),
    borderRadius: BorderRadius.circular(16),
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(border: Border.all(color: const Color(0xFF26313A)), borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          Container(width: 46, height: 46, decoration: BoxDecoration(color: const Color(0xFF18D3D3).withValues(alpha: .12), borderRadius: BorderRadius.circular(13)), child: Icon(icon, color: const Color(0xFF18D3D3))),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: .5)),
            const SizedBox(height: 3),
            Text(subtitle, style: const TextStyle(color: Color(0xFF9AA6AF), fontSize: 12.5)),
          ])),
          const Icon(Icons.chevron_right_rounded, color: Color(0xFF18D3D3)),
        ]),
      ),
    ),
  );
}

class _ToolTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String status;
  final VoidCallback? onTap;
  const _ToolTile({required this.icon, required this.label, required this.status, this.onTap});
  @override
  Widget build(BuildContext context) => Material(
    color: const Color(0xFF12171C),
    borderRadius: BorderRadius.circular(16),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF26313A))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(icon, color: const Color(0xFF18D3D3)),
            const Spacer(),
            Text(status, style: const TextStyle(color: Color(0xFF18D3D3), fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 1)),
          ]),
          const SizedBox(height: 18),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800)),
        ]),
      ),
    ),
  );
}
