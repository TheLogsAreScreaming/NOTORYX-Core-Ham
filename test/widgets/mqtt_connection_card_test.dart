import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/mqtt_broker_settings.dart';
import 'package:meshcore_open/services/mqtt_broker_service.dart';
import 'package:meshcore_open/services/mqtt_transport.dart';
import 'package:meshcore_open/services/network_monitor.dart';
import 'package:meshcore_open/services/secure_mqtt_credentials_store.dart';
import 'package:meshcore_open/widgets/mqtt_connection_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/mesh_packet_fixtures.dart';

class _Transport implements MqttTransport {
  _Transport(this.result);

  final MqttConnectFailure? result;

  String? username;

  @override
  Future<MqttConnectFailure?> connect({
    String? username,
    String? password,
    MqttWill? will,
  }) async {
    this.username = username;
    return result;
  }

  @override
  void disconnect() {}

  @override
  set onConnectionLost(void Function()? callback) {}

  MqttMessageHandler? deliver;

  @override
  void subscribe(String topic) {}

  @override
  bool publish(String topic, Uint8List payload, {bool retain = false}) => true;

  @override
  set onMessage(MqttMessageHandler? handler) => deliver = handler;

  @override
  set onSubscribeFailed(void Function(String topic)? callback) {}
}

void main() {
  late MqttBrokerService service;
  _Transport? transport;
  MqttConnectFailure? result;

  Future<void> pump(WidgetTester tester, {NetworkMonitor? network}) async {
    // Tall enough that the whole settings form is built.
    tester.view.physicalSize = const Size(800, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues({});
    service = MqttBrokerService(
      prefs: await SharedPreferences.getInstance(),
      credentials: MemoryMqttCredentialsStore(),
      transportFactory: (_, _) => transport = _Transport(result),
      statsNotifyInterval: Duration.zero,
      networkMonitor: network,
    );
    await service.load();
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: service,
        child: const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: MqttConnectionCard()),
          ),
        ),
      ),
    );
  }

  setUp(() => result = null);

  testWidgets('offers broker setup when unconfigured', (tester) async {
    await pump(tester);
    expect(find.text('Not configured'), findsOneWidget);
    expect(find.text('Set up broker'), findsOneWidget);
    expect(find.text('Connect MQTT'), findsNothing);
  });

  testWidgets('saves settings from the settings screen', (tester) async {
    await pump(tester);
    await tester.tap(find.text('Set up broker'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Broker hostname'),
      'broker.example.org',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Username (optional)'),
      'alice',
    );
    await tester.enterText(find.widgetWithText(TextField, 'Password'), 'pw');
    await tester.tap(find.text('Save settings'));
    await tester.pumpAndSettle();

    expect(service.settings?.host, 'broker.example.org');
    expect(find.text('Disconnected'), findsOneWidget);
    expect(
      find.text('Broker: broker.example.org:8883 (MQTTS)'),
      findsOneWidget,
    );
    expect(find.text('Signed in as alice'), findsOneWidget);
  });

  testWidgets('settings screen blocks remote cleartext brokers', (
    tester,
  ) async {
    await pump(tester);
    await tester.tap(find.text('Set up broker'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Broker hostname'),
      'broker.example.org',
    );
    await tester.tap(find.text('Use TLS'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Allow cleartext to a local broker'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save settings'));
    await tester.pumpAndSettle();
    expect(
      find.text(
        'Cleartext MQTT is restricted to explicitly approved local hosts.',
      ),
      findsOneWidget,
    );
    expect(service.settings, isNull);
  });

  testWidgets('connects and disconnects', (tester) async {
    await pump(tester);
    await service.saveConfiguration(
      const MqttBrokerSettings(host: 'broker.test', port: 8883),
    );
    await tester.pump();
    await tester.tap(find.text('Connect MQTT'));
    await tester.pump();
    expect(find.text('Connected'), findsOneWidget);
    await tester.tap(find.text('Disconnect MQTT'));
    await tester.pump();
    expect(find.text('Disconnected'), findsOneWidget);
  });

  testWidgets('shows why a connection failed', (tester) async {
    result = MqttConnectFailure.badCredentials;
    await pump(tester);
    await service.saveConfiguration(
      const MqttBrokerSettings(host: 'broker.test', port: 8883),
    );
    await tester.pump();
    await tester.tap(find.text('Connect MQTT'));
    await tester.pump();
    expect(find.text('Connection error'), findsOneWidget);
    expect(
      find.text('The broker rejected the username or password.'),
      findsOneWidget,
    );
  });

  testWidgets('shows packet counts and the packet feed', (tester) async {
    await pump(tester);
    await service.saveConfiguration(
      const MqttBrokerSettings(host: 'broker.test', port: 8883, region: 'PHL'),
    );
    await tester.pump();
    await tester.tap(find.text('Connect MQTT'));
    await tester.pump();
    expect(find.text('Listening on meshcore/PHL/+/packets'), findsOneWidget);

    final raw = groupTextPacket(
      psk: Uint8List(16),
      text: 'Alice: hi',
      path: [7],
    );
    transport!.deliver!('meshcore/PHL/AB12CD34/packets', observerMessage(raw));
    transport!.deliver!('meshcore/PHL/EF56/packets', observerMessage(raw));
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.text('Packets: 1 new, 1 duplicate, 0 invalid'), findsOneWidget);

    await tester.tap(find.text('Packet feed'));
    await tester.pumpAndSettle();
    expect(find.text('Channel message · Flood'), findsOneWidget);
    expect(find.textContaining('Heard by Hilltop (PHL)'), findsOneWidget);
    expect(find.textContaining('1 hops'), findsOneWidget);
    expect(find.textContaining('SNR 7.5 · RSSI -92'), findsOneWidget);
  });

  testWidgets('turns on observer sharing from settings', (tester) async {
    await pump(tester);
    await tester.tap(find.text('Set up broker'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Broker hostname'),
      'broker.example.org',
    );
    await tester.tap(find.text('Share packets my radio hears'));
    await tester.pumpAndSettle();
    expect(find.text('Include direct-message traffic'), findsOneWidget);
    await tester.tap(find.text('Save settings'));
    await tester.pumpAndSettle();
    expect(
      find.text('Set a region to share packets as an observer.'),
      findsOneWidget,
    );

    await tester.enterText(
      find.widgetWithText(TextField, 'Region (optional)'),
      'phl',
    );
    await tester.tap(find.text('Save settings'));
    await tester.pumpAndSettle();
    expect(service.publishSettings.enabled, isTrue);
    expect(service.publishSettings.includeDirectTraffic, isFalse);
    expect(service.settings?.region, 'PHL');
    expect(find.text('Sharing waits for a radio connection'), findsOneWidget);

    service.setObserverIdentity(publicKeyHex: 'abcd', name: 'Base');
    await tester.pump();
    expect(
      find.text('Will share on meshcore/PHL/ABCD/packets'),
      findsOneWidget,
    );
    await tester.tap(find.text('Connect MQTT'));
    await tester.pump();
    expect(find.text('Sharing on meshcore/PHL/ABCD/packets'), findsOneWidget);
  });

  testWidgets('sets up LetsMesh with radio-token sign-in', (tester) async {
    await pump(tester);
    transport = null;
    await tester.tap(find.text('Set up broker'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start from a preset'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('LetsMesh analyzer (US, community)').last);
    await tester.pumpAndSettle();
    expect(find.textContaining('not endorsed by it'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsNothing);
    expect(
      find.text('Connect your radio to sign in. MQTT waits for it.'),
      findsOneWidget,
    );
    await tester.tap(find.text('Save settings'));
    await tester.pumpAndSettle();

    final settings = service.settings!;
    expect(settings.host, 'mqtt-us-v1.letsmesh.net');
    expect(settings.port, 443);
    expect(settings.useTls, isTrue);
    expect(settings.useWebSocket, isTrue);
    expect(settings.webSocketPath, '/');
    expect(settings.authMode, MqttAuthMode.radioToken);
    expect(find.text('Signs in with a radio-signed token'), findsOneWidget);
    expect(find.text('Connect your radio to sign in'), findsOneWidget);

    await tester.tap(find.text('Connect MQTT'));
    await tester.pump();
    expect(transport, isNull);
    expect(
      find.text('Connect your radio to sign in with its key.'),
      findsOneWidget,
    );

    service.setObserverIdentity(publicKeyHex: 'ab12cd34ef', name: 'Base');
    service.setRadioSigner((_) async => Uint8List(64));
    await tester.pump();
    await tester.pump();
    expect(find.text('Connected'), findsOneWidget);
    expect(transport?.username, 'v1_AB12CD34EF');
    expect(
      find.text('Signs in with a radio-signed token as v1_AB12CD34…'),
      findsOneWidget,
    );
    expect(find.textContaining('Token renews at'), findsOneWidget);
    service.disconnect();
  });

  testWidgets('shows when MQTT is waiting for a network', (tester) async {
    await pump(tester, network: _OfflineMonitor());
    await service.saveConfiguration(
      const MqttBrokerSettings(host: 'broker.test', port: 8883),
    );
    await tester.pump();
    await tester.tap(find.text('Connect MQTT'));
    await tester.pump();
    expect(find.text('Reconnecting'), findsOneWidget);
    expect(
      find.text('No network connection. MQTT reconnects when it is back.'),
      findsOneWidget,
    );
    expect(find.textContaining('Retry'), findsNothing);
    expect(find.text('Cancel'), findsOneWidget);
  });
}

class _OfflineMonitor implements NetworkMonitor {
  @override
  Future<NetworkStatus> current() async => NetworkStatus.offline;

  @override
  Stream<NetworkStatus> get changes => const Stream.empty();
}
