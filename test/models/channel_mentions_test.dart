import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/app_settings.dart';
import 'package:meshcore_open/models/channel_message.dart';
import 'package:meshcore_open/models/channel_mentions.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

int _minute = 0;

ChannelMessage msg(String sender, {bool out = false}) => ChannelMessage(
  senderName: sender,
  text: 'hi',
  timestamp: DateTime(2026, 11, 7, 9, _minute++),
  isOutgoing: out,
);

void main() {
  group('mentionQueryAt', () {
    test('just typed @ at the start or after a space', () {
      expect(mentionQueryAt('@', 1), '');
      expect(mentionQueryAt('hey @', 5), '');
    });

    test('partial name', () {
      expect(mentionQueryAt('hey @Sa', 7), 'Sa');
      expect(mentionQueryAt('@Bob R', 6), 'Bob R');
    });

    test('not after a letter, as in an email address', () {
      expect(mentionQueryAt('me@home', 7), isNull);
    });

    test('not inside an already inserted @[name]', () {
      expect(mentionQueryAt('@[Sam] ok', 9), isNull);
      expect(mentionQueryAt('@[Sa', 4), isNull);
    });

    test('no @ or cursor out of range', () {
      expect(mentionQueryAt('hello', 5), isNull);
      expect(mentionQueryAt('@Sam', 0), isNull);
      expect(mentionQueryAt('@Sam', 9), isNull);
    });

    test('a leading or double space ends the mention', () {
      expect(mentionQueryAt('@ x', 3), isNull);
      expect(mentionQueryAt('@Sam  ok', 8), isNull);
    });
  });

  group('mentionCandidates', () {
    final history = [
      msg('Sam'),
      msg('Ridge Repeater'),
      msg('Alex'),
      msg('Me', out: true),
      msg('sam'),
      msg('Troll'),
    ];

    test('most recent first, no duplicates, no outgoing', () {
      expect(mentionCandidates(history, ''), [
        'Troll',
        'sam',
        'Alex',
        'Ridge Repeater',
      ]);
    });

    test('prefix matches before contains matches, case-insensitive', () {
      expect(mentionCandidates(history, 'r'), ['Ridge Repeater', 'Troll']);
    });

    test('blocked senders and own name are left out', () {
      expect(
        mentionCandidates(history, '', blocked: {'Troll'}, selfName: 'Alex'),
        ['sam', 'Ridge Repeater'],
      );
    });

    test('limit caps the list', () {
      expect(mentionCandidates(history, '', limit: 2), hasLength(2));
    });
  });

  group('applyMention', () {
    test('replaces the partial with @[name] and a space', () {
      final r = applyMention('hey @Sa', 7, 'Sam');
      expect(r.text, 'hey @[Sam] ');
      expect(r.cursor, r.text.length);
    });

    test('keeps text after the cursor without doubling the space', () {
      final r = applyMention('@Ri see you', 3, 'Ridge Repeater');
      expect(r.text, '@[Ridge Repeater] see you');
      expect(r.cursor, '@[Ridge Repeater] '.length);
    });
  });

  group('withoutBlockedSenders', () {
    test('hides blocked senders but keeps your own messages', () {
      final list = [msg('Troll'), msg('Sam'), msg('Troll', out: true)];
      final shown = withoutBlockedSenders(list, {'Troll'});
      expect(shown.map((m) => '${m.senderName}${m.isOutgoing}'), [
        'Samfalse',
        'Trolltrue',
      ]);
    });

    test('nothing blocked returns the same list', () {
      final list = [msg('Sam')];
      expect(identical(withoutBlockedSenders(list, {}), list), isTrue);
    });
  });

  group('blocked senders setting', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      PrefsManager.reset();
      await PrefsManager.initialize();
    });

    test('round-trips through JSON and defaults to empty', () {
      expect(AppSettings().blockedSenders, isEmpty);
      final s = AppSettings(blockedSenders: {'Troll'});
      expect(AppSettings.fromJson(s.toJson()).blockedSenders, {'Troll'});
    });

    test('block, check and unblock, trimming names', () async {
      final service = AppSettingsService();
      await service.blockSender(' Troll ');
      expect(service.isSenderBlocked('Troll'), isTrue);
      expect(service.isSenderBlocked(''), isFalse);
      await service.blockSender('  ');
      expect(service.settings.blockedSenders, {'Troll'});
      await service.unblockSender('Troll');
      expect(service.isSenderBlocked('Troll'), isFalse);
    });
  });
}
