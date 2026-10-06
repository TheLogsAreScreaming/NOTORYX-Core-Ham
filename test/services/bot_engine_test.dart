import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/bot_settings.dart';
import 'package:meshcore_open/services/bot_engine.dart';

void main() {
  final now = DateTime.utc(2026, 10, 5, 12);
  late BotEngine engine;
  setUp(() => engine = BotEngine());

  String? reply({
    BotSettings? settings,
    String id = 'one',
    String sender = 'alice',
    String text = 'Hello',
    DateTime? time,
    DateTime? clock,
    bool eligible = true,
  }) => engine.reply(
    settings: settings ?? BotSettings(enabled: true),
    messageId: id,
    sender: sender,
    text: text,
    timestamp: time ?? now,
    now: clock ?? now,
    eligible: eligible,
    commandResponses: {'!ping': 'Pong', '!where': 'Private location'},
  );

  test('master switch defaults off', () {
    expect(reply(settings: BotSettings()), isNull);
  });
  test('sends tagged away reply', () {
    expect(reply(), startsWith(botPrefix));
  });
  test('duplicate message does not reply again even after cooldown', () {
    expect(reply(), isNotNull);
    expect(
      reply(
        clock: now.add(const Duration(minutes: 6)),
        time: now.add(const Duration(minutes: 6)),
      ),
      isNull,
    );
  });
  test('ignores outgoing, CLI, rooms and history via eligibility gate', () {
    expect(reply(eligible: false), isNull);
  });
  test('ignores stale and implausibly future messages', () {
    expect(reply(time: now.subtract(const Duration(minutes: 3))), isNull);
    expect(reply(id: 'two', time: now.add(const Duration(minutes: 1))), isNull);
  });
  test('ignores marked bot messages to prevent feedback loops', () {
    expect(reply(text: '${botPrefix}Pong'), isNull);
    expect(reply(id: 'legacy', text: '[BCS Bot] Pong'), isNull);
  });
  test('per-contact cooldown covers commands and away replies', () {
    expect(reply(), isNotNull);
    expect(reply(id: 'two', text: '!ping'), isNull);
    final later = now.add(const Duration(minutes: 5));
    expect(
      reply(id: 'three', text: '!ping', time: later, clock: later),
      '${botPrefix}Pong',
    );
  });
  test('global cap covers simultaneous contacts', () {
    for (var i = 0; i < 3; i++) {
      expect(reply(id: '$i', sender: '$i'), isNotNull);
    }
    expect(reply(id: 'four', sender: 'four'), isNull);
    final later = now.add(const Duration(seconds: 60));
    expect(
      reply(id: 'five', sender: 'five', time: later, clock: later),
      isNotNull,
    );
  });
  test('budget survives restart', () {
    expect(reply(), isNotNull);
    final saved = engine.budget;
    engine = BotEngine()..restoreBudget(saved);
    expect(reply(id: 'two'), isNull);
  });
  test('commands match exact case-insensitive text', () {
    expect(reply(text: ' !PING '), '${botPrefix}Pong');
  });
  test('unknown and disabled commands do not use away fallback', () {
    expect(reply(text: '!unknown'), isNull);
    expect(
      reply(
        id: 'two',
        text: '!ping',
        settings: BotSettings(enabled: true, commands: {}),
      ),
      isNull,
    );
  });
  test('location sharing is opt-in', () {
    expect(reply(text: '!where'), isNull);
    expect(
      reply(
        id: 'two',
        text: '!where',
        settings: BotSettings(enabled: true, shareLocation: true),
      ),
      '${botPrefix}Private location',
    );
  });
  test('contact allowlist restricts replies', () {
    final settings = BotSettings(enabled: true, allowedSenders: {'bob'});
    expect(reply(settings: settings), isNull);
    expect(reply(id: 'two', sender: 'bob', settings: settings), isNotNull);
  });
  test('custom rules support sender restrictions and keyword matching', () {
    final settings = BotSettings(
      enabled: true,
      awayEnabled: false,
      rules: [
        const BotRule(
          trigger: 'camp',
          response: 'At camp',
          contains: true,
          senderKey: 'bob',
        ),
      ],
    );
    expect(reply(text: 'At CAMP?', settings: settings), isNull);
    expect(
      reply(id: 'two', sender: 'bob', text: 'At CAMP?', settings: settings),
      '${botPrefix}At camp',
    );
  });
  test('disabled rule is ignored', () {
    expect(
      reply(
        text: '!club',
        settings: BotSettings(
          enabled: true,
          rules: [
            const BotRule(trigger: '!club', response: 'BCS', enabled: false),
          ],
        ),
      ),
      isNull,
    );
  });
  test('built-in commands take precedence over custom rules', () {
    expect(
      reply(
        text: '!ping',
        settings: BotSettings(
          enabled: true,
          rules: [const BotRule(trigger: '!ping', response: 'Override')],
        ),
      ),
      '${botPrefix}Pong',
    );
  });
  test('oversized Unicode response is rejected using UTF-8 bytes', () {
    expect(isValidBotResponse(List.filled(40, '🏕').join()), isFalse);
    expect(
      reply(
        settings: BotSettings(
          enabled: true,
          awayMessage: List.filled(150, 'x').join(),
        ),
      ),
      isNull,
    );
  });
  test('settings round trip preserves all choices and safe defaults', () {
    final original = BotSettings(
      enabled: true,
      shareLocation: true,
      allowedSenders: {'bob'},
      rules: [
        const BotRule(trigger: '!club', response: 'BCS', senderKey: 'bob'),
      ],
    );
    final loaded = BotSettings.fromJson(original.toJson());
    expect(loaded.toJson(), original.toJson());
    expect(BotSettings.fromJson({}).shareLocation, isFalse);
    expect(
      BotSettings.fromJson({
        'cooldownSeconds': 0,
        'repliesPerMinute': 999,
      }).cooldownSeconds,
      60,
    );
    expect(
      BotSettings.fromJson({
        'cooldownSeconds': 0,
        'repliesPerMinute': 999,
      }).repliesPerMinute,
      6,
    );
  });
}
