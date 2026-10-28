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
    expect(BastionTheme.fromId('topo_night'), BastionTheme.topoNight);
    // The rc.H-only Halloween theme is gone; people who picked it get Blaze.
    expect(BastionTheme.fromId('halloween'), BastionTheme.blaze);
    final saved = AppSettings().copyWith(appTheme: 'alpine_day');
    expect(AppSettings.fromJson(saved.toJson()).appTheme, 'alpine_day');
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

  test('the palette follows the chosen theme', () {
    MeshPalette.current = BastionTheme.topoNight.palette;
    expect(MeshPalette.accent, const Color(0xFF5CE1E6));
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
