import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/radio_settings.dart';
import 'package:meshcore_open/screens/settings_screen.dart';
import 'package:meshcore_open/utils/amateur_radio.dart';

RadioSettings _preset(String name) =>
    RadioSettings.presets.firstWhere((p) => p.$1 == name).$2;

void main() {
  test('the catalogue starts with the ham firmware default', () {
    final def = _preset('US 33cm');
    expect(def.frequencyHz, 906875);
    expect(def.spreadingFactor, LoRaSpreadingFactor.sf10);
    expect(def.bandwidth, LoRaBandwidth.bw250);
    expect(def.codingRate, LoRaCodingRate.cr4_5);
    expect(def.summary, '906.875 MHz · SF 10 · BW 250 · CR 4/5');
    expect(RadioSettings.presets.first.$1, 'US 33cm');
  });

  test('every preset is in a ham band', () {
    for (final (name, preset) in RadioSettings.presets) {
      expect(isAmateurFrequencyMHz(preset.frequencyMHz), isTrue, reason: name);
    }
  });

  test('every preset name is unique', () {
    final names = RadioSettings.presets.map((p) => p.$1).toList();
    expect(names.toSet().length, names.length);
  });

  test('the suggested preset is the US 33 cm default', () {
    expect(RadioSettings.suggestedPresetFor('US'), 'US 33cm');
    expect(RadioSettings.suggestedPresetFor('us'), 'US 33cm');
    expect(RadioSettings.suggestedPresetFor('CA'), isNull);
    expect(RadioSettings.suggestedPresetFor(null), isNull);
  });

  group('picker', () {
    final indexes = [
      for (var i = 0; i < RadioSettings.presets.length; i++)
        if (!RadioSettings.presets[i].$1.startsWith('Off-Grid ')) i,
    ];
    final usa = RadioSettings.presets.indexWhere((p) => p.$1 == 'US 33cm');

    Future<List<int?>> open(WidgetTester tester) async {
      final picked = <int?>[];
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () async => picked.add(
                  await showModalBottomSheet<int>(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => RadioPresetPicker(
                      indexes: indexes,
                      selected: usa,
                      suggested: 'US 33cm',
                    ),
                  ),
                ),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      return picked;
    }

    testWidgets('suggests the region’s preset first and returns a pick', (
      tester,
    ) async {
      final picked = await open(tester);
      expect(find.text('Suggested for your region'), findsOneWidget);
      expect(find.text('US 33cm'), findsWidgets);
      await tester.tap(find.text('US 33cm').first);
      await tester.pumpAndSettle();
      expect(picked, [usa]);
    });

    testWidgets('search narrows the list', (tester) async {
      await open(tester);
      await tester.enterText(
        find.byKey(const ValueKey('radio-preset-search')),
        '70cm',
      );
      await tester.pumpAndSettle();
      expect(find.text('Suggested for your region'), findsNothing);
      expect(find.text('US 70cm'), findsOneWidget);
      expect(find.text('US 33cm Long Range'), findsNothing);
    });
  });
}
