import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      'red_light',
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

  test('Bubble Gum keeps all five reference colors', () {
    final p = BastionTheme.bubbleGum.palette;
    expect(p.bg4, const Color(0xFFCDB4DA));
    expect(p.bg1, const Color(0xFFFFC8DC));
    expect(p.me, const Color(0xFFFFAFCC));
    expect(p.bg3, const Color(0xFFBEE0FE));
    expect(p.accentDim, const Color(0xFFA2D2FF));
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
    expect(MeshPalette.accent, const Color(0xFF704887));
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
