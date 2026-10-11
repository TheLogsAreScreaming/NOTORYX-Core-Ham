import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meshcore_open/services/encrypted_backup_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';

void main() {
  test('encrypted backups roundtrip and reject wrong passwords and tampering', () async {
    final service = EncryptedBackupService();
    const values = <String, Object>{'channels': 'secret-key', 'enabled': true, 'count': 3};
    final encrypted = await service.seal(values, 'a-long-secret-passphrase');
    expect(encrypted, isNot(contains('secret-key')));
    expect(await service.open(encrypted, 'a-long-secret-passphrase'), values);
    await expectLater(service.open(encrypted, 'different-passphrase'), throwsA(anything));
    final envelope = jsonDecode(encrypted) as Map<String, dynamic>;
    final bytes = base64Decode(envelope['ciphertext'] as String);
    bytes[0] ^= 1;
    envelope['ciphertext'] = base64Encode(bytes);
    await expectLater(service.open(jsonEncode(envelope), 'a-long-secret-passphrase'), throwsA(anything));
  });
  test('chat history is excluded by default snapshot choice', () async {
    SharedPreferences.setMockInitialValues({'messages_radio_contact': 'dm',
      'channel_messages_radio': 'chat', 'channels': 'keys'});
    PrefsManager.reset();
    await PrefsManager.initialize();
    final service = EncryptedBackupService();
    expect(service.snapshot(includeChats: false), {'channels': 'keys'});
    expect(service.snapshot(includeChats: true).length, 3);
    PrefsManager.reset();
  });
}
