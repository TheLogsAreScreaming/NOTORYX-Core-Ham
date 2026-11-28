import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../services/network_change_service.dart';
import '../theme/mesh_theme.dart';
import '../widgets/contact_table_banner.dart' show lastHeardText;
import '../widgets/ember_backdrop.dart';

/// One network change in words.
String networkChangeText(AppLocalizations l10n, NetworkChange change) =>
    switch (change.kind) {
      NetworkChangeKind.newRepeater =>
        change.hops == 0
            ? l10n.netChange_newDirect(change.name)
            : l10n.netChange_newHops(change.name, change.hops),
      NetworkChangeKind.wentQuiet => l10n.netChange_wentQuiet(
        change.name,
        change.quietHours,
      ),
    };

/// Repeaters that appeared nearby or went quiet, newest first.
class NetworkChangesScreen extends StatelessWidget {
  const NetworkChangesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final service = context.watch<NetworkChangeService?>();
    final log = service?.log ?? const [];
    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          foregroundColor: MeshPalette.ink,
          title: Text(l10n.netChange_title),
          actions: [
            if (log.isNotEmpty)
              TextButton(
                onPressed: service!.clearLog,
                child: Text(l10n.netChange_clear),
              ),
          ],
        ),
        body: SafeArea(
          top: false,
          child: log.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(MeshSpace.xl),
                    child: Text(
                      l10n.netChange_empty,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: MeshPalette.ink2),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: log.length,
                  itemBuilder: (context, i) {
                    final c = log[i];
                    final quiet = c.kind == NetworkChangeKind.wentQuiet;
                    return ListTile(
                      leading: Icon(
                        quiet ? Icons.portable_wifi_off : Icons.cell_tower,
                        color: quiet ? MeshPalette.warn : MeshPalette.signal,
                      ),
                      title: Text(networkChangeText(l10n, c)),
                      subtitle: Text(lastHeardText(context, c.at)),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
