import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/coverage_hex.dart';
import '../models/signed_coverage.dart';
import '../services/coverage_hex_service.dart';
import '../theme/mesh_theme.dart';
import '../widgets/mesh_ui.dart';
import '../widgets/ember_backdrop.dart';

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
    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: Text(t.coverageHex_title),
        ),
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
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
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
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: MeshPalette.ink3),
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
                if (!service.targets.any((t) => t.isNotoryxMap))
                  MeshNavRow(
                    key: const ValueKey('coverage-notoryx-share'),
                    icon: Icons.public_rounded,
                    title: t.coverageHex_notoryxShare,
                    subtitle: t.coverageHex_notoryxShareHint,
                    onTap: () => _notoryxMap(context, service, null),
                  ),
                SwitchListTile(
                  title: Text(t.coverageHex_wifiOnly),
                  subtitle: Text(t.coverageHex_wifiOnlyHint),
                  value: service.wifiOnly,
                  onChanged: (v) => unawaited(service.setWifiOnly(v)),
                ),
                SwitchListTile(
                  key: const ValueKey('coverage-trim-drives'),
                  title: Text(t.coverageHex_trimDrives),
                  subtitle: Text(t.coverageHex_trimDrivesHint),
                  value: service.trimDrives,
                  onChanged: (v) => unawaited(service.setTrimDrives(v)),
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
                    onTap: () => t.isNotoryxMap
                        ? _notoryxMap(context, service, t)
                        : _editTarget(context, service, t),
                  ),
                MeshNavRow(
                  icon: Icons.add_rounded,
                  title: t.coverageHex_addMap,
                  subtitle: t.coverageHex_addMapHint,
                  onTap: () => _editTarget(context, service, null),
                ),
                MeshNavRow(
                  icon: Icons.map_outlined,
                  title: t.coverageHex_openMap,
                  subtitle: 'coverage.meshmayhem.org',
                  onTap: () => unawaited(
                    launchUrl(
                      Uri.parse(notoryxCoverageSite),
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
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
            SignedCoverageSection(service: service),
          ],
        ),
      ),
    );
  }

  /// Join, change or leave the NOTORYX coverage map. Joining always shows
  /// what is sent first; nothing is uploaded until the user agrees.
  Future<void> _notoryxMap(
    BuildContext context,
    CoverageHexService service,
    CoverageTarget? existing,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final t = context.l10n;
    final result = await showDialog<_NotoryxChoice>(
      context: context,
      builder: (_) =>
          _NotoryxMapDialog(existing: existing, mapperName: service.mapperName),
    );
    if (result == null) return;
    switch (result.action) {
      case _NotoryxAction.share:
        await service.setMapperName(result.name);
        await service.saveTarget(
          (existing ?? CoverageTarget.notoryxMap()).copyWith(
            privacy: result.privacy,
            enabled: true,
          ),
        );
      case _NotoryxAction.stop:
        await service.removeTarget(notoryxCoverageTargetId);
      case _NotoryxAction.erase:
        if (!context.mounted) return;
        final sure = await showDialog<bool>(
          context: context,
          builder: (dialog) => AlertDialog(
            title: Text(t.coverageHex_eraseUploads),
            content: Text(t.coverageHex_eraseConfirm),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialog, false),
                child: Text(t.common_cancel),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: MeshPalette.alert,
                ),
                onPressed: () => Navigator.pop(dialog, true),
                child: Text(t.coverageHex_eraseUploads),
              ),
            ],
          ),
        );
        if (sure != true) return;
        final erased = await service.eraseNotoryxUploads();
        messenger.showSnackBar(
          SnackBar(
            content: Text(
              erased == null
                  ? t.coverageHex_eraseFailed
                  : t.coverageHex_erased('$erased'),
            ),
          ),
        );
    }
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
              userAgentPackageName: 'com.bastionmesh.ham',
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

enum _NotoryxAction { share, stop, erase }

class _NotoryxChoice {
  final _NotoryxAction action;
  final CoveragePrivacy privacy;
  final String name;
  const _NotoryxChoice(
    this.action, {
    this.privacy = CoveragePrivacy.delayed,
    this.name = '',
  });
}

/// What the NOTORYX coverage map gets, the privacy level and an optional
/// mapper name. Shown before the first upload, and to change or leave.
class _NotoryxMapDialog extends StatefulWidget {
  const _NotoryxMapDialog({this.existing, required this.mapperName});

  final CoverageTarget? existing;
  final String mapperName;

  @override
  State<_NotoryxMapDialog> createState() => _NotoryxMapDialogState();
}

class _NotoryxMapDialogState extends State<_NotoryxMapDialog> {
  late final _name = TextEditingController(text: widget.mapperName);
  late var _privacy = widget.existing?.privacy ?? CoveragePrivacy.delayed;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final joined = widget.existing != null;
    return AlertDialog(
      title: Text(t.coverageHex_notoryxTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.coverageHex_notoryxConsent),
            const SizedBox(height: MeshSpace.md),
            DropdownButtonFormField<CoveragePrivacy>(
              isExpanded: true,
              initialValue: _privacy,
              decoration: InputDecoration(
                labelText: t.coverageHex_privacy,
                helperText: _privacy == CoveragePrivacy.anonymous
                    ? '${_privacyHint(t, _privacy)} '
                          '${t.coverageHex_notoryxAnonymousNote}'
                    : _privacyHint(t, _privacy),
                helperMaxLines: 4,
              ),
              items: [
                for (final p in CoveragePrivacy.values)
                  DropdownMenuItem(value: p, child: Text(_privacyLabel(t, p))),
              ],
              onChanged: (v) => setState(() => _privacy = v ?? _privacy),
            ),
            if (_privacy != CoveragePrivacy.anonymous)
              TextField(
                controller: _name,
                maxLength: 32,
                decoration: InputDecoration(
                  labelText: t.coverageHex_mapperName,
                  helperText: t.coverageHex_mapperNameHint,
                  helperMaxLines: 2,
                ),
              ),
            if (joined) ...[
              const SizedBox(height: MeshSpace.sm),
              TextButton.icon(
                key: const ValueKey('coverage-notoryx-erase'),
                onPressed: () => Navigator.pop(
                  context,
                  const _NotoryxChoice(_NotoryxAction.erase),
                ),
                icon: Icon(
                  Icons.delete_forever_outlined,
                  color: MeshPalette.alert,
                ),
                label: Text(
                  t.coverageHex_eraseUploads,
                  style: TextStyle(color: MeshPalette.alert),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        if (joined)
          TextButton(
            onPressed: () => Navigator.pop(
              context,
              const _NotoryxChoice(_NotoryxAction.stop),
            ),
            child: Text(t.coverageHex_stopSharing),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(joined ? t.common_cancel : t.coverageHex_notNow),
        ),
        FilledButton(
          key: const ValueKey('coverage-notoryx-confirm'),
          onPressed: () => Navigator.pop(
            context,
            _NotoryxChoice(
              _NotoryxAction.share,
              privacy: _privacy,
              name: _privacy == CoveragePrivacy.anonymous ? '' : _name.text,
            ),
          ),
          child: Text(joined ? t.common_save : t.coverageHex_shareAction),
        ),
      ],
    );
  }
}

/// Share this phone's coverage as a signed report, or check one someone
/// else shared. Everything stays local until the user shares it.
class SignedCoverageSection extends StatefulWidget {
  const SignedCoverageSection({super.key, required this.service});

  final CoverageHexService service;

  @override
  State<SignedCoverageSection> createState() => _SignedCoverageSectionState();
}

class _SignedCoverageSectionState extends State<SignedCoverageSection> {
  String? _key;

  @override
  void initState() {
    super.initState();
    unawaited(
      widget.service.signerKey().then((k) {
        if (mounted) setState(() => _key = k);
      }),
    );
  }

  Future<void> _share() async {
    final t = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    if (widget.service.sampleCount == 0) {
      messenger.showSnackBar(SnackBar(content: Text(t.signedCov_empty)));
      return;
    }
    try {
      final report = await widget.service.signedReport();
      await SharePlus.instance.share(
        ShareParams(
          files: [
            XFile.fromData(
              utf8.encode(report),
              mimeType: 'application/json',
              name: 'coverage-report.json',
            ),
          ],
        ),
      );
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(t.signedCov_shareFailed)));
    }
  }

  Future<void> _check() async {
    await showDialog<void>(
      context: context,
      builder: (_) => const SignedCoverageCheckDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final key = _key;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          t.signedCov_section,
          padding: const EdgeInsets.fromLTRB(
            MeshSpace.xs,
            MeshSpace.xl,
            MeshSpace.xs,
            MeshSpace.sm,
          ),
        ),
        MeshGroup(
          children: [
            MeshNavRow(
              icon: Icons.verified_outlined,
              title: t.signedCov_share,
              subtitle: t.signedCov_shareHint,
              onTap: () => unawaited(_share()),
            ),
            MeshNavRow(
              icon: Icons.fact_check_outlined,
              title: t.signedCov_check,
              subtitle: t.signedCov_checkHint,
              onTap: () => unawaited(_check()),
            ),
          ],
        ),
        if (key != null)
          Padding(
            padding: const EdgeInsets.all(MeshSpace.sm),
            child: SelectableText(
              t.signedCov_yourKey(keyFingerprint(key)),
              style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
            ),
          ),
      ],
    );
  }
}

/// Paste a signed report and see what verifies.
class SignedCoverageCheckDialog extends StatefulWidget {
  const SignedCoverageCheckDialog({super.key});

  @override
  State<SignedCoverageCheckDialog> createState() =>
      _SignedCoverageCheckDialogState();
}

class _SignedCoverageCheckDialogState extends State<SignedCoverageCheckDialog> {
  final _text = TextEditingController();
  CoverageVerdict? _verdict;
  bool _checking = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _verify() async {
    setState(() => _checking = true);
    final verdict = await verifyCoverageReport(_text.text.trim());
    if (!mounted) return;
    setState(() {
      _verdict = verdict;
      _checking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final v = _verdict;
    return AlertDialog(
      title: Text(t.signedCov_check),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _text,
              minLines: 3,
              maxLines: 8,
              decoration: InputDecoration(labelText: t.signedCov_paste),
            ),
            const SizedBox(height: MeshSpace.md),
            if (v != null)
              Semantics(
                liveRegion: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (v.unreadable)
                      Text(t.signedCov_unreadable)
                    else ...[
                      Text(
                        t.signedCov_result(v.accepted.length, v.rejectedCount),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      if (v.signer != null)
                        Text(t.signedCov_signer(keyFingerprint(v.signer!))),
                      for (final e in v.rejected.entries)
                        Text('• ${_rejectionText(t, e.key, e.value)}'),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(t.common_close),
        ),
        FilledButton(
          onPressed: _checking ? null : () => unawaited(_verify()),
          child: Text(t.signedCov_verify),
        ),
      ],
    );
  }
}

String _rejectionText(AppLocalizations t, CoverageRejection r, int n) =>
    switch (r) {
      CoverageRejection.badSignature => t.signedCov_rBadSignature(n),
      CoverageRejection.malformed => t.signedCov_rMalformed(n),
      CoverageRejection.impossible => t.signedCov_rImpossible(n),
      CoverageRejection.future => t.signedCov_rFuture(n),
    };
