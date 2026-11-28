import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/contact.dart';

Contact _node({required DateTime advert, DateTime? heardByRadio}) => Contact(
  publicKey: Uint8List(32),
  name: 'Node A',
  type: advTypeRepeater,
  pathLength: -1,
  path: Uint8List(0),
  lastSeen: advert,
  lastModified: heardByRadio,
);

void main() {
  final now = DateTime.utc(2026, 11, 25, 12);

  test('a node with a wrong clock that was just heard is not old', () {
    final node = _node(
      advert: DateTime.utc(2024, 5, 15),
      heardByRadio: now.subtract(const Duration(seconds: 30)),
    );
    expect(node.lastHeardAt(now), now.subtract(const Duration(seconds: 30)));
  });

  test('takes the later of the advert and the radio time', () {
    final advert = now.subtract(const Duration(minutes: 5));
    final radio = now.subtract(const Duration(hours: 2));
    expect(_node(advert: advert, heardByRadio: radio).lastHeardAt(now), advert);
  });

  test('ignores a radio time from an unset or future clock', () {
    final advert = now.subtract(const Duration(hours: 3));
    expect(
      _node(
        advert: advert,
        heardByRadio: DateTime.utc(1970, 1, 2),
      ).lastHeardAt(now),
      advert,
    );
    expect(
      _node(
        advert: advert,
        heardByRadio: now.add(const Duration(days: 30)),
      ).lastHeardAt(now),
      advert,
    );
  });

  test('falls back to the advert time when nothing is believable', () {
    final advert = DateTime.utc(1970, 1, 1, 0, 5);
    expect(_node(advert: advert).lastHeardAt(now), advert);
  });
}
