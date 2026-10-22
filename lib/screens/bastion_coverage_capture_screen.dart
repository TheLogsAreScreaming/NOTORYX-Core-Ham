import 'dart:async';

import 'bastion_coverage_history_screen.dart';

import '../theme/mesh_theme.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/l10n.dart';

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
  static Color get cyan => MeshPalette.accent;
  static Color get bg => MeshPalette.bg;
  static Color get panel => MeshPalette.bg2;

  final CoverageCaptureService _capture = CoverageCaptureService();
  MeshCoreConnector? _connector;
  Timer? _clock;
  bool _busy = false;

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
    if (_busy) return;
    setState(() => _busy = true);
    try {
      if (_capture.recording) {
        await _capture.stop();
      } else {
        await _capture.start();
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceFirst('Bad state: ', '')),
        ),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _export(String format) async {
    if (_capture.observations.isEmpty) return;
    final path = format == 'csv'
        ? await _capture.exportCsv()
        : await _capture.exportJson();
    if (!mounted) return;
    final l10n = context.l10n;
    await SharePlus.instance.share(
      ShareParams(
        subject: l10n.coverage_shareSubject,
        text: l10n.coverage_shareText,
        files: [XFile(path)],
      ),
    );
  }

  String get _elapsed {
    final started = _capture.startedAt;
    if (started == null) return '00:00';
    final end = _capture.recording
        ? DateTime.now()
        : (_capture.endedAt ?? DateTime.now());
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
    final hasGps =
        connector.selfLatitude != null && connector.selfLongitude != null;
    final l10n = context.l10n;

    return PopScope(
      canPop: !_capture.recording && !_busy,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.coverage_leaveBlocked)));
        }
      },
      child: Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          backgroundColor: bg,
          foregroundColor: MeshPalette.ink,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NOTORYX',
                style: TextStyle(
                  color: cyan,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.7,
                ),
              ),
              Text(
                l10n.coverage_title,
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            OutlinedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      BastionCoverageHistoryScreen(capture: _capture),
                ),
              ),
              icon: const Icon(Icons.history),
              label: Text(l10n.coverage_savedSessions),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(l10n.coverage_caveat),
            ),
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
                              ? l10n.coverage_captureActive
                              : l10n.coverage_fieldSession,
                          style: TextStyle(
                            color: MeshPalette.ink,
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
                        ? l10n.coverage_connectedBody
                        : l10n.coverage_disconnectedBody,
                    style: TextStyle(color: MeshPalette.ink3, height: 1.45),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _Stat(
                    label: l10n.coverage_observations,
                    value: '${observations.length}',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _Stat(
                    label: l10n.coverage_uniqueNodes,
                    value: '${_capture.uniqueNodes}',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _Stat(label: l10n.coverage_elapsed, value: _elapsed),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _Status(
                    icon: Icons.radio_rounded,
                    label: connector.isConnected
                        ? l10n.coverage_radioConnected
                        : l10n.coverage_noRadio,
                    active: connector.isConnected,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _Status(
                    icon: Icons.my_location_rounded,
                    label: hasGps
                        ? l10n.coverage_gpsReady
                        : l10n.coverage_noGps,
                    active: hasGps,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: _capture.recording
                    ? const Color(0xFF303A42)
                    : cyan,
                foregroundColor: _capture.recording
                    ? Colors.white
                    : Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: !_busy && (connector.isConnected || _capture.recording)
                  ? _toggle
                  : null,
              icon: Icon(
                _capture.recording
                    ? Icons.stop_rounded
                    : Icons.play_arrow_rounded,
              ),
              label: Text(
                _capture.recording
                    ? l10n.coverage_stopSave
                    : l10n.coverage_start,
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
                      label: Text(l10n.coverage_exportJson),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _export('csv'),
                      icon: const Icon(Icons.table_view_rounded),
                      label: Text(l10n.coverage_exportCsv),
                    ),
                  ),
                ],
              ),
            ],
            if (observations.isNotEmpty)
              CoverageSessionMap(observations: observations),
            const SizedBox(height: 22),
            Text(
              l10n.coverage_liveObservations,
              style: TextStyle(
                color: cyan,
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.3,
              ),
            ),
            const SizedBox(height: 10),
            if (observations.isEmpty)
              _Info(
                icon: Icons.sensors_rounded,
                title: l10n.coverage_waiting,
                body: l10n.coverage_waitingBody,
              )
            else
              ...observations.reversed
                  .take(30)
                  .map(
                    (o) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _ObservationTile(observation: o),
                    ),
                  ),
          ],
        ),
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
      color: MeshPalette.bg2,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: MeshPalette.line),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: MeshPalette.ink3,
            fontSize: 9,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            color: MeshPalette.accent,
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
      color: MeshPalette.bg1,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: active
            ? MeshPalette.accent.withValues(alpha: .45)
            : MeshPalette.line,
      ),
    ),
    child: Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: active ? MeshPalette.accent : const Color(0xFF697680),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: active ? Colors.white : const Color(0xFF89949D),
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
    final l10n = context.l10n;
    final signal = observation.rssiDbm == null
        ? l10n.coverage_signalNa
        : '${observation.rssiDbm} dBm';
    final snr = observation.snrDb == null
        ? l10n.coverage_snrNa
        : 'SNR ${observation.snrDb!.toStringAsFixed(1)} dB';
    final location =
        observation.recorderLatitude != null &&
            observation.recorderLongitude != null
        ? '${observation.recorderLatitude!.toStringAsFixed(5)}, ${observation.recorderLongitude!.toStringAsFixed(5)}'
        : l10n.coverage_gpsUnavailable;

    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: MeshPalette.bg1,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: MeshPalette.line),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.cell_tower_rounded, color: MeshPalette.accent),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  observation.nodeName,
                  style: TextStyle(
                    color: MeshPalette.ink,
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
                  l10n.coverage_pathLine(
                    observation.pathLength < 0
                        ? l10n.coverage_pathFlood
                        : observation.pathLength == 0
                        ? l10n.coverage_pathDirect
                        : l10n.bastion_hopsCount(observation.pathLength),
                    location,
                  ),
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

  const _Info({required this.icon, required this.title, required this.body});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: MeshPalette.bg1,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: MeshPalette.line),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: MeshPalette.accent),
        const SizedBox(width: 11),
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
              const SizedBox(height: 4),
              Text(
                body,
                style: TextStyle(
                  color: MeshPalette.ink3,
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
