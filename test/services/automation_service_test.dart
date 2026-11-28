import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/screens/automation_screen.dart';
import 'package:meshcore_open/screens/station_log_screen.dart';
import 'package:meshcore_open/theme/mesh_theme.dart';
import 'package:provider/provider.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/automation_rule.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/models/channel_message.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/message.dart';
import 'package:meshcore_open/models/operator_profile.dart';
import 'package:meshcore_open/services/automation_service.dart';
import 'package:meshcore_open/services/operator_profile_service.dart';
import 'package:meshcore_open/services/station_log_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Radio extends MeshCoreConnector {
  final direct = StreamController<Message>.broadcast();
  final channel = StreamController<ChannelMessage>.broadcast();
  final sentText = <String>[];
  bool connected = true;
  String? firmware = 'v1.18.0-ham-test.4';
  String? name = 'W1AW Base';
  int? battery = 80;

  final known = [
    Contact(
      publicKey: Uint8List.fromList(List.filled(32, 7)),
      name: 'KD2ABC Hill',
      type: advTypeChat,
      pathLength: -1,
      path: Uint8List(0),
      lastSeen: DateTime.now(),
    ),
  ];

  @override
  bool get isConnected => connected;
  @override
  String? get firmwareVersionString => firmware;
  @override
  String? get selfName => name;
  @override
  int? get currentFreqHz => 433125;
  @override
  int? get batteryPercent => battery;
  @override
  List<Contact> get contacts => known;
  @override
  List<Channel> get channels => [
    Channel(index: 0, name: 'Public', psk: Uint8List(16)),
    Channel(index: 3, name: 'ARES', psk: Uint8List(16)),
  ];
  @override
  Contact? getContactByPubKeyHex(String hex) =>
      known.where((c) => c.publicKeyHex == hex).firstOrNull;
  @override
  Stream<Message> get receivedDirectMessages => direct.stream;
  @override
  Stream<ChannelMessage> get radioChannelMessages => channel.stream;
  @override
  Stream<Contact> get sentDirectMessages => const Stream.empty();
  @override
  Future<void> sendChannelMessage(
    Channel channel,
    String text, {
    String? originalText,
    String? translatedLanguageCode,
    String? translationModelId,
    bool sign = false,
  }) async => sentText.add('#${channel.index} $text');
  @override
  Future<void> sendMessage(
    Contact contact,
    String text, {
    String? originalText,
    String? translatedLanguageCode,
    String? translationModelId,
  }) async => sentText.add('@${contact.name} $text');
}

const _ping = AutomationCondition(
  type: ConditionType.messageReceived,
  contains: 'ping',
);

AutomationRule _rule(List<AutomationAction> actions, {String id = 'r'}) =>
    AutomationRule(
      id: id,
      name: 'Ping reply $id',
      enabled: true,
      conditions: const [_ping],
      actions: actions,
    );

void main() {
  late _Radio radio;
  late OperatorProfileService operator;
  late StationLogService log;
  late DateTime now;
  late List<String> alerts;
  late List<Uri> hooks;
  var sounds = 0;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    radio = _Radio();
    operator = OperatorProfileService();
    await operator.save(
      OperatorProfile(
        callsign: 'W1AW',
        licenseClass: LicenseClass.general,
        acknowledgedAt: DateTime.utc(2026),
      ),
    );
    now = DateTime(2026, 11, 13, 12);
    log = StationLogService(radio, clock: () => now)..start();
    alerts = [];
    hooks = [];
    sounds = 0;
  });

  AutomationService service() => AutomationService(
    radio,
    operator: operator,
    stationLog: log,
    clock: () => now,
    tick: Duration.zero,
    notify: (title, body) async => alerts.add('$title: $body'),
    playSound: () async => sounds++,
    webhook: (url, body) async {
      hooks.add(url);
      return 200;
    },
  )..start();

  Future<void> ping(AutomationService s, {int? channel}) =>
      s.onMessage(AutomationMessage(text: 'ping', channelIndex: channel));

  test('sends with [auto], and logs it in the station log', () async {
    final s = service();
    await s.save(
      _rule(const [
        AutomationAction(
          type: ActionType.sendMessage,
          target: SendTarget.channel,
          channelIndex: 3,
          text: 'pong',
        ),
      ]),
    );
    await ping(s);
    expect(radio.sentText, ['#3 [auto] pong']);
    final entry = log.automated.single;
    expect(entry.rule, 'Ping reply r');
    expect(entry.to, 'ARES');
    expect(entry.text, '[auto] pong');
    expect(entry.station, 'W1AW');
    expect(entry.band, '70cm');
    expect(s.activity.first.outcome, AutomationOutcome.done);
  });

  test(
    'placeholders: alerts get all of them, on-air text never relays',
    () async {
      final s = service();
      await s.save(
        _rule(const [
          AutomationAction(
            type: ActionType.alert,
            text: '{node} said {text} at {time}',
          ),
          AutomationAction(
            type: ActionType.sendMessage,
            target: SendTarget.channel,
            channelIndex: 3,
            text: '{rule} {battery} {time}{node}{text}',
          ),
        ]),
      );
      radio.direct.add(
        Message(
          senderKey: Uint8List.fromList(List.filled(32, 7)),
          text: 'ping secret',
          timestamp: now,
          isOutgoing: false,
        ),
      );
      await pumpEventQueue();
      expect(alerts, ['Ping reply r: KD2ABC Hill said ping secret at 12:00']);
      expect(radio.sentText, ['#3 [auto] Ping reply r 80% 12:00']);
      expect(log.automated.single.text, '[auto] Ping reply r 80% 12:00');
    },
  );

  test('holds transmissions unless the station is ready', () async {
    final s = service();
    await s.save(
      _rule(const [
        AutomationAction(
          type: ActionType.sendMessage,
          target: SendTarget.contact,
          contactKey:
              '0707070707070707070707070707070707070707070707070707070707070707',
          text: 'pong',
        ),
        AutomationAction(type: ActionType.alert, text: 'pinged'),
      ]),
    );
    final cases = <void Function()>[
      () => radio.firmware = 'v1.18.0', // stock firmware
      () => radio.firmware = null, // not reported yet
      () => radio.name = 'Base', // no call sign in the name
      () => radio.connected = false,
    ];
    for (final (i, breakIt) in cases.indexed) {
      radio
        ..firmware = 'v1.18.0-ham-test.4'
        ..name = 'W1AW Base'
        ..connected = true;
      breakIt();
      now = now.add(const Duration(hours: 1));
      await ping(s);
      expect(radio.sentText, isEmpty, reason: 'case $i');
    }
    expect(log.automated, isEmpty);
    // The alert still went out each time.
    expect(alerts, hasLength(cases.length));
    expect(
      s.activity
          .where((a) => a.action == ActionType.sendMessage)
          .map((a) => a.outcome),
      [
        AutomationOutcome.notConnected,
        AutomationOutcome.stationNotReady,
        AutomationOutcome.stationNotReady,
        AutomationOutcome.stationNotReady,
      ],
    );

    radio
      ..firmware = 'v1.18.0-ham-test.4'
      ..name = 'W1AW Base'
      ..connected = true;
    now = now.add(const Duration(hours: 1));
    await ping(s);
    expect(radio.sentText, ['@KD2ABC Hill [auto] pong']);
  });

  test('caps automated sends across rules', () async {
    final s = service();
    for (var i = 0; i < 5; i++) {
      await s.save(
        _rule(const [
          AutomationAction(
            type: ActionType.sendMessage,
            target: SendTarget.channel,
            channelIndex: 0,
            text: 'pong',
          ),
        ], id: '$i'),
      );
    }
    await ping(s);
    expect(radio.sentText, hasLength(3));
    expect(log.automated, hasLength(3));
    expect(
      s.activity.where((a) => a.outcome == AutomationOutcome.rateLimited),
      hasLength(2),
    );
  });

  test('change channel steers sends to the working channel', () async {
    final s = service();
    await s.save(
      _rule(const [
        AutomationAction(type: ActionType.changeChannel, channelIndex: 3),
        AutomationAction(type: ActionType.sendMessage, text: 'on ARES'),
      ]),
    );
    expect(s.workingChannel, isNull);
    await ping(s);
    expect(s.workingChannel, 3);
    expect(radio.sentText, ['#3 [auto] on ARES']);
    expect(
      PrefsManager.instance.getInt(AutomationService.workingChannelKey),
      3,
    );
  });

  test('webhooks are off until allowed; sound plays', () async {
    final s = service();
    expect(s.webhooksEnabled, isFalse);
    await s.save(
      _rule(const [
        AutomationAction(
          type: ActionType.webhook,
          url: 'https://example.org/hook',
        ),
        AutomationAction(type: ActionType.playSound),
      ]),
    );
    await ping(s);
    expect(hooks, isEmpty);
    expect(sounds, 1);
    expect(s.activity.last.outcome, AutomationOutcome.webhooksOff);

    await s.setWebhooksEnabled(true);
    now = now.add(const Duration(minutes: 2));
    await ping(s);
    expect(hooks, [Uri.parse('https://example.org/hook')]);
  });

  test('reacts to radio messages but not its own or automated ones', () async {
    final s = service();
    await s.save(
      _rule(const [AutomationAction(type: ActionType.alert, text: 'got it')]),
    );
    radio.direct.add(
      Message(
        senderKey: Uint8List(32),
        text: '[auto] ping',
        timestamp: now,
        isOutgoing: false,
      ),
    );
    await pumpEventQueue();
    expect(alerts, isEmpty);
    radio.direct.add(
      Message(
        senderKey: Uint8List(32),
        text: 'ping?',
        timestamp: now,
        isOutgoing: false,
      ),
    );
    await pumpEventQueue();
    expect(alerts, ['Ping reply r: got it']);
  });

  test('rules persist; incomplete ones are saved switched off', () async {
    final s = service();
    await s.save(
      _rule(const [AutomationAction(type: ActionType.alert, text: 'x')]),
    );
    await s.save(
      const AutomationRule(
        id: 'half',
        name: 'Half',
        enabled: true,
        conditions: [_ping],
      ),
    );
    s.dispose();
    final again = service();
    expect(again.rules.map((r) => (r.id, r.enabled)), [
      ('r', true),
      ('half', false),
    ]);
  });

  test('clearing the station log clears automated entries too', () async {
    await log.recordAutomated(
      rule: 'R',
      to: 'Public',
      text: '[auto] x',
      station: 'w1aw',
    );
    expect(log.automated.single.station, 'W1AW');
    await log.clear();
    expect(log.automated, isEmpty);
  });

  Widget app(AutomationService s, Widget home) => MultiProvider(
    providers: [
      ChangeNotifierProvider<MeshCoreConnector>.value(value: radio),
      ChangeNotifierProvider.value(value: s),
      ChangeNotifierProvider.value(value: log),
      ChangeNotifierProvider.value(value: operator),
    ],
    child: MaterialApp(
      theme: MeshTheme.dark(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: home,
    ),
  );

  testWidgets('automation screen: labelled switches and the rule editor', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    final s = service();
    await tester.pumpWidget(app(s, const AutomationScreen()));
    expect(find.text('No rules yet'), findsOneWidget);
    expect(find.textContaining('Needs internet'), findsOneWidget);
    expect(
      tester
          .widget<SwitchListTile>(
            find.byKey(const ValueKey('automation-webhooks')),
          )
          .value,
      isFalse,
    );

    await tester.runAsync(
      () => s.save(
        _rule(const [
          AutomationAction(
            type: ActionType.sendMessage,
            target: SendTarget.channel,
            channelIndex: 0,
            text: 'pong',
          ),
        ]),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel(RegExp('Rule Ping reply r on')), findsOne);
    expect(find.textContaining('Transmits on air'), findsOneWidget);

    await tester.tap(find.text('Ping reply r'));
    await tester.pumpAndSettle();
    expect(find.text('Edit rule'), findsOneWidget);
    expect(find.byTooltip('Remove Message received'), findsOneWidget);
    expect(find.byTooltip('Remove Send a message'), findsOneWidget);
    expect(find.textContaining('logged in the station log'), findsWidgets);

    await tester.tap(find.byKey(const ValueKey('automation-add-condition')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Battery low').last);
    await tester.pumpAndSettle();
    expect(find.byTooltip('Remove Battery low'), findsOneWidget);
    expect(find.text('Radio battery below 20%'), findsOneWidget);
    expect(tester.semantics.find(find.byType(Slider)), isNotNull);
    handle.dispose();
    s.dispose();
  });

  testWidgets('station log shows automated transmissions', (tester) async {
    await tester.runAsync(
      () => log.recordAutomated(
        rule: 'Net reminder',
        to: 'ARES',
        text: '[auto] Net at 8',
        station: 'W1AW',
      ),
    );
    final s = service();
    await tester.pumpWidget(app(s, const StationLogScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Automated transmissions'), findsOneWidget);
    expect(find.text('Net reminder → ARES'), findsOneWidget);
    expect(find.textContaining('[auto] Net at 8'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('station-log-menu')));
    await tester.pumpAndSettle();
    expect(find.text('Export automated transmissions (CSV)'), findsOneWidget);
    s.dispose();
  });
}
