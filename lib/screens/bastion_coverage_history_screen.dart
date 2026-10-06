import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_plus/share_plus.dart';
import '../services/coverage_capture_service.dart';

const coverageCaveat =
    'RSSI/SNR are radio snapshots and may belong to another packet. Positions are radio-advertised coordinates, not phone GPS or proof of coverage. Cyan: recorder; amber: advertised node. No interpolation is performed.';

class BastionCoverageHistoryScreen extends StatefulWidget {
  final CoverageCaptureService capture;
  const BastionCoverageHistoryScreen({super.key, required this.capture});
  @override
  State<BastionCoverageHistoryScreen> createState() => _HistoryState();
}

class _HistoryState extends State<BastionCoverageHistoryScreen> {
  bool loading = true;
  String? error;
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      await widget.capture.loadHistory();
    } catch (e) {
      error = 'Could not load sessions: $e';
    }
    if (mounted) setState(() => loading = false);
  }

  Future<void> _delete(CoverageCaptureSession session) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete saved session?'),
        content: Text(
          '${session.observations.length} observations will be removed from this device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await widget.capture.deleteSession(session.id);
    } catch (e) {
      error = 'Could not delete session: $e';
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Saved coverage sessions')),
    body: loading
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'The newest 20 completed sessions are retained. Share sessions you want to keep. Interrupted captures can be reopened below.',
              ),
              if (error ?? widget.capture.loadWarning case final String warning)
                Text(warning),
              if (widget.capture.history.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'No saved sessions yet. Stop a capture to save it.',
                  ),
                ),
              for (final session in widget.capture.history)
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.route, color: Color(0xFF18D3D3)),
                    title: Text(
                      session.startedAt.toLocal().toString().split('.').first,
                    ),
                    subtitle: Text(
                      '${session.observations.length} observations • ${session.endedAt == null ? 'Interrupted capture' : 'Saved'}',
                    ),
                    trailing: IconButton(
                      tooltip: 'Delete session',
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _delete(session),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => _SessionScreen(
                          session: session,
                          capture: widget.capture,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
  );
}

class _SessionScreen extends StatelessWidget {
  final CoverageCaptureSession session;
  final CoverageCaptureService capture;
  const _SessionScreen({required this.session, required this.capture});
  Future<void> _share(BuildContext context, bool csv) async {
    try {
      final path = csv
          ? await capture.exportCsv(session: session)
          : await capture.exportJson(session: session);
      if (!context.mounted) return;
      await SharePlus.instance.share(
        ShareParams(
          subject: 'Bastion coverage session',
          text: coverageCaveat,
          files: [XFile(path)],
        ),
      );
    } catch (e) {
      if (context.mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Export failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Coverage session')),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(session.startedAt.toLocal().toString()),
        Text(
          '${session.observations.length} observations • ${session.observations.map((o) => o.nodeKey).toSet().length} unique nodes',
        ),
        Wrap(
          spacing: 12,
          children: [
            OutlinedButton.icon(
              onPressed: () => _share(context, false),
              icon: const Icon(Icons.share),
              label: const Text('Share JSON'),
            ),
            OutlinedButton.icon(
              onPressed: () => _share(context, true),
              icon: const Icon(Icons.table_view),
              label: const Text('Share CSV'),
            ),
          ],
        ),
        CoverageSessionMap(observations: session.observations),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(coverageCaveat),
        ),
        for (final o in session.observations.reversed)
          ListTile(
            title: Text(o.nodeName),
            subtitle: Text(
              '${o.timestamp.toLocal()}\n${o.rssiDbm ?? '—'} dBm • SNR ${o.snrDb ?? '—'} dB • snapshot age ${o.radioSnapshotAgeMs ?? 'unknown'} ms\n${o.nodeType} • ${o.transport} • path ${o.pathLength}',
            ),
          ),
      ],
    ),
  );
}

class CoverageSessionMap extends StatelessWidget {
  final List<CoverageObservation> observations;
  const CoverageSessionMap({super.key, required this.observations});
  static bool valid(double? lat, double? lon) =>
      lat != null &&
      lon != null &&
      lat.isFinite &&
      lon.isFinite &&
      lat.abs() <= 90 &&
      lon.abs() <= 180 &&
      !(lat == 0 && lon == 0);
  @override
  Widget build(BuildContext context) {
    final markers = <Marker>[];
    for (final o in observations) {
      void add(double? lat, double? lon, bool recorder) {
        if (!valid(lat, lon)) return;
        markers.add(
          Marker(
            point: LatLng(lat!, lon!),
            width: 32,
            height: 32,
            child: Tooltip(
              message:
                  '${recorder ? 'Recorder' : o.nodeName}: ${o.timestamp.toLocal()}',
              child: Icon(
                recorder ? Icons.my_location : Icons.cell_tower,
                color: recorder ? const Color(0xFF18D3D3) : Colors.amber,
              ),
            ),
          ),
        );
      }

      add(o.recorderLatitude, o.recorderLongitude, true);
      add(o.nodeLatitude, o.nodeLongitude, false);
    }
    if (markers.isEmpty)
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'No usable coordinates in this session. Observations remain available below.',
        ),
      );
    return SizedBox(
      height: 320,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: markers.first.point,
          initialZoom: 12,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.bastionmesh.bastion',
          ),
          MarkerLayer(markers: markers),
          const SimpleAttributionWidget(
            source: Text('© OpenStreetMap contributors • online basemap'),
          ),
        ],
      ),
    );
  }
}
