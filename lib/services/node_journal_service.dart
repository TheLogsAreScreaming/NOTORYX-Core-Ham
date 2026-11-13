import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../connector/meshcore_connector.dart';
import '../models/contact.dart';
import '../models/node_journal.dart';
import '../utils/app_logger.dart';

/// Keeps a journal of every node the connected radio has ever heard:
/// contacts and discovered nodes alike. Each radio has its own journal.
///
/// Times come from this phone's clock (when a node's advert changes), so a
/// node with a wrong clock can't fake being heard.
class NodeJournalService extends ChangeNotifier {
  NodeJournalService(
    this.connector, {
    required this.prefs,
    DateTime Function()? clock,
  }) : _now = clock ?? DateTime.now {
    connector.addListener(_changed);
    _changed();
  }

  final MeshCoreConnector connector;
  final SharedPreferences prefs;
  final DateTime Function() _now;
  final Map<String, JournalEntry> _entries = {};
  String _scope = '';
  Timer? _saveTimer;

  static String prefsKey(String scope) => 'node_journal_v1_$scope';

  /// Most recently heard first.
  List<JournalEntry> get entries =>
      _entries.values.toList()
        ..sort((a, b) => b.lastSeen.compareTo(a.lastSeen));

  JournalEntry? entry(String key) => _entries[key];

  /// Every tag in use, sorted, for filtering.
  List<String> get allTags =>
      {for (final e in _entries.values) ...e.tags}.toList()..sort();

  void _changed() {
    final scope = connector.isConnected ? connector.selfPublicKeyHex : '';
    if (scope != _scope) {
      _flush();
      _scope = scope;
      _entries.clear();
      if (scope.isNotEmpty) _load();
      notifyListeners();
    }
    if (scope.isEmpty) return;
    observe(connector.allContactsUnfiltered);
  }

  /// Records [contacts] as heard now. Public for tests.
  @visibleForTesting
  void observe(Iterable<Contact> contacts) {
    final now = _now();
    var changed = false;
    for (final c in contacts) {
      final key = c.publicKeyHex;
      if (key.isEmpty || key == _scope) continue;
      final advert = c.lastSeen;
      final existing = _entries[key];
      if (existing == null) {
        final first = advert.isAfter(now) ? now : advert;
        final e = JournalEntry(
          key: key,
          name: c.name,
          type: c.type,
          firstSeen: first,
          lastSeen: first,
          lastAdvert: advert,
          minHops: c.pathLength >= 0 ? c.pathLength : null,
          maxHops: c.pathLength >= 0 ? c.pathLength : null,
        );
        if (c.hasLocation) e.addSpot(c.latitude!, c.longitude!);
        _entries[key] = e;
        changed = true;
      } else if (existing.observe(
        name: c.name,
        type: c.type,
        advert: advert,
        now: now,
        hops: c.pathLength,
        lat: c.hasLocation ? c.latitude : null,
        lon: c.hasLocation ? c.longitude : null,
      )) {
        changed = true;
      }
    }
    if (changed) {
      _scheduleSave();
      notifyListeners();
    }
  }

  Future<void> setTags(String key, Set<String> tags) async {
    final e = _entries[key];
    if (e == null) return;
    e.tags
      ..clear()
      ..addAll(tags.map((t) => t.trim()).where((t) => t.isNotEmpty));
    notifyListeners();
    await _save();
  }

  Future<void> setNote(String key, String note) async {
    final e = _entries[key];
    if (e == null) return;
    e.note = note.trim();
    notifyListeners();
    await _save();
  }

  /// Removes a node from the journal; it starts fresh if heard again.
  Future<void> forget(String key) async {
    if (_entries.remove(key) == null) return;
    notifyListeners();
    await _save();
  }

  void _load() {
    try {
      final raw = prefs.getString(prefsKey(_scope));
      if (raw == null) return;
      for (final item in jsonDecode(raw) as List) {
        if (JournalEntry.fromJson(item) case final e?) _entries[e.key] = e;
      }
    } catch (e) {
      appLogger.warn('Cannot load node journal: $e');
    }
  }

  void _scheduleSave() {
    _saveTimer ??= Timer(const Duration(seconds: 10), () {
      _saveTimer = null;
      unawaited(_save());
    });
  }

  void _flush() {
    if (_saveTimer != null) unawaited(_save());
  }

  Future<void> _save() async {
    _saveTimer?.cancel();
    _saveTimer = null;
    if (_scope.isEmpty) return;
    await prefs.setString(
      prefsKey(_scope),
      jsonEncode([for (final e in _entries.values) e.toJson()]),
    );
  }

  @override
  void dispose() {
    _flush();
    connector.removeListener(_changed);
    super.dispose();
  }
}
