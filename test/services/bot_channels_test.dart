import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/models/bot_settings.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/models/channel_message.dart';
import 'package:meshcore_open/services/bot_engine.dart';
import 'package:meshcore_open/services/bot_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _public = Channel(
  index: 0,
  name: 'Public',
  psk: Uint8List.fromList(List.filled(16, 1)),
);
final _hiking = Channel(
  index: 1,
  name: '#hiking',
  psk: Uint8List.fromList(List.filled(16, 2)),
);

class _Radio extends MeshCoreConnector {
  final incoming = StreamController<ChannelMessage>.broadcast();
  final sent = <(String, String)>[];

  @override
  bool get isConnected => true;
  @override
  List<Channel> get channels => [_public, _hiking];
  @override
  Stream<ChannelMessage> get radioChannelMessages => incoming.stream;
  @override
  Future<void> sendChannelMessage(
    Channel channel,
    String text, {
    String? originalText,
    String? translatedLanguageCode,
    String? translationModelId,
    bool sign = false,
  }) async => sent.add((channel.name, text));
}

ChannelMessage _post(
  String text, {
  int channel = 1,
  String from = 'Sam',
  bool outgoing = false,
  bool mqtt = false,
}) => ChannelMessage(
  senderName: from,
  text: text,
  timestamp: DateTime.now(),
  isOutgoing: outgoing,
  viaMqtt: mqtt,
  channelIndex: channel,
);

void main() {
  group('engine in a channel', () {
    final now = DateTime.utc(2026, 10, 30, 12);
    String? reply(BotEngine engine, String text, {String id = 'a'}) =>
        engine.reply(
          settings: BotSettings(
            enabled: true,
            shareLocation: true,
            rules: const [
              BotRule(trigger: 'hello', response: 'Hi', contains: true),
            ],
          ),
          messageId: id,
          sender: 'sam',
          text: text,
          timestamp: now,
          now: now,
          commandResponses: {'!ping': 'Pong', '!where': 'Here'},
          channel: true,
        );

    test('answers commands only: no away replies or keyword rules', () {
      expect(reply(BotEngine(), '!ping'), '${botPrefix}Pong');
      expect(reply(BotEngine(), 'anyone around?'), isNull);
      expect(reply(BotEngine(), 'hello all'), isNull);
    });

    test('never shares the location in a channel', () {
      expect(reply(BotEngine(), '!where'), isNull);
    });
  });

  test('channel choices survive a save', () {
    final id = botChannelId(_hiking.psk);
    final back = BotSettings.fromJson(BotSettings(channels: {id}).toJson());
    expect(back.channels, {id});
    expect(BotSettings().channels, isEmpty);
    expect(id, hasLength(16));
    expect(botChannelId(_public.psk), isNot(id));
  });

  test('a reply names the sender when it fits', () {
    expect(channelBotReply('${botPrefix}Pong', 'Sam'), '$botPrefix@Sam Pong');
    final long = '$botPrefix${'x' * 120}';
    expect(channelBotReply(long, 'A very long sender name'), long);
  });

  group('service', () {
    late _Radio radio;
    late BotService bot;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      PrefsManager.reset();
      await PrefsManager.initialize();
      radio = _Radio();
      bot = BotService(radio);
      await bot.load();
    });
    tearDown(() {
      bot.dispose();
      PrefsManager.reset();
    });

    Future<void> hear(ChannelMessage m) async {
      radio.incoming.add(m);
      await Future<void>.delayed(const Duration(milliseconds: 20));
    }

    test('stays quiet in channels until one is turned on', () async {
      await bot.save(BotSettings(enabled: true));
      await hear(_post('!ping'));
      expect(radio.sent, isEmpty);
    });

    test(
      'answers in the channel it is turned on for, and only there',
      () async {
        await bot.save(
          BotSettings(enabled: true, channels: {botChannelId(_hiking.psk)}),
        );
        await hear(_post('!ping', channel: 0));
        expect(radio.sent, isEmpty);
        await hear(_post('!ping', channel: 1));
        expect(radio.sent, [
          ('#hiking', '${botPrefix}@Sam Pong — NOTORYX Core online'),
        ]);
      },
    );

    test('ignores its own posts, MQTT copies and Bot Mode off', () async {
      final on = {botChannelId(_hiking.psk)};
      await bot.save(BotSettings(enabled: false, channels: on));
      await hear(_post('!ping'));
      await bot.save(BotSettings(enabled: true, channels: on));
      await hear(_post('!ping', outgoing: true));
      await hear(_post('!ping', mqtt: true));
      expect(radio.sent, isEmpty);
    });
  });
}
