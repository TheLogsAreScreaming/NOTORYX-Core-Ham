import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/contact.dart';

Contact _repeater(int seed) => Contact(
  publicKey: Uint8List.fromList(List.generate(32, (i) => i + seed)),
  name: 'Repeater $seed',
  type: advTypeRepeater,
  pathLength: -1,
  path: Uint8List(0),
  lastSeen: DateTime.now(),
);

class _Radio extends MeshCoreConnector {
  final List<Uint8List> sent = [];

  @override
  bool get isConnected => true;

  @override
  Future<void> sendFrame(
    Uint8List data, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async {
    sent.add(data);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('a path write for a known contact is sent', () async {
    final radio = _Radio();
    final known = _repeater(1);
    radio.debugSetContacts([known]);

    await radio.setContactPath(known, Uint8List.fromList([0xAB]), 1);

    expect(radio.sent, hasLength(1));
    radio.dispose();
  });

  test('path and flag writes skip a contact that was removed', () async {
    final radio = _Radio();
    radio.debugSetContacts([_repeater(1)]);
    final removed = _repeater(50);

    await radio.setContactPath(removed, Uint8List.fromList([0xAB]), 1);
    await radio.setContactFlags(removed, isFavorite: true);

    expect(radio.sent, isEmpty);
    radio.dispose();
  });
}
