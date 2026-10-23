import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/field_ops.dart';
import 'package:meshcore_open/models/message.dart';
import 'package:meshcore_open/services/field_ops_service.dart';
import 'package:meshcore_open/widgets/sos_panel.dart';

class _Radio extends MeshCoreConnector {
  bool connected = true;
  final stream = StreamController<Message>.broadcast();
  final sent = <Message>[];
  final channelSends = <String>[];
  final person = Contact(
    publicKey: Uint8List.fromList(List.filled(32, 7)),
    name: 'Trail partner',
    type: advTypeChat,
    pathLength: -1,
    path: Uint8List(0),
    lastSeen: DateTime.now(),
  );
  final team = Channel(
    index: 2,
    name: '#search-team',
    psk: Uint8List.fromList(List.filled(16, 9)),
  );
  @override
  bool get isConnected => connected;
  @override
  bool get isLoadingContacts => false;
  @override
  List<Contact> get contacts => [person];
  @override
  List<Channel> get channels => [team];
  @override
  Stream<Message> get receivedDirectMessages => stream.stream;
  @override
  List<Message> getMessages(Contact c) => sent;
  @override
  Future<void> sendMessage(
    Contact contact,
    String text, {
    String? originalText,
    String? translatedLanguageCode,
    String? translationModelId,
  }) async {
    sent.add(
      Message(
        senderKey: contact.publicKey,
        text: text,
        timestamp: DateTime.now(),
        isOutgoing: true,
        status: MessageStatus.pending,
      ),
    );
  }

  @override
  Future<void> sendChannelMessage(
    Channel channel,
    String text, {
    String? originalText,
    String? translatedLanguageCode,
    String? translationModelId,
  }) async {
    channelSends.add('${channel.name}: $text');
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SOS text and state', () {
    final at = DateTime.utc(2026, 10, 16, 14, 5);
    test('carries position and battery when known', () {
      expect(
        sosText(at, latitude: 35.12346, longitude: -80.5, battery: 64),
        '[NOTORYX SOS] Need help | 2026-10-16 14:05 UTC | Radio advert 35.1235,-80.5000 (may be stale) | Battery 64%',
      );
      expect(sosText(at), contains('No position'));
      expect(
        sosAllClearText(at),
        '[NOTORYX SOS] All clear | 2026-10-16 14:05 UTC',
      );
    });
    test('repeats every five minutes, at most twelve times', () {
      var s = const SosState(active: true);
      expect(s.dueAt(at), true);
      s = s.sent(at);
      expect(s.dueAt(at.add(const Duration(minutes: 4))), false);
      expect(s.nextSendAt, at.add(sosRepeatInterval));
      expect(s.dueAt(at.add(sosRepeatInterval)), true);
      for (var i = 1; i < sosMaxSends; i++) {
        s = s.sent(at);
      }
      expect(s.sends, sosMaxSends);
      expect(s.dueAt(at.add(const Duration(hours: 1))), false);
      expect(s.nextSendAt, isNull);
    });
    test('acknowledgement stops repeats', () {
      final s = const SosState(active: true).sent(at).acknowledged('Sam');
      expect(s.dueAt(at.add(const Duration(hours: 1))), false);
      expect(s.nextSendAt, isNull);
      expect(SosState.idle.dueAt(at), false);
    });
    test('needs a radio and somewhere to send', () {
      String? reason({
        bool connected = true,
        int contacts = 1,
        bool channel = false,
      }) => sosUnavailableReason(
        ready: true,
        storageError: false,
        connected: connected,
        selectedContacts: contacts,
        availableContacts: contacts,
        hasChannel: channel,
      );
      expect(reason(), isNull);
      expect(reason(connected: false), contains('Connect'));
      expect(reason(contacts: 0), contains('SOS channel'));
      expect(reason(contacts: 0, channel: true), isNull);
    });
    test('SOS channel survives a save', () {
      final plan = TripPlan.fromJson(const TripPlan(sosChannel: 2).toJson());
      expect(plan.sosChannel, 2);
      expect(TripPlan.fromJson(const {}).sosChannel, -1);
    });
  });

  group('FieldOpsService SOS', () {
    late _Radio radio;
    late FieldOpsService ops;
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      radio = _Radio();
      ops = FieldOpsService(radio);
      await ops.load();
      await ops.configureTrip(
        TripPlan(members: [radio.person.publicKeyHex], sosChannel: 2),
      );
    });
    tearDown(() async {
      ops.dispose();
      await radio.stream.close();
      radio.dispose();
    });

    test('sends to contacts and channel without an active trip', () async {
      expect(ops.trip.active, false);
      await ops.startSos();
      expect(ops.sos.active, true);
      expect(ops.sos.sends, 1);
      expect(radio.sent.single.text, startsWith('[NOTORYX SOS] Need help'));
      expect(
        radio.channelSends.single,
        startsWith('#search-team: [NOTORYX SOS]'),
      );
      expect(ops.entries.where((e) => e.kind == 'sos'), hasLength(3));
      // Not due again until the repeat interval passes.
      await ops.sosTick();
      expect(radio.sent, hasLength(1));
    });

    test('a reply from a trip contact acknowledges it', () async {
      await ops.startSos();
      radio.stream.add(
        Message(
          senderKey: radio.person.publicKey,
          text: 'On our way',
          timestamp: DateTime.now(),
          isOutgoing: false,
        ),
      );
      await pumpEventQueue();
      expect(ops.sos.acknowledgedBy, 'Trail partner');
      expect(ops.sos.nextSendAt, isNull);
      expect(
        ops.entries.any(
          (e) => e.text.contains('acknowledged by Trail partner'),
        ),
        true,
      );
    });

    test('stop with all clear tells everyone once', () async {
      await ops.startSos();
      await ops.stopSos(allClear: true);
      expect(ops.sos.active, false);
      expect(radio.sent.last.text, startsWith('[NOTORYX SOS] All clear'));
      expect(radio.channelSends.last, contains('All clear'));
      expect(radio.sent, hasLength(2));
    });

    test('refuses while disconnected', () async {
      radio.connected = false;
      await expectLater(ops.startSos(), throwsStateError);
      expect(radio.sent, isEmpty);
    });
  });

  group('SOS panel', () {
    late _Radio radio;
    late FieldOpsService ops;
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      radio = _Radio();
      ops = FieldOpsService(radio);
      await ops.load();
      await ops.configureTrip(TripPlan(members: [radio.person.publicKeyHex]));
    });
    tearDown(() async {
      ops.dispose();
      await radio.stream.close();
      radio.dispose();
    });

    // Storage writes were chained outside the test's fake clock in setUp, so
    // let real time pass for them.
    Future<void> settle(WidgetTester tester) async {
      for (var i = 0; i < 3; i++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 20)),
        );
        await tester.pump();
      }
    }

    Widget app() => MultiProvider(
      providers: [
        ChangeNotifierProvider<MeshCoreConnector>.value(value: radio),
        ChangeNotifierProvider<FieldOpsService>.value(value: ops),
      ],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: SosPanel()),
      ),
    );

    testWidgets('a tap does not send; a 2 second hold does', (tester) async {
      await tester.pumpWidget(app());
      await tester.tap(find.byKey(const ValueKey('sos-hold')));
      await tester.pump(const Duration(seconds: 3));
      expect(radio.sent, isEmpty);

      final gesture = await tester.startGesture(
        tester.getCenter(find.byKey(const ValueKey('sos-hold'))),
      );
      await tester.pump(); // The hold animation starts on this frame.
      await tester.pump(const Duration(milliseconds: 1000));
      expect(find.text('KEEP HOLDING…'), findsOneWidget);
      expect(radio.sent, isEmpty);
      await tester.pump(const Duration(milliseconds: 1100));
      await gesture.up();
      await settle(tester);

      expect(radio.sent, hasLength(1));
      expect(find.text('SOS ACTIVE'), findsOneWidget);

      await tester.tap(find.text("I'M SAFE"));
      await settle(tester);
      expect(find.text('HOLD FOR SOS'), findsOneWidget);
      ops.dispose();
      ops = FieldOpsService(radio);
    });
  });
}
