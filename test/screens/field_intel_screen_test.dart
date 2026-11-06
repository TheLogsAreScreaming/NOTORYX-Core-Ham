import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/screens/bastion_field_stats_screen.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Contact _node(int n, String name, int type, Duration ago) => Contact(
  publicKey: Uint8List.fromList(List.filled(32, n)),
  name: name,
  type: type,
  pathLength: n % 3,
  path: Uint8List(0),
  lastSeen: DateTime.now().subtract(ago),
);

class _Radio extends MeshCoreConnector {
  final list = [
    _node(1, 'Hilltop RPT', advTypeRepeater, const Duration(minutes: 5)),
    _node(2, 'Sam', advTypeChat, const Duration(hours: 3)),
    _node(3, 'Base Room', advTypeRoom, const Duration(days: 2)),
  ];
  @override
  List<Contact> get contacts => list;
  @override
  int? getRepeaterBatteryMillivolts(String contactKeyHex) =>
      contactKeyHex == list.first.publicKeyHex ? 3300 : null;
}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
  });
  tearDown(PrefsManager.reset);

  testWidgets('numbers open the nodes behind them, and nodes open details', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(400, 3000));
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
          home: BastionFieldStatsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // A low repeater battery is flagged.
    expect(find.text('Battery low: 3.30 V'), findsOneWidget);

    // Tapping "24 hours" lists who was last heard in that window.
    await tester.tap(find.byKey(const ValueKey('heard-day')));
    await tester.pumpAndSettle();
    expect(find.text('Sam'), findsOneWidget);
    expect(find.text('Nodes: 1'), findsOneWidget);
    await tester.tap(find.text('Sam'));
    await tester.pumpAndSettle();
    expect(find.text('Open chat'), findsOneWidget);
    Navigator.of(tester.element(find.text('Open chat'))).pop();
    await tester.pumpAndSettle();

    // The node mix bar for rooms opens the room.
    await tester.tap(find.byKey(const ValueKey('mix-$advTypeRoom')));
    await tester.pumpAndSettle();
    expect(find.text('Base Room'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    settings.dispose();
    radio.dispose();
  });
}
