import 'dart:ui' show SemanticsAction, Tristate;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/app_settings.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:meshcore_open/theme/mesh_theme.dart';
import 'package:meshcore_open/widgets/theme_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

double contrast(Color a, Color b) {
  final x = a.computeLuminance(), y = b.computeLuminance();
  return x > y ? (x + .05) / (y + .05) : (y + .05) / (x + .05);
}

/// Every palette the app can show: seven themes plus Seasonal's seven.
Map<String, BastionPalette> allPalettes() => {
  for (final t in BastionTheme.values)
    if (t != BastionTheme.seasonal) t.id: t.palette,
  for (final s in Season.values) 'seasonal/${s.id}': s.palette,
};

Future<AppSettingsService> freshSettings([
  Map<String, Object> prefs = const {},
]) async {
  SharedPreferences.setMockInitialValues(prefs);
  PrefsManager.reset();
  await PrefsManager.initialize();
  final settings = AppSettingsService();
  await settings.loadSettings();
  return settings;
}

Widget pickerApp(AppSettingsService settings, {double textScale = 1}) =>
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

void main() {
  tearDown(() => MeshPalette.current = BastionTheme.fallback.palette);

  group('lineup', () {
    test('exactly eight themes, in display order, Blaze the default', () {
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

    test('every palette is distinct', () {
      final accents = allPalettes().values.map((p) => p.accent).toSet();
      expect(accents, hasLength(allPalettes().length));
    });

    test('the spec colors are used', () {
      final blaze = BastionTheme.blaze.palette;
      expect(blaze.bg, const Color(0xFF111820));
      expect(blaze.bg3, const Color(0xFF273443));
      expect(blaze.accent, const Color(0xFFFF8A00));
      expect(blaze.ink, const Color(0xFFF4F6F8));
      expect(blaze.ink3, const Color(0xFFAAB5C3));
      final neon = BastionTheme.neonAnarchy.palette;
      expect(neon.bg, const Color(0xFF08060D));
      expect(neon.accent, const Color(0xFFADFF2F));
      expect(neon.magenta, const Color(0xFFB026FF));
      expect(neon.secondaryContainer, const Color(0xFF7022C4));
      expect(BastionTheme.tactical.palette.accent, const Color(0xFFA8BA79));
      final pink = BastionTheme.pinkOverload.palette;
      expect(pink.bg, const Color(0xFFFFF0FA));
      expect(pink.bg3, const Color(0xFFFFC1E3));
      expect(pink.magenta, const Color(0xFFFF1493));
      expect(pink.brightness, Brightness.light);
      final bare = BastionTheme.bareBeauty.palette;
      expect(bare.bg, const Color(0xFFFFF0E7));
      expect(bare.bg3, const Color(0xFFE8B69E));
      expect(bare.secondary, const Color(0xFF754B43));
      expect(bare.brightness, Brightness.light);
      expect(BastionTheme.okabeIto.palette.bg, const Color(0xFF161A20));
      final night = BastionTheme.nightOps.palette;
      expect(night.bg, const Color(0xFF080808));
      expect(night.accentDim, const Color(0xFFC23A32));
    });

    test('Pink Overload and Bare Beauty are clearly different', () {
      final pink = BastionTheme.pinkOverload.palette;
      final bare = BastionTheme.bareBeauty.palette;
      expect(pink.accent == bare.accent, isFalse);
      // Pink Overload's page is pinker (more red than green by far).
      expect(pink.bg3.r - pink.bg3.g, greaterThan(bare.bg3.r - bare.bg3.g));
    });
  });

  group('accessibility', () {
    test('every palette meets 4.5:1 for text, buttons, bubbles and SOS', () {
      final failures = <String>[];
      for (final e in allPalettes().entries) {
        final p = e.value;
        final s = MeshTheme.forPalette(p).colorScheme;
        final checks = {
          'text': contrast(s.onSurface, s.surface),
          'secondary text on cards': contrast(p.ink2, p.bg2),
          'muted text on cards': contrast(p.ink3, p.bg2),
          'muted text on elevated': contrast(p.ink3, p.bg3),
          'faint text': contrast(p.ink4, p.bg),
          'button text': contrast(s.onPrimary, s.primary),
          'accent on page': contrast(p.accent, p.bg),
          'accent on cards': contrast(p.accent, p.bg2),
          'SOS on page': contrast(p.alert, p.bg),
          'SOS on cards': contrast(p.alert, p.bg2),
          'chat bubble': contrast(p.meInk, p.me),
          'second color on page': contrast(p.secondary, p.bg),
          'third color on page': contrast(p.tertiary, p.bg),
          'second color on cards': contrast(p.secondary, p.bg2),
          'third color on cards': contrast(p.tertiary, p.bg2),
          'on second color': contrast(s.onSecondary, s.secondary),
          'on third color': contrast(s.onTertiary, s.tertiary),
          'text on primary container': contrast(p.ink, p.primaryContainer),
          'text on second container': contrast(p.ink, p.secondaryContainer),
          'text on third container': contrast(p.ink, p.tertiaryContainer),
          'good signal on cards': contrast(p.signal, p.bg2),
          'warning on cards': contrast(p.warn, p.bg2),
          'text on raised surface': contrast(p.ink, p.bg3),
          'unread count': contrast(MeshPalette.onColor(p.alert), p.alert),
          // Sender names and avatar initials use the theme hues as text,
          // through MeshPalette.readable.
          for (final (i, hue) in [
            p.accent,
            p.magenta,
            p.signal,
            p.warn,
            p.secondary,
            p.tertiary,
          ].indexed) ...{
            'name hue $i on cards': contrast(
              MeshPalette.readable(hue, p.bg2),
              p.bg2,
            ),
            'name hue $i on page': contrast(
              MeshPalette.readable(hue, p.bg),
              p.bg,
            ),
          },
        };
        // Collected so one run lists every failing pair, not just the first.
        for (final c in checks.entries) {
          if (c.value < 4.5) {
            failures.add('${e.key}: ${c.key} ${c.value.toStringAsFixed(2)}');
          }
        }
        if (contrast(MeshPalette.onColor(p.magenta), p.magenta) < 3) {
          failures.add('${e.key}: community badge icon');
        }
        expect(s.brightness, p.brightness, reason: e.key);
      }
      expect(failures, isEmpty, reason: failures.join('\n'));
    });

    test('three distinct hues per palette, never the warning color', () {
      for (final e in allPalettes().entries) {
        final p = e.value;
        expect(
          {p.accent, p.secondary, p.tertiary},
          hasLength(3),
          reason: e.key,
        );
        final s = MeshTheme.forPalette(p).colorScheme;
        expect(s.secondary, p.secondary, reason: e.key);
        expect(s.secondary == p.warn, isFalse, reason: e.key);
      }
    });

    test('SOS stays red in every palette', () {
      for (final e in allPalettes().entries) {
        final a = HSVColor.fromColor(e.value.alert);
        final redHue = a.hue <= 25 || a.hue >= 340;
        expect(redHue, isTrue, reason: '${e.key} hue ${a.hue}');
        expect(a.saturation, greaterThan(0.5), reason: e.key);
      }
    });

    test('Night Ops keeps every color in the red family', () {
      final p = BastionTheme.nightOps.palette;
      for (final c in [p.accent, p.secondary, p.tertiary, p.signal, p.warn]) {
        final h = HSVColor.fromColor(c).hue;
        expect(h <= 25 || h >= 340, isTrue, reason: '$c hue $h');
      }
    });

    test('Okabe-Ito keeps the reference palette', () {
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
      expect(p.accent, OkabeIto.skyBlue);
      expect(p.accentDim, OkabeIto.blue);
      expect(p.me, OkabeIto.blue);
      expect(p.secondary, OkabeIto.orange);
      expect(p.warn, OkabeIto.yellow);
      final types = [advTypeChat, advTypeRepeater, advTypeRoom, advTypeSensor];
      final colors = types.map(OkabeIto.nodeType).toSet();
      expect(colors, hasLength(4));
      expect(MapPalette.repeater, OkabeIto.nodeType(advTypeRepeater));
    });
  });

  group('migration', () {
    test('old theme ids open as their closest new theme', () {
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
        final loaded = AppSettings.fromJson({'app_theme': e.key});
        expect(loaded.appTheme, e.value.id, reason: e.key);
      }
    });

    test('Autumn Frost people keep autumn colors inside Seasonal', () {
      final s = AppSettings.fromJson({'app_theme': 'autumn_frost'});
      expect(s.appTheme, 'seasonal');
      expect(s.seasonalOverride, 'autumn');
      expect(
        identical(
          resolveThemePalette(s.appTheme, seasonalOverride: s.seasonalOverride),
          Season.autumn.palette,
        ),
        isTrue,
      );
      // Anyone else starts on automatic.
      expect(
        AppSettings.fromJson({'app_theme': 'blaze'}).seasonalOverride,
        'auto',
      );
    });

    test('a migrated choice is saved under its new id', () async {
      final settings = await freshSettings({
        'app_settings': '{"app_theme":"bubble_gum"}',
      });
      expect(settings.settings.appTheme, 'pink_overload');
      await settings.setAppTheme(settings.settings.appTheme);
      final again = AppSettingsService();
      await again.loadSettings();
      expect(again.settings.appTheme, 'pink_overload');
    }, skip: false);
  });

  group('seasonal', () {
    test('season by month', () {
      Season at(int m, int d) =>
          seasonFor(DateTime(2026, m, d), holidays: false);
      expect(at(3, 1), Season.spring);
      expect(at(5, 31), Season.spring);
      expect(at(6, 1), Season.summer);
      expect(at(8, 31), Season.summer);
      expect(at(9, 1), Season.autumn);
      expect(at(11, 30), Season.autumn);
      expect(at(12, 1), Season.winter);
      expect(at(2, 28), Season.winter);
    });

    test('holidays on their dates only when turned on', () {
      expect(seasonFor(DateTime(2026, 10, 31)), Season.halloween);
      expect(seasonFor(DateTime(2026, 10, 23)), Season.autumn);
      expect(seasonFor(DateTime(2026, 12, 25)), Season.christmas);
      expect(seasonFor(DateTime(2026, 12, 27)), Season.winter);
      expect(seasonFor(DateTime(2027, 2, 14)), Season.valentine);
      expect(seasonFor(DateTime(2027, 2, 15)), Season.winter);
      expect(seasonFor(DateTime(2026, 10, 31), holidays: false), Season.autumn);
    });

    test('an override wins over the date', () {
      expect(
        activeSeason(override: 'winter', now: DateTime(2026, 7, 1)),
        Season.winter,
      );
      expect(
        activeSeason(override: 'auto', now: DateTime(2026, 7, 1)),
        Season.summer,
      );
      expect(
        activeSeason(override: 'bogus', now: DateTime(2026, 7, 1)),
        Season.summer,
      );
    });

    test('only the Seasonal theme looks at the date', () {
      final july = DateTime(2026, 7, 1);
      expect(
        identical(
          resolveThemePalette('seasonal', now: july),
          Season.summer.palette,
        ),
        isTrue,
      );
      for (final t in BastionTheme.values) {
        if (t == BastionTheme.seasonal) continue;
        expect(
          identical(
            resolveThemePalette(t.id, seasonalOverride: 'winter', now: july),
            t.palette,
          ),
          isTrue,
          reason: t.id,
        );
      }
    });

    test('settings round-trip', () {
      final s = AppSettings(
        appTheme: 'seasonal',
        seasonalOverride: 'spring',
        seasonalHolidays: false,
      );
      final back = AppSettings.fromJson(s.toJson());
      expect(back.appTheme, 'seasonal');
      expect(back.seasonalOverride, 'spring');
      expect(back.seasonalHolidays, isFalse);
      expect(AppSettings().seasonalHolidays, isTrue);
    });
  });

  group('picker', () {
    for (final width in [320.0, 720.0]) {
      testWidgets('shows eight cards and saves the choice at width $width', (
        tester,
      ) async {
        final settings = await freshSettings();
        await tester.binding.setSurfaceSize(Size(width, 2400));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        await tester.pumpWidget(pickerApp(settings, textScale: 2));
        for (final t in BastionTheme.values) {
          expect(find.byKey(ValueKey('theme-${t.id}')), findsOneWidget);
          expect(find.text(t.label), findsOneWidget);
        }
        expect(find.text('Selected'), findsOneWidget);
        final neon = find.byKey(const ValueKey('theme-neon_anarchy'));
        await tester.ensureVisible(neon);
        await tester.tap(neon);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(settings.settings.appTheme, 'neon_anarchy');
        final restored = AppSettingsService();
        await restored.loadSettings();
        expect(restored.settings.appTheme, 'neon_anarchy');
        await tester.pumpWidget(const SizedBox.shrink());
        restored.dispose();
        settings.dispose();
      });
    }

    testWidgets('two columns on a phone', (tester) async {
      final settings = await freshSettings();
      await tester.binding.setSurfaceSize(const Size(390, 2400));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(pickerApp(settings));
      final a = tester.getTopLeft(find.byKey(const ValueKey('theme-blaze')));
      final b = tester.getTopLeft(
        find.byKey(const ValueKey('theme-neon_anarchy')),
      );
      expect(a.dy, b.dy);
      expect(b.dx, greaterThan(a.dx));
    });

    testWidgets('seasonal controls appear only for Seasonal and save', (
      tester,
    ) async {
      final settings = await freshSettings();
      await tester.binding.setSurfaceSize(const Size(420, 2400));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(pickerApp(settings));
      expect(find.byKey(const ValueKey('seasonal-season')), findsNothing);
      final seasonal = find.byKey(const ValueKey('theme-seasonal'));
      await tester.ensureVisible(seasonal);
      await tester.tap(seasonal);
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey('seasonal-season')), findsOneWidget);
      final holidays = find.byKey(const ValueKey('seasonal-holidays'));
      await tester.ensureVisible(holidays);
      await tester.tap(holidays);
      await tester.pumpAndSettle();
      expect(settings.settings.seasonalHolidays, isFalse);
      await settings.setSeasonalOverride('winter');
      await tester.pumpAndSettle();
      expect(find.text('Winter'), findsWidgets);
      final restored = AppSettingsService();
      await restored.loadSettings();
      expect(restored.settings.seasonalOverride, 'winter');
      expect(restored.settings.seasonalHolidays, isFalse);
    });

    testWidgets('cards tell screen readers the name, description and state', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      final settings = await freshSettings();
      await tester.binding.setSurfaceSize(const Size(420, 2400));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(pickerApp(settings));
      final node = tester.getSemantics(
        find.byKey(const ValueKey('theme-blaze')),
      );
      expect(node.label, contains('Blaze'));
      expect(node.label, contains('high-visibility orange'));
      expect(node.flagsCollection.isSelected, Tristate.isTrue);
      // The card can be activated from a screen reader.
      expect(node.getSemanticsData().hasAction(SemanticsAction.tap), isTrue);
      tester.semantics.tap(find.semantics.byLabel(RegExp('^Neon Anarchy')));
      await tester.pumpAndSettle();
      expect(settings.settings.appTheme, 'neon_anarchy');
      handle.dispose();
    });
  });

  test('the palette follows the chosen theme', () {
    MeshPalette.current = BastionTheme.pinkOverload.palette;
    expect(MeshPalette.accent, BastionTheme.pinkOverload.palette.accent);
    MeshPalette.current = BastionTheme.blaze.palette;
    expect(MeshPalette.accent, const Color(0xFFFF8A00));
    expect(MeshTheme.light().brightness, Brightness.light);
    expect(MeshTheme.dark().brightness, Brightness.dark);
  });
}
