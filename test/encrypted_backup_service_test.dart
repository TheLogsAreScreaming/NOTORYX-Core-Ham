import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meshcore_open/storage/secure_prefs.dart';
import 'package:meshcore_open/services/encrypted_backup_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';

void main() {
  test(
    'encrypted backups roundtrip and reject wrong passwords and tampering',
    () async {
      final service = EncryptedBackupService();
      const values = <String, Object>{
        'channels': 'secret-key',
        'enabled': true,
        'count': 3,
      };
      final encrypted = await service.seal(values, 'a-long-secret-passphrase');
      expect(encrypted, isNot(contains('secret-key')));
      expect(await service.open(encrypted, 'a-long-secret-passphrase'), values);
      await expectLater(
        service.open(encrypted, 'different-passphrase'),
        throwsA(anything),
      );
      final envelope = jsonDecode(encrypted) as Map<String, dynamic>;
      final bytes = base64Decode(envelope['ciphertext'] as String);
      bytes[0] ^= 1;
      envelope['ciphertext'] = base64Encode(bytes);
      await expectLater(
        service.open(jsonEncode(envelope), 'a-long-secret-passphrase'),
        throwsA(anything),
      );
    },
  );
  test('chat history is excluded by default snapshot choice', () async {
    SharedPreferences.setMockInitialValues({
      'messages_radio_contact': 'dm',
      'channel_messages_radio': 'chat',
      'channels': 'keys',
    });
    PrefsManager.reset();
    await PrefsManager.initialize();
    final service = EncryptedBackupService();
    expect(service.snapshot(includeChats: false), {'channels': 'keys'});
    expect(service.snapshot(includeChats: true).length, 3);
    PrefsManager.reset();
  });

  group('restore', () {
    setUp(() async {
      PrefsManager.reset();
      SecurePrefs.resetForTest();
      SharedPreferences.setMockInitialValues({
        'theme': 'light',
        'untouched': 'stays',
        'message_db_encrypt': false,
        'app_lock_enabled': false,
      });
      await PrefsManager.initialize();
    });

    tearDown(PrefsManager.reset);

    test('a sealed backup restores every value type', () async {
      final service = EncryptedBackupService();
      const backup = <String, Object>{
        'theme': 'dark',
        'contactsaabbccddee': '[{"n":"Sam"}]',
        'flag': true,
        'count': 3,
        'ratio': 1.5,
        'names': <String>['a', 'b'],
      };
      final sealed = await service.seal(backup, 'a-long-secret-passphrase');
      final opened = await service.open(sealed, 'a-long-secret-passphrase');
      expect(await service.restore(opened), 6);
      final prefs = PrefsManager.instance;
      expect(prefs.getString('theme'), 'dark');
      expect(prefs.getString('contactsaabbccddee'), contains('Sam'));
      expect(prefs.getBool('flag'), isTrue);
      expect(prefs.getInt('count'), 3);
      expect(prefs.getDouble('ratio'), 1.5);
      expect(prefs.getStringList('names'), ['a', 'b']);
      expect(prefs.getString('untouched'), 'stays');
    });

    test('security switches and old chat keys are not restored', () async {
      final restored = await EncryptedBackupService().restore(const {
        'message_db_encrypt': true,
        'app_lock_enabled': true,
        'messages_radio_contact': 'dm',
        'channel_messages_radio': 'chat',
        'theme': 'dark',
      });
      expect(restored, 1);
      final prefs = PrefsManager.instance;
      expect(prefs.getBool('message_db_encrypt'), isFalse);
      expect(prefs.getBool('app_lock_enabled'), isFalse);
      expect(prefs.getString('messages_radio_contact'), isNull);
    });

    test('invalid backups change nothing', () async {
      await expectLater(
        EncryptedBackupService().restore({'': 'bad'}),
        throwsFormatException,
      );
      expect(PrefsManager.instance.getString('theme'), 'light');
    });
  });
}
