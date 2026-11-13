import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/services/encrypted_backup_service.dart';
import 'package:meshcore_open/storage/db/history_backup.dart';
import 'package:meshcore_open/storage/db/message_db.dart';

String row(int t, {String? id, String text = 'hi', int status = 0}) =>
    jsonEncode({
      'timestamp': t,
      'text': text,
      'isOutgoing': false,
      'status': status,
      'messageId': ?id,
    });

void main() {
  late MessageDb db;
  setUp(() => db = MessageDb.useInMemoryForTest()!);
  tearDown(() {
    db.close();
    MessageDb.resetForTest();
  });

  group('merge', () {
    test('adds missing messages in time order', () {
      final merged = HistoryBackup.merge(
        [row(10, id: 'a'), row(30, id: 'c')],
        [row(20, id: 'b'), row(40, id: 'd')],
      );
      expect(merged.map((r) => (jsonDecode(r) as Map)['messageId']), [
        'a',
        'b',
        'c',
        'd',
      ]);
    });

    test('keeps the device copy when the same message id is in both', () {
      final device = row(10, id: 'a', status: 2);
      final merged = HistoryBackup.merge([device], [row(10, id: 'a')]);
      expect(merged, [device]);
    });

    test('matches messages without an id by time, direction and text', () {
      final merged = HistoryBackup.merge(
        [row(10, text: 'same')],
        [row(10, text: 'same'), row(10, text: 'other')],
      );
      expect(merged.length, 2);
    });

    test('keeps the original order for equal times', () {
      final merged = HistoryBackup.merge(
        [row(10, id: 'x')],
        [row(10, id: 'y')],
      );
      expect(merged.map((r) => (jsonDecode(r) as Map)['messageId']), [
        'x',
        'y',
      ]);
    });
  });

  test('history round trips into another device without duplicates', () {
    db.replace(MessageTable.direct, 'radio1', 'sam', [
      row(10, id: '1'),
      row(20, id: '2'),
    ]);
    db.replace(MessageTable.channel, 'radio1', '0', [row(15, id: 'p')]);
    final encoded = HistoryBackup.encode(db);
    expect(HistoryBackup.count(encoded), 3);
    db.close();

    db = MessageDb.useInMemoryForTest()!;
    db.replace(MessageTable.direct, 'radio1', 'sam', [row(30, id: '3')]);
    expect(HistoryBackup.restore(db, encoded), 3);
    expect(db.load(MessageTable.direct, 'radio1', 'sam').length, 3);
    expect(db.load(MessageTable.channel, 'radio1', '0'), [row(15, id: 'p')]);
    expect(HistoryBackup.restore(db, encoded), 0);
    expect(db.load(MessageTable.direct, 'radio1', 'sam').length, 3);
  });

  test('a malformed history changes nothing', () {
    db.replace(MessageTable.direct, 'radio1', 'sam', [row(10, id: '1')]);
    final bad = jsonEncode({
      'direct': {
        'radio1': {
          'sam': [row(5, id: '0')],
          'alex': [1, 2],
        },
      },
    });
    expect(() => HistoryBackup.restore(db, bad), throwsFormatException);
    expect(HistoryBackup.count(bad), 0);
    expect(db.load(MessageTable.direct, 'radio1', 'sam'), [row(10, id: '1')]);
    expect(db.load(MessageTable.direct, 'radio1', 'alex'), isEmpty);
  });

  group('backup service', () {
    test('history is sealed with the backup and never restored as a '
        'setting', () async {
      db.replace(MessageTable.direct, 'radio1', 'sam', [row(10, id: '1')]);
      final service = EncryptedBackupService();
      final values = EncryptedBackupService.withHistory({'theme': 'dark'}, db);
      expect(EncryptedBackupService.isRestorable(HistoryBackup.key), isFalse);
      final sealed = await service.seal(values, 'a-long-secret-passphrase');
      expect(sealed, isNot(contains('radio1')));
      final opened = await service.open(sealed, 'a-long-secret-passphrase');
      db.close();
      db = MessageDb.useInMemoryForTest()!;
      expect(EncryptedBackupService.restoreHistory(opened, db), 1);
    });

    test('a backup without history restores no messages', () {
      expect(EncryptedBackupService.restoreHistory({'theme': 'dark'}, db), 0);
    });
  });
}
