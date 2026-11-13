import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../models/contact.dart';
import '../utils/app_logger.dart';

enum NetworkChangeKind { newRepeater, wentQuiet }

/// A repeater that appeared nearby or went quiet.
@immutable
class NetworkChange {
  const NetworkChange({
    required this.kind,
    required this.key,
    required this.name,
    required this.at,
    this.hops = 0,
    this.quietHours = 0,
  });

  final NetworkChangeKind kind;
  final String key;
  final String name;
  final DateTime at;

  /// For a new repeater: hops away (0 is heard directly).
  final int hops;

  /// For a quiet one: hours since it was last heard.
  final int quietHours;

  Map<String, Object> toJson() => {
    'kind': kind.name,
    'key': key,
    'name': name,
    'at': at.millisecondsSinceEpoch,
    'hops': hops,
    'quiet': quietHours,
  };

  static NetworkChange? fromJson(Object? json) {
    if (json is! Map) return null;
    final kind = NetworkChangeKind.values.where((k) => k.name == json['kind']);
    final key = json['key'], name = json['name'], at = json['at'];
    if (kind.isEmpty || key is! String || name is! String || at is! int) {
      return null;
    }
    return NetworkChange(
      kind: kind.first,
      key: key,
      name: name,
      at: DateTime.fromMillisecondsSinceEpoch(at),
      hops: json['hops'] as int? ?? 0,
      quietHours: json['quiet'] as int? ?? 0,
    );
  }
}

/// Decides network changes from repeated looks at the contact list.
///
/// Activity is timed by this phone's clock (when a repeater's advert time
/// changes), so a repeater with a wrong clock can't trigger anything.
class NetworkChangeWatch {
  NetworkChangeWatch({DateTime Function()? clock})
    : _now = clock ?? DateTime.now;

  final DateTime Function() _now;

  /// Every repeater this radio has seen; kept so "new" means new.
  final Set<String> known = {};

  /// Favourite repeaters already reported quiet, until heard again.
  final Set<String> quietReported = {};
  final Map<String, DateTime> _advert = {};
  final Map<String, DateTime> _lastActive = {};

  /// Whether this radio has a baseline yet; the first look never reports
  /// new repeaters.
  bool get primed => known.isNotEmpty;

  /// Looks at [contacts] now. [quiet] zero turns quiet alerts off; [newNearby]
  /// turns on alerts for new repeaters within one hop.
  List<NetworkChange> observe(
    Iterable<Contact> contacts, {
    required Duration quiet,
    required bool newNearby,
  }) {
    final now = _now();
    final wasPrimed = primed;
    final changes = <NetworkChange>[];
    for (final c in contacts) {
      if (c.type != advTypeRepeater) continue;
      final key = c.publicKeyHex;
      if (known.add(key) &&
          wasPrimed &&
          newNearby &&
          c.pathLength >= 0 &&
          c.pathLength <= 1) {
        changes.add(
          NetworkChange(
            kind: NetworkChangeKind.newRepeater,
            key: key,
            name: c.name,
            at: now,
            hops: c.pathLength,
          ),
        );
      }
      final previous = _advert[key];
      _advert[key] = c.lastSeen;
      if (previous == null) {
        _lastActive[key] = c.lastSeen.isAfter(now) ? now : c.lastSeen;
      } else if (previous != c.lastSeen) {
        _lastActive[key] = now;
        quietReported.remove(key);
      }
      if (quiet == Duration.zero || !c.isFavorite) continue;
      final silent = now.difference(_lastActive[key]!);
      if (silent >= quiet && quietReported.add(key)) {
        changes.add(
          NetworkChange(
            kind: NetworkChangeKind.wentQuiet,
            key: key,
            name: c.name,
            at: now,
            quietHours: silent.inHours,
          ),
        );
      }
    }
    return changes;
  }
}

/// Watches the connected radio's repeaters for network changes, keeps the
/// last 50, and passes each to [notify]. Looks again every 10 minutes, since
/// a repeater going quiet changes nothing on its own.
class NetworkChangeService extends ChangeNotifier {
  NetworkChangeService(
    this.connector, {
    required this.prefs,
    required this.quietHours,
    required this.newNearby,
    required this.notify,
    DateTime Function()? clock,
  }) : _clock = clock,
       _watch = NetworkChangeWatch(clock: clock) {
    connector.addListener(_changed);
    _timer = Timer.periodic(const Duration(minutes: 10), (_) => _look());
  }

  final MeshCoreConnector connector;
  final SharedPreferences prefs;
  final int Function() quietHours;
  final bool Function() newNearby;
  final Future<void> Function(NetworkChange change) notify;
  final DateTime Function()? _clock;
  NetworkChangeWatch _watch;
  final List<NetworkChange> _log = [];
  String _scope = '';
  bool _synced = false;
  Timer? _timer;

  static const maxLog = 50;

  /// Newest first.
  List<NetworkChange> get log => List.unmodifiable(_log);

  static String _prefsKey(String scope) => 'network_changes_v1_$scope';

  void _changed() {
    final scope = connector.isConnected ? connector.selfPublicKeyHex : '';
    if (scope != _scope) {
      _scope = scope;
      _synced = false;
      _watch = NetworkChangeWatch(clock: _clock);
      _log.clear();
      if (scope.isNotEmpty) _load();
      notifyListeners();
    }
    if (scope.isEmpty) return;
    if (!_synced) {
      // Take the first full contact list as it is.
      if (connector.isLoadingContacts || connector.contacts.isEmpty) return;
      _synced = true;
    }
    _look();
  }

  void _look() {
    if (!_synced || _scope.isEmpty) return;
    final changes = _watch.observe(
      connector.allContactsUnfiltered,
      quiet: Duration(hours: quietHours()),
      newNearby: newNearby(),
    );
    if (changes.isEmpty && _savedKnown == _watch.known.length) return;
    for (final c in changes) {
      _log.insert(0, c);
      unawaited(notify(c));
    }
    if (_log.length > maxLog) _log.removeRange(maxLog, _log.length);
    unawaited(_save());
    if (changes.isNotEmpty) notifyListeners();
  }

  int _savedKnown = -1;

  void _load() {
    try {
      final raw = prefs.getString(_prefsKey(_scope));
      if (raw == null) return;
      final data = jsonDecode(raw);
      if (data is! Map) return;
      _watch.known.addAll((data['known'] as List? ?? []).whereType<String>());
      _watch.quietReported.addAll(
        (data['quiet'] as List? ?? []).whereType<String>(),
      );
      for (final item in data['log'] as List? ?? []) {
        if (NetworkChange.fromJson(item) case final c?) _log.add(c);
      }
      _savedKnown = _watch.known.length;
    } catch (e) {
      appLogger.warn('Cannot load network changes: $e');
    }
  }

  Future<void> _save() async {
    if (_scope.isEmpty) return;
    _savedKnown = _watch.known.length;
    await prefs.setString(
      _prefsKey(_scope),
      jsonEncode({
        'known': _watch.known.toList(),
        'quiet': _watch.quietReported.toList(),
        'log': [for (final c in _log) c.toJson()],
      }),
    );
  }

  Future<void> clearLog() async {
    _log.clear();
    notifyListeners();
    await _save();
  }

  @override
  void dispose() {
    _timer?.cancel();
    connector.removeListener(_changed);
    super.dispose();
  }
}
