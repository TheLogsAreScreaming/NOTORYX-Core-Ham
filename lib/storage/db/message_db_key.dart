import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Where the message database's key lives. Separate so tests needn't touch
/// the platform keychain.
abstract interface class MessageDbKeyVault {
  Future<String?> read();
  Future<void> write(String key);
  Future<void> delete();
}

class SecureMessageDbKeyVault implements MessageDbKeyVault {
  static const _name = 'message_db_key';
  static const _storage = FlutterSecureStorage();

  @override
  Future<String?> read() => _storage.read(key: _name);

  @override
  Future<void> write(String key) => _storage.write(key: _name, value: key);

  @override
  Future<void> delete() => _storage.delete(key: _name);
}

/// A new random key: 32 bytes, in text safe to place in a PRAGMA.
String generateMessageDbKey() {
  final random = Random.secure();
  return base64Url
      .encode(List<int>.generate(32, (_) => random.nextInt(256)))
      .replaceAll('=', '');
}
