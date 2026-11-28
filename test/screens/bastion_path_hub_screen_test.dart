import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/path_history.dart';
import 'package:meshcore_open/screens/bastion_path_hub_screen.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/services/path_history_service.dart';
import 'package:meshcore_open/services/storage_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _History extends PathHistoryService {
  _History(this.paths) : super(StorageService());

  final Map<String, List<PathRecord>> paths;

  @override
  List<PathRecord> getRecentPaths(String contactPubKeyHex) =>
      paths[contactPubKeyHex] ?? const [];

  @override
  ({
    int successCount,
    int failureCount,
    int lastTripTimeMs,
    DateTime? lastUsed,
  })?
  getFloodStats(String contactPubKeyHex) => null;
}

Contact _repeater(int seed, String name) => Contact(
  publicKey: Uint8List.fromList(List.generate(32, (i) => seed + i)),
  name: name,
  type: advTypeRepeater,
  path: Uint8List(0),
  pathLength: 0,
  lastSeen: DateTime(2026, 10, 22),
);

PathRecord _route(int hops, List<int> bytes, {int failures = 0}) => PathRecord(
  hopCount: hops,
  tripTimeMs: 900,
  timestamp: DateTime(2026, 10, 22),
  wasFloodDiscovery: false,
  pathBytes: bytes,
  successCount: 0,
  failureCount: failures,
);

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
  });

  testWidgets('shows one entry per hop for 1- and 2-byte path hashes', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final oneByte = _repeater(0x10, 'Tunxis Hill');
    final twoByte = _repeater(0x60, 'GBARC Yagi');
    final connector = MeshCoreConnector()..debugSetContacts([oneByte, twoByte]);
    final history = _History({
      oneByte.publicKeyHex: [
        _route(3, [0x3D, 0x4B, 0x8F]),
      ],
      twoByte.publicKeyHex: [
        _route(3, [0x3D, 0x4A, 0x4B, 0xE0, 0x6B, 0x80]),
      ],
    });

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MeshCoreConnector>.value(value: connector),
          ChangeNotifierProvider<PathHistoryService>.value(value: history),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const BastionPathHubScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.textContaining('3D › 4B › 8F'), findsOneWidget);
    expect(find.textContaining('3D4A › 4BE0 › 6B80'), findsOneWidget);
    expect(find.textContaining('3D › 4A › 4B'), findsNothing);
  });

  testWidgets('routes open their details, and Failed shows only failing ones', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final good = _repeater(0x10, 'Good Hill');
    final bad = _repeater(0x60, 'Bad Ridge');
    final connector = MeshCoreConnector()..debugSetContacts([good, bad]);
    final settings = AppSettingsService();
    final history = _History({
      good.publicKeyHex: [
        _route(1, [0x3D]),
      ],
      bad.publicKeyHex: [
        _route(2, [0x3D, 0x4B], failures: 3),
      ],
    });

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MeshCoreConnector>.value(value: connector),
          ChangeNotifierProvider<PathHistoryService>.value(value: history),
          ChangeNotifierProvider.value(value: settings),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const BastionPathHubScreen(),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.byKey(const ValueKey('routes-failed')));
    await tester.pump();
    expect(find.text('Good Hill'), findsNothing);
    expect(find.text('Bad Ridge'), findsOneWidget);
    expect(find.text('Only routes that failed'), findsOneWidget);

    await tester.tap(find.byKey(ValueKey('route-${bad.publicKeyHex}')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('route-contact-details')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('node-sheet')), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    settings.dispose();
  });
}
