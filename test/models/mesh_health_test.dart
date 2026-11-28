import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/mesh_health.dart';
import 'package:meshcore_open/widgets/mesh_health_card.dart';
import 'package:provider/provider.dart';

MeshHealth run({
  int? noise = -115,
  double? snr = 8,
  double? busy = 0.05,
  int neighbours = 4,
  int delivered = 9,
  int failed = 1,
}) => assessMeshHealth(
  MeshHealthInputs(
    noiseFloorDbm: noise,
    lastSnrDb: snr,
    busyFraction: busy,
    neighboursLastHour: neighbours,
    delivered: delivered,
    failed: failed,
  ),
);

HealthGrade gradeOf(MeshHealth h, HealthFactor f) =>
    h.readings.firstWhere((r) => r.factor == f).grade;

final t0 = DateTime(2026, 11, 8, 12);

void main() {
  test('all good is good, with no tip', () {
    final h = run();
    expect(h.overall, HealthGrade.good);
    expect(h.weakest, isNull);
  });

  test('the overall grade is the worst known factor', () {
    final h = run(noise: -95);
    expect(gradeOf(h, HealthFactor.noise), HealthGrade.poor);
    expect(h.overall, HealthGrade.poor);
    expect(h.weakest!.factor, HealthFactor.noise);
  });

  test('bands', () {
    expect(gradeOf(run(noise: -110), HealthFactor.noise), HealthGrade.good);
    expect(gradeOf(run(noise: -105), HealthFactor.noise), HealthGrade.fair);
    expect(gradeOf(run(snr: 5), HealthFactor.signal), HealthGrade.good);
    expect(gradeOf(run(snr: 0), HealthFactor.signal), HealthGrade.fair);
    expect(gradeOf(run(snr: -8), HealthFactor.signal), HealthGrade.poor);
    expect(gradeOf(run(busy: 0.2), HealthFactor.busy), HealthGrade.fair);
    expect(gradeOf(run(busy: 0.4), HealthFactor.busy), HealthGrade.poor);
    expect(
      gradeOf(run(neighbours: 1), HealthFactor.neighbours),
      HealthGrade.fair,
    );
    expect(
      gradeOf(run(neighbours: 0), HealthFactor.neighbours),
      HealthGrade.poor,
    );
    expect(
      gradeOf(run(delivered: 6, failed: 4), HealthFactor.delivery),
      HealthGrade.fair,
    );
    expect(
      gradeOf(run(delivered: 1, failed: 4), HealthFactor.delivery),
      HealthGrade.poor,
    );
  });

  test('too few messages says nothing about delivery', () {
    expect(
      gradeOf(run(delivered: 0, failed: 2), HealthFactor.delivery),
      HealthGrade.unknown,
    );
  });

  test('unknowns are left out of the overall grade', () {
    final h = run(noise: null, snr: null, busy: null, delivered: 0, failed: 0);
    expect(h.overall, HealthGrade.good, reason: 'only neighbours known');
    final none = assessMeshHealth(
      const MeshHealthInputs(neighboursLastHour: 0, delivered: 0, failed: 0),
    );
    expect(none.overall, HealthGrade.poor, reason: 'zero neighbours is known');
  });

  group('busyFraction', () {
    test('air seconds over the span', () {
      final samples = [
        AirtimeSample(t0, 100),
        AirtimeSample(t0.add(const Duration(minutes: 5)), 130),
      ];
      expect(busyFraction(samples), closeTo(0.1, 0.001));
    });

    test('needs two samples at least 2 minutes apart', () {
      expect(busyFraction([AirtimeSample(t0, 1)]), isNull);
      expect(
        busyFraction([
          AirtimeSample(t0, 1),
          AirtimeSample(t0.add(const Duration(minutes: 1)), 5),
        ]),
        isNull,
      );
    });

    test('a radio reboot (counters reset) gives no answer', () {
      expect(
        busyFraction([
          AirtimeSample(t0, 500),
          AirtimeSample(t0.add(const Duration(minutes: 5)), 3),
        ]),
        isNull,
      );
    });

    test('only the last 15 minutes count', () {
      final samples = [
        AirtimeSample(t0, 0),
        AirtimeSample(t0.add(const Duration(minutes: 20)), 600),
        AirtimeSample(t0.add(const Duration(minutes: 30)), 660),
      ];
      expect(busyFraction(samples), closeTo(0.1, 0.001));
    });
  });

  test('the connector keeps airtime samples from stats frames', () {
    final radio = MeshCoreConnector();
    Uint8List frame(int tx, int rx) {
      final b = ByteData(14)
        ..setUint8(0, respCodeStats)
        ..setUint8(1, statsTypeRadio)
        ..setInt16(2, -112, Endian.little)
        ..setInt8(4, -90)
        ..setInt8(5, 32)
        ..setUint32(6, tx, Endian.little)
        ..setUint32(10, rx, Endian.little);
      return b.buffer.asUint8List();
    }

    radio.debugHandleStatsFrame(frame(10, 20));
    radio.debugHandleStatsFrame(frame(12, 25));
    expect(radio.airtimeSamples.map((s) => s.airSecs), [30, 37]);
    expect(radio.latestRadioStats!.noiseFloorDbm, -112);
    radio.dispose();
  });

  testWidgets('the card says it in words, with a tip, at 320 px and 2x', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 900);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    final radio = MeshCoreConnector();
    await tester.pumpWidget(
      ChangeNotifierProvider<MeshCoreConnector>.value(
        value: radio,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: MeshHealthCard(health: run(neighbours: 0, busy: 0.3)),
            ),
          ),
        ),
      ),
    );
    expect(find.text('The mesh is struggling'), findsOneWidget);
    expect(find.textContaining('Heard directly: Poor'), findsOneWidget);
    expect(
      find.textContaining('on air 30% of the last 15 minutes'),
      findsOneWidget,
    );
    expect(find.textContaining('The channel is busy'), findsOneWidget);
    expect(tester.takeException(), isNull);
    radio.dispose();
  });
}
