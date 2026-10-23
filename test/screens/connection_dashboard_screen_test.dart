import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/models/saved_radio.dart';
import 'package:meshcore_open/screens/connection_dashboard_screen.dart';
import 'package:meshcore_open/services/mqtt_broker_service.dart';
import 'package:meshcore_open/services/secure_mqtt_credentials_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeConnector extends MeshCoreConnector {
  MeshCoreConnectionState fakeState = MeshCoreConnectionState.disconnected;
  MeshCoreTransportType fakeTransport = MeshCoreTransportType.bluetooth;
  bool fakeBluetoothOff = false;
  bool fakeReconnectScheduled = false;
  String? fakeError;
  SavedRadio? fakeSaved;
  int reconnectCalls = 0;
  int forgetCalls = 0;

  @override
  MeshCoreConnectionState get state => fakeState;
  @override
  bool get isConnected => fakeState == MeshCoreConnectionState.connected;
  @override
  MeshCoreTransportType get activeTransport => fakeTransport;
  @override
  bool get isBluetoothOff => fakeBluetoothOff;
  @override
  bool get isAutoReconnectScheduled => fakeReconnectScheduled;
  @override
  String? get lastConnectionError => fakeError;
  @override
  SavedRadio? get savedRadio => fakeSaved;
  @override
  String get deviceDisplayName => 'Ridge Base';
  @override
  String? get selfPublicKeyPrefixHex => 'a0a1a2a3a4a5';
  @override
  String? get firmwareVersionString => 'v1.9.1';
  @override
  int? get batteryMillivolts => 4050;
  @override
  int? get batteryPercent => 87;
  @override
  double? get lastRxSnr => 7.25;
  @override
  int? get lastRxRssi => -92;

  @override
  Future<void> reconnectSavedRadio() async => reconnectCalls++;
  @override
  Future<void> forgetSavedRadio() async => forgetCalls++;
}

const _saved = SavedRadio(
  transport: SavedRadioTransport.bluetooth,
  address: 'AA:AA:AA:AA:AA:01',
  name: 'Ridge Base',
);

void main() {
  late _FakeConnector connector;

  setUp(() => connector = _FakeConnector());

  Future<void> pumpCard(WidgetTester tester) => tester.pumpWidget(
    ChangeNotifierProvider<MeshCoreConnector>.value(
      value: connector,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(
          body: SingleChildScrollView(child: RadioConnectionCard()),
        ),
      ),
    ),
  );

  String status(WidgetTester tester) =>
      tester.widget<Text>(find.byKey(const ValueKey('radio-status'))).data!;

  testWidgets('shows device identity, battery and signal when connected', (
    tester,
  ) async {
    connector.fakeState = MeshCoreConnectionState.connected;
    await pumpCard(tester);

    expect(status(tester), 'Connected');
    expect(find.textContaining('Ridge Base'), findsOneWidget);
    expect(find.textContaining('a0a1a2a3a4a5'), findsOneWidget);
    expect(find.textContaining('v1.9.1'), findsOneWidget);
    expect(find.textContaining('87% (4.05 V)'), findsOneWidget);
    expect(find.textContaining('SNR 7.3 dB · RSSI -92 dBm'), findsOneWidget);
    expect(find.text('Disconnect radio'), findsOneWidget);
    // Never the raw enum name.
    expect(find.text('connected'), findsNothing);
  });

  testWidgets('shows a readable last error instead of the state name', (
    tester,
  ) async {
    connector.fakeError = 'Timed out. Check that the radio is on and in range.';
    await pumpCard(tester);

    expect(status(tester), 'Not connected');
    expect(
      find.text(
        'Last error: Timed out. Check that the radio is on and in range.',
      ),
      findsOneWidget,
    );
    expect(find.text('disconnected'), findsNothing);
    expect(find.textContaining('a0a1a2a3a4a5'), findsNothing);
  });

  testWidgets('Bluetooth off is shown and blocks a BLE reconnect', (
    tester,
  ) async {
    connector
      ..fakeBluetoothOff = true
      ..fakeSaved = _saved
      ..fakeError = 'Bluetooth is off';
    await pumpCard(tester);

    expect(status(tester), 'Bluetooth is off');
    expect(find.textContaining('Bluetooth is off. Turn it on'), findsOneWidget);
    expect(find.byKey(const ValueKey('radio-error')), findsNothing);
    expect(find.textContaining('Reconnect to'), findsNothing);
  });

  testWidgets('Bluetooth off does not hide a live USB link', (tester) async {
    connector
      ..fakeBluetoothOff = true
      ..fakeTransport = MeshCoreTransportType.usb
      ..fakeState = MeshCoreConnectionState.connected;
    await pumpCard(tester);
    expect(status(tester), 'Connected');
    expect(find.textContaining('Turn it on'), findsNothing);
  });

  testWidgets('offers reconnect to the saved radio and forget', (tester) async {
    connector.fakeSaved = _saved;
    await pumpCard(tester);

    await tester.tap(find.text('Reconnect to Ridge Base'));
    await tester.pump();
    expect(connector.reconnectCalls, 1);

    await tester.tap(find.text('Forget radio'));
    await tester.pump();
    expect(connector.forgetCalls, 1);
  });

  testWidgets('no reconnect offer while connecting; cancel instead', (
    tester,
  ) async {
    connector
      ..fakeSaved = _saved
      ..fakeState = MeshCoreConnectionState.connecting;
    await pumpCard(tester);
    expect(status(tester), 'Connecting…');
    expect(find.textContaining('Reconnect to'), findsNothing);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('says when a reconnect is scheduled', (tester) async {
    connector.fakeReconnectScheduled = true;
    await pumpCard(tester);
    expect(status(tester), 'Reconnecting soon…');
  });

  group('layout', () {
    late MqttBrokerService mqtt;

    Future<void> pumpScreen(
      WidgetTester tester,
      Size size, {
      MeshCoreConnectionState state = MeshCoreConnectionState.connected,
    }) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      SharedPreferences.setMockInitialValues({});
      mqtt = MqttBrokerService(
        prefs: await SharedPreferences.getInstance(),
        credentials: MemoryMqttCredentialsStore(),
        transportFactory: (_, _) => throw UnimplementedError(),
      );
      addTearDown(mqtt.dispose);
      await mqtt.load();
      connector
        ..fakeState = state
        ..fakeSaved = const SavedRadio(
          transport: SavedRadioTransport.tcp,
          address: '192.168.40.10:5000',
          name: 'A radio with a rather long name for a phone screen',
        );
      // Start from an empty tree so a changed fake state is rebuilt.
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<MeshCoreConnector>.value(value: connector),
            ChangeNotifierProvider<MqttBrokerService>.value(value: mqtt),
          ],
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const ConnectionDashboardScreen(),
          ),
        ),
      );
      await tester.pump();
    }

    testWidgets('fits a phone width without overflow', (tester) async {
      for (final state in [
        MeshCoreConnectionState.connected,
        MeshCoreConnectionState.disconnected,
      ]) {
        await pumpScreen(tester, const Size(320, 800), state: state);
        expect(tester.takeException(), isNull);
        final card = tester.getSize(find.byType(RadioConnectionCard));
        expect(card.width, lessThanOrEqualTo(320));
      }
      expect(find.textContaining('Reconnect to A radio'), findsOneWidget);
      // The transport tiles stack at phone width, below the MQTT card.
      await tester.scrollUntilVisible(find.textContaining('(TCP)'), 200);
      expect(tester.takeException(), isNull);
      final bluetooth = tester.getTopLeft(find.text('Bluetooth').last);
      final tcp = tester.getTopLeft(find.textContaining('(TCP)'));
      expect(tcp.dy, greaterThan(bluetooth.dy));
    });

    testWidgets('caps the content width on desktop', (tester) async {
      await pumpScreen(tester, const Size(1600, 1000));
      expect(tester.takeException(), isNull);
      final card = tester.getRect(find.byType(RadioConnectionCard));
      expect(
        card.width,
        lessThanOrEqualTo(ConnectionDashboardScreen.maxContentWidth),
      );
      // Centered on the wide window.
      expect(card.center.dx, closeTo(800, 1));
    });
  });

  test('labels format battery and signal', () {
    expect(batteryLabel(null, null), isNull);
    expect(batteryLabel(null, 3700), '3.70 V');
    expect(batteryLabel(55, 3800), '55% (3.80 V)');
    expect(signalLabel(null, null), isNull);
    expect(signalLabel(-3.5, null), 'SNR -3.5 dB');
    expect(signalLabel(null, -110), 'RSSI -110 dBm');
  });
}
