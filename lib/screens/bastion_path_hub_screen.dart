import 'package:flutter/material.dart';
import 'map_screen.dart';
import 'discovery_screen.dart';

class BastionPathHubScreen extends StatelessWidget {
  const BastionPathHubScreen({super.key});

  static const _cyan = Color(0xFF18D3D3);
  static const _bg = Color(0xFF0B0E11);
  static const _panel = Color(0xFF12171C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('PATH ANALYSIS', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.4)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: _panel, borderRadius: BorderRadius.circular(18), border: Border.all(color: _cyan.withValues(alpha: .45))),
            child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('ROUTE INTELLIGENCE', style: TextStyle(color: _cyan, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.4)),
              SizedBox(height: 8),
              Text('See how traffic moves through the mesh.', style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800)),
              SizedBox(height: 6),
              Text('Use Bastion’s existing MeshCore path history, hop data and map tools to inspect routes and find better ways through the network.', style: TextStyle(color: Color(0xFFB8C1C9), height: 1.4)),
            ]),
          ),
          const SizedBox(height: 16),
          _PathAction(
            icon: Icons.route_rounded,
            title: 'ROUTE MAP',
            subtitle: 'Open the live mesh map and inspect node paths',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MapScreen())),
          ),
          const SizedBox(height: 12),
          _PathAction(
            icon: Icons.radar_rounded,
            title: 'DISCOVER ROUTES',
            subtitle: 'Discover nodes before analyzing available paths',
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DiscoveryScreen())),
          ),
          const SizedBox(height: 18),
          const _InfoPanel(
            icon: Icons.alt_route_rounded,
            title: 'PATH HISTORY',
            body: 'Bastion already records route attempts, hop counts, successful and failed paths, trip time and route weighting. Build 11 exposes the field entry point while preserving the proven routing engine underneath.',
          ),
          const SizedBox(height: 12),
          const _InfoPanel(
            icon: Icons.timeline_rounded,
            title: 'NEXT PATH PASS',
            body: 'A dedicated route history browser, best route ranking and per contact diagnostics will build on this foundation without destabilizing messaging.',
          ),
        ],
      ),
    );
  }
}

class _PathAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _PathAction({required this.icon, required this.title, required this.subtitle, required this.onTap});

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
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)), const SizedBox(height: 3), Text(subtitle, style: const TextStyle(color: Color(0xFF9AA6AF), fontSize: 12.5))])),
          const Icon(Icons.chevron_right_rounded, color: Color(0xFF18D3D3)),
        ]),
      ),
    ),
  );
}

class _InfoPanel extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  const _InfoPanel({required this.icon, required this.title, required this.body});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: const Color(0xFF10151A), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF26313A))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: const Color(0xFF18D3D3)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)), const SizedBox(height: 5), Text(body, style: const TextStyle(color: Color(0xFF9AA6AF), height: 1.4))])),
    ]),
  );
}
