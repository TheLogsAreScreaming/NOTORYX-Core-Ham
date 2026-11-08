import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/channel_message.dart';
import 'package:meshcore_open/models/message.dart';
import 'package:meshcore_open/storage/channel_message_store.dart';
import 'package:meshcore_open/storage/db/message_db.dart';
import 'package:meshcore_open/storage/db/prefs_import.dart';
import 'package:meshcore_open/storage/message_store.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const radioA = 'aaaaaaaaaa11';
const radioB = 'bbbbbbbbbb22';
final sam = 'a1' * 32;
final alex = 'b2' * 32;

Message dm(String to, int i, {bool outgoing = false}) => Message(
  senderKey: Uint8List.fromList(List.filled(32, to.codeUnitAt(0))),
  text: 'message $i',
  timestamp: DateTime.fromMillisecondsSinceEpoch(1760000000000 + i * 1000),
  isOutgoing: outgoing,
  status: outgoing ? MessageStatus.delivered : MessageStatus.sent,
  retryCount: i % 3,
  pathLength: i % 2 == 0 ? -1 : 2,
  pathBytes: i % 2 == 0 ? null : Uint8List.fromList([0xA1, 0x3F]),
);

ChannelMessage post(int channel, int i) => ChannelMessage(
  senderName: 'Ridge',
  text: 'post $i',
  timestamp: DateTime.fromMillisecondsSinceEpoch(1760000000000 + i * 1000),
  isOutgoing: false,
  status: ChannelMessageStatus.sent,
  channelIndex: channel,
  viaMqtt: i.isEven,
);

MessageStore dmStore(String radio) => MessageStore()..setPublicKeyHex = radio;
ChannelMessageStore postStore(String radio) =>
    ChannelMessageStore()..setPublicKeyHex = radio;

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    resetImportsForTest();
  });
  tearDown(MessageDb.resetForTest);

  /// History written by a build without the database.
  Future<void> seedPrefs() async {
    MessageDb.useNoneForTest();
    await dmStore(radioA).saveMessages(sam, [
      for (var i = 0; i < 40; i++) dm(sam, i, outgoing: i.isOdd),
    ]);
    await dmStore(radioA).saveMessages(alex, [dm(alex, 1)]);
    await postStore(
      radioA,
    ).saveChannelMessages(0, [for (var i = 0; i < 25; i++) post(0, i)]);
    await postStore(radioA).saveChannelMessages(3, [post(3, 7)]);
    await dmStore(radioB).saveMessages(sam, [dm(sam, 99)]);
  }

  test('existing history moves in with identical content', () async {
    await seedPrefs();
    final before = await dmStore(radioA).loadMessages(sam);
    final postsBefore = await postStore(radioA).loadChannelMessages(0);

    final db = MessageDb.useInMemoryForTest()!;
    resetImportsForTest();
    final after = await dmStore(radioA).loadMessages(sam);
    final postsAfter = await postStore(radioA).loadChannelMessages(0);

    expect(db.isMigrated(radioA.substring(0, 10)), isTrue);
    expect(after.map((m) => m.messageId), before.map((m) => m.messageId));
    expect(after.map((m) => m.text), before.map((m) => m.text));
    expect(after.map((m) => m.status), before.map((m) => m.status));
    expect(after.map((m) => m.pathLength), before.map((m) => m.pathLength));
    expect(postsAfter.map((m) => m.text), postsBefore.map((m) => m.text));
    expect(postsAfter.map((m) => m.viaMqtt), postsBefore.map((m) => m.viaMqtt));
    expect(await postStore(radioA).loadChannelMessages(3), hasLength(1));
    expect(await dmStore(radioA).loadMessages(alex), hasLength(1));
  });

  test(
    'the old keys are kept, so an older build still has its history',
    () async {
      await seedPrefs();
      final keysBefore = PrefsManager.instance.getKeys().toSet();
      MessageDb.useInMemoryForTest();
      resetImportsForTest();
      await dmStore(radioA).loadMessages(sam);
      expect(PrefsManager.instance.getKeys().toSet(), keysBefore);
    },
  );

  test('after the move, saves go to the database only', () async {
    await seedPrefs();
    final db = MessageDb.useInMemoryForTest()!;
    resetImportsForTest();
    final store = dmStore(radioA);
    final key = '${store.keyFor}$sam';
    final oldValue = PrefsManager.instance.getString(key);

    await store.saveMessages(sam, [dm(sam, 500)]);
    expect(PrefsManager.instance.getString(key), oldValue);
    expect(
      db.load(MessageTable.direct, radioA.substring(0, 10), sam),
      hasLength(1),
    );
    expect((await store.loadMessages(sam)).single.text, 'message 500');
  });

  test('each radio keeps its own history', () async {
    await seedPrefs();
    final db = MessageDb.useInMemoryForTest()!;
    resetImportsForTest();
    expect((await dmStore(radioA).loadMessages(sam)), hasLength(40));
    expect(db.isMigrated(radioB.substring(0, 10)), isFalse);
    expect((await dmStore(radioB).loadMessages(sam)).single.text, 'message 99');
    expect(db.isMigrated(radioB.substring(0, 10)), isTrue);
  });

  test('importing twice changes nothing', () async {
    await seedPrefs();
    final db = MessageDb.useInMemoryForTest()!;
    expect(importScopeFromPrefs(db, radioA.substring(0, 10)), isTrue);
    expect(importScopeFromPrefs(db, radioA.substring(0, 10)), isTrue);
    expect(
      db.load(MessageTable.direct, radioA.substring(0, 10), sam),
      hasLength(40),
    );
  });

  test('an unreadable old entry is skipped, the rest still move', () async {
    await seedPrefs();
    await PrefsManager.instance.setString(
      'messages_${radioA.substring(0, 10)}${'c3' * 32}',
      '{not json',
    );
    final db = MessageDb.useInMemoryForTest()!;
    expect(importScopeFromPrefs(db, radioA.substring(0, 10)), isTrue);
    expect(
      db.load(MessageTable.direct, radioA.substring(0, 10), sam),
      hasLength(40),
    );
  });

  test('a legacy unscoped history is moved into the database', () async {
    // Write the legacy key the way very old builds did.
    final store = dmStore(radioA);
    MessageDb.useNoneForTest();
    await store.saveMessages(sam, [dm(sam, 2)]);
    final scoped = PrefsManager.instance.getString('${store.keyFor}$sam')!;
    await PrefsManager.instance.remove('${store.keyFor}$sam');
    await PrefsManager.instance.setString('messages_$sam', scoped);

    final db = MessageDb.useInMemoryForTest()!;
    resetImportsForTest();
    expect((await store.loadMessages(sam)).single.text, 'message 2');
    expect(
      db.load(MessageTable.direct, radioA.substring(0, 10), sam),
      hasLength(1),
    );
  });

  test('clearing removes a conversation everywhere', () async {
    await seedPrefs();
    final db = MessageDb.useInMemoryForTest()!;
    resetImportsForTest();
    final store = postStore(radioA);
    await store.clearChannelMessages(0);
    expect(await store.loadChannelMessages(0), isEmpty);
    expect(PrefsManager.instance.getString('${store.keyFor}0'), isNull);
    await store.clearAllChannelMessages();
    expect(
      db.load(MessageTable.channel, radioA.substring(0, 10), '3'),
      isEmpty,
    );
  });

  test('without SQLite (web) the stores keep using preferences', () async {
    MessageDb.useNoneForTest();
    final store = dmStore(radioA);
    await store.saveMessages(sam, [dm(sam, 1)]);
    expect(PrefsManager.instance.getString('${store.keyFor}$sam'), isNotNull);
    expect((await store.loadMessages(sam)).single.text, 'message 1');
  });

  test('a 20,000-message history saves and loads quickly', () async {
    MessageDb.useInMemoryForTest();
    final store = dmStore(radioA);
    final big = [for (var i = 0; i < 20000; i++) dm(sam, i)];
    final watch = Stopwatch()..start();
    await store.saveMessages(sam, big);
    final loaded = await store.loadMessages(sam);
    watch.stop();
    expect(loaded, hasLength(20000));
    expect(watch.elapsed, lessThan(const Duration(seconds: 10)));
  });
}
