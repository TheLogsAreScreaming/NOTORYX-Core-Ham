import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../models/route_choice.dart';
import '../storage/prefs_manager.dart';
import 'trace_pinger.dart';

/// Remembers how well radio links work, from out-and-back traces along
/// routes, and runs those traces.
class RouteLinkService {
  RouteLinkService(
    this.connector, {
    DateTime Function()? clock,
    math.Random? random,
  }) : _now = clock ?? DateTime.now,
       _random = random ?? math.Random() {
    _load();
  }

  static const _key = 'route_links_v1';
  static const keep = Duration(days: 30);
  static const maxLinks = 400;

  final MeshCoreConnector connector;
  final DateTime Function() _now;
  final math.Random _random;
  final Map<String, RouteLink> _links = {};

  Map<String, RouteLink> get links => Map.unmodifiable(_links);

  /// The trace flag for [width]-byte hops, or null when traces can't use
  /// that width.
  static int? traceFlag(int width) => switch (width) {
    1 => 0,
    2 => 1,
    4 => 2,
    _ => null,
  };

  /// Traces out along [path] and back. Returns false when no answer came.
  Future<bool> measure(List<int> path, int width, {Duration? timeout}) async {
    final flag = traceFlag(width);
    if (flag == null || path.isEmpty || !connector.isConnected) return false;
    final hops = path.length ~/ width;
    final tagValue = _random.nextInt(1 << 31);
    final tag = Uint8List(4)
      ..buffer.asByteData().setUint32(0, tagValue, Endian.little);
    final reply = Completer<List<double>>();
    final sub = connector.receivedFrames.listen((frame) {
      final snrs = parseTraceSnrs(frame, tag);
      if (snrs != null && !reply.isCompleted) reply.complete(snrs);
    });
    try {
      await connector.sendFrame(
        buildTraceReq(
          tagValue,
          0,
          flag,
          payload: Uint8List.fromList(roundTripTracePath(path, width)),
        ),
      );
      final snrs = await reply.future.timeout(
        timeout ?? Duration(seconds: 5 + 3 * hops),
      );
      final ids = [
        for (var i = 0; i < hops; i++)
          path
              .sublist(i * width, (i + 1) * width)
              .map((b) => b.toRadixString(16).padLeft(2, '0').toUpperCase())
              .join(),
      ];
      final measured = linksFromRoundTrip(ids, snrs, _now());
      if (measured.isEmpty) return false;
      for (final m in measured) {
        _links[routeLinkKey(m.from, m.to)] = m.link;
      }
      await _save();
      return true;
    } on TimeoutException {
      return false;
    } finally {
      await sub.cancel();
    }
  }

  void _load() {
    try {
      final raw = PrefsManager.instance.getString(_key);
      if (raw == null) return;
      final map = jsonDecode(raw) as Map<String, dynamic>;
      for (final e in map.entries) {
        _links[e.key] = RouteLink.fromJson(e.value as Map<String, dynamic>);
      }
    } on StateError {
      // Storage not ready.
    } on FormatException {
      // Unreadable; start over.
    }
  }

  Future<void> _save() async {
    final now = _now();
    _links.removeWhere((_, l) => now.difference(l.at) > keep);
    if (_links.length > maxLinks) {
      final oldest = _links.entries.toList()
        ..sort((a, b) => a.value.at.compareTo(b.value.at));
      for (final e in oldest.take(_links.length - maxLinks)) {
        _links.remove(e.key);
      }
    }
    try {
      await PrefsManager.instance.setString(
        _key,
        jsonEncode({for (final e in _links.entries) e.key: e.value.toJson()}),
      );
    } on StateError {
      // Storage not ready; kept in memory.
    }
  }
}
