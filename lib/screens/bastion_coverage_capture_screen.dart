import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../connector/meshcore_connector.dart';
import '../services/coverage_capture_service.dart';

class BastionCoverageCaptureScreen extends StatefulWidget {
  const BastionCoverageCaptureScreen({super.key});

  @override
  State<BastionCoverageCaptureScreen> createState() =>
      _BastionCoverageCaptureScreenState();
}

class _BastionCoverageCaptureScreenState
    extends State<BastionCoverageCaptureScreen> {
  static const cyan = Color(0xFF18D3D3);
  static const bg = Color(0xFF0B0E11);
  static const panel = Color(0xFF12171C);

  final CoverageCaptureService _capture = CoverageCaptureService();
  MeshCoreConnector? _connector;
  Timer? _clock;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final connector = context.read<MeshCoreConnector>();
    if (!identical(_connector, connector)) {
      _connector = connector;
      _capture.attach(connector);
      _capture.addListener(_refresh);
    }
  }

  @override
  void dispose() {
    _clock?.cancel();
    _capture.removeListener(_refresh);
    _capture.dispose();
    super.dispose();
  }

  void _refresh() {
    if (!mounted) return;
    if (_capture.recording && !(_clock?.isActive ?? false)) {
      _clock = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() {});
      });
    } else if (!_capture.recording) {
      _clock?.cancel();
      _clock = null;
    }
    setState(() {});
  }

  Future<void> _toggle() async {
    try {
      if (_capture.recording) {
        await _capture.stop();
      } else {
        await _capture.start();
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString().replaceFirst('Bad state: ', ''))),
      );
    }
  }

  Future<void> _export(String format) async {
    if (_capture.observations.isEmpty) return;
    final path = format == 'csv'
        ? await _capture.exportCsv()
        : await _capture.exportJson();
    if (!mounted) return;
    await SharePlus.instance.share(
      ShareParams(
        subject: 'Bastion Coverage Session',
        text: 'Bastion coverage capture export',
        files: [XFile(path)],
      ),
    );
  }

  String get _elapsed {
    final started = _capture.startedAt;
    if (started == null) return '00:00';
    final end = _capture.recording ? DateTime.now() : (_capture.endedAt ?? DateTime.now());
    final d = end.difference(started);
    final h = d.inHours;
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return h > 0 ? '$h:$m:$s' : '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final connector = context.watch<MeshCoreConnector>();
    final observations = _capture.observations;
    final hasGps = connector.selfLatitude != null && connector.selfLongitude != null;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        foregroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BASTION',
              style: TextStyle(
                color: cyan,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.7,
              ),
            ),
            Text(
              'Coverage Capture',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: panel,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: cyan.withValues(alpha: .45)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _capture.recording
                          ? Icons.radio_button_checked
                          : Icons.route_rounded,
                      color: cyan,
                      size: 30,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _capture.recording
                            ? 'CAPTURE ACTIVE'
                            : 'FIELD COVERAGE SESSION',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  connector.isConnected
                      ? 'Bastion records newly heard nodes during this session, including route data, node/location metadata and the nearest available radio RSSI/SNR snapshot.'
                      : 'Connect a radio before starting. Coverage capture records live mesh observations from the connected companion radio.',
                  style: const TextStyle(
                    color: Color(0xFF9AA6AF),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _Stat(
                  label: 'OBSERVATIONS',
                  value: '${observations.length}',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _Stat(
                  label: 'UNIQUE NODES',
                  value: '${_capture.uniqueNodes}',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(child: _Stat(label: 'ELAPSED', value: _elapsed)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _Status(
                  icon: Icons.radio_rounded,
                  label: connector.isConnected ? 'RADIO CONNECTED' : 'NO RADIO',
                  active: connector.isConnected,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _Status(
                  icon: Icons.my_location_rounded,
                  label: hasGps ? 'RADIO GPS READY' : 'NO RADIO GPS',
                  active: hasGps,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor:
                  _capture.recording ? const Color(0xFF303A42) : cyan,
              foregroundColor: _capture.recording ? Colors.white : Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: connector.isConnected || _capture.recording ? _toggle : null,
            icon: Icon(
              _capture.recording ? Icons.stop_rounded : Icons.play_arrow_rounded,
            ),
            label: Text(
              _capture.recording ? 'STOP + SAVE SESSION' : 'START COVERAGE SESSION',
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
          if (observations.isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _export('json'),
                    icon: const Icon(Icons.data_object_rounded),
                    label: const Text('EXPORT JSON'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _export('csv'),
                    icon: const Icon(Icons.table_view_rounded),
                    label: const Text('EXPORT CSV'),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 22),
          const Text(
            'LIVE OBSERVATIONS',
            style: TextStyle(
              color: cyan,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.3,
            ),
          ),
          const SizedBox(height: 10),
          if (observations.isEmpty)
            const _Info(
              icon: Icons.sensors_rounded,
              title: 'WAITING FOR MESH ACTIVITY',
              body:
                  'Start a session and newly heard active nodes will appear here. RSSI/SNR values are radio snapshots and may not always be uniquely attributable to a specific packet.',
            )
          else
            ...observations.reversed.take(30).map(
              (o) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _ObservationTile(observation: o),
              ),
            ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;

  const _Stat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF12171C),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF26313A)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF9AA6AF),
                fontSize: 9,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF18D3D3),
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      );
}

class _Status extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const _Status({
    required this.icon,
    required this.label,
    required this.active,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF10151A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: active
                ? const Color(0xFF18D3D3).withValues(alpha: .45)
                : const Color(0xFF26313A),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 17,
              color: active
                  ? const Color(0xFF18D3D3)
                  : const Color(0xFF697680),
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: active
                      ? Colors.white
                      : const Color(0xFF89949D),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      );
}

class _ObservationTile extends StatelessWidget {
  final CoverageObservation observation;

  const _ObservationTile({required this.observation});

  @override
  Widget build(BuildContext context) {
    final signal = observation.rssiDbm == null
        ? 'signal n/a'
        : '${observation.rssiDbm} dBm';
    final snr = observation.snrDb == null
        ? 'SNR n/a'
        : 'SNR ${observation.snrDb!.toStringAsFixed(1)} dB';
    final location = observation.recorderLatitude != null &&
            observation.recorderLongitude != null
        ? '${observation.recorderLatitude!.toStringAsFixed(5)}, ${observation.recorderLongitude!.toStringAsFixed(5)}'
        : 'radio GPS unavailable';

    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFF10151A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF26313A)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.cell_tower_rounded, color: Color(0xFF18D3D3)),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  observation.nodeName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${observation.nodeType}  •  $signal  •  $snr',
                  style: const TextStyle(
                    color: Color(0xFFB0BBC4),
                    fontSize: 11.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Path: ${observation.pathLength < 0 ? 'flood' : observation.pathLength == 0 ? 'direct' : '${observation.pathLength} hop'}  •  $location',
                  style: const TextStyle(
                    color: Color(0xFF7F8B94),
                    fontSize: 10.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _Info({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFF10151A),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFF26313A)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF18D3D3)),
            const SizedBox(width: 11),
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
                  const SizedBox(height: 4),
                  Text(
                    body,
                    style: const TextStyle(
                      color: Color(0xFF9AA6AF),
                      fontSize: 12.5,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
