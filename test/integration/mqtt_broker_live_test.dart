// Connects the real MQTT client to a local mosquitto broker that this test
// starts on 127.0.0.1. Skipped unless MQTT_LIVE=1.
//
//   MQTT_LIVE=1 MOSQUITTO=/usr/local/sbin/mosquitto \
//     MOSQUITTO_PASSWD=/usr/local/bin/mosquitto_passwd \
//     MOSQUITTO_PUB=/usr/local/bin/mosquitto_pub \
//     MOSQUITTO_SUB=/usr/local/bin/mosquitto_sub \
//     flutter test test/integration/mqtt_broker_live_test.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/mqtt_broker_settings.dart';
import 'package:meshcore_open/models/mqtt_connection_status.dart';
import 'package:meshcore_open/models/mqtt_observer_status.dart';
import 'package:meshcore_open/models/mqtt_publish_policy.dart';
import 'package:meshcore_open/models/radio_rx_packet.dart';
import 'package:meshcore_open/services/mqtt_broker_service.dart';
import 'package:meshcore_open/services/mqtt_client_transport.dart';
import 'package:meshcore_open/services/mqtt_transport.dart';
import 'package:meshcore_open/services/secure_mqtt_credentials_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/mesh_packet_fixtures.dart';

const _tcpPort = 18831;
const _wsPort = 18832;
const _tlsPort = 18833;

final bool enabled = Platform.environment['MQTT_LIVE'] == '1';

late Directory _dir;
Process? _broker;

Future<void> _startBroker() async {
  _broker = await Process.start(
    Platform.environment['MOSQUITTO'] ?? 'mosquitto',
    ['-c', '${_dir.path}/mosquitto.conf'],
  );
  for (var i = 0; i < 50; i++) {
    try {
      (await Socket.connect('127.0.0.1', _tcpPort)).destroy();
      return;
    } on SocketException {
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
  }
  throw StateError('mosquitto did not start');
}

Future<void> _stopBroker() async {
  _broker?.kill();
  await _broker?.exitCode;
  _broker = null;
}

MqttBrokerSettings _local(int port, {bool tls = false, bool ws = false}) =>
    MqttBrokerSettings(
      host: '127.0.0.1',
      port: port,
      useTls: tls,
      useWebSocket: ws,
    );

Future<MqttConnectFailure?> _connect(
  MqttBrokerSettings settings, {
  String? username = 'alice',
  String? password = 's3cret',
}) async {
  final transport = createMqttClientTransport(settings, 'notoryx-livetest');
  final failure = await transport.connect(
    username: username,
    password: password,
  );
  transport.disconnect();
  return failure;
}

void main() {
  setUpAll(() async {
    if (!enabled) return;
    _dir = await Directory.systemTemp.createTemp('mqtt_live');
    final passwd =
        Platform.environment['MOSQUITTO_PASSWD'] ?? 'mosquitto_passwd';
    await Process.run(passwd, [
      '-c',
      '-b',
      '${_dir.path}/passwd',
      'alice',
      's3cret',
    ]);
    await Process.run('openssl', [
      'req',
      '-x509',
      '-newkey',
      'rsa:2048',
      '-nodes',
      '-days',
      '1',
      '-subj',
      '/CN=127.0.0.1',
      '-keyout',
      '${_dir.path}/key.pem',
      '-out',
      '${_dir.path}/cert.pem',
    ]);
    File('${_dir.path}/mosquitto.conf').writeAsStringSync('''
allow_anonymous false
password_file ${_dir.path}/passwd
listener $_tcpPort 127.0.0.1
listener $_wsPort 127.0.0.1
protocol websockets
listener $_tlsPort 127.0.0.1
certfile ${_dir.path}/cert.pem
keyfile ${_dir.path}/key.pem
''');
    await _startBroker();
  });

  tearDownAll(() async {
    if (!enabled) return;
    await _stopBroker();
    await _dir.delete(recursive: true);
  });

  test('connects over TCP with valid credentials', () async {
    expect(await _connect(_local(_tcpPort)), isNull);
  }, skip: !enabled);

  test('connects over WebSocket', () async {
    expect(await _connect(_local(_wsPort, ws: true)), isNull);
  }, skip: !enabled);

  test('reports a wrong password', () async {
    expect(
      await _connect(_local(_tcpPort), password: 'wrong'),
      anyOf(
        MqttConnectFailure.badCredentials,
        MqttConnectFailure.notAuthorized,
      ),
    );
  }, skip: !enabled);

  test('reports missing credentials as not authorized', () async {
    expect(
      await _connect(_local(_tcpPort), username: null, password: null),
      anyOf(
        MqttConnectFailure.notAuthorized,
        MqttConnectFailure.badCredentials,
      ),
    );
  }, skip: !enabled);

  test('refuses an untrusted TLS certificate', () async {
    expect(await _connect(_local(_tlsPort, tls: true)), MqttConnectFailure.tls);
  }, skip: !enabled);

  test('reports an unreachable broker', () async {
    expect(await _connect(_local(18839)), MqttConnectFailure.unreachable);
  }, skip: !enabled);

  test(
    'service reconnects after the broker restarts',
    () async {
      SharedPreferences.setMockInitialValues({});
      final credentials = MemoryMqttCredentialsStore();
      final service = MqttBrokerService(
        prefs: await SharedPreferences.getInstance(),
        credentials: credentials,
        transportFactory: createMqttClientTransport,
      );
      addTearDown(service.dispose);
      await service.load();
      expect(
        await service.saveConfiguration(
          _local(_tcpPort),
          allowInsecureLocalBroker: true,
          username: 'alice',
          password: 's3cret',
        ),
        isNull,
      );
      await service.connect();
      expect(service.status, MqttConnectionStatus.connected);

      final seen = <MqttConnectionStatus>{};
      service.addListener(() => seen.add(service.status));
      await _stopBroker();
      await _waitFor(() => seen.contains(MqttConnectionStatus.reconnecting));
      await _startBroker();
      await _waitFor(() => service.status == MqttConnectionStatus.connected);

      service.disconnect();
      expect(service.status, MqttConnectionStatus.disconnected);
    },
    skip: !enabled,
    timeout: const Timeout(Duration(minutes: 2)),
  );
  test('receives observer packets for the configured region', () async {
    SharedPreferences.setMockInitialValues({});
    final service = MqttBrokerService(
      prefs: await SharedPreferences.getInstance(),
      credentials: MemoryMqttCredentialsStore(),
      transportFactory: createMqttClientTransport,
      statsNotifyInterval: Duration.zero,
    );
    addTearDown(service.dispose);
    await service.load();
    await service.saveConfiguration(
      const MqttBrokerSettings(
        host: '127.0.0.1',
        port: _tcpPort,
        useTls: false,
        region: 'PHL',
      ),
      allowInsecureLocalBroker: true,
      username: 'alice',
      password: 's3cret',
    );
    await service.connect();
    expect(service.subscribedTopic, 'meshcore/PHL/+/packets');
    // Give the broker a moment to register the subscription.
    await Future<void>.delayed(const Duration(milliseconds: 300));

    final raw = groupTextPacket(psk: Uint8List(16), text: 'Alice: hi');
    await _publish('meshcore/PHL/AAAA/packets', observerMessage(raw));
    await _publish('meshcore/PHL/BBBB/packets', observerMessage(raw));
    await _publish('meshcore/NYC/CCCC/packets', observerMessage(raw));
    await _publish('meshcore/PHL/AAAA/status', observerMessage(raw));
    await _waitFor(() => service.packetsReceived >= 2);
    await Future<void>.delayed(const Duration(milliseconds: 300));

    expect(service.packetsReceived, 2);
    expect(service.packetsAccepted, 1);
    expect(service.packetsDuplicate, 1);
    expect(service.recentPackets.single.region, 'PHL');
    expect(service.recentPackets.single.payloadType, 5);
  }, skip: !enabled);
  test('shares heard packets that another subscriber receives', () async {
    Future<MqttBrokerService> service({MqttPublishSettings? share}) async {
      SharedPreferences.setMockInitialValues({});
      final service = MqttBrokerService(
        prefs: await SharedPreferences.getInstance(),
        credentials: MemoryMqttCredentialsStore(),
        transportFactory: createMqttClientTransport,
        statsNotifyInterval: Duration.zero,
      );
      addTearDown(service.dispose);
      await service.load();
      await service.saveConfiguration(
        const MqttBrokerSettings(
          host: '127.0.0.1',
          port: _tcpPort,
          useTls: false,
          region: 'PHL',
        ),
        allowInsecureLocalBroker: true,
        username: 'alice',
        password: 's3cret',
        publishSettings: share,
      );
      await service.connect();
      return service;
    }

    final observer = await service(
      share: const MqttPublishSettings(enabled: true),
    );
    observer.setObserverIdentity(publicKeyHex: 'feedface', name: 'Base');
    final listener = await service();
    await Future<void>.delayed(const Duration(milliseconds: 300));

    final raw = groupTextPacket(psk: Uint8List(16), text: 'Alice: hi');
    expect(
      observer.publishRadioPacket(
        RadioRxPacket(raw: raw, snr: 8, rssi: -88, receivedAt: DateTime.now()),
      ),
      isNull,
    );
    await _waitFor(() => listener.packetsAccepted == 1);
    final received = listener.recentPackets.single;
    expect(received.raw, raw);
    expect(received.observerName, 'Base');
    expect(received.observerKey, 'FEEDFACE');
    expect(received.region, 'PHL');
    expect(received.rssi, -88);

    // The observer hears its own publish but doesn't count it as new.
    await _waitFor(() => observer.packetsDuplicate == 1);
    expect(observer.packetsAccepted, 0);
  }, skip: !enabled);
  group('observer status', () {
    const statusTopic = 'meshcore/PHL/C0FFEE01/status';

    Future<MqttBrokerService> observer() async {
      SharedPreferences.setMockInitialValues({});
      final service = MqttBrokerService(
        prefs: await SharedPreferences.getInstance(),
        credentials: MemoryMqttCredentialsStore(),
        transportFactory: createMqttClientTransport,
        clientVersion: 'notoryx-core/livetest',
      );
      addTearDown(service.dispose);
      await service.load();
      await service.saveConfiguration(
        const MqttBrokerSettings(
          host: '127.0.0.1',
          port: _tcpPort,
          useTls: false,
          region: 'PHL',
        ),
        allowInsecureLocalBroker: true,
        username: 'alice',
        password: 's3cret',
        publishSettings: const MqttPublishSettings(enabled: true),
      );
      service.setObserverIdentity(
        publicKeyHex: 'c0ffee01',
        name: 'Ridge',
        details: const MqttObserverDetails(radio: '910.525,62.5,7,5'),
      );
      await service.connect();
      expect(service.status, MqttConnectionStatus.connected);
      return service;
    }

    tearDown(() => _clearRetained(statusTopic));

    test(
      'retains online while connected and offline after disconnect',
      () async {
        final service = await observer();
        final online = await _retained(statusTopic);
        expect(online, isNotNull);
        expect(online!.retained, isTrue);
        expect(online.json['status'], 'online');
        expect(online.json['origin'], 'Ridge');
        expect(online.json['origin_id'], 'C0FFEE01');
        expect(online.json['radio'], '910.525,62.5,7,5');
        expect(online.json['client_version'], 'notoryx-core/livetest');

        service.disconnect();
        await Future<void>.delayed(const Duration(milliseconds: 300));
        final offline = await _retained(statusTopic);
        expect(offline?.retained, isTrue);
        expect(offline?.json['status'], 'offline');
        expect(offline?.json['origin_id'], 'C0FFEE01');
      },
      skip: !enabled,
    );

    test(
      'the broker publishes the retained offline will on a dropped session',
      () async {
        final service = await observer();
        final watcher = await _Subscriber.start(statusTopic);
        addTearDown(watcher.stop);
        final first = await watcher.next();
        expect(first.json['status'], 'online');

        // A second client with the same id takes the session over, so the
        // broker drops the app's connection without a DISCONNECT packet.
        final clientId = (await SharedPreferences.getInstance()).getString(
          'mqtt_client_id',
        )!;
        service.setObserverIdentity(); // keep it from re-announcing
        await watcher.next(); // the app reports the radio gone: offline
        final intruder = createMqttClientTransport(
          const MqttBrokerSettings(
            host: '127.0.0.1',
            port: _tcpPort,
            useTls: false,
          ),
          clientId,
        );
        expect(
          await intruder.connect(username: 'alice', password: 's3cret'),
          isNull,
        );
        addTearDown(intruder.disconnect);

        final will = await watcher.next();
        expect(will.json['status'], 'offline');
        expect(will.json['origin'], 'Ridge');
        expect(will.json['origin_id'], 'C0FFEE01');
        final retained = await _retained(statusTopic);
        expect(retained?.retained, isTrue);
        expect(retained?.json['status'], 'offline');
        service.disconnect();
      },
      skip: !enabled,
    );
  });
}

typedef _StatusMessage = ({bool retained, Map<String, dynamic> json});

_StatusMessage _parseSubLine(String line) {
  final space = line.indexOf(' ');
  return (
    retained: line.substring(0, space) == '1',
    json: jsonDecode(line.substring(space + 1)) as Map<String, dynamic>,
  );
}

String get _sub => Platform.environment['MOSQUITTO_SUB'] ?? 'mosquitto_sub';

const _brokerArgs = [
  '-h',
  '127.0.0.1',
  '-p',
  '$_tcpPort',
  '-u',
  'alice',
  '-P',
  's3cret',
];

/// The retained message on [topic], or null if there is none.
Future<_StatusMessage?> _retained(String topic) async {
  final result = await Process.run(_sub, [
    ..._brokerArgs,
    '-t',
    topic,
    '--retained-only',
    '-C',
    '1',
    '-W',
    '2',
    '-F',
    '%r %p',
  ]);
  final line = (result.stdout as String).trim();
  return line.isEmpty ? null : _parseSubLine(line);
}

Future<void> _clearRetained(String topic) async {
  if (!enabled) return;
  await Process.run(Platform.environment['MOSQUITTO_PUB'] ?? 'mosquitto_pub', [
    ..._brokerArgs,
    '-t',
    topic,
    '-r',
    '-n',
  ]);
}

/// A mosquitto_sub process that reports every message on a topic.
class _Subscriber {
  _Subscriber._(this._process) {
    _process.stdout
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen((line) => _lines.add(_parseSubLine(line)));
  }

  final Process _process;
  final StreamController<_StatusMessage> _lines = StreamController();
  late final StreamIterator<_StatusMessage> _iterator = StreamIterator(
    _lines.stream,
  );

  static Future<_Subscriber> start(String topic) async {
    final process = await Process.start(_sub, [
      ..._brokerArgs,
      '-t',
      topic,
      '-F',
      '%r %p',
    ]);
    return _Subscriber._(process);
  }

  Future<_StatusMessage> next() async {
    final has = await _iterator.moveNext().timeout(const Duration(seconds: 10));
    expect(has, isTrue);
    return _iterator.current;
  }

  void stop() => _process.kill();
}

Future<void> _publish(String topic, Uint8List payload) async {
  final result = await Process.run(
    Platform.environment['MOSQUITTO_PUB'] ?? 'mosquitto_pub',
    [
      '-h',
      '127.0.0.1',
      '-p',
      '$_tcpPort',
      '-u',
      'alice',
      '-P',
      's3cret',
      '-t',
      topic,
      '-m',
      utf8.decode(payload),
    ],
  );
  expect(result.exitCode, 0, reason: '${result.stderr}');
}

Future<void> _waitFor(bool Function() condition) async {
  for (var i = 0; i < 600; i++) {
    if (condition()) return;
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }
  fail('condition not met within 60 s');
}
