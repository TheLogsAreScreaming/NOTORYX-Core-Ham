import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/licensed_operator_screen.dart';
import '../services/operator_profile_service.dart';
import 'mesh_ui.dart';

/// Settings entry for the licensed operator: shows the saved call sign, or
/// that setup is still needed.
class LicensedOperatorCard extends StatelessWidget {
  const LicensedOperatorCard({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<OperatorProfileService>().profile;
    final scheme = Theme.of(context).colorScheme;
    return MeshCard(
      padding: EdgeInsets.zero,
      child: ListTile(
        leading: Icon(
          profile.isComplete
              ? Icons.badge_outlined
              : Icons.warning_amber_rounded,
          color: profile.isComplete ? scheme.onSurfaceVariant : scheme.error,
        ),
        title: const Text('Licensed operator'),
        subtitle: Text(
          profile.isComplete
              ? '${profile.callsign} · ${profile.licenseClass!.label}'
              : 'Set your call sign and read the coordination guide',
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LicensedOperatorScreen()),
        ),
      ),
    );
  }
}
