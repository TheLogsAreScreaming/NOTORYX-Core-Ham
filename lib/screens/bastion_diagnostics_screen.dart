import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import 'app_debug_log_screen.dart';
import 'ble_debug_log_screen.dart';
import 'companion_radio_stats_screen.dart';

class BastionDiagnosticsScreen extends StatelessWidget {
  const BastionDiagnosticsScreen({super.key});

  static const _cyan = Color(0xFF18D3D3);
  static const _bg = Color(0xFF0B0E11);
  static const _panel = Color(0xFF12171C);

  String _value(Object? value) => value == null ? '—' : '$value';

  String _mhz(int? hz) =>
      hz == null ? '—' : '${(hz / 1000000).toStringAsFixed(4)} MHz';

  String _battery(int? mv) =>
      mv == null ? '—' : '${(mv / 1000).toStringAsFixed(2)} V';

  Future<void> _export(BuildContext context, MeshCoreConnector c) async {
    final s = c.latestRadioStats;
    final now = DateTime.now().toIso8601String();
    final lines = <String>[
      'Bastion Diagnostics',
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
        subject: 'Bastion Diagnostics',
        text: 'Bastion diagnostics export',
        files: [XFile(file.path)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<MeshCoreConnector>();
    final s = c.latestRadioStats;
    final repeaters = c.contacts.where((x) => x.type == advTypeRepeater).length;

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BASTION',
              style: TextStyle(
                color: _cyan,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.7,
              ),
            ),
            Text('Diagnostics', style: TextStyle(fontWeight: FontWeight.w900)),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Export diagnostics',
            onPressed: () => _export(context, c),
            icon: const Icon(Icons.ios_share_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
        children: [
          _statusCard(c),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _metric('NODES', '${c.contacts.length}')),
              const SizedBox(width: 8),
              Expanded(child: _metric('REPEATERS', '$repeaters')),
              const SizedBox(width: 8),
              Expanded(child: _metric('CHANNELS', '${c.channels.length}')),
            ],
          ),
          const SizedBox(height: 18),
          _section('RADIO', [
            _row('Frequency', _mhz(c.currentFreqHz)),
            _row(
              'Bandwidth',
              c.currentBwHz == null ? '—' : '${c.currentBwHz} Hz',
            ),
            _row('Spreading factor', _value(c.currentSf)),
            _row('Coding rate', _value(c.currentCr)),
            _row(
              'TX power',
              c.currentTxPower == null ? '—' : '${c.currentTxPower} dBm',
            ),
            _row('RSSI', s == null ? '—' : '${s.lastRssiDbm} dBm'),
            _row(
              'SNR',
              s == null ? '—' : '${s.lastSnrDb.toStringAsFixed(1)} dB',
            ),
            _row('Noise floor', s == null ? '—' : '${s.noiseFloorDbm} dBm'),
          ]),
          const SizedBox(height: 12),
          _section('DEVICE', [
            _row('Name', c.deviceDisplayName),
            _row('Manufacturer', _value(c.manufacturerName)),
            _row('Firmware', _value(c.firmwareVersionString)),
            _row('Battery', _battery(c.batteryMillivolts)),
            _row('Transport', c.activeTransport.name.toUpperCase()),
            _row(
              'GPS',
              c.selfLatitude == null || c.selfLongitude == null
                  ? '—'
                  : '${c.selfLatitude!.toStringAsFixed(5)}, ${c.selfLongitude!.toStringAsFixed(5)}',
            ),
          ]),
          const SizedBox(height: 18),
          const Text(
            'DEEP TOOLS',
            style: TextStyle(
              color: _cyan,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          _nav(
            context,
            Icons.monitor_heart_rounded,
            'LIVE RADIO STATS',
            'Noise, RSSI, SNR and airtime',
            const CompanionRadioStatsScreen(),
          ),
          const SizedBox(height: 8),
          _nav(
            context,
            Icons.data_object_rounded,
            'FRAME / BLE DEBUG',
            'Inspect decoded and raw received frames',
            const BleDebugLogScreen(),
          ),
          const SizedBox(height: 8),
          _nav(
            context,
            Icons.bug_report_outlined,
            'APP DEBUG LOG',
            'Review application diagnostic events',
            const AppDebugLogScreen(),
          ),
        ],
      ),
    );
  }

  Widget _statusCard(MeshCoreConnector c) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _panel,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: _cyan.withValues(alpha: .45)),
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
                c.isConnected ? 'RADIO ONLINE' : 'RADIO OFFLINE',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                c.isConnected
                    ? '${c.deviceDisplayName} • ${c.activeTransport.name.toUpperCase()}'
                    : 'Connect a MeshCore companion to populate live diagnostics.',
                style: const TextStyle(color: Color(0xFF9AA6AF), fontSize: 12),
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
      color: _panel,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFF26313A)),
    ),
    child: Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: _cyan,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8D9AA4),
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
      color: _panel,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF26313A)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: _cyan,
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.3,
          ),
        ),
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
            style: const TextStyle(color: Color(0xFF9AA6AF), fontSize: 12),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
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
    color: _panel,
    borderRadius: BorderRadius.circular(14),
    child: InkWell(
      borderRadius: BorderRadius.circular(14),
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
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF9AA6AF),
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: _cyan),
          ],
        ),
      ),
    ),
  );
}
