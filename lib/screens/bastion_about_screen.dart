import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../l10n/l10n.dart';

class BastionAboutScreen extends StatelessWidget {
  const BastionAboutScreen({super.key});

  static const _cyan = Color(0xFF8AB6AA);
  static const _bg = Color(0xFF182126);
  static const _panel = Color(0xFF202D33);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Color(0xFFE4E6DF),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BASTION',
              style: TextStyle(
                color: _cyan,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.7,
              ),
            ),
            Text(
              l10n.bastionAbout_title,
              style: const TextStyle(fontWeight: FontWeight.w900),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.fort_rounded, color: _cyan, size: 38),
                const SizedBox(height: 12),
                const Text(
                  'BASTION',
                  style: TextStyle(
                    color: Color(0xFFE4E6DF),
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 4),
                const SizedBox(height: 14),
                Text(
                  l10n.bastionAbout_intro,
                  style: const TextStyle(
                    color: Color(0xFFCED8D2),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) => _infoPanel(
              Icons.info_outline_rounded,
              l10n.bastionAbout_version,
              snapshot.hasData
                  ? '${snapshot.data!.version} (${snapshot.data!.buildNumber})'
                  : l10n.common_loading,
            ),
          ),
          const SizedBox(height: 12),
          _infoPanel(
            Icons.code_rounded,
            l10n.bastionAbout_openSource,
            l10n.bastionAbout_openSourceBody,
          ),
          const SizedBox(height: 12),
          _infoPanel(
            Icons.groups_rounded,
            l10n.bastionAbout_community,
            l10n.bastionAbout_communityBody,
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
              applicationLegalese: l10n.bastionAbout_legalese,
            ),
            icon: const Icon(Icons.description_outlined),
            label: Text(
              l10n.bastionAbout_licenses,
              style: const TextStyle(fontWeight: FontWeight.w900),
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
      border: Border.all(color: const Color(0xFF36474E)),
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
                  color: Color(0xFFE4E6DF),
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                body,
                style: const TextStyle(color: Color(0xFFADBEB7), height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
