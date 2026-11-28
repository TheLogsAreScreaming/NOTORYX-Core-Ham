import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';

import '../models/contact.dart';
import '../models/radio_rx_packet.dart';
import '../models/traffic_route.dart';
import 'rx_log_service.dart';

/// A route on screen and when its animation started.
@immutable
class ActiveTrafficRoute {
  const ActiveTrafficRoute(this.route, this.startedAt);

  final TrafficRoute route;
  final DateTime startedAt;
}

/// Feeds heard packets to the live Traffic map: keeps the latest route for
/// the card and plays at most [maxActive] routes at once, queueing the rest.
/// Lives only while Traffic mode is on; nothing is stored.
class TrafficFeed extends ChangeNotifier {
  TrafficFeed({
    Stream<RadioRxPacket>? packets,
    required this.contacts,
    required this.selfPosition,
    this.selfId,
    this.selfName,
    DateTime Function()? clock,
    this.maxActive = 3,
    this.maxQueued = 12,
  }) : _clock = clock ?? DateTime.now {
    _subscription = packets?.listen(add);
  }

  final List<Contact> Function() contacts;
  final LatLng? Function() selfPosition;
  final String? Function()? selfId;
  final String? Function()? selfName;
  final DateTime Function() _clock;
  final int maxActive;
  final int maxQueued;
  StreamSubscription<RadioRxPacket>? _subscription;

  final List<ActiveTrafficRoute> _active = [];
  final ListQueue<TrafficRoute> _queue = ListQueue();
  Set<TrafficKind> _kinds = TrafficKind.values.toSet();
  TrafficRoute? _latest;

  /// Whether the travelling dot is skipped (reduce motion is on).
  bool reduceMotion = false;

  /// Routes being drawn now, oldest first.
  List<ActiveTrafficRoute> get active => List.unmodifiable(_active);

  /// The newest route heard, shown on the card.
  TrafficRoute? get latest => _latest;

  /// Packet kinds shown.
  Set<TrafficKind> get kinds => Set.unmodifiable(_kinds);

  set kinds(Set<TrafficKind> value) {
    if (setEquals(value, _kinds)) return;
    _kinds = value.toSet();
    _active.removeWhere((a) => !_kinds.contains(a.route.kind));
    _queue.removeWhere((r) => !_kinds.contains(r.kind));
    if (_latest != null && !_kinds.contains(_latest!.kind)) _latest = null;
    notifyListeners();
  }

  /// Adds one heard packet. Our own traffic heard back is skipped.
  void add(RadioRxPacket packet) {
    if (packet.fromSelf) return;
    final entry = RxLogEntry.from(packet);
    if (entry == null) return;
    final route = TrafficRouteBuilder.build(
      entry,
      contacts: contacts(),
      selfPosition: selfPosition(),
      selfId: selfId?.call(),
      selfName: selfName?.call(),
    );
    if (route != null) addRoute(route);
  }

  /// Shows [route] on the card and plays it, or queues it while
  /// [maxActive] routes are already playing.
  @visibleForTesting
  void addRoute(TrafficRoute route) {
    if (!_kinds.contains(route.kind)) return;
    _latest = route;
    if (route.drawable) {
      if (_active.length < maxActive) {
        _active.add(ActiveTrafficRoute(route, _clock()));
      } else {
        _queue.addLast(route);
        while (_queue.length > maxQueued) {
          _queue.removeFirst();
        }
      }
    }
    notifyListeners();
  }

  /// Drops finished routes and starts queued ones. Returns whether anything
  /// is still on screen.
  bool tick() {
    final now = _clock();
    final before = _active.length;
    _active.removeWhere((a) {
      final legs = a.route.points.length - 1;
      return now.difference(a.startedAt) >=
          TrafficTiming.total(legs, reduceMotion: reduceMotion);
    });
    var changed = _active.length != before;
    while (_active.length < maxActive && _queue.isNotEmpty) {
      _active.add(ActiveTrafficRoute(_queue.removeFirst(), now));
      changed = true;
    }
    if (changed) notifyListeners();
    return _active.isNotEmpty;
  }

  /// The feed's clock, which the map layer animates by.
  DateTime get now => _clock();

  /// How many routes are waiting to play.
  int get queued => _queue.length;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
