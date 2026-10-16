import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/helpers/cayenne_lpp.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/sensor_subscription.dart';
import 'package:meshcore_open/services/sensor_subscription_service.dart';
import 'package:meshcore_open/widgets/sensor_live_card.dart';

final _sensor = Contact(
  publicKey: Uint8List.fromList(List.generate(32, (i) => 0x40 + i)),
  name: 'Creek gauge',
  type: advTypeSensor,
  pathLength: -1,
  path: Uint8List(0),
  lastSeen: DateTime.now(),
);

const _temp = WatchedReading(2, CayenneLpp.lppTemperature, 0.5);
const _volts = WatchedReading(1, CayenneLpp.lppVoltage, 0.1);

Uint8List _le32(int v) =>
    Uint8List(4)..buffer.asByteData().setUint32(0, v, Endian.little);

/// Answers binary requests like a companion forwarding a sensor's reply.
class _Radio extends MeshCoreConnector {
  final frames = StreamController<Uint8List>.broadcast();
  final requests = <Uint8List>[];
  int replySeconds = 3600;
  bool answer = true;

  @override
  bool get isConnected => true;
  @override
  Stream<Uint8List> get receivedFrames => frames.stream;

  @override
  Future<void> sendFrame(
    Uint8List frame, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async {
    expect(frame[0], cmdSendBinaryReq);
    final payload = frame.sublist(33);
    requests.add(payload);
    final tag = _le32(0xA1B2C3D4);
    scheduleMicrotask(() {
      frames.add(Uint8List.fromList([respCodeSent, 0, ...tag, 0, 0, 0, 0]));
      if (!answer) return;
      final data = payload[0] == reqTypeSubscribe
          ? [
              replySeconds & 0xFF,
              replySeconds >> 8,
              0,
              0,
              ...'default'.codeUnits,
              0,
            ]
          : List.filled(10, 0);
      frames.add(
        Uint8List.fromList([pushCodeBinaryResponse, 0, ...tag, ...data]),
      );
    });
  }

  void push(int tag, List<int> lpp) => frames.add(
    Uint8List.fromList([
      pushCodeBinaryResponse,
      0,
      ..._le32(tag),
      ..._le32(1760600000),
      ...lpp,
    ]),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('protocol', () {
    test('thresholds are LPP: channel, type, big-endian scaled value', () {
      expect(encodeMinDeltas([_temp, _volts]), [
        2, 103, 0x00, 0x05, // 0.5 °C in 0.1 steps
        1, 116, 0x00, 0x0A, // 0.1 V in 0.01 steps
      ]);
      expect(() => encodeMinDeltas([]), throwsArgumentError);
      expect(
        () => encodeMinDeltas([_temp, _temp, _temp, _temp]),
        throwsArgumentError,
        reason: '16 bytes is over the sensor limit of 14',
      );
    });

    test('subscribe payload matches the sensor firmware', () {
      final p = buildSubscribePayload(
        pushTag: 0x01020304,
        duration: const Duration(hours: 1),
        readings: [_temp],
      );
      expect(p, [
        reqTypeSubscribe,
        0x04, 0x03, 0x02, 0x01, // push tag, little-endian
        0x10, 0x0E, // 3600 s
        0, // reserved
        4, // thresholds length
        2, 103, 0, 5,
      ]);
      // 24 h doesn't fit 16 bits; it is capped.
      final long = buildSubscribePayload(
        pushTag: 1,
        duration: const Duration(hours: 24),
        readings: [_temp],
      );
      expect(long[5] | long[6] << 8, maxSubscriptionSeconds);
      expect(buildUnsubscribePayload(), [reqTypeUnsubscribe]);
    });

    test('replies and pushes parse', () {
      final ok = parseSubscribeReply(
        Uint8List.fromList([0x10, 0x0E, 0, 0, ...'west'.codeUnits, 0]),
      );
      expect(ok.accepted, true);
      expect(ok.seconds, 3600);
      expect(ok.scope, 'west');
      expect(parseSubscribeReply(Uint8List(4)).accepted, false);
      final push = parseSensorPush(
        Uint8List.fromList([
          0x8C,
          0,
          ..._le32(7),
          ..._le32(10),
          2,
          103,
          0,
          215,
        ]),
      )!;
      expect(push.tag, 7);
      expect(push.sensorTime, DateTime.utc(1970, 1, 1, 0, 0, 10));
      expect(CayenneLpp.parse(push.lpp).single['value'], 21.5);
    });
  });

  group('service', () {
    late _Radio radio;
    late SensorSubscriptionService service;
    setUp(() {
      radio = _Radio();
      service = SensorSubscriptionService(radio, random: Random(1));
    });
    tearDown(() {
      service.dispose();
      radio.frames.close();
      radio.dispose();
    });

    test('subscribes, collects matching pushes, ignores others', () async {
      final sub = await service.subscribe(
        _sensor,
        readings: [_temp],
        duration: const Duration(hours: 1),
      );
      expect(radio.requests.single[0], reqTypeSubscribe);
      expect(sub.scope, 'default');
      expect(service.subscriptionFor(_sensor), same(sub));
      final tag = radio.requests.single.buffer
          .asByteData(radio.requests.single.offsetInBytes)
          .getUint32(1, Endian.little);
      expect(sub.pushTag, tag);

      radio.push(tag ^ 1, [2, 103, 0, 200]); // someone else's push
      radio.push(tag, [2, 103, 0, 215, 1, 116, 0x01, 0x90]);
      await pumpEventQueue();
      expect(sub.pushes, hasLength(1));
      expect(sub.pushes.first.readings.first['value'], 21.5);
      expect(sub.pushes.first.readings.last['value'], 4.0);

      await service.unsubscribe(_sensor);
      expect(radio.requests.last, [reqTypeUnsubscribe]);
      expect(service.subscriptionFor(_sensor), isNull);
    });

    test('a refusal is reported and nothing is kept', () async {
      radio.replySeconds = 0;
      await expectLater(
        service.subscribe(
          _sensor,
          readings: [_temp],
          duration: const Duration(hours: 1),
        ),
        throwsA(isA<StateError>()),
      );
      expect(service.active, isEmpty);
    });

    test('no answer times out', () async {
      radio.answer = false;
      await expectLater(
        service.subscribe(
          _sensor,
          readings: [_temp],
          duration: const Duration(hours: 1),
          timeout: const Duration(milliseconds: 50),
        ),
        throwsA(isA<StateError>()),
      );
    });
  });

  group('card', () {
    test('offers only watchable readings, once each', () {
      final options = watchOptions([
        {'channel': 1, 'type': CayenneLpp.lppVoltage, 'value': 4.1},
        {'channel': 2, 'type': CayenneLpp.lppTemperature, 'value': 21.5},
        {'channel': 2, 'type': CayenneLpp.lppTemperature, 'value': 21.5},
        {'channel': 3, 'type': CayenneLpp.lppGps, 'value': null},
      ]);
      expect(options.map((o) => o.type), [116, 103]);
      expect(describeWatch(options.last), 'temperature (ch 2) ±0.5 °C');
      expect(
        describeReading({'channel': 2, 'type': 103, 'value': 21.5}),
        'Temperature (ch 2): 21.5 °C',
      );
    });

    testWidgets('shows a live subscription and its latest push', (
      tester,
    ) async {
      final radio = _Radio();
      final service = SensorSubscriptionService(radio, random: Random(2));
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: service,
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              body: SensorLiveCard(
                sensor: _sensor,
                current: const [
                  {'channel': 2, 'type': 103, 'value': 21.5},
                ],
              ),
            ),
          ),
        ),
      );
      expect(find.text('Watch for changes'), findsOneWidget);
      late SensorSubscription sub;
      await tester.runAsync(() async {
        sub = await service.subscribe(
          _sensor,
          readings: [_temp],
          duration: const Duration(hours: 1),
        );
        radio.push(sub.pushTag, [2, 103, 0, 230]);
        await pumpEventQueue();
      });
      await tester.pump();
      expect(
        find.textContaining('Watching temperature (ch 2)'),
        findsOneWidget,
      );
      expect(find.text('Temperature (ch 2): 23 °C'), findsOneWidget);
      expect(find.text('Stop live updates'), findsOneWidget);
      service.dispose();
      await radio.frames.close();
      radio.dispose();
    });
  });
}
