import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/services/repeater_status_history.dart';
import 'package:meshcore_open/widgets/repeater_history_widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final radio = 'a' * 64;
final ridge = 'b' * 64;

void main() {
  late SharedPreferences prefs;
  var now = DateTime(2026, 11, 1, 12);

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    now = DateTime(2026, 11, 1, 12);
  });

  RepeaterStatusHistory make() =>
      RepeaterStatusHistory(prefs, clock: () => now)..setScope(radio);

  test('parts of one check merge; later checks add a sample', () {
    final h = make();
    h.recordStatus(ridge, StatusSample(at: now, batteryMv: 4100, errors: 2));
    h.recordStatus(
      ridge,
      StatusSample(at: now.add(const Duration(seconds: 5)), noiseFloor: -110),
    );
    expect(h.statusFor(ridge), hasLength(1));
    expect(h.statusFor(ridge).single.batteryMv, 4100);
    expect(h.statusFor(ridge).single.noiseFloor, -110);

    now = now.add(const Duration(hours: 1));
    h.recordStatus(ridge, StatusSample(at: now, batteryMv: 4050));
    expect(h.statusFor(ridge), hasLength(2));
    expect(h.statusFor(ridge).last.valueOf(StatusMetric.battery), 4.05);
    h.dispose();
  });

  test('history survives a restart and is kept per radio', () async {
    final h = make();
    h.recordStatus(ridge, StatusSample(at: now, rssi: -90, snr: 6.5));
    h.recordNeighbours(ridge, {'0a1b2c3d': (snr: 7.25, heardSecsAgo: 30)});
    await h.flush();
    h.dispose();

    final again = make();
    expect(again.statusFor(ridge).single.rssi, -90);
    expect(again.statusFor(ridge).single.snr, 6.5);
    final snr = again.snrFor(ridge, '0A1B2C3D');
    expect(snr.single.snr, 7.25);
    expect(snr.single.at, now.subtract(const Duration(seconds: 30)));

    again.setScope('c' * 64);
    expect(again.statusFor(ridge), isEmpty);
    again.dispose();
  });

  test('the same neighbour reading asked twice is kept once', () {
    final h = make();
    h.recordNeighbours(ridge, {'0a1b2c3d': (snr: 5, heardSecsAgo: 60)});
    now = now.add(const Duration(seconds: 20));
    h.recordNeighbours(ridge, {'0a1b2c3d': (snr: 5, heardSecsAgo: 80)});
    expect(h.snrFor(ridge, '0a1b2c3d'), hasLength(1));
    now = now.add(const Duration(minutes: 10));
    h.recordNeighbours(ridge, {'0a1b2c3d': (snr: -2, heardSecsAgo: 5)});
    expect(h.snrFor(ridge, '0a1b2c3d').map((s) => s.snr), [5, -2]);
    h.dispose();
  });

  test('old readings drop off and clear forgets a repeater', () {
    final h = make();
    h.recordStatus(ridge, StatusSample(at: now, batteryMv: 4000));
    now = now.add(const Duration(days: 31));
    h.recordStatus(ridge, StatusSample(at: now, batteryMv: 3900));
    expect(h.statusFor(ridge).single.batteryMv, 3900);
    h.clear(ridge);
    expect(h.statusFor(ridge), isEmpty);
    h.dispose();
  });

  test('nothing is kept without a radio or for bad keys', () {
    final h = RepeaterStatusHistory(prefs, clock: () => now);
    h.recordStatus(ridge, StatusSample(at: now, batteryMv: 4000));
    expect(h.statusFor(ridge), isEmpty);
    h.setScope(radio);
    h.recordStatus('xyz', StatusSample(at: now, batteryMv: 4000));
    h.recordStatus(ridge, StatusSample(at: now));
    expect(h.statusFor(ridge), isEmpty);
    h.dispose();
  });

  testWidgets('history card charts the chosen metric', (tester) async {
    final h = make();
    h.recordStatus(
      ridge,
      StatusSample(at: now.subtract(const Duration(hours: 3)), batteryMv: 4100),
    );
    h.recordStatus(ridge, StatusSample(at: now, batteryMv: 4000));
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ChangeNotifierProvider<RepeaterStatusHistory?>.value(
            value: h,
            child: SingleChildScrollView(
              child: RepeaterStatusHistoryCard(repeaterKey: ridge),
            ),
          ),
        ),
      ),
    );
    expect(find.text('Status history'), findsOneWidget);
    expect(find.text('2 saved checks'), findsOneWidget);
    expect(
      find.bySemanticsLabel(RegExp(r'^Battery chart, 2 readings')),
      findsOneWidget,
    );
    await tester.tap(find.text('Noise floor'));
    await tester.pump();
    expect(find.textContaining('No Noise floor readings'), findsOneWidget);
    h.dispose();
  });
}
