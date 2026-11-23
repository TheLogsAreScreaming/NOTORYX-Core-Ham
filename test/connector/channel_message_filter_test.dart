import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/models/message_filter.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/services/message_filter/message_filter_service.dart';
import 'package:meshcore_open/storage/channel_message_store.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A CHANNEL_MSG_RECV frame (pre-V3 layout) carrying "[sender]: [text]".
Uint8List _frame(int channel, String sender, String text, int secondsAgo) {
  final ts = DateTime.now().millisecondsSinceEpoch ~/ 1000 - secondsAgo;
  final body = utf8.encode('$sender: $text');
  return Uint8List.fromList([
    respCodeChannelMsgRecv,
    channel,
    0, // path length: direct
    txtTypePlain,
    ts & 0xff,
    (ts >> 8) & 0xff,
    (ts >> 16) & 0xff,
    (ts >> 24) & 0xff,
    ...body,
    0,
  ]);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const self = 'aabbccddeeff00112233';
  late MeshCoreConnector radio;
  late MessageFilterService filter;
  late Channel channel;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    channel = Channel(index: 0, name: 'Public', psk: Uint8List(16));
    PrefsManager.reset();
    await PrefsManager.initialize();
    final settings = AppSettingsService();
    await settings.loadSettings();
    filter = MessageFilterService(trainer: MessageFilterService.trainInline);
    await filter.load();
    await filter.addRule(const FilterRule(id: 'r1', pattern: 'cheap coins'));
    radio = MeshCoreConnector()
      ..debugUseChannelStore(self, settings)
      ..debugUseMessageFilter(filter)
      ..debugSetChannels([channel]);
  });

  tearDown(() {
    radio.dispose();
    filter.dispose();
  });

  Future<void> receive(String sender, String text, {int secondsAgo = 5}) async {
    radio.debugHandleIncomingChannelFrame(_frame(0, sender, text, secondsAgo));
    await Future<void>.delayed(Duration.zero);
  }

  test(
    'a rule match is stored tagged, hidden and not counted unread',
    () async {
      await receive('Promo', 'Get cheap coins now');
      await receive('Ann', 'Anyone near the trailhead?', secondsAgo: 4);

      final messages = radio.getChannelMessages(channel);
      expect(messages, hasLength(2));
      final spam = messages.firstWhere((m) => m.senderName == 'Promo');
      expect(spam.filterReason, 'textRule');
      expect(spam.filterDetail, 'cheap coins');
      expect(radio.isChannelMessageHidden(channel, spam), isTrue);
      expect(
        radio.isChannelMessageHidden(
          channel,
          messages.firstWhere((m) => m.senderName == 'Ann'),
        ),
        isFalse,
      );
      // Only the real message counts; the preview skips the spam.
      expect(channel.unreadCount, 1);
      expect(radio.latestVisibleChannelMessage(channel)?.senderName, 'Ann');
    },
  );

  test('SOS, check-ins and emergency words are never hidden', () async {
    await receive('Bob', '[NOTORYX SOS] cheap coins near the lake');
    await receive('Cy', '[NOTORYX Check-in] cheap coins', secondsAgo: 4);
    await receive('Di', 'MAYDAY cheap coins', secondsAgo: 3);
    await receive('Ed', '[Bastion SOS] cheap coins', secondsAgo: 2);
    final messages = radio.getChannelMessages(channel);
    expect(messages, hasLength(4));
    expect(messages.where((m) => m.isFiltered), isEmpty);
  });

  test('a channel left out of filtering shows everything', () async {
    await filter.setChannelExcluded(
      MeshCoreConnector.messageFilterChannelId(channel),
      true,
    );
    await receive('Promo', 'Get cheap coins now');
    final message = radio.getChannelMessages(channel).single;
    expect(radio.isChannelMessageHidden(channel, message), isFalse);
    expect(channel.unreadCount, 1);
  });

  test('a new rule hides messages that already arrived; removing it shows '
      'them again', () async {
    await receive('Fay', 'Raffle tickets for sale');
    expect(radio.getChannelMessages(channel).single.isFiltered, isFalse);

    await filter.addRule(const FilterRule(id: 'r2', pattern: 'raffle'));
    expect(radio.getChannelMessages(channel).single.filterReason, 'textRule');

    await filter.removeRule('r2');
    expect(radio.getChannelMessages(channel).single.isFiltered, isFalse);
  });

  test('Spam and Not spam tag and untag in place', () async {
    await receive('Gil', 'Visit my shop');
    final message = radio.getChannelMessages(channel).single;
    await radio.markChannelMessageSpam(channel, message);
    final spam = radio.getChannelMessages(channel).single;
    expect(spam.filterReason, 'manual');
    expect(
      radio.recentFilteredChannelMessages().single.$2.messageId,
      message.messageId,
    );

    await radio.markChannelMessageNotSpam(channel, spam);
    expect(radio.getChannelMessages(channel).single.isFiltered, isFalse);
    expect(filter.notSpamExampleCount, 1);
  });

  test('the filter tag survives a save and reload', () async {
    await receive('Promo', 'Get cheap coins now');
    await Future<void>.delayed(const Duration(milliseconds: 50));
    final store = ChannelMessageStore()..setPublicKeyHex = self;
    final stored = await store.loadChannelMessages(0);
    expect(stored.single.filterReason, 'textRule');
    expect(stored.single.filterDetail, 'cheap coins');
  });
}
