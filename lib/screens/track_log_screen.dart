import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../helpers/snack_bar_builder.dart';
import '../l10n/l10n.dart';
import '../models/track_log.dart';
import '../services/track_log_service.dart';
import '../theme/mesh_theme.dart';
import '../utils/platform_info.dart';
import '../widgets/connect_ui.dart';
import '../widgets/mesh_ui.dart';
import '../widgets/ember_backdrop.dart';
import '../widgets/ui/mesh_states.dart';

/// Start and stop a breadcrumb trail from the radio's GPS, look at saved
/// tracks, and export them as GPX.
class TrackLogScreen extends StatefulWidget {
  const TrackLogScreen({super.key});

  @override
  State<TrackLogScreen> createState() => _TrackLogScreenState();
}

class _TrackLogScreenState extends State<TrackLogScreen> {
  String? _selectedId;
  Timer? _tick;

  @override
  void initState() {
    super.initState();
    // Keeps the running duration current between points.
    _tick = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }

  Future<void> _export(Track track) async {
    final l10n = context.l10n;
    final name = l10n.trackLog_gpxName(_when(context, track.started));
    try {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/notoryx-track-${track.id}.gpx');
      await file.writeAsString(trackToGpx(track, name: name));
      await SharePlus.instance.share(
        ShareParams(subject: name, files: [XFile(file.path)]),
      );
    } catch (e) {
      if (!mounted) return;
      showDismissibleSnackBar(
        context,
        content: Text(l10n.trackLog_exportFailed),
      );
    }
  }

  Future<void> _confirmDelete(TrackLogService log, Track track) async {
    final l10n = context.l10n;
    final ok = await confirmDestructive(
      context,
      title: l10n.trackLog_deleteTitle,
      message: l10n.trackLog_deleteBody,
      confirmLabel: l10n.common_delete,
    );
    if (ok == true) {
      if (_selectedId == track.id) setState(() => _selectedId = null);
      await log.delete(track);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final log = context.watch<TrackLogService>();
    final now = DateTime.now();
    final current = log.recording;
    Track? shown = current;
    for (final t in log.tracks) {
      if (t.id == _selectedId) shown = t;
    }
    shown ??= log.tracks.isEmpty ? null : log.tracks.first;
    final statusColor = current != null ? MeshPalette.alert : MeshPalette.ink3;

    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: Text(l10n.trackLog_title),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
              children: [
                ConsolePanel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          PulseDot(
                            color: statusColor,
                            size: 10,
                            animate: current != null,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            current != null
                                ? l10n.trackLog_recording
                                : l10n.trackLog_notRecording,
                            key: const ValueKey('track-status'),
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: MeshPalette.ink,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ],
                      ),
                      if (current != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          _stats(context, current, now),
                          style: TextStyle(color: MeshPalette.ink2),
                        ),
                      ],
                      if (!log.hasPosition) ...[
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.gps_off,
                              size: 18,
                              color: MeshPalette.warn,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                l10n.trackLog_noGps,
                                style: TextStyle(color: MeshPalette.warn),
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 46,
                        child: current != null
                            ? FilledButton.icon(
                                key: const ValueKey('track-stop'),
                                style: FilledButton.styleFrom(
                                  backgroundColor: MeshPalette.alert,
                                ),
                                onPressed: () => unawaited(log.stop()),
                                icon: const Icon(Icons.stop_rounded),
                                label: Text(l10n.trackLog_stop),
                              )
                            : FilledButton.icon(
                                key: const ValueKey('track-start'),
                                onPressed: () => unawaited(log.start()),
                                icon: const Icon(Icons.fiber_manual_record),
                                label: Text(l10n.trackLog_start),
                              ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l10n.trackLog_howItWorks,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: MeshPalette.ink3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                ConsolePanel(
                  padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.trackLog_snap,
                              style: TextStyle(
                                color: MeshPalette.ink,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              l10n.trackLog_snapBody,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: MeshPalette.ink3),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: log.snapToGrid,
                        onChanged: (v) => unawaited(log.setSnapToGrid(v)),
                      ),
                    ],
                  ),
                ),
                if (shown != null && shown.points.length > 1) ...[
                  const SizedBox(height: 22),
                  ConsoleKicker(_when(context, shown.started)),
                  ConsolePanel(
                    padding: const EdgeInsets.all(12),
                    child: AspectRatio(
                      aspectRatio: 16 / 10,
                      child: Semantics(
                        label: _stats(context, shown, now),
                        child: CustomPaint(
                          painter: _TrackPainter(
                            points: shown.points,
                            line: MeshPalette.accent,
                            start: MeshPalette.signal,
                            grid: MeshPalette.line,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 22),
                ConsoleKicker(l10n.trackLog_saved),
                if (log.tracks.isEmpty)
                  Text(
                    l10n.trackLog_none,
                    style: TextStyle(color: MeshPalette.ink3),
                  ),
                for (final t in log.tracks)
                  Padding(
                    key: ValueKey(t.id),
                    padding: const EdgeInsets.only(bottom: 8),
                    child: MeshCard(
                      margin: EdgeInsets.zero,
                      borderColor: t.id == shown?.id
                          ? MeshPalette.accentLine
                          : null,
                      onTap: () => setState(() => _selectedId = t.id),
                      child: Row(
                        children: [
                          Icon(
                            t.id == current?.id
                                ? Icons.fiber_manual_record
                                : Icons.route,
                            color: t.id == current?.id
                                ? MeshPalette.alert
                                : MeshPalette.accent,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _when(context, t.started),
                                  style: TextStyle(
                                    color: MeshPalette.ink,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  _stats(context, t, now),
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: MeshPalette.ink3),
                                ),
                              ],
                            ),
                          ),
                          if (!PlatformInfo.isWeb && t.points.isNotEmpty)
                            IconButton(
                              tooltip: l10n.trackLog_export,
                              onPressed: () => unawaited(_export(t)),
                              icon: const Icon(Icons.ios_share),
                            ),
                          IconButton(
                            tooltip: l10n.common_delete,
                            onPressed: () => unawaited(_confirmDelete(log, t)),
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _when(BuildContext context, DateTime at) {
    final local = at.toLocal();
    final m = MaterialLocalizations.of(context);
    return '${m.formatMediumDate(local)} · '
        '${m.formatTimeOfDay(TimeOfDay.fromDateTime(local))}';
  }

  String _stats(BuildContext context, Track t, DateTime now) {
    final d = t.duration(now);
    final h = d.inHours, m = d.inMinutes % 60;
    return context.l10n.trackLog_stats(
      t.distanceKm.toStringAsFixed(2),
      h > 0 ? '${h}h ${m}m' : '${m}m',
      t.points.length,
    );
  }
}

/// Draws a track as a line scaled to fit, north up, with the start marked.
class _TrackPainter extends CustomPainter {
  _TrackPainter({
    required this.points,
    required this.line,
    required this.start,
    required this.grid,
  });

  final List<TrackPoint> points;
  final Color line;
  final Color start;
  final Color grid;

  @override
  void paint(Canvas canvas, Size size) {
    var minLat = points.first.lat, maxLat = minLat;
    var minLon = points.first.lon, maxLon = minLon;
    for (final p in points) {
      minLat = math.min(minLat, p.lat);
      maxLat = math.max(maxLat, p.lat);
      minLon = math.min(minLon, p.lon);
      maxLon = math.max(maxLon, p.lon);
    }
    // Longitude degrees shrink away from the equator.
    final lonScale = math.cos((minLat + maxLat) / 2 * math.pi / 180).abs();
    final w = math.max((maxLon - minLon) * lonScale, 1e-6);
    final h = math.max(maxLat - minLat, 1e-6);
    const pad = 12.0;
    final scale = math.min(
      (size.width - 2 * pad) / w,
      (size.height - 2 * pad) / h,
    );
    final offX = (size.width - w * scale) / 2;
    final offY = (size.height - h * scale) / 2;
    Offset at(TrackPoint p) => Offset(
      offX + (p.lon - minLon) * lonScale * scale,
      size.height - (offY + (p.lat - minLat) * scale),
    );

    final gridPaint = Paint()
      ..color = grid
      ..strokeWidth = 1;
    for (var i = 1; i < 4; i++) {
      final y = size.height * i / 4, x = size.width * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    final path = Path()..moveTo(at(points.first).dx, at(points.first).dy);
    for (final p in points.skip(1)) {
      path.lineTo(at(p).dx, at(p).dy);
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = line
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(at(points.first), 6, Paint()..color = start);
    canvas.drawCircle(at(points.last), 6, Paint()..color = line);
  }

  @override
  bool shouldRepaint(_TrackPainter old) =>
      old.points.length != points.length ||
      old.line != line ||
      !identical(old.points, points);
}
