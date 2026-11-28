import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/checklist.dart';
import 'package:meshcore_open/screens/checklists_screen.dart';
import 'package:meshcore_open/services/checklist_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final t0 = DateTime.utc(2026, 11, 13, 7, 30);

void main() {
  setUpAll(initializeDateFormatting);

  late SharedPreferences prefs;
  late DateTime now;
  late int ids;

  ChecklistStore store() =>
      ChecklistStore(prefs, clock: () => now, newId: () => 'id${ids++}');

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    now = t0;
    ids = 0;
  });

  test('items are one per line, blanks dropped', () {
    expect(parseChecklistItems(' Water \n\n  Map\n '), ['Water', 'Map']);
  });

  test(
    'a run records when each item was ticked and when it finished',
    () async {
      final s = store();
      final list = s.create('Hike', ['Water', 'Map']);
      await s.saveChecklist(list);
      final run = await s.start(list);
      now = t0.add(const Duration(minutes: 3));
      await s.toggle(run.id, 1);
      expect(s.run(run.id)!.items[1].doneAt, now);
      expect(s.run(run.id)!.doneCount, 1);

      expect((await s.start(list)).id, run.id, reason: 'open run is reused');

      now = t0.add(const Duration(minutes: 5));
      await s.finish(run.id, note: ' all good ');
      final done = s.run(run.id)!;
      expect(done.finishedAt, now);
      expect(done.note, 'all good');
      await s.toggle(run.id, 0);
      expect(s.run(run.id)!.doneCount, 1, reason: 'finished runs are fixed');
      expect(s.openRunOf(list.id), isNull);
    },
  );

  test('records survive restarts and checklist edits', () async {
    final s = store();
    final list = s.create('Deploy', ['Antenna']);
    await s.saveChecklist(list);
    final run = await s.start(list);
    await s.toggle(run.id, 0);
    await s.finish(run.id);
    await s.saveChecklist(list.copyWith(items: ['Antenna', 'Solar']));

    final again = store();
    expect(again.checklists.single.items, ['Antenna', 'Solar']);
    expect(again.run(run.id)!.items.map((i) => i.text), ['Antenna']);

    await again.deleteChecklist(list.id);
    expect(again.checklists, isEmpty);
    expect(again.run(run.id), isNotNull, reason: 'finished records stay');
    await again.deleteRun(run.id);
    expect(again.runs, isEmpty);
  });

  test('starter checklists are added once, never re-added', () async {
    final l10n = lookupAppLocalizations(const Locale('de'));
    final s = store();
    await s.seed(starterChecklists(l10n));
    expect(s.checklists.map((c) => c.name), [
      'Vor der Tour',
      'Knoten aufstellen',
    ]);
    expect(s.checklists.first.items, hasLength(6));
    await s.deleteChecklist(s.checklists.first.id);
    await s.seed(starterChecklists(l10n));
    expect(store().checklists, hasLength(1));
  });

  test('exports as JSON with UTC times and as text', () async {
    final s = store();
    final list = s.create('Hike', ['Water', 'Map']);
    final run = await s.start(list);
    await s.toggle(run.id, 0);
    now = t0.add(const Duration(hours: 1));
    await s.finish(run.id, note: 'ok');
    final done = s.run(run.id)!;
    final json = jsonDecode(done.exportJson()) as Map;
    expect(json['format'], 'notoryx-checklist-run/1');
    expect(json['started'], '2026-11-13T07:30:00.000Z');
    expect(json['finished'], '2026-11-13T08:30:00.000Z');
    expect(json['done'], 1);
    expect((json['items'] as List).last['done_at'], isNull);
    final text = checklistRunText(
      lookupAppLocalizations(const Locale('en')),
      done,
      'en',
    );
    expect(text, contains('1 of 2 done'));
    expect(text, contains('[x] Water'));
    expect(text, contains('[ ] Map'));
    expect(text, contains('Note: ok'));
  });

  testWidgets('screen seeds starters, runs a checklist and saves it', (
    tester,
  ) async {
    final s = store();
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: s,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ChecklistsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Before a trip'), findsOneWidget);
    expect(find.text('Putting up a node'), findsOneWidget);
    expect(find.byTooltip('Edit checklist'), findsNWidgets(2));

    await tester.tap(find.text('Before a trip'));
    await tester.pumpAndSettle();
    expect(find.byType(CheckboxListTile), findsNWidgets(6));
    await tester.tap(find.text('Offline maps saved for the area'));
    await tester.pumpAndSettle();
    expect(find.text('1 of 6 done'), findsOneWidget);

    await tester.ensureVisible(find.text('Finish and save'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Finish and save'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save anyway'));
    await tester.pumpAndSettle();
    expect(s.runs.single.finished, isTrue);
    expect(find.byTooltip('Export or delete'), findsOneWidget);
  });
}
