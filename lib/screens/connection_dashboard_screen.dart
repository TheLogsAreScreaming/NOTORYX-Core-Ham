import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/saved_radio.dart';
import '../utils/platform_info.dart';
import '../widgets/mqtt_connection_card.dart';
import 'scanner_screen.dart';
import 'tcp_screen.dart';
import 'usb_screen.dart';

/// Radio and MQTT broker connections are shown and controlled separately.
class ConnectionDashboardScreen extends StatelessWidget {
  const ConnectionDashboardScreen({super.key});

  /// Widest the cards grow on tablets and desktop, so lines stay readable.
  static const double maxContentWidth = 720;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.connections_title)),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxContentWidth),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              RadioConnectionCard(),
              SizedBox(height: 12),
              MqttConnectionCard(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Status, identity and controls for the companion radio link.
class RadioConnectionCard extends StatelessWidget {
  const RadioConnectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final connector = context.watch<MeshCoreConnector>();
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final state = connector.state;
    final connected = connector.isConnected;
    final busy =
        state == MeshCoreConnectionState.connecting ||
        state == MeshCoreConnectionState.disconnecting;
    final bluetoothOff =
        connector.isBluetoothOff &&
        connector.activeTransport == MeshCoreTransportType.bluetooth;
    final saved = connector.savedRadio;
    final error = connector.lastConnectionError;
    final canReconnect =
        saved != null &&
        !connected &&
        !busy &&
        !(saved.transport == SavedRadioTransport.bluetooth &&
            connector.isBluetoothOff);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.connections_radioTitle,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              radioStatusLabel(l10n, connector),
              key: const ValueKey('radio-status'),
              style: theme.textTheme.titleMedium,
            ),
            if (bluetoothOff) ...[
              const SizedBox(height: 8),
              _Notice(
                icon: Icons.bluetooth_disabled,
                text: l10n.connections_bluetoothOffNotice,
              ),
            ],
            const SizedBox(height: 8),
            _InfoRow(
              label: l10n.connections_transport,
              value: transportLabel(l10n, connector.activeTransport),
            ),
            if (connected) ..._identityRows(l10n, connector),
            if (!connected && !busy && error != null && !bluetoothOff) ...[
              const SizedBox(height: 8),
              _Notice(
                key: const ValueKey('radio-error'),
                icon: Icons.error_outline,
                text: l10n.connections_lastError(error),
                isError: true,
              ),
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (connected || state == MeshCoreConnectionState.connecting)
                  OutlinedButton.icon(
                    onPressed: () => unawaited(connector.disconnect()),
                    icon: const Icon(Icons.link_off),
                    label: Text(
                      connected
                          ? l10n.connections_disconnectRadio
                          : l10n.common_cancel,
                    ),
                  ),
                if (canReconnect)
                  FilledButton.icon(
                    onPressed: () => _reconnect(context, connector),
                    icon: const Icon(Icons.refresh),
                    label: Text(l10n.connections_reconnectTo(saved.name)),
                  ),
                if (saved != null && !connected && !busy)
                  TextButton(
                    onPressed: () => unawaited(connector.forgetSavedRadio()),
                    child: Text(l10n.connections_forgetRadio),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              l10n.connections_connectAnother,
              style: theme.textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (!PlatformInfo.isWeb)
                  OutlinedButton.icon(
                    onPressed: () => _open(context, const ScannerScreen()),
                    icon: const Icon(Icons.bluetooth),
                    label: Text(l10n.radioStatus_bluetooth),
                  ),
                if (PlatformInfo.supportsUsbSerial)
                  OutlinedButton.icon(
                    onPressed: () => _open(context, const UsbScreen()),
                    icon: const Icon(Icons.usb),
                    label: Text(l10n.connections_usbSerial),
                  ),
                OutlinedButton.icon(
                  onPressed: () => _open(context, const TcpScreen()),
                  icon: const Icon(Icons.lan),
                  label: Text(l10n.connections_tcpIp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _identityRows(
    AppLocalizations l10n,
    MeshCoreConnector connector,
  ) {
    final keyPrefix = connector.selfPublicKeyPrefixHex;
    final firmware = connector.firmwareVersionString?.trim();
    final firmwareCode = connector.firmwareVerCode;
    final battery = batteryLabel(
      connector.batteryPercent,
      connector.batteryMillivolts,
    );
    final signal = signalLabel(connector.lastRxSnr, connector.lastRxRssi);
    return [
      _InfoRow(
        label: l10n.connections_device,
        value: connector.deviceDisplayName,
      ),
      if (keyPrefix != null)
        _InfoRow(label: l10n.connections_publicKey, value: keyPrefix),
      if (firmware != null && firmware.isNotEmpty)
        _InfoRow(label: l10n.connections_firmware, value: firmware)
      else if (firmwareCode != null)
        _InfoRow(
          label: l10n.connections_firmware,
          value: l10n.connections_firmwareProtocol('$firmwareCode'),
        ),
      if (battery != null)
        _InfoRow(label: l10n.connections_battery, value: battery),
      if (signal != null)
        _InfoRow(label: l10n.connections_lastRx, value: signal),
    ];
  }

  Future<void> _reconnect(
    BuildContext context,
    MeshCoreConnector connector,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final failed = context.l10n.connections_reconnectFailed;
    try {
      await connector.reconnectSavedRadio();
    } catch (_) {
      // The card already shows connector.lastConnectionError.
      messenger.showSnackBar(SnackBar(content: Text(failed)));
    }
  }

  void _open(BuildContext context, Widget screen) {
    unawaited(
      Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (_) => screen)),
    );
  }
}

/// One-line status for the radio card, e.g. "Connected" or
/// "Bluetooth is off".
String radioStatusLabel(AppLocalizations l10n, MeshCoreConnector connector) {
  if (connector.isBluetoothOff &&
      connector.activeTransport == MeshCoreTransportType.bluetooth &&
      !connector.isConnected) {
    return l10n.connections_statusBluetoothOff;
  }
  return switch (connector.state) {
    MeshCoreConnectionState.connected => l10n.connections_statusConnected,
    MeshCoreConnectionState.connecting => l10n.connections_statusConnecting,
    MeshCoreConnectionState.disconnecting =>
      l10n.connections_statusDisconnecting,
    MeshCoreConnectionState.scanning => l10n.connections_statusScanning,
    MeshCoreConnectionState.disconnected =>
      connector.isAutoReconnectScheduled
          ? l10n.connections_statusReconnectingSoon
          : l10n.connections_statusNotConnected,
  };
}

String transportLabel(AppLocalizations l10n, MeshCoreTransportType transport) =>
    switch (transport) {
      MeshCoreTransportType.bluetooth => l10n.radioStatus_bluetooth,
      MeshCoreTransportType.usb => l10n.connections_usbSerial,
      MeshCoreTransportType.tcp => l10n.connections_tcpIp,
    };

/// "87% (4.05 V)", "4.05 V" or null when the radio has not reported.
String? batteryLabel(int? percent, int? millivolts) {
  if (millivolts == null) return null;
  final volts = '${(millivolts / 1000).toStringAsFixed(2)} V';
  return percent == null ? volts : '$percent% ($volts)';
}

/// "SNR 7.0 dB · RSSI -92 dBm" for the last heard packet, or null.
String? signalLabel(double? snr, int? rssi) {
  if (snr == null && rssi == null) return null;
  return [
    if (snr != null) 'SNR ${snr.toStringAsFixed(1)} dB',
    if (rssi != null) 'RSSI $rssi dBm',
  ].join(' · ');
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}

class _Notice extends StatelessWidget {
  const _Notice({
    super.key,
    required this.icon,
    required this.text,
    this.isError = false,
  });

  final IconData icon;
  final String text;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = isError ? scheme.error : scheme.onSurfaceVariant;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: TextStyle(color: color)),
        ),
      ],
    );
  }
}
