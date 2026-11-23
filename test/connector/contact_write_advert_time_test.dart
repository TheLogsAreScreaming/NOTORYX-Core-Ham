import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/helpers/share_links.dart';
import 'package:meshcore_open/models/contact.dart';

final _advert = DateTime.fromMillisecondsSinceEpoch(1700000000 * 1000);

Contact _node({DateTime? lastSeen}) => Contact(
  publicKey: Uint8List.fromList(List.generate(32, (i) => i + 7)),
  name: 'Node A',
  type: advTypeRepeater,
  pathLength: -1,
  path: Uint8List(0),
  lastSeen: lastSeen ?? _advert,
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

  List<Uint8List> get contactWrites =>
      sent.where((f) => f[0] == cmdAddUpdateContact).toList();
}

/// The last-advert field of a CMD_ADD_UPDATE_CONTACT frame.
int _advertField(Uint8List frame) {
  const offset = 1 + pubKeySize + 3 + maxPathSize + maxNameSize;
  return ByteData.sublistView(frame).getUint32(offset, Endian.little);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('advertSeconds clamps to the 32-bit field', () {
    expect(advertSeconds(_advert), 1700000000);
    expect(advertSeconds(DateTime.fromMillisecondsSinceEpoch(0)), 0);
    expect(advertSeconds(DateTime.fromMillisecondsSinceEpoch(-5000)), 0);
  });

  test('a path write keeps the advert time the radio holds', () async {
    final radio = _Radio();
    radio.debugSetContacts([_node()]);

    // A screen may hold an older copy whose lastSeen is not the radio's.
    final stale = _node(lastSeen: DateTime.now());
    await radio.setContactPath(stale, Uint8List.fromList([0xAB]), 1);

    expect(_advertField(radio.contactWrites.single), 1700000000);
    radio.dispose();
  });

  test('a flag write keeps the advert time, not the phone clock', () async {
    final radio = _Radio();
    final node = _node();
    radio.debugSetContacts([node]);

    await radio.setContactFlags(node, isFavorite: true);

    expect(_advertField(radio.contactWrites.single), 1700000000);
    radio.dispose();
  });

  test('a contact added from a link starts with no advert time', () async {
    final radio = _Radio();
    final node = _node();

    await radio.addContactFromLink(
      ContactLink(node.name, node.publicKey, node.type),
    );

    expect(_advertField(radio.contactWrites.first), 0);
    radio.dispose();
  });
}
