import 'contact.dart';
import 'wardrive.dart';

/// How well a nearby repeater and this radio hear each other, judged by
/// the weaker of the two directions.
enum NearbyLink { strong, usable, weak }

/// One repeater that answered a nearby test.
class NearbyRepeater {
  const NearbyRepeater({required this.reply, this.name});

  final WardriveReply reply;

  /// The matching contact's name, when this radio knows the repeater.
  final String? name;

  String get prefix => reply.prefix;

  /// The weaker direction's SNR, in dB.
  double get weakerSnr =>
      reply.snrHere < reply.snrThere ? reply.snrHere : reply.snrThere;

  NearbyLink get link => weakerSnr >= 5
      ? NearbyLink.strong
      : weakerSnr >= -5
      ? NearbyLink.usable
      : NearbyLink.weak;
}

/// Names each reply from [known] by key prefix, strongest link first.
List<NearbyRepeater> rankNearbyRepeaters(
  Iterable<WardriveReply> replies,
  List<Contact> known,
) {
  String? nameFor(String prefix) {
    for (final c in known) {
      if (c.publicKeyHex.toLowerCase().startsWith(prefix.toLowerCase())) {
        return c.name.isEmpty ? null : c.name;
      }
    }
    return null;
  }

  final seen = <String>{};
  final list = [
    for (final r in replies)
      if (seen.add(r.prefix)) NearbyRepeater(reply: r, name: nameFor(r.prefix)),
  ];
  list.sort((a, b) {
    final byWeaker = b.weakerSnr.compareTo(a.weakerSnr);
    return byWeaker != 0 ? byWeaker : a.prefix.compareTo(b.prefix);
  });
  return list;
}
