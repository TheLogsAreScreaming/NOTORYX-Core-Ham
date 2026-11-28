import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/network_scan.dart';
import 'package:meshcore_open/screens/networks_screen.dart';
import 'package:meshcore_open/services/network_scan_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Radio extends MeshCoreConnector {
  bool connected = false;
  @override
  bool get isConnected => connected;
  @override
  int? get currentFreqHz => connected ? 910525 : null;
  @override
  int? get currentBwHz => 62500;
  @override
  int? get currentSf => 7;
  @override
  int? get currentCr => 5;
}

const _ms = ScanTarget(
  name: 'MediumSlow',
  freqKHz: 914875,
  bwHz: 250000,
  sf: 10,
  cr: 5,
);

void main() {
  late _Radio radio;
  late NetworkScanService scan;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    radio = _Radio();
    scan = NetworkScanService(radio)
      ..debugSeed(
        log: [
          NetworkSighting(
            target: _ms,
            at: DateTime.now(),
            packets: 4,
            bestSnr: 5,
            bestRssi: -99,
            nodes: const [HeardNode(key: 'abcd0123', name: 'Hollyburn RPT')],
          ),
        ],
      );
  });
  tearDown(() {
    scan.dispose();
    PrefsManager.reset();
  });

  Future<void> show(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      ChangeNotifierProvider<NetworkScanService>.value(
        value: scan,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: NetworksScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('without a radio, scanning is off and says why', (tester) async {
    await show(tester);
    expect(find.text('Connect a radio to scan.'), findsOneWidget);
    final button = tester.widget<OutlinedButton>(
      find.descendant(
        of: find.byKey(const ValueKey('scan-toggle')),
        matching: find.byType(OutlinedButton),
      ),
    );
    expect(button.onPressed, isNull);
  });

  testWidgets('a heard network shows its nodes and can be saved', (
    tester,
  ) async {
    radio.connected = true;
    await show(tester);
    expect(find.text('MediumSlow'), findsWidgets);
    await tester.tap(find.byKey(ValueKey('nearby-${_ms.signature}')));
    await tester.pumpAndSettle();
    expect(find.text('Hollyburn RPT'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('network-save')));
    await tester.pumpAndSettle();
    expect(scan.isSaved(_ms), isTrue);
  });

  testWidgets('a network can be added by hand, and bad settings are refused', (
    tester,
  ) async {
    await show(tester);
    await tester.tap(find.byKey(const ValueKey('network-add')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('network-frequency')),
      '9999',
    );
    await tester.tap(find.byKey(const ValueKey('network-add-save')));
    await tester.pumpAndSettle();
    expect(scan.saved, isEmpty);
    expect(
      find.text(
        "Check the settings: they're outside what MeshCore radios accept.",
      ),
      findsOneWidget,
    );
    await tester.enterText(
      find.byKey(const ValueKey('network-name')),
      'Hilltop',
    );
    await tester.enterText(
      find.byKey(const ValueKey('network-frequency')),
      '918.0',
    );
    await tester.tap(find.byKey(const ValueKey('network-add-save')));
    await tester.pumpAndSettle();
    expect(scan.saved.single.name, 'Hilltop');
    expect(scan.saved.single.freqKHz, 918000);
    expect(
      find.byKey(ValueKey('saved-${scan.saved.single.signature}')),
      findsOneWidget,
    );
  });
}
