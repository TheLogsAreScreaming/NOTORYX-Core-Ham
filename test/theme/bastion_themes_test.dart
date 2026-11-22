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

/// Every palette a person can end up looking at.
Map<String, BastionPalette> allPalettes() => {
  for (final t in BastionTheme.values) t.id: t.palette,
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
  });

  test('exactly five themes, in order, with BLACKOUT the default', () {
    expect(BastionTheme.values.map((t) => t.id), [
      'blackout',
      'blaze',
      'tactical',
      'okabe_ito',
      'night_ops',
    ]);
    expect(AppSettings().appTheme, 'blackout');
    expect(BastionTheme.fromId(null), BastionTheme.blackout);
    expect(BastionTheme.fromId('nope'), BastionTheme.blackout);
  });

  test('saved ids from earlier versions map to their replacements', () {
    const expected = {
      'blaze': BastionTheme.blaze,
      'tactical': BastionTheme.tactical,
      'red_light': BastionTheme.nightOps,
      'okabe_ito': BastionTheme.okabeIto,
      'okabe_ito_slate': BastionTheme.okabeIto,
      'alpine_day': BastionTheme.blaze,
      // Removed themes, and older ids that led to them, open as BLACKOUT.
      'neon_anarchy': BastionTheme.blackout,
      'pink_overload': BastionTheme.blackout,
      'bare_beauty': BastionTheme.blackout,
      'seasonal': BastionTheme.blackout,
      'autumn_frost': BastionTheme.blackout,
      'bubble_gum': BastionTheme.blackout,
      'bronzed_blush': BastionTheme.blackout,
      'topo_night': BastionTheme.blackout,
      'christmas': BastionTheme.blackout,
      'halloween': BastionTheme.blackout,
    };
    for (final e in expected.entries) {
      expect(BastionTheme.fromId(e.key), e.value, reason: e.key);
    }
  });

  test('BLACKOUT is monochrome but keeps the meaning colours', () {
    final p = BastionTheme.blackout.palette;
    expect(p.brightness, Brightness.dark);
    expect(p.bg, const Color(0xFF080808));
    expect(p.bg3, const Color(0xFF242424));
    expect(p.line2, const Color(0xFF484848));
    expect(p.ink, const Color(0xFFE8E8E8));
    expect(p.accent, const Color(0xFFE8E8E8));
    for (final c in [p.bg, p.bg3, p.line2, p.ink, p.accent, p.nav]) {
      expect(HSVColor.fromColor(c).saturation, 0, reason: '$c');
    }
    // Signal, warning and alert still carry colour.
    for (final c in [p.signal, p.warn, p.alert]) {
      expect(HSVColor.fromColor(c).saturation, greaterThan(0.3), reason: '$c');
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
        final nightOps = find.byKey(const ValueKey('theme-night_ops'));
        await tester.ensureVisible(nightOps);
        await tester.tap(nightOps);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(settings.settings.appTheme, 'night_ops');
        expect(find.text('Selected'), findsOneWidget);
        final restored = AppSettingsService();
        await restored.loadSettings();
        expect(restored.settings.appTheme, 'night_ops');
        await tester.pumpWidget(const SizedBox.shrink());
        restored.dispose();
        settings.dispose();
      },
    );
  }

  for (final removed in ['pink_overload', 'seasonal', 'bubble_gum']) {
    testWidgets('a removed theme ($removed) opens as BLACKOUT', (tester) async {
      final settings = await freshSettings({
        'app_settings': '{"app_theme":"$removed"}',
      });
      await tester.pumpWidget(picker(settings));
      expect(tester.takeException(), isNull);
      final card = tester.widget<Semantics>(
        find
            .ancestor(
              of: find.byKey(const ValueKey('theme-blackout')),
              matching: find.byType(Semantics),
            )
            .first,
      );
      expect(card.properties.selected, isTrue);
      await tester.pumpWidget(const SizedBox.shrink());
      settings.dispose();
    });
  }

  test('the palette follows the chosen theme', () {
    MeshPalette.current = BastionTheme.nightOps.palette;
    expect(MeshPalette.accent, BastionTheme.nightOps.palette.accent);
    MeshPalette.current = BastionTheme.blaze.palette;
    expect(MeshPalette.accent, const Color(0xFFFF8A00));
    expect(MeshTheme.dark().brightness, Brightness.dark);
  });
}
