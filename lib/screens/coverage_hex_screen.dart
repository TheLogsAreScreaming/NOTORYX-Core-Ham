import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/coverage_hex.dart';
import '../services/coverage_hex_service.dart';
import '../theme/mesh_theme.dart';
import '../widgets/mesh_ui.dart';

String _privacyLabel(AppLocalizations t, CoveragePrivacy p) => switch (p) {
  CoveragePrivacy.live => t.coverageHex_privacyLive,
  CoveragePrivacy.delayed => t.coverageHex_privacyDelayed,
  CoveragePrivacy.anonymous => t.coverageHex_privacyAnonymous,
};

String _privacyHint(AppLocalizations t, CoveragePrivacy p) => switch (p) {
  CoveragePrivacy.live => t.coverageHex_privacyLiveHint,
  CoveragePrivacy.delayed => t.coverageHex_privacyDelayedHint,
  CoveragePrivacy.anonymous => t.coverageHex_privacyAnonymousHint,
};

String _problemText(AppLocalizations t, CoverageProblem p) => switch (p) {
  CoverageProblem.noPermission => t.coverageHex_noPermission,
  CoverageProblem.noGps => t.coverageHex_noGps,
  CoverageProblem.loadFailed => t.coverageHex_loadFailed,
};

String? _uploadText(BuildContext context, CoverageUploadStatus? s) {
  final t = context.l10n;
  return switch (s) {
    null => null,
    CoverageUploadSent(:final cells, :final at) => t.coverageHex_sent(
      '$cells',
      TimeOfDay.fromDateTime(at.toLocal()).format(context),
    ),
    CoverageUploadRejected(:final statusCode) => t.coverageHex_httpError(
      '$statusCode',
    ),
    CoverageUploadUnreachable() => t.coverageHex_unreachable,
  };
}

/// Coverage mapping: credit what the radio hears to hexagons on the map and
/// share them with coverage maps.
class CoverageHexScreen extends StatelessWidget {
  const CoverageHexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = context.watch<CoverageHexService>();
    final t = context.l10n;
    final fix = service.fix;
    final problem = service.problem;
    final status = problem != null
        ? _problemText(t, problem)
        : !service.mapping
        ? t.coverageHex_statusOff
        : fix == null
        ? t.coverageHex_waitingGps
        : fix.accuracyMeters > maxFixAccuracyMeters
        ? t.coverageHex_gpsTooRough('${fix.accuracyMeters.round()}')
        : t.coverageHex_recording('${fix.accuracyMeters.round()}');
    return Scaffold(
      appBar: AppBar(title: Text(t.coverageHex_title)),
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
                    Expanded(
                      child: Text(
                        t.coverageHex_mapCoverage,
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
                        label: t.coverageHex_hexagons,
                      ),
                    ),
                    Expanded(
                      child: MeshStat(
                        value: '${service.sampleCount}',
                        label: t.coverageHex_samples,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: MeshSpace.md),
                Text(
                  t.coverageHex_privacyNote,
                  style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
                ),
              ],
            ),
          ),
          if (service.cells.isNotEmpty || fix != null) ...[
            const SizedBox(height: MeshSpace.md),
            _HexMap(service: service),
          ],
          SectionHeader(
            t.coverageHex_uploadSection,
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
                title: Text(t.coverageHex_wifiOnly),
                subtitle: Text(t.coverageHex_wifiOnlyHint),
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
                    _privacyLabel(context.l10n, t.privacy),
                    context.l10n.coverageHex_waiting(
                      '${service.pendingFor(t)}',
                    ),
                    ?_uploadText(context, service.statusOf(t.id)),
                  ].join(' · '),
                  onTap: () => _editTarget(context, service, t),
                ),
              MeshNavRow(
                icon: Icons.add_rounded,
                title: t.coverageHex_addMap,
                subtitle: t.coverageHex_addMapHint,
                onTap: () => _editTarget(context, service, null),
              ),
            ],
          ),
          if (service.targets.isNotEmpty) ...[
            const SizedBox(height: MeshSpace.md),
            OutlinedButton.icon(
              onPressed: () => unawaited(service.upload()),
              icon: const Icon(Icons.upload_rounded),
              label: Text(t.coverageHex_uploadNow),
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
    final t = context.l10n;
    final urlOk = CoverageTarget.isValidUrl(_url.text);
    final nameOk = _name.text.trim().isNotEmpty;
    return AlertDialog(
      title: Text(
        widget.existing == null
            ? t.coverageHex_addMap
            : t.coverageHex_mapDialogTitle,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _name,
              decoration: InputDecoration(
                labelText: t.settings_infoName,
                errorText: _tried && !nameOk ? t.coverageHex_nameMissing : null,
              ),
              onChanged: (_) => setState(() {}),
            ),
            TextField(
              controller: _url,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                labelText: t.coverageHex_url,
                hintText: 'https://',
                errorText: _tried && !urlOk ? t.coverageHex_urlInvalid : null,
              ),
              onChanged: (_) => setState(() {}),
            ),
            TextField(
              controller: _key,
              decoration: InputDecoration(
                labelText: t.coverageHex_apiKey,
                helperText: t.coverageHex_apiKeyHint,
              ),
            ),
            const SizedBox(height: MeshSpace.md),
            DropdownButtonFormField<CoverageFormat>(
              isExpanded: true,
              initialValue: _format,
              decoration: InputDecoration(labelText: t.coverageHex_format),
              items: [
                DropdownMenuItem(
                  value: CoverageFormat.hexagons,
                  child: Text(t.coverageHex_formatHex),
                ),
                DropdownMenuItem(
                  value: CoverageFormat.meshMapper,
                  child: Text(t.coverageHex_formatMeshMapper),
                ),
              ],
              onChanged: (v) => setState(() => _format = v ?? _format),
            ),
            const SizedBox(height: MeshSpace.md),
            DropdownButtonFormField<CoveragePrivacy>(
              isExpanded: true,
              initialValue: _privacy,
              decoration: InputDecoration(
                labelText: t.coverageHex_privacy,
                helperText: _privacyHint(t, _privacy),
                helperMaxLines: 3,
              ),
              items: [
                for (final p in CoveragePrivacy.values)
                  DropdownMenuItem(value: p, child: Text(_privacyLabel(t, p))),
              ],
              onChanged: (v) => setState(() => _privacy = v ?? _privacy),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(t.coverageHex_uploadsOn),
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
            child: Text(
              t.common_remove,
              style: TextStyle(color: MeshPalette.alert),
            ),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(t.common_cancel),
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
          child: Text(t.common_save),
        ),
      ],
    );
  }
}
