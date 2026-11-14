import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/automation_rule.dart';

AutomationRule _rule(
  List<AutomationCondition> conditions, {
  ConditionMatch match = ConditionMatch.all,
  List<AutomationAction> actions = const [
    AutomationAction(type: ActionType.alert, text: 'hey'),
  ],
  String id = 'r1',
}) => AutomationRule(
  id: id,
  name: 'Rule',
  enabled: true,
  match: match,
  conditions: conditions,
  actions: actions,
);

const _battery = AutomationCondition(
  type: ConditionType.batteryBelow,
  percent: 20,
);

const _send = AutomationAction(
  type: ActionType.sendMessage,
  target: SendTarget.channel,
  channelIndex: 0,
  text: 'Battery low',
);

void main() {
  final t0 = DateTime(2026, 11, 13, 9);

  AutomationSnapshot snap(
    Duration after, {
    int? battery,
    double? lat,
    double? lon,
    Map<String, DateTime> seen = const {},
  }) => AutomationSnapshot(
    now: t0.add(after),
    batteryPercent: battery,
    latitude: lat,
    longitude: lon,
    nodeLastSeen: seen,
  );

  group('AutomationEngine', () {
    test('fires once when a condition becomes true, not on first reading', () {
      final engine = AutomationEngine();
      final rules = [
        _rule([_battery]),
      ];
      // Already low on the first reading: only recorded.
      expect(engine.evaluate(rules, snap(Duration.zero, battery: 10)), isEmpty);
      expect(
        engine.evaluate(rules, snap(const Duration(minutes: 2), battery: 50)),
        isEmpty,
      );
      expect(
        engine.evaluate(rules, snap(const Duration(minutes: 4), battery: 15)),
        hasLength(1),
      );
      // Still low: no repeat.
      expect(
        engine.evaluate(rules, snap(const Duration(minutes: 6), battery: 12)),
        isEmpty,
      );
    });

    test('unknown readings keep the last state', () {
      final engine = AutomationEngine();
      final rules = [
        _rule([_battery]),
      ];
      engine.evaluate(rules, snap(Duration.zero, battery: 50));
      expect(engine.evaluate(rules, snap(const Duration(minutes: 1))), isEmpty);
      expect(
        engine.evaluate(rules, snap(const Duration(minutes: 2), battery: 10)),
        hasLength(1),
      );
    });

    test('AND needs every condition, OR needs one', () {
      const area = AutomationCondition(
        type: ConditionType.leaveArea,
        latitude: 40,
        longitude: -75,
        radiusMeters: 1000,
      );
      final and = AutomationEngine();
      final or = AutomationEngine();
      final andRules = [
        _rule([_battery, area]),
      ];
      final orRules = [
        _rule([_battery, area], match: ConditionMatch.any),
      ];
      // Inside the area, battery fine.
      final s0 = snap(Duration.zero, battery: 80, lat: 40, lon: -75);
      expect(and.evaluate(andRules, s0), isEmpty);
      expect(or.evaluate(orRules, s0), isEmpty);
      // Battery low, still inside: OR fires, AND doesn't.
      final s1 = snap(
        const Duration(minutes: 5),
        battery: 10,
        lat: 40,
        lon: -75,
      );
      expect(and.evaluate(andRules, s1), isEmpty);
      expect(or.evaluate(orRules, s1), hasLength(1));
      // Battery low and outside: AND fires now.
      final s2 = snap(
        const Duration(minutes: 10),
        battery: 10,
        lat: 40.1,
        lon: -75,
      );
      expect(and.evaluate(andRules, s2), hasLength(1));
    });

    test('a 0,0 position counts as no fix', () {
      final engine = AutomationEngine();
      final rules = [
        _rule(const [
          AutomationCondition(
            type: ConditionType.enterArea,
            latitude: 40,
            longitude: -75,
          ),
        ]),
      ];
      engine.evaluate(rules, snap(Duration.zero, lat: 41, lon: -75));
      expect(
        engine.evaluate(
          rules,
          snap(const Duration(minutes: 1), lat: 0, lon: 0),
        ),
        isEmpty,
      );
      expect(
        engine.evaluate(
          rules,
          snap(const Duration(minutes: 2), lat: 40, lon: -75),
        ),
        hasLength(1),
      );
    });

    test('node online and offline follow last heard', () {
      final engine = AutomationEngine();
      final rules = [
        _rule(const [
          AutomationCondition(
            type: ConditionType.nodeOffline,
            nodeKey: 'abc',
            minutes: 30,
          ),
        ]),
      ];
      engine.evaluate(rules, snap(Duration.zero, seen: {'abc': t0}));
      expect(
        engine.evaluate(
          rules,
          snap(const Duration(minutes: 31), seen: {'abc': t0}),
        ),
        hasLength(1),
      );
    });

    test('time of day fires once at the minute', () {
      final engine = AutomationEngine();
      final rules = [
        _rule(const [
          AutomationCondition(
            type: ConditionType.timeOfDay,
            minuteOfDay: 9 * 60 + 1,
          ),
        ]),
      ];
      engine.evaluate(rules, snap(Duration.zero));
      expect(
        engine.evaluate(rules, snap(const Duration(seconds: 60))),
        hasLength(1),
      );
      expect(
        engine.evaluate(rules, snap(const Duration(seconds: 90))),
        isEmpty,
      );
    });

    test('messages match source, sender, channel and text', () {
      final engine = AutomationEngine();
      final rules = [
        _rule(const [
          AutomationCondition(
            type: ConditionType.messageReceived,
            source: MessageSource.channel,
            channelIndex: 2,
            contains: 'net',
          ),
        ]),
      ];
      final s = snap(Duration.zero);
      expect(
        engine.evaluate(
          rules,
          s,
          message: const AutomationMessage(text: 'NET now', channelIndex: 1),
        ),
        isEmpty,
      );
      expect(
        engine.evaluate(
          rules,
          s,
          message: const AutomationMessage(text: 'hello', channelIndex: 2),
        ),
        isEmpty,
      );
      expect(
        engine.evaluate(
          rules,
          s,
          message: const AutomationMessage(text: 'hello'),
        ),
        isEmpty,
      );
      expect(
        engine.evaluate(
          rules,
          s,
          message: const AutomationMessage(
            text: 'The NET starts',
            channelIndex: 2,
          ),
        ),
        hasLength(1),
      );
      // Timer passes never fire a message-only rule.
      expect(engine.evaluate(rules, snap(const Duration(hours: 1))), isEmpty);
    });

    test('message AND state: both must hold when the message arrives', () {
      final engine = AutomationEngine();
      final rules = [
        _rule(const [
          AutomationCondition(type: ConditionType.messageReceived),
          _battery,
        ]),
      ];
      const m = AutomationMessage(text: 'status?', senderKey: 'k');
      expect(
        engine.evaluate(rules, snap(Duration.zero, battery: 90), message: m),
        isEmpty,
      );
      expect(
        engine.evaluate(rules, snap(Duration.zero, battery: 10), message: m),
        hasLength(1),
      );
    });

    test('ignores automated and bot messages, so rules cannot ping-pong', () {
      final engine = AutomationEngine();
      final rules = [
        _rule(const [AutomationCondition(type: ConditionType.messageReceived)]),
      ];
      for (final text in ['[auto] hi', '[NOTORYX Bot] hi']) {
        expect(
          engine.evaluate(
            rules,
            snap(Duration.zero),
            message: AutomationMessage(text: text),
          ),
          isEmpty,
        );
      }
    });

    test('rules that transmit wait 15 minutes, others 1 minute', () {
      final quiet = AutomationEngine();
      final tx = AutomationEngine();
      const msg = AutomationCondition(type: ConditionType.messageReceived);
      final quietRules = [
        _rule(const [msg]),
      ];
      final txRules = [
        _rule(const [msg], actions: const [_send]),
      ];
      const m = AutomationMessage(text: 'x');
      for (final e in [quiet, tx]) {
        expect(
          e.evaluate(
            e == quiet ? quietRules : txRules,
            snap(Duration.zero),
            message: m,
          ),
          hasLength(1),
        );
      }
      final later = snap(const Duration(minutes: 2));
      expect(quiet.evaluate(quietRules, later, message: m), hasLength(1));
      expect(tx.evaluate(txRules, later, message: m), isEmpty);
      expect(
        tx.evaluate(txRules, snap(const Duration(minutes: 16)), message: m),
        hasLength(1),
      );
    });

    test('disabled or unfinished rules never fire', () {
      final engine = AutomationEngine();
      final off = _rule([_battery]).copyWith(enabled: false);
      final unfinished = _rule(const [
        AutomationCondition(type: ConditionType.nodeOnline),
      ], id: 'r2');
      engine.evaluate([off, unfinished], snap(Duration.zero, battery: 80));
      expect(
        engine.evaluate([
          off,
          unfinished,
        ], snap(const Duration(minutes: 1), battery: 5)),
        isEmpty,
      );
    });
  });

  test('AutomationTxLimiter allows 3 sends per 10 minutes', () {
    final limiter = AutomationTxLimiter();
    expect(
      [for (var i = 0; i < 4; i++) limiter.take(t0)],
      [true, true, true, false],
    );
    expect(limiter.take(t0.add(const Duration(minutes: 10))), isTrue);
  });

  group('validation', () {
    test('automated text must fit 140 bytes with the prefix', () {
      expect(isValidAutomationText('  '), isFalse);
      expect(isValidAutomationText('a' * 133), isTrue);
      expect(isValidAutomationText('a' * 134), isFalse);
    });

    test('webhooks must be https', () {
      expect(isValidWebhookUrl('https://example.org/hook'), isTrue);
      expect(isValidWebhookUrl('http://example.org/hook'), isFalse);
      expect(isValidWebhookUrl('example.org'), isFalse);
    });

    test('a rule needs a name, a condition and an action, all filled in', () {
      expect(_rule([_battery]).isComplete, isTrue);
      expect(_rule([]).isComplete, isFalse);
      expect(_rule([_battery], actions: const []).isComplete, isFalse);
      expect(
        _rule(
          [_battery],
          actions: const [AutomationAction(type: ActionType.webhook)],
        ).isComplete,
        isFalse,
      );
    });
  });

  group('json', () {
    test('round-trips', () {
      final rule = _rule(
        const [
          _battery,
          AutomationCondition(
            type: ConditionType.messageReceived,
            source: MessageSource.direct,
            nodeKey: 'abc',
            contains: 'qrv',
          ),
        ],
        match: ConditionMatch.any,
        actions: const [
          _send,
          AutomationAction(
            type: ActionType.webhook,
            url: 'https://example.org/h',
          ),
        ],
      );
      final back = AutomationRule.fromJson(
        jsonDecode(jsonEncode(rule.toJson())),
      )!;
      expect(jsonEncode(back.toJson()), jsonEncode(rule.toJson()));
      expect(back.enabled, isTrue);
    });

    test('an unreadable part switches the rule off', () {
      final json = _rule([_battery]).toJson()
        ..['conditions'] = [
          _battery.toJson(),
          {'type': 'somethingNew'},
        ];
      final back = AutomationRule.fromJson(json)!;
      expect(back.conditions, hasLength(1));
      expect(back.enabled, isFalse);
      expect(AutomationRule.fromJson({'name': 'x'}), isNull);
    });
  });

  test('fillAutomationText fills every placeholder', () {
    final now = DateTime(2026, 11, 13, 7, 5);
    const msg = AutomationMessage(text: 'hi', senderName: 'KD2ABC');
    expect(
      fillAutomationText(
        '{rule}|{time}|{battery}|{node}|{text}',
        rule: 'R',
        now: now,
        battery: 42,
        message: msg,
      ),
      'R|07:05|42%|KD2ABC|hi',
    );
    expect(
      fillAutomationText('{battery}{node}{text}', rule: 'R', now: now),
      '?',
    );
  });
}
