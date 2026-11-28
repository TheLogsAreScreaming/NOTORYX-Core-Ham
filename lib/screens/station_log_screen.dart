import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/l10n.dart';
import '../models/station_log.dart';
import '../services/operator_profile_service.dart';
import '../services/station_log_service.dart';
import '../widgets/mesh_ui.dart';
import '../widgets/ui/mesh_states.dart';

/// The station log: exchanges of direct messages with stations whose node
/// names start with a call sign, newest first, with ADIF and CSV export.
class StationLogScreen extends StatelessWidget {
  const StationLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final log = context.watch<StationLogService>();
    final entries = log.entries;
    final automated = log.automated;
    final loc = MaterialLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.ham_stationLog),
        actions: [
          if (entries.isNotEmpty || automated.isNotEmpty)
            PopupMenuButton<String>(
              key: const ValueKey('station-log-menu'),
              tooltip: l10n.ham_stationLogExport,
              icon: const Icon(Icons.ios_share),
              onSelected: (v) => switch (v) {
                'adif' => _export(context, entries, adif: true),
                'csv' => _export(context, entries, adif: false),
                'auto' => _exportAutomated(context, automated),
                _ => _clear(context, log),
              },
              itemBuilder: (_) => [
                if (entries.isNotEmpty) ...[
                  PopupMenuItem(
                    value: 'adif',
                    child: Text(l10n.ham_exportAdif),
                  ),
                  PopupMenuItem(value: 'csv', child: Text(l10n.ham_exportCsv)),
                ],
                if (automated.isNotEmpty)
                  PopupMenuItem(
                    value: 'auto',
                    child: Text(l10n.ham_exportAutomatedCsv),
                  ),
                PopupMenuItem(
                  value: 'clear',
                  child: Text(l10n.ham_stationLogClear),
                ),
              ],
            ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: entries.isEmpty && automated.isEmpty
            ? EmptyState(
                icon: Icons.menu_book_outlined,
                title: l10n.ham_stationLogEmpty,
                subtitle: l10n.ham_stationLogHint,
              )
            : ListView(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 24),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: Text(
                      l10n.ham_stationLogHint,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  MeshCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        for (final e in entries)
                          ListTile(
                            title: Text(e.call),
                            subtitle: Text(
                              [
                                '${loc.formatShortDate(e.start.toLocal())} '
                                    '${loc.formatTimeOfDay(TimeOfDay.fromDateTime(e.start.toLocal()))}',
                                ?e.band,
                                l10n.ham_stationLogCounts(e.sent, e.received),
                              ].join(' · '),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (automated.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                      child: Semantics(
                        header: true,
                        child: Text(
                          l10n.ham_automatedTx,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Text(
                        l10n.ham_automatedTxHint,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    MeshCard(
                      key: const ValueKey('station-log-automated'),
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          for (final a in automated)
                            ListTile(
                              leading: const ExcludeSemantics(
                                child: Icon(Icons.bolt_outlined),
                              ),
                              title: Text('${a.rule} → ${a.to}'),
                              subtitle: Text(
                                [
                                  '${loc.formatShortDate(a.at.toLocal())} '
                                      '${loc.formatTimeOfDay(TimeOfDay.fromDateTime(a.at.toLocal()))}',
                                  ?a.band,
                                  a.text,
                                ].join(' · '),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
      ),
    );
  }

  Future<void> _export(
    BuildContext context,
    List<StationLogEntry> entries, {
    required bool adif,
  }) async {
    final subject = context.l10n.ham_stationLog;
    final call = context.read<OperatorProfileService>().profile.callsign;
    final version = (await PackageInfo.fromPlatform()).version;
    final text = adif
        ? stationLogAdif(entries, stationCall: call, programVersion: version)
        : stationLogCsv(entries);
    final dir = await getTemporaryDirectory();
    final stamp = DateTime.now().toUtc().toIso8601String().replaceAll(
      RegExp(r'[:.]'),
      '-',
    );
    final file = File(
      '${dir.path}/notoryx-ham-log-$stamp.${adif ? 'adi' : 'csv'}',
    );
    await file.writeAsString(text);
    await SharePlus.instance.share(
      ShareParams(subject: subject, files: [XFile(file.path)]),
    );
  }

  Future<void> _exportAutomated(
    BuildContext context,
    List<AutomatedTransmission> automated,
  ) async {
    final subject = context.l10n.ham_automatedTx;
    final dir = await getTemporaryDirectory();
    final stamp = DateTime.now().toUtc().toIso8601String().replaceAll(
      RegExp(r'[:.]'),
      '-',
    );
    final file = File('${dir.path}/notoryx-ham-automated-$stamp.csv');
    await file.writeAsString(automatedTransmissionsCsv(automated));
    await SharePlus.instance.share(
      ShareParams(subject: subject, files: [XFile(file.path)]),
    );
  }

  Future<void> _clear(BuildContext context, StationLogService log) async {
    final ok = await confirmDestructive(
      context,
      message: context.l10n.ham_stationLogClearConfirm,
    );
    if (ok) await log.clear();
  }
}
