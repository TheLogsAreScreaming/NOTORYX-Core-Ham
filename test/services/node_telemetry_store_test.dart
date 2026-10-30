import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meshcore_open/helpers/cayenne_lpp.dart';
import 'package:meshcore_open/services/node_telemetry_store.dart';

final radio = 'a' * 64;
final node = 'b' * 64;
Map<String, dynamic> reading(int type, num value, {int channel = 1}) => {
  'channel': channel,
  'type': type,
  'value': value,
};

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late SharedPreferences prefs;
  late NodeTelemetryStore store;
  late DateTime now;
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    now = DateTime.utc(2026, 10, 30, 12);
    store = NodeTelemetryStore(prefs, clock: () => now)..setScope(radio);
  });
  tearDown(() async {
    await store.flush();
    store.dispose();
  });

  test(
    'rapid identity switches retain readings before disk writes finish',
    () async {
      store.record(node, [
        reading(CayenneLpp.lppTemperature, 21),
      ], source: TelemetrySource.telemetry);
      store.setScope('c' * 64);
      store.setScope(radio);
      expect(store.metricFor(node, TelemetryMetric.temperature)!.value, 21);
      await store.flush();
    },
  );

  test('partial updates preserve independent timestamps and sources', () {
    store.record(node, [
      reading(CayenneLpp.lppTemperature, 21),
    ], source: TelemetrySource.sensor);
    final first = now;
    now = now.add(const Duration(hours: 2));
    store.record(node, [
      reading(CayenneLpp.lppVoltage, 4.1),
    ], source: TelemetrySource.status);
    final temperature = store.metricFor(node, TelemetryMetric.temperature)!;
    expect(temperature.at, first);
    expect(temperature.source, TelemetrySource.sensor);
    expect(temperature.staleAt(now), isTrue);
    expect(
      store.metricFor(node, TelemetryMetric.battery)!.staleAt(now),
      isFalse,
    );
  });

  test('ages dim at one hour and expire at 24 hours without more traffic', () {
    store.record(node, [
      reading(CayenneLpp.lppTemperature, 21),
    ], source: TelemetrySource.telemetry);
    now = now.add(const Duration(minutes: 59));
    expect(
      store.metricFor(node, TelemetryMetric.temperature)!.staleAt(now),
      isFalse,
    );
    now = now.add(const Duration(minutes: 1));
    expect(
      store.metricFor(node, TelemetryMetric.temperature)!.staleAt(now),
      isTrue,
    );
    now = now.add(const Duration(hours: 23));
    expect(store.readingsFor(node), isEmpty);
  });

  test('saves and restores data and isolates radio identities', () async {
    store.record(node, [
      reading(CayenneLpp.lppVoltage, 4.2),
    ], source: TelemetrySource.status);
    await store.flush();
    final restored = NodeTelemetryStore(prefs, clock: () => now)
      ..setScope(radio);
    addTearDown(restored.dispose);
    expect(restored.metricFor(node, TelemetryMetric.battery)!.value, 4.2);
    restored.setScope('c' * 64);
    expect(restored.readingsFor(node), isEmpty);
    restored.record(node, [
      reading(CayenneLpp.lppVoltage, 3.7),
    ], source: TelemetrySource.status);
    await restored.flush();
    restored.setScope(radio);
    expect(restored.metricFor(node, TelemetryMetric.battery)!.value, 4.2);
  });

  test('rejects malformed and future values and out-of-order updates', () {
    store.record(node, [
      reading(CayenneLpp.lppTemperature, 20),
    ], source: TelemetrySource.telemetry);
    store.record(
      node,
      [reading(CayenneLpp.lppTemperature, 10)],
      source: TelemetrySource.telemetry,
      at: now.subtract(const Duration(minutes: 1)),
    );
    store.record(
      node,
      [reading(CayenneLpp.lppTemperature, 99)],
      source: TelemetrySource.telemetry,
      at: now.add(const Duration(minutes: 1)),
    );
    store.record(node, [
      reading(CayenneLpp.lppVoltage, double.nan),
      reading(CayenneLpp.lppRelativeHumidity, 101),
      reading(CayenneLpp.lppVoltage, 3, channel: -1),
    ], source: TelemetrySource.telemetry);
    expect(store.readingsFor(node).length, 1);
    expect(store.metricFor(node, TelemetryMetric.temperature)!.value, 20);
  });

  test(
    'channels stay separate and percentage sensors are not guessed as batteries',
    () {
      store.record(node, [
        reading(CayenneLpp.lppTemperature, 20),
        reading(CayenneLpp.lppTemperature, 30, channel: 2),
        reading(CayenneLpp.lppPercentage, 60),
      ], source: TelemetrySource.sensor);
      expect(store.readingsFor(node).length, 3);
      expect(store.metricFor(node, TelemetryMetric.battery), isNull);
    },
  );

  test('bounds nodes by recency and measurements per node', () {
    final bounded = NodeTelemetryStore(prefs, clock: () => now, maxNodes: 2)
      ..setScope(radio);
    addTearDown(bounded.dispose);
    for (var i = 1; i <= 3; i++) {
      now = now.add(const Duration(seconds: 1));
      bounded.record('$i' * 64, [
        reading(CayenneLpp.lppTemperature, i),
      ], source: TelemetrySource.sensor);
    }
    expect(bounded.nodeCount, 2);
    expect(bounded.readingsFor('1' * 64), isEmpty);
    bounded.record('3' * 64, [
      for (var i = 0; i < 50; i++)
        reading(CayenneLpp.lppTemperature, i, channel: i),
    ], source: TelemetrySource.sensor);
    expect(bounded.readingsFor('3' * 64).length, 32);
  });

  test('corrupt persistence does not prevent new readings', () async {
    await prefs.setString('node_telemetry_v1_${'d' * 64}', '{broken');
    store.setScope('d' * 64);
    expect(store.nodeCount, 0);
    store.record(node, [
      reading(CayenneLpp.lppTemperature, 21),
    ], source: TelemetrySource.telemetry);
    expect(store.nodeCount, 1);
  });
}
