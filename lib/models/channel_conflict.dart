import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;

import 'channel.dart';

/// A channel slot where the radio and the app disagree.
///
/// The app keeps its own copy of every channel. When a sync finds the radio
/// holding a different name or key in a slot (someone changed it with another
/// app, or the app's copy is old), the app's copy is kept here until the user
/// picks which one wins.
class ChannelConflict {
  ChannelConflict({required this.index, required this.app, this.radio});

  final int index;

  /// What the app had saved for this slot.
  final Channel app;

  /// What the radio holds now, or null if the slot is empty on the radio.
  final Channel? radio;

  bool get missingOnRadio => radio == null;
  bool get nameDiffers => radio == null || radio!.name != app.name;
  bool get keyDiffers => radio == null || !_sameKey(radio!.psk, app.psk);

  Map<String, dynamic> toJson() => {
    'index': index,
    'name': app.name,
    'psk': base64Encode(app.psk),
  };

  /// Reads a saved conflict; [radio] is today's radio copy of the slot.
  static ChannelConflict? fromJson(Object? json) {
    if (json is! Map) return null;
    final index = json['index'];
    final name = json['name'];
    final psk = json['psk'];
    if (index is! int || name is! String || psk is! String) return null;
    final Uint8List bytes;
    try {
      bytes = base64Decode(psk);
    } on FormatException {
      return null;
    }
    if (bytes.length != 16) return null;
    return ChannelConflict(
      index: index,
      app: Channel(index: index, name: name, psk: bytes),
    );
  }
}

bool _sameKey(Uint8List a, Uint8List b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

/// Whether two copies of a slot carry the same name and key.
bool sameChannel(Channel a, Channel b) =>
    a.name == b.name && _sameKey(a.psk, b.psk);

/// A short, safe way to tell two keys apart on screen without showing them:
/// the first four bytes of the key's SHA-256, as `ab12 cd34`.
String channelKeyFingerprint(Uint8List psk) {
  final digest = crypto.sha256.convert(psk).bytes;
  String hex(int b) => b.toRadixString(16).padLeft(2, '0');
  return '${hex(digest[0])}${hex(digest[1])} ${hex(digest[2])}${hex(digest[3])}';
}

/// Compares the app's saved channels with what a full sync read from the
/// radio.
///
/// Only slots below [slots] are compared (the sync didn't ask about the
/// rest). Slots in [skip] were just written by this app, so a difference
/// there is expected. A slot the app never had is new, not a conflict.
/// [pending] holds conflicts not yet answered: for those slots the app's
/// side is the pending copy, not [app], which already holds the radio's.
List<ChannelConflict> findChannelConflicts({
  required List<Channel> app,
  required List<Channel> radio,
  required int slots,
  Set<int> skip = const {},
  List<ChannelConflict> pending = const [],
}) {
  final appBySlot = <int, Channel>{
    for (final c in app)
      if (!c.isEmpty) c.index: c,
  };
  for (final p in pending) {
    appBySlot[p.index] = p.app;
  }
  final radioBySlot = <int, Channel>{
    for (final c in radio)
      if (!c.isEmpty) c.index: c,
  };
  final out = <ChannelConflict>[];
  final indexes = appBySlot.keys.toList()..sort();
  for (final index in indexes) {
    if (index >= slots || skip.contains(index)) continue;
    final mine = appBySlot[index]!;
    final theirs = radioBySlot[index];
    if (theirs != null && sameChannel(mine, theirs)) continue;
    out.add(ChannelConflict(index: index, app: mine, radio: theirs));
  }
  return out;
}
