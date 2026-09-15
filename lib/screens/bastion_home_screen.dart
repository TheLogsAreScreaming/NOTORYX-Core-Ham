import 'package:flutter/material.dart';
import 'scanner_screen.dart';
import 'discovery_screen.dart';
import 'bastion_map_hub_screen.dart';

class BastionHomeScreen extends StatelessWidget {
  const BastionHomeScreen({super.key});

  static const _cyan = Color(0xFF18D3D3);
  static const _bg = Color(0xFF0B0E11);
  static const _panel = Color(0xFF12171C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
          children: [
            Row(children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  border: Border.all(color: _cyan, width: 2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.fort_rounded, color: Colors.white, size: 31),
              ),
              const SizedBox(width: 14),
              const Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('BASTION', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 2.4)),
                  Text('BASTION  •  MESHCORE', style: TextStyle(color: _cyan, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.1)),
                ],
              )),
            ]),
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: _panel,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: _cyan.withValues(alpha: .45)),
              ),
              child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('FIELD CONSOLE', style: TextStyle(color: _cyan, fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1.5)),
                SizedBox(height: 8),
                Text('Your MeshCore command center.', style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800)),
                SizedBox(height: 6),
                Text('Connect a radio, discover the mesh, message nodes and move into Bastion field tools from one place.', style: TextStyle(color: Color(0xFFB8C1C9), height: 1.4)),
              ]),
            ),
            const SizedBox(height: 18),
            _ActionCard(
              icon: Icons.bluetooth_searching_rounded,
              title: 'CONNECT RADIO',
              subtitle: 'Bluetooth, USB and TCP MeshCore connections',
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ScannerScreen())),
            ),
            const SizedBox(height: 12),
            _ActionCard(
              icon: Icons.radar_rounded,
              title: 'MESH DISCOVERY',
              subtitle: 'Find nodes and inspect the mesh around you',
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DiscoveryScreen())),
            ),
            const SizedBox(height: 22),
            const Text('BASTION FIELD TOOLS', style: TextStyle(color: _cyan, fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1.4)),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(child: _ToolTile(
                icon: Icons.map_rounded,
                label: 'MAP + COVERAGE',
                status: 'ACTIVE',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BastionMapHubScreen())),
              )),
              const SizedBox(width: 10),
              const Expanded(child: _ToolTile(icon: Icons.route_rounded, label: 'PATH ANALYSIS', status: 'NEXT')),
            ]),
            const SizedBox(height: 10),
            const Row(children: [
              Expanded(child: _ToolTile(icon: Icons.cell_tower_rounded, label: 'REPEATER TOOLS', status: 'NEXT')),
              SizedBox(width: 10),
              Expanded(child: _ToolTile(icon: Icons.analytics_rounded, label: 'FIELD STATS', status: 'NEXT')),
            ]),
            const SizedBox(height: 24),
            const Center(child: Text('BASTION  •  BASTION', style: TextStyle(color: Color(0xFF66727D), fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.3))),
          ],
        ),
      ),
    );
  }
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
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: .5)), const SizedBox(height: 3), Text(subtitle, style: const TextStyle(color: Color(0xFF9AA6AF), fontSize: 12.5))])),
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
    color: const Color(0xFF10151A),
    borderRadius: BorderRadius.circular(15),
    child: InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Container(
        height: 112,
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: onTap == null ? const Color(0xFF26313A) : const Color(0xFF18D3D3).withValues(alpha: .45)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: const Color(0xFF18D3D3), size: 25),
          const Spacer(),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)),
          const SizedBox(height: 3),
          Row(children: [
            Text(status, style: const TextStyle(color: Color(0xFF18D3D3), fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1)),
            if (onTap != null) ...[
              const Spacer(),
              const Icon(Icons.chevron_right_rounded, color: Color(0xFF18D3D3), size: 17),
            ],
          ]),
        ]),
      ),
    ),
  );
}
