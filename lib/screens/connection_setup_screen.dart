import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../utils/platform_info.dart';
import 'scanner_screen.dart';
import 'usb_screen.dart';

enum SetupConnection { bluetooth, usb }

/// Opens guidance without scanning, flashing firmware, or changing radio settings.
Future<void> openConnectionSetup(BuildContext context) async {
  final choice = await Navigator.of(context).push<SetupConnection>(
    MaterialPageRoute(
      builder: (_) => ConnectionSetupScreen(
        supportsBluetooth: !PlatformInfo.isWeb,
        supportsUsb: PlatformInfo.supportsUsbSerial,
      ),
    ),
  );
  if (!context.mounted || choice == null) return;
  await Navigator.of(context).push<void>(
    MaterialPageRoute(
      builder: (_) => choice == SetupConnection.usb
          ? const UsbScreen()
          : const ScannerScreen(),
    ),
  );
}

class ConnectionSetupScreen extends StatefulWidget {
  const ConnectionSetupScreen({
    super.key,
    required this.supportsBluetooth,
    required this.supportsUsb,
  });

  final bool supportsBluetooth;
  final bool supportsUsb;

  @override
  State<ConnectionSetupScreen> createState() => _ConnectionSetupScreenState();
}

class _ConnectionSetupScreenState extends State<ConnectionSetupScreen> {
  SetupConnection? _choice;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final choice = _choice;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.setupWizard_title)),
      body: SafeArea(
        child: ListView(
          key: ValueKey(choice),
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              choice == null
                  ? l10n.setupWizard_choose
                  : l10n.setupWizard_prepare,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            if (choice == null) ...[
              Text(l10n.setupWizard_intro),
              const SizedBox(height: 16),
              ListTile(
                enabled: widget.supportsBluetooth,
                leading: const Icon(Icons.bluetooth),
                title: Text(l10n.connectionChoiceBluetoothLabel),
                subtitle: Text(
                  widget.supportsBluetooth
                      ? l10n.setupWizard_bluetooth
                      : l10n.setupWizard_noBluetooth,
                ),
                onTap: widget.supportsBluetooth
                    ? () => setState(() => _choice = SetupConnection.bluetooth)
                    : null,
              ),
              ListTile(
                enabled: widget.supportsUsb,
                leading: const Icon(Icons.usb),
                title: Text(l10n.connectionChoiceUsbLabel),
                subtitle: Text(
                  widget.supportsUsb
                      ? l10n.setupWizard_usb
                      : l10n.setupWizard_noUsb,
                ),
                onTap: widget.supportsUsb
                    ? () => setState(() => _choice = SetupConnection.usb)
                    : null,
              ),
            ] else ...[
              Text(
                choice == SetupConnection.bluetooth
                    ? l10n.setupWizard_bluetoothSteps
                    : l10n.setupWizard_usbSteps,
              ),
              const SizedBox(height: 20),
              Text(
                l10n.setupWizard_firmwareTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(l10n.setupWizard_firmware),
              const SizedBox(height: 16),
              Text(l10n.setupWizard_settings),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: () => Navigator.of(context).pop(choice),
                icon: Icon(
                  choice == SetupConnection.bluetooth
                      ? Icons.bluetooth_searching
                      : Icons.usb,
                ),
                label: Text(
                  choice == SetupConnection.bluetooth
                      ? l10n.setupWizard_openBluetooth
                      : l10n.setupWizard_openUsb,
                ),
              ),
              TextButton(
                onPressed: () => setState(() => _choice = null),
                child: Text(l10n.setupWizard_change),
              ),
            ],
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.setupWizard_later),
            ),
          ],
        ),
      ),
    );
  }
}
