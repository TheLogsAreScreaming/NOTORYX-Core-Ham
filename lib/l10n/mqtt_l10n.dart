import '../models/mqtt_broker_presets.dart';
import '../models/mqtt_connection_status.dart';
import '../models/mqtt_notice.dart';
import 'app_localizations.dart';

/// Localized text for MQTT values that models keep language-neutral.
extension MqttLocalizations on AppLocalizations {
  String mqttNotice(MqttNotice notice) => switch (notice.kind) {
    MqttNoticeKind.invalidHost => mqtt_noticeInvalidHost,
    MqttNoticeKind.invalidPort => mqtt_noticeInvalidPort,
    MqttNoticeKind.invalidWebSocketPath => mqtt_noticeInvalidWebSocketPath,
    MqttNoticeKind.invalidTopicPrefix => mqtt_noticeInvalidTopicPrefix,
    MqttNoticeKind.invalidRegion => mqtt_noticeInvalidRegion,
    MqttNoticeKind.tlsRequired => mqtt_noticeTlsRequired,
    MqttNoticeKind.cleartextLocalOnly => mqtt_noticeCleartextLocalOnly,
    MqttNoticeKind.regionNeededToShare => mqtt_noticeRegionNeededToShare,
    MqttNoticeKind.passwordNeeded => mqtt_noticePasswordNeeded(
      notice.detail ?? '',
    ),
    MqttNoticeKind.noNetwork => mqtt_noticeNoNetwork,
    MqttNoticeKind.subscriptionRefused => mqtt_noticeSubscriptionRefused,
    MqttNoticeKind.badCredentials => mqtt_noticeBadCredentials,
    MqttNoticeKind.notAuthorized => mqtt_noticeNotAuthorized,
    MqttNoticeKind.connectionRefused => mqtt_noticeConnectionRefused,
    MqttNoticeKind.unreachable => mqtt_noticeUnreachable,
    MqttNoticeKind.tlsFailed => mqtt_noticeTlsFailed,
    MqttNoticeKind.webSocketOnly => mqtt_noticeWebSocketOnly,
    MqttNoticeKind.radioNotConnected => mqtt_noticeRadioNotConnected,
    MqttNoticeKind.signingUnsupported => mqtt_noticeSigningUnsupported,
    MqttNoticeKind.signingTimeout => mqtt_noticeSigningTimeout,
    MqttNoticeKind.signingTooLong => mqtt_noticeSigningTooLong,
    MqttNoticeKind.signingRejected => mqtt_noticeSigningRejected,
  };

  String mqttStatus(MqttConnectionStatus status) => switch (status) {
    MqttConnectionStatus.notConfigured => mqtt_statusNotConfigured,
    MqttConnectionStatus.disconnected => mqtt_statusDisconnected,
    MqttConnectionStatus.connecting => mqtt_statusConnecting,
    MqttConnectionStatus.connected => mqtt_statusConnected,
    MqttConnectionStatus.reconnecting => mqtt_statusReconnecting,
    MqttConnectionStatus.error => mqtt_statusError,
  };

  /// Name of a MeshCore payload type (header bits 2–5).
  String mqttPacketType(int payloadType) => switch (payloadType) {
    0x00 => mqtt_packetRequest,
    0x01 => mqtt_packetResponse,
    0x02 => mqtt_packetDirectMessage,
    0x03 => mqtt_packetAck,
    0x04 => mqtt_packetAdvert,
    0x05 => mqtt_packetChannelMessage,
    0x06 => mqtt_packetChannelData,
    0x07 => mqtt_packetAnonymousRequest,
    0x08 => mqtt_packetPath,
    0x09 => mqtt_packetTrace,
    0x0A => mqtt_packetMultipart,
    0x0B => mqtt_packetControl,
    _ => mqtt_packetType(payloadType),
  };

  /// Name of a MeshCore route type (header bits 0–1).
  String mqttRoute(int routeType) => switch (routeType) {
    0 => mqtt_routeTransportFlood,
    1 => mqtt_routeFlood,
    2 => mqtt_routeDirect,
    _ => mqtt_routeTransportDirect,
  };

  String mqttPresetName(MqttBrokerPreset preset) {
    if (identical(preset, MqttBrokerPresets.custom)) return mqtt_presetCustom;
    if (identical(preset, MqttBrokerPresets.local)) return mqtt_presetLocal;
    if (identical(preset, MqttBrokerPresets.letsMeshUs)) {
      return mqtt_presetLetsMeshUs;
    }
    if (identical(preset, MqttBrokerPresets.letsMeshEu)) {
      return mqtt_presetLetsMeshEu;
    }
    return preset.name;
  }

  String? mqttPresetNote(MqttBrokerPreset preset) =>
      preset.note == null ? null : mqtt_presetLetsMeshNote;
}
