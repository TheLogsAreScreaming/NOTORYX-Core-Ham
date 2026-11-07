import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/cayenne_lpp.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/contact.dart';
import '../models/sensor_subscription.dart';
import '../services/sensor_subscription_service.dart';
import '../helpers/snack_bar_builder.dart';

/// "Live updates" for a sensor on its telemetry page: subscribe to pushes
/// when chosen readings change, and show what arrives.
class SensorLiveCard extends StatelessWidget {
  final Contact sensor;

  /// The last telemetry read ([CayenneLpp.parse] output), used to offer
  /// readings to watch. Null until telemetry has been loaded once.
  final List<Map<String, dynamic>>? current;

  const SensorLiveCard({super.key, required this.sensor, this.current});

  @override
  Widget build(BuildContext context) {
    final service = context.watch<SensorSubscriptionService>();
    final sub = service.subscriptionFor(sensor);
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return Card(
      key: const ValueKey('sensor-live-card'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.sensor_liveUpdates, style: theme.textTheme.titleMedium),
            const SizedBox(height: 6),
            if (sub == null) ...[
              Text(l10n.sensor_intro),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: watchOptions(current).isEmpty
                    ? null
                    : () => _subscribe(context, service),
                icon: const Icon(Icons.sensors),
                label: Text(l10n.sensor_watch),
              ),
              if (watchOptions(current).isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(l10n.sensor_loadFirst),
                ),
            ] else ...[
              Text(
                sub.scope.isEmpty
                    ? l10n.sensor_watching(
                        sub.readings
                            .map((r) => describeWatch(r, l10n: l10n))
                            .join(', '),
                        TimeOfDay.fromDateTime(sub.expiresAt).format(context),
                      )
                    : l10n.sensor_watchingRegion(
                        sub.readings
                            .map((r) => describeWatch(r, l10n: l10n))
                            .join(', '),
                        TimeOfDay.fromDateTime(sub.expiresAt).format(context),
                        sub.scope,
                      ),
              ),
              const SizedBox(height: 8),
              if (sub.pushes.isEmpty)
                Text(l10n.sensor_noChanges)
              else ...[
                Text(
                  l10n.sensor_lastUpdate(
                    TimeOfDay.fromDateTime(sub.pushes.first.receivedAt)
                        .format(context),
                    sub.pushes.length,
                  ),
                  style: theme.textTheme.bodySmall,
                ),
                for (final r in sub.pushes.first.readings)
                  if (describeReading(r, l10n: l10n) case final text?)
                    Text(
                      text,
                      key: ValueKey('live-${r['channel']}-${r['type']}'),
                    ),
              ],
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => _unsubscribe(context, service),
                child: Text(l10n.sensor_stop),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _subscribe(
    BuildContext context,
    SensorSubscriptionService service,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final choice = await showDialog<_WatchChoice>(
      context: context,
      builder: (_) => _WatchDialog(options: watchOptions(current)),
    );
    if (choice == null) return;
    try {
      await service.subscribe(
        sensor,
        readings: choice.readings,
        duration: Duration(hours: choice.hours),
      );
    } catch (e) {
      messenger.showSnackBar(meshSnackBar(content: Text(friendlyError(e))));
    }
  }

  Future<void> _unsubscribe(
    BuildContext context,
    SensorSubscriptionService service,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    try {
      await service.unsubscribe(sensor);
    } catch (e) {
      messenger.showSnackBar(
        meshSnackBar(
          content: Text(l10n.sensor_stopUnconfirmed(friendlyError(e))),
        ),
      );
    }
  }
}

/// Readings from a telemetry read that can be watched, one per channel+type.
List<WatchedReading> watchOptions(List<Map<String, dynamic>>? current) {
  final seen = <String>{};
  final out = <WatchedReading>[];
  for (final r in current ?? const <Map<String, dynamic>>[]) {
    final type = r['type'] as int;
    final channel = r['channel'] as int;
    final spec = watchableTypes[type];
    if (spec == null || !seen.add('$channel/$type')) continue;
    out.add(WatchedReading(channel, type, spec.defaultDelta));
  }
  return out;
}

final AppLocalizations _en = lookupAppLocalizations(const Locale('en'));

/// The reading type's name in [t]'s language.
String readingLabel(int type, AppLocalizations t) => switch (type) {
  CayenneLpp.lppTemperature => t.sensor_typeTemperature,
  CayenneLpp.lppRelativeHumidity => t.sensor_typeHumidity,
  CayenneLpp.lppBarometricPressure => t.sensor_typePressure,
  CayenneLpp.lppVoltage => t.sensor_typeVoltage,
  CayenneLpp.lppCurrent => t.sensor_typeCurrent,
  CayenneLpp.lppLuminosity => t.sensor_typeLight,
  CayenneLpp.lppConcentration => t.sensor_typeConcentration,
  CayenneLpp.lppPercentage => t.sensor_typePercentage,
  CayenneLpp.lppAnalogInput => t.sensor_typeAnalogInput,
  CayenneLpp.lppAltitude => t.sensor_typeAltitude,
  _ => watchableTypes[type]?.label ?? '$type',
};

String _withUnit(num v, LppSpec spec) =>
    '${_num(v)}${spec.unit.isEmpty ? '' : ' ${spec.unit}'}';

/// "temperature (ch 2) ±0.5 °C".
String describeWatch(WatchedReading r, {AppLocalizations? l10n}) {
  final t = l10n ?? _en;
  final label = readingLabel(r.type, t);
  // English reads the name mid-sentence in lower case; other languages
  // keep the word's own case (German nouns stay capitalised).
  return t.sensor_watchItem(
    t.localeName == 'en' ? label.toLowerCase() : label,
    '${r.channel}',
    _withUnit(r.minDelta, r.spec),
  );
}

/// "Temperature (ch 2): 21.5 °C", or null for readings we don't label.
String? describeReading(Map<String, dynamic> r, {AppLocalizations? l10n}) {
  final t = l10n ?? _en;
  final type = r['type'];
  final spec = watchableTypes[type];
  final value = r['value'];
  if (spec == null || value is! num) return null;
  return t.sensor_readingValue(
    readingLabel(type as int, t),
    '${r['channel']}',
    _withUnit(value, spec),
  );
}

String _num(num v) => v == v.roundToDouble()
    ? v.toInt().toString()
    : v.toStringAsFixed(2).replaceFirst(RegExp(r'0$'), '');

class _WatchChoice {
  final List<WatchedReading> readings;
  final int hours;
  const _WatchChoice(this.readings, this.hours);
}

class _WatchDialog extends StatefulWidget {
  final List<WatchedReading> options;
  const _WatchDialog({required this.options});

  @override
  State<_WatchDialog> createState() => _WatchDialogState();
}

class _WatchDialogState extends State<_WatchDialog> {
  late final List<WatchedReading> _options = List.of(widget.options);
  final Set<int> _chosen = {};
  int _hours = subscriptionHours.first;

  int get _bytes => _chosen.fold(0, (sum, i) => sum + _options[i].encodedSize);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.sensor_watch),
      content: SizedBox(
        width: 420,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.sensor_dialogBody),
              for (var i = 0; i < _options.length; i++)
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _chosen.contains(i),
                  title: Text(
                    l10n.sensor_readingTitle(
                      readingLabel(_options[i].type, l10n),
                      '${_options[i].channel}',
                    ),
                  ),
                  subtitle: Text(
                    l10n.sensor_updateOn(
                      _withUnit(_options[i].minDelta, _options[i].spec),
                    ),
                  ),
                  secondary: _chosen.contains(i)
                      ? IconButton(
                          tooltip: l10n.sensor_changeThreshold,
                          icon: const Icon(Icons.tune),
                          onPressed: () => _editDelta(i),
                        )
                      : null,
                  onChanged: (v) => setState(() {
                    if (v != true) {
                      _chosen.remove(i);
                    } else if (_bytes + _options[i].encodedSize <=
                        maxMinDeltaBytes) {
                      _chosen.add(i);
                    }
                  }),
                ),
              Text(
                l10n.sensor_capacity(maxMinDeltaBytes, '$_bytes'),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              DropdownButtonFormField<int>(
                initialValue: _hours,
                decoration: InputDecoration(labelText: l10n.sensor_for),
                items: [
                  for (final h in subscriptionHours)
                    DropdownMenuItem(
                      value: h,
                      child: Text(l10n.sensor_hours(h)),
                    ),
                ],
                onChanged: (v) => setState(() => _hours = v ?? _hours),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.common_cancel),
        ),
        FilledButton(
          onPressed: _chosen.isEmpty
              ? null
              : () => Navigator.pop(
                  context,
                  _WatchChoice([
                    for (final i in _chosen.toList()..sort()) _options[i],
                  ], _hours),
                ),
          child: Text(l10n.sensor_start),
        ),
      ],
    );
  }

  Future<void> _editDelta(int i) async {
    final option = _options[i];
    final l10n = context.l10n;
    final controller = TextEditingController(text: _num(option.minDelta));
    final value = await showDialog<double>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          l10n.sensor_thresholdTitle(readingLabel(option.type, l10n)),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(suffixText: option.spec.unit),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.common_cancel),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(context, double.tryParse(controller.text)),
            child: Text(l10n.common_save),
          ),
        ],
      ),
    );
    controller.dispose();
    if (value == null || value <= 0) return;
    setState(() {
      _options[i] = WatchedReading(option.channel, option.type, value);
    });
  }
}
