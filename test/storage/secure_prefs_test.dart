import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/storage/db/message_db.dart';
import 'package:meshcore_open/storage/db/message_db_key.dart';
import 'package:meshcore_open/storage/db/message_db_native.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:meshcore_open/storage/secure_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Vault implements MessageDbKeyVault {
  String? key;
  @override
  Future<String?> read() async => key;
  @override
  Future<void> write(String k) async => key = k;
  @override
  Future<void> delete() async => key = null;
}

void main() {
  late Directory dir;
  late String path;
  late _Vault vault;
  final opened = <MessageDb>[];

  Future<MessageDb> open(bool encrypted) async {
    final db = (await openMessageDbFile(
      path,
      wantEncrypted: encrypted,
      vault: vault,
    ))!;
    opened.add(db);
    return db;
  }

  Future<void> closeAll() async {
    for (final db in opened) {
      db.close();
    }
    opened.clear();
  }

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('secure_prefs');
    path = '${dir.path}/m.db';
    vault = _Vault();
    PrefsManager.reset();
    SharedPreferences.setMockInitialValues({
      'contactsaabbccddee': '[{"n":"Sam"}]',
      'channelsaabbccddee': '[{"psk":"secretkey"}]',
      'waypoints_v1': '{"w":1}',
      'draft_aa_c_bb': 'hello',
      'theme': 'dark',
    });
    await PrefsManager.initialize();
    SecurePrefs.resetForTest();
  });

  tearDown(() async {
    await closeAll();
    SecurePrefs.resetForTest();
    await dir.delete(recursive: true);
  });

  test('only the sensitive keys are matched', () {
    expect(SecurePrefs.isSensitive('contactsaabbccddee'), isTrue);
    expect(SecurePrefs.isSensitive('contacts'), isTrue);
    expect(SecurePrefs.isSensitive('channelsaabbccddee'), isTrue);
    expect(SecurePrefs.isSensitive('draft_x'), isTrue);
    expect(SecurePrefs.isSensitive('channel_messages_ab'), isFalse);
    expect(SecurePrefs.isSensitive('contact_group_x'), isFalse);
    expect(SecurePrefs.isSensitive('theme'), isFalse);
  });

  test('without encryption everything stays in preferences', () async {
    await SecurePrefs.attach(await open(false));
    expect(SecurePrefs.isActive, isFalse);
    expect(SecurePrefs.getString('waypoints_v1'), '{"w":1}');
    expect(PrefsManager.instance.getString('waypoints_v1'), '{"w":1}');
  });

  test('with no database it falls back to preferences', () async {
    await SecurePrefs.attach(null);
    await SecurePrefs.setString('draft_z', 'kept');
    expect(PrefsManager.instance.getString('draft_z'), 'kept');
  });

  test('encrypting moves values in and removes the plaintext', () async {
    await SecurePrefs.attach(await open(true));
    expect(SecurePrefs.isActive, isTrue);
    expect(SecurePrefs.getString('channelsaabbccddee'), contains('secretkey'));
    final prefs = PrefsManager.instance;
    expect(prefs.getString('channelsaabbccddee'), isNull);
    expect(prefs.getString('contactsaabbccddee'), isNull);
    expect(prefs.getString('draft_aa_c_bb'), isNull);
    expect(prefs.getString('theme'), 'dark');
  });

  test('values are not readable in the file on disk', () async {
    await SecurePrefs.attach(await open(true));
    await SecurePrefs.setString('draft_new', 'plainneedle');
    await closeAll();
    final bytes = await File(path).readAsBytes();
    final text = String.fromCharCodes(bytes);
    expect(text, isNot(contains('secretkey')));
    expect(text, isNot(contains('plainneedle')));
  });

  test('new values survive closing and reopening', () async {
    await SecurePrefs.attach(await open(true));
    await SecurePrefs.setString('waypoints_v1', 'changed');
    await SecurePrefs.remove('draft_aa_c_bb');
    await closeAll();
    SecurePrefs.resetForTest();
    await SecurePrefs.attach(await open(true));
    expect(SecurePrefs.getString('waypoints_v1'), 'changed');
    expect(SecurePrefs.getString('draft_aa_c_bb'), isNull);
    expect(PrefsManager.instance.getString('waypoints_v1'), isNull);
  });

  test('turning encryption off returns everything', () async {
    await SecurePrefs.attach(await open(true));
    await SecurePrefs.setString('draft_new', 'back');
    await closeAll();
    SecurePrefs.resetForTest();
    final plain = await open(false);
    await SecurePrefs.attach(plain);
    expect(SecurePrefs.isActive, isFalse);
    final prefs = PrefsManager.instance;
    expect(prefs.getString('channelsaabbccddee'), contains('secretkey'));
    expect(prefs.getString('draft_new'), 'back');
    expect(plain.loadSecrets(), isEmpty);
  });

  test('backups still include the moved values', () async {
    await SecurePrefs.attach(await open(true));
    expect(SecurePrefs.snapshot(), containsPair('waypoints_v1', '{"w":1}'));
  });
}
