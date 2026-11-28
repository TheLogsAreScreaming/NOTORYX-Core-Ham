import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';

class _Radio extends MeshCoreConnector {
  final sent = <Uint8List>[];
  @override
  bool get isConnected => true;
  @override
  Future<void> sendFrame(
    Uint8List frame, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async => sent.add(frame);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late _Radio radio;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    radio = _Radio();
  });
  tearDown(() => radio.dispose());

  test('the radio saying its contact list is full is flagged', () async {
    var notified = 0;
    radio.addListener(() => notified++);
    expect(radio.contactsFull, isFalse);

    radio.handleFrameForTest([pushCodeContactsFull]);
    expect(radio.contactsFull, isTrue);
    // Notifications are batched; let the batch go out.
    await Future<void>.delayed(const Duration(milliseconds: 300));
    expect(notified, greaterThan(0));
  });

  test('the flag clears when the radio drops a contact', () {
    radio.handleFrameForTest([pushCodeContactsFull]);
    radio.handleFrameForTest([pushCodeContactDeleted, ...List.filled(32, 7)]);
    expect(radio.contactsFull, isFalse);
  });

  test('the flag clears when we remove a contact', () async {
    final contact = Contact(
      publicKey: Uint8List.fromList(List.filled(32, 3)),
      name: 'Sam',
      type: advTypeChat,
      pathLength: -1,
      path: Uint8List(0),
      lastSeen: DateTime.now(),
    );
    radio.debugSetContacts([contact]);
    radio.handleFrameForTest([pushCodeContactsFull]);
    await radio.removeContact(contact);
    expect(radio.contactsFull, isFalse);
  });
}
