import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/field_ops.dart';
import 'package:meshcore_open/models/message.dart';
import 'package:meshcore_open/services/field_ops_service.dart';

class _Radio extends MeshCoreConnector {
  void changed() => notifyListeners();
  final stream = StreamController<Message>.broadcast();
  final sent = <Message>[];
  DateTime seen = DateTime.utc(2026, 10, 16, 8);
  Contact get person => Contact(
    publicKey: Uint8List.fromList(List.filled(32, 7)),
    name: 'Trail partner',
    type: advTypeChat,
    pathLength: -1,
    path: Uint8List(0),
    lastSeen: seen,
  );
  @override
  bool get isConnected => true;
  @override
  bool get isLoadingContacts => false;
  @override
  List<Contact> get contacts => [person];
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
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('overdueMembers', () {
    final start = DateTime.utc(2026, 10, 16, 9);
    const hour = Duration(hours: 1);
    test('time before the trip started does not count', () {
      expect(
        overdueMembers(
          members: ['a'],
          lastHeard: {'a': start.subtract(const Duration(days: 1))},
          tripStarted: start,
          now: start.add(const Duration(minutes: 59)),
          overdue: hour,
        ),
        isEmpty,
      );
    });
    test('quiet past the limit is overdue; recent activity is not', () {
      expect(
        overdueMembers(
          members: ['a', 'b'],
          lastHeard: {'b': start.add(const Duration(minutes: 30))},
          tripStarted: start,
          now: start.add(const Duration(minutes: 61)),
          overdue: hour,
        ),
        ['a'],
      );
    });
  });

  test('reminder setting is saved and limited to the choices', () {
    expect(
      TripPlan.fromJson(
        const TripPlan(reminderMinutes: 60).toJson(),
      ).reminderMinutes,
      60,
    );
    expect(TripPlan.fromJson(const {'reminderMinutes': 7}).reminderMinutes, 0);
    expect(
      tripBrief(const TripPlan(reminderMinutes: 120), const {}),
      contains('Check-in reminder: every 120 minutes'),
    );
  });

  group('FieldOpsService trip watch', () {
    late _Radio radio;
    late FieldOpsService ops;
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      radio = _Radio();
      ops = FieldOpsService(radio);
      await ops.load();
      await ops.configureTrip(
        TripPlan(
          members: [radio.person.publicKeyHex],
          overdueMinutes: 30,
          reminderMinutes: 60,
        ),
      );
      await ops.startTrip();
    });
    tearDown(() async {
      ops.dispose();
      await radio.stream.close();
      radio.dispose();
    });

    test(
      'reminder follows the last check-in and clears when the trip ends',
      () async {
        final started = ops.tripStartedAt!;
        expect(ops.reminderAt, started.add(const Duration(minutes: 60)));
        await ops.sendCheckIn(ops.previewCheckIn("I'm OK"));
        expect(ops.lastCheckInAt, isNotNull);
        expect(
          ops.reminderAt,
          ops.lastCheckInAt!.add(const Duration(minutes: 60)),
        );
        await ops.endTrip();
        expect(ops.reminderAt, isNull);
      },
    );

    test('alerts once when a contact goes quiet, clears when heard', () async {
      final start = ops.tripStartedAt!;
      await ops.watchTick(start.add(const Duration(minutes: 29)));
      expect(ops.overdueNames, isEmpty);

      await ops.watchTick(start.add(const Duration(minutes: 31)));
      expect(ops.overdueNames, ['Trail partner']);
      await ops.watchTick(start.add(const Duration(minutes: 40)));
      expect(
        ops.entries.where((e) => e.text.contains('not heard from')),
        hasLength(1),
      );

      radio.stream.add(
        Message(
          senderKey: radio.person.publicKey,
          text: 'All good',
          timestamp: DateTime.now(),
          isOutgoing: false,
        ),
      );
      await pumpEventQueue();
      expect(ops.overdueNames, isEmpty);
      expect(ops.entries.any((e) => e.text.contains('heard from again')), true);
    });

    test('a new advert counts as activity', () async {
      final start = ops.tripStartedAt!;
      await ops.watchTick(start.add(const Duration(minutes: 31)));
      expect(ops.overdueNames, hasLength(1));
      radio.seen = radio.seen.add(const Duration(hours: 2));
      radio.changed();
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(ops.overdueNames, isEmpty);
    });

    test('no alerts once the trip ends', () async {
      final start = ops.tripStartedAt!;
      await ops.endTrip();
      await ops.watchTick(start.add(const Duration(hours: 5)));
      expect(ops.overdueNames, isEmpty);
    });
  });
}
