import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'mqtt_credentials_store.dart';

/// Picks the credential store for this platform.
///
/// Web has no OS-backed secret store (flutter_secure_storage falls back to
/// localStorage there), so web keeps credentials in memory for the session.
///
/// A non-empty [namespace] keeps another broker's credentials apart from
/// the main broker's.
MqttCredentialsStore createMqttCredentialsStore({String namespace = ''}) {
  if (kIsWeb) return MemoryMqttCredentialsStore();
  return SecureMqttCredentialsStore(namespace: namespace);
}

/// Keychain / Keystore / libsecret / Credential Manager backed credentials.
class SecureMqttCredentialsStore implements MqttCredentialsStore {
  SecureMqttCredentialsStore({
    FlutterSecureStorage? storage,
    String namespace = '',
  }) : _usernameKey = namespace.isEmpty
           ? 'mqtt_broker_username'
           : 'mqtt_x_${namespace}__username',
       _passwordKey = namespace.isEmpty
           ? 'mqtt_broker_password'
           : 'mqtt_x_${namespace}__password',
       _storage =
           storage ??
           const FlutterSecureStorage(
             // The data protection keychain needs keychain-access-groups,
             // which ad-hoc signed macOS builds can't carry.
             mOptions: MacOsOptions(usesDataProtectionKeychain: false),
           );

  final String _usernameKey;
  final String _passwordKey;

  final FlutterSecureStorage _storage;

  @override
  Future<void> save({
    required String username,
    required String password,
  }) async {
    await _storage.write(key: _usernameKey, value: username);
    await _storage.write(key: _passwordKey, value: password);
  }

  @override
  Future<({String username, String password})?> read() async {
    try {
      final username = await _storage.read(key: _usernameKey);
      final password = await _storage.read(key: _passwordKey);
      if (username == null || password == null) return null;
      return (username: username, password: password);
    } on Object catch (e) {
      // Restored Android backups can't be decrypted on a new device; treat
      // them as missing rather than failing every connect.
      debugPrint('MQTT credentials unreadable, clearing: ${e.runtimeType}');
      await clear();
      return null;
    }
  }

  @override
  Future<void> clear() async {
    try {
      await _storage.delete(key: _usernameKey);
      await _storage.delete(key: _passwordKey);
    } on Object catch (e) {
      debugPrint('MQTT credentials clear failed: ${e.runtimeType}');
    }
  }
}

/// Session-only credentials, for web and tests.
class MemoryMqttCredentialsStore implements MqttCredentialsStore {
  ({String username, String password})? _credentials;

  @override
  Future<void> save({
    required String username,
    required String password,
  }) async {
    _credentials = (username: username, password: password);
  }

  @override
  Future<({String username, String password})?> read() async => _credentials;

  @override
  Future<void> clear() async => _credentials = null;
}
