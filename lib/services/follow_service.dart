import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../helpers/cayenne_lpp.dart';
import '../models/contact.dart';

/// Where a followed contact was, and how we learned it.
@immutable
class FollowPoint {
  const FollowPoint({
    required this.at,
    required this.lat,
    required this.lon,
    required this.fromRequest,
  });

  final DateTime at;
  final double lat;
  final double lon;

  /// True when it came from a position request, false from an advert.
  final bool fromRequest;
}

/// Follows one contact that shares its position for a short while: asks it
/// for its position every few minutes, also takes positions from its
/// adverts, and keeps the trail. Stops by itself after [length].
///
/// Only one contact is followed at a time; the trail lives in memory and
/// is dropped when following stops.
class FollowService extends ChangeNotifier {
  FollowService(
    this.connector, {
    DateTime Function()? clock,
    this.length = const Duration(minutes: 15),
    this.askEvery = const Duration(minutes: 3),
  }) : _now = clock ?? DateTime.now;

  final MeshCoreConnector connector;
  final DateTime Function() _now;

  /// How long following lasts.
  final Duration length;

  /// How often the contact is asked for its position.
  final Duration askEvery;

  /// Points closer than this to the last one only refresh its time.
  static const minMoveMetres = 5.0;

  String? _key;
  String _name = '';
  DateTime? _startedAt;
  final List<FollowPoint> _trail = [];
  int _asked = 0;
  int _answered = 0;
  DateTime? _lastAskAt;
  Timer? _askTimer;
  Timer? _endTimer;
  StreamSubscription<Uint8List>? _frames;
  bool _disposed = false;

  /// The followed contact's public key, or null when not following.
  String? get contactKey => _key;
  String get contactName => _name;
  bool get active => _key != null;
  DateTime? get startedAt => _startedAt;
  DateTime? get endsAt => _startedAt?.add(length);
  DateTime? get lastAskAt => _lastAskAt;
  int get asked => _asked;
  int get answered => _answered;
  List<FollowPoint> get trail => List.unmodifiable(_trail);
  DateTime get now => _now();

  /// Time left, or zero when not following.
  Duration get remaining {
    final end = endsAt;
    if (end == null) return Duration.zero;
    final left = end.difference(now);
    return left.isNegative ? Duration.zero : left;
  }

  bool isFollowing(String key) => _key == key.toLowerCase();

  /// Starts following [contact] (stops any other first).
  void start(Contact contact) {
    stop(notify: false);
    _key = contact.publicKeyHex.toLowerCase();
    _name = contact.name;
    _startedAt = now;
    if (contact.hasLocation) {
      _add(contact.latitude!, contact.longitude!, fromRequest: false);
    }
    _frames = connector.receivedFrames.listen(_onFrame);
    connector.addListener(_onContacts);
    _endTimer = Timer(length, stop);
    _askTimer = Timer.periodic(askEvery, (_) => unawaited(askNow()));
    notifyListeners();
    unawaited(askNow());
  }

  /// Stops following and forgets the trail.
  void stop({bool notify = true}) {
    if (_key == null) return;
    _askTimer?.cancel();
    _endTimer?.cancel();
    unawaited(_frames?.cancel());
    _frames = null;
    connector.removeListener(_onContacts);
    _key = null;
    _name = '';
    _startedAt = null;
    _lastAskAt = null;
    _asked = 0;
    _answered = 0;
    _trail.clear();
    if (notify && !_disposed) notifyListeners();
  }

  /// Asks the contact for its position now.
  Future<void> askNow() async {
    final contact = _contact();
    if (contact == null || !connector.isConnected) return;
    if (remaining == Duration.zero) {
      stop();
      return;
    }
    _asked++;
    _lastAskAt = now;
    notifyListeners();
    try {
      await connector.sendFrame(buildSendTelemetryReq(contact.publicKey));
    } catch (_) {
      // The next ask tries again.
    }
  }

  Contact? _contact() {
    final key = _key;
    if (key == null) return null;
    for (final c in connector.allContactsUnfiltered) {
      if (c.publicKeyHex.toLowerCase() == key) return c;
    }
    return null;
  }

  void _onContacts() {
    final c = _contact();
    if (c == null || !c.hasLocation) return;
    final last = _trail.isEmpty ? null : _trail.last;
    if (last != null && last.lat == c.latitude && last.lon == c.longitude) {
      return;
    }
    _add(c.latitude!, c.longitude!, fromRequest: false);
    notifyListeners();
  }

  void _onFrame(Uint8List frame) {
    // [code][reserved][key prefix 6][LPP...]
    if (frame.length < 8 || frame[0] != pushCodeTelemetryResponse) return;
    final key = _key;
    if (key == null) return;
    if (pubKeyToHex(frame.sublist(2, 8)).toLowerCase() !=
        key.substring(0, 12)) {
      return;
    }
    final fix = gpsFromLpp(frame.sublist(8));
    _answered++;
    if (fix != null) _add(fix.lat, fix.lon, fromRequest: true);
    notifyListeners();
  }

  void _add(double lat, double lon, {required bool fromRequest}) {
    if (lat == 0 && lon == 0) return;
    final point = FollowPoint(
      at: now,
      lat: lat,
      lon: lon,
      fromRequest: fromRequest,
    );
    if (_trail.isNotEmpty &&
        distanceMetres(
              (lat: _trail.last.lat, lon: _trail.last.lon),
              (lat: lat, lon: lon),
            ) <
            minMoveMetres) {
      _trail[_trail.length - 1] = point;
      return;
    }
    _trail.add(point);
  }

  @visibleForTesting
  void handleFrameForTest(Uint8List frame) => _onFrame(frame);

  @override
  void dispose() {
    stop(notify: false);
    _disposed = true;
    super.dispose();
  }
}

/// The first GPS reading in a Cayenne LPP payload, if any.
({double lat, double lon})? gpsFromLpp(Uint8List lpp) {
  try {
    for (final r in CayenneLpp.parse(lpp)) {
      if (r['type'] != CayenneLpp.lppGps) continue;
      final v = r['value'];
      if (v is! Map) continue;
      final lat = v['latitude'], lon = v['longitude'];
      if (lat is num && lon is num && (lat != 0 || lon != 0)) {
        return (lat: lat.toDouble(), lon: lon.toDouble());
      }
    }
  } catch (_) {}
  return null;
}

/// Great-circle distance in metres.
double distanceMetres(
  ({double lat, double lon}) a,
  ({double lat, double lon}) b,
) {
  const r = 6371000.0;
  double rad(double d) => d * math.pi / 180;
  final dLat = rad(b.lat - a.lat), dLon = rad(b.lon - a.lon);
  final h =
      math.pow(math.sin(dLat / 2), 2) +
      math.cos(rad(a.lat)) *
          math.cos(rad(b.lat)) *
          math.pow(math.sin(dLon / 2), 2);
  return 2 * r * math.asin(math.min(1, math.sqrt(h)));
}
