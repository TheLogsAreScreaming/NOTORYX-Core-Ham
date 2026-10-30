import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/radio_settings.dart';
import 'package:meshcore_open/screens/settings_screen.dart';

RadioSettings _preset(String name) =>
    RadioSettings.presets.firstWhere((p) => p.$1 == name).$2;

void main() {
  test('the catalogue has MeshCore’s USA and Canada presets', () {
    final usa = _preset('USA');
    expect(usa.frequencyHz, 910525);
    expect(usa.spreadingFactor, LoRaSpreadingFactor.sf7);
    expect(usa.bandwidth, LoRaBandwidth.bw62_5);
    expect(usa.codingRate, LoRaCodingRate.cr4_5);
    expect(usa.summary, '910.525 MHz · SF 7 · BW 62.5 · CR 4/5');
    expect(_preset('Canada').frequencyHz, 910525);
    expect(_preset('USA - Southern California').frequencyHz, 927875);
    expect(_preset('EU/UK (Narrow)').codingRate, LoRaCodingRate.cr4_8);
  });

  test('every preset name is unique', () {
    final names = RadioSettings.presets.map((p) => p.$1).toList();
    expect(names.toSet().length, names.length);
  });

  test('the suggested preset follows the device country', () {
    expect(RadioSettings.suggestedPresetFor('US'), 'USA');
    expect(RadioSettings.suggestedPresetFor('ca'), 'Canada');
    expect(RadioSettings.suggestedPresetFor('DE'), 'EU/UK (Narrow)');
    expect(RadioSettings.suggestedPresetFor('JP'), isNull);
    expect(RadioSettings.suggestedPresetFor(null), isNull);
    for (final code in ['US', 'CA', 'AU', 'NZ', 'NL', 'CH', 'GB', 'VN']) {
      final name = RadioSettings.suggestedPresetFor(code);
      expect(
        RadioSettings.presets.any((p) => p.$1 == name),
        isTrue,
        reason: code,
      );
    }
  });

  group('picker', () {
    final indexes = [
      for (var i = 0; i < RadioSettings.presets.length; i++)
        if (!RadioSettings.presets[i].$1.startsWith('Off-Grid ')) i,
    ];
    final usa = RadioSettings.presets.indexWhere((p) => p.$1 == 'USA');

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
                      suggested: 'USA',
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
      expect(find.text('USA'), findsWidgets);
      await tester.tap(find.text('USA').first);
      await tester.pumpAndSettle();
      expect(picked, [usa]);
    });

    testWidgets('search narrows the list', (tester) async {
      await open(tester);
      await tester.enterText(
        find.byKey(const ValueKey('radio-preset-search')),
        'canada',
      );
      await tester.pumpAndSettle();
      expect(find.text('Suggested for your region'), findsNothing);
      expect(find.text('Canada'), findsOneWidget);
      expect(find.text('Australia'), findsNothing);
    });
  });
}
