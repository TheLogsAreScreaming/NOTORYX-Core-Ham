import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/models/app_settings.dart';
import 'package:meshcore_open/models/channel_message.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/storage/channel_message_store.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';

ChannelMessage _msg(String text, Duration age) => ChannelMessage(
  senderKey: Uint8List(0),
  senderName: 'Alex',
  text: text,
  timestamp: DateTime.now().subtract(age),
  isOutgoing: false,
  status: ChannelMessageStatus.sent,
  channelIndex: 0,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const self = 'aabbccddeeff00112233';

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
  });

  test('keeps messages at or after the cutoff, in order', () {
    final list = [
      _msg('old', const Duration(days: 40)),
      _msg('new', const Duration(days: 1)),
    ];
    final kept = keepChannelMessagesSince(
      list,
      DateTime.now().subtract(const Duration(days: 30)),
    );
    expect(kept.map((m) => m.text), ['new']);
  });

  test('the setting saves and only accepts offered choices', () {
    final s = AppSettings().copyWith(channelMessageRetentionDays: 30);
    expect(AppSettings.fromJson(s.toJson()).channelMessageRetentionDays, 30);
    expect(
      AppSettings.fromJson({
        'channel_message_retention_days': 3,
      }).channelMessageRetentionDays,
      0,
    );
    expect(AppSettings().channelMessageRetentionDays, 0);
  });

  test('pruning deletes old saved messages only when turned on', () async {
    final store = ChannelMessageStore()..setPublicKeyHex = self;
    await store.saveChannelMessages(0, [
      _msg('last month', const Duration(days: 40)),
      _msg('this week', const Duration(days: 2)),
    ]);
    final settings = AppSettingsService();
    await settings.loadSettings();
    final radio = MeshCoreConnector()..debugUseChannelStore(self, settings);

    expect(await radio.pruneOldChannelMessages(maxChannels: 1), 0);
    expect(await store.loadChannelMessages(0), hasLength(2));

    await settings.setChannelMessageRetentionDays(30);
    expect(await radio.pruneOldChannelMessages(maxChannels: 1), 1);
    expect((await store.loadChannelMessages(0)).map((m) => m.text), [
      'this week',
    ]);
    radio.dispose();
  });
}
