import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../services/repeater_report_card.dart';
import '../services/repeater_status_history.dart';
import '../theme/mesh_theme.dart';
import 'mesh_ui.dart';

/// One repeater's report card over the kept history: checks, restarts,
/// uptime, battery, noise, errors and neighbour churn, with a CSV export.
class RepeaterReportCardView extends StatelessWidget {
  const RepeaterReportCardView({super.key, required this.repeaterKey});

  final String repeaterKey;

  static String _duration(AppLocalizations l10n, int secs) =>
      l10n.repeater_daysHoursMinsSecs(
        secs ~/ 86400,
        (secs % 86400) ~/ 3600,
        (secs % 3600) ~/ 60,
        secs % 60,
      );

  static String _volts(int mv) => '${(mv / 1000).toStringAsFixed(2)} V';

  Future<void> _exportCsv(List<StatusSample> samples) async {
    final dir = await getTemporaryDirectory();
    final prefix = repeaterKey.length >= 8
        ? repeaterKey.substring(0, 8)
        : repeaterKey;
    final file = File('${dir.path}/repeater-$prefix-status.csv');
    await file.writeAsString(statusSamplesCsv(samples));
    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final history = context.watch<RepeaterStatusHistory?>();
    if (history == null) return const SizedBox.shrink();
    final samples = history.statusFor(repeaterKey);
    final card = RepeaterReportCard.from(
      samples: samples,
      neighbours: history.neighboursOf(repeaterKey),
      now: history.now,
    );

    Widget row(String label, String value) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: MeshPalette.ink3, fontSize: 13),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            flex: 2,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: MeshPalette.ink,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    final battery = card.batteryNowMv == null
        ? null
        : [
            l10n.reportCard_batteryValue(
              _volts(card.batteryNowMv!),
              _volts(card.batteryLowMv!),
            ),
            if (card.batteryMvPerWeek case final w?)
              l10n.reportCard_batteryTrend(
                '${w >= 0 ? '+' : '−'}${(w.abs() / 1000).toStringAsFixed(2)} V',
              ),
          ].join(' · ');

    return Column(
      key: const ValueKey('repeater-report-card'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(l10n.reportCard_title),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: MeshCard(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (card.isEmpty)
                  Text(
                    l10n.reportCard_empty,
                    style: TextStyle(color: MeshPalette.ink3, fontSize: 13),
                  )
                else ...[
                  row(
                    l10n.reportCard_checks,
                    l10n.reportCard_checksValue(
                      card.checks,
                      card.span.inDays < 1 ? 1 : card.span.inDays,
                    ),
                  ),
                  row(l10n.reportCard_restarts, '${card.restarts}'),
                  if (card.longestUptimeSecs case final up?)
                    row(l10n.reportCard_longestUptime, _duration(l10n, up)),
                  ?(battery == null
                      ? null
                      : row(l10n.reportCard_battery, battery)),
                  if (card.noiseAvg case final avg?)
                    row(
                      l10n.reportCard_noise,
                      l10n.reportCard_noiseValue(
                        avg.toStringAsFixed(0),
                        '${card.noiseWorst}',
                      ),
                    ),
                  if (card.newErrors case final e?)
                    row(l10n.reportCard_errors, '$e'),
                  if (card.neighboursHeard > 0)
                    row(
                      l10n.reportCard_neighbours,
                      l10n.reportCard_neighboursValue(
                        card.neighboursHeard,
                        card.neighboursNew,
                        card.neighboursGone,
                      ),
                    ),
                ],
                const SizedBox(height: 6),
                Text(
                  l10n.reportCard_hint,
                  style: TextStyle(color: MeshPalette.ink3, fontSize: 12),
                ),
                if (samples.isNotEmpty)
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton.icon(
                      onPressed: () => _exportCsv(samples),
                      icon: const Icon(Icons.table_view_outlined, size: 18),
                      label: Text(l10n.reportCard_exportCsv),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
