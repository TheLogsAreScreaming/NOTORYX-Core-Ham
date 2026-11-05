import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/message.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
  });
  tearDown(PrefsManager.reset);

  test(
    'resending while disconnected keeps the message and marks it failed',
    () async {
      final radio = MeshCoreConnector();
      final contact = Contact(
        publicKey: Uint8List.fromList(List.filled(32, 7)),
        name: 'Sam',
        type: 1,
        pathLength: -1,
        path: Uint8List(0),
        lastSeen: DateTime.now(),
      );
      final message = Message(
        senderKey: contact.publicKey,
        text: 'At camp',
        timestamp: DateTime.now(),
        isOutgoing: true,
      );
      radio.debugAddMessage(message);

      expect(radio.isConnected, isFalse);
      expect(await radio.resendMessage(contact, message), isFalse);

      final kept = radio.getMessages(contact);
      expect(kept, hasLength(1));
      expect(kept.single.text, 'At camp');
      expect(kept.single.status, MessageStatus.failed);
      radio.dispose();
    },
  );
}
