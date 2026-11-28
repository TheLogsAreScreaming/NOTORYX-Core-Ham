import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/troubleshooting.dart';
import 'package:meshcore_open/screens/troubleshooting_screen.dart';
import 'package:provider/provider.dart';

TroubleSnapshot snap({
  bool connected = true,
  int messaged = 3,
  int noRoute = 0,
  int notHeard = 0,
  int neighbours = 2,
  bool? noisePoor = false,
}) => TroubleSnapshot(
  connected: connected,
  messagedContacts: messaged,
  messagedWithoutRoute: noRoute,
  messagedNotHeardInDay: notHeard,
  neighboursLastHour: neighbours,
  noisePoor: noisePoor,
);

StepResult resultOf(List<(TroubleStep, StepResult)> steps, TroubleStep s) =>
    steps.firstWhere((e) => e.$1 == s).$2;

void main() {
  test('delivery guide: all good means nowhere to start', () {
    final steps = runGuide(TroubleGuide.noDelivery, snap());
    expect(steps.every((s) => s.$2 == StepResult.ok), isTrue);
    expect(startHere(steps), isNull);
  });

  test('delivery guide starts at the first problem', () {
    final steps = runGuide(
      TroubleGuide.noDelivery,
      snap(noRoute: 1, neighbours: 0),
    );
    expect(resultOf(steps, TroubleStep.routes), StepResult.problem);
    expect(startHere(steps), TroubleStep.routes);
  });

  test('not connected: radio checks are unchecked, start at connecting', () {
    final steps = runGuide(TroubleGuide.hearNobody, snap(connected: false));
    expect(resultOf(steps, TroubleStep.connected), StepResult.problem);
    expect(resultOf(steps, TroubleStep.neighbours), StepResult.unchecked);
    expect(resultOf(steps, TroubleStep.noise), StepResult.unchecked);
    expect(startHere(steps), TroubleStep.connected);
  });

  test('nobody messaged: delivery checks can\'t run', () {
    final steps = runGuide(TroubleGuide.noDelivery, snap(messaged: 0));
    expect(resultOf(steps, TroubleStep.routes), StepResult.unchecked);
    expect(startHere(steps), TroubleStep.routes);
  });

  test('hear-nobody flags noise and empty neighbours', () {
    final steps = runGuide(
      TroubleGuide.hearNobody,
      snap(noisePoor: true, neighbours: 0),
    );
    expect(resultOf(steps, TroubleStep.noise), StepResult.problem);
    expect(resultOf(steps, TroubleStep.neighbours), StepResult.problem);
    expect(startHere(steps), TroubleStep.noise);
  });

  test('connect guide: with nothing checkable, start at the first step', () {
    final steps = runGuide(TroubleGuide.noConnect, snap(connected: false));
    expect(startHere(steps), TroubleStep.connected);
    final now = runGuide(TroubleGuide.noConnect, snap());
    expect(startHere(now), TroubleStep.bluetooth);
  });

  testWidgets('the screen walks a guide at 320 px and 2x text', (tester) async {
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
          home: const TroubleshootingScreen(guide: TroubleGuide.hearNobody),
        ),
      ),
    );
    expect(find.text('Start here'), findsOneWidget);
    expect(find.textContaining('1. Your radio is connected'), findsOneWidget);
    expect(find.textContaining('Connect your radio first'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text("Can't connect to my radio"));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.textContaining('Try another way to connect'),
      200,
    );
    expect(find.textContaining('Try another way to connect'), findsOneWidget);
    expect(tester.takeException(), isNull);
    radio.dispose();
  });
}
