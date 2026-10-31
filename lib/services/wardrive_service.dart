import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../models/wardrive.dart';
import 'coverage_hex_service.dart' show PositionFix, geolocatorFixes;
import '../storage/prefs_manager.dart';

/// Why the last ping wasn't sent, for the screen to word.
enum WardriveWait { none, noRadio, noPosition }

/// Drives a wardrive: every [interval] it sends a zero-hop discover request
/// from where you are and records which repeaters answered, how
/// well they heard us and how well we heard them. Nothing is posted to a
/// channel, and zero-hop packets aren't passed on, so it only uses airtime
/// where you are.
///
/// The position comes from the phone's GPS while a session runs. The radio
/// only reports its own position when the app connects, so on its own it
/// would pin every ping to the spot you started from. Its position is the
/// fallback when the phone has no fix.
class WardriveService extends ChangeNotifier {
  WardriveService(
    this.connector, {
    this.listenWindow = const Duration(seconds: 6),
    DateTime Function()? clock,
    math.Random? random,
    Stream<PositionFix> Function()? fixes,
  }) : _now = clock ?? DateTime.now,
       _random = random ?? math.Random(),
       _fixes = fixes ?? geolocatorFixes;

  final MeshCoreConnector connector;
  final Duration listenWindow;
  final DateTime Function() _now;
  final math.Random _random;
  final Stream<PositionFix> Function() _fixes;

  /// A phone fix older than this is not trusted for a ping.
  static const fixMaxAge = Duration(minutes: 2);

  static const _key = 'notoryx_wardrive_sessions_v1';
  static const maxSessions = 20;
  static const maxPings = 2000;

  /// Ping intervals to choose from, in seconds. 20 s is the floor: a busy
  /// mesh shouldn't be pinged faster than that.
  static const intervals = [20, 30, 60, 120];

  List<WardriveSession> _sessions = const [];
  WardriveSession? _active;
  Duration _interval = const Duration(seconds: 30);
  Timer? _timer;
  bool _pinging = false;
  WardriveWait _wait = WardriveWait.none;
  bool _disposed = false;
  StreamSubscription<PositionFix>? _fixSub;
  PositionFix? _fix;
  DateTime? _fixAt;

  /// Finished sessions, newest first.
  List<WardriveSession> get sessions => _sessions;
  WardriveSession? get active => _active;
  bool get running => _active != null;
  bool get pinging => _pinging;
  Duration get interval => _interval;
  WardriveWait get wait => _wait;

  /// Where you are now, for the map to follow: the phone's latest fix, or
  /// the radio's position. Null when neither is known.
  ({double lat, double lon})? get position {
    final fix = _fix, at = _fixAt;
    if (fix != null && at != null && _now().difference(at) <= fixMaxAge) {
      return (lat: fix.lat, lon: fix.lon);
    }
    final lat = connector.selfLatitude, lon = connector.selfLongitude;
    if (lat == null || lon == null || (lat == 0 && lon == 0)) return null;
    return (lat: lat, lon: lon);
  }

  void load() {
    try {
      final raw = PrefsManager.instance.getString(_key);
      if (raw == null) return;
      _sessions = [
        for (final s in jsonDecode(raw) as List)
          WardriveSession.fromJson(Map<String, dynamic>.from(s as Map)),
      ];
    } catch (_) {
      _sessions = const [];
    }
  }

  void setInterval(int seconds) {
    _interval = Duration(seconds: math.max(intervals.first, seconds));
    if (running) _schedule();
    _notify();
  }

  /// Starts a session and sends the first ping straight away.
  Future<void> start() async {
    if (running) return;
    _active = WardriveSession(
      id: '${_now().microsecondsSinceEpoch}',
      startedAt: _now(),
    );
    _watchPosition();
    _schedule();
    _notify();
    await pingNow();
  }

  /// Ends the session and keeps it in the history (if it has any pings).
  Future<void> stop() async {
    final session = _active;
    if (session == null) return;
    _timer?.cancel();
    _timer = null;
    _stopWatchingPosition();
    _active = null;
    _wait = WardriveWait.none;
    if (session.pings.isNotEmpty) {
      _sessions = [
        session.copyWith(endedAt: _now()),
        ..._sessions,
      ].take(maxSessions).toList();
      await _save();
    }
    _notify();
  }

  Future<void> deleteSession(String id) async {
    _sessions = _sessions.where((s) => s.id != id).toList();
    await _save();
    _notify();
  }

  void _watchPosition() {
    _fixSub?.cancel();
    try {
      _fixSub = _fixes().listen(
        (fix) {
          _fix = fix;
          _fixAt = _now();
          _notify();
        },
        // No permission or no GPS: the radio's position is used instead.
        onError: (Object _) {},
        cancelOnError: true,
      );
    } catch (_) {
      _fixSub = null;
    }
  }

  void _stopWatchingPosition() {
    unawaited(_fixSub?.cancel());
    _fixSub = null;
    _fix = null;
    _fixAt = null;
  }

  void _schedule() {
    _timer?.cancel();
    _timer = Timer.periodic(_interval, (_) => unawaited(pingNow()));
  }

  /// Sends one discover ping from where the radio is, if it can.
  @visibleForTesting
  Future<void> pingNow() async {
    if (_active == null || _pinging) return;
    if (!connector.isConnected) {
      _wait = WardriveWait.noRadio;
      _notify();
      return;
    }
    final here = position;
    if (here == null) {
      _wait = WardriveWait.noPosition;
      _notify();
      return;
    }
    _wait = WardriveWait.none;
    _pinging = true;
    _notify();
    final tag = _random.nextInt(0x7FFFFFFF);
    final at = _now();
    final replies = <String, WardriveReply>{};
    final sub = connector.receivedFrames.listen((frame) {
      final reply = parseDiscoverReply(frame, tag);
      if (reply != null) replies.putIfAbsent(reply.prefix, () => reply);
    });
    try {
      await connector.sendFrame(
        buildSendControlDataFrame(
          buildDiscoveryRequestPayload(tag, prefixOnly: true),
        ),
      );
      await Future<void>.delayed(listenWindow);
    } catch (_) {
      // A failed send still records the spot, as unheard.
    } finally {
      await sub.cancel();
      _pinging = false;
    }
    final session = _active;
    if (session == null || _disposed) return;
    final pings = [
      ...session.pings,
      WardrivePing(
        at: at,
        latitude: here.lat,
        longitude: here.lon,
        replies: replies.values.toList(),
      ),
    ];
    _active = session.copyWith(
      pings: pings.length > maxPings
          ? pings.sublist(pings.length - maxPings)
          : pings,
    );
    _notify();
  }

  Future<void> _save() async {
    await PrefsManager.instance.setString(
      _key,
      jsonEncode([for (final s in _sessions) s.toJson()]),
    );
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _timer?.cancel();
    _stopWatchingPosition();
    super.dispose();
  }
}
