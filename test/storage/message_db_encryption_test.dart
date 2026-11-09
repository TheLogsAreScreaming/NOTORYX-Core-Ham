import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/storage/db/message_db.dart';
import 'package:meshcore_open/storage/db/message_db_key.dart';
import 'package:meshcore_open/storage/db/message_db_native.dart';

class _Vault implements MessageDbKeyVault {
  String? key;
  bool broken = false;

  @override
  Future<String?> read() async => key;

  @override
  Future<void> write(String k) async {
    if (broken) throw StateError('no keychain');
    key = k;
  }

  @override
  Future<void> delete() async => key = null;
}

void main() {
  late Directory dir;
  late String path;
  late _Vault vault;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('msgdb');
    path = '${dir.path}/messages.db';
    vault = _Vault();
  });
  tearDown(() => dir.deleteSync(recursive: true));

  String header() =>
      String.fromCharCodes(File(path).readAsBytesSync().take(15));

  Future<MessageDb> open(bool want) async =>
      (await openMessageDbFile(path, wantEncrypted: want, vault: vault))!;

  void write(MessageDb db) =>
      db.replace(MessageTable.values.first, 's', 'c', ['secret-text-marker']);

  List<String> read(MessageDb db) =>
      db.load(MessageTable.values.first, 's', 'c');

  test('an existing plain database is encrypted and keeps its rows', () async {
    var db = await open(false);
    write(db);
    db.close();
    expect(header(), 'SQLite format 3');

    db = await open(true);
    expect(db.isEncrypted, isTrue);
    expect(MessageDb.encryptionState, MessageDbEncryption.on);
    expect(read(db), ['secret-text-marker']);
    db.close();

    expect(header(), isNot('SQLite format 3'));
    final bytes = String.fromCharCodes(File(path).readAsBytesSync());
    expect(bytes.contains('secret-text-marker'), isFalse);
    expect(File('$path-wal').existsSync(), isFalse);
  });

  test('a new database starts encrypted', () async {
    var db = await open(true);
    write(db);
    db.close();
    expect(header(), isNot('SQLite format 3'));
    db = await open(true);
    expect(read(db), ['secret-text-marker']);
    db.close();
  });

  test('turning encryption off restores a plain file', () async {
    var db = await open(true);
    write(db);
    db.close();
    db = await open(false);
    expect(db.isEncrypted, isFalse);
    expect(read(db), ['secret-text-marker']);
    db.close();
    expect(header(), 'SQLite format 3');
    expect(vault.key, isNull);
  });

  test('a missing key returns null and leaves the file alone', () async {
    final db = await open(true);
    write(db);
    db.close();
    final before = File(path).readAsBytesSync();
    final kept = vault.key;
    vault.key = null;
    expect(
      await openMessageDbFile(path, wantEncrypted: true, vault: vault),
      isNull,
    );
    expect(MessageDb.encryptionState, MessageDbEncryption.failed);
    expect(File(path).readAsBytesSync(), before);
    vault.key = kept;
    final again = await open(true);
    expect(read(again), ['secret-text-marker']);
    again.close();
  });

  test('a keychain failure keeps the plain database usable', () async {
    var db = await open(false);
    write(db);
    db.close();
    vault.broken = true;
    db = await open(true);
    expect(db.isEncrypted, isFalse);
    expect(MessageDb.encryptionState, MessageDbEncryption.failed);
    expect(read(db), ['secret-text-marker']);
    db.close();
  });
}
