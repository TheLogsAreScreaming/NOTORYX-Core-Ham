import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/message.dart';
import 'package:meshcore_open/models/radio_rx_packet.dart';
import 'package:meshcore_open/models/timeline.dart';
import 'package:meshcore_open/models/waypoint.dart';
import 'package:meshcore_open/screens/timeline_screen.dart';
import 'package:meshcore_open/services/timeline_service.dart';
import 'package:meshcore_open/services/waypoint_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final t0 = DateTime(2026, 11, 13, 9);

Contact node(int seed, String name, {int type = advTypeRepeater}) => Contact(
  publicKey: Uint8List.fromList(List.filled(32, seed)),
  name: name,
  type: type,
  pathLength: 1,
  path: Uint8List(1),
  lastSeen: t0,
);

/// A one-hop flood text packet relayed last by [hop].
RadioRxPacket heardFrom(int hop, double snr, DateTime at) => RadioRxPacket(
  raw: Uint8List.fromList([0x09, 0x01, hop, 1, 2, 3, 4]),
  snr: snr,
  rssi: -100,
  receivedAt: at,
);

class FakeConnector extends MeshCoreConnector {
  List<Contact> nodes = [];
  List<Message> chat = [];
  Future<void> update() async {
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 80));
  }

  @override
  bool get isConnected => true;
  @override
  bool get isLoadingContacts => false;
  @override
  String get selfPublicKeyHex => 'ff' * 32;
  @override
  String? get selfName => 'Me';
  @override
  List<Contact> get allContactsUnfiltered => nodes;
  @override
  List<Contact> get contacts => nodes.take(1).toList();
  @override
  Future<List<Message>> loadFullConversation(Contact contact) async => chat;
}

void main() {
  group('model', () {
    test('signal tracker ignores jitter and reports big moves', () {
      final t = SignalChangeTracker();
      expect(t.observe('3D', 5), isNull);
      expect(t.observe('3D', 7), isNull);
      expect(t.observe('3D', 3), isNull);
      final drop = t.observe('3D', -4)!;
      expect(drop.to, -4);
      expect(drop.from, greaterThan(2));
      expect(t.observe('3D', -3), isNull, reason: 'new baseline');
      expect(t.observe('AA', -10), isNull, reason: 'each node separately');
    });

    test('shared places are spotted in message text', () {
      expect(hasSharedPlace('m:45.12345,-122.5|Camp|'), isTrue);
      expect(hasSharedPlace('meet here m:45.1,-122.5|Camp|'), isTrue);
      expect(hasSharedPlace('m:hello'), isFalse);
    });

    test('filter keeps chosen kinds and words, newest first', () {
      final events = [
        TimelineEvent(
          kind: TimelineKind.message,
          at: t0,
          subject: 'Ana',
          detail: 'Water at the spring',
        ),
        TimelineEvent(
          kind: TimelineKind.nodeJoined,
          at: t0.add(const Duration(hours: 1)),
          subject: 'Ridge',
        ),
        TimelineEvent(
          kind: TimelineKind.waypoint,
          at: t0.add(const Duration(hours: 2)),
          subject: 'Spring camp',
        ),
      ];
      final all = filterTimeline(events, kinds: {...TimelineKind.values});
      expect(all.map((e) => e.subject), ['Spring camp', 'Ridge', 'Ana']);
      expect(
        filterTimeline(
          events,
          kinds: {...TimelineKind.values},
          query: 'SPRING',
        ).map((e) => e.subject),
        ['Spring camp', 'Ana'],
      );
      expect(
        filterTimeline(
          events,
          kinds: {TimelineKind.message},
          query: 'spring',
        ).single.subject,
        'Ana',
      );
    });

    test('events round trip through JSON', () {
      final e = TimelineEvent(
        kind: TimelineKind.signalChange,
        at: t0,
        subject: 'Ridge',
        key: '3D',
        fromSnr: 5,
        toSnr: -2.5,
      );
      final back = TimelineEvent.fromJson(e.toJson())!;
      expect(back.toJson(), e.toJson());
      expect(TimelineEvent.fromJson({'k': 'nope'}), isNull);
    });

    test('every event has words', () {
      final l10n = lookupAppLocalizations(const Locale('en'));
      expect(
        timelineTitle(
          l10n,
          TimelineEvent(
            kind: TimelineKind.signalChange,
            at: t0,
            subject: 'Ridge',
            fromSnr: 5,
            toSnr: -2.5,
          ),
        ),
        'Ridge: signal down from 5.0 to -2.5 dB',
      );
      expect(
        timelineTitle(
          l10n,
          TimelineEvent(
            kind: TimelineKind.nodeJoined,
            at: t0,
            subject: 'Ridge',
          ),
        ),
        'First heard: Ridge',
      );
      expect(
        timelineTitle(
          l10n,
          TimelineEvent(
            kind: TimelineKind.waypoint,
            at: t0,
            subject: 'Ana',
            detail: 'm:1,2|x|',
            key: 'Public',
          ),
        ),
        'Ana shared a place in Public',
      );
    });
  });

  group('service', () {
    late FakeConnector radio;
    late SharedPreferences prefs;
    late WaypointStore places;
    DateTime now = t0;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      radio = FakeConnector()..nodes = [node(1, 'Ridge')];
      places = WaypointStore(prefs);
      now = t0;
    });

    test('first list is the baseline; later nodes are news', () async {
      final tl = TimelineService(
        radio,
        prefs: prefs,
        waypoints: places,
        clock: () => now,
      );
      expect(tl.events, isEmpty);
      now = t0.add(const Duration(minutes: 5));
      radio.nodes = [...radio.nodes, node(2, 'Hiker', type: advTypeChat)];
      await radio.update();
      expect(tl.events.single.kind, TimelineKind.nodeJoined);
      expect(tl.events.single.subject, 'Hiker');
      expect(tl.events.single.at, now);
      tl.dispose();

      final again = TimelineService(
        radio,
        prefs: prefs,
        waypoints: places,
        clock: () => now,
      );
      expect(again.events.single.subject, 'Hiker');
      await radio.update();
      expect(again.events, hasLength(1), reason: 'known nodes stay known');
      again.dispose();
    });

    test('saved waypoints and signal swings are logged', () async {
      final tl = TimelineService(
        radio,
        prefs: prefs,
        waypoints: places,
        clock: () => now,
      );
      await places.add(
        const Waypoint(id: 'w1', name: 'Spring', lat: 45, lon: -122),
      );
      expect(tl.events.first.kind, TimelineKind.waypoint);
      expect(tl.events.first.subject, 'Spring');

      tl.onPacket(heardFrom(1, 8, t0));
      tl.onPacket(heardFrom(1, 7, t0));
      tl.onPacket(heardFrom(1, -2, t0));
      final change = tl.events.first;
      expect(change.kind, TimelineKind.signalChange);
      expect(change.subject, 'Ridge');
      expect(change.toSnr, -2);
      tl.dispose();
    });

    test('messages load as events; shared places count as places', () async {
      radio.chat = [
        Message(
          senderKey: radio.nodes.first.publicKey,
          text: 'Hello',
          timestamp: t0,
          isOutgoing: false,
        ),
        Message(
          senderKey: radio.nodes.first.publicKey,
          text: 'm:45.1,-122.2|Camp|',
          timestamp: t0.add(const Duration(minutes: 1)),
          isOutgoing: true,
        ),
      ];
      final tl = TimelineService(radio, prefs: prefs, clock: () => now);
      final msgs = await tl.loadMessages();
      expect(msgs.map((e) => e.kind), [
        TimelineKind.waypoint,
        TimelineKind.message,
      ]);
      expect(msgs.first.subject, 'Me');
      expect(msgs.last.subject, 'Ridge');
      expect(msgs.last.key, 'Ridge');
      tl.dispose();
    });
  });

  testWidgets('screen shows a feed with day headers and kind filters', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final radio = FakeConnector()
      ..nodes = [node(1, 'Ridge')]
      ..chat = [
        Message(
          senderKey: Uint8List(32),
          text: 'Water at the spring',
          timestamp: t0,
          isOutgoing: false,
        ),
      ];
    final tl = TimelineService(radio, prefs: prefs);
    await tester.pumpWidget(
      ChangeNotifierProvider<TimelineService?>.value(
        value: tl,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: TimelineScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Water at the spring'), findsOneWidget);
    expect(find.text('Ridge in Ridge'), findsOneWidget);
    expect(find.bySemanticsLabel('Messages'), findsWidgets);

    await tester.tap(find.widgetWithText(FilterChip, 'Messages'));
    await tester.pump();
    expect(find.text('Water at the spring'), findsNothing);
    expect(find.textContaining('Nothing yet'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    tl.dispose();
  });
}
