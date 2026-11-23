import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/sensor_labels.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/contact.dart';
import '../services/sensor_history_store.dart';
import '../theme/mesh_theme.dart';
import '../widgets/mesh_ui.dart';
import '../widgets/time_series_chart.dart';
import 'telemetry_screen.dart';

/// Opens the history page of a sensor (or any node with telemetry).
void openSensorHistory(BuildContext context, Contact node) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => SensorHistoryScreen(node: node)),
  );
}

enum _Window {
  hour(Duration(hours: 1)),
  six(Duration(hours: 6)),
  day(Duration(hours: 24));

  const _Window(this.length);
  final Duration length;

  String label(AppLocalizations l10n) => switch (this) {
    hour => l10n.sensorHistory_window1h,
    six => l10n.sensorHistory_window6h,
    day => l10n.sensorHistory_window24h,
  };
}

/// Every numeric value a node has reported over the last day, charted, with
/// an optional alert per value.
class SensorHistoryScreen extends StatefulWidget {
  const SensorHistoryScreen({super.key, required this.node});

  final Contact node;

  @override
  State<SensorHistoryScreen> createState() => _SensorHistoryScreenState();
}

class _SensorHistoryScreenState extends State<SensorHistoryScreen> {
  _Window _window = _Window.six;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final store = context.watch<SensorHistoryStore?>();
    final key = widget.node.publicKeyHex;
    final metrics = store?.metricsFor(key) ?? const <String>[];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.sensorHistory_title),
            Text(
              widget.node.name,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => TelemetryScreen(contact: widget.node),
          ),
        ),
        icon: const Icon(Icons.sensors),
        label: Text(l10n.sensorHistory_readNow),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
          children: [
            SegmentedButton<_Window>(
              segments: [
                for (final w in _Window.values)
                  ButtonSegment(value: w, label: Text(w.label(l10n))),
              ],
              selected: {_window},
              showSelectedIcon: false,
              onSelectionChanged: (s) => setState(() => _window = s.first),
            ),
            const SizedBox(height: 12),
            if (store == null || metrics.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  l10n.sensorHistory_empty,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: MeshPalette.ink3),
                ),
              )
            else
              for (final id in metrics)
                _MetricCard(
                  store: store,
                  nodeKey: key,
                  metricId: id,
                  window: _window.length,
                ),
          ],
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.store,
    required this.nodeKey,
    required this.metricId,
    required this.window,
  });

  final SensorHistoryStore store;
  final String nodeKey;
  final String metricId;
  final Duration window;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final type = SensorHistoryStore.typeOf(metricId);
    final channel = SensorHistoryStore.channelOf(metricId);
    final name = sensorTypeLabel(l10n, type);
    final all = store.samplesFor(nodeKey, metricId);
    final now = store.now;
    final start = now.subtract(window);
    final points = [
      for (final s in all)
        if (!s.at.isBefore(start)) (at: s.at, value: s.value),
    ];
    final latest = all.isEmpty ? null : all.last;
    final threshold = store.thresholdFor(nodeKey, metricId);
    String fmt(double v) => formatSensorValue(type, v);
    final values = points.map((p) => p.value);
    return MeshCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '$name · ${l10n.telemetry_channelTitle(channel)}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              if (latest != null)
                Text(
                  fmt(latest.value),
                  style: MeshTheme.mono(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          if (latest != null)
            Text(
              l10n.sensorHistory_updated(
                MaterialLocalizations.of(
                  context,
                ).formatTimeOfDay(TimeOfDay.fromDateTime(latest.at)),
              ),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          const SizedBox(height: 8),
          if (points.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                l10n.sensorHistory_noneInWindow,
                style: TextStyle(color: MeshPalette.ink3),
              ),
            )
          else
            TimeSeriesChart(
              points: points,
              start: start,
              end: now,
              format: fmt,
              threshold: threshold?.above ?? threshold?.below,
              semanticsLabel: l10n.sensorHistory_chartLabel(
                name,
                points.length,
                fmt(values.reduce((a, b) => a < b ? a : b)),
                fmt(values.reduce((a, b) => a > b ? a : b)),
              ),
            ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                threshold == null
                    ? Icons.notifications_none
                    : Icons.notifications_active,
                size: 18,
                color: threshold == null ? MeshPalette.ink3 : MeshPalette.warn,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  _thresholdText(l10n, threshold, fmt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              TextButton(
                onPressed: () => _editThreshold(context, type, threshold),
                child: Text(l10n.sensorHistory_setAlert),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _thresholdText(
    AppLocalizations l10n,
    SensorThreshold? t,
    String Function(double) fmt,
  ) {
    if (t == null) return l10n.sensorHistory_noAlert;
    return [
      if (t.above != null) l10n.sensorHistory_alertWhenAbove(fmt(t.above!)),
      if (t.below != null) l10n.sensorHistory_alertWhenBelow(fmt(t.below!)),
    ].join(' · ');
  }

  Future<void> _editThreshold(
    BuildContext context,
    int type,
    SensorThreshold? current,
  ) async {
    final result = await showDialog<SensorThreshold?>(
      context: context,
      builder: (_) => _ThresholdDialog(type: type, current: current),
    );
    if (result == null) return;
    await store.setThreshold(nodeKey, metricId, result.isEmpty ? null : result);
  }
}

class _ThresholdDialog extends StatefulWidget {
  const _ThresholdDialog({required this.type, this.current});

  final int type;
  final SensorThreshold? current;

  @override
  State<_ThresholdDialog> createState() => _ThresholdDialogState();
}

class _ThresholdDialogState extends State<_ThresholdDialog> {
  late final _above = TextEditingController(
    text: widget.current?.above?.toString() ?? '',
  );
  late final _below = TextEditingController(
    text: widget.current?.below?.toString() ?? '',
  );

  @override
  void dispose() {
    _above.dispose();
    _below.dispose();
    super.dispose();
  }

  double? _parse(String s) => double.tryParse(s.trim().replaceAll(',', '.'));

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final unit = sensorUnit(widget.type);
    final above = _parse(_above.text), below = _parse(_below.text);
    final invalid = above != null && below != null && below >= above;
    const keyboard = TextInputType.numberWithOptions(
      decimal: true,
      signed: true,
    );
    return AlertDialog(
      title: Text(l10n.sensorHistory_alertDialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.sensorHistory_alertDialogHint),
          const SizedBox(height: 12),
          TextField(
            controller: _above,
            keyboardType: keyboard,
            decoration: InputDecoration(
              labelText: l10n.sensorHistory_above,
              suffixText: unit,
            ),
            onChanged: (_) => setState(() {}),
          ),
          TextField(
            controller: _below,
            keyboardType: keyboard,
            decoration: InputDecoration(
              labelText: l10n.sensorHistory_below,
              suffixText: unit,
              errorText: invalid ? l10n.sensorHistory_belowMustBeLower : null,
            ),
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
      actions: [
        if (widget.current != null)
          TextButton(
            onPressed: () => Navigator.pop(context, const SensorThreshold()),
            child: Text(l10n.sensorHistory_removeAlert),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.common_cancel),
        ),
        FilledButton(
          onPressed: invalid
              ? null
              : () => Navigator.pop(
                  context,
                  SensorThreshold(above: above, below: below),
                ),
          child: Text(l10n.common_save),
        ),
      ],
    );
  }
}
