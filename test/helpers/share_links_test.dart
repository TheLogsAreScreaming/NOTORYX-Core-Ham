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

  test('preserves every documented type and encoded contact name', () {
    for (final type in [
      advTypeChat,
      advTypeRepeater,
      advTypeRoom,
      advTypeSensor,
    ]) {
      final contact = _contact('Ridge + #2 & café', 0xAB, type: type);
      final parsed = parseContactLink(contactLinkFor(contact))!;
      expect(parsed.type, type);
      expect(parsed.name, contact.name);
      expect(parsed.publicKey, contact.publicKey);
    }
  });

  test('defaults only missing type and name, never malformed values', () {
    final base = 'meshcore://contact/add?public_key=${'a' * 64}';
    expect(parseContactLink(base)!.type, advTypeChat);
    expect(parseContactLink(base)!.name, 'Unnamed contact');
    for (final suffix in [
      '&type=',
      '&type=nope',
      '&type=0',
      '&type=5',
      '&type=1&type=2',
      '&public_key=${'b' * 64}',
      '&name=A&name=B',
      '&name=%FF',
      '&name=%ZZ',
      '#fragment',
    ]) {
      expect(parseContactLink('$base$suffix'), isNull, reason: suffix);
    }
  });

  group('pasting a contact', () {
    final key =
        '9cd8fcf22a47333b591d96a2b848b73f457b1bb1a3ea2453a885f9e5787765b1';
    final advertHex = List.generate(
      110,
      (i) => (i * 7 % 256).toRadixString(16).padLeft(2, '0'),
    ).join();

    ContactLink linkOf(String text) =>
        (parsePastedContact(text)! as PastedLink).link;

    test('takes a proper link, even inside other words', () {
      final link = linkOf(
        'Add me! meshcore://contact/add?name=Ridge&public_key=$key&type=2 thanks',
      );
      expect(link.name, 'Ridge');
      expect(link.type, advTypeRepeater);
    });

    test('takes a link whose name has raw spaces', () {
      final link = linkOf(
        'meshcore://contact/add?name=Bob Smith&public_key=$key&type=1',
      );
      expect(link.name, 'Bob Smith');
      expect(link.publicKeyHex.toLowerCase(), key);
      final last = linkOf(
        'meshcore://contact/add?public_key=$key&type=3&name=Base Camp Room',
      );
      expect(last.name, 'Base Camp Room');
      expect(last.type, advTypeRoom);
    });

    test('takes an advert wrapped across lines or in other case', () {
      final wrapped =
          'MeshCore://${advertHex.substring(0, 100)}\n'
          '${advertHex.substring(100, 180)} ${advertHex.substring(180)}';
      final pasted = parsePastedContact(wrapped)! as PastedAdvert;
      expect(pasted.advert, hex2Uint8List(advertHex));
      expect(
        (parsePastedContact('  meshcore://$advertHex\n')! as PastedAdvert)
            .advert
            .length,
        110,
      );
      expect(parsePastedContact(advertHex), isA<PastedAdvert>());
    });

    test('takes a bare public key', () {
      final link = linkOf(' $key ');
      expect(link.name, 'Unnamed contact');
      expect(link.type, advTypeChat);
    });

    test('turns down anything else', () {
      for (final text in [
        'hello',
        'meshcore://abcd',
        'meshcore://contact/add?name=x&public_key=abc&type=1',
        key.substring(1),
        'meshcore://contact/add?name=A B&public_key=$key&type=2&type=1',
        'meshcore://contact/add?name=A B&public_key=$key&name=C',
        '',
      ]) {
        expect(parsePastedContact(text), isNull, reason: text);
      }
    });
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
    expect(find.text('Add contact'), findsNothing);
    expect(find.text('Already in your contacts.'), findsOneWidget);
    await show(_contact('Next contact', 4));
    expect(find.text('Add contact'), findsOneWidget);
  });
}
