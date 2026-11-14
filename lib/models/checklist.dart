import 'dart:convert';

/// A reusable list of things to check, such as before a trip or when
/// putting up a node.
class Checklist {
  const Checklist({required this.id, required this.name, required this.items});

  final String id;
  final String name;
  final List<String> items;

  Checklist copyWith({String? name, List<String>? items}) =>
      Checklist(id: id, name: name ?? this.name, items: items ?? this.items);

  Map<String, Object?> toJson() => {'id': id, 'name': name, 'items': items};

  static Checklist? fromJson(Object? json) {
    if (json is! Map) return null;
    final id = json['id'], name = json['name'], items = json['items'];
    if (id is! String || name is! String || items is! List) return null;
    return Checklist(
      id: id,
      name: name,
      items: items.whereType<String>().toList(),
    );
  }
}

/// Splits typed text into items: one per line, blanks dropped.
List<String> parseChecklistItems(String text) => [
  for (final line in text.split('\n'))
    if (line.trim().isNotEmpty) line.trim(),
];

/// One ticked (or not) line of a run.
class RunItem {
  const RunItem(this.text, {this.doneAt});
  final String text;
  final DateTime? doneAt;
  bool get done => doneAt != null;

  Map<String, Object?> toJson() => {
    't': text,
    if (doneAt != null) 'at': doneAt!.millisecondsSinceEpoch,
  };

  static RunItem? fromJson(Object? json) {
    if (json is! Map || json['t'] is! String) return null;
    final at = json['at'];
    return RunItem(
      json['t'] as String,
      doneAt: at is int ? DateTime.fromMillisecondsSinceEpoch(at) : null,
    );
  }
}

/// One time a checklist was worked through. The item texts are copied in,
/// so later edits to the checklist don't change past records.
class ChecklistRun {
  const ChecklistRun({
    required this.id,
    required this.checklistId,
    required this.name,
    required this.startedAt,
    required this.items,
    this.finishedAt,
    this.note = '',
  });

  final String id;
  final String checklistId;
  final String name;
  final DateTime startedAt;
  final DateTime? finishedAt;
  final List<RunItem> items;
  final String note;

  bool get finished => finishedAt != null;
  int get doneCount => items.where((i) => i.done).length;

  factory ChecklistRun.start(Checklist list, String id, DateTime now) =>
      ChecklistRun(
        id: id,
        checklistId: list.id,
        name: list.name,
        startedAt: now,
        items: [for (final t in list.items) RunItem(t)],
      );

  /// Ticks or unticks item [index] at [now].
  ChecklistRun toggle(int index, DateTime now) => _copy(
    items: [
      for (final (i, item) in items.indexed)
        i == index ? RunItem(item.text, doneAt: item.done ? null : now) : item,
    ],
  );

  ChecklistRun finish(DateTime now, {String note = ''}) =>
      _copy(finishedAt: now, note: note.trim());

  ChecklistRun _copy({
    List<RunItem>? items,
    DateTime? finishedAt,
    String? note,
  }) => ChecklistRun(
    id: id,
    checklistId: checklistId,
    name: name,
    startedAt: startedAt,
    items: items ?? this.items,
    finishedAt: finishedAt ?? this.finishedAt,
    note: note ?? this.note,
  );

  Map<String, Object?> toJson() => {
    'id': id,
    'list': checklistId,
    'name': name,
    'start': startedAt.millisecondsSinceEpoch,
    if (finishedAt != null) 'end': finishedAt!.millisecondsSinceEpoch,
    'items': [for (final i in items) i.toJson()],
    if (note.isNotEmpty) 'note': note,
  };

  static ChecklistRun? fromJson(Object? json) {
    if (json is! Map) return null;
    final id = json['id'], list = json['list'], name = json['name'];
    final start = json['start'], items = json['items'];
    if (id is! String ||
        list is! String ||
        name is! String ||
        start is! int ||
        items is! List) {
      return null;
    }
    final end = json['end'];
    return ChecklistRun(
      id: id,
      checklistId: list,
      name: name,
      startedAt: DateTime.fromMillisecondsSinceEpoch(start),
      finishedAt: end is int ? DateTime.fromMillisecondsSinceEpoch(end) : null,
      items: [for (final i in items) ?RunItem.fromJson(i)],
      note: json['note'] as String? ?? '',
    );
  }

  /// A machine-readable record with ISO-8601 UTC times, for export.
  String exportJson() => const JsonEncoder.withIndent('  ').convert({
    'format': 'notoryx-checklist-run/1',
    'checklist': name,
    'started': startedAt.toUtc().toIso8601String(),
    'finished': finishedAt?.toUtc().toIso8601String(),
    'done': doneCount,
    'total': items.length,
    'items': [
      for (final i in items)
        {'item': i.text, 'done_at': i.doneAt?.toUtc().toIso8601String()},
    ],
    if (note.isNotEmpty) 'note': note,
  });
}
