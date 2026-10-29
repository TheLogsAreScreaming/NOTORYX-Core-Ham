import 'dart:io';

import '../theme/mesh_theme.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../l10n/l10n.dart';
import 'app_debug_log_screen.dart';
import 'ble_debug_log_screen.dart';
import 'companion_radio_stats_screen.dart';

class BastionDiagnosticsScreen extends StatelessWidget {
  const BastionDiagnosticsScreen({super.key});

  static Color get _cyan => MeshPalette.accent;
  static Color get _bg => MeshPalette.bg;

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
      'NOTORYX Core Diagnostics',
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
        subject: 'NOTORYX Core Diagnostics',
        text: 'NOTORYX Core diagnostics export',
        files: [XFile(file.path)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<MeshCoreConnector>();
    final s = c.latestRadioStats;
    final repeaters = c.contacts.where((x) => x.type == advTypeRepeater).length;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: MeshPalette.ink,
        title: Text(l10n.bastionDiag_title),
        actions: [
          IconButton(
            tooltip: l10n.bastionDiag_export,
            onPressed: () => _export(context, c),
            icon: const Icon(Icons.ios_share_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
        children: [
          _statusCard(context, c),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _metric(l10n.bastion_nodes, '${c.contacts.length}'),
              ),
              const SizedBox(width: 8),
              Expanded(child: _metric(l10n.bastion_repeaters, '$repeaters')),
              const SizedBox(width: 8),
              Expanded(
                child: _metric(
                  l10n.bastionDiag_channels,
                  '${c.channels.length}',
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _section(l10n.bastionDiag_radio, [
            _row(l10n.bastionDiag_frequency, _mhz(c.currentFreqHz)),
            _row(
              l10n.bastionDiag_bandwidth,
              c.currentBwHz == null ? '—' : '${c.currentBwHz} Hz',
            ),
            _row(l10n.bastionDiag_spreadingFactor, _value(c.currentSf)),
            _row(l10n.bastionDiag_codingRate, _value(c.currentCr)),
            _row(
              l10n.bastionDiag_txPower,
              c.currentTxPower == null ? '—' : '${c.currentTxPower} dBm',
            ),
            _row('RSSI', s == null ? '—' : '${s.lastRssiDbm} dBm'),
            _row(
              'SNR',
              s == null ? '—' : '${s.lastSnrDb.toStringAsFixed(1)} dB',
            ),
            _row(
              l10n.bastionDiag_noiseFloor,
              s == null ? '—' : '${s.noiseFloorDbm} dBm',
            ),
          ]),
          const SizedBox(height: 12),
          _section(l10n.bastionDiag_device, [
            _row(l10n.bastionDiag_name, c.deviceDisplayName),
            _row(l10n.bastionDiag_manufacturer, _value(c.manufacturerName)),
            _row(l10n.bastionDiag_firmware, _value(c.firmwareVersionString)),
            _row(l10n.bastionDiag_battery, _battery(c.batteryMillivolts)),
            _row(
              l10n.bastionDiag_transport,
              c.activeTransport.name.toUpperCase(),
            ),
            _row(
              'GPS',
              c.selfLatitude == null || c.selfLongitude == null
                  ? '—'
                  : '${c.selfLatitude!.toStringAsFixed(5)}, ${c.selfLongitude!.toStringAsFixed(5)}',
            ),
          ]),
          const SizedBox(height: 18),
          Text(l10n.bastionDiag_deepTools, style: MeshTheme.sectionTitle()),
          const SizedBox(height: 8),
          _nav(
            context,
            Icons.monitor_heart_rounded,
            l10n.bastionDiag_liveStats,
            l10n.bastionDiag_liveStatsHint,
            const CompanionRadioStatsScreen(),
          ),
          const SizedBox(height: 8),
          _nav(
            context,
            Icons.data_object_rounded,
            l10n.bastionDiag_frameDebug,
            l10n.bastionDiag_frameDebugHint,
            const BleDebugLogScreen(),
          ),
          const SizedBox(height: 8),
          _nav(
            context,
            Icons.bug_report_outlined,
            l10n.bastionDiag_appLog,
            l10n.bastionDiag_appLogHint,
            const AppDebugLogScreen(),
          ),
        ],
      ),
    );
  }

  Widget _statusCard(BuildContext context, MeshCoreConnector c) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      border: Border.all(color: MeshPalette.line),
      borderRadius: BorderRadius.circular(MeshRadii.xs),
    ),
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
                  fontWeight: FontWeight.w900,
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

  Widget _metric(String label, String value) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    decoration: BoxDecoration(
      border: Border.all(color: MeshPalette.line),
      borderRadius: BorderRadius.circular(MeshRadii.xs),
    ),
    child: Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: _cyan,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            color: MeshPalette.ink3,
            fontSize: 9,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );

  Widget _section(String title, List<Widget> children) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: MeshPalette.line),
      borderRadius: BorderRadius.circular(MeshRadii.xs),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: MeshTheme.sectionTitle()),
        const SizedBox(height: 8),
        ...children,
      ],
    ),
  );

  Widget _row(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(color: MeshPalette.ink3, fontSize: 12),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: MeshPalette.ink,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _nav(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Widget screen,
  ) => Material(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(MeshRadii.xs),
    child: InkWell(
      borderRadius: BorderRadius.circular(MeshRadii.xs),
      onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
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
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(color: MeshPalette.ink3, fontSize: 11.5),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: _cyan),
          ],
        ),
      ),
    ),
  );
}
