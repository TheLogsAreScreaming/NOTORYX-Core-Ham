// Regression tests for failures other MeshCore and Meshtastic clients hit,
// in code NOTORYX shares or mirrors (roadmap P0-4).
import 'dart:convert';
import 'dart:typed_data';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/message.dart';
import 'package:meshcore_open/services/message_retry_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A PUSH_CODE_NEW_ADVERT frame: the radio heard (and maybe auto-added) [n].
Uint8List newAdvert(
  int n, {
  int type = advTypeRepeater,
  int flags = 0,
  int lastMod = 1000,
}) {
  final b = BytesBuilder()
    ..addByte(pushCodeNewAdvert)
    ..add(List.filled(32, n))
    ..addByte(type)
    ..addByte(flags)
    ..addByte(0)
    ..add(List.filled(maxPathSize, 0));
  final name = utf8.encode('Node $n');
  b
    ..add([...name, ...List.filled(maxNameSize - name.length, 0)])
    ..add(_u32(lastMod))
    ..add(_u32(0))
    ..add(_u32(0))
    ..add(_u32(lastMod));
  return b.toBytes();
}

List<int> _u32(int v) =>
    (ByteData(4)..setUint32(0, v, Endian.little)).buffer.asUint8List();

Contact contact(int n) => Contact(
  publicKey: Uint8List.fromList(List.filled(32, n)),
  name: 'Node $n',
  type: advTypeChat,
  pathLength: 0,
  path: Uint8List(0),
  lastSeen: DateTime.now(),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('a failed write must not wedge later sends', () {
    test('the failed message fails and the next one still goes out', () {
      final writes = <String>[];
      final updates = <Message>[];
      var linkRejects = true;
      final service = MessageRetryService();
      fakeAsync((async) {
        service.initialize(
          RetryServiceConfig(
            sendMessage: (c, text, attempt, ts) async {
              writes.add(text);
              // e.g. "data longer than allowed, datalen: 170 > max: 169"
              return !linkRejects;
            },
            addMessage: (_, _) {},
            updateMessage: updates.add,
          ),
        );
        final sam = contact(1);
        service.sendMessageWithRetry(contact: sam, text: 'x' * 156);
        async.flushMicrotasks();
        expect(updates.last.status, MessageStatus.failed);

        linkRejects = false;
        service.sendMessageWithRetry(contact: sam, text: 'ok');
        async.flushMicrotasks();
        expect(writes, ['x' * 156, 'ok']);
        expect(service.hasPendingMessages, isTrue, reason: 'ok awaits ACK');
      });
    });

    test('a send that reports nothing is left to the normal retry path', () {
      final updates = <Message>[];
      final service = MessageRetryService();
      fakeAsync((async) {
        service.initialize(
          RetryServiceConfig(
            sendMessage: (_, _, _, _) => null,
            addMessage: (_, _) {},
            updateMessage: updates.add,
          ),
        );
        service.sendMessageWithRetry(contact: contact(2), text: 'hi');
        async.flushMicrotasks();
        expect(updates.where((m) => m.status == MessageStatus.failed), isEmpty);
      });
    });
  });

  group('message limits never shrink with the BLE MTU', () {
    test('composer limits are fixed by the protocol, not the link', () {
      expect(maxContactMessageBytes(), greaterThanOrEqualTo(150));
      expect(maxChannelMessageBytes('A long sender name'), greaterThan(100));
    });

    test('a max-length DM frame fits the frame limit and an MTU 185 write', () {
      final frame = buildSendTextMsgFrame(
        Uint8List(32),
        'x' * maxContactMessageBytes(),
        timestampSeconds: 1,
      );
      expect(frame.length, lessThanOrEqualTo(maxFrameSize));
      // MTU 185 (requested on connect) leaves 182 bytes per ATT write.
      expect(frame.length, lessThanOrEqualTo(185 - 3));
    });
  });

  group('the contact list must not drift from the radio', () {
    late MeshCoreConnector connector;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      PrefsManager.reset();
      await PrefsManager.initialize();
      connector = MeshCoreConnector();
    });

    test('full table with overwrite oldest: the oldest is replaced', () {
      connector.debugSetContactTable(
        maxContacts: 3,
        overwriteOldest: true,
        autoAddRepeaters: true,
      );
      connector.handleFrameForTest(newAdvert(1, lastMod: 100));
      connector.handleFrameForTest(
        newAdvert(2, lastMod: 50, flags: contactFlagFavorite),
      );
      connector.handleFrameForTest(newAdvert(3, lastMod: 200));
      for (var n = 4; n <= 8; n++) {
        connector.handleFrameForTest(newAdvert(n, lastMod: 300 + n));
      }
      final names = connector.contacts.map((c) => c.name).toSet();
      expect(names, hasLength(3), reason: 'never more than the radio holds');
      expect(names, contains('Node 2'), reason: 'favorites are never replaced');
      expect(names, containsAll(['Node 7', 'Node 8']));
    });

    test('full table without overwrite: the radio adds nothing, nor do we', () {
      connector.debugSetContactTable(maxContacts: 2, autoAddRepeaters: true);
      connector.handleFrameForTest(newAdvert(1));
      connector.handleFrameForTest(newAdvert(2));
      connector.handleFrameForTest(newAdvert(3));
      expect(connector.contacts.map((c) => c.name), ['Node 1', 'Node 2']);
      expect(
        connector.discoveredContacts.map((c) => c.name),
        contains('Node 3'),
        reason: 'still listed as heard, so it can be added by hand',
      );
    });

    test('adverts for types the radio does not auto-add stay discovered', () {
      connector.debugSetContactTable(maxContacts: 100, autoAddUsers: true);
      for (var n = 1; n <= 20; n++) {
        connector.handleFrameForTest(newAdvert(n));
      }
      expect(connector.contacts, isEmpty, reason: 'no phantom repeaters');
      expect(connector.discoveredContacts, hasLength(20));
    });
  });
}
