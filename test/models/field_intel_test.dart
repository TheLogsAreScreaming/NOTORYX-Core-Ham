import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/field_intel.dart';

final now = DateTime(2026, 11, 6, 12);

Contact node(
  int n, {
  int type = advTypeChat,
  int hops = 0,
  Duration ago = Duration.zero,
  double? lat,
  double? lon,
  int flags = 0,
}) => Contact(
  publicKey: Uint8List.fromList(List.filled(32, n)),
  name: 'n$n',
  type: type,
  pathLength: hops,
  path: Uint8List(0),
  lastSeen: now.subtract(ago),
  latitude: lat,
  longitude: lon,
  flags: flags,
);

void main() {
  test('buckets when nodes were last heard', () {
    expect(
      heardWhen(now.subtract(const Duration(minutes: 10)), now),
      HeardWhen.quarterHour,
    );
    expect(
      heardWhen(now.subtract(const Duration(minutes: 45)), now),
      HeardWhen.hour,
    );
    expect(
      heardWhen(now.subtract(const Duration(hours: 5)), now),
      HeardWhen.day,
    );
    expect(
      heardWhen(now.subtract(const Duration(days: 2)), now),
      HeardWhen.older,
    );
  });

  test('groups nodes by hops', () {
    expect(hopBand(node(1, hops: -1)), HopBand.unknown);
    expect(hopBand(node(1, hops: 0)), HopBand.direct);
    expect(hopBand(node(1, hops: 2)), HopBand.two);
    expect(hopBand(node(1, hops: 7)), HopBand.threePlus);
  });

  test('counts last-heard nodes per hour and lists those in a bar', () {
    final nodes = [
      node(1, ago: const Duration(minutes: 5)),
      node(2, ago: const Duration(minutes: 50)),
      node(3, ago: const Duration(hours: 3, minutes: 10)),
      node(4, ago: const Duration(days: 3)),
    ];
    final h = hourlyLastHeard(nodes, now);
    expect(h[23], 2);
    expect(h[20], 1);
    expect(h.reduce((a, b) => a + b), 3);
    expect(heardInHour(nodes, 20, now).single.name, 'n3');
  });

  test('distance and direction', () {
    // About 111 km due north per degree of latitude.
    expect(distanceKm(47, -122, 48, -122), closeTo(111.2, 0.5));
    expect(compassPoint(bearingDeg(47, -122, 48, -122)), 'N');
    expect(compassPoint(bearingDeg(47, -122, 47, -121)), 'E');
    final sorted = byDistance(
      [node(1, lat: 47.5, lon: -122), node(2, lat: 47.1, lon: -122), node(3)],
      47,
      -122,
    );
    expect(sorted.map((d) => d.contact.name), ['n2', 'n1']);
  });

  test('flags low repeater batteries and quiet favourites', () {
    final r1 = node(1, type: advTypeRepeater),
        r2 = node(2, type: advTypeRepeater);
    final low = lowBatteryRepeaters([
      r1,
      r2,
      node(3),
    ], (k) => k == r1.publicKeyHex ? 3300 : 4100);
    expect(low.single.$1.name, 'n1');
    expect(low.single.$2, 3300);
    final fav = node(
      4,
      flags: contactFlagFavorite,
      ago: const Duration(days: 2),
    );
    expect(quietFavorites([fav, node(5, flags: contactFlagFavorite)], now), [
      fav,
    ]);
  });
}
