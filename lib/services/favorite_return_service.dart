import 'dart:async';

import 'package:flutter/foundation.dart';

import '../connector/meshcore_connector.dart';
import '../models/contact.dart';

/// A favourite heard again after a long silence.
@immutable
class FavoriteReturn {
  const FavoriteReturn({
    required this.key,
    required this.name,
    required this.quiet,
  });
  final String key;
  final String name;

  /// How long nothing was heard from them.
  final Duration quiet;
}

/// Decides when a favourite counts as back in range: once per return, after
/// at least the quiet threshold with nothing heard, and never for what the
/// first contact sync after connecting reports.
///
/// Activity is any change to a contact's advert time or last message time,
/// timed by this phone's clock so a node with a wrong clock can't trigger it.
class FavoriteReturnWatch {
  FavoriteReturnWatch({DateTime Function()? clock})
    : _now = clock ?? DateTime.now;

  final DateTime Function() _now;
  final Map<String, ({DateTime seen, DateTime message})> _stamps = {};
  final Map<String, DateTime> _lastActive = {};
  bool _primed = false;

  /// Forgets everything; the next [observe] only records.
  void reset() {
    _stamps.clear();
    _lastActive.clear();
    _primed = false;
  }

  /// Records [contacts] and returns the favourites that just came back
  /// after at least [quiet]. A zero [quiet] turns alerts off.
  List<FavoriteReturn> observe(
    Iterable<Contact> contacts, {
    required Duration quiet,
  }) {
    final now = _now();
    final back = <FavoriteReturn>[];
    for (final c in contacts) {
      if (!c.isFavorite) continue;
      final key = c.publicKeyHex;
      final stamp = (seen: c.lastSeen, message: c.lastMessageAt);
      final previous = _stamps[key];
      _stamps[key] = stamp;
      if (previous == null) {
        // First sight: the advert time is the best guess at when they were
        // last active, unless it's in the future (a node clock ahead).
        _lastActive[key] = c.lastSeen.isAfter(now) ? now : c.lastSeen;
        continue;
      }
      if (previous == stamp) continue;
      final last = _lastActive[key] ?? now;
      _lastActive[key] = now;
      if (!_primed || quiet == Duration.zero) continue;
      final gap = now.difference(last);
      if (gap >= quiet) {
        back.add(FavoriteReturn(key: key, name: c.name, quiet: gap));
      }
    }
    _primed = true;
    return back;
  }
}

/// Notifies when a favourite is heard again after the quiet time set in
/// App Settings. Runs only while a radio is connected; the first contact
/// sync after each connect never notifies.
class FavoriteReturnService {
  FavoriteReturnService(
    this.connector, {
    required this.quietHours,
    required this.notify,
    FavoriteReturnWatch? watch,
  }) : _watch = watch ?? FavoriteReturnWatch() {
    connector.addListener(_changed);
  }

  final MeshCoreConnector connector;

  /// The current setting; 0 turns alerts off.
  final int Function() quietHours;
  final Future<void> Function(FavoriteReturn back) notify;
  final FavoriteReturnWatch _watch;
  bool _connected = false;
  bool _synced = false;

  void _changed() {
    final connected = connector.isConnected;
    if (connected != _connected) {
      _connected = connected;
      _synced = false;
      _watch.reset();
    }
    if (!connected) return;
    // Wait for the contact list to arrive, then take it as the baseline.
    if (!_synced) {
      if (connector.isLoadingContacts || connector.contacts.isEmpty) return;
      _synced = true;
      _watch.observe(connector.contacts, quiet: Duration.zero);
      return;
    }
    final back = _watch.observe(
      connector.contacts,
      quiet: Duration(hours: quietHours()),
    );
    for (final b in back) {
      unawaited(notify(b));
    }
  }

  void dispose() => connector.removeListener(_changed);
}
