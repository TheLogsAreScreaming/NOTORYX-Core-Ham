import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/app_settings.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:meshcore_open/theme/mesh_theme.dart';
import 'package:meshcore_open/widgets/theme_picker.dart';

double contrast(Color a, Color b) {
  final x = a.computeLuminance(), y = b.computeLuminance();
  return x > y ? (x + .05) / (y + .05) : (y + .05) / (x + .05);
}

/// Every palette a person can end up looking at: the seven fixed themes and
/// each of Seasonal's looks.
Map<String, BastionPalette> allPalettes() => {
  for (final t in BastionTheme.values)
    if (t != BastionTheme.seasonal) t.id: t.palette,
  for (final s in Season.values)
    'seasonal ${s.id}': SeasonalTheme.paletteFor(s),
};

Widget picker(AppSettingsService settings, {double textScale = 1}) =>
    ChangeNotifierProvider.value(
      value: settings,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(textScale)),
          child: child!,
        ),
        home: const Scaffold(body: SingleChildScrollView(child: ThemePicker())),
      ),
    );

Future<AppSettingsService> freshSettings([
  Map<String, Object> saved = const {},
]) async {
  SharedPreferences.setMockInitialValues(saved);
  PrefsManager.reset();
  await PrefsManager.initialize();
  final settings = AppSettingsService();
  await settings.loadSettings();
  return settings;
}

void main() {
  tearDown(() {
    MeshPalette.current = BastionTheme.fallback.palette;
    SeasonalTheme.choice = null;
    SeasonalTheme.holidays = false;
    SeasonalTheme.now = DateTime.now;
  });

  test('exactly eight themes, in order, with Blaze the default', () {
    expect(BastionTheme.values.map((t) => t.id), [
      'blaze',
      'neon_anarchy',
      'tactical',
      'pink_overload',
      'bare_beauty',
      'okabe_ito',
      'night_ops',
      'seasonal',
    ]);
    expect(AppSettings().appTheme, 'blaze');
    expect(BastionTheme.fromId(null), BastionTheme.blaze);
    expect(BastionTheme.fromId('nope'), BastionTheme.blaze);
  });

  test('saved ids from earlier versions map to their replacements', () {
    const expected = {
      'blaze': BastionTheme.blaze,
      'autumn_frost': BastionTheme.seasonal,
      'bubble_gum': BastionTheme.pinkOverload,
      'bronzed_blush': BastionTheme.bareBeauty,
      'red_light': BastionTheme.nightOps,
      'okabe_ito': BastionTheme.okabeIto,
      'okabe_ito_slate': BastionTheme.okabeIto,
      'topo_night': BastionTheme.pinkOverload,
      'christmas': BastionTheme.seasonal,
      'alpine_day': BastionTheme.blaze,
      'halloween': BastionTheme.blaze,
    };
    for (final e in expected.entries) {
      expect(BastionTheme.fromId(e.key), e.value, reason: e.key);
    }
  });

  test('every palette reaches WCAG AA contrast', () {
    final misses = <String>[];
    void need(String what, Color a, Color b, double min) {
      final r = contrast(a, b);
      if (r < min) misses.add('$what ${r.toStringAsFixed(2)}');
    }

    for (final MapEntry(key: name, value: p) in allPalettes().entries) {
      final surfaces = {'bg': p.bg, 'bg1': p.bg1, 'bg2': p.bg2, 'bg3': p.bg3};
      final text = {
        'ink': p.ink,
        'ink2': p.ink2,
        'ink3': p.ink3,
        'ink4': p.ink4,
        'signal': p.signal,
        'warn': p.warn,
        'alert': p.alert,
        'accent': p.accent,
      };
      for (final t in text.entries) {
        for (final s in surfaces.entries) {
          need('$name ${t.key} on ${s.key}', t.value, s.value, 4.5);
        }
      }
      for (final s in [p.bg, p.bg1]) {
        need('$name nav', p.nav, s, 4.5);
        need('$name magenta', p.magenta, s, 4.5);
        // Outlines of fields and buttons (non-text controls).
        need('$name line3', p.line3, s, 3);
      }
      need('$name button text', p.onAccent, p.accent, 4.5);
      need('$name own bubble', p.meInk, p.me, 4.5);
      final scheme = MeshTheme.forPalette(p).colorScheme;
      need('$name error text', scheme.onError, scheme.error, 4.5);
      need(
        '$name error box',
        scheme.onErrorContainer,
        scheme.errorContainer,
        4.5,
      );
      expect(scheme.brightness, p.brightness, reason: name);
    }
    expect(misses, isEmpty, reason: misses.join('\n'));
  });

  test('icon hues read on every surface they sit on', () {
    final fails = <String>[];
    for (final MapEntry(key: name, value: p) in allPalettes().entries) {
      for (final (i, c) in p.spectrum.indexed) {
        for (final (surface, bg) in [('bg', p.bg), ('bg2', p.bg2)]) {
          final r = contrast(c, bg);
          if (r < 3) {
            fails.add('$name hue($i) on $surface ${r.toStringAsFixed(2)}');
          }
        }
      }
    }
    expect(fails, isEmpty);
  });

  test('SOS and errors stay red in every theme', () {
    for (final MapEntry(key: name, value: p) in allPalettes().entries) {
      final hue = HSVColor.fromColor(p.alert).hue;
      expect(hue < 20 || hue > 335, isTrue, reason: '$name alert hue $hue');
    }
  });

  test('Okabe-Ito keeps its reference hues and node colours', () {
    expect(OkabeIto.categorical, const [
      Color(0xFFE69F00),
      Color(0xFF56B4E9),
      Color(0xFF009E73),
      Color(0xFFF0E442),
      Color(0xFF0072B2),
      Color(0xFFD55E00),
      Color(0xFFCC79A7),
    ]);
    final p = BastionTheme.okabeIto.palette;
    expect(p.warn, OkabeIto.orange);
    expect(p.accent, OkabeIto.skyBlue);
    expect(p.me, OkabeIto.blue);
    // Error and warning far apart in hue, so they don't blur together with
    // colour-vision deficiencies.
    final gap =
        HSVColor.fromColor(p.warn).hue - HSVColor.fromColor(p.alert).hue;
    expect(gap.abs(), greaterThan(25));
    final types = [advTypeChat, advTypeRepeater, advTypeRoom, advTypeSensor];
    expect(types.map(OkabeIto.nodeType).toSet(), hasLength(4));
    expect(MapPalette.repeater, OkabeIto.nodeType(advTypeRepeater));
  });

  test('Pink Overload and Bare Beauty are clearly different looks', () {
    final pink = BastionTheme.pinkOverload.palette;
    final nude = BastionTheme.bareBeauty.palette;
    expect(pink.brightness, Brightness.light);
    expect(nude.brightness, Brightness.light);
    expect(pink.accent, isNot(nude.accent));
    expect(pink.motif, BackdropMotif.sparkle);
    expect(nude.motif, BackdropMotif.contours);
    // Pink is far more saturated than the natural tones.
    expect(
      HSVColor.fromColor(pink.me).saturation,
      greaterThan(HSVColor.fromColor(nude.me).saturation + 0.3),
    );
    expect(BastionTheme.neonAnarchy.palette.motif, BackdropMotif.grid);
  });

  group('Seasonal', () {
    test('follows the local date', () {
      Season on(int m, int d, {bool holidays = false}) =>
          SeasonalTheme.seasonFor(DateTime(2026, m, d), holidays: holidays);
      expect(on(3, 1), Season.spring);
      expect(on(5, 31), Season.spring);
      expect(on(6, 1), Season.summer);
      expect(on(9, 1), Season.autumn);
      expect(on(11, 30), Season.autumn);
      expect(on(12, 1), Season.winter);
      expect(on(2, 28), Season.winter);
      // Holidays only when switched on.
      expect(on(10, 31), Season.autumn);
      expect(on(10, 31, holidays: true), Season.halloween);
      expect(on(10, 23, holidays: true), Season.autumn);
      expect(on(12, 20, holidays: true), Season.christmas);
      expect(on(12, 27, holidays: true), Season.winter);
      expect(on(2, 14, holidays: true), Season.valentine);
      expect(on(2, 15, holidays: true), Season.winter);
    });

    test('a picked season overrides the date', () {
      SeasonalTheme.now = () => DateTime(2026, 7, 4);
      expect(BastionTheme.seasonal.palette, SeasonalPalettes.summer);
      SeasonalTheme.choice = Season.winter;
      expect(BastionTheme.seasonal.palette, SeasonalPalettes.winter);
    });

    test('other themes never change with the date', () {
      for (final date in [DateTime(2026, 1, 1), DateTime(2026, 10, 31)]) {
        SeasonalTheme.now = () => date;
        SeasonalTheme.holidays = true;
        expect(BastionTheme.blaze.palette.accent, const Color(0xFFFF8A00));
      }
    });

    test('settings keep the choice and the holiday switch', () {
      final saved = AppSettings().copyWith(
        appTheme: 'seasonal',
        seasonalChoice: 'spring',
        seasonalHolidays: true,
      );
      final back = AppSettings.fromJson(saved.toJson());
      expect(back.seasonalChoice, 'spring');
      expect(back.seasonalHolidays, isTrue);
      expect(AppSettings().seasonalChoice, 'auto');
      expect(AppSettings().seasonalHolidays, isFalse);
    });
  });

  for (final (width, scale) in [(320.0, 2.0), (390.0, 1.0), (900.0, 1.0)]) {
    testWidgets(
      'picking a theme saves and restores it ($width px, ${scale}x)',
      (tester) async {
        final settings = await freshSettings();
        await tester.binding.setSurfaceSize(Size(width, 1200));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        await tester.pumpWidget(picker(settings, textScale: scale));
        for (final t in BastionTheme.values) {
          expect(find.byKey(ValueKey('theme-${t.id}')), findsOneWidget);
        }
        final neon = find.byKey(const ValueKey('theme-neon_anarchy'));
        await tester.ensureVisible(neon);
        await tester.tap(neon);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(settings.settings.appTheme, 'neon_anarchy');
        expect(find.text('Selected'), findsOneWidget);
        final restored = AppSettingsService();
        await restored.loadSettings();
        expect(restored.settings.appTheme, 'neon_anarchy');
        await tester.pumpWidget(const SizedBox.shrink());
        restored.dispose();
        settings.dispose();
      },
    );
  }

  testWidgets('Seasonal shows its season controls, others do not', (
    tester,
  ) async {
    SeasonalTheme.now = () => DateTime(2026, 10, 31);
    final settings = await freshSettings();
    await tester.pumpWidget(picker(settings));
    expect(find.byKey(const ValueKey('season-auto')), findsNothing);
    final seasonal = find.byKey(const ValueKey('theme-seasonal'));
    await tester.ensureVisible(seasonal);
    await tester.tap(seasonal);
    await tester.pumpAndSettle();
    expect(find.text('Automatic (Autumn)'), findsOneWidget);
    final holidays = find.byKey(const ValueKey('season-holidays'));
    await tester.ensureVisible(holidays);
    await tester.tap(holidays);
    await tester.pumpAndSettle();
    expect(settings.settings.seasonalHolidays, isTrue);
    expect(find.text('Automatic (Halloween)'), findsOneWidget);
    final winter = find.byKey(const ValueKey('season-winter'));
    await tester.ensureVisible(winter);
    await tester.tap(winter);
    await tester.pumpAndSettle();
    expect(settings.settings.seasonalChoice, 'winter');
    await tester.pumpWidget(const SizedBox.shrink());
    settings.dispose();
  });

  testWidgets('an old saved theme opens on its replacement', (tester) async {
    final settings = await freshSettings({
      'app_settings': '{"app_theme":"bubble_gum"}',
    });
    await tester.pumpWidget(picker(settings));
    final card = tester.widget<Semantics>(
      find
          .ancestor(
            of: find.byKey(const ValueKey('theme-pink_overload')),
            matching: find.byType(Semantics),
          )
          .first,
    );
    expect(card.properties.selected, isTrue);
    await tester.pumpWidget(const SizedBox.shrink());
    settings.dispose();
  });

  test('the palette follows the chosen theme', () {
    MeshPalette.current = BastionTheme.pinkOverload.palette;
    expect(MeshPalette.accent, BastionTheme.pinkOverload.palette.accent);
    expect(MeshTheme.light().brightness, Brightness.light);
    MeshPalette.current = BastionTheme.blaze.palette;
    expect(MeshPalette.accent, const Color(0xFFFF8A00));
    expect(MeshTheme.dark().brightness, Brightness.dark);
  });
}
