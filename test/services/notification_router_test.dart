import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/screens/channel_chat_screen.dart';
import 'package:meshcore_open/screens/chat_screen.dart';
import 'package:meshcore_open/screens/discovery_screen.dart';
import 'package:meshcore_open/services/notification_router.dart';

final _sam = Contact(
  publicKey: Uint8List.fromList(List.generate(32, (i) => i + 1)),
  name: 'Sam',
  type: advTypeChat,
  path: Uint8List(0),
  pathLength: 0,
  lastSeen: DateTime(2026, 10, 30),
);
final _hiking = Channel(
  index: 2,
  name: '#hiking',
  psk: Uint8List.fromList(List.filled(16, 2)),
);

class _Radio extends MeshCoreConnector {
  @override
  Contact? getContactByPubKeyHex(String hex) =>
      hex == _sam.publicKeyHex ? _sam : null;
  @override
  List<Channel> get channels => [_hiking];
}

void main() {
  final router = NotificationRouter(GlobalKey<NavigatorState>(), _Radio());

  test('a message opens that conversation', () {
    final screen = router.screenFor('message:${_sam.publicKeyHex}');
    expect(screen, isA<ChatScreen>());
    expect((screen! as ChatScreen).contact.name, 'Sam');
  });

  test('a channel post opens that channel', () {
    final screen = router.screenFor('channel:2');
    expect(screen, isA<ChannelChatScreen>());
    expect((screen! as ChannelChatScreen).channel.name, '#hiking');
  });

  test('a new advert opens Discovered contacts', () {
    expect(router.screenFor('advert:abc'), isA<DiscoveryScreen>());
  });

  test('anything gone or unknown opens nothing', () {
    expect(router.screenFor('message:ffff'), isNull);
    expect(router.screenFor('channel:9'), isNull);
    expect(router.screenFor('batch'), isNull);
  });
}
