import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
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
      appBar: AppBar(title: const Text('Connections')),
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
            Text('Radio connection', style: theme.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              radioStatusLabel(connector),
              key: const ValueKey('radio-status'),
              style: theme.textTheme.titleMedium,
            ),
            if (bluetoothOff) ...[
              const SizedBox(height: 8),
              const _Notice(
                icon: Icons.bluetooth_disabled,
                text:
                    'Bluetooth is off. Turn it on to reconnect; the app will '
                    'retry once it is back.',
              ),
            ],
            const SizedBox(height: 8),
            _InfoRow(
              label: 'Transport',
              value: transportLabel(connector.activeTransport),
            ),
            if (connected) ..._identityRows(connector),
            if (!connected && !busy && error != null && !bluetoothOff) ...[
              const SizedBox(height: 8),
              _Notice(
                key: const ValueKey('radio-error'),
                icon: Icons.error_outline,
                text: 'Last error: $error',
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
                    label: Text(connected ? 'Disconnect radio' : 'Cancel'),
                  ),
                if (canReconnect)
                  FilledButton.icon(
                    onPressed: () => _reconnect(context, connector),
                    icon: const Icon(Icons.refresh),
                    label: Text('Reconnect to ${saved.name}'),
                  ),
                if (saved != null && !connected && !busy)
                  TextButton(
                    onPressed: () => unawaited(connector.forgetSavedRadio()),
                    child: const Text('Forget radio'),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Connect another radio', style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (!PlatformInfo.isWeb)
                  OutlinedButton.icon(
                    onPressed: () => _open(context, const ScannerScreen()),
                    icon: const Icon(Icons.bluetooth),
                    label: const Text('Bluetooth'),
                  ),
                if (PlatformInfo.supportsUsbSerial)
                  OutlinedButton.icon(
                    onPressed: () => _open(context, const UsbScreen()),
                    icon: const Icon(Icons.usb),
                    label: const Text('USB serial'),
                  ),
                OutlinedButton.icon(
                  onPressed: () => _open(context, const TcpScreen()),
                  icon: const Icon(Icons.lan),
                  label: const Text('TCP/IP'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _identityRows(MeshCoreConnector connector) {
    final keyPrefix = connector.selfPublicKeyPrefixHex;
    final firmware = connector.firmwareVersionString?.trim();
    final firmwareCode = connector.firmwareVerCode;
    final battery = batteryLabel(
      connector.batteryPercent,
      connector.batteryMillivolts,
    );
    final signal = signalLabel(connector.lastRxSnr, connector.lastRxRssi);
    return [
      _InfoRow(label: 'Device', value: connector.deviceDisplayName),
      if (keyPrefix != null) _InfoRow(label: 'Public key', value: keyPrefix),
      if (firmware != null && firmware.isNotEmpty)
        _InfoRow(label: 'Firmware', value: firmware)
      else if (firmwareCode != null)
        _InfoRow(label: 'Firmware', value: 'protocol v$firmwareCode'),
      if (battery != null) _InfoRow(label: 'Battery', value: battery),
      if (signal != null) _InfoRow(label: 'Last RX', value: signal),
    ];
  }

  Future<void> _reconnect(
    BuildContext context,
    MeshCoreConnector connector,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await connector.reconnectSavedRadio();
    } catch (_) {
      // The card already shows connector.lastConnectionError.
      messenger.showSnackBar(
        const SnackBar(content: Text('Could not reconnect to the radio')),
      );
    }
  }

  void _open(BuildContext context, Widget screen) {
    unawaited(
      Navigator.of(
        context,
      ).push(MaterialPageRoute<void>(builder: (_) => screen)),
    );
  }
}

/// One-line status for the radio card, e.g. "Connected" or
/// "Bluetooth is off".
String radioStatusLabel(MeshCoreConnector connector) {
  if (connector.isBluetoothOff &&
      connector.activeTransport == MeshCoreTransportType.bluetooth &&
      !connector.isConnected) {
    return 'Bluetooth is off';
  }
  return switch (connector.state) {
    MeshCoreConnectionState.connected => 'Connected',
    MeshCoreConnectionState.connecting => 'Connecting…',
    MeshCoreConnectionState.disconnecting => 'Disconnecting…',
    MeshCoreConnectionState.scanning => 'Scanning for radios…',
    MeshCoreConnectionState.disconnected =>
      connector.isAutoReconnectScheduled
          ? 'Reconnecting soon…'
          : 'Not connected',
  };
}

String transportLabel(MeshCoreTransportType transport) => switch (transport) {
  MeshCoreTransportType.bluetooth => 'Bluetooth',
  MeshCoreTransportType.usb => 'USB serial',
  MeshCoreTransportType.tcp => 'TCP/IP',
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
