import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../services/rx_log_service.dart';
import '../theme/mesh_theme.dart';
import '../widgets/ember_backdrop.dart';
import '../widgets/instrument.dart';
import '../widgets/mesh_ui.dart';

String rxKindLabel(AppLocalizations l10n, RxKind kind) => switch (kind) {
  RxKind.advert => l10n.rxLog_kindAdvert,
  RxKind.channel => l10n.rxLog_kindChannel,
  RxKind.direct => l10n.rxLog_kindDirect,
  RxKind.ack => l10n.rxLog_kindAck,
  RxKind.path => l10n.rxLog_kindPath,
  RxKind.trace => l10n.rxLog_kindTrace,
  RxKind.control => l10n.rxLog_kindControl,
  RxKind.other => l10n.rxLog_kindOther,
};

IconData _kindIcon(RxKind kind) => switch (kind) {
  RxKind.advert => Icons.campaign_outlined,
  RxKind.channel => Icons.forum_outlined,
  RxKind.direct => Icons.mail_outline,
  RxKind.ack => Icons.done_all,
  RxKind.path => Icons.alt_route,
  RxKind.trace => Icons.timeline,
  RxKind.control => Icons.radar,
  RxKind.other => Icons.help_outline,
};

/// Every packet the radio hears, live: kind, route, hops and signal, with a
/// filter, pause, and CSV export. Tap a packet for its path and raw bytes.
class RxLogScreen extends StatefulWidget {
  const RxLogScreen({super.key});

  @override
  State<RxLogScreen> createState() => _RxLogScreenState();
}

class _RxLogScreenState extends State<RxLogScreen> {
  RxKind? _kind;

  Future<void> _export(List<RxLogEntry> entries) async {
    final subject = context.l10n.rxLog_title;
    final dir = await getTemporaryDirectory();
    final stamp = DateTime.now().toUtc().toIso8601String().replaceAll(
      RegExp(r'[:.]'),
      '-',
    );
    final file = File('${dir.path}/notoryx-rx-log-$stamp.csv');
    await file.writeAsString(rxLogCsv(entries));
    await SharePlus.instance.share(
      ShareParams(subject: subject, files: [XFile(file.path)]),
    );
  }

  Future<void> _clear(RxLogService log) async {
    final l10n = context.l10n;
    final ok = await showDialog<bool>(
      context: context,
      builder: (d) => AlertDialog(
        content: Text(l10n.rxLog_clearConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(d, false),
            child: Text(l10n.common_cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(d, true),
            child: Text(l10n.common_clear),
          ),
        ],
      ),
    );
    if (ok == true) log.clear();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final log = context.watch<RxLogService>();
    final all = log.entries;
    final shown = _kind == null
        ? all
        : all.where((e) => e.kind == _kind).toList();
    final counts = <RxKind, int>{};
    for (final e in all) {
      counts.update(e.kind, (n) => n + 1, ifAbsent: () => 1);
    }

    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: Text(l10n.rxLog_title),
          actions: [
            IconButton(
              key: const ValueKey('rx-log-pause'),
              tooltip: log.paused ? l10n.rxLog_resume : l10n.rxLog_pause,
              icon: Icon(log.paused ? Icons.play_arrow : Icons.pause),
              onPressed: () => log.paused = !log.paused,
            ),
            IconButton(
              key: const ValueKey('rx-log-export'),
              tooltip: l10n.rxLog_export,
              icon: const Icon(Icons.ios_share),
              onPressed: shown.isEmpty ? null : () => _export(shown),
            ),
            IconButton(
              key: const ValueKey('rx-log-clear'),
              tooltip: l10n.common_clear,
              icon: const Icon(Icons.delete_sweep_outlined),
              onPressed: all.isEmpty ? null : () => _clear(log),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: MeshSpace.lg),
                children: [
                  _KindChip(
                    label: '${l10n.rxLog_kindAll} · ${all.length}',
                    selected: _kind == null,
                    onSelected: () => setState(() => _kind = null),
                  ),
                  for (final kind in RxKind.values)
                    if (counts[kind] case final n?)
                      _KindChip(
                        key: ValueKey('rx-kind-${kind.name}'),
                        label: '${rxKindLabel(l10n, kind)} · $n',
                        selected: _kind == kind,
                        onSelected: () =>
                            setState(() => _kind = _kind == kind ? null : kind),
                      ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                MeshSpace.lg,
                0,
                MeshSpace.lg,
                MeshSpace.sm,
              ),
              child: Text(
                log.paused
                    ? l10n.rxLog_paused
                    : l10n.rxLog_count(shown.length, log.total),
                key: const ValueKey('rx-log-status'),
                style: TextStyle(
                  color: log.paused ? MeshPalette.warn : MeshPalette.ink3,
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(
              child: shown.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(MeshSpace.lg),
                      child: MeshCard(
                        margin: EdgeInsets.zero,
                        child: Text(
                          '${l10n.rxLog_empty}\n\n${l10n.rxLog_note}',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: MeshPalette.ink2),
                        ),
                      ),
                    )
                  : ListView.builder(
                      key: const ValueKey('rx-log-list'),
                      padding: const EdgeInsets.fromLTRB(
                        MeshSpace.lg,
                        0,
                        MeshSpace.lg,
                        MeshSpace.xxl,
                      ),
                      itemCount: shown.length,
                      itemBuilder: (context, i) => _PacketRow(
                        entry: shown[i],
                        onTap: () => showRxPacketSheet(context, shown[i]),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KindChip extends StatelessWidget {
  const _KindChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.only(end: MeshSpace.sm),
    child: ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
    ),
  );
}

String _hopsText(AppLocalizations l10n, RxLogEntry e) =>
    e.hops == 0 ? l10n.rxLog_heardDirectly : l10n.rxLog_hops(e.hops);

class _PacketRow extends StatelessWidget {
  const _PacketRow({required this.entry, required this.onTap});
  final RxLogEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final time = DateFormat.Hms(
      Localizations.localeOf(context).toLanguageTag(),
    ).format(entry.receivedAt);
    final route = entry.isDirect
        ? l10n.rxLog_routeDirect
        : l10n.rxLog_routeFlood;
    final parts = [
      route,
      _hopsText(l10n, entry),
      l10n.rxLog_bytes(entry.raw.length),
      if (entry.fromSelf) l10n.rxLog_own,
    ];
    return Semantics(
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Icon(_kindIcon(entry.kind), size: 20, color: MeshPalette.ink2),
              const SizedBox(width: MeshSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rxKindLabel(l10n, entry.kind),
                      style: TextStyle(
                        color: MeshPalette.ink,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      parts.join(' · '),
                      style: TextStyle(color: MeshPalette.ink3, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    time,
                    style: MeshTheme.mono(
                      color: MeshPalette.ink2,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    l10n.rxLog_signal(entry.snr.toStringAsFixed(1), entry.rssi),
                    style: MeshTheme.mono(
                      color: MeshPalette.ink3,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A packet's decoded header, path and raw bytes, with copy.
Future<void> showRxPacketSheet(BuildContext context, RxLogEntry e) {
  final l10n = context.l10n;
  final hex = RxLogEntry.hex(e.raw);
  final path = e.pathHashes;
  return showMeshSheet<void>(
    context,
    builder: (sheet) => SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(sheet).height * 0.85,
        ),
        child: Column(
          key: const ValueKey('rx-packet-sheet'),
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BottomSheetHeader(
              title: rxKindLabel(l10n, e.kind),
              subtitle: DateFormat.yMd(
                Localizations.localeOf(sheet).toLanguageTag(),
              ).add_Hms().format(e.receivedAt),
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: MeshSpace.lg),
                children: [
                  InstrumentRow(
                    icon: Icons.alt_route,
                    title: l10n.rxLog_route,
                    trailing: Text(
                      e.isDirect
                          ? l10n.rxLog_routeDirect
                          : l10n.rxLog_routeFlood,
                    ),
                  ),
                  InstrumentRow(
                    icon: Icons.share_outlined,
                    title: l10n.rxLog_path,
                    subtitle: path.isEmpty
                        ? l10n.rxLog_heardDirectly
                        : path.join(' → '),
                    trailing: Text(_hopsText(l10n, e)),
                  ),
                  InstrumentRow(
                    icon: Icons.network_cell,
                    title: l10n.rxLog_signalTitle,
                    trailing: Text(
                      l10n.rxLog_signal(e.snr.toStringAsFixed(1), e.rssi),
                    ),
                  ),
                  InstrumentRow(
                    icon: Icons.category_outlined,
                    title: l10n.rxLog_payloadType,
                    trailing: Text(
                      '0x${e.info.payloadType.toRadixString(16).padLeft(2, '0').toUpperCase()}',
                    ),
                  ),
                  InstrumentRow(
                    icon: Icons.tag,
                    title: l10n.rxLog_hash,
                    subtitle: e.info.hash,
                  ),
                  InstrumentRow(
                    icon: Icons.data_object,
                    title: l10n.rxLog_raw,
                    subtitle: l10n.rxLog_bytes(e.raw.length),
                    divider: false,
                  ),
                  SelectableText(
                    hex
                        .replaceAllMapped(RegExp('..'), (m) => '${m[0]} ')
                        .trimRight(),
                    key: const ValueKey('rx-packet-hex'),
                    style: MeshTheme.mono(color: MeshPalette.ink, fontSize: 12),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(MeshSpace.lg),
              child: InstrumentButton(
                key: const ValueKey('rx-packet-copy'),
                label: l10n.rxLog_copyHex,
                icon: Icons.copy,
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: hex));
                  Navigator.pop(sheet);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(l10n.keyGen_copied)));
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
