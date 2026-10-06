import 'dart:async';
import 'dart:convert';
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
  bool connected = true;
  final stream = StreamController<Message>.broadcast();
  final sent = <Message>[];
  final person = Contact(
    publicKey: Uint8List.fromList(List.filled(32, 7)),
    name: 'Trail partner',
    type: advTypeChat,
    pathLength: -1,
    path: Uint8List(0),
    lastSeen: DateTime.now(),
  );
  @override
  bool get isConnected => connected;
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
  late _Radio radio;
  late FieldOpsService ops;
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    radio = _Radio();
    ops = FieldOpsService(radio);
    await ops.load();
  });
  tearDown(() async {
    ops.dispose();
    await radio.stream.close();
    radio.dispose();
  });
  test('restart never silently resumes trip or automation', () async {
    await ops.configureTrip(TripPlan(members: [radio.person.publicKeyHex]));
    await ops.startTrip();
    await ops.enableAutomations(true);
    final restored = FieldOpsService(radio);
    await restored.load();
    expect(restored.trip.active, false);
    expect(restored.automationEnabled, false);
    expect(restored.trip.members, [radio.person.publicKeyHex]);
    restored.dispose();
  });
  test(
    'check-in queues once per recipient and log follows actual acknowledgment',
    () async {
      await ops.configureTrip(TripPlan(members: [radio.person.publicKeyHex]));
      await ops.startTrip();
      await ops.sendCheckIn(ops.previewCheckIn("I'm OK"));
      expect(radio.sent, hasLength(1));
      expect(ops.entries.first.status, 'pending');
      expect(radio.sent.single.text, isNot(contains('Radio advert')));
      radio.sent[0] = radio.sent[0].copyWith(status: MessageStatus.delivered);
      radio.changed();
      expect(ops.entries.first.status, 'delivered');
    },
  );
  test('inactive trip and disconnected radio cannot send check-ins', () async {
    await ops.configureTrip(TripPlan(members: [radio.person.publicKeyHex]));
    await expectLater(
      ops.sendCheckIn(ops.previewCheckIn('At Camp')),
      throwsStateError,
    );
    await ops.startTrip();
    radio.connected = false;
    await expectLater(
      ops.sendCheckIn(ops.previewCheckIn('At Camp')),
      throwsStateError,
    );
    expect(radio.sent, isEmpty);
  });
  test(
    'dry-run scheduled rule records action without any radio send',
    () async {
      await ops.configureTrip(TripPlan(members: [radio.person.publicKeyHex]));
      await ops.startTrip();
      await ops.enableAutomations(true);
      final i = ops.rules.indexWhere(
        (r) => r.trigger == FieldTrigger.scheduled,
      );
      ops.rules[i] = FieldRule(
        id: 'scheduled',
        trigger: FieldTrigger.scheduled,
        action: FieldAction.checkIn,
        enabled: true,
        nextDue: DateTime.now().subtract(const Duration(seconds: 1)),
      );
      await ops.tick();
      expect(radio.sent, isEmpty);
      expect(ops.entries.any((e) => e.text.startsWith('DRY RUN:')), true);
    },
  );
  test('late schedule logs missed action and never catches up', () async {
    await ops.configureTrip(TripPlan(members: [radio.person.publicKeyHex]));
    await ops.startTrip();
    await ops.enableAutomations(true);
    final i = ops.rules.indexWhere((r) => r.trigger == FieldTrigger.scheduled);
    ops.rules[i] = FieldRule(
      id: 'scheduled',
      trigger: FieldTrigger.scheduled,
      action: FieldAction.checkIn,
      enabled: true,
      dryRun: false,
      nextDue: DateTime.now().subtract(const Duration(minutes: 10)),
    );
    await ops.tick();
    await ops.tick();
    expect(radio.sent, isEmpty);
    expect(ops.entries.where((e) => e.kind == 'missed'), hasLength(1));
  });
  test(
    'automatic transmission budget persists before sending and rate limits batches',
    () async {
      await ops.configureTrip(TripPlan(members: [radio.person.publicKeyHex]));
      await ops.startTrip();
      await ops.enableAutomations(true);
      await ops.sendCheckIn(ops.previewCheckIn("I'm OK"), automatic: true);
      await ops.sendCheckIn(ops.previewCheckIn("I'm OK"), automatic: true);
      expect(radio.sent, hasLength(1));
      final raw = (await SharedPreferences.getInstance()).getString(
        'bastion_field_ops_v1',
      )!;
      expect(jsonDecode(raw)['lastAutoSend'], isNotNull);
    },
  );
  test(
    'corrupt storage is retained and transmission features stay blocked',
    () async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('bastion_field_ops_v1', 'damaged');
      final damaged = FieldOpsService(radio);
      await damaged.load();
      expect(damaged.error, isNotNull);
      await expectLater(damaged.enableAutomations(true), throwsStateError);
      expect(prefs.getString('bastion_field_ops_v1'), 'damaged');
      damaged.dispose();
    },
  );
  test('log export retains timestamp, kind and delivery state', () async {
    await ops.record('note', 'Creek crossing');
    final exported = jsonDecode(ops.exportLog()) as Map;
    expect(exported['schema'], 1);
    expect(exported['entries'][0]['text'], 'Creek crossing');
    expect(DateTime.tryParse(exported['entries'][0]['at']), isNotNull);
    await ops.clearLog();
    expect(ops.entries, isEmpty);
  });
  test(
    'position sharing rejects invalid coordinates and fits the field packet budget',
    () {
      expect(usablePosition(0, 0), false);
      expect(usablePosition(double.nan, 1), false);
      expect(usablePosition(91, 1), false);
      final text = checkInText(
        'Heading Back',
        DateTime.utc(2026, 10, 5),
        latitude: 35.3,
        longitude: -83.8,
        battery: 100,
      );
      expect(utf8.encode(text).length, lessThanOrEqualTo(140));
      expect(text, contains('may be stale'));
    },
  );
}
