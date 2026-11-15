import 'package:geolocator/geolocator.dart';

/// One phone GPS reading.
typedef PhoneFix = ({
  double lat,
  double lon,
  double accuracyMeters,
  DateTime time,
});

/// Phone GPS helpers for screens that can use the phone's own position;
/// callers fall back to the radio's position when it's unavailable.
PhoneFix _fix(Position p) => (
  lat: p.latitude,
  lon: p.longitude,
  accuracyMeters: p.accuracy,
  time: p.timestamp,
);

/// Asks for permission if needed; null without permission.
Future<PhoneFix?> askForPhoneFix() async {
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    return null;
  }
  final p =
      await Geolocator.getLastKnownPosition() ??
      await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          timeLimit: Duration(seconds: 10),
        ),
      );
  return _fix(p);
}

/// A high-accuracy fix, reusing one under [maxAge] old. Throws without GPS.
Future<PhoneFix> freshPhoneFix(DateTime now, Duration maxAge) async {
  final last = await Geolocator.getLastKnownPosition();
  if (last != null && now.difference(last.timestamp) < maxAge) {
    return _fix(last);
  }
  return _fix(
    await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 8),
      ),
    ),
  );
}

/// High-accuracy fixes every 20 m. Throws without permission.
Stream<PhoneFix> phoneFixStream() async* {
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    throw StateError('Location permission was not granted.');
  }
  yield* Geolocator.getPositionStream(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 20,
    ),
  ).map(_fix);
}

/// The last known fix, only if permission was already granted; never asks.
Future<PhoneFix?> lastKnownPhoneFix() async {
  final permission = await Geolocator.checkPermission();
  if (permission != LocationPermission.whileInUse &&
      permission != LocationPermission.always) {
    return null;
  }
  final p = await Geolocator.getLastKnownPosition();
  return p == null ? null : _fix(p);
}
