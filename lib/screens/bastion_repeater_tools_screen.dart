import '../theme/mesh_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../l10n/l10n.dart';
import '../models/contact.dart';
import '../widgets/repeater_login_dialog.dart';
import 'repeater_hub_screen.dart';

class BastionRepeaterToolsScreen extends StatelessWidget {
  const BastionRepeaterToolsScreen({super.key});
  static Color get _cyan => MeshPalette.accent;
  static Color get _bg => MeshPalette.bg;

  void _login(BuildContext context, Contact repeater) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => RepeaterLoginDialog(
        repeater: repeater,
        onLogin: (password, isAdmin) {
          Navigator.of(dialogContext).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => RepeaterHubScreen(
                repeater: repeater,
                password: password,
                isAdmin: isAdmin,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final connector = context.watch<MeshCoreConnector>();
    final repeaters = connector.contacts
        .where((c) => c.type == advTypeRepeater)
        .toList();
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: MeshPalette.ink,
        title: Text(l10n.bastion_repeaterTools),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: MeshPalette.bg2,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: _cyan.withValues(alpha: .45)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.repeaterTools_heroLabel,
                  style: MeshTheme.sectionTitle(),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.repeaterTools_headline,
                  style: TextStyle(
                    color: MeshPalette.ink,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.repeaterTools_body,
                  style: TextStyle(color: MeshPalette.ink2, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _Stat(
                label: l10n.repeaterTools_discovered,
                value: '${repeaters.length}',
              ),
              const SizedBox(width: 10),
              _Stat(label: l10n.repeaterTools_tools, value: '5+'),
            ],
          ),
          const SizedBox(height: 20),
          Text(l10n.repeaterTools_available, style: MeshTheme.sectionTitle()),
          const SizedBox(height: 10),
          if (repeaters.isEmpty)
            const _EmptyRepeaters()
          else
            ...repeaters.map(
              (r) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Material(
                  color: MeshPalette.bg2,
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () => _login(context, r),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: MeshPalette.line),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.cell_tower_rounded,
                            color: _cyan,
                            size: 28,
                          ),
                          const SizedBox(width: 13),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  r.name.isEmpty
                                      ? l10n.repeaterTools_unnamed
                                      : r.name,
                                  style: TextStyle(
                                    color: MeshPalette.ink,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  r.shortPubKeyHex,
                                  style: TextStyle(
                                    color: MeshPalette.ink3,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.login_rounded, color: _cyan),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 12),
          _Capability(
            icon: Icons.monitor_heart_rounded,
            title: l10n.repeaterTools_statusTelemetry,
            body: l10n.repeaterTools_statusTelemetryBody,
          ),
          const SizedBox(height: 10),
          _Capability(
            icon: Icons.hub_rounded,
            title: l10n.repeaterTools_neighbors,
            body: l10n.repeaterTools_neighborsBody,
          ),
          const SizedBox(height: 10),
          _Capability(
            icon: Icons.terminal_rounded,
            title: l10n.repeaterTools_cli,
            body: l10n.repeaterTools_cliBody,
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  const _Stat({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: MeshPalette.bg1,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: MeshPalette.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              color: MeshPalette.accent,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: MeshPalette.ink3,
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    ),
  );
}

class _EmptyRepeaters extends StatelessWidget {
  const _EmptyRepeaters();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: MeshPalette.bg1,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: MeshPalette.line),
    ),
    child: Row(
      children: [
        Icon(Icons.portable_wifi_off_rounded, color: MeshPalette.accent),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            context.l10n.repeaterTools_empty,
            style: TextStyle(color: MeshPalette.ink2, height: 1.35),
          ),
        ),
      ],
    ),
  );
}

class _Capability extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  const _Capability({
    required this.icon,
    required this.title,
    required this.body,
  });
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: MeshPalette.bg1,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: MeshPalette.line),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: MeshPalette.accent),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: MeshPalette.ink,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: TextStyle(color: MeshPalette.ink3, height: 1.35),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
