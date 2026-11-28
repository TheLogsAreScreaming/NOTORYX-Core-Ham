import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/screens/settings_screen.dart';
import 'package:meshcore_open/services/app_debug_log_service.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/services/operator_profile_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:meshcore_open/widgets/theme_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    PackageInfo.setMockInitialValues(
      appName: 'test',
      packageName: 'test',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
    );
  });

  testWidgets('the theme heading in Settings is translated', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MeshCoreConnector()),
          ChangeNotifierProvider(create: (_) => AppSettingsService()),
          ChangeNotifierProvider(create: (_) => OperatorProfileService()),
          ChangeNotifierProvider(create: (_) => AppDebugLogService()),
        ],
        child: MaterialApp(
          locale: const Locale('de'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SettingsScreen(),
        ),
      ),
    );
    // The screen has an indefinite progress indicator, so step frames
    // instead of pumpAndSettle.
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    await tester.scrollUntilVisible(
      find.byType(ThemePicker),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pump();

    final card = find.ancestor(
      of: find.byType(ThemePicker),
      matching: find.byType(Column),
    );
    expect(
      find.descendant(of: card.first, matching: find.text('Design')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: card.first, matching: find.text('Theme')),
      findsNothing,
    );
  });
}
