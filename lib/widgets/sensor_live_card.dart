import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/contact.dart';
import '../models/sensor_subscription.dart';
import '../services/sensor_subscription_service.dart';

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
    return Card(
      key: const ValueKey('sensor-live-card'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Live updates', style: theme.textTheme.titleMedium),
            const SizedBox(height: 6),
            if (sub == null) ...[
              const Text(
                'Have the sensor send readings by itself when they change, instead of asking each time. Needs a login with read access.',
              ),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: watchOptions(current).isEmpty
                    ? null
                    : () => _subscribe(context, service),
                icon: const Icon(Icons.sensors),
                label: const Text('Watch for changes'),
              ),
              if (watchOptions(current).isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text('Load telemetry first to choose readings.'),
                ),
            ] else ...[
              Text(
                'Watching ${sub.readings.map(describeWatch).join(', ')} until ${TimeOfDay.fromDateTime(sub.expiresAt).format(context)}${sub.scope.isEmpty ? '' : ' • region ${sub.scope}'}.',
              ),
              const SizedBox(height: 8),
              if (sub.pushes.isEmpty)
                const Text('No changes reported yet.')
              else ...[
                Text(
                  'Last update ${TimeOfDay.fromDateTime(sub.pushes.first.receivedAt).format(context)} • ${sub.pushes.length} received',
                  style: theme.textTheme.bodySmall,
                ),
                for (final r in sub.pushes.first.readings)
                  if (describeReading(r) case final text?)
                    Text(
                      text,
                      key: ValueKey('live-${r['channel']}-${r['type']}'),
                    ),
              ],
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => _unsubscribe(context, service),
                child: const Text('Stop live updates'),
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
      messenger.showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Future<void> _unsubscribe(
    BuildContext context,
    SensorSubscriptionService service,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await service.unsubscribe(sensor);
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Stopped here; the sensor did not confirm and will stop when the time runs out. $e',
          ),
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

String describeWatch(WatchedReading r) =>
    '${r.spec.label.toLowerCase()} (ch ${r.channel}) ±${_num(r.minDelta)}${r.spec.unit.isEmpty ? '' : ' ${r.spec.unit}'}';

/// "Temperature (ch 2): 21.5 °C", or null for readings we don't label.
String? describeReading(Map<String, dynamic> r) {
  final spec = watchableTypes[r['type']];
  final value = r['value'];
  if (spec == null || value is! num) return null;
  return '${spec.label} (ch ${r['channel']}): ${_num(value)}${spec.unit.isEmpty ? '' : ' ${spec.unit}'}';
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
    return AlertDialog(
      title: const Text('Watch for changes'),
      content: SizedBox(
        width: 420,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'The sensor checks about once a minute and sends an update when a chosen reading changes by more than its threshold.',
              ),
              for (var i = 0; i < _options.length; i++)
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _chosen.contains(i),
                  title: Text(
                    '${_options[i].spec.label} (ch ${_options[i].channel})',
                  ),
                  subtitle: Text(
                    'Update on a change of ${_num(_options[i].minDelta)} ${_options[i].spec.unit}',
                  ),
                  secondary: _chosen.contains(i)
                      ? IconButton(
                          tooltip: 'Change threshold',
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
                'The sensor can watch up to $maxMinDeltaBytes bytes of readings ($_bytes used).',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              DropdownButtonFormField<int>(
                initialValue: _hours,
                decoration: const InputDecoration(labelText: 'For'),
                items: [
                  for (final h in subscriptionHours)
                    DropdownMenuItem(value: h, child: Text('$h hours')),
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
          child: const Text('Cancel'),
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
          child: const Text('Start'),
        ),
      ],
    );
  }

  Future<void> _editDelta(int i) async {
    final option = _options[i];
    final controller = TextEditingController(text: _num(option.minDelta));
    final value = await showDialog<double>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${option.spec.label} threshold'),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(suffixText: option.spec.unit),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(context, double.tryParse(controller.text)),
            child: const Text('Save'),
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
