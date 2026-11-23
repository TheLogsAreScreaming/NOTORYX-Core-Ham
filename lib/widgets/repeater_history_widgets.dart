import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../services/repeater_status_history.dart';
import '../theme/mesh_theme.dart';
import 'mesh_ui.dart';
import 'time_series_chart.dart';

/// Time windows offered on history charts.
enum HistoryWindow {
  day(Duration(days: 1)),
  week(Duration(days: 7)),
  month(Duration(days: 30));

  const HistoryWindow(this.length);
  final Duration length;

  String label(AppLocalizations l10n) => switch (this) {
    day => l10n.history_window24h,
    week => l10n.history_window7d,
    month => l10n.history_window30d,
  };
}

String statusMetricLabel(AppLocalizations l10n, StatusMetric metric) =>
    switch (metric) {
      StatusMetric.battery => l10n.statusHistory_battery,
      StatusMetric.rssi => l10n.statusHistory_rssi,
      StatusMetric.snr => l10n.statusHistory_snr,
      StatusMetric.noiseFloor => l10n.statusHistory_noiseFloor,
      StatusMetric.errors => l10n.statusHistory_errors,
      StatusMetric.uptime => l10n.statusHistory_uptime,
    };

String _formatMetric(StatusMetric metric, double v) => switch (metric) {
  StatusMetric.battery => '${v.toStringAsFixed(2)} V',
  StatusMetric.snr => '${v.toStringAsFixed(1)} dB',
  StatusMetric.rssi || StatusMetric.noiseFloor => '${v.round()} dBm',
  StatusMetric.errors => v.round().toString(),
  StatusMetric.uptime => '${v.toStringAsFixed(v < 10 ? 1 : 0)} h',
};

double _minSpan(StatusMetric metric) => switch (metric) {
  StatusMetric.battery => 0.2,
  StatusMetric.errors => 2,
  _ => 4,
};

/// Charts every saved status check of one repeater.
class RepeaterStatusHistoryCard extends StatefulWidget {
  const RepeaterStatusHistoryCard({super.key, required this.repeaterKey});

  final String repeaterKey;

  @override
  State<RepeaterStatusHistoryCard> createState() =>
      _RepeaterStatusHistoryCardState();
}

class _RepeaterStatusHistoryCardState extends State<RepeaterStatusHistoryCard> {
  StatusMetric _metric = StatusMetric.battery;
  HistoryWindow _window = HistoryWindow.week;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final history = context.watch<RepeaterStatusHistory?>();
    if (history == null) return const SizedBox.shrink();
    final samples = history.statusFor(widget.repeaterKey);
    final now = history.now;
    final start = now.subtract(_window.length);
    final points = <TimePoint>[
      for (final s in samples)
        if (!s.at.isBefore(start))
          if (s.valueOf(_metric) case final v?) (at: s.at, value: v),
    ];
    final metricName = statusMetricLabel(l10n, _metric);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(l10n.statusHistory_title),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: MeshCard(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final m in StatusMetric.values)
                      ChoiceChip(
                        label: Text(statusMetricLabel(l10n, m)),
                        selected: _metric == m,
                        onSelected: (_) => setState(() => _metric = m),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                SegmentedButton<HistoryWindow>(
                  segments: [
                    for (final w in HistoryWindow.values)
                      ButtonSegment(value: w, label: Text(w.label(l10n))),
                  ],
                  selected: {_window},
                  showSelectedIcon: false,
                  onSelectionChanged: (s) => setState(() => _window = s.first),
                ),
                const SizedBox(height: 12),
                if (points.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      samples.isEmpty
                          ? l10n.statusHistory_empty
                          : l10n.statusHistory_noneInWindow(metricName),
                      style: TextStyle(color: MeshPalette.ink3),
                    ),
                  )
                else
                  TimeSeriesChart(
                    points: points,
                    start: start,
                    end: now,
                    minSpan: _minSpan(_metric),
                    format: (v) => _formatMetric(_metric, v),
                    semanticsLabel: l10n.statusHistory_chartLabel(
                      metricName,
                      points.length,
                      _formatMetric(
                        _metric,
                        points
                            .map((p) => p.value)
                            .reduce((a, b) => a < b ? a : b),
                      ),
                      _formatMetric(
                        _metric,
                        points
                            .map((p) => p.value)
                            .reduce((a, b) => a > b ? a : b),
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.statusHistory_count(samples.length),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    if (samples.isNotEmpty)
                      TextButton(
                        onPressed: () => _confirmClear(context, history),
                        child: Text(l10n.statusHistory_clear),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _confirmClear(
    BuildContext context,
    RepeaterStatusHistory history,
  ) async {
    final l10n = context.l10n;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.statusHistory_clearTitle),
        content: Text(l10n.statusHistory_clearBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.common_cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.statusHistory_clear),
          ),
        ],
      ),
    );
    if (ok == true) history.clear(widget.repeaterKey);
  }
}

/// A tiny SNR trend for one neighbour; tap for the full chart.
class NeighbourSnrTrend extends StatelessWidget {
  const NeighbourSnrTrend({
    super.key,
    required this.repeaterKey,
    required this.neighbourPrefix,
    required this.name,
  });

  final String repeaterKey;
  final String neighbourPrefix;
  final String name;

  @override
  Widget build(BuildContext context) {
    final history = context.watch<RepeaterStatusHistory?>();
    final samples = history?.snrFor(repeaterKey, neighbourPrefix) ?? const [];
    if (history == null || samples.length < 2) return const SizedBox.shrink();
    final l10n = context.l10n;
    final points = [for (final s in samples) (at: s.at, value: s.snr)];
    return InkWell(
      onTap: () => showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        builder: (_) => ChangeNotifierProvider<RepeaterStatusHistory?>.value(
          value: history,
          child: _NeighbourSnrSheet(
            repeaterKey: repeaterKey,
            neighbourPrefix: neighbourPrefix,
            name: name,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: TimeSeriesChart(
          points: points,
          start: points.first.at,
          end: history.now,
          height: 28,
          minSpan: 4,
          format: (_) => '',
          semanticsLabel: l10n.snrHistory_trendLabel(name, samples.length),
        ),
      ),
    );
  }
}

class _NeighbourSnrSheet extends StatelessWidget {
  const _NeighbourSnrSheet({
    required this.repeaterKey,
    required this.neighbourPrefix,
    required this.name,
  });

  final String repeaterKey;
  final String neighbourPrefix;
  final String name;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final history = context.watch<RepeaterStatusHistory?>();
    final samples = history?.snrFor(repeaterKey, neighbourPrefix) ?? const [];
    if (history == null || samples.isEmpty) return const SizedBox.shrink();
    final points = [for (final s in samples) (at: s.at, value: s.snr)];
    final values = points.map((p) => p.value);
    final low = values.reduce((a, b) => a < b ? a : b);
    final high = values.reduce((a, b) => a > b ? a : b);
    final avg = values.reduce((a, b) => a + b) / points.length;
    String db(double v) => '${v.toStringAsFixed(1)} dB';
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.snrHistory_title(name),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(l10n.snrHistory_hint),
            const SizedBox(height: 12),
            TimeSeriesChart(
              points: points,
              start: points.first.at,
              end: history.now,
              height: 160,
              minSpan: 4,
              format: db,
              semanticsLabel: l10n.snrHistory_trendLabel(name, samples.length),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.snrHistory_summary(
                samples.length,
                db(low),
                db(avg),
                db(high),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
