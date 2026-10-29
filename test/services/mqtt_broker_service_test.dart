import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/radio_signing.dart';
import 'package:meshcore_open/models/mqtt_broker_settings.dart';
import 'package:meshcore_open/models/mqtt_connection_status.dart';
import 'package:meshcore_open/models/mqtt_mesh_packet.dart';
import 'package:meshcore_open/models/mqtt_notice.dart';
import 'package:meshcore_open/models/mqtt_observer_status.dart';
import 'package:meshcore_open/models/mqtt_publish_policy.dart';
import 'package:meshcore_open/models/radio_rx_packet.dart';
import 'package:meshcore_open/services/mqtt_broker_service.dart';
import 'package:meshcore_open/services/mqtt_transport.dart';
import 'package:meshcore_open/services/network_monitor.dart';
import 'package:meshcore_open/services/secure_mqtt_credentials_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/mesh_packet_fixtures.dart';

class FakeTransport implements MqttTransport {
  FakeTransport(this.result);

  MqttConnectFailure? result;
  Completer<void>? gate;
  String? username;
  String? password;
  MqttWill? will;
  bool disconnected = false;
  void Function()? lost;

  @override
  Future<MqttConnectFailure?> connect({
    String? username,
    String? password,
    MqttWill? will,
  }) async {
    this.username = username;
    this.password = password;
    this.will = will;
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
  final List<(String, Uint8List)> retained = [];
  bool canPublish = true;

  @override
  bool publish(String topic, Uint8List payload, {bool retain = false}) {
    if (!canPublish) return false;
    (retain ? retained : published).add((topic, payload));
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
        const MqttNotice(MqttNoticeKind.regionNeededToShare),
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

    // Backlogged packets older than 72 hours are dropped, so these use the
    // real clock rather than the fixed test date.
    RadioRxPacket fresh(Uint8List raw) =>
        RadioRxPacket(raw: raw, snr: 5, rssi: -90, receivedAt: DateTime.now());

    test('queues packets while offline and backfills them in order', () async {
      final service = await sharing();
      // The connection drops; the session is still wanted.
      transports.single.lost!();
      expect(
        service.publishRadioPacket(fresh(channelPacket)),
        MqttPublishSkip.notConnected,
      );
      service.publishRadioPacket(fresh(directPacket));
      // Direct traffic isn't shared by default, so only one waits.
      expect(service.backlogLength, 1);
      // It reconnects on its own after a second, then drains the backlog.
      await Future<void>.delayed(const Duration(milliseconds: 3600));
      expect(service.status, MqttConnectionStatus.connected);
      expect(service.backlogLength, 0);
      final (topic, payload) = transports.last.published.single;
      expect(MqttMeshPacket.tryParse(topic, payload)!.raw, channelPacket);
      service.dispose();
    });

    test('a manual disconnect stops queuing', () async {
      final service = await sharing();
      service.disconnect();
      service.publishRadioPacket(heard(channelPacket));
      expect(service.backlogLength, 0);
      service.dispose();
    });

    test('the backlog survives a restart', () async {
      final store = _MemoryBacklog();
      final made = <FakeTransport>[];
      MqttBrokerService make() => MqttBrokerService(
        prefs: prefs,
        credentials: credentials,
        transportFactory: (settings, clientId) {
          final t = FakeTransport(null);
          made.add(t);
          return t;
        },
        backlogStore: store,
      );
      final first = make();
      await first.load();
      await first.saveConfiguration(regional, publishSettings: share);
      first.setObserverIdentity(publicKeyHex: 'ab12cd34', name: 'Base');
      await first.connect();
      made.last.lost!();
      first.publishRadioPacket(fresh(channelPacket));
      first.dispose();
      await Future<void>.delayed(Duration.zero);
      final second = make();
      await second.load();
      expect(second.backlogLength, 1);
      second.dispose();
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

  group('observer status', () {
    const regional = MqttBrokerSettings(
      host: 'broker.test',
      port: 8883,
      region: 'PHL',
    );
    const key = 'AB12CD34';
    const statusTopic = 'meshcore/PHL/AB12CD34/status';

    Map<String, dynamic> decode(Object payload) =>
        jsonDecode(
              payload is String ? payload : utf8.decode(payload as Uint8List),
            )
            as Map<String, dynamic>;

    Future<MqttBrokerService> connected({bool share = true}) async {
      final service = MqttBrokerService(
        prefs: prefs,
        credentials: credentials,
        transportFactory: (settings, clientId) {
          final transport = FakeTransport(null);
          transports.add(transport);
          return transport;
        },
        clientVersion: 'notoryx-core/test',
        clock: () => DateTime.utc(2026, 10, 21, 18),
      );
      await service.load();
      await service.saveConfiguration(
        regional,
        publishSettings: MqttPublishSettings(enabled: share),
      );
      service.setObserverIdentity(
        publicKeyHex: 'ab12cd34',
        name: 'Base',
        details: const MqttObserverDetails(
          radio: '910.525,62.5,7,5',
          model: 'Heltec V3',
          firmwareVersion: 'v1.9.0',
        ),
      );
      await service.connect();
      return service;
    }

    test(
      'publishes retained online and sets a matching offline will',
      () async {
        final service = await connected();
        final transport = transports.single;
        expect(transport.will?.topic, statusTopic);
        expect(transport.will?.retain, isTrue);
        final will = decode(transport.will!.payload);
        expect(will['status'], 'offline');
        expect(will['origin'], 'Base');
        expect(will['origin_id'], key);

        expect(transport.retained, hasLength(1));
        expect(transport.retained.single.$1, statusTopic);
        expect(decode(transport.retained.single.$2), {
          'status': 'online',
          'timestamp': '2026-10-21T18:00:00.000Z',
          'origin': 'Base',
          'origin_id': key,
          'radio': '910.525,62.5,7,5',
          'model': 'Heltec V3',
          'firmware_version': 'v1.9.0',
          'client_version': 'notoryx-core/test',
        });
        expect(service.onlineStatusTopic, statusTopic);
        // Packets are never retained.
        expect(transport.published, isEmpty);
      },
    );

    test('sends no status or will without sharing', () async {
      final service = await connected(share: false);
      expect(transports.single.will, isNull);
      expect(transports.single.retained, isEmpty);
      expect(service.onlineStatusTopic, isNull);
    });

    test('replaces online with offline on a clean disconnect', () async {
      final service = await connected();
      final transport = transports.single;
      service.disconnect();
      expect(transport.retained, hasLength(2));
      expect(transport.retained.last.$1, statusTopic);
      expect(decode(transport.retained.last.$2)['status'], 'offline');
      expect(transport.disconnected, isTrue);
      expect(service.onlineStatusTopic, isNull);
    });

    test(
      'reports the radio leaving and returning without reconnecting',
      () async {
        final service = await connected();
        final transport = transports.single;
        service.setObserverIdentity();
        expect(decode(transport.retained.last.$2)['status'], 'offline');
        expect(decode(transport.retained.last.$2)['origin_id'], key);
        expect(service.onlineStatusTopic, isNull);

        service.setObserverIdentity(publicKeyHex: key, name: 'Base');
        expect(transports, hasLength(1));
        expect(decode(transport.retained.last.$2)['status'], 'online');
        expect(service.onlineStatusTopic, statusTopic);
      },
    );

    test('reconnects with a new will for a different radio', () async {
      final service = await connected();
      service.setObserverIdentity(publicKeyHex: 'ffee0011', name: 'Other');
      await pumpEventQueue();
      expect(decode(transports.first.retained.last.$2)['status'], 'offline');
      expect(transports, hasLength(2));
      expect(transports.last.will?.topic, 'meshcore/PHL/FFEE0011/status');
      expect(service.onlineStatusTopic, 'meshcore/PHL/FFEE0011/status');
    });
  });

  group('radio token sign-in', () {
    const tokenSettings = MqttBrokerSettings(
      host: 'broker.test',
      port: 8883,
      authMode: MqttAuthMode.radioToken,
    );
    const key =
        '4852B69364572B52EFA1B6BB3E6D0ABED4F389A1CBFBB60A9BBA2CCE649CAF0E';
    final start = DateTime.utc(2026, 10, 21, 18);
    late List<Uint8List> signed;
    late int signatureByte;

    Future<Uint8List> signer(Uint8List data) async {
      signed.add(data);
      return Uint8List(64)..fillRange(0, 64, signatureByte++);
    }

    setUp(() {
      signed = [];
      signatureByte = 0x11;
    });

    MqttBrokerService tokenService(DateTime Function() clock) =>
        MqttBrokerService(
          prefs: prefs,
          credentials: credentials,
          transportFactory: (settings, clientId) {
            final transport = FakeTransport(
              results.isEmpty ? null : results.removeAt(0),
            );
            transports.add(transport);
            return transport;
          },
          clientVersion: 'notoryx-core/test',
          clock: clock,
        );

    Map<String, dynamic> claimsOf(String token) =>
        jsonDecode(
              utf8.decode(
                base64Url.decode(base64Url.normalize(token.split('.')[1])),
              ),
            )
            as Map<String, dynamic>;

    test(
      'waits for the radio, then signs in with a radio-signed token',
      () async {
        final service = tokenService(() => start);
        await service.load();
        expect(
          await service.saveConfiguration(
            tokenSettings,
            username: 'ignored',
            password: 'ignored',
          ),
          isNull,
        );
        expect(await credentials.read(), isNull);

        await service.connect();
        expect(transports, isEmpty);
        expect(service.waitingForRadio, isTrue);
        expect(service.status, MqttConnectionStatus.error);
        expect(service.errorMessage, contains('Connect your radio'));

        service.setObserverIdentity(publicKeyHex: key.toLowerCase());
        expect(transports, isEmpty);
        service.setRadioSigner(signer);
        await pumpEventQueue();

        expect(service.status, MqttConnectionStatus.connected);
        expect(service.waitingForRadio, isFalse);
        final transport = transports.single;
        expect(transport.username, 'v1_$key');
        expect(service.tokenUsername, 'v1_$key');
        final token = transport.password!;
        final parts = token.split('.');
        expect(parts, hasLength(3));
        expect(signed.single, ascii.encode('${parts[0]}.${parts[1]}'));
        expect(parts[2], '11' * 64);
        final claims = claimsOf(token);
        expect(claims['publicKey'], key);
        expect(claims['aud'], 'broker.test');
        expect(claims['client'], 'notoryx-core/test');
        expect(claims['iat'], start.millisecondsSinceEpoch ~/ 1000);
        expect(claims['exp'], claims['iat'] + 3600);
        expect(service.tokenExpiresAt, start.add(const Duration(hours: 1)));
        expect(service.tokenRefreshAt, start.add(const Duration(minutes: 55)));
      },
    );

    test('reports firmware that cannot sign and does not retry', () async {
      final service = tokenService(() => start);
      await service.load();
      await service.saveConfiguration(tokenSettings);
      service.setObserverIdentity(publicKeyHex: key);
      service.setRadioSigner(
        (_) async =>
            throw const RadioSigningException(RadioSigningFailure.unsupported),
      );
      await service.connect();
      expect(transports, isEmpty);
      expect(service.status, MqttConnectionStatus.error);
      expect(service.waitingForRadio, isFalse);
      expect(service.errorMessage, contains('does not support signing'));
    });

    test('renews the token five minutes before expiry and reconnects', () {
      fakeAsync((async) {
        final service = tokenService(() => start.add(async.elapsed));
        service.load();
        service.saveConfiguration(tokenSettings);
        async.flushMicrotasks();
        service.setObserverIdentity(publicKeyHex: key);
        service.setRadioSigner(signer);
        service.connect();
        async.flushMicrotasks();
        expect(transports, hasLength(1));

        async.elapse(const Duration(minutes: 54, seconds: 59));
        expect(transports, hasLength(1));
        expect(signed, hasLength(1));

        async.elapse(const Duration(seconds: 1));
        expect(signed, hasLength(2));
        expect(transports, hasLength(2));
        expect(transports.first.disconnected, isTrue);
        expect(service.status, MqttConnectionStatus.connected);
        expect(transports.last.password, isNot(transports.first.password));
        expect(transports.last.password, endsWith('12' * 64));
        expect(
          claimsOf(transports.last.password!)['iat'],
          start.add(const Duration(minutes: 55)).millisecondsSinceEpoch ~/ 1000,
        );
        expect(service.tokenRefreshAt, start.add(const Duration(minutes: 110)));

        async.elapse(const Duration(minutes: 55));
        expect(transports, hasLength(3));
        service.disconnect();
      });
    });

    test('keeps the session and retries renewal while the radio is away', () {
      fakeAsync((async) {
        final service = tokenService(() => start.add(async.elapsed));
        service.load();
        service.saveConfiguration(tokenSettings);
        async.flushMicrotasks();
        service.setObserverIdentity(publicKeyHex: key);
        service.setRadioSigner(signer);
        service.connect();
        async.flushMicrotasks();

        service.setRadioSigner(null);
        async.elapse(const Duration(minutes: 56));
        expect(transports, hasLength(1));
        expect(transports.single.disconnected, isFalse);
        expect(service.status, MqttConnectionStatus.connected);

        service.setRadioSigner(signer);
        async.elapse(const Duration(minutes: 1));
        expect(transports, hasLength(2));
        expect(signed, hasLength(2));
        service.disconnect();
      });
    });

    test('reuses a fresh token after a dropped connection', () {
      fakeAsync((async) {
        final service = tokenService(() => start.add(async.elapsed));
        service.load();
        service.saveConfiguration(tokenSettings);
        async.flushMicrotasks();
        service.setObserverIdentity(publicKeyHex: key);
        service.setRadioSigner(signer);
        service.connect();
        async.flushMicrotasks();

        async.elapse(const Duration(minutes: 10));
        transports.single.lost!();
        async.elapse(const Duration(seconds: 1));
        expect(transports, hasLength(2));
        expect(signed, hasLength(1));
        expect(transports.last.password, transports.first.password);
        service.disconnect();
      });
    });

    test('keeps the session when the same radio reconnects', () async {
      final service = tokenService(() => start);
      await service.load();
      await service.saveConfiguration(tokenSettings);
      service.setObserverIdentity(publicKeyHex: key);
      service.setRadioSigner(signer);
      await service.connect();
      expect(transports, hasLength(1));

      service.setRadioSigner(null);
      service.setObserverIdentity();
      service.setObserverIdentity(publicKeyHex: key);
      service.setRadioSigner(signer);
      await pumpEventQueue();
      expect(transports, hasLength(1));
      expect(signed, hasLength(1));

      service.setObserverIdentity(publicKeyHex: 'ffee0011');
      await pumpEventQueue();
      expect(transports, hasLength(2));
      expect(transports.last.username, 'v1_FFEE0011');
      expect(signed, hasLength(2));
    });

    test('signs a new token after the broker refuses one', () async {
      results = [MqttConnectFailure.notAuthorized];
      final service = tokenService(() => start);
      await service.load();
      await service.saveConfiguration(tokenSettings);
      service.setObserverIdentity(publicKeyHex: key);
      service.setRadioSigner(signer);
      await service.connect();
      expect(service.status, MqttConnectionStatus.error);
      expect(transports, hasLength(1));

      await service.connect();
      expect(signed, hasLength(2));
      expect(service.status, MqttConnectionStatus.connected);
    });
  });

  group('network changes', () {
    late StreamController<NetworkStatus> network;
    const wifi = NetworkStatus({'wifi'});
    const mobile = NetworkStatus({'mobile'});

    setUp(() => network = StreamController<NetworkStatus>.broadcast());
    tearDown(() => network.close());

    MqttBrokerService watching(NetworkStatus initial) => MqttBrokerService(
      prefs: prefs,
      credentials: credentials,
      transportFactory: (settings, clientId) {
        final transport = FakeTransport(
          results.isEmpty ? null : results.removeAt(0),
        );
        transports.add(transport);
        return transport;
      },
      networkMonitor: _FakeNetworkMonitor(initial, network.stream),
    );

    Future<void> change(NetworkStatus status) async {
      network.add(status);
      await Future<void>.delayed(Duration.zero);
      await Future<void>.delayed(Duration.zero);
    }

    test('Wi-Fi only treats mobile data as no network', () async {
      final service = watching(mobile);
      await service.load();
      await service.saveConfiguration(_settings);
      await service.setWifiOnly(true);
      await service.connect();
      expect(transports, isEmpty);
      expect(service.waitingForNetwork, isTrue);

      await change(wifi);
      expect(service.status, MqttConnectionStatus.connected);

      await change(mobile);
      expect(transports.single.disconnected, isTrue);

      await service.setWifiOnly(false);
      await Future<void>.delayed(Duration.zero);
      expect(transports, hasLength(2));
      service.dispose();
    });

    test('namespaced brokers keep separate settings', () async {
      final extra = MqttBrokerService(
        prefs: prefs,
        credentials: credentials,
        transportFactory: (settings, clientId) => FakeTransport(null),
        namespace: 'x1',
        uploadOnly: true,
      );
      await extra.load();
      await extra.saveConfiguration(_settings);
      final main = watching(wifi);
      await main.load();
      expect(main.status, MqttConnectionStatus.notConfigured);
      expect(
        prefs.getKeys().where((k) => k.startsWith('mqtt_x_x1__')),
        isNotEmpty,
      );
      extra.dispose();
      main.dispose();
    });

    test('waits for a network before connecting', () async {
      final service = watching(NetworkStatus.offline);
      await service.load();
      await service.saveConfiguration(_settings);
      await service.connect();
      expect(transports, isEmpty);
      expect(service.status, MqttConnectionStatus.reconnecting);
      expect(service.waitingForNetwork, isTrue);
      expect(service.errorMessage, contains('No network'));

      await change(wifi);
      expect(transports, hasLength(1));
      expect(service.status, MqttConnectionStatus.connected);
      expect(service.waitingForNetwork, isFalse);
    });

    test('drops the session offline and resumes when back', () async {
      final service = watching(wifi);
      await service.load();
      await service.saveConfiguration(_settings);
      await service.connect();
      expect(service.status, MqttConnectionStatus.connected);

      await change(NetworkStatus.offline);
      expect(transports.single.disconnected, isTrue);
      expect(service.waitingForNetwork, isTrue);

      await change(wifi);
      expect(transports, hasLength(2));
      expect(service.status, MqttConnectionStatus.connected);
      expect(service.reconnectAttempt, 0);
    });

    test('spends no retries while offline', () {
      fakeAsync((async) {
        results = [MqttConnectFailure.unreachable];
        final service = watching(wifi);
        service.load();
        async.flushMicrotasks();
        service.saveConfiguration(_settings);
        async.flushMicrotasks();
        service.connect();
        async.flushMicrotasks();
        expect(service.status, MqttConnectionStatus.reconnecting);
        expect(service.reconnectAttempt, 1);

        network.add(NetworkStatus.offline);
        async.flushMicrotasks();
        async.elapse(const Duration(minutes: 10));
        expect(transports, hasLength(1));
        expect(service.waitingForNetwork, isTrue);
        expect(service.reconnectAttempt, 0);

        network.add(wifi);
        async.flushMicrotasks();
        expect(transports, hasLength(2));
        expect(service.status, MqttConnectionStatus.connected);
      });
    });

    test('reconnects at once when the active network is lost', () async {
      final service = watching(wifi);
      await service.load();
      await service.saveConfiguration(_settings);
      await service.connect();

      await change(const NetworkStatus({'wifi', 'mobile'}));
      expect(transports, hasLength(1), reason: 'gaining a network is fine');

      await change(mobile);
      expect(transports, hasLength(2));
      expect(transports.first.disconnected, isTrue);
      expect(service.status, MqttConnectionStatus.connected);
    });

    test('stays down after a manual disconnect', () async {
      final service = watching(wifi);
      await service.load();
      await service.saveConfiguration(_settings);
      await service.connect();
      service.disconnect();
      await change(NetworkStatus.offline);
      await change(wifi);
      expect(transports, hasLength(1));
      expect(service.status, MqttConnectionStatus.disconnected);
    });

    test(
      'does not retry rejected credentials when the network returns',
      () async {
        results = [MqttConnectFailure.badCredentials];
        final service = watching(wifi);
        await service.load();
        await service.saveConfiguration(_settings);
        await service.connect();
        expect(service.status, MqttConnectionStatus.error);
        await change(NetworkStatus.offline);
        await change(wifi);
        expect(transports, hasLength(1));
        expect(service.status, MqttConnectionStatus.error);
      },
    );

    test('detects a lost interface', () {
      expect(mobile.lostInterfaceSince(wifi), isTrue);
      expect(
        const NetworkStatus({'wifi', 'mobile'}).lostInterfaceSince(wifi),
        isFalse,
      );
      expect(wifi.lostInterfaceSince(wifi), isFalse);
      expect(NetworkStatus.offline.available, isFalse);
    });
  });
}

class _FakeNetworkMonitor implements NetworkMonitor {
  _FakeNetworkMonitor(this._initial, this.changes);

  final NetworkStatus _initial;

  @override
  final Stream<NetworkStatus> changes;

  @override
  Future<NetworkStatus> current() async => _initial;
}

class _MemoryBacklog implements MqttBacklogStore {
  String? data;
  @override
  Future<String?> read() async => data;
  @override
  Future<void> write(String d) async => data = d;
}
