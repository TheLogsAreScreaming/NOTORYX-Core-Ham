import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/field_ops.dart';
import 'package:meshcore_open/models/message.dart';
import 'package:meshcore_open/services/field_ops_service.dart';

Contact _contact(int fill, String name) => Contact(
  publicKey: Uint8List.fromList(List.filled(32, fill)),
  name: name,
  type: advTypeChat,
  pathLength: -1,
  path: Uint8List(0),
  lastSeen: DateTime.now(),
);

class _Radio extends MeshCoreConnector {
  void changed() => notifyListeners();
  final stream = StreamController<Message>.broadcast();
  final sam = _contact(7, 'Sam');
  final alex = _contact(8, 'Alex');
  final sent = <String, List<Message>>{};
  final team = Channel(
    index: 2,
    name: '#team',
    psk: Uint8List.fromList(List.filled(16, 3)),
  );
  final channelPosts = <(String, String, bool)>[];
  @override
  List<Channel> get channels => [team];
  @override
  Future<void> sendChannelMessage(
    Channel channel,
    String text, {
    String? originalText,
    String? translatedLanguageCode,
    String? translationModelId,
    bool sign = false,
  }) async => channelPosts.add((channel.name, text, sign));
  @override
  bool get isConnected => true;
  @override
  bool get isLoadingContacts => false;
  @override
  List<Contact> get contacts => [sam, alex];
  @override
  Stream<Message> get receivedDirectMessages => stream.stream;
  @override
  List<Message> getMessages(Contact c) => sent[c.publicKeyHex] ?? [];
  @override
  Future<void> sendMessage(
    Contact contact,
    String text, {
    String? originalText,
    String? translatedLanguageCode,
    String? translationModelId,
  }) async {
    (sent[contact.publicKeyHex] ??= []).add(
      Message(
        senderKey: contact.publicKey,
        text: text,
        timestamp: DateTime.now(),
        isOutgoing: true,
        status: MessageStatus.pending,
      ),
    );
  }

  void setStatus(Contact c, MessageStatus status) {
    final list = sent[c.publicKeyHex]!;
    list[list.length - 1] = list.last.copyWith(status: status);
    changed();
  }
}

FieldEntry _entry(
  String id,
  String batch,
  String key,
  String name,
  String status,
) => FieldEntry(
  id: id,
  at: DateTime.utc(2026, 10, 16, 9),
  kind: 'check-in',
  text: '$name: [NOTORYX Check-in] I\'m OK | 2026-10-16 09:00 UTC',
  contactKey: key,
  status: status,
  batch: batch,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CheckInDelivery', () {
    test('summarises the newest batch, a resend replacing the original', () {
      final entries = [
        // Newest first, as the Field Log keeps them.
        _entry('4', 'b2', 'a', 'Sam', 'delivered'), // resend
        _entry('3', 'b2', 'b', 'Alex', 'delivered'),
        _entry('2', 'b2', 'a', 'Sam', 'failed'),
        _entry('1', 'b1', 'a', 'Sam', 'failed'),
      ];
      final d = CheckInDelivery.latest(entries)!;
      expect(d.batch, 'b2');
      expect(d.statuses, {'a': 'delivered', 'b': 'delivered'});
      expect(d.headline, 'Delivered to all 2 contacts');
      expect(d.text, startsWith('[NOTORYX Check-in] '));
    });
    test('still reads check-ins logged before the NOTORYX rename', () {
      expect(isCheckInText("[Bastion Check-in] I'm OK"), isTrue);
      expect(isCheckInText("[NOTORYX Check-in] I'm OK"), isTrue);
      expect(isCheckInText('Bastion check in later'), isFalse);
    });
    test('names who it did not reach', () {
      final d = CheckInDelivery.latest([
        _entry('3', 'b', 'c', 'Jo', 'sent'),
        _entry('2', 'b', 'b', 'Alex', 'failed'),
        _entry('1', 'b', 'a', 'Sam', 'delivered'),
      ])!;
      expect(d.failedKeys, ['b']);
      expect(
        d.headline,
        'Delivered to 1 of 3 • Not delivered: Alex • Waiting for the rest',
      );
      expect(CheckInDelivery.latest(const []), isNull);
    });
    test('batch survives a save', () {
      final e = FieldEntry.fromJson(
        _entry('1', 'b9', 'a', 'Sam', 'sent').toJson(),
      );
      expect(e.batch, 'b9');
      expect(e.withStatus('delivered').batch, 'b9');
    });
  });

  group('FieldOpsService delivery', () {
    late _Radio radio;
    late FieldOpsService ops;
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      radio = _Radio();
      ops = FieldOpsService(radio);
      await ops.load();
      await ops.configureTrip(
        TripPlan(members: [radio.sam.publicKeyHex, radio.alex.publicKeyHex]),
      );
      await ops.startTrip();
    });
    tearDown(() async {
      ops.dispose();
      await radio.stream.close();
      radio.dispose();
    });

    Future<void> settle() =>
        Future<void>.delayed(const Duration(milliseconds: 120));

    test(
      'tracks each contact, alerts on failure, resends only to them',
      () async {
        await ops.sendCheckIn(ops.previewCheckIn("I'm OK"));
        final text = radio.sent[radio.sam.publicKeyHex]!.single.text;
        expect(ops.latestDelivery!.total, 2);
        expect(ops.latestDelivery!.waiting, true);

        radio.setStatus(radio.sam, MessageStatus.delivered);
        radio.setStatus(radio.alex, MessageStatus.failed);
        await settle();
        final d = ops.latestDelivery!;
        expect(d.headline, 'Delivered to 1 of 2 • Not delivered: Alex');
        expect(
          ops.entries.any(
            (e) => e.text.startsWith('Check-in not delivered to Alex'),
          ),
          true,
        );

        await ops.resendCheckIn();
        expect(radio.sent[radio.sam.publicKeyHex], hasLength(1));
        expect(radio.sent[radio.alex.publicKeyHex], hasLength(2));
        expect(radio.sent[radio.alex.publicKeyHex]!.last.text, text);
        expect(ops.latestDelivery!.batch, d.batch);

        radio.setStatus(radio.alex, MessageStatus.delivered);
        await settle();
        expect(ops.latestDelivery!.headline, 'Delivered to all 2 contacts');
        expect(
          ops.entries.where((e) => e.text == 'Delivered to all 2 contacts.'),
          hasLength(1),
        );
      },
    );

    test('resend does nothing when everyone got it', () async {
      await ops.sendCheckIn(ops.previewCheckIn('At Camp'));
      radio.setStatus(radio.sam, MessageStatus.delivered);
      radio.setStatus(radio.alex, MessageStatus.delivered);
      await settle();
      await ops.resendCheckIn();
      expect(radio.sent.values.every((l) => l.length == 1), true);
    });
  });

  group('check-in channel', () {
    late _Radio radio;
    late FieldOpsService ops;
    Future<void> start({int channel = -1}) async {
      SharedPreferences.setMockInitialValues({});
      radio = _Radio();
      ops = FieldOpsService(radio);
      await ops.load();
      await ops.configureTrip(
        TripPlan(
          members: [radio.sam.publicKeyHex, radio.alex.publicKeyHex],
          checkInChannel: channel,
        ),
      );
      await ops.startTrip();
    }

    tearDown(() async {
      ops.dispose();
      await radio.stream.close();
      radio.dispose();
    });

    test('posts each check-in to the channel, signed', () async {
      await start(channel: 2);
      await ops.sendCheckIn(ops.previewCheckIn("I'm OK"));
      final text = radio.sent[radio.sam.publicKeyHex]!.single.text;
      expect(radio.channelPosts, [('#team', text, true)]);
      // The channel is not a contact: the summary still counts two.
      expect(ops.latestDelivery!.total, 2);
      expect(ops.entries.any((e) => e.text == '#team: $text'), isTrue);
    });

    test('a resend to missed contacts does not repost', () async {
      await start(channel: 2);
      await ops.sendCheckIn(ops.previewCheckIn("I'm OK"));
      radio.setStatus(radio.alex, MessageStatus.failed);
      await Future<void>.delayed(const Duration(milliseconds: 120));
      await ops.resendCheckIn();
      expect(radio.channelPosts, hasLength(1));
    });

    test('without a channel nothing is posted', () async {
      await start();
      await ops.sendCheckIn(ops.previewCheckIn("I'm OK"));
      expect(radio.channelPosts, isEmpty);
    });
  });

  test('the channel choice is saved with the trip', () {
    final back = TripPlan.fromJson(const TripPlan(checkInChannel: 2).toJson());
    expect(back.checkInChannel, 2);
    expect(TripPlan.fromJson(const {}).checkInChannel, -1);
  });
}
