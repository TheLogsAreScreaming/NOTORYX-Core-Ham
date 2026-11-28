import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/screens/channel_chat_screen.dart';
import 'package:meshcore_open/screens/chat_screen.dart';
import 'package:meshcore_open/screens/discovery_screen.dart';
import 'package:meshcore_open/services/notification_router.dart';
import 'package:meshcore_open/services/notification_service.dart';
import 'package:meshcore_open/storage/draft_store.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _sam = Contact(
  publicKey: Uint8List.fromList(List.generate(32, (i) => i + 1)),
  name: 'Sam',
  type: advTypeChat,
  path: Uint8List(0),
  pathLength: 0,
  lastSeen: DateTime(2026, 10, 30),
);
final _hiking = Channel(
  index: 2,
  name: '#hiking',
  psk: Uint8List.fromList(List.filled(16, 2)),
);

class _Radio extends MeshCoreConnector {
  @override
  Contact? getContactByPubKeyHex(String hex) =>
      hex == _sam.publicKeyHex ? _sam : null;
  @override
  List<Channel> get channels => [_hiking];
}

void main() {
  final router = NotificationRouter(GlobalKey<NavigatorState>(), _Radio());

  test('a message opens that conversation', () {
    final screen = router.screenFor('message:${_sam.publicKeyHex}');
    expect(screen, isA<ChatScreen>());
    expect((screen! as ChatScreen).contact.name, 'Sam');
  });

  test('a channel post opens that channel', () {
    final screen = router.screenFor('channel:2');
    expect(screen, isA<ChannelChatScreen>());
    expect((screen! as ChannelChatScreen).channel.name, '#hiking');
  });

  test('a new advert opens Discovered contacts', () {
    expect(router.screenFor('advert:abc'), isA<DiscoveryScreen>());
  });

  test('anything gone or unknown opens nothing', () {
    expect(router.screenFor('message:ffff'), isNull);
    expect(router.screenFor('channel:9'), isNull);
    expect(router.screenFor('batch'), isNull);
  });

  group('quick reply', () {
    TestWidgetsFlutterBinding.ensureInitialized();

    late _SendingRadio radio;
    const self = 'aabbccddeeff00112233';
    String draftFor() => DraftStore.contactKey(self, _sam.publicKeyHex);

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await PrefsManager.initialize();
      await DraftStore.save(draftFor(), '');
      radio = _SendingRadio();
    });

    test('sends to the contact when connected', () async {
      radio.connected = true;
      await NotificationRouter(
        GlobalKey<NavigatorState>(),
        radio,
      ).reply('message:${_sam.publicKeyHex}', 'on my way');
      expect(radio.sent, ['Sam:on my way']);
      expect(DraftStore.load(draftFor()), isNull);
    });

    test('sends to the channel when connected', () async {
      radio.connected = true;
      await NotificationRouter(
        GlobalKey<NavigatorState>(),
        radio,
      ).reply('channel:2', 'hello');
      expect(radio.sent, ['#hiking:hello']);
    });

    test('with no radio it becomes a draft', () async {
      await NotificationRouter(
        GlobalKey<NavigatorState>(),
        radio,
      ).reply('message:${_sam.publicKeyHex}', 'later');
      expect(radio.sent, isEmpty);
      expect(DraftStore.load(draftFor()), 'later');
    });

    test('while the app is locked it becomes a draft', () async {
      radio.connected = true;
      await NotificationRouter(
        GlobalKey<NavigatorState>(),
        radio,
        isLocked: () => true,
      ).reply('message:${_sam.publicKeyHex}', 'locked');
      expect(radio.sent, isEmpty);
      expect(DraftStore.load(draftFor()), 'locked');
    });

    test('too long becomes a draft, added to what was there', () async {
      radio.connected = true;
      await DraftStore.save(draftFor(), 'first');
      final long = 'x' * (maxContactMessageBytes() + 1);
      await NotificationRouter(
        GlobalKey<NavigatorState>(),
        radio,
      ).reply('message:${_sam.publicKeyHex}', long);
      expect(radio.sent, isEmpty);
      expect(DraftStore.load(draftFor()), 'first\n$long');
    });

    test('before the radio is known it waits, then drafts', () async {
      radio.selfKey = '';
      await NotificationRouter(
        GlobalKey<NavigatorState>(),
        radio,
      ).reply('message:${_sam.publicKeyHex}', 'cold');
      expect(DraftStore.load(draftFor()), isNull);
      radio.selfKey = self;
      radio.announce();
      // The connector batches its change notifications on a timer.
      for (var i = 0; i < 40 && DraftStore.load(draftFor()) == null; i++) {
        await Future<void>.delayed(const Duration(milliseconds: 50));
      }
      expect(DraftStore.load(draftFor()), 'cold');
    });

    test('only a typed reply counts as one', () {
      NotificationResponse response(String? action, String? input) =>
          NotificationResponse(
            notificationResponseType:
                NotificationResponseType.selectedNotificationAction,
            actionId: action,
            input: input,
            payload: 'channel:2',
          );
      final reply = NotificationService.replyFrom(response('reply', ' hi '));
      expect(reply?.payload, 'channel:2');
      expect(reply?.text, 'hi');
      expect(NotificationService.replyFrom(response('reply', '  ')), isNull);
      expect(NotificationService.replyFrom(response(null, null)), isNull);
    });
  });
}

class _SendingRadio extends _Radio {
  bool connected = false;
  String selfKey = 'aabbccddeeff00112233';
  final sent = <String>[];

  void announce() => notifyListeners();

  @override
  bool get isConnected => connected;
  @override
  String get selfPublicKeyHex => selfKey;
  @override
  String? get selfName => 'Me';
  @override
  String prepareContactOutboundText(Contact contact, String text) => text;
  @override
  Future<void> sendMessage(
    Contact contact,
    String text, {
    String? originalText,
    String? translatedLanguageCode,
    String? translationModelId,
  }) async => sent.add('${contact.name}:$text');
  @override
  Future<void> sendChannelMessage(
    Channel channel,
    String text, {
    String? originalText,
    String? translatedLanguageCode,
    String? translationModelId,
    bool sign = false,
  }) async => sent.add('${channel.name}:$text');
}
