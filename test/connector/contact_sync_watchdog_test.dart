import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';

Uint8List _key(int seed) => Uint8List.fromList(
  List.generate(32, (i) => (seed * 31 + i * 7) & 0xFF | 1),
);

Contact _contact(int seed, String name) => Contact(
  publicKey: _key(seed),
  name: name,
  type: advTypeChat,
  pathLength: -1,
  path: Uint8List(0),
  lastSeen: DateTime.now(),
);

/// A RESP_CODE_CONTACT frame as the radio sends it.
List<int> _contactFrame(int seed, String name) {
  final nameBytes = utf8.encode(name);
  return [
    respCodeContact,
    ..._key(seed),
    advTypeChat,
    0, // flags
    0xFF, // path unknown
    ...List.filled(64, 0),
    ...nameBytes,
    ...List.filled(32 - nameBytes.length, 0),
    ...List.filled(16, 0), // last advert, lat, lon, lastmod
  ];
}

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
    MeshCoreConnector.contactSyncSilence = const Duration(milliseconds: 60);
    radio = _Radio()
      ..debugSetContacts([_contact(1, 'Sam'), _contact(2, 'Alex')]);
  });
  tearDown(() => radio.dispose());

  Future<void> wait(int ms) => Future<void>.delayed(Duration(milliseconds: ms));

  test('saved contacts stay visible while the radio sends its list', () async {
    await radio.getContacts();
    expect(radio.isLoadingContacts, isTrue);
    expect(radio.contacts.map((c) => c.name), ['Sam', 'Alex']);
  });

  test('a silent radio is asked once more, then the sync gives up', () async {
    await radio.getContacts();
    expect(radio.sent.where((f) => f[0] == cmdGetContacts), hasLength(1));
    await wait(90);
    expect(radio.sent.where((f) => f[0] == cmdGetContacts), hasLength(2));
    expect(radio.isLoadingContacts, isTrue);
    await wait(90);
    expect(radio.isLoadingContacts, isFalse);
    expect(radio.contactSyncStalled, isTrue);
    expect(radio.hasLoadedContacts, isTrue);
    expect(radio.contacts, hasLength(2), reason: 'nothing is dropped');

    await radio.retryContactSync();
    expect(radio.contactSyncStalled, isFalse);
    expect(radio.isLoadingContacts, isTrue);
  });

  test('contacts arriving keep the sync alive', () async {
    await radio.getContacts();
    for (var i = 0; i < 4; i++) {
      await wait(40);
      radio.handleFrameForTest(_contactFrame(1, 'Sam'));
    }
    expect(radio.isLoadingContacts, isTrue);
    expect(radio.sent.where((f) => f[0] == cmdGetContacts), hasLength(1));
  });

  test('a complete sync drops contacts the radio no longer has', () async {
    await radio.getContacts();
    radio.handleFrameForTest([respCodeContactsStart, 1, 0, 0, 0]);
    radio.handleFrameForTest(_contactFrame(1, 'Sam'));
    radio.handleFrameForTest([respCodeEndOfContacts]);
    expect(radio.isLoadingContacts, isFalse);
    expect(radio.contactSyncStalled, isFalse);
    expect(radio.contacts.map((c) => c.name), ['Sam']);
    await wait(90);
    expect(
      radio.sent.where((f) => f[0] == cmdGetContacts),
      hasLength(1),
      reason: 'the watchdog stops after the sync completes',
    );
  });

  test('a partial (refresh) sync keeps contacts it did not mention', () async {
    await radio.getContacts(preserveExisting: true);
    radio.handleFrameForTest(_contactFrame(1, 'Sam'));
    radio.handleFrameForTest([respCodeEndOfContacts]);
    expect(radio.contacts, hasLength(2));
  });
}
