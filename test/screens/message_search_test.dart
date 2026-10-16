import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/models/channel_message.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/message.dart';
import 'package:meshcore_open/models/message_search.dart';
import 'package:meshcore_open/screens/message_search_screen.dart';

final _sam = Contact(
  publicKey: Uint8List.fromList(List.filled(32, 7)),
  name: 'Sam',
  type: advTypeChat,
  pathLength: -1,
  path: Uint8List(0),
  lastSeen: DateTime.now(),
);
final _public = Channel(
  index: 0,
  name: 'Public',
  psk: Uint8List.fromList(List.filled(16, 1)),
);
final _empty = Channel(index: 3, name: '', psk: Uint8List(16));

Message _dm(String text, int minute, {bool out = false, bool cli = false}) =>
    Message(
      senderKey: _sam.publicKey,
      text: text,
      timestamp: DateTime.utc(2026, 10, 16, 9, minute),
      isOutgoing: out,
      isCli: cli,
    );

ChannelMessage _ch(String text, int minute) => ChannelMessage(
  senderKey: null,
  senderName: 'Alex',
  text: text,
  timestamp: DateTime.utc(2026, 10, 16, 9, minute),
  isOutgoing: false,
  status: ChannelMessageStatus.sent,
  channelIndex: 0,
);

class _Radio extends MeshCoreConnector {
  @override
  List<Contact> get contacts => [_sam];
  @override
  List<Channel> get channels => [_public, _empty];
  @override
  Future<List<Message>> loadFullConversation(Contact contact) async => [
    _dm('Meet at the trailhead', 1),
    _dm('trailhead parking is full', 5, out: true),
    _dm('> get name', 6, cli: true),
  ];
  @override
  Future<List<ChannelMessage>> loadFullChannelHistory(Channel c) async => [
    _ch('Water at the TRAILHEAD tap is off', 3),
    _ch('nothing here', 4),
  ];
}

void main() {
  test('every word must match, in any order and case', () {
    final words = queryWords('  Trail  PARK ');
    expect(words, ['trail', 'park']);
    expect(matchesWords('parking at the trailhead', words), isTrue);
    expect(matchesWords('trailhead', words), isFalse);
    expect(matchesWords('anything', const []), isFalse);
  });

  test('highlight ranges are merged and ordered', () {
    expect(highlightRanges('Trail trailhead', ['trail', 'head']), [
      (0, 5),
      (6, 15),
    ]);
  });

  test('searches direct and channel history, newest first', () async {
    final radio = _Radio();
    final hits = await searchMessages(
      query: 'trailhead',
      contacts: radio.contacts,
      channels: radio.channels,
      loadDirect: radio.loadFullConversation,
      loadChannel: radio.loadFullChannelHistory,
    );
    expect(hits.map((h) => '${h.conversation}/${h.sender}'), [
      'Sam/You',
      'Public/Alex',
      'Sam/Sam',
    ]);
    expect(
      (await searchMessages(
        query: 'get name',
        contacts: radio.contacts,
        channels: radio.channels,
        loadDirect: radio.loadFullConversation,
        loadChannel: radio.loadFullChannelHistory,
      )),
      isEmpty,
      reason: 'command line replies are not chat',
    );
    radio.dispose();
  });

  testWidgets('typing shows highlighted matches', (tester) async {
    final radio = _Radio();
    await tester.pumpWidget(
      ChangeNotifierProvider<MeshCoreConnector>.value(
        value: radio,
        child: const MaterialApp(home: MessageSearchScreen()),
      ),
    );
    expect(find.textContaining('Search every direct'), findsOneWidget);
    await tester.enterText(
      find.byKey(const ValueKey('message-search-field')),
      'water',
    );
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();
    expect(find.text('1 match'), findsOneWidget);
    expect(find.text('Public • Alex'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('message-search-field')),
      'zebra',
    );
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();
    expect(find.text('No messages contain "zebra".'), findsOneWidget);
  });
}
