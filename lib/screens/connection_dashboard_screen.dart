import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/saved_radio.dart';
import '../utils/platform_info.dart';
import '../theme/mesh_theme.dart';
import '../widgets/connect_ui.dart';
import '../widgets/mesh_ui.dart';
import '../widgets/mqtt_connection_card.dart';
import '../widgets/radio_overview_card.dart';
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
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.connections_title)),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxContentWidth),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            children: [
              ConsoleKicker(l10n.connections_radioTitle),
              const RadioConnectionCard(),
              const SizedBox(height: 22),
              ConsoleKicker(l10n.connections_internetBridge),
              const MqttConnectionCard(),
              const SizedBox(height: 22),
              ConsoleKicker(l10n.connections_connectAnother),
              const _TransportChoices(),
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

    final statusColor = connected
        ? MeshPalette.signal
        : bluetoothOff
        ? MeshPalette.alert
        : busy || connector.isAutoReconnectScheduled
        ? MeshPalette.warn
        : MeshPalette.ink3;
    final title = connected
        ? connector.deviceDisplayName
        : saved?.name ?? l10n.connections_noRadio;

    return ConsolePanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: statusColor.withValues(alpha: 0.5)),
                ),
                child: Icon(
                  connected
                      ? Icons.settings_input_antenna_rounded
                      : Icons.portable_wifi_off_rounded,
                  color: statusColor,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: MeshPalette.ink,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        PulseDot(color: statusColor, size: 8, animate: busy),
                        const SizedBox(width: 7),
                        Flexible(
                          child: Text(
                            radioStatusLabel(l10n, connector),
                            key: const ValueKey('radio-status'),
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '  ·  ${transportLabel(l10n, connector.activeTransport)}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: MeshPalette.ink3,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (bluetoothOff) ...[
            const SizedBox(height: 14),
            _Notice(
              icon: Icons.bluetooth_disabled,
              text: l10n.connections_bluetoothOffNotice,
            ),
          ],
          if (connected) ...[
            const SizedBox(height: 16),
            _StatGrid(stats: _stats(l10n, connector)),
          ],
          if (!connected && !busy && error != null && !bluetoothOff) ...[
            const SizedBox(height: 14),
            _Notice(
              key: const ValueKey('radio-error'),
              icon: Icons.error_outline,
              text: l10n.connections_lastError(error),
              isError: true,
            ),
          ],
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (canReconnect)
                FilledButton.icon(
                  onPressed: () => _reconnect(context, connector),
                  icon: const Icon(Icons.refresh),
                  label: Text(l10n.connections_reconnectTo(saved.name)),
                ),
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
              if (saved != null && !connected && !busy)
                TextButton(
                  onPressed: () => unawaited(connector.forgetSavedRadio()),
                  child: Text(l10n.connections_forgetRadio),
                ),
            ],
          ),
        ],
      ),
    );
  }

  List<_Stat> _stats(AppLocalizations l10n, MeshCoreConnector connector) {
    final keyPrefix = connector.selfPublicKeyPrefixHex;
    final firmware = connector.firmwareVersionString?.trim();
    final firmwareCode = connector.firmwareVerCode;
    final battery = batteryLabel(
      connector.batteryPercent,
      connector.batteryMillivolts,
    );
    final signal = signalLabel(connector.lastRxSnr, connector.lastRxRssi);
    final radio = radioSettingsLine(connector);
    return [
      if (battery != null)
        _Stat(Icons.battery_full_rounded, l10n.connections_battery, battery),
      if (signal != null)
        _Stat(Icons.network_check_rounded, l10n.connections_lastRx, signal),
      if (firmware != null && firmware.isNotEmpty)
        _Stat(Icons.memory_rounded, l10n.connections_firmware, firmware)
      else if (firmwareCode != null)
        _Stat(
          Icons.memory_rounded,
          l10n.connections_firmware,
          l10n.connections_firmwareProtocol('$firmwareCode'),
        ),
      if (keyPrefix != null)
        _Stat(
          Icons.key_rounded,
          l10n.connections_publicKey,
          keyPrefix,
          mono: true,
        ),
      if (radio != null)
        _Stat(
          Icons.graphic_eq_rounded,
          l10n.connections_radioSettings,
          radio,
          mono: true,
          wide: true,
        ),
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
}

/// Bluetooth, USB and Wi-Fi as large tiles; side by side when there's room.
class _TransportChoices extends StatelessWidget {
  const _TransportChoices();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    void open(Widget screen) => unawaited(
      Navigator.of(
        context,
      ).push(MaterialPageRoute<void>(builder: (_) => screen)),
    );
    return ResponsiveTilePair(
      children: [
        if (!PlatformInfo.isWeb)
          TransportTile(
            icon: Icons.bluetooth_rounded,
            title: l10n.radioStatus_bluetooth,
            subtitle: l10n.setupWizard_bluetooth,
            onTap: () => open(const ScannerScreen()),
          ),
        if (PlatformInfo.supportsUsbSerial)
          TransportTile(
            icon: Icons.usb_rounded,
            title: l10n.connections_usbSerial,
            subtitle: l10n.setupWizard_usb,
            onTap: () => open(const UsbScreen()),
          ),
        TransportTile(
          icon: Icons.wifi_rounded,
          title: l10n.radioStatus_tcp,
          subtitle: l10n.scanner_tcpHint,
          onTap: () => open(const TcpScreen()),
        ),
      ],
    );
  }
}

class _Stat {
  const _Stat(
    this.icon,
    this.label,
    this.value, {
    this.mono = false,
    this.wide = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool mono;

  /// Takes a full row, for long values like the radio settings.
  final bool wide;
}

/// Readings as small labeled tiles: two per row on phones, three on wider
/// screens.
class _StatGrid extends StatelessWidget {
  const _StatGrid({required this.stats});

  final List<_Stat> stats;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 8.0;
        final columns = constraints.maxWidth >= 520 ? 3 : 2;
        final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final stat in stats)
              SizedBox(
                width: stat.wide ? constraints.maxWidth : width,
                child: _StatTile(stat: stat),
              ),
          ],
        );
      },
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.stat});

  final _Stat stat;

  @override
  Widget build(BuildContext context) {
    final valueStyle = TextStyle(
      color: MeshPalette.ink,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      height: 1.3,
    );
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      decoration: BoxDecoration(
        color: MeshPalette.bg3,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(stat.icon, size: 14, color: MeshPalette.ink3),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  stat.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MeshPalette.ink3,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            stat.value,
            style: stat.mono
                ? MeshTheme.mono(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: MeshPalette.ink,
                  )
                : valueStyle,
          ),
        ],
      ),
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
