import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/models/app_settings.dart';
import 'package:meshcore_open/screens/settings_screen.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/services/field_ops_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('the setting is saved and defaults to off', () {
    expect(AppSettings().batterySaver, isFalse);
    final on = AppSettings().copyWith(batterySaver: true);
    expect(AppSettings.fromJson(on.toJson()).batterySaver, isTrue);
    expect(AppSettings.fromJson(AppSettings().toJson()).batterySaver, isFalse);
  });

  test('the connector polls the radio less often', () {
    final radio = MeshCoreConnector();
    expect(radio.batteryPollInterval, const Duration(minutes: 2));
    expect(radio.gpsLocationPollInterval, const Duration(minutes: 1));
    expect(radio.radioStatsPollInterval, const Duration(seconds: 30));
    radio.setBatterySaver(true);
    expect(radio.batteryPollInterval, const Duration(minutes: 10));
    expect(radio.gpsLocationPollInterval, const Duration(minutes: 5));
    expect(radio.radioStatsPollInterval, const Duration(seconds: 60));
    radio.setPollingInterval(5);
    expect(radio.radioStatsPollInterval, const Duration(seconds: 60));
    radio.setBatterySaver(false);
    expect(radio.radioStatsPollInterval, const Duration(seconds: 5));
    radio.dispose();
  });

  test('trip checks slow down; nothing else changes', () async {
    SharedPreferences.setMockInitialValues({});
    final radio = MeshCoreConnector();
    final ops = FieldOpsService(radio);
    await ops.load();
    expect(ops.tickInterval, const Duration(seconds: 15));
    expect(ops.watchInterval, const Duration(seconds: 30));
    ops.setBatterySaver(true);
    expect(ops.tickInterval, const Duration(seconds: 60));
    expect(ops.watchInterval, const Duration(minutes: 2));
    ops.dispose();
    radio.dispose();
  });

  testWidgets('settings switch turns it on', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await PrefsManager.initialize();
    final settings = AppSettingsService();
    await settings.loadSettings();
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: settings,
        child: const MaterialApp(home: Scaffold(body: BatterySaverCard())),
      ),
    );
    expect(
      find.textContaining('Check the radio and trip less often'),
      findsOneWidget,
    );
    await tester.tap(find.byKey(const ValueKey('battery-saver')));
    await tester.pumpAndSettle();
    expect(settings.settings.batterySaver, isTrue);
    expect(
      find.textContaining('On: radio battery every 10 min'),
      findsOneWidget,
    );
  });
}
