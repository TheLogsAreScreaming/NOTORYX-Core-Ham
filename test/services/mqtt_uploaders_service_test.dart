import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/mqtt_broker_settings.dart';
import 'package:meshcore_open/models/mqtt_publish_policy.dart';
import 'package:meshcore_open/services/mqtt_broker_service.dart';
import 'package:meshcore_open/services/mqtt_transport.dart';
import 'package:meshcore_open/services/mqtt_uploaders_service.dart';
import 'package:meshcore_open/services/secure_mqtt_credentials_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Transport implements MqttTransport {
  @override
  Future<MqttConnectFailure?> connect({
    String? username,
    String? password,
    MqttWill? will,
  }) async => null;
  @override
  void disconnect() {}
  @override
  set onConnectionLost(void Function()? callback) {}
  @override
  void subscribe(String topic) => subscribed.add(topic);
  final subscribed = <String>[];
  @override
  bool publish(String topic, Uint8List payload, {bool retain = false}) => true;
  @override
  set onMessage(MqttMessageHandler? handler) {}
  @override
  set onSubscribeFailed(void Function(String topic)? callback) {}
}

class _Keys implements UploaderKeyStore {
  final data = <String, String>{};
  @override
  Future<String?> read(String id) async => data[id];
  @override
  Future<void> write(String id, String seed) async => data[id] = seed;
  @override
  Future<void> delete(String id) async => data.remove(id);
}

class _Backlog implements MqttBacklogStore {
  @override
  Future<String?> read() async => null;
  @override
  Future<void> write(String data) async {}
}

void main() {
  late SharedPreferences prefs;
  late _Keys keys;
  late List<_Transport> transports;
  late MqttUploadersService uploaders;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    keys = _Keys();
    transports = [];
    uploaders = MqttUploadersService(
      prefs: prefs,
      credentials: (_) => MemoryMqttCredentialsStore(),
      transportFactory: (settings, clientId) {
        final t = _Transport();
        transports.add(t);
        return t;
      },
      backlogStore: (_) => _Backlog(),
      keyStore: keys,
    );
  });

  tearDown(() => uploaders.dispose());

  const regional = MqttBrokerSettings(
    host: 'broker.test',
    port: 8883,
    region: 'PHL',
  );

  test('a separate key signs in under its own identity', () async {
    uploaders.setRadioIdentity(
      const RadioIdentity(publicKeyHex: 'AB12CD34', name: 'Base'),
    );
    final own = await uploaders.add('Second', separateKey: true);
    final viaRadio = await uploaders.add('Third');
    await own.service.saveConfiguration(
      regional,
      publishSettings: const MqttPublishSettings(enabled: true),
    );
    await viaRadio.service.saveConfiguration(
      regional,
      publishSettings: const MqttPublishSettings(enabled: true),
    );
    final key = uploaders.ownPublicKey(own.id)!;
    expect(key, hasLength(64));
    expect(own.service.publishTopic, contains(key));
    expect(viaRadio.service.publishTopic, contains('AB12CD34'));
    expect(own.service.radioCanSign, isTrue);

    await own.service.connect();
    expect(transports.last.subscribed, isEmpty, reason: 'upload only');
  });

  test('the key survives a restart and removal forgets everything', () async {
    final first = await uploaders.add('Second', separateKey: true);
    final key = uploaders.ownPublicKey(first.id);
    await first.service.saveConfiguration(regional);

    final reloaded = MqttUploadersService(
      prefs: prefs,
      credentials: (_) => MemoryMqttCredentialsStore(),
      transportFactory: (settings, clientId) => _Transport(),
      backlogStore: (_) => _Backlog(),
      keyStore: keys,
    );
    await reloaded.load();
    expect(reloaded.uploaders.single.name, 'Second');
    expect(reloaded.ownPublicKey(first.id), key);
    expect(reloaded.uploaders.single.service.settings, isNotNull);

    await reloaded.remove(first.id);
    expect(reloaded.uploaders, isEmpty);
    expect(keys.data, isEmpty);
    expect(
      prefs.getKeys().where((k) => k.startsWith('mqtt_x_${first.id}__')),
      isEmpty,
    );
    reloaded.dispose();
  });
}
