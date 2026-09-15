import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';

class BastionFieldStatsScreen extends StatelessWidget {
  const BastionFieldStatsScreen({super.key});

  static const _cyan = Color(0xFF18D3D3);
  static const _bg = Color(0xFF0B0E11);
  static const _panel = Color(0xFF12171C);

  @override
  Widget build(BuildContext context) {
    final connector = context.watch<MeshCoreConnector>();
    final contacts = connector.contacts;
    final repeaters = contacts.where((c) => c.type == advTypeRepeater).length;
    final rooms = contacts.where((c) => c.type == advTypeRoom).length;
    final others = contacts.length - repeaters - rooms;

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('FIELD STATS', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.3)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: _panel,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: _cyan.withValues(alpha: .45)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('FIELD OVERVIEW', style: TextStyle(color: _cyan, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.4)),
                SizedBox(height: 8),
                Text('A quick read on the mesh around you.', style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800)),
                SizedBox(height: 6),
                Text('Live counts come from the connected MeshCore session so you can immediately see what Bastion currently knows about the local mesh.', style: TextStyle(color: Color(0xFFB8C1C9), height: 1.4)),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(children: [
            Expanded(child: _StatCard(icon: Icons.hub_rounded, label: 'TOTAL NODES', value: '${contacts.length}')),
            const SizedBox(width: 10),
            Expanded(child: _StatCard(icon: Icons.cell_tower_rounded, label: 'REPEATERS', value: '$repeaters')),
          ]),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: _StatCard(icon: Icons.forum_rounded, label: 'ROOMS', value: '$rooms')),
            const SizedBox(width: 10),
            Expanded(child: _StatCard(icon: Icons.sensors_rounded, label: 'OTHER NODES', value: '$others')),
          ]),
          const SizedBox(height: 20),
          const _SectionCard(
            icon: Icons.route_rounded,
            title: 'ROUTE INTELLIGENCE',
            body: 'Path attempts, hop counts, successes, failures, timing and route weights are already tracked by Bastion’s underlying path history system. The next stats pass can turn those records into best-route and reliability summaries.',
          ),
          const SizedBox(height: 10),
          const _SectionCard(
            icon: Icons.signal_cellular_alt_rounded,
            title: 'SIGNAL + COVERAGE',
            body: 'This screen is now the home for future RX/TX coverage totals, signal summaries and field-session statistics as the MeshMapper-style recorder is added.',
          ),
          const SizedBox(height: 10),
          const _SectionCard(
            icon: Icons.history_rounded,
            title: 'SESSION HISTORY',
            body: 'A later pass can add per-session distance, nodes seen, repeaters reached, messages, route quality and exportable field reports without disturbing core messaging.',
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _StatCard({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: const Color(0xFF10151A),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: const Color(0xFF26313A)),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: const Color(0xFF18D3D3), size: 25),
      const SizedBox(height: 14),
      Text(value, style: const TextStyle(color: Colors.white, fontSize: 27, fontWeight: FontWeight.w900)),
      const SizedBox(height: 2),
      Text(label, style: const TextStyle(color: Color(0xFF18D3D3), fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1)),
    ]),
  );
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  const _SectionCard({required this.icon, required this.title, required this.body});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF10151A),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: const Color(0xFF26313A)),
    ),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: const Color(0xFF18D3D3)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
        const SizedBox(height: 5),
        Text(body, style: const TextStyle(color: Color(0xFF9AA6AF), height: 1.4)),
      ])),
    ]),
  );
}
