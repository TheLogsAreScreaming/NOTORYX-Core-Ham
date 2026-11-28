import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// One compass reading: which way the top of the screen faces.
class CompassReading {
  /// Degrees clockwise from magnetic north, 0–360.
  final double magneticHeading;

  /// 0 unreliable, 1 low, 2 medium, 3 high (Android's sensor status).
  final int accuracy;

  const CompassReading({required this.magneticHeading, required this.accuracy});

  /// Whether the compass needs calibrating before it can be trusted.
  bool get needsCalibration => accuracy <= 1;
}

/// The phone's compass. Only Android has it for now; elsewhere [readings]
/// ends with an error straight away and callers fall back to a north-up
/// arrow.
class DeviceCompass {
  static const _events = EventChannel('notoryx/compass');
  static const _methods = MethodChannel('notoryx/compass_methods');

  const DeviceCompass();

  /// Live readings, about 20 a second, while listened to.
  Stream<CompassReading> readings() {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      return Stream<CompassReading>.error(
        UnsupportedError('No compass on this platform.'),
      );
    }
    return _events.receiveBroadcastStream().map((event) {
      final map = Map<Object?, Object?>.from(event as Map);
      return CompassReading(
        magneticHeading: (map['heading'] as num).toDouble(),
        accuracy: (map['accuracy'] as num?)?.toInt() ?? 2,
      );
    });
  }

  /// Degrees to add to a magnetic heading to get true north at a place,
  /// or null if the platform can't tell.
  Future<double?> declination(double lat, double lon, {double alt = 0}) async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return null;
    try {
      final value = await _methods.invokeMethod<double>('declination', {
        'lat': lat,
        'lon': lon,
        'alt': alt,
      });
      return value;
    } on PlatformException catch (e, st) {
      debugPrint('Compass declination failed: $e\n$st');
      return null;
    } on MissingPluginException {
      return null;
    }
  }
}

/// Wraps [degrees] into 0–360.
double normalizeDegrees(double degrees) {
  final d = degrees % 360;
  return d < 0 ? d + 360 : d;
}

/// How far to turn from [heading] to face [bearing], in −180…180:
/// negative is left, positive is right.
double turnAngle({required double bearing, required double heading}) {
  final d = normalizeDegrees(bearing - heading);
  return d > 180 ? d - 360 : d;
}

/// Moves [previous] a fraction [alpha] of the way to [next] the short way
/// round the circle, so the arrow doesn't spin through 359° → 0°.
double smoothHeading(double? previous, double next, {double alpha = 0.25}) {
  if (previous == null) return normalizeDegrees(next);
  final delta = turnAngle(bearing: next, heading: previous);
  return normalizeDegrees(previous + delta * alpha);
}

/// Within this many degrees either side, the node counts as straight ahead.
const double onTargetDegrees = 10;
