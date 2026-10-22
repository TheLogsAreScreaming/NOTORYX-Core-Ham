import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/channel_message.dart';
import 'package:meshcore_open/storage/channel_message_store.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late ChannelMessageStore store;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    store = ChannelMessageStore()..publicKeyHex = '1234567890';
  });

  ChannelMessage message(String text, {bool viaMqtt = false}) => ChannelMessage(
    senderName: 'Alice',
    text: text,
    timestamp: DateTime.fromMillisecondsSinceEpoch(1760000000000),
    isOutgoing: false,
    status: ChannelMessageStatus.sent,
    channelIndex: 1,
    viaMqtt: viaMqtt,
  );

  test('viaMqtt survives a save and load', () async {
    await store.saveChannelMessages(1, [
      message('cloud', viaMqtt: true),
      message('radio'),
    ]);
    final loaded = await store.loadChannelMessages(1);
    expect(loaded.map((m) => m.viaMqtt), [true, false]);
  });

  test('messages stored before viaMqtt existed load as not via MQTT', () async {
    await PrefsManager.instance.setString(
      '${store.keyFor}1',
      jsonEncode([
        {
          'senderName': 'Alice',
          'text': 'old',
          'timestamp': 1760000000000,
          'isOutgoing': false,
          'status': ChannelMessageStatus.sent.index,
          'channelIndex': 1,
        },
      ]),
    );
    final loaded = await store.loadChannelMessages(1);
    expect(loaded.single.text, 'old');
    expect(loaded.single.viaMqtt, isFalse);
  });

  test('copyWith keeps or changes viaMqtt', () {
    final flagged = message('cloud', viaMqtt: true);
    expect(flagged.copyWith(repeatCount: 2).viaMqtt, isTrue);
    expect(flagged.copyWith(viaMqtt: false).viaMqtt, isFalse);
    expect(message('radio').viaMqtt, isFalse);
  });
}
