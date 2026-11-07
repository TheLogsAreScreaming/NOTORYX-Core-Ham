import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/l10n.dart';
import '../models/network_scan.dart';
import '../models/radio_settings.dart';
import '../services/network_scan_service.dart';
import '../theme/mesh_theme.dart';
import '../widgets/ember_backdrop.dart';
import '../widgets/instrument.dart';
import '../widgets/mesh_ui.dart';
import '../widgets/ui/mesh_states.dart';
import '../helpers/snack_bar_builder.dart';

/// Networks: scan for MeshCore networks nearby, keep a log of where each
/// was heard, save networks and join one.
class NetworksScreen extends StatefulWidget {
  const NetworksScreen({super.key});

  @override
  State<NetworksScreen> createState() => _NetworksScreenState();
}

class _NetworksScreenState extends State<NetworksScreen> {
  int _dwell = 45;
  ScanMode _mode = ScanMode.quick;
  Set<String>? _chosen;
  Timer? _tick;

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }

  String? get _country =>
      WidgetsBinding.instance.platformDispatcher.locale.countryCode;

  /// "about 45 s" or "about 3 min".
  String _about(Duration d) {
    final l10n = context.l10n;
    final secs = d.inSeconds;
    return l10n.networks_estimate(
      secs < 90 ? '$secs s' : '${(secs / 60).round()} min',
    );
  }

  List<ScanTarget> _targets(NetworkScanService s) {
    final chosen = _chosen;
    if (chosen == null) return s.suggestedTargets(countryCode: _country);
    return [
      for (final t in s.allTargets())
        if (chosen.contains(t.signature)) t,
    ];
  }

  String _when(BuildContext context, DateTime at) {
    final local = at.toLocal();
    final m = MaterialLocalizations.of(context);
    return '${m.formatShortDate(local)} ${m.formatTimeOfDay(TimeOfDay.fromDateTime(local))}';
  }

  String? _blockText(ScanBlock b) {
    final l10n = context.l10n;
    return switch (b) {
      ScanBlock.none => null,
      ScanBlock.noRadio => l10n.networks_blockNoRadio,
      ScanBlock.noSettings => l10n.networks_blockSettings,
      ScanBlock.sos => l10n.networks_blockSos,
      ScanBlock.trip => l10n.networks_blockTrip,
    };
  }

  Future<void> _start(NetworkScanService s) async {
    _tick?.cancel();
    _tick = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
    await s.scan(
      _targets(s),
      mode: _mode,
      dwell: Duration(seconds: _dwell),
    );
    _tick?.cancel();
    if (mounted) setState(() {});
  }

  Future<void> _pickTargets(NetworkScanService s) async {
    final l10n = context.l10n;
    final suggested = {
      for (final t in s.suggestedTargets(countryCode: _country)) t.signature,
    };
    final all = s.allTargets()
      ..sort(
        (a, b) => (suggested.contains(b.signature) ? 1 : 0).compareTo(
          suggested.contains(a.signature) ? 1 : 0,
        ),
      );
    final own = s.yourNetwork;
    final picked = {..._chosen ?? suggested};
    final result = await showMeshSheet<Set<String>>(
      context,
      builder: (sheet) => StatefulBuilder(
        builder: (sheet, setSheet) => SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(sheet).height * 0.8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BottomSheetHeader(title: l10n.networks_choose(picked.length)),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (final t in all)
                        if (own == null || !t.sameSettings(own))
                          CheckboxListTile(
                            key: ValueKey('scan-target-${t.signature}'),
                            value: picked.contains(t.signature),
                            title: Text(t.name),
                            subtitle: Text(t.summary),
                            onChanged: (v) => setSheet(() {
                              if (v == true) {
                                picked.add(t.signature);
                              } else {
                                picked.remove(t.signature);
                              }
                            }),
                          ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(MeshSpace.lg),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () => setSheet(() {
                          picked
                            ..clear()
                            ..addAll(suggested);
                        }),
                        child: Text(l10n.networks_suggested),
                      ),
                      const Spacer(),
                      FilledButton(
                        onPressed: () => Navigator.pop(sheet, picked),
                        child: Text(l10n.common_done),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (result != null && mounted) setState(() => _chosen = result);
  }

  Future<void> _join(NetworkScanService s, ScanTarget t) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final ok = await confirmAction(
      context,
      title: l10n.networks_join,
      message: l10n.networks_joinConfirm(t.name),
      confirmLabel: l10n.networks_join,
    );
    if (ok != true) return;
    try {
      await s.join(t);
      messenger.showSnackBar(
        meshSnackBar(content: Text(l10n.networks_joined(t.name))),
      );
    } catch (e) {
      messenger.showSnackBar(meshSnackBar(content: Text(friendlyError(e))));
    }
  }

  void _showNetwork(
    NetworkScanService s,
    ScanTarget t, {
    NetworkSighting? sighting,
  }) {
    final l10n = context.l10n;
    final own = s.yourNetwork;
    showMeshSheet<void>(
      context,
      builder: (sheet) => SafeArea(
        child: ListenableBuilder(
          listenable: s,
          builder: (sheet, _) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BottomSheetHeader(title: t.name, subtitle: t.summary),
              if (sighting != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: MeshSpace.lg),
                  child: Text(
                    '${l10n.networks_heardSummary(sighting.nodes.length, sighting.packets, sighting.bestSnr.toStringAsFixed(1))}\n'
                    '${l10n.networks_lastHeard(_when(context, sighting.at))} · '
                    '${l10n.networks_timesHeard(s.timesHeard(t))}',
                    style: TextStyle(color: MeshPalette.ink2),
                  ),
                ),
                if (sighting.nodes.isNotEmpty) ...[
                  InstrumentLabel(l10n.networks_nodesHeard),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 220),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (final n in sighting.nodes)
                          InstrumentRow(
                            icon: Icons.cell_tower,
                            title: n.name ?? n.key.toUpperCase(),
                            subtitle: n.key.toUpperCase(),
                            divider: false,
                          ),
                      ],
                    ),
                  ),
                ],
              ],
              Padding(
                padding: const EdgeInsets.all(MeshSpace.lg),
                child: Row(
                  children: [
                    Expanded(
                      child: s.isSaved(t)
                          ? InstrumentButton(
                              label: l10n.common_remove,
                              icon: Icons.bookmark_remove_outlined,
                              onPressed: () => unawaited(s.removeSaved(t)),
                            )
                          : InstrumentButton(
                              key: const ValueKey('network-save'),
                              label: l10n.common_save,
                              icon: Icons.bookmark_add_outlined,
                              onPressed: () => unawaited(s.saveNetwork(t)),
                            ),
                    ),
                    const SizedBox(width: MeshSpace.sm),
                    Expanded(
                      child: FilledButton.icon(
                        key: const ValueKey('network-join'),
                        onPressed:
                            own == null || t.sameSettings(own) || s.running
                            ? null
                            : () {
                                Navigator.pop(sheet);
                                unawaited(_join(s, t));
                              },
                        icon: const Icon(Icons.login),
                        label: Text(l10n.networks_join),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addNetwork(NetworkScanService s) async {
    final target = await showDialog<ScanTarget>(
      context: context,
      builder: (_) => const _AddNetworkDialog(),
    );
    if (target != null) await s.saveNetwork(target);
  }

  Future<void> _export(NetworkScanService s, {required bool gpx}) async {
    final text = gpx ? networkLogGpx(s.log) : networkLogCsv(s.log);
    final dir = await getTemporaryDirectory();
    final stamp = DateTime.now().toUtc().toIso8601String().replaceAll(
      RegExp(r'[:.]'),
      '-',
    );
    final file = File(
      '${dir.path}/notoryx-networks-$stamp.${gpx ? 'gpx' : 'csv'}',
    );
    await file.writeAsString(text);
    if (!mounted) return;
    await SharePlus.instance.share(
      ShareParams(
        subject: context.l10n.networks_log,
        files: [XFile(file.path)],
      ),
    );
  }

  Future<void> _clearLog(NetworkScanService s) async {
    final l10n = context.l10n;
    final ok = await confirmDestructive(
      context,
      message: l10n.networks_clearLogConfirm,
      confirmLabel: l10n.common_delete,
    );
    if (ok == true) await s.clearLog();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final s = context.watch<NetworkScanService>();
    final own = s.yourNetwork;
    final targets = _targets(s);
    final block = s.running ? null : _blockText(s.block);
    final stopped = s.running ? null : _blockText(s.stoppedBy);
    final nearby = s.latestByNetwork();
    final left = s.stepEndsAt?.difference(DateTime.now()).inSeconds;

    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: Text(l10n.networks_title),
        ),
        body: ListView(
          padding: const EdgeInsets.only(bottom: MeshSpace.xxl),
          children: [
            InstrumentLabel(l10n.networks_yourNetwork),
            MeshCard(
              child: Text(
                own?.summary ?? l10n.networks_blockSettings,
                key: const ValueKey('your-network'),
                style: MeshTheme.mono(color: MeshPalette.ink, fontSize: 14),
              ),
            ),
            InstrumentLabel(l10n.networks_scanTitle),
            MeshCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.networks_scanExplainer,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: MeshPalette.ink2),
                  ),
                  const SizedBox(height: MeshSpace.sm),
                  SegmentedButton<ScanMode>(
                    key: const ValueKey('scan-mode'),
                    showSelectedIcon: false,
                    segments: [
                      ButtonSegment(
                        value: ScanMode.quick,
                        icon: const Icon(Icons.bolt),
                        label: Text(l10n.networks_modeQuick),
                      ),
                      ButtonSegment(
                        value: ScanMode.thorough,
                        icon: const Icon(Icons.hearing),
                        label: Text(l10n.networks_modeThorough),
                      ),
                    ],
                    selected: {_mode},
                    onSelectionChanged: s.running
                        ? null
                        : (v) => setState(() => _mode = v.first),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _mode == ScanMode.quick
                        ? l10n.networks_modeQuickHint
                        : l10n.networks_modeThoroughHint,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: MeshPalette.ink3),
                  ),
                  if (_mode == ScanMode.thorough) ...[
                    const SizedBox(height: MeshSpace.sm),
                    Text(
                      l10n.networks_listenFor,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: MeshPalette.ink3),
                    ),
                    const SizedBox(height: 4),
                    SegmentedButton<int>(
                      showSelectedIcon: false,
                      segments: [
                        for (final d in NetworkScanService.dwells)
                          ButtonSegment(value: d, label: Text('${d}s')),
                      ],
                      selected: {_dwell},
                      onSelectionChanged: s.running
                          ? null
                          : (v) => setState(() => _dwell = v.first),
                    ),
                  ],
                  InstrumentRow(
                    key: const ValueKey('scan-targets'),
                    icon: Icons.tune,
                    title:
                        '${l10n.networks_choose(targets.length)} · '
                        '${_about(s.estimate(targets.length, _mode, Duration(seconds: _dwell)))}',
                    subtitle: targets.map((t) => t.name).take(4).join(', '),
                    onTap: s.running ? null : () => _pickTargets(s),
                    divider: false,
                  ),
                  if (s.running) ...[
                    LinearProgressIndicator(
                      value: s.steps == 0 ? null : (s.step - 1) / s.steps,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${l10n.networks_listening(s.current?.name ?? '', s.step, s.steps)}'
                      '${left == null ? '' : ' · ${left < 0 ? 0 : left}s'}',
                      key: const ValueKey('scan-progress'),
                      style: TextStyle(color: MeshPalette.ink2),
                    ),
                    const SizedBox(height: MeshSpace.sm),
                  ],
                  if (block ?? stopped case final why?)
                    Padding(
                      padding: const EdgeInsets.only(bottom: MeshSpace.sm),
                      child: Text(
                        why,
                        style: TextStyle(color: MeshPalette.warn),
                      ),
                    ),
                  InstrumentButton(
                    key: const ValueKey('scan-toggle'),
                    label: s.running
                        ? l10n.networks_cancel
                        : l10n.networks_start,
                    icon: s.running ? Icons.stop_rounded : Icons.radar,
                    danger: s.running,
                    onPressed: s.running
                        ? s.cancel
                        : block != null || targets.isEmpty
                        ? null
                        : () => unawaited(_start(s)),
                  ),
                ],
              ),
            ),
            InstrumentLabel(l10n.networks_nearby),
            if (nearby.isEmpty)
              MeshCard(
                child: Text(
                  l10n.networks_nothingYet,
                  style: TextStyle(color: MeshPalette.ink3),
                ),
              )
            else
              for (final n in nearby)
                MeshCard(
                  key: ValueKey('nearby-${n.target.signature}'),
                  onTap: () => _showNetwork(s, n.target, sighting: n),
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings_input_antenna,
                        color: MeshPalette.accent,
                      ),
                      const SizedBox(width: MeshSpace.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              n.target.name,
                              style: TextStyle(
                                color: MeshPalette.ink,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              n.target.summary,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: MeshPalette.ink2),
                            ),
                            Text(
                              '${l10n.networks_heardSummary(n.nodes.length, n.packets, n.bestSnr.toStringAsFixed(1))} · '
                              '${l10n.networks_lastHeard(_when(context, n.at))}',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: MeshPalette.ink3),
                            ),
                          ],
                        ),
                      ),
                      if (own != null && n.target.sameSettings(own))
                        Icon(Icons.check_circle, color: MeshPalette.signal)
                      else
                        Icon(Icons.chevron_right, color: MeshPalette.ink3),
                    ],
                  ),
                ),
            InstrumentLabel(l10n.networks_saved),
            for (final t in s.saved)
              MeshCard(
                key: ValueKey('saved-${t.signature}'),
                onTap: () => _showNetwork(s, t),
                child: InstrumentRow(
                  icon: Icons.bookmark_outline,
                  title: t.name,
                  subtitle: t.summary,
                  divider: false,
                ),
              ),
            if (s.saved.isEmpty)
              MeshCard(
                child: Text(
                  l10n.networks_noSaved,
                  style: TextStyle(color: MeshPalette.ink3),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: MeshSpace.lg,
                vertical: MeshSpace.sm,
              ),
              child: InstrumentButton(
                key: const ValueKey('network-add'),
                label: l10n.networks_add,
                icon: Icons.add,
                onPressed: () => unawaited(_addNetwork(s)),
              ),
            ),
            InstrumentLabel(
              l10n.networks_log,
              trailing: s.log.isEmpty ? null : '${s.log.length}',
            ),
            if (s.log.isEmpty)
              MeshCard(
                child: Text(
                  l10n.networks_logEmpty,
                  style: TextStyle(color: MeshPalette.ink3),
                ),
              )
            else ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MeshSpace.lg),
                child: Wrap(
                  spacing: MeshSpace.sm,
                  runSpacing: MeshSpace.sm,
                  children: [
                    InstrumentButton(
                      key: const ValueKey('network-log-map'),
                      label: l10n.networks_showMap,
                      icon: Icons.map_outlined,
                      onPressed: s.log.any((e) => e.hasLocation)
                          ? () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => _NetworkLogMap(log: s.log),
                              ),
                            )
                          : null,
                    ),
                    InstrumentButton(
                      label: l10n.networks_exportCsv,
                      icon: Icons.table_chart_outlined,
                      onPressed: () => unawaited(_export(s, gpx: false)),
                    ),
                    InstrumentButton(
                      label: l10n.networks_exportGpx,
                      icon: Icons.route_outlined,
                      onPressed: () => unawaited(_export(s, gpx: true)),
                    ),
                    InstrumentButton(
                      label: l10n.networks_clearLog,
                      icon: Icons.delete_outline,
                      danger: true,
                      onPressed: s.running ? null : () => _clearLog(s),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: MeshSpace.sm),
              for (final e in s.log.take(50))
                MeshCard(
                  onTap: () => _showNetwork(s, e.target, sighting: e),
                  child: InstrumentRow(
                    icon: Icons.history,
                    title: e.target.name,
                    subtitle:
                        '${_when(context, e.at)} · '
                        '${l10n.networks_heardSummary(e.nodes.length, e.packets, e.bestSnr.toStringAsFixed(1))}',
                    divider: false,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Where each logged network was heard.
class _NetworkLogMap extends StatelessWidget {
  const _NetworkLogMap({required this.log});

  final List<NetworkSighting> log;

  @override
  Widget build(BuildContext context) {
    final located = log.where((s) => s.hasLocation).toList();
    final names = {for (final s in located) s.target.signature};
    final colors = {
      for (final (i, sig) in names.indexed)
        sig: OkabeIto.categorical[i % OkabeIto.categorical.length],
    };
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.networks_log)),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(
            located.first.latitude!,
            located.first.longitude!,
          ),
          initialZoom: 12,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.bastionmesh.ham',
          ),
          MarkerLayer(
            markers: [
              for (final s in located)
                Marker(
                  point: LatLng(s.latitude!, s.longitude!),
                  width: 22,
                  height: 22,
                  child: Tooltip(
                    message: '${s.target.name}\n${s.target.summary}',
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors[s.target.signature],
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Defines a network by hand. It owns its text fields, so they outlive the
/// dialog's closing animation.
class _AddNetworkDialog extends StatefulWidget {
  const _AddNetworkDialog();

  @override
  State<_AddNetworkDialog> createState() => _AddNetworkDialogState();
}

class _AddNetworkDialogState extends State<_AddNetworkDialog> {
  final name = TextEditingController();
  final freq = TextEditingController();
  var bw = LoRaBandwidth.bw250;
  var sf = LoRaSpreadingFactor.sf10;
  var cr = LoRaCodingRate.cr4_5;
  String? error;

  @override
  void dispose() {
    name.dispose();
    freq.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.networks_add),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              key: const ValueKey('network-name'),
              controller: name,
              decoration: InputDecoration(labelText: l10n.networks_name),
            ),
            TextField(
              key: const ValueKey('network-frequency'),
              controller: freq,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              decoration: InputDecoration(
                labelText: l10n.settings_frequency,
                suffixText: 'MHz',
              ),
            ),
            DropdownButtonFormField<LoRaBandwidth>(
              initialValue: bw,
              decoration: InputDecoration(labelText: l10n.settings_bandwidth),
              items: [
                for (final b in LoRaBandwidth.values)
                  DropdownMenuItem(value: b, child: Text(b.label)),
              ],
              onChanged: (v) => setState(() => bw = v ?? bw),
            ),
            DropdownButtonFormField<LoRaSpreadingFactor>(
              initialValue: sf,
              decoration: InputDecoration(
                labelText: l10n.settings_spreadingFactor,
              ),
              items: [
                for (final v in LoRaSpreadingFactor.values)
                  DropdownMenuItem(value: v, child: Text(v.label)),
              ],
              onChanged: (v) => setState(() => sf = v ?? sf),
            ),
            DropdownButtonFormField<LoRaCodingRate>(
              initialValue: cr,
              decoration: InputDecoration(labelText: l10n.settings_codingRate),
              items: [
                for (final v in LoRaCodingRate.values)
                  DropdownMenuItem(value: v, child: Text(v.label)),
              ],
              onChanged: (v) => setState(() => cr = v ?? cr),
            ),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: MeshSpace.sm),
                child: Text(error!, style: TextStyle(color: MeshPalette.alert)),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.common_cancel),
        ),
        FilledButton(
          key: const ValueKey('network-add-save'),
          onPressed: () {
            final mhz = double.tryParse(freq.text.trim());
            final t = ScanTarget(
              name: name.text.trim().isEmpty
                  ? (mhz?.toStringAsFixed(3) ?? '')
                  : name.text.trim(),
              freqKHz: ((mhz ?? 0) * 1000).round(),
              bwHz: bw.hz,
              sf: sf.value,
              cr: cr.value,
            );
            if (mhz == null || !t.isValid) {
              setState(() => error = l10n.networks_invalid);
              return;
            }
            Navigator.pop(context, t);
          },
          child: Text(l10n.common_save),
        ),
      ],
    );
  }
}
