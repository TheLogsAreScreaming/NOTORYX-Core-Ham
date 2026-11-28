import 'dart:math' as math;

import '../connector/meshcore_protocol.dart';
import 'contact.dart';

/// When a node was last heard, in the buckets Field intelligence shows.
enum HeardWhen { quarterHour, hour, day, older }

/// How far a node is in hops, as Field intelligence groups them.
enum HopBand { direct, one, two, threePlus, unknown }

HeardWhen heardWhen(DateTime lastSeen, DateTime now) {
  final age = now.difference(lastSeen);
  if (age <= const Duration(minutes: 15)) return HeardWhen.quarterHour;
  if (age <= const Duration(hours: 1)) return HeardWhen.hour;
  if (age <= const Duration(hours: 24)) return HeardWhen.day;
  return HeardWhen.older;
}

HopBand hopBand(Contact c) => switch (c.pathLength) {
  < 0 => HopBand.unknown,
  0 => HopBand.direct,
  1 => HopBand.one,
  2 => HopBand.two,
  _ => HopBand.threePlus,
};

/// Nodes last heard in each of the past 24 hours: index 23 is the latest
/// hour, 0 the hour that ended 23 hours ago. Only each node's latest time
/// is known, so this is when nodes were last heard, not all their traffic.
List<int> hourlyLastHeard(Iterable<Contact> contacts, DateTime now) {
  final counts = List.filled(24, 0);
  for (final c in contacts) {
    final hoursAgo = now.difference(c.lastSeen).inMinutes ~/ 60;
    if (hoursAgo < 0 || hoursAgo > 23) continue;
    counts[23 - hoursAgo]++;
  }
  return counts;
}

/// The nodes last heard in the hour at [index] of [hourlyLastHeard].
List<Contact> heardInHour(
  Iterable<Contact> contacts,
  int index,
  DateTime now,
) => [
  for (final c in contacts)
    if (now.difference(c.lastSeen).inMinutes ~/ 60 == 23 - index) c,
];

/// Great-circle distance in km.
double distanceKm(double lat1, double lon1, double lat2, double lon2) {
  const r = 6371.0;
  double rad(double d) => d * math.pi / 180;
  final dLat = rad(lat2 - lat1), dLon = rad(lon2 - lon1);
  final a =
      math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(rad(lat1)) *
          math.cos(rad(lat2)) *
          math.sin(dLon / 2) *
          math.sin(dLon / 2);
  return 2 * r * math.asin(math.min(1, math.sqrt(a)));
}

/// Initial bearing from the first point to the second, 0–360°.
double bearingDeg(double lat1, double lon1, double lat2, double lon2) {
  double rad(double d) => d * math.pi / 180;
  final y = math.sin(rad(lon2 - lon1)) * math.cos(rad(lat2));
  final x =
      math.cos(rad(lat1)) * math.sin(rad(lat2)) -
      math.sin(rad(lat1)) * math.cos(rad(lat2)) * math.cos(rad(lon2 - lon1));
  return (math.atan2(y, x) * 180 / math.pi + 360) % 360;
}

/// "N", "NE", … for a bearing.
String compassPoint(double bearing) {
  const points = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
  return points[((bearing + 22.5) % 360 ~/ 45)];
}

/// A located node with its distance and direction from you.
typedef NodeDistance = ({Contact contact, double km, double bearing});

/// Located nodes, nearest first.
List<NodeDistance> byDistance(
  Iterable<Contact> contacts,
  double lat,
  double lon,
) {
  final list = [
    for (final c in contacts)
      if (c.hasLocation)
        (
          contact: c,
          km: distanceKm(lat, lon, c.latitude!, c.longitude!),
          bearing: bearingDeg(lat, lon, c.latitude!, c.longitude!),
        ),
  ]..sort((a, b) => a.km.compareTo(b.km));
  return list;
}

/// A repeater battery below this (millivolts) is flagged.
const lowBatteryMv = 3500;

/// Repeaters reporting a low battery, lowest first.
List<(Contact, int)> lowBatteryRepeaters(
  Iterable<Contact> contacts,
  int? Function(String keyHex) millivolts,
) {
  final list = <(Contact, int)>[
    for (final c in contacts)
      if (c.type == advTypeRepeater)
        if (millivolts(c.publicKeyHex) case final mv?)
          if (mv > 0 && mv < lowBatteryMv) (c, mv),
  ]..sort((a, b) => a.$2.compareTo(b.$2));
  return list;
}

/// Favourites not heard for a day.
List<Contact> quietFavorites(Iterable<Contact> contacts, DateTime now) => [
  for (final c in contacts)
    if (c.isFavorite && heardWhen(c.lastSeen, now) == HeardWhen.older) c,
];
