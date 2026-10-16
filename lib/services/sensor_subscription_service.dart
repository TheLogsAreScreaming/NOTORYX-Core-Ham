import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../helpers/cayenne_lpp.dart';
import '../models/contact.dart';
import '../models/sensor_subscription.dart';

/// A live subscription to one sensor's readings.
class SensorSubscription {
  final String contactKey;
  final String name;
  final int pushTag;
  final List<WatchedReading> readings;
  final DateTime expiresAt;
  final String scope;

  /// Pushes received, newest first (at most [SensorSubscriptionService.historyLimit]).
  final List<SensorReadingPush> pushes = [];

  SensorSubscription({
    required this.contactKey,
    required this.name,
    required this.pushTag,
    required this.readings,
    required this.expiresAt,
    required this.scope,
  });

  bool activeAt(DateTime now) => now.isBefore(expiresAt);
}

/// One push, as received and parsed.
class SensorReadingPush {
  final DateTime receivedAt;
  final DateTime sensorTime;

  /// [CayenneLpp.parse] output: channel, type and value per reading.
  final List<Map<String, dynamic>> readings;
  const SensorReadingPush(this.receivedAt, this.sensorTime, this.readings);
}

/// Asks sensors to push readings when they change (MeshCore sensor
/// REQ_TYPE_SUBSCRIBE), and collects the pushes for the rest of the app
/// session. The sensor must have logged us in with at least read access.
class SensorSubscriptionService extends ChangeNotifier {
  final MeshCoreConnector _connector;
  final Random _random;
  final Map<String, SensorSubscription> _subscriptions = {};
  StreamSubscription<Uint8List>? _frames;
  bool _disposed = false;

  static const historyLimit = 50;

  SensorSubscriptionService(this._connector, {Random? random})
    : _random = random ?? Random.secure() {
    _frames = _connector.receivedFrames.listen(_onFrame);
  }

  SensorSubscription? subscriptionFor(Contact contact) {
    final sub = _subscriptions[contact.publicKeyHex];
    if (sub == null) return null;
    return sub.activeAt(DateTime.now()) ? sub : null;
  }

  List<SensorSubscription> get active {
    final now = DateTime.now();
    return _subscriptions.values.where((s) => s.activeAt(now)).toList();
  }

  /// Subscribes to [readings] on [sensor] for [duration]. Returns the
  /// subscription, or throws [StateError] with the reason it was refused.
  Future<SensorSubscription> subscribe(
    Contact sensor, {
    required List<WatchedReading> readings,
    required Duration duration,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    var tag = 0;
    while (tag == 0) {
      tag = _random.nextInt(1 << 32);
    }
    final payload = buildSubscribePayload(
      pushTag: tag,
      duration: duration,
      readings: readings,
    );
    final reply = parseSubscribeReply(await _request(sensor, payload, timeout));
    if (!reply.accepted) {
      throw StateError(
        'The sensor refused. Log in with at least read access, and make sure it has a default region.',
      );
    }
    final sub = SensorSubscription(
      contactKey: sensor.publicKeyHex,
      name: sensor.name,
      pushTag: tag,
      readings: List.unmodifiable(readings),
      expiresAt: DateTime.now().add(Duration(seconds: reply.seconds)),
      scope: reply.scope,
    );
    _subscriptions[sensor.publicKeyHex] = sub;
    _notify();
    return sub;
  }

  /// Stops the sensor's pushes. The local subscription ends even if the
  /// sensor can't be reached; it would expire on its own anyway.
  Future<void> unsubscribe(
    Contact sensor, {
    Duration timeout = const Duration(seconds: 30),
  }) async {
    final removed = _subscriptions.remove(sensor.publicKeyHex);
    _notify();
    if (removed == null) return;
    await _request(sensor, buildUnsubscribePayload(), timeout);
  }

  void _onFrame(Uint8List frame) {
    if (frame.isEmpty || frame[0] != pushCodeBinaryResponse) return;
    final push = parseSensorPush(frame);
    if (push == null) return;
    for (final sub in _subscriptions.values) {
      if (sub.pushTag != push.tag) continue;
      sub.pushes.insert(
        0,
        SensorReadingPush(
          DateTime.now(),
          push.sensorTime,
          CayenneLpp.parse(push.lpp),
        ),
      );
      if (sub.pushes.length > historyLimit) sub.pushes.removeLast();
      _notify();
      return;
    }
  }

  /// Sends a binary request and returns the reply data after its tag.
  Future<Uint8List> _request(
    Contact node,
    Uint8List payload,
    Duration timeout,
  ) async {
    final reply = Completer<Uint8List>();
    Uint8List? tag;
    // Listen before sending: RESP_CODE_SENT carries the tag the reply uses.
    final sub = _connector.receivedFrames.listen((frame) {
      if (frame.length < 6 || reply.isCompleted) return;
      if (tag == null && frame[0] == respCodeSent) {
        tag = Uint8List.fromList(frame.sublist(2, 6));
      } else if (tag != null &&
          frame[0] == pushCodeBinaryResponse &&
          listEquals(frame.sublist(2, 6), tag)) {
        reply.complete(Uint8List.fromList(frame.sublist(6)));
      }
    });
    try {
      await _connector.sendFrame(
        buildSendBinaryReq(node.publicKey, payload: payload),
      );
      return await reply.future.timeout(timeout);
    } on TimeoutException {
      throw StateError('No answer from ${node.name}.');
    } finally {
      await sub.cancel();
    }
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _frames?.cancel();
    super.dispose();
  }
}
