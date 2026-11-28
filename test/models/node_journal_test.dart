import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/node_journal.dart';
import 'package:meshcore_open/screens/node_journal_screen.dart';
import 'package:meshcore_open/services/node_journal_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final t0 = DateTime(2026, 11, 1, 12);

JournalEntry entry({
  int type = advTypeRepeater,
  DateTime? first,
  DateTime? last,
  Set<String>? days,
}) => JournalEntry(
  key: 'aa' * 32,
  name: 'Ridge',
  type: type,
  firstSeen: first ?? t0,
  lastSeen: last ?? t0,
  days: days,
);

Set<String> daysFrom(DateTime start, int count, {int step = 1}) => {
  for (var i = 0; i < count; i++)
    journalDay(start.add(Duration(days: i * step))),
};

Contact node(
  int seed,
  String name, {
  DateTime? seen,
  int type = advTypeRepeater,
  double? lat,
  double? lon,
  int hops = 1,
}) => Contact(
  publicKey: Uint8List.fromList(List.filled(32, seed)),
  name: name,
  type: type,
  pathLength: hops,
  path: Uint8List(hops),
  lastSeen: seen ?? t0,
  latitude: lat,
  longitude: lon,
);

class FakeConnector extends MeshCoreConnector {
  List<Contact> nodes = [];
  bool connected = true;
  Future<void> update() async {
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 80));
  }

  @override
  bool get isConnected => connected;
  @override
  String get selfPublicKeyHex => 'ff' * 32;
  @override
  List<Contact> get allContactsUnfiltered => nodes;
}

void main() {
  group('classifier', () {
    test('a relay heard nearly every day is an always-on relay', () {
      final now = t0.add(const Duration(days: 9));
      final e = entry(last: now, days: daysFrom(t0, 10));
      final g = classifyNode(e, now);
      expect(g.first.behaviour, NodeBehaviour.steadyRelay);
      expect(g.first.confidence, closeTo(1.0, 0.001));
      expect(
        g.first.evidence,
        contains(const Evidence(EvidenceKind.daysHeard, 10, 10)),
      );
    });

    test('a person heard most days is a regular, not a relay', () {
      final now = t0.add(const Duration(days: 6));
      final e = entry(
        type: advTypeChat,
        last: now,
        days: daysFrom(t0, 4, step: 2),
      );
      final labels = classifyNode(e, now).map((g) => g.behaviour);
      expect(labels, contains(NodeBehaviour.regular));
      expect(labels, isNot(contains(NodeBehaviour.steadyRelay)));
    });

    test('new nodes are newcomers', () {
      final e = entry();
      final g = classifyNode(e, t0.add(const Duration(hours: 5)));
      expect(g.single.behaviour, NodeBehaviour.newcomer);
      expect(
        g.single.evidence.single,
        const Evidence(EvidenceKind.firstHeardHours, 5),
      );
    });

    test('heard on two days in a month is rarely heard', () {
      final now = t0.add(const Duration(days: 29));
      final e = entry(
        last: t0.add(const Duration(days: 3)),
        days: {journalDay(t0), journalDay(t0.add(const Duration(days: 3)))},
      );
      final g = classifyNode(e, now);
      expect(g.map((x) => x.behaviour), contains(NodeBehaviour.rarelyHeard));
      expect(g.first.behaviour, NodeBehaviour.rarelyHeard);
    });

    test('a busy node silent for ten days has gone quiet', () {
      final now = t0.add(const Duration(days: 20));
      final e = entry(
        last: t0.add(const Duration(days: 10)),
        days: daysFrom(t0, 10),
      );
      final g = classifyNode(e, now);
      expect(g.first.behaviour, NodeBehaviour.goneQuiet);
      expect(
        g.first.evidence.first,
        const Evidence(EvidenceKind.silentDays, 10),
      );
      expect(
        g.map((x) => x.behaviour),
        isNot(contains(NodeBehaviour.steadyRelay)),
      );
    });

    test('several places far apart make a roamer; nearby spots merge', () {
      final e = entry(type: advTypeChat);
      expect(e.addSpot(45.0, -122.0), isTrue);
      expect(e.addSpot(45.001, -122.0), isFalse, reason: 'about 110 m away');
      e.addSpot(45.05, -122.0);
      e.addSpot(45.1, -122.1);
      final g = classifyNode(e, t0.add(const Duration(days: 2)));
      final roam = g.firstWhere((x) => x.behaviour == NodeBehaviour.roamer);
      expect(roam.evidence.single.kind, EvidenceKind.places);
      expect(roam.evidence.single.a, 3);
      expect(roam.evidence.single.b, greaterThanOrEqualTo(10));
    });

    test('every behaviour and evidence has words', () {
      final l10n = lookupAppLocalizations(const Locale('en'));
      for (final b in NodeBehaviour.values) {
        expect(behaviourName(l10n, b), isNotEmpty);
      }
      expect(
        evidenceText(l10n, const Evidence(EvidenceKind.daysHeard, 3, 7)),
        'Heard on 3 of 7 days',
      );
    });
  });

  group('entry', () {
    test('a sighting counts only when the advert time changes', () {
      final e = entry()..lastAdvert = t0;
      final later = t0.add(const Duration(days: 1));
      e.observe(name: 'Ridge', type: advTypeRepeater, advert: t0, now: later);
      expect(e.sightings, 1);
      e.observe(
        name: 'Ridge 2',
        type: advTypeRepeater,
        advert: later,
        now: later,
        hops: 3,
      );
      expect(e.sightings, 2);
      expect(e.lastSeen, later);
      expect(e.name, 'Ridge 2');
      expect(e.days, hasLength(2));
      expect((e.minHops, e.maxHops), (3, 3));
    });

    test('round trips through JSON with tags and notes', () {
      final e = entry(days: daysFrom(t0, 3))
        ..tags.addAll({'club', 'hill'})
        ..note = 'Solar, on the water tower'
        ..minHops = 1
        ..maxHops = 4
        ..lastAdvert = t0;
      e.addSpot(45, -122);
      final back = JournalEntry.fromJson(e.toJson())!;
      expect(back.toJson(), e.toJson());
      expect(JournalEntry.fromJson({'key': 1}), isNull);
    });
  });

  group('generated mark', () {
    test('is the same for the same key and mirrored', () {
      final a = nodeMarkFor('A1B2' * 16);
      final b = nodeMarkFor('a1b2' * 16);
      expect(a.cells, b.cells);
      expect(a.hue, b.hue);
      for (var row = 0; row < 5; row++) {
        for (var col = 0; col < 5; col++) {
          expect(a.cells[row * 5 + col], a.cells[row * 5 + 4 - col]);
        }
      }
      expect(a.cells, contains(true));
    });

    test('differs between keys', () {
      final marks = {
        for (var i = 0; i < 50; i++)
          nodeMarkFor(i.toRadixString(16).padLeft(64, '0')).cells.join(),
      };
      expect(marks.length, greaterThan(40));
    });
  });

  group('service', () {
    late FakeConnector radio;
    late SharedPreferences prefs;
    late DateTime now;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      radio = FakeConnector();
      now = t0;
    });

    test('logs every node heard, ignores itself, keeps tags', () async {
      radio.nodes = [
        node(1, 'Ridge'),
        node(2, 'Hiker', type: advTypeChat, lat: 45, lon: -122),
        Contact(
          publicKey: Uint8List.fromList(List.filled(32, 0xff)),
          name: 'Me',
          type: advTypeChat,
          pathLength: 0,
          path: Uint8List(0),
          lastSeen: t0,
        ),
      ];
      final journal = NodeJournalService(radio, prefs: prefs, clock: () => now);
      expect(
        journal.entries.map((e) => e.name),
        unorderedEquals(['Ridge', 'Hiker']),
      );
      final hiker = journal.entries.firstWhere((e) => e.name == 'Hiker');
      expect(hiker.spots, hasLength(1));

      now = t0.add(const Duration(days: 1));
      radio.nodes = [node(1, 'Ridge', seen: now)];
      await radio.update();
      expect(journal.entry(radio.nodes.first.publicKeyHex)!.sightings, 2);

      await journal.setTags(radio.nodes.first.publicKeyHex, {' club ', ''});
      await journal.setNote(radio.nodes.first.publicKeyHex, '  tower ');
      journal.dispose();

      final again = NodeJournalService(radio, prefs: prefs, clock: () => now);
      final ridge = again.entry(radio.nodes.first.publicKeyHex)!;
      expect(ridge.tags, {'club'});
      expect(ridge.note, 'tower');
      expect(again.allTags, ['club']);
      await again.forget(ridge.key);
      expect(again.entry(ridge.key), isNull);
      again.dispose();
    });

    test('empties when the radio disconnects', () async {
      radio.nodes = [node(1, 'Ridge')];
      final journal = NodeJournalService(radio, prefs: prefs, clock: () => now);
      expect(journal.entries, hasLength(1));
      radio.connected = false;
      await radio.update();
      expect(journal.entries, isEmpty);
      journal.dispose();
    });
  });

  testWidgets('screen lists nodes, filters by label and opens a node', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final radio = FakeConnector()
      ..nodes = [node(1, 'Ridge'), node(2, 'Hiker', type: advTypeChat)];
    DateTime clock() => t0.add(const Duration(hours: 2));
    final journal = NodeJournalService(radio, prefs: prefs, clock: clock);
    await tester.pumpWidget(
      ChangeNotifierProvider<NodeJournalService?>.value(
        value: journal,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: NodeJournalScreen(clock: clock),
        ),
      ),
    );
    expect(find.text('Ridge'), findsOneWidget);
    expect(find.text('Hiker'), findsOneWidget);
    expect(find.textContaining('Newcomer · 90% sure'), findsNWidgets(2));

    await tester.tap(find.widgetWithText(ChoiceChip, 'Roamer'));
    await tester.pump();
    expect(find.text('Ridge'), findsNothing);

    await tester.tap(find.widgetWithText(ChoiceChip, 'All'));
    await tester.pump();
    await tester.tap(find.text('Ridge'));
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel('Generated mark for Ridge'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextField, 'Add tag'), 'club');
    await tester.tap(find.byTooltip('Add tag'));
    await tester.pump();
    expect(journal.entry(radio.nodes.first.publicKeyHex)!.tags, {'club'});
    expect(find.byTooltip('Remove tag club'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    journal.dispose();
  });
}
