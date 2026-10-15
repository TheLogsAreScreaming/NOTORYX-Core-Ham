import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/screens/settings_screen.dart';
import 'package:meshcore_open/services/app_debug_log_service.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeConnector extends MeshCoreConnector {
  _FakeConnector({required this.supported});

  final bool supported;
  String _region = '';
  final List<String> sentRegions = [];

  @override
  bool get isConnected => true;

  @override
  bool? get floodCorridorSupported => supported;

  @override
  String? get corridorRegion => _region;

  @override
  Future<void> setCorridorRegion(String region) async {
    sentRegions.add(region);
    _region = region;
    notifyListeners();
  }
}

Widget _app(MeshCoreConnector connector) => MultiProvider(
  providers: [
    ChangeNotifierProvider<MeshCoreConnector>.value(value: connector),
    ChangeNotifierProvider(create: (_) => AppSettingsService()),
    ChangeNotifierProvider(create: (_) => AppDebugLogService()),
  ],
  child: MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: const SettingsScreen(),
  ),
);

// The settings screen shows an indefinite progress indicator, so
// pumpAndSettle never settles; step past dialog transitions instead.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'regions': ['#bc-south', 'yvr'],
    });
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

  testWidgets('edits the corridor region on corridor firmware', (tester) async {
    final connector = _FakeConnector(supported: true);
    await tester.pumpWidget(_app(connector));
    await _settle(tester);

    expect(find.text('#corridor (default)'), findsOneWidget);
    await tester.tap(find.text('Corridor region'));
    await _settle(tester);

    await tester.tap(find.widgetWithText(ActionChip, '#bc-south'));
    await tester.tap(find.text('Save'));
    await _settle(tester);
    expect(connector.sentRegions, ['bc-south']);
    expect(find.text('#bc-south'), findsOneWidget);

    await tester.tap(find.text('Corridor region'));
    await _settle(tester);
    await tester.tap(find.text('Use default'));
    await _settle(tester);
    expect(connector.sentRegions, ['bc-south', '']);
    expect(find.text('#corridor (default)'), findsOneWidget);
  });

  testWidgets('hides the setting on stock firmware', (tester) async {
    await tester.pumpWidget(_app(_FakeConnector(supported: false)));
    await _settle(tester);

    expect(find.text('Corridor region'), findsNothing);
  });
}
