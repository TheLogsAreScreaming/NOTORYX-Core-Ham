import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/app_settings.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:meshcore_open/theme/mesh_theme.dart';
import 'package:meshcore_open/widgets/theme_picker.dart';

double contrast(Color a, Color b) {
  final x = a.computeLuminance(), y = b.computeLuminance();
  return x > y ? (x + .05) / (y + .05) : (y + .05) / (x + .05);
}

void main() {
  tearDown(() => MeshPalette.current = BastionTheme.fallback.palette);

  test('Blaze is the default, and unknown ids fall back to it', () {
    expect(AppSettings().appTheme, 'blaze');
    expect(BastionTheme.fromId(null), BastionTheme.blaze);
    expect(BastionTheme.fromId('nope'), BastionTheme.blaze);
    expect(BastionTheme.fromId('topo_night'), BastionTheme.bubbleGum);
    expect(BastionTheme.fromId('bubble_gum'), BastionTheme.bubbleGum);
    expect(
      BastionTheme.values.any((theme) => theme.id == 'topo_night'),
      isFalse,
    );
    // The rc.H-only Halloween theme is gone; people who picked it get Blaze.
    expect(BastionTheme.fromId('halloween'), BastionTheme.blaze);
    // Alpine day is gone too; people who picked it get the default.
    expect(BastionTheme.fromId('alpine_day'), BastionTheme.blaze);
    expect(BastionTheme.values.map((t) => t.id), [
      'blaze',
      'autumn_frost',
      'bubble_gum',
      'bronzed_blush',
      'red_light',
      'okabe_ito',
      'okabe_ito_slate',
    ]);
  });

  test('every theme keeps text, buttons and SOS readable', () {
    for (final t in BastionTheme.values) {
      final p = t.palette;
      final s = MeshTheme.forPalette(p).colorScheme;
      final checks = {
        'text': contrast(s.onSurface, s.surface),
        'secondary text': contrast(s.onSurfaceVariant, s.surfaceContainerHigh),
        'muted text': contrast(p.ink3, p.bg2),
        'faint text': contrast(p.ink4, p.bg),
        'button text': contrast(s.onPrimary, s.primary),
        'accent on page': contrast(p.accent, p.bg),
        'alert': contrast(p.alert, p.bg2),
        'chat bubble': contrast(p.meInk, p.me),
        'second color on page': contrast(p.secondary, p.bg),
        'third color on page': contrast(p.tertiary, p.bg),
        'second color on cards': contrast(p.secondary, p.bg2),
        'third color on cards': contrast(p.tertiary, p.bg2),
        'text on second container': contrast(p.ink, p.secondaryContainer),
        'text on third container': contrast(p.ink, p.tertiaryContainer),
      };
      for (final c in checks.entries) {
        expect(
          c.value,
          greaterThanOrEqualTo(4.5),
          reason: '${t.label}: ${c.key} ${c.value.toStringAsFixed(1)}',
        );
      }
      expect(s.brightness, p.brightness);
    }
  });

  test('Bubble Gum is pink, not white, behind the text', () {
    final p = BastionTheme.bubbleGum.palette;
    expect(p.brightness, Brightness.light);
    // The old near-white page was too bright; keep the page a real pink.
    for (final surface in [p.bg, p.bg1, p.bg2]) {
      expect(surface.computeLuminance(), lessThan(0.7));
      expect(surface.r, greaterThan(surface.g));
    }
    expect(p.me, const Color(0xFFB5207A));
  });

  test('the Okabe-Ito palette, theme and node colors match the reference', () {
    expect(OkabeIto.categorical, const [
      Color(0xFFE69F00),
      Color(0xFF56B4E9),
      Color(0xFF009E73),
      Color(0xFFF0E442),
      Color(0xFF0072B2),
      Color(0xFFD55E00),
      Color(0xFFCC79A7),
    ]);
    expect(OkabeIto.black, const Color(0xFF000000));
    final p = BastionTheme.okabeIto.palette;
    expect(p.bg, OkabeIto.black);
    // Good, warning and bad signal are three different Okabe-Ito hues.
    expect(
      {p.signal, p.warn, p.alert},
      {OkabeIto.bluishGreen, OkabeIto.yellow, OkabeIto.vermillion},
    );
    expect(BastionTheme.fromId('okabe_ito'), BastionTheme.okabeIto);
    final types = [advTypeChat, advTypeRepeater, advTypeRoom, advTypeSensor];
    final colors = types.map(OkabeIto.nodeType).toSet();
    expect(colors, hasLength(4));
    expect(colors.every(OkabeIto.categorical.contains), isTrue);
    expect(MapPalette.repeater, OkabeIto.nodeType(advTypeRepeater));
    expect(MapPalette.sensor, OkabeIto.nodeType(advTypeSensor));
  });

  test('Okabe-Ito comes on black and on charcoal', () {
    expect(BastionTheme.okabeIto.palette.bg, OkabeIto.black);
    final slate = BastionTheme.okabeItoSlate.palette;
    expect(slate.bg.computeLuminance(), greaterThan(0.01));
    expect(slate.brightness, Brightness.dark);
    // Same palette: the accent, warning and your bubble are unchanged.
    expect(slate.accent, OkabeIto.skyBlue);
    expect(slate.warn, OkabeIto.yellow);
    expect(slate.me, OkabeIto.blue);
    expect(BastionTheme.fromId('okabe_ito_slate'), BastionTheme.okabeItoSlate);
  });

  test('Bronzed Blush uses its four colors', () {
    final p = BastionTheme.bronzedBlush.palette;
    expect(p.me, const Color(0xFF8A4E3C)); // Deep Bronze
    expect(p.accentDim, const Color(0xFFE6A6A6)); // Pale Pink
    expect(p.accent, const Color(0xFFF3A7AD)); // Soft Pink
    expect(p.primaryContainer, const Color(0xFF874D5A)); // Inner Tone
    expect(BastionTheme.fromId('bronzed_blush'), BastionTheme.bronzedBlush);
  });

  test('every theme has three distinct hues, not one accent on grey', () {
    for (final t in BastionTheme.values) {
      final p = t.palette;
      final hues = {p.accent, p.secondary, p.tertiary};
      expect(hues, hasLength(3), reason: t.id);
      // The scheme's secondary and tertiary are no longer the warning color.
      final s = MeshTheme.forPalette(p).colorScheme;
      expect(s.secondary, p.secondary, reason: t.id);
      expect(s.tertiary, p.tertiary, reason: t.id);
      expect(s.secondary == p.warn, isFalse, reason: t.id);
    }
  });

  test('Autumn Frost uses all five fall colors and replaces Christmas', () {
    final p = BastionTheme.autumnFrost.palette;
    expect(p.bg2, const Color(0xFF24343C)); // Frozen Slate
    expect(p.bg4, const Color(0xFF3A574C)); // Pine Frost
    expect(p.me, const Color(0xFF854D2B)); // Chestnut Ember
    expect(p.secondaryContainer, const Color(0xFF87591F)); // Bronze Leaf
    expect(p.accentDim, const Color(0xFFA06A25)); // Amber Oak
    expect(BastionTheme.fromId('autumn_frost'), BastionTheme.autumnFrost);
    expect(BastionTheme.fromId('christmas'), BastionTheme.autumnFrost);
    final saved = AppSettings().copyWith(appTheme: 'autumn_frost');
    expect(AppSettings.fromJson(saved.toJson()).appTheme, 'autumn_frost');
  });

  for (final width in [320.0, 720.0]) {
    testWidgets('Autumn Frost selection survives reload at width $width', (
      tester,
    ) async {
      SharedPreferences.setMockInitialValues({});
      PrefsManager.reset();
      await PrefsManager.initialize();
      final settings = AppSettingsService();
      await settings.loadSettings();
      await tester.binding.setSurfaceSize(Size(width, 1000));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: settings,
          child: MaterialApp(
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(2)),
              child: child!,
            ),
            home: const Scaffold(
              body: SingleChildScrollView(child: ThemePicker()),
            ),
          ),
        ),
      );
      final autumn = find.byKey(const ValueKey('theme-autumn_frost'));
      await tester.ensureVisible(autumn);
      await tester.tap(autumn);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(settings.settings.appTheme, 'autumn_frost');
      final restored = AppSettingsService();
      await restored.loadSettings();
      expect(restored.settings.appTheme, 'autumn_frost');
      final bubbleGum = find.byKey(const ValueKey('theme-bubble_gum'));
      await tester.ensureVisible(bubbleGum);
      await tester.tap(bubbleGum);
      await tester.pumpAndSettle();
      expect(find.text('Topo night'), findsNothing);
      expect(find.text('Alpine day'), findsNothing);
      expect(find.text('Christmas'), findsNothing);
      expect(settings.settings.appTheme, 'bubble_gum');
      await restored.loadSettings();
      expect(restored.settings.appTheme, 'bubble_gum');
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
      restored.dispose();
      settings.dispose();
    });
  }

  test('the palette follows the chosen theme', () {
    MeshPalette.current = BastionTheme.bubbleGum.palette;
    expect(MeshPalette.accent, const Color(0xFF8E0B56));
    MeshPalette.current = BastionTheme.blaze.palette;
    expect(MeshPalette.accent, const Color(0xFFFF9A3C));
    expect(MeshTheme.light().brightness, Brightness.light);
    expect(MeshTheme.dark().brightness, Brightness.dark);
  });

  testWidgets('tapping a theme saves it', (tester) async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    final settings = AppSettingsService();
    await settings.loadSettings();
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: settings,
        child: const MaterialApp(
          home: Scaffold(body: SingleChildScrollView(child: ThemePicker())),
        ),
      ),
    );
    expect(find.text('Blaze'), findsOneWidget);
    expect(find.text('Red light'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('theme-red_light')));
    await tester.pumpAndSettle();
    expect(settings.settings.appTheme, 'red_light');
  });
}
