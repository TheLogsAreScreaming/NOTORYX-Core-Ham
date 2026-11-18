import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';

import '../connector/meshcore_protocol.dart';
import '../helpers/path_hop_resolver.dart';
import '../services/rx_log_service.dart';
import 'contact.dart';
import 'mqtt_mesh_packet.dart';

/// The six packet kinds the live Traffic map draws, each in its own colour.
enum TrafficKind { advert, direct, channel, ack, trace, path }

/// The Traffic map kind for an RX log kind, or null for traffic it leaves
/// out (control and unknown packets).
TrafficKind? trafficKindFor(RxKind kind) => switch (kind) {
  RxKind.advert => TrafficKind.advert,
  RxKind.direct => TrafficKind.direct,
  RxKind.channel => TrafficKind.channel,
  RxKind.ack => TrafficKind.ack,
  RxKind.trace => TrafficKind.trace,
  RxKind.path => TrafficKind.path,
  RxKind.control || RxKind.other => null,
};

/// Where a hop sits in a route.
enum TrafficHopRole { origin, repeater, self }

/// One node a packet passed on its way to this radio.
@immutable
class TrafficHop {
  const TrafficHop({
    required this.id,
    required this.role,
    this.name,
    this.position,
  });

  /// Short upper-case hex ID: the path hash, or the start of the key.
  final String id;
  final TrafficHopRole role;

  /// The contact's name, when the hop could be matched to one.
  final String? name;

  /// Null when the node has no known position; it is then left off the map.
  final LatLng? position;

  /// The name when known, otherwise the short ID.
  String get label => name ?? id;

  bool get onMap => position != null;
}

/// A packet this radio heard, as a route from its origin through each
/// repeater to us.
@immutable
class TrafficRoute {
  const TrafficRoute({
    required this.kind,
    required this.hops,
    required this.receivedAt,
    required this.snr,
    required this.rssi,
    required this.isFlood,
    required this.hopCount,
    required this.packetHash,
    this.station,
  });

  final TrafficKind kind;

  /// Every hop in order: origin (when known), repeaters, then us.
  final List<TrafficHop> hops;
  final DateTime receivedAt;
  final double snr;
  final int rssi;

  /// Flooded rather than source-routed.
  final bool isFlood;

  /// Repeaters the packet has passed (flood) or still has ahead (direct).
  final int hopCount;
  final String packetHash;

  /// Call sign from the frame's station ID, when there was one.
  final String? station;

  /// The hops that can be drawn, in order, with repeated positions merged.
  List<TrafficHop> get mapHops {
    final out = <TrafficHop>[];
    for (final hop in hops) {
      final position = hop.position;
      if (position == null) continue;
      if (out.isNotEmpty && out.last.position == position) continue;
      out.add(hop);
    }
    return out;
  }

  /// Positions of [mapHops], origin first.
  List<LatLng> get points => [for (final hop in mapHops) hop.position!];

  /// Whether there is at least one leg to draw.
  bool get drawable => mapHops.length >= 2;

  /// Origin and repeaters with no position (we are never in this list).
  List<TrafficHop> get notOnMap => [
    for (final hop in hops)
      if (!hop.onMap && hop.role != TrafficHopRole.self) hop,
  ];

  /// The node we heard this from: the last repeater, or the origin when it
  /// reached us directly. Null when neither is known.
  TrafficHop? get heardFrom {
    for (var i = hops.length - 1; i >= 0; i--) {
      if (hops[i].role != TrafficHopRole.self) return hops[i];
    }
    return null;
  }

  /// Seconds since it was heard, never negative.
  int ageSeconds(DateTime now) {
    final s = now.difference(receivedAt).inSeconds;
    return s < 0 ? 0 : s;
  }
}

/// Turns heard packets into [TrafficRoute]s using the contact list.
class TrafficRouteBuilder {
  const TrafficRouteBuilder._();

  /// The route [entry] took, or null when the map leaves this kind out.
  ///
  /// Flood packets carry the repeaters they have passed, in order; those
  /// hashes are matched to repeaters by key prefix (see [PathHopResolver]).
  /// Source-routed packets carry the hops still ahead, so they are drawn
  /// straight from origin to us.
  static TrafficRoute? build(
    RxLogEntry entry, {
    required List<Contact> contacts,
    LatLng? selfPosition,
    String? selfId,
    String? selfName,
  }) {
    final kind = trafficKindFor(entry.kind);
    if (kind == null) return null;
    final info = entry.info;
    final origin = _origin(info.payloadType, info.payload, contacts);

    final repeaters = <TrafficHop>[];
    if (!info.isDirect) {
      final hashes = _travelledHashes(info);
      final width = hashes.width;
      final bytes = hashes.bytes;
      if (bytes.isNotEmpty) {
        final originPosition = origin?.position;
        final resolved = PathHopResolver.resolve(
          pathBytes: bytes,
          contacts: contacts,
          endpoint: originPosition ?? selfPosition,
          resolveFromEnd: originPosition == null,
          pathHashByteWidth: width,
        );
        for (var i = 0; i < resolved.length; i++) {
          final contact = resolved[i];
          final id = _hex(
            Uint8List.sublistView(bytes, i * width, (i + 1) * width),
          );
          repeaters.add(
            TrafficHop(
              id: id,
              role: TrafficHopRole.repeater,
              name: _nameOf(contact),
              position: _positionOf(contact),
            ),
          );
        }
      }
    }

    return TrafficRoute(
      kind: kind,
      hops: [
        ?origin,
        ...repeaters,
        TrafficHop(
          id: selfId ?? '',
          role: TrafficHopRole.self,
          name: selfName,
          position: selfPosition,
        ),
      ],
      receivedAt: entry.receivedAt,
      snr: entry.snr,
      rssi: entry.rssi,
      isFlood: !info.isDirect,
      hopCount: info.hopCount,
      packetHash: info.hash,
      station: entry.station,
    );
  }

  /// The repeater hashes a flood packet has passed. Trace packets keep SNR
  /// readings in the path field and the route hashes in their payload:
  /// `[tag x4][auth x4][flags][hashes]`, hash size `1 << (flags & 3)`.
  static ({Uint8List bytes, int width}) _travelledHashes(MeshPacketInfo info) {
    if (info.payloadType != payloadTypeTRACE) {
      return (bytes: info.path, width: info.pathHashWidth);
    }
    final payload = info.payload;
    if (payload.length < 9) return (bytes: Uint8List(0), width: 1);
    final width = 1 << (payload[8] & 0x03);
    if (width > 4) return (bytes: Uint8List(0), width: 1);
    final hashes = Uint8List.sublistView(payload, 9);
    // Only the hops it has reached so far: one SNR byte per hop.
    final travelled = (info.path.length * width).clamp(0, hashes.length);
    final whole = travelled - travelled % width;
    return (bytes: Uint8List.sublistView(hashes, 0, whole), width: width);
  }

  /// The sender, when the packet names it: adverts and anonymous requests
  /// carry the full key; messages, requests, responses and path returns
  /// carry a one-byte source hash, matched only when exactly one contact
  /// has it. Channel messages, acks and traces don't say who sent them.
  static TrafficHop? _origin(
    int payloadType,
    Uint8List payload,
    List<Contact> contacts,
  ) {
    switch (payloadType) {
      case payloadTypeADVERT:
        if (payload.length < 101) return null;
        final key = Uint8List.sublistView(payload, 0, 32);
        final contact = _byKey(contacts, key);
        final advert = _advertDetails(payload);
        return TrafficHop(
          id: _hex(Uint8List.sublistView(key, 0, 3)),
          role: TrafficHopRole.origin,
          name: advert.name ?? _nameOf(contact),
          position: advert.position ?? _positionOf(contact),
        );
      case payloadTypeANONREQ:
        if (payload.length < 33) return null;
        final key = Uint8List.sublistView(payload, 1, 33);
        final contact = _byKey(contacts, key);
        return TrafficHop(
          id: _hex(Uint8List.sublistView(key, 0, 3)),
          role: TrafficHopRole.origin,
          name: _nameOf(contact),
          position: _positionOf(contact),
        );
      case payloadTypeTXTMSG ||
          payloadTypeREQ ||
          payloadTypeRESPONSE ||
          payloadTypePATH:
        if (payload.length < 2) return null;
        final source = payload[1];
        final matches = [
          for (final c in contacts)
            if (c.publicKey.isNotEmpty && c.publicKey[0] == source) c,
        ];
        final contact = matches.length == 1 ? matches.single : null;
        return TrafficHop(
          id: _hex(Uint8List.fromList([source])),
          role: TrafficHopRole.origin,
          name: _nameOf(contact),
          position: _positionOf(contact),
        );
      default:
        return null;
    }
  }

  static Contact? _byKey(List<Contact> contacts, Uint8List key) {
    for (final c in contacts) {
      if (listEquals(c.publicKey, key)) return c;
    }
    return null;
  }

  /// Name and position from an advert's app data:
  /// `[key x32][time x4][signature x64][flags][lat, lon x4 if 0x10]
  /// [feature x2 if 0x20][feature x2 if 0x40][name if 0x80]`.
  static ({String? name, LatLng? position}) _advertDetails(Uint8List payload) {
    final flags = payload[100];
    var i = 101;
    LatLng? position;
    if (flags & 0x10 != 0) {
      if (payload.length < i + 8) return (name: null, position: null);
      final data = ByteData.sublistView(payload, i, i + 8);
      final lat = data.getInt32(0, Endian.little) / 1e6;
      final lon = data.getInt32(4, Endian.little) / 1e6;
      i += 8;
      if (_validPosition(lat, lon)) position = LatLng(lat, lon);
    }
    if (flags & 0x20 != 0) i += 2;
    if (flags & 0x40 != 0) i += 2;
    String? name;
    if (flags & 0x80 != 0 && i < payload.length) {
      final bytes = payload.sublist(i).takeWhile((b) => b != 0).toList();
      final text = utf8.decode(bytes, allowMalformed: true).trim();
      if (text.isNotEmpty) name = text;
    }
    return (name: name, position: position);
  }

  static bool _validPosition(double lat, double lon) =>
      (lat.abs() > 1e-6 || lon.abs() > 1e-6) &&
      lat >= -90 &&
      lat <= 90 &&
      lon >= -180 &&
      lon <= 180;

  static String? _nameOf(Contact? contact) {
    final name = contact?.name.trim();
    return name == null || name.isEmpty ? null : name;
  }

  static LatLng? _positionOf(Contact? contact) {
    if (contact == null || !contact.hasLocation) return null;
    return LatLng(contact.latitude!, contact.longitude!);
  }

  static String _hex(Uint8List bytes) => RxLogEntry.hex(bytes);
}

/// Where a route's animation is at a moment in time.
@immutable
class TrafficFrame {
  const TrafficFrame({
    required this.leg,
    required this.legProgress,
    required this.opacity,
    required this.arrived,
  });

  /// The leg the dot is on (0 = origin to first hop). Equals the number of
  /// legs once it has arrived.
  final int leg;

  /// How far along [leg] the dot is, 0 to 1.
  final double legProgress;

  /// 1 while travelling, falling to 0 as the route fades.
  final double opacity;
  final bool arrived;

  bool get finished => opacity <= 0;
}

/// Timing for route animations.
class TrafficTiming {
  const TrafficTiming._();

  /// Time the dot takes per leg.
  static const leg = Duration(milliseconds: 650);

  /// Longest the dot travels, however many legs there are.
  static const maxTravel = Duration(milliseconds: 3200);

  /// Fade after arrival.
  static const fade = Duration(milliseconds: 3500);

  /// Travel time for [legs] legs; zero when motion is reduced.
  static Duration travel(int legs, {bool reduceMotion = false}) {
    if (reduceMotion || legs <= 0) return Duration.zero;
    final ms = leg.inMilliseconds * legs;
    return Duration(
      milliseconds: ms > maxTravel.inMilliseconds
          ? maxTravel.inMilliseconds
          : ms,
    );
  }

  /// Total time a route with [legs] legs stays on screen.
  static Duration total(int legs, {bool reduceMotion = false}) =>
      travel(legs, reduceMotion: reduceMotion) + fade;

  /// The animation frame [elapsed] after a route with [legs] legs started.
  /// With [reduceMotion] there is no travelling dot: the line is drawn
  /// whole and fades.
  static TrafficFrame frameAt(
    Duration elapsed,
    int legs, {
    bool reduceMotion = false,
  }) {
    final travelMs = travel(legs, reduceMotion: reduceMotion).inMilliseconds;
    final t = elapsed.inMilliseconds < 0 ? 0 : elapsed.inMilliseconds;
    if (legs > 0 && t < travelMs) {
      final position = t / travelMs * legs;
      final index = position.floor().clamp(0, legs - 1);
      return TrafficFrame(
        leg: index,
        legProgress: (position - index).clamp(0.0, 1.0),
        opacity: 1,
        arrived: false,
      );
    }
    final fadeT = (t - travelMs) / fade.inMilliseconds;
    return TrafficFrame(
      leg: legs,
      legProgress: 1,
      opacity: (1 - fadeT).clamp(0.0, 1.0),
      arrived: true,
    );
  }
}
