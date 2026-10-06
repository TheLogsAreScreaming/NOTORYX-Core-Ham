import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class BastionAboutScreen extends StatelessWidget {
  const BastionAboutScreen({super.key});

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
              'About + Credits',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _panel,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: _cyan.withValues(alpha: .45)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.fort_rounded, color: _cyan, size: 38),
                SizedBox(height: 12),
                Text(
                  'BASTION',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 4),
                SizedBox(height: 14),
                Text(
                  'An independent community companion app for MeshCore networks. Bastion is not an official MeshCore app and inclusion of community resources does not imply partnership or endorsement.',
                  style: TextStyle(color: Color(0xFFB8C1C9), height: 1.45),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) => _infoPanel(
              Icons.info_outline_rounded,
              'VERSION',
              snapshot.hasData
                  ? '${snapshot.data!.version} (${snapshot.data!.buildNumber})'
                  : 'Loading…',
            ),
          ),
          const SizedBox(height: 12),
          _infoPanel(
            Icons.code_rounded,
            'OPEN SOURCE FOUNDATION',
            'Bastion is built from and modifies open-source MeshCore Open code under the MIT License. Coverage workflow work also credits the MIT-licensed MeshMapper Flutter App where applicable.',
          ),
          const SizedBox(height: 12),
          _infoPanel(
            Icons.groups_rounded,
            'COMMUNITY FIRST',
            'Third-party creator resources remain the property of their respective creators. No ownership or partnership is implied.',
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: _cyan,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () => showLicensePage(
              context: context,
              applicationName: 'Bastion',
              applicationLegalese: 'Bastion • Independent MeshCore companion',
            ),
            icon: const Icon(Icons.description_outlined),
            label: const Text(
              'OPEN SOURCE LICENSES',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoPanel(IconData icon, String title, String body) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _panel,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF26313A)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _cyan),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                body,
                style: const TextStyle(color: Color(0xFF9AA6AF), height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
