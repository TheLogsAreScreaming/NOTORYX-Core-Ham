import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../connector/meshcore_connector.dart';
import '../helpers/path_helper.dart';
import '../models/channel_message.dart';
import '../models/direct_repeaters.dart';
import '../models/message.dart';
import '../models/radio_rx_packet.dart';
import '../models/timeline.dart';
import '../utils/app_logger.dart';
import 'waypoint_store.dart';

/// Keeps the timeline's own events for the connected radio: nodes heard
/// for the first time, direct signal changes and waypoints saved.
/// Messages aren't copied here; [loadMessages] reads them from history when the
/// timeline opens, so they stay wherever (and however encrypted) they are.
class TimelineService extends ChangeNotifier {
  TimelineService(
    this.connector, {
    required this.prefs,
    this.waypoints,
    DateTime Function()? clock,
  }) : _now = clock ?? DateTime.now {
    connector.addListener(_changed);
    waypoints?.addListener(_waypointsChanged);
    _rx = connector.rxPackets.listen(onPacket);
    _changed();
    _waypointsChanged();
  }

  final MeshCoreConnector connector;
  final SharedPreferences prefs;
  final WaypointStore? waypoints;
  final DateTime Function() _now;
  StreamSubscription<RadioRxPacket>? _rx;

  final List<TimelineEvent> _events = [];
  final Set<String> _knownNodes = {};
  Set<String>? _knownWaypoints;
  final _signals = SignalChangeTracker();
  String _scope = '';
  bool _primed = false;
  Timer? _saveTimer;

  static const maxEvents = 500;
  static String prefsKey(String scope) => 'timeline_v1_$scope';

  /// The timeline's own events, newest first.
  List<TimelineEvent> get events => List.unmodifiable(_events);

  void _add(TimelineEvent e) {
    _events.insert(0, e);
    if (_events.length > maxEvents) {
      _events.removeRange(maxEvents, _events.length);
    }
    _scheduleSave();
    notifyListeners();
  }

  void _changed() {
    final scope = connector.isConnected ? connector.selfPublicKeyHex : '';
    if (scope != _scope) {
      if (_saveTimer != null) unawaited(_save());
      _scope = scope;
      _events.clear();
      _knownNodes.clear();
      _primed = false;
      if (scope.isNotEmpty) _load();
      notifyListeners();
    }
    if (scope.isEmpty) return;
    if (!_primed) {
      if (connector.isLoadingContacts) return;
      // The first full list is the starting point, not news.
      _primed = true;
      final added = _knownNodes.length;
      _knownNodes.addAll(
        connector.allContactsUnfiltered.map((c) => c.publicKeyHex),
      );
      if (_knownNodes.length != added) _scheduleSave();
      return;
    }
    if (connector.isLoadingContacts) return;
    for (final c in connector.allContactsUnfiltered) {
      final key = c.publicKeyHex;
      if (key == _scope || !_knownNodes.add(key)) continue;
      _add(
        TimelineEvent(
          kind: TimelineKind.nodeJoined,
          at: _now(),
          subject: c.name,
          key: key,
        ),
      );
    }
  }

  void _waypointsChanged() {
    final store = waypoints;
    if (store == null) return;
    final ids = {for (final w in store.waypoints) w.id};
    final known = _knownWaypoints;
    _knownWaypoints = ids;
    if (known == null || _scope.isEmpty) return;
    for (final w in store.waypoints) {
      if (known.contains(w.id)) continue;
      _add(
        TimelineEvent(
          kind: TimelineKind.waypoint,
          at: _now(),
          subject: w.name,
          key: w.id,
        ),
      );
    }
  }

  /// Notes a direct signal change from a received packet.
  @visibleForTesting
  void onPacket(RadioRxPacket packet) {
    if (_scope.isEmpty || packet.fromSelf) return;
    final from = heardDirectlyFrom(packet.raw);
    if (from == null) return;
    final hop = PathHelper.formatHopHex(from);
    final change = _signals.observe(hop, packet.snr);
    if (change == null) return;
    final node = connector.allContactsUnfiltered
        .where(
          (c) =>
              c.publicKey.length >= from.length &&
              listEquals(c.publicKey.sublist(0, from.length), from),
        )
        .firstOrNull;
    _add(
      TimelineEvent(
        kind: TimelineKind.signalChange,
        at: packet.receivedAt,
        subject: node?.name ?? hop,
        key: node?.publicKeyHex ?? hop,
        fromSnr: change.from,
        toSnr: change.to,
      ),
    );
  }

  /// Up to [limit] recent messages from each conversation and channel, as
  /// timeline events. Messages with a shared place count as places.
  Future<List<TimelineEvent>> loadMessages({int limit = 100}) async {
    final out = <TimelineEvent>[];
    if (!connector.isConnected) return out;
    TimelineEvent fromMessage({
      required String sender,
      required String text,
      required DateTime at,
      required bool outgoing,
      required String where,
    }) => TimelineEvent(
      kind: hasSharedPlace(text) ? TimelineKind.waypoint : TimelineKind.message,
      at: at,
      subject: sender,
      detail: text,
      key: where,
      outgoing: outgoing,
    );
    final self = connector.selfName ?? '';
    for (final c in connector.contacts) {
      try {
        final List<Message> msgs = await connector.loadFullConversation(c);
        for (final m in msgs.reversed.take(limit)) {
          if (m.isCli) continue;
          out.add(
            fromMessage(
              sender: m.isOutgoing ? self : c.name,
              text: m.text,
              at: m.timestamp,
              outgoing: m.isOutgoing,
              where: c.name,
            ),
          );
        }
      } catch (e) {
        appLogger.warn('Timeline skipped a conversation: $e');
      }
    }
    for (final ch in connector.channels) {
      if (ch.name.isEmpty) continue;
      try {
        final List<ChannelMessage> msgs = await connector
            .loadFullChannelHistory(ch);
        for (final m in msgs.reversed.take(limit)) {
          out.add(
            fromMessage(
              sender: m.isOutgoing ? self : m.senderName,
              text: m.text,
              at: m.timestamp,
              outgoing: m.isOutgoing,
              where: ch.name,
            ),
          );
        }
      } catch (e) {
        appLogger.warn('Timeline skipped a channel: $e');
      }
    }
    out.sort((a, b) => b.at.compareTo(a.at));
    return out;
  }

  Future<void> clear() async {
    _events.clear();
    notifyListeners();
    await _save();
  }

  void _load() {
    try {
      final raw = prefs.getString(prefsKey(_scope));
      if (raw == null) return;
      final data = jsonDecode(raw) as Map;
      _knownNodes.addAll((data['known'] as List? ?? []).whereType<String>());
      for (final e in data['events'] as List? ?? []) {
        if (TimelineEvent.fromJson(e) case final ev?) _events.add(ev);
      }
      _primed = _knownNodes.isNotEmpty;
    } catch (e) {
      appLogger.warn('Cannot load timeline: $e');
    }
  }

  void _scheduleSave() {
    _saveTimer ??= Timer(const Duration(seconds: 10), () {
      _saveTimer = null;
      unawaited(_save());
    });
  }

  Future<void> _save() async {
    _saveTimer?.cancel();
    _saveTimer = null;
    if (_scope.isEmpty) return;
    await prefs.setString(
      prefsKey(_scope),
      jsonEncode({
        'known': _knownNodes.toList(),
        'events': [for (final e in _events) e.toJson()],
      }),
    );
  }

  @override
  void dispose() {
    if (_saveTimer != null) unawaited(_save());
    unawaited(_rx?.cancel());
    connector.removeListener(_changed);
    waypoints?.removeListener(_waypointsChanged);
    super.dispose();
  }
}
