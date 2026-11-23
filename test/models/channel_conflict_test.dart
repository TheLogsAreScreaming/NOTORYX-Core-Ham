import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/models/channel_conflict.dart';

Channel ch(int index, String name, int keyByte) => Channel(
  index: index,
  name: name,
  psk: Uint8List.fromList(List.filled(16, keyByte)),
);

void main() {
  test('matching slots and new radio slots are not conflicts', () {
    final out = findChannelConflicts(
      app: [ch(0, 'Public', 1)],
      radio: [ch(0, 'Public', 1), ch(1, '#new', 2)],
      slots: 8,
    );
    expect(out, isEmpty);
  });

  test('a changed name or key is a conflict holding both copies', () {
    final out = findChannelConflicts(
      app: [ch(0, 'Public', 1), ch(1, 'Team', 2)],
      radio: [ch(0, 'Public', 1), ch(1, 'Team', 3)],
      slots: 8,
    );
    expect(out, hasLength(1));
    expect(out.single.index, 1);
    expect(out.single.keyDiffers, isTrue);
    expect(out.single.nameDiffers, isFalse);
    expect(out.single.app.psk.first, 2);
    expect(out.single.radio!.psk.first, 3);
  });

  test('a slot emptied on the radio is a conflict', () {
    final out = findChannelConflicts(
      app: [ch(2, 'Team', 2)],
      radio: const [],
      slots: 8,
    );
    expect(out.single.missingOnRadio, isTrue);
  });

  test('slots the app just wrote, or that were not read, are skipped', () {
    final out = findChannelConflicts(
      app: [ch(1, 'Old', 2), ch(9, 'Far', 4)],
      radio: [ch(1, 'New', 3)],
      slots: 8,
      skip: {1},
    );
    expect(out, isEmpty);
  });

  test('a pending conflict keeps the app copy until the radio matches', () {
    final pending = [ChannelConflict(index: 1, app: ch(1, 'Team', 2))];
    final still = findChannelConflicts(
      app: [ch(1, 'Team', 3)],
      radio: [ch(1, 'Team', 3)],
      slots: 8,
      pending: pending,
    );
    expect(still.single.app.psk.first, 2);
    final gone = findChannelConflicts(
      app: [ch(1, 'Team', 3)],
      radio: [ch(1, 'Team', 2)],
      slots: 8,
      pending: pending,
    );
    expect(gone, isEmpty);
  });

  test('saved conflicts round-trip and fingerprints do not leak the key', () {
    final c = ChannelConflict(index: 3, app: ch(3, 'Team', 7));
    final back = ChannelConflict.fromJson(c.toJson())!;
    expect(back.index, 3);
    expect(back.app.name, 'Team');
    expect(sameChannel(back.app, c.app), isTrue);
    expect(ChannelConflict.fromJson({'index': 1}), isNull);
    final fp = channelKeyFingerprint(c.app.psk);
    expect(fp, matches(RegExp(r'^[0-9a-f]{4} [0-9a-f]{4}$')));
    expect(fp.replaceAll(' ', ''), isNot(contains('0707')));
  });
}
