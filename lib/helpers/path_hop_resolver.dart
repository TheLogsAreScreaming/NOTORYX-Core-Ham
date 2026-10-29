import 'package:latlong2/latlong.dart';

import '../connector/meshcore_protocol.dart';
import 'path_helper.dart';
import '../models/contact.dart';

class PathHopResolver {
  const PathHopResolver._();

  /// Farther than this from the previous hop, a candidate can't be the
  /// repeater that relayed the message: LoRa hops rarely pass 150 km.
  static const double defaultMaxHopKm = 150;

  static List<Contact?> resolve({
    required List<int> pathBytes,
    required List<Contact> contacts,
    LatLng? endpoint,
    bool resolveFromEnd = false,
    int pathHashByteWidth = 1,
    double maxHopKm = defaultMaxHopKm,
  }) {
    final width = pathHashByteWidth.clamp(1, 4).toInt();
    final candidatesByPrefix = <String, List<Contact>>{};
    for (final contact in contacts) {
      if (contact.publicKey.length < width) continue;
      if (contact.type != advTypeRepeater && contact.type != advTypeRoom) {
        continue;
      }
      final prefix = PathHelper.formatHopHex(
        contact.publicKey.sublist(0, width),
      );
      candidatesByPrefix.putIfAbsent(prefix, () => <Contact>[]).add(contact);
    }
    for (final candidates in candidatesByPrefix.values) {
      candidates.sort((a, b) => b.lastSeen.compareTo(a.lastSeen));
    }

    final hops = PathHelper.splitPathBytes(pathBytes, width);
    final resolved = List<Contact?>.filled(hops.length, null);
    final indexes = resolveFromEnd
        ? List<int>.generate(hops.length, (i) => hops.length - 1 - i)
        : List<int>.generate(hops.length, (i) => i);
    final distance = Distance();
    var previousPosition = endpoint;

    for (final index in indexes) {
      final candidates =
          candidatesByPrefix[PathHelper.formatHopHex(hops[index])];
      if (candidates == null || candidates.isEmpty) continue;

      // A short path hash is not a unique repeater identity. When multiple
      // contacts share the same prefix and no location evidence is available,
      // leave the hop unresolved rather than showing an arbitrary name.
      if (candidates.length > 1 && previousPosition == null) continue;

      var bestIndex = 0;
      if (previousPosition != null && candidates.length == 1) {
        // A lone candidate that is out of radio range is someone else's
        // repeater with the same short ID.
        final position = _positionOf(candidates.first);
        if (position != null &&
            distance(previousPosition, position) > maxHopKm * 1000) {
          continue;
        }
      }
      if (previousPosition != null && candidates.length > 1) {
        double? nearestDistance;
        for (var i = 0; i < candidates.length; i++) {
          final position = _positionOf(candidates[i]);
          if (position == null) continue;
          final candidateDistance = distance(previousPosition, position);
          if (nearestDistance == null || candidateDistance < nearestDistance) {
            nearestDistance = candidateDistance;
            bestIndex = i;
          }
        }
        // Without a located candidate, recency is not identity evidence.
        if (nearestDistance == null) continue;
        if (nearestDistance > maxHopKm * 1000) continue;
      }

      final contact = candidates.removeAt(bestIndex);
      resolved[index] = contact;
      previousPosition = _positionOf(contact) ?? previousPosition;
    }

    return resolved;
  }

  static LatLng? _positionOf(Contact contact) {
    if (!contact.hasLocation ||
        contact.latitude == null ||
        contact.longitude == null) {
      return null;
    }
    return LatLng(contact.latitude!, contact.longitude!);
  }
}
