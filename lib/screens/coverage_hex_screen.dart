import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../models/coverage_hex.dart';
import '../services/coverage_hex_service.dart';
import '../theme/mesh_theme.dart';
import '../widgets/mesh_ui.dart';

String _privacyLabel(CoveragePrivacy p) => switch (p) {
  CoveragePrivacy.live => 'Live',
  CoveragePrivacy.delayed => 'Delayed 3 h',
  CoveragePrivacy.anonymous => 'Anonymous, 24 h',
};

String _privacyHint(CoveragePrivacy p) => switch (p) {
  CoveragePrivacy.live => 'Sent within about 15 minutes.',
  CoveragePrivacy.delayed =>
    'Held 3 hours so the map can’t show where you are now.',
  CoveragePrivacy.anonymous =>
    'Held 24 hours, dated by day only, and unsigned so uploads can’t be linked.',
};

/// Coverage mapping: credit what the radio hears to hexagons on the map and
/// share them with coverage maps.
class CoverageHexScreen extends StatelessWidget {
  const CoverageHexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = context.watch<CoverageHexService>();
    final fix = service.fix;
    final status =
        service.error ??
        (!service.mapping
            ? 'Off. Turn on while you drive or walk to map where your radio hears the mesh.'
            : fix == null
            ? 'Waiting for GPS…'
            : fix.accuracyMeters > maxFixAccuracyMeters
            ? 'GPS accuracy ${fix.accuracyMeters.round()} m: too rough, not recording.'
            : 'Recording. GPS accuracy ${fix.accuracyMeters.round()} m.');
    return Scaffold(
      appBar: AppBar(title: const Text('Coverage hexagons')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          MeshSpace.lg,
          MeshSpace.sm,
          MeshSpace.lg,
          MeshSpace.xxl,
        ),
        children: [
          MeshCard(
            margin: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Map coverage',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Switch(
                      key: const ValueKey('coverage-mapping'),
                      value: service.mapping,
                      onChanged: (v) => unawaited(service.setMapping(v)),
                    ),
                  ],
                ),
                const SizedBox(height: MeshSpace.xs),
                Text(status, style: TextStyle(color: MeshPalette.ink3)),
                const SizedBox(height: MeshSpace.md),
                Row(
                  children: [
                    Expanded(
                      child: MeshStat(
                        value: '${service.cells.length}',
                        label: 'Hexagons',
                      ),
                    ),
                    Expanded(
                      child: MeshStat(
                        value: '${service.sampleCount}',
                        label: 'Samples',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: MeshSpace.md),
                Text(
                  'Uses the phone’s GPS while this screen’s switch is on. '
                  'Only hexagon IDs (about 0.9 km across) are shared, never '
                  'your exact position.',
                  style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
                ),
              ],
            ),
          ),
          if (service.cells.isNotEmpty || fix != null) ...[
            const SizedBox(height: MeshSpace.md),
            _HexMap(service: service),
          ],
          const SectionHeader(
            'Upload to coverage maps',
            padding: EdgeInsets.fromLTRB(
              MeshSpace.xs,
              MeshSpace.xl,
              MeshSpace.xs,
              MeshSpace.sm,
            ),
          ),
          MeshGroup(
            children: [
              SwitchListTile(
                title: const Text('Upload on Wi-Fi only'),
                subtitle: const Text(
                  'Samples wait on the phone (up to 7 days) until Wi-Fi.',
                ),
                value: service.wifiOnly,
                onChanged: (v) => unawaited(service.setWifiOnly(v)),
              ),
              for (final t in service.targets)
                MeshNavRow(
                  icon: t.enabled
                      ? Icons.cloud_upload_outlined
                      : Icons.cloud_off_outlined,
                  title: t.name,
                  subtitle: [
                    _privacyLabel(t.privacy),
                    '${service.pendingFor(t)} waiting',
                    ?service.statusOf(t.id),
                  ].join(' · '),
                  onTap: () => _editTarget(context, service, t),
                ),
              MeshNavRow(
                icon: Icons.add_rounded,
                title: 'Add a coverage map',
                subtitle: 'Any HTTPS endpoint that accepts coverage uploads.',
                onTap: () => _editTarget(context, service, null),
              ),
            ],
          ),
          if (service.targets.isNotEmpty) ...[
            const SizedBox(height: MeshSpace.md),
            OutlinedButton.icon(
              onPressed: () => unawaited(service.upload()),
              icon: const Icon(Icons.upload_rounded),
              label: const Text('Upload now'),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _editTarget(
    BuildContext context,
    CoverageHexService service,
    CoverageTarget? existing,
  ) async {
    final result = await showDialog<_TargetEdit>(
      context: context,
      builder: (_) => _TargetDialog(existing: existing),
    );
    if (result == null) return;
    if (result.delete && existing != null) {
      await service.removeTarget(existing.id);
    } else if (result.target != null) {
      await service.saveTarget(result.target!);
    }
  }
}

class _HexMap extends StatelessWidget {
  const _HexMap({required this.service});

  final CoverageHexService service;

  @override
  Widget build(BuildContext context) {
    final cells = service.cells;
    final fix = service.fix;
    final center = fix != null
        ? LatLng(fix.lat, fix.lon)
        : () {
            final c = service.indexer.centerOf(cells.keys.first);
            return LatLng(c.lat, c.lon);
          }();
    return ClipRRect(
      borderRadius: BorderRadius.circular(MeshRadii.lg),
      child: SizedBox(
        height: 320,
        child: FlutterMap(
          options: MapOptions(initialCenter: center, initialZoom: 12),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.bastionmesh.bastion',
            ),
            PolygonLayer(
              polygons: [
                for (final e in cells.entries)
                  Polygon(
                    points: [
                      for (final p in service.indexer.boundaryOf(e.key))
                        LatLng(p.lat, p.lon),
                    ],
                    color: MeshTheme.snrColor(
                      e.value,
                      blocked: false,
                    ).withValues(alpha: 0.35),
                    borderColor: MeshTheme.snrColor(e.value, blocked: false),
                    borderStrokeWidth: 1,
                  ),
              ],
            ),
            if (fix != null)
              CircleLayer(
                circles: [
                  CircleMarker(
                    point: LatLng(fix.lat, fix.lon),
                    radius: 6,
                    color: MeshPalette.accent,
                    borderColor: Colors.white,
                    borderStrokeWidth: 2,
                  ),
                ],
              ),
            const SimpleAttributionWidget(source: Text('OpenStreetMap')),
          ],
        ),
      ),
    );
  }
}

class _TargetEdit {
  final CoverageTarget? target;
  final bool delete;
  const _TargetEdit({this.target, this.delete = false});
}

class _TargetDialog extends StatefulWidget {
  const _TargetDialog({this.existing});

  final CoverageTarget? existing;

  @override
  State<_TargetDialog> createState() => _TargetDialogState();
}

class _TargetDialogState extends State<_TargetDialog> {
  late final _name = TextEditingController(text: widget.existing?.name);
  late final _url = TextEditingController(text: widget.existing?.url);
  late final _key = TextEditingController(text: widget.existing?.apiKey);
  late var _format = widget.existing?.format ?? CoverageFormat.hexagons;
  late var _privacy = widget.existing?.privacy ?? CoveragePrivacy.delayed;
  late var _enabled = widget.existing?.enabled ?? true;
  bool _tried = false;

  @override
  void dispose() {
    _name.dispose();
    _url.dispose();
    _key.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final urlOk = CoverageTarget.isValidUrl(_url.text);
    final nameOk = _name.text.trim().isNotEmpty;
    return AlertDialog(
      title: Text(
        widget.existing == null ? 'Add a coverage map' : 'Coverage map',
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _name,
              decoration: InputDecoration(
                labelText: 'Name',
                errorText: _tried && !nameOk ? 'Give it a name.' : null,
              ),
              onChanged: (_) => setState(() {}),
            ),
            TextField(
              controller: _url,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                labelText: 'Upload URL',
                hintText: 'https://',
                errorText: _tried && !urlOk ? 'Must be an https:// URL.' : null,
              ),
              onChanged: (_) => setState(() {}),
            ),
            TextField(
              controller: _key,
              decoration: const InputDecoration(
                labelText: 'API key (optional)',
                helperText: 'Sent as X-API-Key.',
              ),
            ),
            const SizedBox(height: MeshSpace.md),
            DropdownButtonFormField<CoverageFormat>(
              isExpanded: true,
              initialValue: _format,
              decoration: const InputDecoration(labelText: 'Format'),
              items: const [
                DropdownMenuItem(
                  value: CoverageFormat.hexagons,
                  child: Text('Hexagon IDs (NOTORYX)'),
                ),
                DropdownMenuItem(
                  value: CoverageFormat.meshMapper,
                  child: Text('MeshMapper-compatible'),
                ),
              ],
              onChanged: (v) => setState(() => _format = v ?? _format),
            ),
            const SizedBox(height: MeshSpace.md),
            DropdownButtonFormField<CoveragePrivacy>(
              isExpanded: true,
              initialValue: _privacy,
              decoration: InputDecoration(
                labelText: 'Privacy',
                helperText: _privacyHint(_privacy),
                helperMaxLines: 3,
              ),
              items: [
                for (final p in CoveragePrivacy.values)
                  DropdownMenuItem(value: p, child: Text(_privacyLabel(p))),
              ],
              onChanged: (v) => setState(() => _privacy = v ?? _privacy),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Uploads on'),
              value: _enabled,
              onChanged: (v) => setState(() => _enabled = v),
            ),
          ],
        ),
      ),
      actions: [
        if (widget.existing != null)
          TextButton(
            onPressed: () =>
                Navigator.pop(context, const _TargetEdit(delete: true)),
            child: Text('Remove', style: TextStyle(color: MeshPalette.alert)),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (!urlOk || !nameOk) {
              setState(() => _tried = true);
              return;
            }
            Navigator.pop(
              context,
              _TargetEdit(
                target: CoverageTarget(
                  id: widget.existing?.id ?? CoverageHexService.newTargetId(),
                  name: _name.text.trim(),
                  url: _url.text.trim(),
                  apiKey: _key.text.trim(),
                  format: _format,
                  privacy: _privacy,
                  enabled: _enabled,
                ),
              ),
            );
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
