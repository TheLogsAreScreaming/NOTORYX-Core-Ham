import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/delivery_diagnosis.dart';
import 'package:meshcore_open/models/message.dart';

final now = DateTime(2026, 11, 7, 12);

Message sent({
  MessageStatus status = MessageStatus.failed,
  int retries = 0,
  int? pathLength = 2,
  List<int> path = const [0xA1, 0x3F],
  bool radioTookIt = true,
  int? tripMs,
}) => Message(
  senderKey: Uint8List(32),
  text: 'At camp',
  timestamp: now.subtract(const Duration(minutes: 5)),
  isOutgoing: true,
  status: status,
  retryCount: retries,
  sentAt: radioTookIt ? now.subtract(const Duration(minutes: 5)) : null,
  deliveredAt: status == MessageStatus.delivered ? now : null,
  tripTimeMs: tripMs,
  pathLength: pathLength,
  pathBytes: Uint8List.fromList(path),
);

Contact friend({Duration heard = const Duration(minutes: 10)}) => Contact(
  publicKey: Uint8List.fromList(List.filled(32, 7)),
  name: 'Sam',
  type: advTypeChat,
  pathLength: 2,
  path: Uint8List(0),
  lastSeen: now.subtract(heard),
);

DeliveryDiagnosis diagnose(
  Message m, {
  Contact? contact,
  int maxRetries = 5,
  int floodAttempts = 2,
}) => diagnoseDelivery(
  m,
  maxRetries: maxRetries,
  floodAttempts: floodAttempts,
  contact: contact ?? friend(),
  now: now,
);

void main() {
  test('delivered over the saved route', () {
    final d = diagnose(sent(status: MessageStatus.delivered, tripMs: 2300));
    expect(d.verdict, DeliveryVerdict.delivered);
    expect(d.attemptsMade, 1);
    expect(d.lastRouteFlood, isFalse);
    expect(d.lastRouteHashes, ['A1', '3F']);
    expect(d.tripTime, const Duration(milliseconds: 2300));
  });

  test('delivered by flood once the direct tries failed', () {
    final d = diagnose(
      sent(status: MessageStatus.delivered, retries: 5, pathLength: -1),
    );
    expect(d.verdict, DeliveryVerdict.deliveredByFlood);
    expect(d.attemptsMade, 6);
    expect(d.totalTries, 7);
    expect(d.lastRouteHashes, isEmpty);
  });

  test('a contact with no route floods from the start: plain delivered', () {
    final d = diagnose(
      sent(status: MessageStatus.delivered, pathLength: -1, path: const []),
    );
    expect(d.verdict, DeliveryVerdict.delivered);
  });

  test('pending while attempts remain', () {
    final d = diagnose(sent(status: MessageStatus.sent, retries: 2));
    expect(d.verdict, DeliveryVerdict.pending);
    expect(d.attemptsMade, 3);
  });

  test('the radio never took it', () {
    final d = diagnose(sent(radioTookIt: false));
    expect(d.verdict, DeliveryVerdict.notSent);
    expect(d.attemptsMade, 0);
  });

  test('failed and the contact has been quiet for hours', () {
    final d = diagnose(
      sent(retries: 6, pathLength: -1),
      contact: friend(heard: const Duration(hours: 9)),
    );
    expect(d.verdict, DeliveryVerdict.failedQuiet);
    expect(d.contactQuiet?.inHours, 9);
  });

  test('failed over the saved route with flood attempts off', () {
    final d = diagnose(sent(retries: 4), floodAttempts: 0);
    expect(d.verdict, DeliveryVerdict.failedNoFlood);
  });

  test('failed after every route', () {
    final d = diagnose(sent(retries: 6, pathLength: -1));
    expect(d.verdict, DeliveryVerdict.failedNoAck);
    expect(d.contactQuiet, isNull);
  });

  test('a contact clock ahead of this phone is not called quiet', () {
    final ahead = Contact(
      publicKey: Uint8List.fromList(List.filled(32, 8)),
      name: 'Ahead',
      type: advTypeChat,
      pathLength: 0,
      path: Uint8List(0),
      lastSeen: now.add(const Duration(days: 2)),
    );
    final d = diagnose(sent(retries: 6, pathLength: -1), contact: ahead);
    expect(d.contactQuiet, isNull);
  });

  test('two-byte hop hashes are grouped per hop', () {
    final d = diagnose(
      sent(
        status: MessageStatus.delivered,
        path: const [0xA1, 0xB2, 0x3F, 0x4E],
      ),
    );
    expect(d.lastRouteHashes, ['A1B2', '3F4E']);
  });
}
