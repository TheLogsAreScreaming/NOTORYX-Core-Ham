import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/contact.dart';

Contact _contact({int flags = 0}) => Contact(
  publicKey: Uint8List.fromList(List.generate(32, (i) => i + 1)),
  name: 'Sam',
  type: advTypeChat,
  pathLength: -1,
  path: Uint8List(0),
  lastSeen: DateTime.now(),
  flags: flags,
);

class _Radio extends MeshCoreConnector {
  final sam = _contact();
  @override
  List<Contact> get contacts => [sam];
}

/// A RESP_CODE_CONTACT_MSG_RECV frame as companion firmware queues it.
Uint8List _incoming(Contact from, int txtType, String text) =>
    Uint8List.fromList([
      respCodeContactMsgRecv,
      ...from.publicKey.sublist(0, 6),
      0xFF, // path length: flood
      txtType,
      0, 0, 0, 0, // timestamp
      ...utf8.encode(text),
      0,
    ]);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('remote commands to a companion use TXT_TYPE_CLI_COMMAND', () {
    final key = _contact().publicKey;
    final companion = buildSendCliCommandFrame(
      key,
      'ab|get name',
      txtType: txtTypeCliCommand,
      timestampSeconds: 1,
    );
    expect(companion[0], cmdSendTxtMsg);
    expect(companion[1], 3);
    expect(companion.sublist(7, 13), key.sublist(0, 6));
    expect(
      utf8.decode(companion.sublist(13, companion.length - 1)),
      'ab|get name',
    );
    // Repeaters keep CLI data.
    expect(buildSendCliCommandFrame(key, 'ver')[1], txtTypeCliData);
  });

  test('flag 0x10 is the remote command line permission', () {
    expect(contactFlagRemoteCli, 0x10);
    expect(_contact().remoteCliAllowed, isFalse);
    expect(_contact(flags: 0x10 | 0x02).remoteCliAllowed, isTrue);
    expect(_contact(flags: 0x0F).remoteCliAllowed, isFalse);
  });

  test('a command our radio refused is recorded, not shown as chat', () {
    final radio = _Radio();
    final message = radio.parseContactMessageForTest(
      _incoming(radio.sam, txtTypeCliCommand, 'xy|reboot'),
    );
    expect(message, isNull);
    final blocked = radio.blockedRemoteCommands.single;
    expect(blocked.name, 'Sam');
    expect(blocked.command, 'reboot');
    expect(blocked.contactKey, radio.sam.publicKeyHex);
    radio.dispose();
  });

  test('CLI replies are not mistaken for blocked commands', () {
    final radio = _Radio();
    radio.parseContactMessageForTest(
      _incoming(radio.sam, txtTypeCliData << 2, 'xy|> Sam'),
    );
    expect(radio.blockedRemoteCommands, isEmpty);
    radio.dispose();
  });
}
