import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;

import 'mqtt_broker_settings.dart';

/// Largest MQTT payload accepted before JSON decoding.
const int mqttMeshPacketMaxPayloadBytes = 4096;

/// Largest raw MeshCore packet (radio MTU).
const int meshPacketMaxBytes = 255;

/// Topic layout used by MeshCore observers (meshcoretomqtt):
/// `<prefix>/<region>/<observer public key>/packets`.
class MqttPacketTopics {
  const MqttPacketTopics._();

  /// The subscription filter for [settings]' prefix and region.
  static String subscriptionFor(MqttBrokerSettings settings) {
    final prefix = settings.topicPrefix.trim();
    final region = settings.region.trim();
    return '$prefix/${region.isEmpty ? '+' : region}/+/packets';
  }

  /// Where this app publishes as an observer, or null without a region.
  static String? publishFor(MqttBrokerSettings settings, String observerKey) {
    final region = settings.region.trim();
    if (region.isEmpty || observerKey.isEmpty) return null;
    return '${settings.topicPrefix.trim()}/$region/$observerKey/packets';
  }
}

/// The parts of a raw MeshCore packet needed to classify and deduplicate it.
class MeshPacketInfo {
  const MeshPacketInfo._({
    required this.routeType,
    required this.payloadType,
    required this.hopCount,
    required this.payload,
    required this.hash,
  });

  final int routeType;
  final int payloadType;
  final int hopCount;
  final Uint8List payload;

  /// Firmware-compatible packet hash: the first 8 bytes of
  /// SHA-256(payload type + payload), as lowercase hex. The same packet heard
  /// by several observers, or over several hops, has the same hash.
  final String hash;

  /// Whether the packet is source-routed rather than flooded.
  bool get isDirect => routeType == 2 || routeType == 3;

  /// Returns null if [raw] is shorter than its header and path claim.
  static MeshPacketInfo? tryParse(Uint8List raw) {
    if (raw.length < 2 || raw.length > meshPacketMaxBytes) return null;
    final header = raw[0];
    final routeType = header & 0x03;
    var offset = 1;
    // Transport-flood and transport-direct carry two u16 transport codes.
    if (routeType == 0 || routeType == 3) offset += 4;
    if (offset >= raw.length) return null;
    final pathLenRaw = raw[offset++];
    final hopCount = pathLenRaw == 0xFF ? 0 : pathLenRaw & 63;
    final hashWidth = pathLenRaw == 0xFF ? 1 : ((pathLenRaw >> 6) & 0x03) + 1;
    offset += hopCount * hashWidth;
    if (offset > raw.length) return null;
    final payload = Uint8List.sublistView(raw, offset);
    final payloadType = (header >> 2) & 0x0F;
    return MeshPacketInfo._(
      routeType: routeType,
      payloadType: payloadType,
      hopCount: hopCount,
      payload: payload,
      hash: _packetHash(payloadType, payload),
    );
  }

  static String _packetHash(int payloadType, Uint8List payload) {
    final input = Uint8List(1 + payload.length)
      ..[0] = payloadType
      ..setRange(1, payload.length + 1, payload);
    return crypto.sha256
        .convert(input)
        .bytes
        .sublist(0, 8)
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join();
  }
}

/// A MeshCore packet an internet observer heard on its radio and published
/// to MQTT. Everything here is untrusted input from the broker.
class MqttMeshPacket {
  MqttMeshPacket._({
    required this.raw,
    required this.routeType,
    required this.payloadType,
    required this.hopCount,
    required this.payload,
    required this.hash,
    required this.receivedAt,
    this.region,
    this.observerKey,
    this.observerName,
    this.snr,
    this.rssi,
  });

  /// The whole over-the-air packet.
  final Uint8List raw;
  final int routeType;
  final int payloadType;
  final int hopCount;
  final Uint8List payload;

  /// See [MeshPacketInfo.hash].
  final String hash;
  final DateTime receivedAt;
  final String? region;
  final String? observerKey;
  final String? observerName;
  final double? snr;
  final int? rssi;

  /// Parses one observer message, or returns null if it isn't a well-formed
  /// received MeshCore packet.
  static MqttMeshPacket? tryParse(
    String topic,
    List<int> payload, {
    DateTime? receivedAt,
  }) {
    if (payload.isEmpty || payload.length > mqttMeshPacketMaxPayloadBytes) {
      return null;
    }
    final Object? decoded;
    try {
      decoded = jsonDecode(utf8.decode(payload));
    } on FormatException {
      return null;
    }
    if (decoded is! Map<String, dynamic>) return null;
    if (decoded['type'] != 'PACKET') return null;
    final direction = decoded['direction'];
    if (direction != null && direction != 'rx') return null;
    final raw = _hexBytes(decoded['raw']);
    if (raw == null) return null;
    final info = MeshPacketInfo.tryParse(raw);
    if (info == null) return null;

    final segments = topic.split('/');
    final hasTopicIds = segments.length >= 4 && segments.last == 'packets';
    return MqttMeshPacket._(
      raw: raw,
      routeType: info.routeType,
      payloadType: info.payloadType,
      hopCount: info.hopCount,
      payload: info.payload,
      hash: info.hash,
      receivedAt: receivedAt ?? DateTime.now(),
      region: hasTopicIds ? segments[segments.length - 3] : null,
      observerKey: _limit(
        decoded['origin_id'] ??
            (hasTopicIds ? segments[segments.length - 2] : null),
        64,
      ),
      observerName: _limit(decoded['origin'], 32),
      snr: _number(decoded['SNR'])?.toDouble(),
      rssi: _number(decoded['RSSI'])?.round(),
    );
  }

  String get payloadTypeLabel => switch (payloadType) {
    0x00 => 'Request',
    0x01 => 'Response',
    0x02 => 'Direct message',
    0x03 => 'Ack',
    0x04 => 'Advert',
    0x05 => 'Channel message',
    0x06 => 'Channel data',
    0x07 => 'Anonymous request',
    0x08 => 'Path',
    0x09 => 'Trace',
    0x0A => 'Multipart',
    0x0B => 'Control',
    _ => 'Type $payloadType',
  };

  String get routeLabel => switch (routeType) {
    0 => 'Transport flood',
    1 => 'Flood',
    2 => 'Direct',
    _ => 'Transport direct',
  };

  static Uint8List? _hexBytes(Object? value) {
    if (value is! String || value.length.isOdd) return null;
    if (!RegExp(r'^[0-9A-Fa-f]*$').hasMatch(value)) return null;
    final out = Uint8List(value.length ~/ 2);
    for (var i = 0; i < out.length; i++) {
      out[i] = int.parse(value.substring(i * 2, i * 2 + 2), radix: 16);
    }
    return out;
  }

  static num? _number(Object? value) {
    if (value is num) return value.isFinite ? value : null;
    if (value is String) return num.tryParse(value);
    return null;
  }

  static String? _limit(Object? value, int maxLength) {
    if (value is! String || value.isEmpty) return null;
    return value.length > maxLength ? value.substring(0, maxLength) : value;
  }
}
