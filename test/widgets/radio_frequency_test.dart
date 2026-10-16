import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/widgets/radio_overview_card.dart';

class _Radio extends MeshCoreConnector {
  @override
  int? get currentFreqHz => 911000; // what a radio set to 911 MHz reports
  @override
  int? get currentBwHz => 62500;
  @override
  int? get currentSf => 7;
  @override
  int? get currentCr => 5;
  @override
  int? get currentTxPower => 22;
}

void main() {
  test('radios report kHz; Hz values are still understood', () {
    expect(radioFrequencyMHz(911000), 911.0);
    expect(radioFrequencyMHz(910525), 910.525);
    expect(radioFrequencyMHz(869525), 869.525);
    expect(radioFrequencyMHz(433175), 433.175);
    expect(radioFrequencyMHz(910525000), 910.525);
    expect(radioFrequencyMHz(null), isNull);
    expect(radioFrequencyMHz(0), isNull);
  });

  testWidgets('the radio overview shows 911 MHz, not 0.911', (tester) async {
    final radio = _Radio();
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: RadioOverviewCard(connector: radio)),
      ),
    );
    expect(find.text('911 MHz · SF7 · BW62.5 · CR5 · 22 dBm'), findsOneWidget);
    radio.dispose();
  });
}
