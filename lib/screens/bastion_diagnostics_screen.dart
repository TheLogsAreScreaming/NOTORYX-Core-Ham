import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../l10n/l10n.dart';
import '../theme/mesh_theme.dart';
import '../widgets/ember_backdrop.dart';
import '../widgets/instrument.dart';
import '../widgets/mesh_ui.dart';
import '../widgets/node_sheet.dart';
import 'app_debug_log_screen.dart';
import 'ble_debug_log_screen.dart';
import 'channel_chat_screen.dart';
import 'companion_radio_stats_screen.dart';
import 'map_screen.dart';
import '../helpers/snack_bar_builder.dart';

class BastionDiagnosticsScreen extends StatelessWidget {
  const BastionDiagnosticsScreen({super.key});

  static Color get _cyan => MeshPalette.accent;

  String _value(Object? value) => value == null ? '—' : '$value';

  String _mhz(int? reported) {
    final mhz = radioFrequencyMHz(reported);
    return mhz == null ? '—' : '${mhz.toStringAsFixed(4)} MHz';
  }

  String _battery(int? mv) =>
      mv == null ? '—' : '${(mv / 1000).toStringAsFixed(2)} V';

  Future<void> _export(BuildContext context, MeshCoreConnector c) async {
    final s = c.latestRadioStats;
    final now = DateTime.now().toIso8601String();
    final lines = <String>[
      'NOTORYX Core Ham Diagnostics',
      'Generated: $now',
      '',
      'Connection',
      'Connected: ${c.isConnected}',
      'Transport: ${c.activeTransport.name}',
      'Device: ${c.deviceDisplayName}',
      'Manufacturer: ${_value(c.manufacturerName)}',
      'Firmware: ${_value(c.firmwareVersionString)}',
      'Battery: ${_battery(c.batteryMillivolts)}',
      '',
      'Mesh',
      'Contacts: ${c.contacts.length}',
      'Channels: ${c.channels.length}',
      'Direct repeaters: ${c.directRepeaters.length}',
      'GPS: ${c.selfLatitude == null || c.selfLongitude == null ? '—' : '${c.selfLatitude}, ${c.selfLongitude}'}',
      '',
      'Radio',
      'Frequency: ${_mhz(c.currentFreqHz)}',
      'Bandwidth: ${c.currentBwHz == null ? '—' : '${c.currentBwHz} Hz'}',
      'Spreading factor: ${_value(c.currentSf)}',
      'Coding rate: ${_value(c.currentCr)}',
      'TX power: ${c.currentTxPower == null ? '—' : '${c.currentTxPower} dBm'}',
      'RSSI: ${s == null ? '—' : '${s.lastRssiDbm} dBm'}',
      'SNR: ${s == null ? '—' : '${s.lastSnrDb.toStringAsFixed(1)} dB'}',
      'Noise floor: ${s == null ? '—' : '${s.noiseFloorDbm} dBm'}',
      'TX airtime: ${s == null ? '—' : '${s.txAirSecs} s'}',
      'RX airtime: ${s == null ? '—' : '${s.rxAirSecs} s'}',
      '',
      'Storage',
      'Used: ${c.storageUsedKb == null ? '—' : '${c.storageUsedKb} KB'}',
      'Total: ${c.storageTotalKb == null ? '—' : '${c.storageTotalKb} KB'}',
    ];

    final dir = await getTemporaryDirectory();
    final file = File(
      '${dir.path}/bastion-diagnostics-${DateTime.now().millisecondsSinceEpoch}.txt',
    );
    await file.writeAsString(lines.join('\n'));
    if (!context.mounted) return;
    await SharePlus.instance.share(
      ShareParams(
        subject: 'NOTORYX Core Ham Diagnostics',
        text: 'NOTORYX Core Ham diagnostics export',
        files: [XFile(file.path)],
      ),
    );
  }

  Future<void> _refresh(MeshCoreConnector c) async {
    if (!c.isConnected) return;
    try {
      await c.refreshDeviceInfo();
      await c.requestRadioStats();
    } catch (_) {
      // Values stay as they were.
    }
  }

  void _copy(BuildContext context, String label, String value) {
    if (value == '—') return;
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      meshSnackBar(content: Text(context.l10n.diag_copied(label))),
    );
  }

  void _showChannels(BuildContext context, MeshCoreConnector c) {
    final l10n = context.l10n;
    final channels = c.channels.where((ch) => !ch.isEmpty).toList();
    showMeshSheet<void>(
      context,
      builder: (sheet) => SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(sheet).height * 0.8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomSheetHeader(title: l10n.bastionDiag_channels),
              Flexible(
                child: channels.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(MeshSpace.lg),
                        child: Text(l10n.diag_noChannels),
                      )
                    : ListView(
                        shrinkWrap: true,
                        children: [
                          for (final ch in channels)
                            InstrumentRow(
                              icon: Icons.tag,
                              title: ch.name,
                              subtitle: '#${ch.index}',
                              onTap: () {
                                Navigator.pop(sheet);
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) =>
                                        ChannelChatScreen(channel: ch),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<MeshCoreConnector>();
    final s = c.latestRadioStats;
    final repeaters = c.contacts
        .where((x) => x.type == advTypeRepeater)
        .toList();
    final l10n = context.l10n;
    final lat = c.selfLatitude, lon = c.selfLongitude;
    final hasGps = lat != null && lon != null && (lat != 0 || lon != 0);
    final used = c.storageUsedKb, total = c.storageTotalKb;

    Widget row(String label, String value, {Widget? trailing}) => InkWell(
      key: ValueKey('diag-$label'),
      onTap: () => _copy(context, label, value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(color: MeshPalette.ink3, fontSize: 13),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: MeshTheme.mono(
                  color: MeshPalette.ink,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );

    Widget section(String title, List<Widget> children) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InstrumentLabel(title),
        MeshCard(child: Column(children: children)),
      ],
    );

    Widget metric(String key, String label, String value, VoidCallback onTap) =>
        Expanded(
          child: MeshCard(
            key: ValueKey('diag-metric-$key'),
            margin: EdgeInsets.zero,
            onTap: onTap,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Column(
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: MeshPalette.ink,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: MeshPalette.ink3, fontSize: 11),
                ),
              ],
            ),
          ),
        );

    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: Text(l10n.bastionDiag_title),
          actions: [
            IconButton(
              tooltip: l10n.bastionDiag_export,
              onPressed: () => _export(context, c),
              icon: const Icon(Icons.ios_share_rounded),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () => _refresh(c),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: MeshSpace.xxl),
            children: [
              _statusCard(context, c),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  children: [
                    metric(
                      'nodes',
                      l10n.bastion_nodes,
                      '${c.contacts.length}',
                      () =>
                          showNodeList(context, l10n.bastion_nodes, c.contacts),
                    ),
                    const SizedBox(width: 8),
                    metric(
                      'repeaters',
                      l10n.bastion_repeaters,
                      '${repeaters.length}',
                      () => showNodeList(
                        context,
                        l10n.bastion_repeaters,
                        repeaters,
                      ),
                    ),
                    const SizedBox(width: 8),
                    metric(
                      'channels',
                      l10n.bastionDiag_channels,
                      '${c.channels.where((ch) => !ch.isEmpty).length}',
                      () => _showChannels(context, c),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text(
                  l10n.diag_tapToCopy,
                  style: TextStyle(color: MeshPalette.ink3, fontSize: 12),
                ),
              ),
              section(l10n.bastionDiag_radio, [
                row(l10n.bastionDiag_frequency, _mhz(c.currentFreqHz)),
                row(
                  l10n.bastionDiag_bandwidth,
                  c.currentBwHz == null ? '—' : '${c.currentBwHz} Hz',
                ),
                row(l10n.bastionDiag_spreadingFactor, _value(c.currentSf)),
                row(l10n.bastionDiag_codingRate, _value(c.currentCr)),
                row(
                  l10n.bastionDiag_txPower,
                  c.currentTxPower == null ? '—' : '${c.currentTxPower} dBm',
                ),
                row('RSSI', s == null ? '—' : '${s.lastRssiDbm} dBm'),
                row(
                  'SNR',
                  s == null ? '—' : '${s.lastSnrDb.toStringAsFixed(1)} dB',
                ),
                row(
                  l10n.bastionDiag_noiseFloor,
                  s == null ? '—' : '${s.noiseFloorDbm} dBm',
                ),
              ]),
              section(l10n.bastionDiag_device, [
                row(l10n.bastionDiag_name, c.deviceDisplayName),
                row(l10n.bastionDiag_manufacturer, _value(c.manufacturerName)),
                row(l10n.bastionDiag_firmware, _value(c.firmwareVersionString)),
                row(l10n.bastionDiag_battery, _battery(c.batteryMillivolts)),
                row(
                  l10n.diag_storage,
                  used == null || total == null || used < 0 || total <= 0
                      ? '—'
                      : l10n.diag_storageValue(used, total),
                ),
                row(
                  l10n.bastionDiag_transport,
                  c.activeTransport.name.toUpperCase(),
                ),
                row(
                  'GPS',
                  hasGps
                      ? '${lat.toStringAsFixed(5)}, ${lon.toStringAsFixed(5)}'
                      : '—',
                  trailing: hasGps
                      ? IconButton(
                          key: const ValueKey('diag-gps-map'),
                          tooltip: l10n.fieldIntel_showOnMap,
                          icon: const Icon(Icons.map_outlined, size: 18),
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => MapScreen(
                                highlightPosition: LatLng(lat, lon),
                              ),
                            ),
                          ),
                        )
                      : null,
                ),
              ]),
              InstrumentLabel(l10n.bastionDiag_deepTools),
              for (final (icon, title, subtitle, page) in [
                (
                  Icons.monitor_heart_rounded,
                  l10n.bastionDiag_liveStats,
                  l10n.bastionDiag_liveStatsHint,
                  const CompanionRadioStatsScreen() as Widget,
                ),
                (
                  Icons.data_object_rounded,
                  l10n.bastionDiag_frameDebug,
                  l10n.bastionDiag_frameDebugHint,
                  const BleDebugLogScreen(),
                ),
                (
                  Icons.bug_report_outlined,
                  l10n.bastionDiag_appLog,
                  l10n.bastionDiag_appLogHint,
                  const AppDebugLogScreen(),
                ),
              ])
                MeshCard(
                  onTap: () => Navigator.of(
                    context,
                  ).push(MaterialPageRoute<void>(builder: (_) => page)),
                  child: InstrumentRow(
                    icon: icon,
                    title: title,
                    subtitle: subtitle,
                    trailing: Icon(
                      Icons.chevron_right,
                      color: MeshPalette.ink3,
                    ),
                    divider: false,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusCard(BuildContext context, MeshCoreConnector c) => MeshCard(
    child: Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _cyan.withValues(alpha: .12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            c.isConnected
                ? Icons.radio_rounded
                : Icons.portable_wifi_off_rounded,
            color: _cyan,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                c.isConnected
                    ? context.l10n.bastionDiag_online
                    : context.l10n.bastionDiag_offline,
                style: TextStyle(
                  color: MeshPalette.ink,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                c.isConnected
                    ? '${c.deviceDisplayName} • ${c.activeTransport.name.toUpperCase()}'
                    : context.l10n.bastionDiag_offlineHint,
                style: TextStyle(color: MeshPalette.ink3, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
