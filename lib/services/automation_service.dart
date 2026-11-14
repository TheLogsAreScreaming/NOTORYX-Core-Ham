import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../models/automation_rule.dart';
import '../models/channel_message.dart';
import '../models/message.dart';
import '../storage/prefs_manager.dart';
import '../utils/amateur_radio.dart';
import '../utils/app_logger.dart';
import '../utils/station_readiness.dart';
import 'notification_service.dart';
import 'operator_profile_service.dart';
import 'station_log_service.dart';

/// What happened when a rule's action ran (or why it didn't).
enum AutomationOutcome {
  done,

  /// No radio connected.
  notConnected,

  /// The station can't transmit legally right now (stock firmware, setup
  /// incomplete, name without the call sign, out of band).
  stationNotReady,

  /// The cap on automated transmissions was reached.
  rateLimited,

  /// The contact or channel to send to isn't on the radio.
  noTarget,

  /// Webhooks are switched off in the automation settings.
  webhooksOff,

  failed,
}

/// One line of the automation activity list.
class AutomationActivity {
  const AutomationActivity({
    required this.at,
    required this.rule,
    required this.action,
    required this.outcome,
  });

  final DateTime at;
  final String rule;
  final ActionType action;
  final AutomationOutcome outcome;
}

typedef AutomationNotify = Future<void> Function(String title, String body);
typedef AutomationWebhook = Future<int> Function(Uri url, String body);

/// Runs the user's automation rules while the app is open.
///
/// Ham rules: a rule only transmits when the station is ready to transmit
/// legally ([stationReadiness] is ready and the radio runs the ham
/// firmware, which sends plain text and the call sign with every frame);
/// every automated message starts with [automationPrefix], counts against
/// [AutomationTxLimiter], and is written to the station log.
class AutomationService extends ChangeNotifier {
  AutomationService(
    this.connector, {
    required this.operator,
    required this.stationLog,
    DateTime Function()? clock,
    AutomationNotify? notify,
    Future<void> Function()? playSound,
    AutomationWebhook? webhook,
    Duration tick = const Duration(seconds: 30),
  }) : _clock = clock ?? DateTime.now,
       _notify = notify ?? _postNotification,
       _playSound = playSound ?? _systemSound,
       _webhook = webhook ?? _postWebhook,
       _tick = tick;

  static const rulesKey = 'automation_rules_v1';
  static const webhooksKey = 'automation_webhooks_enabled';
  static const workingChannelKey = 'automation_working_channel';
  static const _maxActivity = 50;

  final MeshCoreConnector connector;
  final OperatorProfileService operator;
  final StationLogService stationLog;
  final DateTime Function() _clock;
  final AutomationNotify _notify;
  final Future<void> Function() _playSound;
  final AutomationWebhook _webhook;
  final Duration _tick;
  final AutomationEngine _engine = AutomationEngine();
  final AutomationTxLimiter _limiter = AutomationTxLimiter();
  final List<AutomationRule> _rules = [];
  final List<AutomationActivity> _activity = [];
  final _subs = <StreamSubscription<Object>>[];
  bool _webhooksEnabled = false;
  int? _workingChannel;
  Timer? _timer;
  Future<void> _running = Future.value();

  static Future<void> _postNotification(String title, String body) =>
      NotificationService().showAutomation(title: title, body: body);

  static Future<void> _systemSound() async {
    await SystemSound.play(SystemSoundType.alert);
    await HapticFeedback.vibrate();
  }

  static Future<int> _postWebhook(Uri url, String body) async {
    final response = await http
        .post(url, headers: {'content-type': 'application/json'}, body: body)
        .timeout(const Duration(seconds: 10));
    return response.statusCode;
  }

  List<AutomationRule> get rules => List.unmodifiable(_rules);

  /// Newest first.
  List<AutomationActivity> get activity => List.unmodifiable(_activity);

  /// Whether webhook actions may use the internet. Off by default.
  bool get webhooksEnabled => _webhooksEnabled;

  /// The channel "send to working channel" goes to; changed by rules.
  int? get workingChannel => _workingChannel;

  /// Loads saved rules and starts watching the radio.
  void start() {
    _load();
    _subs
      ..add(connector.receivedDirectMessages.listen(_onDirect))
      ..add(connector.radioChannelMessages.listen(_onChannel));
    if (_tick > Duration.zero) {
      _timer = Timer.periodic(_tick, (_) => unawaited(run()));
    }
  }

  /// Adds [rule], or replaces the one with its id. An incomplete rule is
  /// saved switched off.
  Future<void> save(AutomationRule rule) async {
    final r = rule.isComplete ? rule : rule.copyWith(enabled: false);
    final at = _rules.indexWhere((x) => x.id == r.id);
    if (at < 0) {
      _rules.add(r);
    } else {
      _rules[at] = r;
    }
    await _persist();
  }

  Future<void> delete(String id) async {
    _rules.removeWhere((r) => r.id == id);
    await _persist();
  }

  Future<void> setWebhooksEnabled(bool on) async {
    _webhooksEnabled = on;
    notifyListeners();
    await PrefsManager.instance.setBool(webhooksKey, on);
  }

  Future<void> setWorkingChannel(int? index) async {
    _workingChannel = index;
    notifyListeners();
    if (index == null) {
      await PrefsManager.instance.remove(workingChannelKey);
    } else {
      await PrefsManager.instance.setInt(workingChannelKey, index);
    }
  }

  /// One timer pass: fires rules whose conditions just became true.
  Future<void> run() => _serial(() => _evaluate(null));

  /// A pass for [message], which just arrived.
  @visibleForTesting
  Future<void> onMessage(AutomationMessage message) =>
      _serial(() => _evaluate(message));

  void _onDirect(Message m) {
    if (m.isCli || m.isOutgoing) return;
    unawaited(
      onMessage(
        AutomationMessage(
          text: m.text,
          senderKey: m.senderKeyHex,
          senderName: connector.getContactByPubKeyHex(m.senderKeyHex)?.name,
        ),
      ),
    );
  }

  void _onChannel(ChannelMessage m) {
    if (m.isOutgoing) return;
    final key = m.senderKey;
    unawaited(
      onMessage(
        AutomationMessage(
          text: m.text,
          senderKey: key == null ? null : pubKeyToHex(key),
          senderName: m.senderName,
          channelIndex: m.channelIndex,
        ),
      ),
    );
  }

  /// Passes run one after another, so two can't race on the limiter.
  Future<void> _serial(Future<void> Function() pass) =>
      _running = _running.then((_) => pass()).catchError((Object e) {
        appLogger.warn('Automation pass failed: $e', tag: 'Automation');
      });

  Future<void> _evaluate(AutomationMessage? message) async {
    final connected = connector.isConnected;
    final fired = _engine.evaluate(
      _rules,
      AutomationSnapshot(
        now: _clock(),
        batteryPercent: connected ? connector.batteryPercent : null,
        latitude: connected ? connector.selfLatitude : null,
        longitude: connected ? connector.selfLongitude : null,
        nodeLastSeen: {
          for (final c in connector.contacts) c.publicKeyHex: c.lastSeen,
        },
      ),
      message: message,
    );
    for (final rule in fired) {
      for (final action in rule.actions) {
        AutomationOutcome outcome;
        try {
          outcome = await _act(rule, action, message);
        } catch (e) {
          appLogger.warn(
            'Automation "${rule.name}" ${action.type.name} failed: $e',
            tag: 'Automation',
          );
          outcome = AutomationOutcome.failed;
        }
        _record(rule, action, outcome);
      }
    }
  }

  void _record(
    AutomationRule rule,
    AutomationAction action,
    AutomationOutcome outcome,
  ) {
    _activity.insert(
      0,
      AutomationActivity(
        at: _clock(),
        rule: rule.name,
        action: action.type,
        outcome: outcome,
      ),
    );
    if (_activity.length > _maxActivity) _activity.removeLast();
    notifyListeners();
  }

  /// Why this station may not transmit right now, or null when it may.
  AutomationOutcome? transmitHold() {
    if (!connector.isConnected) return AutomationOutcome.notConnected;
    final firmware = connector.firmwareVersionString;
    final readiness = stationReadiness(
      operator.profile,
      nodeName: connector.selfName,
      freqKhz: connector.currentFreqHz,
      firmwareVersion: firmware,
    );
    // Unlike the banner, an unknown firmware or name isn't given the
    // benefit of the doubt: nobody is watching this transmission.
    if (readiness != StationReadiness.ready ||
        isAmateurFirmware(firmware) != true ||
        connector.selfName == null) {
      return AutomationOutcome.stationNotReady;
    }
    return null;
  }

  /// [template] with its placeholders filled. On-air text never gets
  /// [message], so `{node}` and `{text}` come out empty there.
  String _fill(
    AutomationRule rule,
    String template, [
    AutomationMessage? message,
  ]) => fillAutomationText(
    template,
    rule: rule.name,
    now: _clock(),
    battery: connector.isConnected ? connector.batteryPercent : null,
    message: message,
  ).trim();

  Future<AutomationOutcome> _act(
    AutomationRule rule,
    AutomationAction action,
    AutomationMessage? message,
  ) async {
    switch (action.type) {
      case ActionType.alert:
        await _notify(rule.name, _fill(rule, action.text, message));
        return AutomationOutcome.done;
      case ActionType.playSound:
        await _playSound();
        return AutomationOutcome.done;
      case ActionType.changeChannel:
        await setWorkingChannel(action.channelIndex);
        return AutomationOutcome.done;
      case ActionType.webhook:
        if (!_webhooksEnabled) return AutomationOutcome.webhooksOff;
        if (!isValidWebhookUrl(action.url)) return AutomationOutcome.failed;
        final status = await _webhook(
          Uri.parse(action.url.trim()),
          jsonEncode({
            'rule': rule.name,
            'firedAt': _clock().toUtc().toIso8601String(),
          }),
        );
        return status >= 200 && status < 300
            ? AutomationOutcome.done
            : AutomationOutcome.failed;
      case ActionType.sendMessage:
        return _send(rule, action);
    }
  }

  Future<AutomationOutcome> _send(
    AutomationRule rule,
    AutomationAction action,
  ) async {
    final hold = transmitHold();
    if (hold != null) return hold;
    final body = _fill(rule, action.text);
    if (!isValidAutomationText(body)) return AutomationOutcome.failed;
    final text = '$automationPrefix$body';
    final Future<void> Function() send;
    final String to;
    if (action.target == SendTarget.contact) {
      final key = action.contactKey;
      final contact = key == null ? null : connector.getContactByPubKeyHex(key);
      if (contact == null) return AutomationOutcome.noTarget;
      to = contact.name;
      send = () => connector.sendMessage(contact, text);
    } else {
      final index = action.target == SendTarget.channel
          ? action.channelIndex
          : _workingChannel;
      final channel = connector.channels
          .where((c) => c.index == index)
          .firstOrNull;
      if (channel == null) return AutomationOutcome.noTarget;
      to = channel.name.isEmpty ? '#${channel.index}' : channel.name;
      send = () => connector.sendChannelMessage(channel, text);
    }
    if (!_limiter.take(_clock())) return AutomationOutcome.rateLimited;
    await send();
    await stationLog.recordAutomated(
      rule: rule.name,
      to: to,
      text: text,
      station: operator.profile.callsign,
    );
    return AutomationOutcome.done;
  }

  void _load() {
    final prefs = PrefsManager.instance;
    _webhooksEnabled = prefs.getBool(webhooksKey) ?? false;
    _workingChannel = prefs.getInt(workingChannelKey);
    final raw = prefs.getString(rulesKey);
    if (raw == null) return;
    try {
      _rules.addAll([
        for (final item in jsonDecode(raw) as List)
          ?AutomationRule.fromJson(item),
      ]);
    } catch (e) {
      appLogger.warn('Automation rules unreadable: $e', tag: 'Automation');
      unawaited(prefs.setString('${rulesKey}_unreadable', raw));
    }
  }

  Future<void> _persist() async {
    notifyListeners();
    await PrefsManager.instance.setString(
      rulesKey,
      jsonEncode([for (final r in _rules) r.toJson()]),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final s in _subs) {
      unawaited(s.cancel());
    }
    super.dispose();
  }
}
