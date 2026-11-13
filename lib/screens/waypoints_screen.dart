import 'dart:convert';
import 'dart:math' as math;

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../connector/meshcore_connector.dart';
import '../helpers/snack_bar_builder.dart';
import '../l10n/l10n.dart';
import '../models/channel.dart';
import '../models/waypoint.dart';
import '../services/waypoint_store.dart';
import '../theme/mesh_theme.dart';
import '../utils/app_logger.dart';
import '../widgets/coordinate_copy_sheet.dart';
import '../widgets/ember_backdrop.dart';

/// Great-circle length of [points] in kilometres.
double routeLengthKm(List<Waypoint> points) {
  const r = 6371.0;
  double rad(double d) => d * math.pi / 180;
  var total = 0.0;
  for (var i = 1; i < points.length; i++) {
    final a = points[i - 1], b = points[i];
    final dLat = rad(b.lat - a.lat), dLon = rad(b.lon - a.lon);
    final h =
        math.pow(math.sin(dLat / 2), 2) +
        math.cos(rad(a.lat)) *
            math.cos(rad(b.lat)) *
            math.pow(math.sin(dLon / 2), 2);
    total += 2 * r * math.asin(math.min(1, math.sqrt(h)));
  }
  return total;
}

/// Saved waypoints and routes: import GPX, export GPX, copy, send a
/// waypoint to a channel as a shared marker, or delete.
class WaypointsScreen extends StatelessWidget {
  const WaypointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final store = context.watch<WaypointStore>();
    final waypoints = store.waypoints;
    final routes = store.routes;
    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          foregroundColor: MeshPalette.ink,
          title: Text(l10n.waypoints_title),
          actions: [
            PopupMenuButton<String>(
              key: const ValueKey('waypoints-menu'),
              onSelected: (v) => switch (v) {
                'file' => _importFile(context),
                'paste' => _importPaste(context),
                _ => _export(context),
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'file',
                  child: Text(l10n.waypoints_importFile),
                ),
                PopupMenuItem(
                  value: 'paste',
                  child: Text(l10n.waypoints_importPaste),
                ),
                if (waypoints.isNotEmpty || routes.isNotEmpty)
                  PopupMenuItem(
                    value: 'export',
                    child: Text(l10n.waypoints_export),
                  ),
              ],
            ),
          ],
        ),
        body: SafeArea(
          top: false,
          child: waypoints.isEmpty && routes.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(MeshSpace.xl),
                    child: Text(
                      l10n.waypoints_empty,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: MeshPalette.ink2),
                    ),
                  ),
                )
              : ListView(
                  children: [
                    if (waypoints.isNotEmpty)
                      _Header(l10n.waypoints_waypoints(waypoints.length)),
                    for (final w in waypoints)
                      ListTile(
                        key: ValueKey('wpt-${w.id}'),
                        leading: const Icon(Icons.place_outlined),
                        title: Text(w.name),
                        subtitle: Text(
                          formatCoordinateFor(context, w.lat, w.lon),
                        ),
                        onTap: () => _waypointActions(context, w),
                      ),
                    if (routes.isNotEmpty)
                      _Header(l10n.waypoints_routes(routes.length)),
                    for (final r in routes)
                      ListTile(
                        key: ValueKey('rte-${r.id}'),
                        leading: const Icon(Icons.route_outlined),
                        title: Text(r.name),
                        subtitle: Text(
                          l10n.waypoints_routeSummary(
                            r.points.length,
                            routeLengthKm(r.points).toStringAsFixed(1),
                          ),
                        ),
                        trailing: IconButton(
                          tooltip: l10n.waypoints_delete,
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => store.removeRoute(r.id),
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _waypointActions(BuildContext context, Waypoint w) async {
    final l10n = context.l10n;
    final action = await showModalBottomSheet<String>(
      context: context,
      builder: (sheet) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                w.name,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: w.note.isEmpty ? null : Text(w.note),
            ),
            ListTile(
              leading: const Icon(Icons.copy),
              title: Text(l10n.waypoints_copy),
              onTap: () => Navigator.pop(sheet, 'copy'),
            ),
            ListTile(
              leading: const Icon(Icons.send_outlined),
              title: Text(l10n.waypoints_sendToChannel),
              onTap: () => Navigator.pop(sheet, 'send'),
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: Text(l10n.waypoints_delete),
              onTap: () => Navigator.pop(sheet, 'delete'),
            ),
          ],
        ),
      ),
    );
    if (!context.mounted) return;
    switch (action) {
      case 'copy':
        await showCoordinateCopySheet(context, lat: w.lat, lon: w.lon);
      case 'send':
        await _send(context, w);
      case 'delete':
        await context.read<WaypointStore>().remove(w.id);
    }
  }

  Future<void> _send(BuildContext context, Waypoint w) async {
    final l10n = context.l10n;
    final radio = context.read<MeshCoreConnector>();
    final channel = await showModalBottomSheet<Channel>(
      context: context,
      builder: (sheet) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: Text(
                l10n.waypoints_pickChannel,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            for (final c in radio.channels)
              ListTile(
                leading: const Icon(Icons.tag),
                title: Text(c.name),
                onTap: () => Navigator.pop(sheet, c),
              ),
          ],
        ),
      ),
    );
    if (channel == null || !context.mounted) return;
    await radio.sendChannelMessage(channel, w.toMarkerText());
    if (context.mounted) {
      showDismissibleSnackBar(
        context,
        content: Text(l10n.waypoints_sent(channel.name)),
      );
    }
  }

  Future<void> _importFile(BuildContext context) async {
    try {
      final file = await openFile(
        acceptedTypeGroups: const [
          XTypeGroup(
            label: 'GPX',
            extensions: ['gpx'],
            uniformTypeIdentifiers: ['com.topografix.gpx', 'public.xml'],
          ),
        ],
      );
      if (file == null) return;
      final text = await file.readAsString();
      if (!context.mounted) return;
      await _import(context, text);
    } catch (e) {
      appLogger.warn('GPX file import failed: $e');
      if (context.mounted) {
        showDismissibleSnackBar(
          context,
          content: Text(context.l10n.waypoints_importFailed),
        );
      }
    }
  }

  Future<void> _importPaste(BuildContext context) async {
    final text = await showDialog<String>(
      context: context,
      builder: (_) => const _PasteGpxDialog(),
    );
    if (text == null || text.trim().isEmpty || !context.mounted) return;
    await _import(context, text);
  }

  Future<void> _import(BuildContext context, String xml) async {
    final l10n = context.l10n;
    final store = context.read<WaypointStore>();
    try {
      final parsed = parseGpx(xml);
      final added = await store.addImport(parsed);
      if (!context.mounted) return;
      showDismissibleSnackBar(
        context,
        content: Text(l10n.waypoints_imported(added.waypoints, added.routes)),
      );
    } on FormatException {
      if (context.mounted) {
        showDismissibleSnackBar(
          context,
          content: Text(l10n.waypoints_importFailed),
        );
      }
    }
  }

  Future<void> _export(BuildContext context) async {
    final store = context.read<WaypointStore>();
    final xml = toGpx(store.waypoints, store.routes);
    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile.fromData(
            utf8.encode(xml),
            mimeType: 'application/gpx+xml',
            name: 'notoryx-waypoints.gpx',
          ),
        ],
        fileNameOverrides: const ['notoryx-waypoints.gpx'],
      ),
    );
  }
}

/// Asks for GPX text. Owns its controller, so it outlives the closing
/// animation.
class _PasteGpxDialog extends StatefulWidget {
  const _PasteGpxDialog();

  @override
  State<_PasteGpxDialog> createState() => _PasteGpxDialogState();
}

class _PasteGpxDialogState extends State<_PasteGpxDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.waypoints_importPaste),
      content: TextField(
        key: const ValueKey('gpx-paste'),
        controller: _controller,
        minLines: 4,
        maxLines: 10,
        decoration: InputDecoration(hintText: l10n.waypoints_pasteHint),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.common_cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _controller.text),
          child: Text(l10n.waypoints_import),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
    child: Text(
      text,
      style: TextStyle(
        color: MeshPalette.ink3,
        fontWeight: FontWeight.w700,
        fontSize: 12,
      ),
    ),
  );
}

/// On a shared-marker message: saves the place to Waypoints.
class SaveWaypointButton extends StatelessWidget {
  const SaveWaypointButton({
    super.key,
    required this.label,
    required this.lat,
    required this.lon,
    required this.color,
  });

  final String label;
  final double lat;
  final double lon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return IconButton(
      tooltip: l10n.waypoints_save,
      icon: Icon(Icons.bookmark_add_outlined, color: color),
      onPressed: () async {
        WaypointStore store;
        try {
          store = context.read<WaypointStore>();
        } on ProviderNotFoundException {
          return;
        }
        final added = await store.add(
          Waypoint(
            id: 'mk-${DateTime.now().microsecondsSinceEpoch}',
            name: label.isEmpty ? l10n.waypoints_unnamed : label,
            lat: lat,
            lon: lon,
          ),
        );
        if (context.mounted) {
          showDismissibleSnackBar(
            context,
            content: Text(
              added ? l10n.waypoints_saved : l10n.waypoints_alreadySaved,
            ),
          );
        }
      },
    );
  }
}
