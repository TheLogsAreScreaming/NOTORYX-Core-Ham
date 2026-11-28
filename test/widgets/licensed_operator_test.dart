import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/operator_profile.dart';
import 'package:meshcore_open/screens/licensed_operator_screen.dart';
import 'package:meshcore_open/services/operator_profile_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:meshcore_open/theme/mesh_theme.dart';
import 'package:meshcore_open/utils/station_id_check.dart';
import 'package:meshcore_open/widgets/operator_setup_banner.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Connector extends MeshCoreConnector {
  _Connector({
    required this.connected,
    this.name,
    this.freqKhz,
    this.mismatches = const [],
    this.firmware,
    this.stockFrames = 0,
  });
  final String? firmware;
  final int stockFrames;
  @override
  int get stockFramesHeard => stockFrames;
  @override
  String? get firmwareVersionString => firmware;
  final bool connected;
  final String? name;
  final int? freqKhz;
  final List<StationIdMismatch> mismatches;
  @override
  List<StationIdMismatch> get stationIdMismatches => mismatches;
  @override
  bool get isConnected => connected;
  @override
  String? get selfName => name;
  @override
  int? get currentFreqHz => freqKhz;
}

void main() {
  late OperatorProfileService profiles;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    profiles = OperatorProfileService()..load();
  });

  Widget app(
    Widget home, {
    bool connected = false,
    String? name,
    int? freqKhz,
    List<StationIdMismatch> mismatches = const [],
    String? firmware,
    int stockFrames = 0,
  }) {
    final navigatorKey = GlobalKey<NavigatorState>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MeshCoreConnector>.value(
          value: _Connector(
            connected: connected,
            name: name,
            freqKhz: freqKhz,
            mismatches: mismatches,
            firmware: firmware,
            stockFrames: stockFrames,
          ),
        ),
        ChangeNotifierProvider.value(value: profiles),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: MeshTheme.dark(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) =>
            OperatorSetupBanner(navigatorKey: navigatorKey, child: child!),
        home: home,
      ),
    );
  }

  testWidgets('saves only a complete profile, and keeps it', (tester) async {
    tester.view.physicalSize = const Size(1080, 5000);
    tester.view.devicePixelRatio = 2.5;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(app(const LicensedOperatorScreen()));
    FilledButton save() =>
        tester.widget(find.byKey(const ValueKey('operator-save')));

    expect(save().onPressed, isNull);
    await tester.enterText(
      find.byKey(const ValueKey('operator-callsign')),
      'vE3abc',
    );
    await tester.pump();
    expect(find.text('Not a US call sign'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('operator-callsign')),
      'w1aw',
    );
    await tester.tap(find.byKey(const ValueKey('operator-class')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('General').last);
    await tester.pumpAndSettle();
    expect(save().onPressed, isNull); // not acknowledged yet

    await tester.tap(find.byKey(const ValueKey('operator-acknowledge')));
    await tester.pump();
    await tester.ensureVisible(find.byKey(const ValueKey('operator-save')));
    await tester.tap(find.byKey(const ValueKey('operator-save')));
    await tester.pumpAndSettle();

    expect(profiles.profile.isComplete, isTrue);
    expect(profiles.profile.callsign, 'W1AW');
    expect(profiles.profile.licenseClass, LicenseClass.general);
    final reloaded = OperatorProfileService()..load();
    expect(reloaded.profile.callsign, 'W1AW');
  });

  testWidgets('banner shows only while connected and setup is unfinished', (
    tester,
  ) async {
    const banner = 'Finish licensed operator setup before transmitting';

    await tester.pumpWidget(app(const Text('home')));
    expect(find.text(banner), findsNothing); // not connected

    await tester.pumpWidget(app(const Text('home'), connected: true));
    expect(find.text(banner), findsOneWidget);

    await tester.tap(find.text(banner));
    await tester.pumpAndSettle();
    expect(find.text('Licensed operator'), findsWidgets);

    await profiles.save(
      OperatorProfile(
        callsign: 'W1AW',
        licenseClass: LicenseClass.technician,
        acknowledgedAt: DateTime.now(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text(banner), findsNothing);
  });

  testWidgets('banner then asks for the call sign name, then a ham band', (
    tester,
  ) async {
    await profiles.save(
      OperatorProfile(
        callsign: 'W1AW',
        licenseClass: LicenseClass.general,
        acknowledgedAt: DateTime.now(),
      ),
    );
    await tester.pumpWidget(
      app(const Text('home'), connected: true, name: 'Base', freqKhz: 906875),
    );
    expect(
      find.text('Name the radio with your call sign before transmitting'),
      findsOneWidget,
    );

    await tester.pumpWidget(
      app(
        const Text('home'),
        connected: true,
        name: 'W1AW Base',
        freqKhz: 869525,
      ),
    );
    expect(find.text('The radio is set outside the ham bands'), findsOneWidget);

    await tester.pumpWidget(
      app(
        const Text('home'),
        connected: true,
        name: 'W1AW Base',
        freqKhz: 906875,
      ),
    );
    expect(find.byType(OperatorSetupBanner), findsOneWidget);
    expect(find.byIcon(Icons.warning_amber_rounded), findsNothing);
  });

  testWidgets('station ID mismatches are listed only when heard', (
    tester,
  ) async {
    Future<void> open(List<StationIdMismatch> mismatches) async {
      await tester.pumpWidget(
        app(
          const LicensedOperatorScreen(),
          connected: true,
          name: 'W1AW Base',
          freqKhz: 910525,
          mismatches: mismatches,
        ),
      );
      await tester.pumpAndSettle();
    }

    await open(const []);
    await tester.scrollUntilVisible(
      find.textContaining('Firmware'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.byKey(const ValueKey('station-id-mismatches')), findsNothing);

    final at = DateTime.utc(2026, 11, 8);
    await open([
      StationIdMismatch(
        nodeKey: 'cdcdcdcd',
        advertName: 'Ridge Repeater',
        station: 'N0RPT',
        at: at,
      ),
      StationIdMismatch(
        nodeKey: 'abababab',
        advertName: 'W1AW Hilltop',
        station: 'KD2ABC',
        at: at,
      ),
    ]);
    final rows = find.text('W1AW Hilltop: sent with station ID KD2ABC');
    await tester.scrollUntilVisible(
      rows,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text("2 station IDs don't match their names"), findsOneWidget);
    expect(
      find.text('Ridge Repeater: sent with station ID N0RPT'),
      findsOneWidget,
    );
    expect(
      find.text("This name doesn't start with a call sign"),
      findsOneWidget,
    );
  });

  testWidgets('stock firmware is flagged before anything else', (tester) async {
    await tester.pumpWidget(
      app(
        const Text('home'),
        connected: true,
        name: 'Base',
        firmware: 'v1.18.0-6aab3dd0',
      ),
    );
    await tester.pump();
    expect(
      find.text(
        "This radio runs stock MeshCore. Don't transmit with it on the ham "
        'bands',
      ),
      findsOneWidget,
    );

    await tester.pumpWidget(
      app(
        const LicensedOperatorScreen(),
        connected: true,
        name: 'Base',
        firmware: 'v1.18.0-6aab3dd0',
      ),
    );
    await tester.pumpAndSettle();
    final note = find.textContaining('Stock MeshCore encrypts');
    await tester.scrollUntilVisible(
      note,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(note, findsOneWidget);
    expect(find.text('Ready to transmit'), findsNothing);
  });

  testWidgets('stock MeshCore traffic on the frequency is called out', (
    tester,
  ) async {
    Future<void> open(int stock) async {
      await tester.pumpWidget(
        app(
          const LicensedOperatorScreen(),
          connected: true,
          name: 'W1AW Base',
          freqKhz: 906875,
          stockFrames: stock,
        ),
      );
      await tester.pumpAndSettle();
    }

    await open(0);
    expect(find.byKey(const ValueKey('stock-traffic')), findsNothing);
    await open(3);
    final banner = find.byKey(const ValueKey('stock-traffic'));
    await tester.scrollUntilVisible(
      banner,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(
      find.text('3 stock MeshCore frames heard here in the last 10 minutes'),
      findsOneWidget,
    );
  });
}
