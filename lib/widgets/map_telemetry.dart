import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../helpers/cayenne_lpp.dart';
import '../l10n/l10n.dart';
import '../models/app_settings.dart';
import '../models/contact.dart';
import '../screens/telemetry_screen.dart';
import '../services/app_settings_service.dart';
import '../services/my_sensors_service.dart';
import '../services/node_telemetry_store.dart';

String telemetryMetricLabel(BuildContext context, TelemetryMetric metric) =>
    switch (metric) {
      TelemetryMetric.battery => context.l10n.telemetry_batteryLabel,
      TelemetryMetric.temperature => context.l10n.telemetry_temperatureLabel,
      TelemetryMetric.humidity => context.l10n.telemetry_humidityLabel,
      TelemetryMetric.pressure => context.l10n.telemetry_pressureLabel,
    };

String _readingLabel(BuildContext context, int type) => switch (type) {
  CayenneLpp.lppVoltage => context.l10n.telemetry_voltageLabel,
  CayenneLpp.lppPercentage => context.l10n.telemetry_percentageLabel,
  CayenneLpp.lppTemperature => context.l10n.telemetry_temperatureLabel,
  CayenneLpp.lppRelativeHumidity => context.l10n.telemetry_humidityLabel,
  CayenneLpp.lppBarometricPressure => context.l10n.telemetry_pressureLabel,
  CayenneLpp.lppLuminosity => context.l10n.telemetry_luminosityLabel,
  CayenneLpp.lppGps => context.l10n.telemetry_gpsLabel,
  CayenneLpp.lppAltitude => context.l10n.telemetry_altitudeLabel,
  CayenneLpp.lppCurrent => context.l10n.telemetry_currentLabel,
  CayenneLpp.lppPower => context.l10n.telemetry_powerLabel,
  CayenneLpp.lppConcentration => context.l10n.telemetry_concentrationLabel,
  _ => context.l10n.telemetry_genericLabel,
};

String _age(BuildContext context, NodeReading r, DateTime now) {
  final minutes = now.difference(r.at).inMinutes.clamp(0, 1440);
  return minutes == 0
      ? context.l10n.time_justNow
      : minutes < 60
      ? context.l10n.time_minutesAgo(minutes)
      : context.l10n.time_hoursAgo(minutes ~/ 60);
}

String _source(BuildContext context, TelemetrySource source) =>
    switch (source) {
      TelemetrySource.self => context.l10n.mySensors_title,
      TelemetrySource.sensor => context.l10n.sensor_liveUpdates,
      TelemetrySource.status => context.l10n.repeater_status,
      TelemetrySource.telemetry => context.l10n.contact_telemetry,
    };

Color telemetryReadingColor(NodeReading reading, Color fallback) {
  final value = reading.value;
  if (value is! num) return fallback;
  // Voltage is not universally a single-cell Li-ion battery. Keep it neutral.
  if (reading.type == CayenneLpp.lppTemperature) {
    return value < 0
        ? Colors.lightBlue
        : value < 30
        ? Colors.green
        : value < 40
        ? Colors.orange
        : Colors.red;
  }
  return fallback;
}

/// Refreshes ages locally only; this widget never sends a radio request.
class TelemetryClock extends StatefulWidget {
  const TelemetryClock({super.key, required this.builder});
  final WidgetBuilder builder;
  @override
  State<TelemetryClock> createState() => _TelemetryClockState();
}

class _TelemetryClockState extends State<TelemetryClock> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context);
}

/// Mirrors map clustering: only single-node cells and the selected node get badges.
List<Contact> telemetryIndividualNodes(
  List<Contact> contacts, {
  double? cellDegrees,
  String? selectedKey,
}) {
  if (cellDegrees == null || cellDegrees <= 0) return contacts;
  String cell(Contact c) =>
      '${(c.latitude! / cellDegrees).floor()}:${(c.longitude! / cellDegrees).floor()}';
  final counts = <String, int>{};
  for (final c in contacts) {
    if (!c.hasLocation || c.publicKeyHex == selectedKey) continue;
    counts.update(cell(c), (count) => count + 1, ifAbsent: () => 1);
  }
  return contacts
      .where(
        (c) =>
            c.hasLocation &&
            (c.publicKeyHex == selectedKey || counts[cell(c)] == 1),
      )
      .toList();
}

/// An opt-in layer, culled against the current camera bounds on every map move.
class MapTelemetryLayer extends StatelessWidget {
  const MapTelemetryLayer({
    super.key,
    required this.contacts,
    required this.metric,
    required this.onSelect,
    this.selfKey,
    this.selfPosition,
    this.clusterCellDegrees,
    this.selectedKey,
  });
  final List<Contact> contacts;
  final TelemetryMetric metric;
  final ValueChanged<Contact> onSelect;
  final String? selfKey;
  final LatLng? selfPosition;
  final double? clusterCellDegrees;
  final String? selectedKey;

  @override
  Widget build(BuildContext context) => TelemetryClock(
    builder: (context) {
      final store = context.watch<NodeTelemetryStore?>();
      if (store == null) return const SizedBox.shrink();
      final camera = MapCamera.of(context);
      final imperial = context.select<AppSettingsService, bool>(
        (s) => s.settings.unitSystem == UnitSystem.imperial,
      );
      final points = [
        for (final c in telemetryIndividualNodes(
          contacts,
          cellDegrees: clusterCellDegrees,
          selectedKey: selectedKey,
        ))
          if (c.hasLocation)
            (
              key: c.publicKeyHex,
              point: LatLng(c.latitude!, c.longitude!),
              contact: c,
            ),
        if (selfKey != null &&
            selfPosition != null &&
            !contacts.any((c) => c.publicKeyHex == selfKey))
          (key: selfKey!, point: selfPosition!, contact: null),
      ];
      final markers = <Marker>[];
      for (final point in points) {
        if (!camera.visibleBounds.contains(point.point)) continue;
        final reading = store.metricFor(point.key, metric);
        if (reading == null) continue;
        final text = formatSensorReading(reading.lpp, imperial: imperial);
        if (text == null) continue;
        final scheme = Theme.of(context).colorScheme;
        final stale = reading.staleAt(store.now);
        final label =
            '${telemetryMetricLabel(context, metric)}: $text • ${_age(context, reading, store.now)}${stale ? ' • ${context.l10n.map_stale}' : ''}';
        markers.add(
          Marker(
            key: ValueKey('telemetry-${point.key}'),
            point: point.point,
            width: 112,
            height: 30,
            child: Transform.translate(
              offset: const Offset(0, 44),
              child: Opacity(
                opacity: stale ? 0.55 : 1,
                child: Tooltip(
                  message: label,
                  child: Semantics(
                    label: label,
                    button: point.contact != null,
                    child: Material(
                      color: scheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: point.contact == null
                            ? null
                            : () => onSelect(point.contact!),
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          child: Center(
                            child: Text(
                              text,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: telemetryReadingColor(
                                  reading,
                                  scheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
      return MarkerLayer(markers: markers);
    },
  );
}

/// Cached measurements in the selected node card. Opening Refresh deliberately
/// uses the existing telemetry request/login path, not a second packet sender.
class NodeTelemetrySection extends StatelessWidget {
  const NodeTelemetrySection({super.key, required this.contact});
  final Contact contact;
  @override
  Widget build(BuildContext context) => TelemetryClock(
    builder: (context) {
      final store = context.watch<NodeTelemetryStore?>();
      if (store == null) return const SizedBox.shrink();
      final readings = store.readingsFor(contact.publicKeyHex);
      final imperial = context.select<AppSettingsService, bool>(
        (s) => s.settings.unitSystem == UnitSystem.imperial,
      );
      final connected = context.select<MeshCoreConnector, bool>(
        (c) => c.isConnected,
      );
      final title = Text(
        context.l10n.contact_telemetry,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      );
      final actions = Wrap(
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          IconButton(
            tooltip: context.l10n.mapTelemetry_policy,
            onPressed: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(context.l10n.mapTelemetry_policy),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(context.l10n.common_close),
                  ),
                ],
              ),
            ),
            icon: const Icon(Icons.info_outline, size: 18),
          ),
          TextButton.icon(
            key: const ValueKey('node-telemetry-refresh'),
            onPressed: !connected
                ? null
                : () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) => TelemetryScreen(contact: contact),
                    ),
                  ),
            icon: const Icon(Icons.refresh, size: 18),
            label: Text(context.l10n.repeater_refresh),
          ),
        ],
      );
      // Larger text needs more room: the list grows with it, and the title
      // moves above the buttons when they can't share a line.
      final scale = MediaQuery.textScalerOf(context).scale(14) / 14;
      return LayoutBuilder(
        builder: (context, constraints) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (constraints.maxWidth < 300 * scale) ...[
              title,
              Align(alignment: AlignmentDirectional.centerEnd, child: actions),
            ] else
              Row(
                children: [
                  Expanded(child: title),
                  actions,
                ],
              ),
            if (readings.isEmpty)
              Text(
                context.l10n.telemetry_noData,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              )
            else
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: (112 * scale).clamp(112, 280).toDouble(),
                ),
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    for (final reading in readings)
                      if (formatSensorReading(reading.lpp, imperial: imperial)
                          case final text?)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            '${context.l10n.sensor_readingValue(_readingLabel(context, reading.type), reading.channel.toString(), text)}\n${_age(context, reading, store.now)} • ${_source(context, reading.source)}',
                            style: TextStyle(
                              color: reading.staleAt(store.now)
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                  ],
                ),
              ),
          ],
        ),
      );
    },
  );
}
