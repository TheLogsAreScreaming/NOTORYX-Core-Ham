import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../models/checklist.dart';
import '../utils/app_logger.dart';

/// Checklists and their run records, kept on this phone for every radio.
/// Nothing here needs a radio or a network.
class ChecklistStore extends ChangeNotifier {
  ChecklistStore(
    this.prefs, {
    DateTime Function()? clock,
    String Function()? newId,
  }) : _now = clock ?? DateTime.now,
       _newId = newId ?? const Uuid().v4 {
    _load();
  }

  final SharedPreferences prefs;
  final DateTime Function() _now;
  final String Function() _newId;
  static const _key = 'checklists_v1';
  static const maxRuns = 300;

  final List<Checklist> _lists = [];
  final List<ChecklistRun> _runs = [];
  bool _seeded = false;

  List<Checklist> get checklists => List.unmodifiable(_lists);

  /// Newest first; unfinished runs included.
  List<ChecklistRun> get runs => List.unmodifiable(_runs);

  /// Whether the starter checklists were ever added (and so shouldn't
  /// come back after the user deletes them).
  bool get seeded => _seeded;

  ChecklistRun? run(String id) => _runs.where((r) => r.id == id).firstOrNull;

  /// The unfinished run of [list], if one was left open.
  ChecklistRun? openRunOf(String listId) =>
      _runs.where((r) => r.checklistId == listId && !r.finished).firstOrNull;

  void _load() {
    try {
      final raw = prefs.getString(_key);
      if (raw == null) return;
      final data = jsonDecode(raw) as Map;
      _seeded = data['seeded'] == true;
      for (final l in data['lists'] as List? ?? []) {
        if (Checklist.fromJson(l) case final c?) _lists.add(c);
      }
      for (final r in data['runs'] as List? ?? []) {
        if (ChecklistRun.fromJson(r) case final x?) _runs.add(x);
      }
    } catch (e) {
      appLogger.warn('Cannot load checklists: $e');
    }
  }

  Future<void> _save() async {
    notifyListeners();
    await prefs.setString(
      _key,
      jsonEncode({
        'seeded': _seeded,
        'lists': [for (final l in _lists) l.toJson()],
        'runs': [for (final r in _runs) r.toJson()],
      }),
    );
  }

  /// Adds the starter checklists once, in the user's language.
  Future<void> seed(List<({String name, List<String> items})> starters) async {
    if (_seeded) return;
    _seeded = true;
    for (final s in starters) {
      _lists.add(Checklist(id: _newId(), name: s.name, items: s.items));
    }
    await _save();
  }

  /// Adds [list] or replaces the one with its ID.
  Future<void> saveChecklist(Checklist list) async {
    final i = _lists.indexWhere((l) => l.id == list.id);
    if (i < 0) {
      _lists.add(list);
    } else {
      _lists[i] = list;
    }
    await _save();
  }

  Checklist create(String name, List<String> items) =>
      Checklist(id: _newId(), name: name.trim(), items: items);

  /// Deletes a checklist. Its finished runs stay as records.
  Future<void> deleteChecklist(String id) async {
    _lists.removeWhere((l) => l.id == id);
    _runs.removeWhere((r) => r.checklistId == id && !r.finished);
    await _save();
  }

  /// Opens a run of [list], or returns the one left open.
  Future<ChecklistRun> start(Checklist list) async {
    final open = openRunOf(list.id);
    if (open != null) return open;
    final run = ChecklistRun.start(list, _newId(), _now());
    _runs.insert(0, run);
    if (_runs.length > maxRuns) _runs.removeRange(maxRuns, _runs.length);
    await _save();
    return run;
  }

  Future<void> toggle(String runId, int index) =>
      _update(runId, (r) => r.toggle(index, _now()));

  Future<void> finish(String runId, {String note = ''}) =>
      _update(runId, (r) => r.finish(_now(), note: note));

  Future<void> deleteRun(String runId) async {
    _runs.removeWhere((r) => r.id == runId);
    await _save();
  }

  Future<void> _update(String id, ChecklistRun Function(ChecklistRun) f) async {
    final i = _runs.indexWhere((r) => r.id == id);
    if (i < 0 || _runs[i].finished) return;
    _runs[i] = f(_runs[i]);
    await _save();
  }
}
