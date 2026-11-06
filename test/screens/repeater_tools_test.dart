import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/screens/bastion_repeater_tools_screen.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Contact _rpt(int n, String name, Duration ago) => Contact(
  publicKey: Uint8List.fromList(List.filled(32, n)),
  name: name,
  type: advTypeRepeater,
  pathLength: 0,
  path: Uint8List(0),
  lastSeen: DateTime.now().subtract(ago),
);

class _Radio extends MeshCoreConnector {
  final list = [
    _rpt(1, 'Hilltop', const Duration(minutes: 5)),
    _rpt(2, 'Valley', const Duration(hours: 5)),
  ];
  @override
  List<Contact> get contacts => list;
  @override
  int? getRepeaterBatteryMillivolts(String contactKeyHex) =>
      contactKeyHex == list[1].publicKeyHex ? 3200 : 4100;
}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
  });
  tearDown(PrefsManager.reset);

  testWidgets('filters repeaters and opens one with Log in', (tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 2000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final radio = _Radio();
    final settings = AppSettingsService();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MeshCoreConnector>.value(value: radio),
          ChangeNotifierProvider.value(value: settings),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BastionRepeaterToolsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Hilltop'), findsOneWidget);
    expect(find.text('Valley'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('repeater-filter-lowBattery')));
    await tester.pumpAndSettle();
    expect(find.text('Hilltop'), findsNothing);
    expect(find.text('Valley'), findsOneWidget);
    expect(find.textContaining('3.20 V'), findsOneWidget);

    await tester.tap(find.text('Valley'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('node-sheet')), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    settings.dispose();
    radio.dispose();
  });
}
