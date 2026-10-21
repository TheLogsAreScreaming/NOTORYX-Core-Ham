import 'dart:convert';
import 'dart:typed_data';

import 'mqtt_mesh_packet.dart';
import 'radio_rx_packet.dart';

/// What the user agreed to share as an MQTT observer. Everything is off
/// until they turn it on.
class MqttPublishSettings {
  const MqttPublishSettings({
    this.enabled = false,
    this.includeDirectTraffic = false,
    this.includeOwnTraffic = false,
  });

  /// Share packets this radio hears.
  final bool enabled;

  /// Also share requests, responses, direct messages and paths. Their
  /// contents stay encrypted, but they show which nodes talk to each other.
  final bool includeDirectTraffic;

  /// Also share this radio's own adverts and messages.
  final bool includeOwnTraffic;
}

/// Why a heard packet was not published.
enum MqttPublishSkip {
  disabled,
  notConnected,
  noTopic,
  invalid,
  privateType,
  directTraffic,
  ownTraffic,
  alreadyShared,
  rateLimited,
}

/// Decides which heard packets may be shared. Pure, so it can be tested
/// without a broker.
class MqttPublishPolicy {
  const MqttPublishPolicy();

  /// Payload types shared by default: adverts, channel traffic, acks, traces,
  /// multipart wrappers and control packets.
  static const sharedTypes = {0x03, 0x04, 0x05, 0x06, 0x09, 0x0A, 0x0B};

  /// Addressed traffic, shared only with [MqttPublishSettings.includeDirectTraffic].
  static const directTypes = {0x00, 0x01, 0x02, 0x07, 0x08};

  MqttPublishSkip? check(
    MeshPacketInfo info, {
    required bool fromSelf,
    required MqttPublishSettings settings,
  }) {
    if (!settings.enabled) return MqttPublishSkip.disabled;
    if (fromSelf && !settings.includeOwnTraffic) {
      return MqttPublishSkip.ownTraffic;
    }
    if (directTypes.contains(info.payloadType)) {
      return settings.includeDirectTraffic
          ? null
          : MqttPublishSkip.directTraffic;
    }
    // Custom (0x0F) and unassigned types are never shared.
    if (!sharedTypes.contains(info.payloadType)) {
      return MqttPublishSkip.privateType;
    }
    return null;
  }
}

/// Encodes a heard packet in the meshcoretomqtt observer `packets` format,
/// so existing analyzers and this app's own subscriber can read it.
Uint8List encodeObserverPacket(
  RadioRxPacket packet,
  MeshPacketInfo info, {
  required String origin,
  required String originId,
}) {
  final at = packet.receivedAt.toUtc();
  String two(int value) => value.toString().padLeft(2, '0');
  return Uint8List.fromList(
    utf8.encode(
      jsonEncode({
        'origin': origin,
        'origin_id': originId,
        'timestamp': at.toIso8601String(),
        'type': 'PACKET',
        'direction': 'rx',
        'time': '${two(at.hour)}:${two(at.minute)}:${two(at.second)}',
        'date': '${at.day}/${at.month}/${at.year}',
        'len': '${packet.raw.length}',
        'packet_type': '${info.payloadType}',
        'route': info.isDirect ? 'D' : 'F',
        'payload_len': '${info.payload.length}',
        'raw': packet.raw
            .map((b) => b.toRadixString(16).padLeft(2, '0'))
            .join()
            .toUpperCase(),
        'SNR': '${packet.snr.round()}',
        'RSSI': '${packet.rssi}',
        'hash': info.hash.toUpperCase(),
      }),
    ),
  );
}
