import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/helpers/cayenne_lpp.dart';
import 'package:meshcore_open/services/node_telemetry_store.dart';
import 'package:meshcore_open/services/sensor_history_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

final radio = 'a' * 64;
final sensor = 'b' * 64;

void main() {
  late SharedPreferences prefs;
  var now = DateTime(2026, 11, 22, 12);

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    now = DateTime(2026, 11, 22, 12);
  });

  NodeReading temp(double v, {int channel = 1}) => NodeReading(
    channel: channel,
    type: CayenneLpp.lppTemperature,
    value: v,
    at: now,
    source: TelemetrySource.sensor,
  );

  test('keeps numeric readings over time, per radio', () async {
    final store = SensorHistoryStore(prefs, clock: () => now)..setScope(radio);
    store.recordReadings(sensor, [temp(20)]);
    now = now.add(const Duration(minutes: 5));
    store.recordReadings(sensor, [
      temp(21),
      NodeReading(
        channel: 1,
        type: CayenneLpp.lppGps,
        value: const {'latitude': 1, 'longitude': 2, 'altitude': 3},
        at: now,
        source: TelemetrySource.sensor,
      ),
    ]);
    final id = SensorHistoryStore.metricId(1, CayenneLpp.lppTemperature);
    expect(store.metricsFor(sensor), [id]);
    expect(store.samplesFor(sensor, id).map((s) => s.value), [20, 21]);
    await store.flush();
    store.dispose();

    final again = SensorHistoryStore(prefs, clock: () => now)..setScope(radio);
    expect(again.samplesFor(sensor, id), hasLength(2));
    again.setScope('c' * 64);
    expect(again.metricsFor(sensor), isEmpty);
    again.dispose();
  });

  test('drops readings older than a day', () {
    final store = SensorHistoryStore(prefs, clock: () => now)..setScope(radio);
    store.recordReadings(sensor, [temp(20)]);
    now = now.add(const Duration(hours: 27));
    store.recordReadings(sensor, [temp(22)]);
    final id = SensorHistoryStore.metricId(1, CayenneLpp.lppTemperature);
    expect(store.samplesFor(sensor, id).single.value, 22);
    store.dispose();
  });

  test('alerts once when a value crosses a limit', () async {
    final alerts = <SensorAlert>[];
    final store = SensorHistoryStore(
      prefs,
      clock: () => now,
      onAlert: alerts.add,
    )..setScope(radio);
    final id = SensorHistoryStore.metricId(1, CayenneLpp.lppTemperature);
    await store.setThreshold(
      sensor,
      id,
      const SensorThreshold(above: 30, below: 5),
    );
    store.recordReadings(sensor, [temp(25)]);
    now = now.add(const Duration(minutes: 1));
    store.recordReadings(sensor, [temp(31)]);
    expect(alerts.single.above, isTrue);
    expect(alerts.single.limit, 30);
    now = now.add(const Duration(minutes: 1));
    store.recordReadings(sensor, [temp(32)]);
    expect(alerts, hasLength(1));
    // Back inside, then out again within the quiet time: no new alert.
    now = now.add(const Duration(minutes: 1));
    store.recordReadings(sensor, [temp(20)]);
    now = now.add(const Duration(minutes: 1));
    store.recordReadings(sensor, [temp(33)]);
    expect(alerts, hasLength(1));
    now = now.add(const Duration(minutes: 40));
    store.recordReadings(sensor, [temp(2)]);
    expect(alerts, hasLength(2));
    expect(alerts.last.above, isFalse);

    final reloaded = SensorHistoryStore(prefs, clock: () => now);
    expect(reloaded.thresholdFor(sensor, id)?.above, 30);
    await reloaded.setThreshold(sensor, id, null);
    expect(reloaded.thresholdFor(sensor, id), isNull);
    store.dispose();
    reloaded.dispose();
  });

  test('the telemetry store passes on what it accepts', () {
    final telemetry = NodeTelemetryStore(prefs, clock: () => now)
      ..setScope(radio);
    final got = <NodeReading>[];
    telemetry.onRecorded = (_, readings) => got.addAll(readings);
    telemetry.record(sensor, [
      {'channel': 1, 'type': CayenneLpp.lppTemperature, 'value': 21.5},
      {'channel': 1, 'type': CayenneLpp.lppRelativeHumidity, 'value': 400},
    ], source: TelemetrySource.telemetry);
    expect(got.single.value, 21.5);
    telemetry.dispose();
  });
}
