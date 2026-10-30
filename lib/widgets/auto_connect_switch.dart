import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';
import '../services/app_settings_service.dart';

/// The "Connect to my radio automatically" switch, shared by Settings and
/// the Last radio card.
class AutoConnectSwitch extends StatelessWidget {
  const AutoConnectSwitch({super.key, this.dense = false});

  final bool dense;

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettingsService>();
    final l10n = context.l10n;
    return SwitchListTile(
      key: const ValueKey('auto-connect-radio'),
      dense: dense,
      contentPadding: dense ? EdgeInsets.zero : null,
      secondary: dense ? null : const Icon(Icons.bluetooth_connected),
      title: Text(l10n.autoConnect_title),
      subtitle: Text(l10n.autoConnect_hint),
      value: settings.settings.autoConnectRadio,
      onChanged: settings.setAutoConnectRadio,
    );
  }
}
