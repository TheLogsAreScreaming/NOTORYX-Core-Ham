import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/radio_rx_packet.dart';
import 'package:meshcore_open/models/traffic_route.dart';
import 'package:meshcore_open/services/rx_log_service.dart';
import 'package:meshcore_open/services/traffic_feed.dart';
import 'package:meshcore_open/widgets/traffic_map.dart';

const _flood = 1;
const _direct = 2;
final _heardAt = DateTime.utc(2026, 11, 18, 12);
const _self = LatLng(40.0, -75.0);

/// `[header][path len][path][payload]` with no transport codes.
Uint8List _packet(
  int payloadType,
  List<int> payload, {
  int route = _flood,
  List<int> path = const [],
  int width = 1,
  int? hops,
}) => Uint8List.fromList([
  (payloadType << 2) | route,
  (hops ?? path.length ~/ width) | ((width - 1) << 6),
  ...path,
  ...payload,
]);

RxLogEntry _entry(Uint8List raw, {bool fromSelf = false}) => RxLogEntry.from(
  RadioRxPacket(
    raw: raw,
    snr: 12,
    rssi: -33,
    receivedAt: _heardAt,
    fromSelf: fromSelf,
  ),
)!;

Uint8List _key(List<int> prefix) =>
    Uint8List(32)..setRange(0, prefix.length, prefix);

Contact _contact(
  String name,
  List<int> prefix, {
  LatLng? at,
  int type = advTypeRepeater,
}) => Contact(
  publicKey: _key(prefix),
  name: name,
  type: type,
  pathLength: 0,
  path: Uint8List(0),
  latitude: at?.latitude,
  longitude: at?.longitude,
  lastSeen: _heardAt,
);

/// An advert payload with a position and a name.
List<int> _advert(List<int> keyPrefix, String name, {LatLng? at}) {
  final flags = 0x02 | 0x80 | (at != null ? 0x10 : 0);
  final location = ByteData(8);
  if (at != null) {
    location
      ..setInt32(0, (at.latitude * 1e6).round(), Endian.little)
      ..setInt32(4, (at.longitude * 1e6).round(), Endian.little);
  }
  return [
    ..._key(keyPrefix),
    ...List.filled(4, 0), // timestamp
    ...List.filled(64, 0), // signature
    flags,
    if (at != null) ...location.buffer.asUint8List(),
    ...utf8.encode(name),
  ];
}

TrafficRoute _build(RxLogEntry entry, List<Contact> contacts) =>
    TrafficRouteBuilder.build(
      entry,
      contacts: contacts,
      selfPosition: _self,
      selfId: 'C0FFEE',
      selfName: 'Base',
    )!;

void main() {
  final hill = _contact('Hill', [0xAA], at: const LatLng(40.4, -75.4));
  final ridge = _contact('Ridge', [0xBB], at: const LatLng(40.2, -75.2));
  final noFix = _contact('Cellar', [0xCC]);

  group('route building', () {
    test('a flooded advert runs origin → each repeater → us', () {
      final raw = _packet(
        payloadTypeADVERT,
        _advert([0x1F, 0xD7, 0x5D], 'Summit', at: const LatLng(40.6, -75.6)),
        path: [0xAA, 0xBB],
      );
      final route = _build(_entry(raw), [hill, ridge]);

      expect(route.kind, TrafficKind.advert);
      expect(route.hops.map((h) => h.label), [
        'Summit',
        'Hill',
        'Ridge',
        'Base',
      ]);
      expect(route.hops.first.id, '1FD75D');
      expect(route.points, [
        const LatLng(40.6, -75.6),
        const LatLng(40.4, -75.4),
        const LatLng(40.2, -75.2),
        _self,
      ]);
      expect(route.isFlood, isTrue);
      expect(route.hopCount, 2);
      expect(route.heardFrom?.label, 'Ridge');
      expect(route.notOnMap, isEmpty);
      expect(route.drawable, isTrue);
      expect(route.snr, 12);
      expect(route.rssi, -33);
    });

    test('hops with no position are skipped on the map but listed', () {
      final raw = _packet(
        payloadTypeADVERT,
        _advert([0x1F], 'Summit', at: const LatLng(40.6, -75.6)),
        path: [0xAA, 0xCC, 0xDD, 0xBB],
      );
      final route = _build(_entry(raw), [hill, ridge, noFix]);

      expect(route.hops.map((h) => h.label), [
        'Summit',
        'Hill',
        'Cellar',
        'DD',
        'Ridge',
        'Base',
      ]);
      expect(route.mapHops.map((h) => h.label), [
        'Summit',
        'Hill',
        'Ridge',
        'Base',
      ]);
      expect(route.notOnMap.map((h) => h.label), ['Cellar', 'DD']);
    });

    test('an advert with no position takes it from the contact', () {
      final origin = _contact(
        'Saved',
        [0x1F, 0xD7],
        type: advTypeChat,
        at: const LatLng(40.7, -75.7),
      );
      final raw = _packet(payloadTypeADVERT, _advert([0x1F, 0xD7], 'Saved'));
      final route = _build(_entry(raw), [origin]);
      expect(route.hops.first.position, const LatLng(40.7, -75.7));
      expect(route.heardFrom?.label, 'Saved');
      expect(route.points, [const LatLng(40.7, -75.7), _self]);
    });

    test('a channel message starts at the first repeater', () {
      final raw = _packet(
        payloadTypeGRPTXT,
        [0x11, 0x22, 0x33, 0x44],
        path: [0xAA, 0xBB],
      );
      final route = _build(_entry(raw), [hill, ridge]);
      expect(route.kind, TrafficKind.channel);
      expect(route.hops.first.role, TrafficHopRole.repeater);
      expect(route.hops.map((h) => h.label), ['Hill', 'Ridge', 'Base']);
    });

    test('an unlocated packet heard directly is not drawable', () {
      final raw = _packet(payloadTypeGRPTXT, [0x11, 0x22, 0x33]);
      final route = _build(_entry(raw), const []);
      expect(route.hops.single.role, TrafficHopRole.self);
      expect(route.drawable, isFalse);
      expect(route.heardFrom, isNull);
    });

    test('a source-routed message goes straight from sender to us', () {
      final sender = _contact(
        'Walker',
        [0x5A],
        type: advTypeChat,
        at: const LatLng(40.3, -75.1),
      );
      final raw = _packet(
        payloadTypeTXTMSG,
        [0xC0, 0x5A, 0x01, 0x02, 0x03],
        route: _direct,
        path: [0xAA, 0xBB], // hops still ahead, not travelled
      );
      final route = _build(_entry(raw), [sender, hill, ridge]);
      expect(route.kind, TrafficKind.direct);
      expect(route.isFlood, isFalse);
      expect(route.hops.map((h) => h.label), ['Walker', 'Base']);
    });

    test('a one-byte source shared by two contacts stays unnamed', () {
      final a = _contact('One', [0x5A, 1], type: advTypeChat);
      final b = _contact('Two', [0x5A, 2], type: advTypeChat);
      final raw = _packet(payloadTypeTXTMSG, [0xC0, 0x5A, 0x01, 0x02]);
      final route = _build(_entry(raw), [a, b]);
      expect(route.hops.first.name, isNull);
      expect(route.hops.first.label, '5A');
    });

    test('two-byte path hashes match by two-byte key prefix', () {
      final wide = _contact('Wide', [0xAB, 0xCD], at: const LatLng(40.1, -75));
      final raw = _packet(
        payloadTypeACK,
        [1, 2, 3, 4],
        path: [0xAB, 0xCD],
        width: 2,
      );
      final route = _build(_entry(raw), [wide]);
      expect(route.kind, TrafficKind.ack);
      expect(route.hops.first.id, 'ABCD');
      expect(route.hops.first.name, 'Wide');
    });

    test('a trace follows the hashes in its payload it has reached', () {
      // Path field holds one SNR byte per hop reached; payload holds the
      // full planned route.
      final raw = _packet(
        payloadTypeTRACE,
        [1, 2, 3, 4, 0, 0, 0, 0, 0x00, 0xAA, 0xBB, 0xCC],
        path: [40, 36],
      );
      final route = _build(_entry(raw), [hill, ridge, noFix]);
      expect(route.kind, TrafficKind.trace);
      expect(route.hops.map((h) => h.label), ['Hill', 'Ridge', 'Base']);
    });

    test('control packets are left off the map', () {
      final raw = _packet(payloadTypeCONTROL, [0x80, 0x01]);
      expect(
        TrafficRouteBuilder.build(_entry(raw), contacts: const []),
        isNull,
      );
    });

    test('every RX kind maps to one of six colours, or none', () {
      expect(trafficKindFor(RxKind.advert), TrafficKind.advert);
      expect(trafficKindFor(RxKind.direct), TrafficKind.direct);
      expect(trafficKindFor(RxKind.channel), TrafficKind.channel);
      expect(trafficKindFor(RxKind.ack), TrafficKind.ack);
      expect(trafficKindFor(RxKind.trace), TrafficKind.trace);
      expect(trafficKindFor(RxKind.path), TrafficKind.path);
      expect(trafficKindFor(RxKind.control), isNull);
      expect(trafficKindFor(RxKind.other), isNull);
      expect(TrafficKind.values.map(trafficColor).toSet(), hasLength(6));
    });
  });

  group('animation timing', () {
    test('the dot walks the legs, then the route fades', () {
      var f = TrafficTiming.frameAt(Duration.zero, 3);
      expect((f.leg, f.legProgress, f.opacity, f.arrived), (0, 0.0, 1, false));

      final travel = TrafficTiming.travel(3);
      f = TrafficTiming.frameAt(travel * 0.5, 3);
      expect(f.leg, 1);
      expect(f.legProgress, closeTo(0.5, 0.01));

      f = TrafficTiming.frameAt(travel, 3);
      expect(f.arrived, isTrue);
      expect(f.leg, 3);
      expect(f.opacity, 1);

      f = TrafficTiming.frameAt(TrafficTiming.total(3), 3);
      expect(f.finished, isTrue);
    });

    test('long routes are capped so they never crawl', () {
      expect(TrafficTiming.travel(30), TrafficTiming.maxTravel);
    });

    test('reduce motion draws the whole line at once and fades', () {
      final f = TrafficTiming.frameAt(Duration.zero, 4, reduceMotion: true);
      expect(f.arrived, isTrue);
      expect(f.leg, 4);
      expect(TrafficTiming.total(4, reduceMotion: true), TrafficTiming.fade);
    });
  });

  group('feed', () {
    late DateTime now;
    TrafficFeed feed() => TrafficFeed(
      contacts: () => [hill, ridge],
      selfPosition: () => _self,
      clock: () => now,
    );
    RadioRxPacket heard({
      bool fromSelf = false,
      int type = payloadTypeGRPTXT,
    }) => RadioRxPacket(
      raw: _packet(type, [1, 2, 3, 4], path: [0xAA, 0xBB]),
      snr: 5,
      rssi: -90,
      receivedAt: now,
      fromSelf: fromSelf,
    );

    setUp(() => now = _heardAt);

    test('plays three routes at once and queues the rest', () {
      final f = feed();
      for (var i = 0; i < 5; i++) {
        f.add(heard());
      }
      expect(f.active, hasLength(3));
      expect(f.queued, 2);
      expect(f.latest, isNotNull);

      now = now.add(TrafficTiming.total(2));
      expect(f.tick(), isTrue);
      expect(f.active, hasLength(2));
      expect(f.queued, 0);

      now = now.add(TrafficTiming.total(2));
      expect(f.tick(), isFalse);
      f.dispose();
    });

    test('our own packets heard back are skipped', () {
      final f = feed()..add(heard(fromSelf: true));
      expect(f.latest, isNull);
      expect(f.active, isEmpty);
      f.dispose();
    });

    test('the filter hides kinds that are turned off', () {
      final f = feed()..add(heard());
      expect(f.active, hasLength(1));
      f.kinds = {TrafficKind.advert};
      expect(f.active, isEmpty);
      expect(f.latest, isNull);
      f.add(heard());
      expect(f.latest, isNull);
      f.dispose();
    });
  });
}
