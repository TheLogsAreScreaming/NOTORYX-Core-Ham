import 'node_telemetry_store.dart';
import 'dart:async';

import 'package:flutter/foundation.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../helpers/cayenne_lpp.dart';

/// The connected radio's own sensors: battery voltage, temperatures, GPS,
/// light and anything else wired to it. A telemetry request with no contact
/// key asks the radio about itself, and it answers with its own key.
class MySensorsService extends ChangeNotifier {
  MySensorsService(
    this.connector, {
    this.timeout = const Duration(seconds: 8),
    DateTime Function()? clock,
  }) : _now = clock ?? DateTime.now;

  final MeshCoreConnector connector;
  final Duration timeout;
  final DateTime Function() _now;

  List<Map<String, dynamic>> _readings = const [];
  DateTime? _updated;
  bool _loading = false;
  bool _failed = false;
  bool _disposed = false;

  /// Decoded Cayenne LPP readings, `{channel, type, value}` each.
  List<Map<String, dynamic>> get readings => _readings;
  DateTime? get updated => _updated;
  bool get loading => _loading;

  /// The last request got no answer (no radio, or it timed out).
  bool get failed => _failed;

  Future<void> refresh() async {
    if (_loading) return;
    final self = connector.selfPublicKey;
    if (!connector.isConnected || self == null || self.length < 6) {
      _failed = true;
      _notify();
      return;
    }
    final scope = connector.selfPublicKeyHex;
    _loading = true;
    _failed = false;
    _notify();
    final reply = Completer<Uint8List>();
    final sub = connector.receivedFrames.listen((frame) {
      // [code][reserved][key prefix 6][LPP...]
      if (frame.length < 8 || frame[0] != pushCodeTelemetryResponse) return;
      if (!listEquals(frame.sublist(2, 8), self.sublist(0, 6))) return;
      if (!reply.isCompleted) reply.complete(frame.sublist(8));
    });
    try {
      await connector.sendFrame(buildSendTelemetryReq(null));
      final lpp = await reply.future.timeout(timeout);
      _readings = CayenneLpp.parse(lpp);
      _updated = _now();
      if (connector.selfPublicKeyHex == scope &&
          connector.telemetryStore?.scope == scope) {
        connector.telemetryStore?.record(
          scope,
          _readings,
          source: TelemetrySource.self,
          at: _updated,
        );
      }
    } catch (_) {
      _failed = true;
    } finally {
      await sub.cancel();
      _loading = false;
      _notify();
    }
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

/// A reading as short text, like "4.19 V" or "41.328, -73.094", or null for
/// kinds the panel doesn't show. [imperial] shows temperature in °F,
/// altitude in feet and pressure in inHg.
String? formatSensorReading(
  Map<String, dynamic> reading, {
  bool imperial = false,
}) {
  final value = reading['value'];
  String n(num v, int digits) => v.toStringAsFixed(digits);
  String alt(num m) => imperial ? '${n(m * 3.28084, 0)}ft' : '${n(m, 0)}m';
  switch (reading['type']) {
    case CayenneLpp.lppVoltage:
      return '${n(value as num, 2)} V';
    case CayenneLpp.lppTemperature:
      final c = value as num;
      return imperial ? '${n(c * 9 / 5 + 32, 1)} °F' : '${n(c, 1)} °C';
    case CayenneLpp.lppLuminosity:
      return '$value lx';
    case CayenneLpp.lppRelativeHumidity:
      return '${n(value as num, 0)} %RH';
    case CayenneLpp.lppBarometricPressure:
      final hpa = value as num;
      return imperial ? '${n(hpa * 0.02953, 2)} inHg' : '${n(hpa, 1)} hPa';
    case CayenneLpp.lppPercentage:
      return '$value %';
    case CayenneLpp.lppAltitude:
      final m = value as num;
      return imperial ? '${n(m * 3.28084, 0)} ft' : '${n(m, 0)} m';
    case CayenneLpp.lppCurrent:
      return '${n(value as num, 3)} A';
    case CayenneLpp.lppPower:
      return '$value W';
    case CayenneLpp.lppConcentration:
      return '$value ppm';
    case CayenneLpp.lppGps:
      final gps = value as Map;
      final lat = gps['latitude'] as num, lon = gps['longitude'] as num;
      if (lat == 0 && lon == 0) return null;
      return '${n(lat, 3)}, ${n(lon, 3)} @${alt(gps['altitude'] as num)}';
  }
  return null;
}
