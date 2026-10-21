import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/mqtt_broker_settings.dart';
import 'package:meshcore_open/models/mqtt_connection_status.dart';
import 'package:meshcore_open/services/mqtt_broker_service.dart';
import 'package:meshcore_open/services/mqtt_transport.dart';
import 'package:meshcore_open/services/secure_mqtt_credentials_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}
