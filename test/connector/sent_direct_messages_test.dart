import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Radio extends MeshCoreConnector {
  @override
  bool get isConnected => true;
  @override
  Future<void> sendFrame(
    Uint8List frame, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async {}
}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
  });

  test('each message the user sends is announced once', () async {
    final radio = _Radio();
    final contact = Contact(
      publicKey: Uint8List.fromList(List.filled(32, 7)),
      name: 'W1AW Base',
      type: advTypeChat,
      pathLength: -1,
      path: Uint8List(0),
      lastSeen: DateTime.now(),
    );
    final sent = <Contact>[];
    radio.sentDirectMessages.listen(sent.add);

    await radio.sendMessage(contact, 'hello');
    await radio.sendMessage(contact, 'x' * (maxTextPayloadBytes + 1));
    await radio.sendMessage(contact, '');
    await pumpEventQueue();
    expect(sent.map((c) => c.name), ['W1AW Base']);
  });
}
