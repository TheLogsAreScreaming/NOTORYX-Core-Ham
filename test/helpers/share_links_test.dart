import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/helpers/share_links.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/screens/map_screen.dart' show parseMarkerText;
import 'package:meshcore_open/widgets/share_in_chat.dart';

Contact _contact(String name, int fill, {int type = advTypeChat}) => Contact(
  publicKey: Uint8List.fromList(List.filled(32, fill)),
  name: name,
  type: type,
  pathLength: -1,
  path: Uint8List(0),
  lastSeen: DateTime.now(),
);

class _Radio extends MeshCoreConnector {
  final known = [_contact('Sam', 7)];
  final frames = <Uint8List>[];
  int refreshes = 0;
  @override
  bool get isConnected => true;
  @override
  List<Contact> get contacts => known;
  @override
  Future<void> sendFrame(
    Uint8List frame, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async => frames.add(frame);
  @override
  Future<void> refreshContacts() async => refreshes++;
}

void main() {
  test('reads the example link from the MeshCore docs', () {
    final link = parseContactLink(
      'meshcore://contact/add?name=Example+Contact&public_key=9cd8fcf22a47333b591d96a2b848b73f457b1bb1a3ea2453a885f9e5787765b1&type=1',
    )!;
    expect(link.name, 'Example Contact');
    expect(
      link.publicKeyHex.toLowerCase(),
      '9cd8fcf22a47333b591d96a2b848b73f457b1bb1a3ea2453a885f9e5787765b1',
    );
    expect(link.typeLabel, 'Companion');
  });

  test('a shared contact round-trips and fits one message', () {
    final c = _contact('Ridge Repeater #2', 0xAB, type: advTypeRepeater);
    final text = contactLinkFor(c);
    expect(text, startsWith('meshcore://contact/add?name=Ridge+Repeater+%232'));
    final back = parseContactLink('Add this one: $text')!;
    expect(back.name, 'Ridge Repeater #2');
    expect(back.publicKey, c.publicKey);
    expect(back.type, advTypeRepeater);
    expect(text.length, lessThanOrEqualTo(maxTextPayloadBytes - 20));
  });

  test('rejects malformed links', () {
    expect(parseContactLink('hello'), isNull);
    expect(
      parseContactLink('meshcore://contact/add?name=x&public_key=abc&type=1'),
      isNull,
    );
    expect(
      parseContactLink(
        'meshcore://contact/add?name=x&public_key=${'a' * 64}&type=9',
      ),
      isNull,
    );
  });

  test('a shared position is the map marker the app already shows', () {
    final text = positionMarker(35.123456, -80.5, 'Trail|Lead position');
    final poi = parseMarkerText(text)!;
    expect(poi.position.latitude, 35.123456);
    expect(poi.position.longitude, -80.5);
    expect(poi.label, 'Trail/Lead position');
  });

  test('adding a shared contact writes it with an unknown route', () async {
    final radio = _Radio();
    final link = parseContactLink(contactLinkFor(_contact('Alex', 9)))!;
    await radio.addContactFromLink(link);
    final frame = radio.frames.single;
    expect(frame[0], cmdAddUpdateContact);
    expect(frame.sublist(1, 33), link.publicKey);
    expect(frame[33], advTypeChat);
    expect(frame[35], 0xFF);
    expect(radio.refreshes, 1);
    radio.dispose();
  });

  testWidgets('the chat card offers Add only for new contacts', (tester) async {
    final radio = _Radio();
    Future<void> show(Contact c) => tester.pumpWidget(
      ChangeNotifierProvider<MeshCoreConnector>.value(
        value: radio,
        child: MaterialApp(
          home: Scaffold(
            body: ContactLinkCard(
              link: parseContactLink(contactLinkFor(c))!,
              textColor: Colors.black,
            ),
          ),
        ),
      ),
    );
    await show(radio.known.first);
    expect(find.text('Already in your contacts.'), findsOneWidget);

    await show(_contact('Jo', 3));
    expect(find.text('Add contact'), findsOneWidget);
    await tester.tap(find.text('Add contact'));
    await tester.pump();
    expect(radio.frames, hasLength(1));
    expect(find.text('Added Jo.'), findsOneWidget);
  });
}
