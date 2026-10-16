import 'dart:typed_data';

import '../helpers/cayenne_lpp.dart';

/// MeshCore sensor request types (simple_sensor firmware).
const int reqTypeSubscribe = 0x08;
const int reqTypeUnsubscribe = 0x09;

/// The sensor keeps at most this many bytes of change thresholds.
const int maxMinDeltaBytes = 14;

/// The sensor stores the duration as 16-bit seconds.
const int maxSubscriptionSeconds = 0xFFFF;

/// Subscription lengths offered, in hours (18 h is the 16-bit maximum).
const subscriptionHours = [1, 6, 18];

/// How a reading type is encoded in LPP, for writing a change threshold.
class LppSpec {
  final String label;
  final String unit;
  final int size;
  final int multiplier;
  final bool signed;
  final double defaultDelta;
  const LppSpec(
    this.label,
    this.unit,
    this.size,
    this.multiplier,
    this.signed,
    this.defaultDelta,
  );
}

/// Reading types a subscription can watch, with sensible change thresholds.
const watchableTypes = <int, LppSpec>{
  CayenneLpp.lppTemperature: LppSpec('Temperature', '°C', 2, 10, true, 0.5),
  CayenneLpp.lppRelativeHumidity: LppSpec('Humidity', '%', 1, 2, false, 2),
  CayenneLpp.lppBarometricPressure: LppSpec('Pressure', 'hPa', 2, 10, false, 1),
  CayenneLpp.lppVoltage: LppSpec('Voltage', 'V', 2, 100, false, 0.1),
  CayenneLpp.lppCurrent: LppSpec('Current', 'A', 2, 1000, true, 0.05),
  CayenneLpp.lppLuminosity: LppSpec('Light', 'lux', 2, 1, false, 50),
  CayenneLpp.lppConcentration: LppSpec('Concentration', 'ppm', 2, 1, false, 50),
  CayenneLpp.lppPercentage: LppSpec('Percentage', '%', 1, 1, false, 5),
  CayenneLpp.lppAnalogInput: LppSpec('Analog input', '', 2, 100, true, 0.1),
  CayenneLpp.lppAltitude: LppSpec('Altitude', 'm', 2, 1, true, 10),
};

/// One reading to watch: a push is sent when it moves by more than [minDelta].
class WatchedReading {
  final int channel;
  final int type;
  final double minDelta;
  const WatchedReading(this.channel, this.type, this.minDelta);

  LppSpec get spec => watchableTypes[type]!;
  int get encodedSize => 2 + spec.size;

  @override
  bool operator ==(Object other) =>
      other is WatchedReading &&
      other.channel == channel &&
      other.type == type &&
      other.minDelta == minDelta;
  @override
  int get hashCode => Object.hash(channel, type, minDelta);
}

/// LPP-encoded thresholds: [channel][type][value, big-endian] per reading.
Uint8List encodeMinDeltas(List<WatchedReading> readings) {
  final out = BytesBuilder();
  for (final r in readings) {
    final spec = watchableTypes[r.type];
    if (spec == null) {
      throw ArgumentError('Reading type ${r.type} cannot be watched.');
    }
    final raw = (r.minDelta.abs() * spec.multiplier).round();
    final max = (1 << (spec.size * 8 - (spec.signed ? 1 : 0))) - 1;
    final v = raw.clamp(0, max);
    out.addByte(r.channel);
    out.addByte(r.type);
    for (var i = spec.size - 1; i >= 0; i--) {
      out.addByte((v >> (8 * i)) & 0xFF);
    }
  }
  final bytes = out.toBytes();
  if (bytes.length < 3) {
    throw ArgumentError('Choose at least one reading to watch.');
  }
  if (bytes.length > maxMinDeltaBytes) {
    throw ArgumentError('Too many readings: the sensor keeps 14 bytes.');
  }
  return bytes;
}

/// Payload after the request type byte is prepended by [buildSubscribePayload].
Uint8List buildSubscribePayload({
  required int pushTag,
  required Duration duration,
  required List<WatchedReading> readings,
}) {
  final deltas = encodeMinDeltas(readings);
  final secs = duration.inSeconds.clamp(1, maxSubscriptionSeconds);
  final data = ByteData(9 + deltas.length);
  data.setUint8(0, reqTypeSubscribe);
  data.setUint32(1, pushTag, Endian.little);
  data.setUint16(5, secs, Endian.little);
  data.setUint8(7, 0); // reserved
  data.setUint8(8, deltas.length);
  final bytes = data.buffer.asUint8List();
  bytes.setRange(9, 9 + deltas.length, deltas);
  return bytes;
}

Uint8List buildUnsubscribePayload() => Uint8List.fromList([reqTypeUnsubscribe]);

/// The sensor's answer to a subscribe: how long it agreed to push for, and
/// which region scope it will push in. Zero seconds means it refused.
class SubscribeReply {
  final int seconds;
  final String scope;
  const SubscribeReply(this.seconds, this.scope);
  bool get accepted => seconds > 0;
}

/// Parses the reply data after the 4-byte request tag.
SubscribeReply parseSubscribeReply(Uint8List data) {
  if (data.length < 4) return const SubscribeReply(0, '');
  final secs = data[0] | (data[1] << 8);
  final nameBytes = data.length > 4 ? data.sublist(4) : Uint8List(0);
  final end = nameBytes.indexOf(0);
  final scope = String.fromCharCodes(
    end < 0 ? nameBytes : nameBytes.sublist(0, end),
  );
  return SubscribeReply(secs, scope);
}

/// A telemetry push: our companion forwards it as PUSH_CODE_BINARY_RESPONSE
/// carrying the subscription's push tag, the sensor time, then LPP data.
class SensorPush {
  final int tag;
  final DateTime sensorTime;
  final Uint8List lpp;
  const SensorPush(this.tag, this.sensorTime, this.lpp);
}

/// Parses a PUSH_CODE_BINARY_RESPONSE frame as a push, or null if too short.
SensorPush? parseSensorPush(Uint8List frame) {
  if (frame.length < 10) return null;
  final data = ByteData.sublistView(frame);
  final tag = data.getUint32(2, Endian.little);
  final secs = data.getUint32(6, Endian.little);
  return SensorPush(
    tag,
    DateTime.fromMillisecondsSinceEpoch(secs * 1000, isUtc: true),
    Uint8List.fromList(frame.sublist(10)),
  );
}
