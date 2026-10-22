import 'dart:convert';
import 'dart:typed_data';

/// Observer presence reported on the `status` topic.
enum MqttObserverPresence { online, offline }

/// What the radio reports about itself in observer status messages. Unknown
/// values are sent as `unknown`, as meshcoretomqtt does.
class MqttObserverDetails {
  const MqttObserverDetails({this.radio, this.model, this.firmwareVersion});

  /// Radio settings as `freq MHz,bandwidth kHz,SF,CR`, the shape of the
  /// MeshCore CLI's `get radio` reply.
  final String? radio;
  final String? model;
  final String? firmwareVersion;

  /// Formats LoRa settings like `get radio`, or null if any is missing.
  static String? radioFrom({int? freqHz, int? bwHz, int? sf, int? cr}) {
    if (freqHz == null || bwHz == null || sf == null || cr == null) {
      return null;
    }
    String trim(double value) => value
        .toStringAsFixed(3)
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
    return '${trim(freqHz / 1e6)},${trim(bwHz / 1e3)},$sf,$cr';
  }

  @override
  bool operator ==(Object other) =>
      other is MqttObserverDetails &&
      other.radio == radio &&
      other.model == model &&
      other.firmwareVersion == firmwareVersion;

  @override
  int get hashCode => Object.hash(radio, model, firmwareVersion);
}

/// Encodes an observer status message in the meshcoretomqtt format
/// (`build_status_message`): published retained as `online` after connecting
/// and set as the retained `offline` last will. Device stats are left out.
Uint8List encodeObserverStatus(
  MqttObserverPresence presence, {
  required DateTime at,
  required String origin,
  required String originId,
  required String clientVersion,
  MqttObserverDetails details = const MqttObserverDetails(),
}) {
  return Uint8List.fromList(
    utf8.encode(
      jsonEncode({
        'status': presence.name,
        'timestamp': at.toUtc().toIso8601String(),
        'origin': origin,
        'origin_id': originId,
        'radio': details.radio ?? 'unknown',
        'model': details.model ?? 'unknown',
        'firmware_version': details.firmwareVersion ?? 'unknown',
        'client_version': clientVersion,
      }),
    ),
  );
}
