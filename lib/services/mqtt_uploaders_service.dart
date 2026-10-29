import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cryptography/cryptography.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/mqtt_observer_status.dart';
import '../models/radio_rx_packet.dart';
import '../utils/keys.dart';
import '../utils/platform_info.dart';
import 'mqtt_broker_service.dart';
import 'mqtt_credentials_store.dart';
import 'mqtt_transport.dart';
import 'network_monitor.dart';

/// Keeps a broker's offline backlog in the app's support folder.
class FileMqttBacklogStore implements MqttBacklogStore {
  FileMqttBacklogStore(this.name);

  final String name;

  Future<File> _file() async {
    final dir = await getApplicationSupportDirectory();
    return File('${dir.path}/mqtt_backlog_$name.json');
  }

  @override
  Future<String?> read() async {
    if (PlatformInfo.isWeb) return null;
    final f = await _file();
    return await f.exists() ? f.readAsString() : null;
  }

  @override
  Future<void> write(String data) async {
    if (PlatformInfo.isWeb) return;
    final f = await _file();
    final tmp = File('${f.path}.tmp');
    await tmp.writeAsString(data, flush: true);
    await tmp.rename(f.path);
  }

  Future<void> delete() async {
    if (PlatformInfo.isWeb) return;
    final f = await _file();
    if (await f.exists()) await f.delete();
  }
}

/// Holds the private seed for an upload broker's own signing key.
abstract class UploaderKeyStore {
  Future<String?> read(String id);
  Future<void> write(String id, String seed);
  Future<void> delete(String id);
}

class SecureUploaderKeyStore implements UploaderKeyStore {
  final _storage = const FlutterSecureStorage(
    mOptions: MacOsOptions(usesDataProtectionKeychain: false),
  );
  final Map<String, String> _memory = {};

  String _k(String id) => 'mqtt_x_${id}__seed';

  @override
  Future<String?> read(String id) async =>
      kIsWeb ? _memory[id] : _storage.read(key: _k(id));

  @override
  Future<void> write(String id, String seed) async => kIsWeb
      ? _memory[id] = seed
      : await _storage.write(key: _k(id), value: seed);

  @override
  Future<void> delete(String id) async =>
      kIsWeb ? _memory.remove(id) : await _storage.delete(key: _k(id));
}

/// An extra broker the radio's traffic is also shared with.
class MqttUploader {
  MqttUploader({
    required this.id,
    required this.name,
    required this.separateKey,
    required this.service,
  });

  final String id;
  final String name;

  /// Signs in with a key made on this phone instead of the radio's, so this
  /// broker can't link the uploads to your radio identity.
  final bool separateKey;
  final MqttBrokerService service;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'separateKey': separateKey,
  };
}

/// The radio identity the main broker uses, so extra brokers can match it.
class RadioIdentity {
  const RadioIdentity({
    this.publicKeyHex,
    this.name,
    this.details = const MqttObserverDetails(),
    this.signer,
  });

  final String? publicKeyHex;
  final String? name;
  final MqttObserverDetails details;
  final Future<Uint8List> Function(Uint8List data)? signer;
}

/// Extra MQTT brokers, beside the main one, that receive the same packets
/// the radio hears. Each has its own settings, credentials, Wi-Fi-only
/// choice and 72-hour offline backlog, and they never subscribe.
class MqttUploadersService extends ChangeNotifier {
  MqttUploadersService({
    required SharedPreferences prefs,
    required MqttCredentialsStore Function(String namespace) credentials,
    required MqttTransportFactory transportFactory,
    NetworkMonitor Function()? networkMonitor,
    MqttBacklogStore Function(String id)? backlogStore,
    UploaderKeyStore? keyStore,
  }) : _prefs = prefs,
       _credentials = credentials,
       _transportFactory = transportFactory,
       _networkMonitor = networkMonitor,
       _backlogStore = backlogStore ?? FileMqttBacklogStore.new,
       _keys = keyStore ?? SecureUploaderKeyStore();

  static const _listKey = 'mqtt_extra_brokers_v1';
  static const maxUploaders = 4;

  final SharedPreferences _prefs;
  final MqttCredentialsStore Function(String namespace) _credentials;
  final MqttTransportFactory _transportFactory;
  final NetworkMonitor Function()? _networkMonitor;
  final MqttBacklogStore Function(String id) _backlogStore;
  final UploaderKeyStore _keys;

  final List<MqttUploader> _uploaders = [];
  final Map<String, ({String publicKeyHex, SimpleKeyPair keys})> _ownKeys = {};
  RadioIdentity _radio = const RadioIdentity();
  String clientVersion = 'notoryx-core';

  List<MqttUploader> get uploaders => List.unmodifiable(_uploaders);

  Future<void> load() async {
    final saved = _prefs.getString(_listKey);
    if (saved == null) return;
    try {
      for (final row in jsonDecode(saved) as List) {
        final m = row as Map<String, dynamic>;
        await _open(
          m['id'] as String,
          m['name'] as String,
          m['separateKey'] as bool? ?? false,
        );
      }
    } catch (_) {
      // A damaged list loses the extra brokers, never the main one.
    }
    notifyListeners();
  }

  Future<MqttUploader> _open(String id, String name, bool separateKey) async {
    final service = MqttBrokerService(
      prefs: _prefs,
      credentials: _credentials(id),
      transportFactory: _transportFactory,
      networkMonitor: _networkMonitor?.call(),
      namespace: id,
      uploadOnly: true,
      backlogStore: _backlogStore(id),
    )..clientVersion = clientVersion;
    final uploader = MqttUploader(
      id: id,
      name: name,
      separateKey: separateKey,
      service: service,
    );
    _uploaders.add(uploader);
    await service.load();
    if (separateKey) await _ownKey(id);
    _applyIdentity(uploader);
    return uploader;
  }

  /// Adds a broker; its settings are filled in afterwards like the main
  /// broker's.
  Future<MqttUploader> add(String name, {bool separateKey = false}) async {
    final uploader = await _open(
      const Uuid().v4().substring(0, 8),
      name.trim().isEmpty ? 'Broker ${_uploaders.length + 2}' : name.trim(),
      separateKey,
    );
    await _saveList();
    notifyListeners();
    return uploader;
  }

  /// Disconnects and forgets a broker, its settings, password, key and
  /// backlog.
  Future<void> remove(String id) async {
    final i = _uploaders.indexWhere((u) => u.id == id);
    if (i < 0) return;
    final uploader = _uploaders.removeAt(i);
    uploader.service.disconnect();
    uploader.service.dispose();
    for (final key in _prefs.getKeys().toList()) {
      if (key.startsWith('mqtt_x_${id}__')) await _prefs.remove(key);
    }
    await _credentials(id).clear();
    await _keys.delete(id);
    _ownKeys.remove(id);
    final store = _backlogStore(id);
    if (store is FileMqttBacklogStore) await store.delete();
    await _saveList();
    notifyListeners();
  }

  Future<void> _saveList() => _prefs.setString(
    _listKey,
    jsonEncode(_uploaders.map((u) => u.toJson()).toList()),
  );

  /// Offers a packet the radio heard to every extra broker.
  void publishRadioPacket(RadioRxPacket packet) {
    for (final u in _uploaders) {
      u.service.publishRadioPacket(packet);
    }
  }

  /// Follows the main broker's radio identity and signer.
  void setRadioIdentity(RadioIdentity identity) {
    _radio = identity;
    for (final u in _uploaders) {
      _applyIdentity(u);
    }
  }

  void _applyIdentity(MqttUploader u) {
    final own = _ownKeys[u.id];
    if (u.separateKey && own != null) {
      u.service.setObserverIdentity(
        publicKeyHex: own.publicKeyHex,
        name: _radio.name,
        details: _radio.details,
      );
      u.service.setRadioSigner(
        (data) async => Uint8List.fromList(
          (await Ed25519().sign(data, keyPair: own.keys)).bytes,
        ),
      );
    } else {
      u.service.setObserverIdentity(
        publicKeyHex: _radio.publicKeyHex,
        name: _radio.name,
        details: _radio.details,
      );
      u.service.setRadioSigner(_radio.signer);
    }
  }

  Future<void> _ownKey(String id) async {
    var seed = await _keys.read(id);
    if (seed == null) {
      seed = base64Encode(randomBytes(32));
      await _keys.write(id, seed);
    }
    final keys = await Ed25519().newKeyPairFromSeed(base64Decode(seed));
    final pub = await keys.extractPublicKey();
    _ownKeys[id] = (
      publicKeyHex: pub.bytes
          .map((b) => b.toRadixString(16).padLeft(2, '0'))
          .join()
          .toUpperCase(),
      keys: keys,
    );
  }

  /// The public key an uploader signs in with, when it has its own.
  String? ownPublicKey(String id) => _ownKeys[id]?.publicKeyHex;

  @override
  void dispose() {
    for (final u in _uploaders) {
      u.service.dispose();
    }
    super.dispose();
  }
}
