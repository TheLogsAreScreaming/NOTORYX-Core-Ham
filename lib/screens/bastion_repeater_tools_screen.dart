import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../models/contact.dart';
import '../widgets/repeater_login_dialog.dart';
import 'repeater_hub_screen.dart';

class BastionRepeaterToolsScreen extends StatelessWidget {
  const BastionRepeaterToolsScreen({super.key});
  static const _cyan = Color(0xFF18D3D3);
  static const _bg = Color(0xFF0B0E11);

  void _login(BuildContext context, Contact repeater) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => RepeaterLoginDialog(
        repeater: repeater,
        onLogin: (password, isAdmin) {
          Navigator.of(dialogContext).pop();
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => RepeaterHubScreen(repeater: repeater, password: password, isAdmin: isAdmin)));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final connector = context.watch<MeshCoreConnector>();
    final repeaters = connector.contacts.where((c) => c.type == advTypeRepeater).toList();
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(backgroundColor: _bg, foregroundColor: Colors.white, title: const Text('REPEATER TOOLS', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.3))),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: const Color(0xFF12171C), borderRadius: BorderRadius.circular(18), border: Border.all(color: _cyan.withValues(alpha: .45))),
            child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('REPEATER COMMAND', style: TextStyle(color: _cyan, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.4)),
              SizedBox(height: 8),
              Text('Manage the infrastructure behind your mesh.', style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800)),
              SizedBox(height: 6),
              Text('Select a discovered repeater to authenticate and open its existing MeshCore status, telemetry, neighbors, settings and CLI tools.', style: TextStyle(color: Color(0xFFB8C1C9), height: 1.4)),
            ]),
          ),
          const SizedBox(height: 18),
          Row(children: [
            _Stat(label: 'DISCOVERED', value: '${repeaters.length}'),
            const SizedBox(width: 10),
            const _Stat(label: 'TOOLS', value: '5+'),
          ]),
          const SizedBox(height: 20),
          const Text('AVAILABLE REPEATERS', style: TextStyle(color: _cyan, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.3)),
          const SizedBox(height: 10),
          if (repeaters.isEmpty)
            const _EmptyRepeaters()
          else
            ...repeaters.map((r) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Material(
                color: const Color(0xFF12171C),
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () => _login(context, r),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFF26313A))),
                    child: Row(children: [
                      const Icon(Icons.cell_tower_rounded, color: _cyan, size: 28),
                      const SizedBox(width: 13),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(r.name.isEmpty ? 'Unnamed repeater' : r.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 3),
                        Text(r.shortPubKeyHex, style: const TextStyle(color: Color(0xFF9AA6AF), fontSize: 11)),
                      ])),
                      const Icon(Icons.login_rounded, color: _cyan),
                    ]),
                  ),
                ),
              ),
            )),
          const SizedBox(height: 12),
          const _Capability(icon: Icons.monitor_heart_rounded, title: 'STATUS + TELEMETRY', body: 'Inspect repeater health and telemetry using the existing management stack.'),
          const SizedBox(height: 10),
          const _Capability(icon: Icons.hub_rounded, title: 'NEIGHBORS', body: 'Inspect neighboring infrastructure and mesh relationships.'),
          const SizedBox(height: 10),
          const _Capability(icon: Icons.terminal_rounded, title: 'CLI + SETTINGS', body: 'Authenticated administrators can reach the existing repeater CLI and configuration tools.'),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label; final String value;
  const _Stat({required this.label, required this.value});
  @override Widget build(BuildContext context) => Expanded(child: Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFF10151A), borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFF26313A))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(value, style: const TextStyle(color: Color(0xFF18D3D3), fontSize: 24, fontWeight: FontWeight.w900)), Text(label, style: const TextStyle(color: Color(0xFF9AA6AF), fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 1))])));
}
class _EmptyRepeaters extends StatelessWidget {
  const _EmptyRepeaters();
  @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: const Color(0xFF10151A), borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFF26313A))), child: const Row(children: [Icon(Icons.portable_wifi_off_rounded, color: Color(0xFF18D3D3)), SizedBox(width: 12), Expanded(child: Text('No repeaters discovered yet. Connect a radio and discover the mesh first.', style: TextStyle(color: Color(0xFFB8C1C9), height: 1.35)))]));
}
class _Capability extends StatelessWidget {
  final IconData icon; final String title; final String body;
  const _Capability({required this.icon, required this.title, required this.body});
  @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: const Color(0xFF10151A), borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFF26313A))), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, color: const Color(0xFF18D3D3)), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)), const SizedBox(height: 4), Text(body, style: const TextStyle(color: Color(0xFF9AA6AF), height: 1.35))]))]));
}
