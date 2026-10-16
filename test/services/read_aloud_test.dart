import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/app_settings.dart';
import 'package:meshcore_open/models/channel_message.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/message.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/services/read_aloud_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';

final _sam = Contact(
  publicKey: Uint8List.fromList(List.filled(32, 7)),
  name: 'Sam',
  type: advTypeChat,
  pathLength: -1,
  path: Uint8List(0),
  lastSeen: DateTime.now(),
);

class _Radio extends MeshCoreConnector {
  final direct = StreamController<Message>.broadcast();
  final channel = StreamController<ReceivedChannelMessage>.broadcast();
  @override
  List<Contact> get contacts => [_sam];
  @override
  Stream<Message> get receivedDirectMessages => direct.stream;
  @override
  Stream<ReceivedChannelMessage> get receivedChannelMessages => channel.stream;
}

class _Speaker implements Speaker {
  final said = <String>[];
  Completer<void>? hold;
  @override
  Future<void> speak(String text) async {
    said.add(text);
    await hold?.future;
  }

  @override
  Future<void> stop() async {}
}

Message _dm(String text) => Message(
  senderKey: _sam.publicKey,
  text: text,
  timestamp: DateTime.now(),
  isOutgoing: false,
);

ReceivedChannelMessage _ch(String text) => ReceivedChannelMessage(
  ChannelMessage(
    senderKey: null,
    senderName: 'Alex',
    text: text,
    timestamp: DateTime.now(),
    isOutgoing: false,
    status: ChannelMessageStatus.sent,
    channelIndex: 0,
  ),
  'Public',
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('spoken text drops tags, links and things not worth saying', () {
    expect(
      spokenText('[Bastion Check-in] At Camp | 2026-10-16 14:05 UTC'),
      'Check-in. At Camp. 2026-10-16 14:05 UTC',
    );
    expect(spokenText('[Bastion SOS] Need help'), startsWith('S O S. Need'));
    expect(spokenText('map at https://x.example/a?b=1 ok'), 'map at a link ok');
    expect(spokenText('   '), isNull);
    expect(spokenText('x' * 400)!.length, 301);
  });

  test('the setting is saved and only accepts known values', () {
    final on = AppSettings().copyWith(readAloudIncoming: 'all');
    expect(AppSettings.fromJson(on.toJson()).readAloudIncoming, 'all');
    expect(
      AppSettings.fromJson({'read_aloud_incoming': 'loud'}).readAloudIncoming,
      'off',
    );
  });

  group('service', () {
    late _Radio radio;
    late AppSettingsService settings;
    late _Speaker speaker;
    late ReadAloudService service;
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      PrefsManager.reset();
      await PrefsManager.initialize();
      settings = AppSettingsService();
      await settings.loadSettings();
      radio = _Radio();
      speaker = _Speaker();
      service = ReadAloudService(radio, settings, speaker: speaker);
    });
    tearDown(() {
      service.dispose();
      radio.dispose();
    });

    Future<void> idle() => pumpEventQueue();

    test('off by default; reading from the menu still works', () async {
      radio.direct.add(_dm('hello'));
      await idle();
      expect(speaker.said, isEmpty);
      await service.read('Sam', 'hello');
      expect(speaker.said, ['Sam says: hello']);
    });

    test('direct mode reads direct messages only', () async {
      await settings.setReadAloudIncoming('direct');
      radio.direct.add(_dm('on my way'));
      radio.channel.add(_ch('anyone out there'));
      await idle();
      expect(speaker.said, ['Sam says: on my way']);
    });

    test('all mode reads channels too, but not in the background', () async {
      await settings.setReadAloudIncoming('all');
      radio.channel.add(_ch('anyone out there'));
      await idle();
      expect(speaker.said, ['Alex on Public: anyone out there']);
      service.foreground = false;
      radio.direct.add(_dm('quiet'));
      await idle();
      expect(speaker.said, hasLength(1));
    });

    test('a burst is capped so it does not talk for minutes', () async {
      await settings.setReadAloudIncoming('direct');
      speaker.hold = Completer<void>();
      for (var i = 0; i < 6; i++) {
        radio.direct.add(_dm('m$i'));
      }
      await idle();
      speaker.hold!.complete();
      await idle();
      expect(speaker.said, ['Sam says: m0', 'Sam says: m1', 'Sam says: m2']);
    });
  });
}
