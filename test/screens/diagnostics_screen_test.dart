import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/screens/bastion_diagnostics_screen.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Radio extends MeshCoreConnector {
  @override
  List<Contact> get contacts => [
    Contact(
      publicKey: Uint8List.fromList(List.filled(32, 1)),
      name: 'Hilltop',
      type: advTypeRepeater,
      pathLength: 0,
      path: Uint8List(0),
      lastSeen: DateTime.now(),
    ),
  ];
  @override
  int? get currentSf => 10;
}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
  });
  tearDown(PrefsManager.reset);

  testWidgets('counts open their nodes, and values copy', (tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 2000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          copied = (call.arguments as Map)['text'] as String?;
        }
        return null;
      },
    );
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
          home: BastionDiagnosticsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('10'));
    await tester.pump();
    expect(copied, '10');
    expect(find.textContaining('Copied'), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.tap(find.byKey(const ValueKey('diag-metric-repeaters')));
    await tester.pumpAndSettle();
    expect(find.text('Hilltop'), findsOneWidget);
    await tester.tap(find.text('Hilltop'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('node-sheet')), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    settings.dispose();
    radio.dispose();
  });
}
