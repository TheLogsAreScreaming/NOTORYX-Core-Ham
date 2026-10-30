import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/helpers/cayenne_lpp.dart';
import 'package:meshcore_open/services/my_sensors_service.dart';

final _self = Uint8List.fromList(List.generate(32, (i) => i + 10));

class _Radio extends MeshCoreConnector {
  final frames = StreamController<Uint8List>.broadcast();
  bool connected = true;

  /// What the radio answers a telemetry request with; null = silence.
  Uint8List? Function()? answer;

  @override
  bool get isConnected => connected;
  @override
  Uint8List? get selfPublicKey => _self;
  @override
  Stream<Uint8List> get receivedFrames => frames.stream;
  @override
  Future<void> sendFrame(
    Uint8List data, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async {
    final reply = answer?.call();
    if (reply != null) scheduleMicrotask(() => frames.add(reply));
  }
}

Uint8List _reply(Uint8List key, Uint8List lpp) => Uint8List.fromList([
  pushCodeTelemetryResponse,
  0,
  ...key.sublist(0, 6),
  ...lpp,
]);

Uint8List _lpp() =>
    (CayenneLpp()
          ..addVoltage(1, 4.19)
          ..addTemperature(1, 20.5)
          ..addGps(1, 41.328, -73.094, 0))
        .toBytes();

void main() {
  test('reads and formats the radio’s own sensors', () async {
    final radio = _Radio()..answer = () => _reply(_self, _lpp());
    final sensors = MySensorsService(radio);
    await sensors.refresh();
    expect(sensors.failed, isFalse);
    expect(sensors.updated, isNotNull);
    expect(sensors.readings.map(formatSensorReading), [
      '4.19 V',
      '20.5 °C',
      '41.328, -73.094 @0m',
    ]);
  });

  test('another node’s telemetry is not taken for ours', () async {
    final other = Uint8List.fromList(List.filled(32, 7));
    final radio = _Radio()..answer = () => _reply(other, _lpp());
    final sensors = MySensorsService(
      radio,
      timeout: const Duration(milliseconds: 50),
    );
    await sensors.refresh();
    expect(sensors.failed, isTrue);
    expect(sensors.readings, isEmpty);
  });

  test('no answer or no radio is a failure, not a hang', () async {
    final silent = MySensorsService(
      _Radio(),
      timeout: const Duration(milliseconds: 50),
    );
    await silent.refresh();
    expect(silent.failed, isTrue);
    expect(silent.loading, isFalse);

    final offline = MySensorsService(_Radio()..connected = false);
    await offline.refresh();
    expect(offline.failed, isTrue);
  });

  test('readings the panel does not show are skipped', () {
    expect(
      formatSensorReading({'type': CayenneLpp.lppAccelerometer, 'value': {}}),
      isNull,
    );
    expect(
      formatSensorReading({
        'type': CayenneLpp.lppGps,
        'value': {'latitude': 0, 'longitude': 0, 'altitude': 0},
      }),
      isNull,
    );
    expect(
      formatSensorReading({'type': CayenneLpp.lppLuminosity, 'value': 19}),
      '19 lx',
    );
  });
}
