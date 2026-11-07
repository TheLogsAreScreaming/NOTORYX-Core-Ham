import 'package:flutter/material.dart';
import '../connector/meshcore_connector.dart';
import '../l10n/l10n.dart';
import 'app_logger.dart';
import '../widgets/ui/mesh_states.dart';

/// Shows a confirmation dialog before disconnecting from the device.
/// Returns true if user confirmed and disconnect completed, false otherwise.
Future<bool> showDisconnectDialog(
  BuildContext context,
  MeshCoreConnector connector,
) async {
  final l10n = context.l10n;
  final confirmed = await confirmAction(
    context,
    title: l10n.dialog_disconnect,
    message: l10n.dialog_disconnectConfirm,
    confirmLabel: l10n.common_disconnect,
  );

  if (confirmed == true) {
    appLogger.info('Disconnect confirmed from popup', tag: 'Connection');
    await connector.disconnect();
    return true;
  }
  return false;
}
