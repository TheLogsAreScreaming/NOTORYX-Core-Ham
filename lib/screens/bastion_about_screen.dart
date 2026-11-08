import '../theme/mesh_theme.dart';
import '../widgets/notoryx_logo.dart';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../l10n/l10n.dart';
import '../widgets/ember_backdrop.dart';

class BastionAboutScreen extends StatelessWidget {
  const BastionAboutScreen({super.key});

  static Color get _cyan => MeshPalette.accent;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          foregroundColor: MeshPalette.ink,
          title: Text(l10n.bastionAbout_title),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: MeshPalette.line),
                borderRadius: BorderRadius.circular(MeshRadii.xs),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const NotoryxLogo(size: 48),
                  const SizedBox(height: 12),
                  Text(
                    'NOTORYX',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: MeshPalette.ink,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const SizedBox(height: 14),
                  Text(
                    l10n.bastionAbout_intro,
                    style: TextStyle(color: MeshPalette.ink2, height: 1.45),
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
                applicationName: 'NOTORYX Core Ham',
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
      ),
    );
  }

  Widget _infoPanel(IconData icon, String title, String body) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: MeshPalette.line),
      borderRadius: BorderRadius.circular(MeshRadii.xs),
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
                style: TextStyle(
                  color: MeshPalette.ink,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                body,
                style: TextStyle(color: MeshPalette.ink3, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
