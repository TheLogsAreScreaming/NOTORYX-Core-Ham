import 'dart:async';
import 'dart:typed_data';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/mqtt_broker_settings.dart';
import 'package:meshcore_open/models/mqtt_connection_status.dart';
import 'package:meshcore_open/models/mqtt_mesh_packet.dart';
import 'package:meshcore_open/models/mqtt_publish_policy.dart';
import 'package:meshcore_open/models/radio_rx_packet.dart';
import 'package:meshcore_open/services/mqtt_broker_service.dart';
import 'package:meshcore_open/services/mqtt_transport.dart';
import 'package:meshcore_open/services/secure_mqtt_credentials_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/mesh_packet_fixtures.dart';

class FakeTransport implements MqttTransport {
  FakeTransport(this.result);

  MqttConnectFailure? result;
  Completer<void>? gate;
  String? username;
  String? password;
  bool disconnected = false;
  void Function()? lost;

  @override
  Future<MqttConnectFailure?> connect({
    String? username,
    String? password,
  }) async {
    this.username = username;
    this.password = password;
    await gate?.future;
    return result;
  }

  @override
  void disconnect() => disconnected = true;

  @override
  set onConnectionLost(void Function()? callback) => lost = callback;

  final List<String> subscriptions = [];
  MqttMessageHandler? onMessageHandler;
  void Function(String topic)? subscribeFailed;

  @override
  void subscribe(String topic) => subscriptions.add(topic);

  final List<(String, Uint8List)> published = [];
  bool canPublish = true;

  @override
  bool publish(String topic, Uint8List payload) {
    if (!canPublish) return false;
    published.add((topic, payload));
    return true;
  }

  @override
  set onMessage(MqttMessageHandler? handler) => onMessageHandler = handler;

  @override
  set onSubscribeFailed(void Function(String topic)? callback) =>
      subscribeFailed = callback;
}

const _settings = MqttBrokerSettings(host: 'broker.test', port: 8883);

void main() {
  late SharedPreferences prefs;
  late MemoryMqttCredentialsStore credentials;
  late List<FakeTransport> transports;
  late List<MqttConnectFailure?> results;

  MqttBrokerService build() => MqttBrokerService(
    prefs: prefs,
    credentials: credentials,
    transportFactory: (settings, clientId) {
      final transport = FakeTransport(
        results.isEmpty ? null : results.removeAt(0),
      );
      transports.add(transport);
      return transport;
    },
    maxReconnectAttempts: 2,
  );

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    credentials = MemoryMqttCredentialsStore();
    transports = [];
    results = [];
  });

  test('starts unconfigured and cannot connect', () async {
    final service = build();
    await service.load();
    expect(service.status, MqttConnectionStatus.notConfigured);
    expect(service.canConnect, isFalse);
    await service.connect();
    expect(transports, isEmpty);
  });

  test('saves settings to prefs and credentials to the secure store', () async {
    final service = build();
    await service.load();
    final error = await service.saveConfiguration(
      _settings,
      username: 'alice',
      password: 's3cret',
    );
    expect(error, isNull);
    expect(service.status, MqttConnectionStatus.disconnected);
    expect(service.username, 'alice');
    final stored = prefs.getString('mqtt_broker_settings')!;
    expect(stored, contains('broker.test'));
    expect(stored, isNot(contains('alice')));
    expect(stored, isNot(contains('s3cret')));
    expect((await credentials.read())?.password, 's3cret');

    final reloaded = build();
    await reloaded.load();
    expect(reloaded.settings?.host, 'broker.test');
    expect(reloaded.username, 'alice');
    expect(reloaded.status, MqttConnectionStatus.disconnected);
  });

  test('keeps the saved password when none is entered', () async {
    final service = build();
    await service.load();
    await service.saveConfiguration(
      _settings,
      username: 'alice',
      password: 's3cret',
    );
    expect(
      await service.saveConfiguration(_settings, username: 'alice'),
      isNull,
    );
    expect((await credentials.read())?.password, 's3cret');
    expect(
      await service.saveConfiguration(_settings, username: 'bob'),
      isNotNull,
    );
    expect(await service.saveConfiguration(_settings), isNull);
    expect(await credentials.read(), isNull);
    expect(service.hasCredentials, isFalse);
  });

  test('rejects cleartext brokers unless local and allowed', () async {
    final service = build();
    await service.load();
    const cleartext = MqttBrokerSettings(
      host: '192.168.1.5',
      port: 1883,
      useTls: false,
    );
    expect(await service.saveConfiguration(cleartext), isNotNull);
    expect(
      await service.saveConfiguration(
        cleartext,
        allowInsecureLocalBroker: true,
      ),
      isNull,
    );
  });

  test('connects with stored credentials and disconnects', () async {
    final service = build();
    await service.load();
    await service.saveConfiguration(
      _settings,
      username: 'alice',
      password: 's3cret',
    );
    final seen = <MqttConnectionStatus>[];
    service.addListener(() => seen.add(service.status));
    await service.connect();
    expect(service.status, MqttConnectionStatus.connected);
    expect(seen, [
      MqttConnectionStatus.connecting,
      MqttConnectionStatus.connected,
    ]);
    expect(transports.single.username, 'alice');
    expect(transports.single.password, 's3cret');
    expect(service.diagnostics.toSafeMap().values, isNot(contains('s3cret')));

    service.disconnect();
    expect(service.status, MqttConnectionStatus.disconnected);
    expect(transports.single.disconnected, isTrue);
  });

  test('does not retry rejected credentials', () async {
    results = [MqttConnectFailure.badCredentials];
    final service = build();
    await service.load();
    await service.saveConfiguration(_settings);
    await service.connect();
    expect(service.status, MqttConnectionStatus.error);
    expect(service.diagnostics.lastErrorCategory, 'badCredentials');
    expect(service.errorMessage, contains('username or password'));
    expect(transports, hasLength(1));
    expect(service.canConnect, isTrue);
  });

  test('retries unreachable brokers with backoff, then gives up', () {
    fakeAsync((async) {
      results = [
        MqttConnectFailure.unreachable,
        MqttConnectFailure.unreachable,
        MqttConnectFailure.unreachable,
      ];
      final service = build();
      service.load();
      service.saveConfiguration(_settings);
      async.flushMicrotasks();
      service.connect();
      async.flushMicrotasks();
      expect(service.status, MqttConnectionStatus.reconnecting);
      expect(service.reconnectAttempt, 1);

      async.elapse(const Duration(seconds: 1));
      expect(transports, hasLength(2));
      expect(service.reconnectAttempt, 2);

      async.elapse(const Duration(seconds: 2));
      expect(transports, hasLength(3));
      expect(service.status, MqttConnectionStatus.error);

      async.elapse(const Duration(minutes: 5));
      expect(transports, hasLength(3));
    });
  });

  test('reconnects after an established session drops', () {
    fakeAsync((async) {
      final service = build();
      service.load();
      service.saveConfiguration(_settings);
      async.flushMicrotasks();
      service.connect();
      async.flushMicrotasks();
      expect(service.status, MqttConnectionStatus.connected);

      transports.single.lost!();
      expect(service.status, MqttConnectionStatus.reconnecting);
      async.elapse(const Duration(seconds: 1));
      expect(transports, hasLength(2));
      expect(service.status, MqttConnectionStatus.connected);
      expect(service.reconnectAttempt, 0);
    });
  });

  test('disconnect cancels a pending reconnect', () {
    fakeAsync((async) {
      results = [MqttConnectFailure.unreachable];
      final service = build();
      service.load();
      service.saveConfiguration(_settings);
      async.flushMicrotasks();
      service.connect();
      async.flushMicrotasks();
      expect(service.status, MqttConnectionStatus.reconnecting);

      service.disconnect();
      async.elapse(const Duration(minutes: 1));
      expect(transports, hasLength(1));
      expect(service.status, MqttConnectionStatus.disconnected);
    });
  });

  test('a session that finishes after disconnect is closed', () async {
    final service = build();
    await service.load();
    await service.saveConfiguration(_settings);
    final gate = Completer<void>();
    final pending = service.connect();
    await Future<void>.delayed(Duration.zero);
    transports.single.gate = gate;
    service.disconnect();
    gate.complete();
    await pending;
    expect(service.status, MqttConnectionStatus.disconnected);
    expect(transports.single.disconnected, isTrue);
  });

  test('reuses one client identifier', () async {
    final ids = <String>[];
    final service = MqttBrokerService(
      prefs: prefs,
      credentials: credentials,
      transportFactory: (settings, clientId) {
        ids.add(clientId);
        return FakeTransport(null);
      },
    );
    await service.load();
    await service.saveConfiguration(_settings);
    await service.connect();
    service.disconnect();
    await service.connect();
    expect(ids, hasLength(2));
    expect(ids.first, ids.last);
    expect(ids.first, startsWith('notoryx-'));
  });

  group('packet subscription', () {
    final psk = Uint8List.fromList(List.generate(16, (i) => i));
    final packet = groupTextPacket(psk: psk, text: 'Alice: hi');

    Future<MqttBrokerService> connected({String region = ''}) async {
      final service = MqttBrokerService(
        prefs: prefs,
        credentials: credentials,
        transportFactory: (settings, clientId) {
          final transport = FakeTransport(null);
          transports.add(transport);
          return transport;
        },
        statsNotifyInterval: Duration.zero,
      );
      await service.load();
      await service.saveConfiguration(
        MqttBrokerSettings(host: 'broker.test', port: 8883, region: region),
      );
      await service.connect();
      return service;
    }

    test('subscribes to observer packets after connecting', () async {
      final service = await connected(region: 'PHL');
      expect(transports.single.subscriptions, ['meshcore/PHL/+/packets']);
      expect(service.subscribedTopic, 'meshcore/PHL/+/packets');
      service.disconnect();
      expect(service.subscribedTopic, isNull);
    });

    test('emits each distinct packet once and counts the rest', () async {
      final service = await connected();
      final seen = <MqttMeshPacket>[];
      service.packets.listen(seen.add);
      final deliver = transports.single.onMessageHandler!;

      deliver('meshcore/PHL/AAAA/packets', observerMessage(packet));
      deliver(
        'meshcore/PHL/BBBB/packets',
        observerMessage(packet, origin: 'Valley', originId: 'BBBB'),
      );
      deliver('meshcore/PHL/AAAA/packets', Uint8List.fromList([1, 2, 3]));
      await Future<void>.delayed(Duration.zero);

      expect(seen, hasLength(1));
      expect(seen.single.observerName, 'Hilltop');
      expect(service.recentPackets, hasLength(1));
      expect(service.packetsReceived, 3);
      expect(service.packetsAccepted, 1);
      expect(service.packetsDuplicate, 1);
      expect(service.packetsRejected, 1);
    });

    test('keeps only the most recent packets', () async {
      final service = await connected();
      final deliver = transports.single.onMessageHandler!;
      for (var i = 0; i < MqttBrokerService.recentPacketLimit + 5; i++) {
        deliver(
          'meshcore/PHL/AAAA/packets',
          observerMessage(groupTextPacket(psk: psk, text: 'Alice: $i')),
        );
      }
      expect(
        service.recentPackets,
        hasLength(MqttBrokerService.recentPacketLimit),
      );
      expect(
        service.recentPackets.first.hash,
        MqttMeshPacket.tryParse(
          't',
          observerMessage(
            groupTextPacket(
              psk: psk,
              text: 'Alice: ${MqttBrokerService.recentPacketLimit + 4}',
            ),
          ),
        )!.hash,
      );
    });

    test('ignores messages from an ended session', () async {
      final service = await connected();
      final deliver = transports.single.onMessageHandler!;
      service.disconnect();
      deliver('meshcore/PHL/AAAA/packets', observerMessage(packet));
      expect(service.packetsReceived, 0);
    });

    test('reports a refused subscription', () async {
      final service = await connected();
      transports.single.subscribeFailed!('meshcore/+/+/packets');
      expect(service.subscriptionFailed, isTrue);
      expect(service.subscribedTopic, isNull);
      expect(service.errorMessage, contains('subscription'));
    });

    test('saving settings resets packet stats', () async {
      final service = await connected();
      transports.single.onMessageHandler!(
        'meshcore/PHL/AAAA/packets',
        observerMessage(packet),
      );
      await service.saveConfiguration(_settings);
      expect(service.packetsReceived, 0);
      expect(service.recentPackets, isEmpty);
    });

    test('persists the channel delivery choice', () async {
      final service = build();
      await service.load();
      expect(service.deliverChannelMessages, isFalse);
      await service.saveConfiguration(_settings, deliverChannelMessages: true);
      expect(service.deliverChannelMessages, isTrue);
      final reloaded = build();
      await reloaded.load();
      expect(reloaded.deliverChannelMessages, isTrue);
      await reloaded.saveConfiguration(_settings);
      expect(reloaded.deliverChannelMessages, isTrue);
    });
  });

  group('observer publishing', () {
    const share = MqttPublishSettings(enabled: true);
    const regional = MqttBrokerSettings(
      host: 'broker.test',
      port: 8883,
      region: 'PHL',
    );
    final psk = Uint8List.fromList(List.generate(16, (i) => i));
    final start = DateTime.utc(2026, 10, 21, 18);

    RadioRxPacket heard(
      Uint8List raw, {
      bool fromSelf = false,
      Duration after = Duration.zero,
    }) => RadioRxPacket(
      raw: raw,
      snr: 5,
      rssi: -90,
      receivedAt: start.add(after),
      fromSelf: fromSelf,
    );

    final channelPacket = groupTextPacket(psk: psk, text: 'Alice: hi');
    final directPacket = Uint8List.fromList([0x09, 0, 0x12, 0x34, 1, 2]);

    Future<MqttBrokerService> sharing({
      MqttPublishSettings settings = share,
      int maxPerMinute = 60,
      bool connect = true,
    }) async {
      final service = MqttBrokerService(
        prefs: prefs,
        credentials: credentials,
        transportFactory: (settings, clientId) {
          final transport = FakeTransport(null);
          transports.add(transport);
          return transport;
        },
        statsNotifyInterval: Duration.zero,
        maxPublishesPerMinute: maxPerMinute,
      );
      await service.load();
      expect(
        await service.saveConfiguration(regional, publishSettings: settings),
        isNull,
      );
      service.setObserverIdentity(publicKeyHex: 'ab12cd34', name: 'Base');
      if (connect) await service.connect();
      return service;
    }

    test('publishes nothing by default', () async {
      final service = build();
      await service.load();
      await service.saveConfiguration(regional);
      service.setObserverIdentity(publicKeyHex: 'ab12', name: 'Base');
      await service.connect();
      expect(
        service.publishRadioPacket(heard(channelPacket)),
        MqttPublishSkip.disabled,
      );
      expect(transports.single.published, isEmpty);
      expect(service.publishTopic, isNull);
    });

    test('requires a region to turn sharing on', () async {
      final service = build();
      await service.load();
      expect(
        await service.saveConfiguration(_settings, publishSettings: share),
        contains('region'),
      );
      expect(service.publishSettings.enabled, isFalse);
    });

    test('publishes heard packets to its observer topic', () async {
      final service = await sharing();
      expect(service.publishTopic, 'meshcore/PHL/AB12CD34/packets');
      expect(service.publishRadioPacket(heard(channelPacket)), isNull);
      final (topic, payload) = transports.single.published.single;
      expect(topic, 'meshcore/PHL/AB12CD34/packets');
      final parsed = MqttMeshPacket.tryParse(topic, payload)!;
      expect(parsed.raw, channelPacket);
      expect(parsed.observerName, 'Base');
      expect(parsed.observerKey, 'AB12CD34');
      expect(service.packetsPublished, 1);
    });

    test('waits for a connection and a radio identity', () async {
      final offline = await sharing(connect: false);
      expect(
        offline.publishRadioPacket(heard(channelPacket)),
        MqttPublishSkip.notConnected,
      );
      final anonymous = await sharing();
      anonymous.setObserverIdentity();
      expect(anonymous.publishTopic, isNull);
      expect(
        anonymous.publishRadioPacket(heard(channelPacket)),
        MqttPublishSkip.noTopic,
      );
      expect(anonymous.publishSkips[MqttPublishSkip.noTopic], 1);
    });

    test('honours the direct and own traffic switches', () async {
      final strict = await sharing();
      expect(
        strict.publishRadioPacket(heard(directPacket)),
        MqttPublishSkip.directTraffic,
      );
      expect(
        strict.publishRadioPacket(heard(channelPacket, fromSelf: true)),
        MqttPublishSkip.ownTraffic,
      );
      expect(transports.last.published, isEmpty);

      final open = await sharing(
        settings: const MqttPublishSettings(
          enabled: true,
          includeDirectTraffic: true,
          includeOwnTraffic: true,
        ),
      );
      expect(open.publishRadioPacket(heard(directPacket)), isNull);
      expect(
        open.publishRadioPacket(heard(channelPacket, fromSelf: true)),
        isNull,
      );
      expect(transports.last.published, hasLength(2));
    });

    test('skips identical receptions but shares other paths', () async {
      final service = await sharing();
      expect(service.publishRadioPacket(heard(channelPacket)), isNull);
      expect(
        service.publishRadioPacket(heard(channelPacket)),
        MqttPublishSkip.alreadyShared,
      );
      final relayed = groupTextPacket(psk: psk, text: 'Alice: hi', path: [7]);
      expect(service.publishRadioPacket(heard(relayed)), isNull);
      expect(service.packetsPublished, 2);
    });

    test('limits publishes per minute', () async {
      final service = await sharing(maxPerMinute: 2);
      Uint8List packet(int i) => groupTextPacket(psk: psk, text: 'A: $i');
      expect(service.publishRadioPacket(heard(packet(1))), isNull);
      expect(
        service.publishRadioPacket(
          heard(packet(2), after: const Duration(seconds: 10)),
        ),
        isNull,
      );
      expect(
        service.publishRadioPacket(
          heard(packet(3), after: const Duration(seconds: 20)),
        ),
        MqttPublishSkip.rateLimited,
      );
      expect(
        service.publishRadioPacket(
          heard(packet(4), after: const Duration(seconds: 61)),
        ),
        isNull,
      );
    });

    test('reports a publish the session refused', () async {
      final service = await sharing();
      transports.single.canPublish = false;
      expect(
        service.publishRadioPacket(heard(channelPacket)),
        MqttPublishSkip.notConnected,
      );
      expect(service.packetsPublished, 0);
    });

    test('ignores its own publishes coming back', () async {
      final service = await sharing();
      final deliver = transports.single.onMessageHandler!;
      deliver(
        'meshcore/PHL/AB12CD34/packets',
        observerMessage(channelPacket, originId: 'AB12CD34'),
      );
      expect(service.packetsAccepted, 0);
      expect(service.packetsDuplicate, 1);
      deliver(
        'meshcore/PHL/EEEE/packets',
        observerMessage(channelPacket, originId: 'EEEE'),
      );
      expect(service.packetsAccepted, 1);
    });

    test('persists sharing settings', () async {
      await sharing(
        settings: const MqttPublishSettings(
          enabled: true,
          includeDirectTraffic: true,
        ),
      );
      final reloaded = build();
      await reloaded.load();
      expect(reloaded.publishSettings.enabled, isTrue);
      expect(reloaded.publishSettings.includeDirectTraffic, isTrue);
      expect(reloaded.publishSettings.includeOwnTraffic, isFalse);
    });
  });
}
