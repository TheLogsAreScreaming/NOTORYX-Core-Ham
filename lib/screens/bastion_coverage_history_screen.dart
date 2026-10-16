import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_plus/share_plus.dart';
import '../l10n/l10n.dart';
import '../services/coverage_capture_service.dart';

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
      if (mounted) error = context.l10n.coverage_loadFailed('$e');
    }
    if (mounted) setState(() => loading = false);
  }

  Future<void> _delete(CoverageCaptureSession session) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.coverage_deleteTitle),
        content: Text(
          context.l10n.coverage_deleteBody(session.observations.length),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.l10n.common_cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.l10n.common_delete),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await widget.capture.deleteSession(session.id);
    } catch (e) {
      if (mounted) error = context.l10n.coverage_deleteFailed('$e');
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.l10n.coverage_historyTitle)),
    body: loading
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(context.l10n.coverage_retention),
              if (error ?? widget.capture.loadWarning case final String warning)
                Text(warning),
              if (widget.capture.history.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(context.l10n.coverage_noSessions),
                ),
              for (final session in widget.capture.history)
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.route, color: Color(0xFF8AB6AA)),
                    title: Text(
                      session.startedAt.toLocal().toString().split('.').first,
                    ),
                    subtitle: Text(
                      '${context.l10n.bastion_observationsCount(session.observations.length)} • ${session.endedAt == null ? context.l10n.coverage_interrupted : context.l10n.coverage_saved}',
                    ),
                    trailing: IconButton(
                      tooltip: context.l10n.coverage_deleteTooltip,
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
          subject: context.l10n.coverage_shareSubject,
          text: context.l10n.coverage_caveat,
          files: [XFile(path)],
        ),
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.coverage_exportFailed('$e'))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.l10n.coverage_sessionTitle)),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(session.startedAt.toLocal().toString()),
        Text(
          '${context.l10n.bastion_observationsCount(session.observations.length)} • ${context.l10n.bastion_uniqueNodesCount(session.observations.map((o) => o.nodeKey).toSet().length)}',
        ),
        Wrap(
          spacing: 12,
          children: [
            OutlinedButton.icon(
              onPressed: () => _share(context, false),
              icon: const Icon(Icons.share),
              label: Text(context.l10n.coverage_shareJson),
            ),
            OutlinedButton.icon(
              onPressed: () => _share(context, true),
              icon: const Icon(Icons.table_view),
              label: Text(context.l10n.coverage_shareCsv),
            ),
          ],
        ),
        CoverageSessionMap(observations: session.observations),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(context.l10n.coverage_caveat),
        ),
        for (final o in session.observations.reversed)
          ListTile(
            title: Text(o.nodeName),
            subtitle: Text(
              '${o.timestamp.toLocal()}\n${context.l10n.coverage_snapshotDetail('${o.rssiDbm ?? '—'}', '${o.snrDb ?? '—'}', '${o.radioSnapshotAgeMs ?? context.l10n.coverage_unknown}')}\n${o.nodeType} • ${o.transport} • ${context.l10n.coverage_pathValue('${o.pathLength}')}',
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
                  '${recorder ? context.l10n.coverage_recorder : o.nodeName}: ${o.timestamp.toLocal()}',
              child: Icon(
                recorder ? Icons.my_location : Icons.cell_tower,
                color: recorder ? const Color(0xFF8AB6AA) : Colors.amber,
              ),
            ),
          ),
        );
      }

      add(o.recorderLatitude, o.recorderLongitude, true);
      add(o.nodeLatitude, o.nodeLongitude, false);
    }
    if (markers.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Text(context.l10n.coverage_noCoordinates),
      );
    }
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
          SimpleAttributionWidget(
            source: Text(context.l10n.coverage_osmAttribution),
          ),
        ],
      ),
    );
  }
}
