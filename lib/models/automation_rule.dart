/// Automation rules: "when these things are true, do that". Pure data and
/// the engine that decides when a rule fires; nothing here touches the
/// radio, storage, the network or the UI, so it can all be tested.
///
/// Ham rules shape the design: every on-air send an automation makes is
/// marked [automationPrefix], rate limited, held unless the station is ready
/// to transmit legally, and written to the station log by the service.
library;

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';

/// Marks every automated transmission so anyone listening can tell it was
/// sent by a rule, not typed by the operator.
const String automationPrefix = '[auto] ';

/// The longest automated message, prefix included, in UTF-8 bytes. Same as
/// the bot's limit, comfortably inside one ham frame.
const int automationMaxTextBytes = 140;

/// Whether [text] can be sent by a rule: not blank, and short enough with
/// [automationPrefix] in front.
bool isValidAutomationText(String text) =>
    text.trim().isNotEmpty &&
    utf8.encode('$automationPrefix${text.trim()}').length <=
        automationMaxTextBytes;

/// Whether [url] can be called by a webhook action: https only, with a host.
bool isValidWebhookUrl(String url) {
  final uri = Uri.tryParse(url.trim());
  return uri != null && uri.scheme == 'https' && uri.host.isNotEmpty;
}

/// Whether [text] was sent by an automation or the bot. Rules never react to
/// those, so two stations' rules can't answer each other forever.
bool isAutomatedText(String text) {
  final t = text.trimLeft();
  return t.startsWith(automationPrefix.trim()) || t.startsWith('[NOTORYX Bot]');
}

enum ConditionType {
  /// The connected radio's battery is below [AutomationCondition.percent].
  batteryBelow,

  /// It is [AutomationCondition.minuteOfDay], local time.
  timeOfDay,

  /// The radio's position is inside the circle.
  enterArea,

  /// The radio's position is outside the circle.
  leaveArea,

  /// A message arrived that matches the condition's filters.
  messageReceived,

  /// [AutomationCondition.nodeKey] was heard in the last
  /// [AutomationCondition.minutes] minutes.
  nodeOnline,

  /// [AutomationCondition.nodeKey] has not been heard for
  /// [AutomationCondition.minutes] minutes.
  nodeOffline,
}

/// Where a received message must come from to match.
enum MessageSource { any, direct, channel }

/// One thing a rule watches. Only the fields for its [type] matter.
class AutomationCondition {
  const AutomationCondition({
    required this.type,
    this.percent = 20,
    this.minuteOfDay = 480,
    this.latitude,
    this.longitude,
    this.radiusMeters = 500,
    this.nodeKey,
    this.minutes = 30,
    this.source = MessageSource.any,
    this.channelIndex,
    this.contains = '',
  });

  final ConditionType type;
  final int percent;

  /// Minutes after local midnight.
  final int minuteOfDay;
  final double? latitude;
  final double? longitude;
  final int radiusMeters;

  /// Public key (hex) of the node, or of the only sender a message may
  /// come from (null: anyone).
  final String? nodeKey;
  final int minutes;
  final MessageSource source;

  /// For channel messages: the only channel that matches (null: any).
  final int? channelIndex;

  /// Text the message must contain, ignoring case (empty: any text).
  final String contains;

  /// A copy with the given fields changed. Nullable fields take a getter so
  /// they can be cleared.
  AutomationCondition copyWith({
    ConditionType? type,
    int? percent,
    int? minuteOfDay,
    ValueGetter<double?>? latitude,
    ValueGetter<double?>? longitude,
    int? radiusMeters,
    ValueGetter<String?>? nodeKey,
    int? minutes,
    MessageSource? source,
    ValueGetter<int?>? channelIndex,
    String? contains,
  }) => AutomationCondition(
    type: type ?? this.type,
    percent: percent ?? this.percent,
    minuteOfDay: minuteOfDay ?? this.minuteOfDay,
    latitude: latitude == null ? this.latitude : latitude(),
    longitude: longitude == null ? this.longitude : longitude(),
    radiusMeters: radiusMeters ?? this.radiusMeters,
    nodeKey: nodeKey == null ? this.nodeKey : nodeKey(),
    minutes: minutes ?? this.minutes,
    source: source ?? this.source,
    channelIndex: channelIndex == null ? this.channelIndex : channelIndex(),
    contains: contains ?? this.contains,
  );

  /// Whether this condition is about an event (a message) rather than a
  /// state that stays true for a while.
  bool get isEvent => type == ConditionType.messageReceived;

  /// Whether every field this type needs is filled in.
  bool get isComplete => switch (type) {
    ConditionType.batteryBelow => percent > 0 && percent <= 100,
    ConditionType.timeOfDay => minuteOfDay >= 0 && minuteOfDay < 24 * 60,
    ConditionType.enterArea || ConditionType.leaveArea =>
      latitude != null && longitude != null && radiusMeters > 0,
    ConditionType.messageReceived => true,
    ConditionType.nodeOnline ||
    ConditionType.nodeOffline => nodeKey != null && minutes > 0,
  };

  Map<String, dynamic> toJson() => {
    'type': type.name,
    'percent': percent,
    'minuteOfDay': minuteOfDay,
    'latitude': ?latitude,
    'longitude': ?longitude,
    'radiusMeters': radiusMeters,
    'nodeKey': ?nodeKey,
    'minutes': minutes,
    'source': source.name,
    'channelIndex': ?channelIndex,
    'contains': contains,
  };

  /// Null for anything unreadable, so one bad condition can't lose the rule
  /// list.
  static AutomationCondition? fromJson(Object? j) {
    if (j is! Map) return null;
    final type = ConditionType.values.asNameMap()[j['type']];
    if (type == null) return null;
    return AutomationCondition(
      type: type,
      percent: (j['percent'] as num?)?.toInt() ?? 20,
      minuteOfDay: (j['minuteOfDay'] as num?)?.toInt() ?? 480,
      latitude: (j['latitude'] as num?)?.toDouble(),
      longitude: (j['longitude'] as num?)?.toDouble(),
      radiusMeters: (j['radiusMeters'] as num?)?.toInt() ?? 500,
      nodeKey: j['nodeKey'] as String?,
      minutes: (j['minutes'] as num?)?.toInt() ?? 30,
      source:
          MessageSource.values.asNameMap()[j['source']] ?? MessageSource.any,
      channelIndex: (j['channelIndex'] as num?)?.toInt(),
      contains: j['contains'] as String? ?? '',
    );
  }
}

enum ActionType {
  /// Send a plain-text message on air (to a contact, a channel, or the
  /// working channel). Logged in the station log.
  sendMessage,

  /// Post a notification on this device.
  alert,

  /// Make [AutomationAction.channelIndex] the working channel.
  changeChannel,

  /// Play an alert sound on this device.
  playSound,

  /// POST a short JSON note to an https address. Needs internet, and is
  /// off until webhooks are allowed in the automation settings.
  webhook,
}

/// Where a [ActionType.sendMessage] goes.
enum SendTarget { contact, channel, workingChannel }

/// One thing a rule does. Only the fields for its [type] matter.
class AutomationAction {
  const AutomationAction({
    required this.type,
    this.target = SendTarget.workingChannel,
    this.contactKey,
    this.channelIndex,
    this.text = '',
    this.url = '',
  });

  final ActionType type;
  final SendTarget target;
  final String? contactKey;
  final int? channelIndex;

  /// The message to send, or the alert's text.
  final String text;
  final String url;

  /// A copy with the given fields changed. Nullable fields take a getter so
  /// they can be cleared.
  AutomationAction copyWith({
    SendTarget? target,
    ValueGetter<String?>? contactKey,
    ValueGetter<int?>? channelIndex,
    String? text,
    String? url,
  }) => AutomationAction(
    type: type,
    target: target ?? this.target,
    contactKey: contactKey == null ? this.contactKey : contactKey(),
    channelIndex: channelIndex == null ? this.channelIndex : channelIndex(),
    text: text ?? this.text,
    url: url ?? this.url,
  );

  /// Whether this action transmits on the radio.
  bool get transmits => type == ActionType.sendMessage;

  /// Whether every field this type needs is filled in and allowed.
  bool get isComplete => switch (type) {
    ActionType.sendMessage =>
      isValidAutomationText(text) &&
          switch (target) {
            SendTarget.contact => contactKey != null,
            SendTarget.channel => channelIndex != null,
            SendTarget.workingChannel => true,
          },
    ActionType.alert => text.trim().isNotEmpty,
    ActionType.changeChannel => channelIndex != null,
    ActionType.playSound => true,
    ActionType.webhook => isValidWebhookUrl(url),
  };

  Map<String, dynamic> toJson() => {
    'type': type.name,
    'target': target.name,
    'contactKey': ?contactKey,
    'channelIndex': ?channelIndex,
    'text': text,
    'url': url,
  };

  static AutomationAction? fromJson(Object? j) {
    if (j is! Map) return null;
    final type = ActionType.values.asNameMap()[j['type']];
    if (type == null) return null;
    return AutomationAction(
      type: type,
      target:
          SendTarget.values.asNameMap()[j['target']] ??
          SendTarget.workingChannel,
      contactKey: j['contactKey'] as String?,
      channelIndex: (j['channelIndex'] as num?)?.toInt(),
      text: j['text'] as String? ?? '',
      url: j['url'] as String? ?? '',
    );
  }
}

/// How a rule's conditions combine.
enum ConditionMatch {
  /// Every condition must be true (AND).
  all,

  /// One true condition is enough (OR).
  any,
}

/// One "when this happens, do that" rule. Off until the user turns it on.
class AutomationRule {
  const AutomationRule({
    required this.id,
    required this.name,
    this.enabled = false,
    this.match = ConditionMatch.all,
    this.conditions = const [],
    this.actions = const [],
  });

  final String id;
  final String name;
  final bool enabled;
  final ConditionMatch match;
  final List<AutomationCondition> conditions;
  final List<AutomationAction> actions;

  /// Whether the rule can transmit on the radio.
  bool get transmits => actions.any((a) => a.transmits);

  /// Whether the rule reacts to messages.
  bool get hasEvent => conditions.any((c) => c.isEvent);

  /// Whether the rule can be turned on: named, at least one condition and
  /// one action, all filled in.
  bool get isComplete =>
      name.trim().isNotEmpty &&
      conditions.isNotEmpty &&
      actions.isNotEmpty &&
      conditions.every((c) => c.isComplete) &&
      actions.every((a) => a.isComplete);

  AutomationRule copyWith({
    String? name,
    bool? enabled,
    ConditionMatch? match,
    List<AutomationCondition>? conditions,
    List<AutomationAction>? actions,
  }) => AutomationRule(
    id: id,
    name: name ?? this.name,
    enabled: enabled ?? this.enabled,
    match: match ?? this.match,
    conditions: conditions ?? this.conditions,
    actions: actions ?? this.actions,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'enabled': enabled,
    'match': match.name,
    'conditions': [for (final c in conditions) c.toJson()],
    'actions': [for (final a in actions) a.toJson()],
  };

  /// Null for an unreadable rule. Unreadable conditions or actions are
  /// dropped and the rule is switched off, so it can't act on half a
  /// definition.
  static AutomationRule? fromJson(Object? j) {
    if (j is! Map) return null;
    final id = j['id'], name = j['name'];
    if (id is! String || id.isEmpty || name is! String) return null;
    final rawConditions = j['conditions'] is List
        ? j['conditions'] as List
        : const [];
    final rawActions = j['actions'] is List ? j['actions'] as List : const [];
    final conditions = [
      for (final c in rawConditions) ?AutomationCondition.fromJson(c),
    ];
    final actions = [for (final a in rawActions) ?AutomationAction.fromJson(a)];
    final lost =
        conditions.length != rawConditions.length ||
        actions.length != rawActions.length;
    return AutomationRule(
      id: id,
      name: name,
      enabled: !lost && j['enabled'] == true,
      match:
          ConditionMatch.values.asNameMap()[j['match']] ?? ConditionMatch.all,
      conditions: conditions,
      actions: actions,
    );
  }
}

/// A message that just arrived, for [ConditionType.messageReceived].
class AutomationMessage {
  const AutomationMessage({
    required this.text,
    this.senderKey,
    this.channelIndex,
  });

  final String text;

  /// The sender's public key (hex), when known.
  final String? senderKey;

  /// The channel it arrived on, or null for a direct message.
  final int? channelIndex;

  bool get isDirect => channelIndex == null;
}

/// What the rules can see at one moment. Null means not known right now.
class AutomationSnapshot {
  const AutomationSnapshot({
    required this.now,
    this.batteryPercent,
    this.latitude,
    this.longitude,
    this.nodeLastSeen = const {},
  });

  final DateTime now;
  final int? batteryPercent;
  final double? latitude;
  final double? longitude;
  final Map<String, DateTime> nodeLastSeen;
}

/// Decides which rules fire. No radio, storage or UI, so it can be tested.
///
/// A rule's conditions combine with AND ([ConditionMatch.all]) or OR
/// ([ConditionMatch.any]). On a timer [evaluate] fires a rule when the
/// combined result *becomes* true, once per crossing; the first reading
/// only records the state, so opening the app or connecting can't set off
/// a burst. A message fires a rule when a message condition matches it and
/// the combined result is true then. A rule that transmits waits
/// [txCooldown] before firing again; others wait [quietCooldown].
class AutomationEngine {
  static const txCooldown = Duration(minutes: 15);
  static const quietCooldown = Duration(minutes: 1);

  final Map<String, bool> _state = {};
  final Map<String, DateTime> _lastFired = {};

  /// The enabled, complete rules that should act now, in the given order.
  /// [message] is the message that just arrived, if this pass is for one.
  List<AutomationRule> evaluate(
    List<AutomationRule> rules,
    AutomationSnapshot snapshot, {
    AutomationMessage? message,
  }) {
    final now = snapshot.now;
    final fired = <AutomationRule>[];
    for (final rule in rules) {
      if (!rule.enabled || !rule.isComplete) {
        _state.remove(rule.id);
        continue;
      }
      if (message != null) {
        if (isAutomatedText(message.text)) continue;
        final matched = rule.conditions.any(
          (c) => c.isEvent && _messageMatches(c, message),
        );
        if (!matched) continue;
        if (_combine(rule, snapshot, message) != true) continue;
      } else {
        final condition = _combine(rule, snapshot, null);
        if (condition == null) continue; // Unknown keeps the last state.
        final previous = _state[rule.id];
        _state[rule.id] = condition;
        if (previous != false || !condition) continue;
      }
      final last = _lastFired[rule.id];
      final wait = rule.transmits ? txCooldown : quietCooldown;
      if (last != null && now.difference(last) < wait) continue;
      _lastFired[rule.id] = now;
      fired.add(rule);
    }
    return fired;
  }

  /// AND/OR of the rule's conditions. Unknown (null) only decides the
  /// result when nothing known does: AND is false if any condition is
  /// false, OR is true if any is true.
  bool? _combine(
    AutomationRule rule,
    AutomationSnapshot s,
    AutomationMessage? message,
  ) {
    var unknown = false;
    for (final c in rule.conditions) {
      final v = _condition(c, s, message);
      if (v == null) {
        unknown = true;
      } else if (rule.match == ConditionMatch.all && !v) {
        return false;
      } else if (rule.match == ConditionMatch.any && v) {
        return true;
      }
    }
    if (unknown) return null;
    return rule.match == ConditionMatch.all;
  }

  bool? _condition(
    AutomationCondition c,
    AutomationSnapshot s,
    AutomationMessage? message,
  ) {
    switch (c.type) {
      case ConditionType.batteryBelow:
        final battery = s.batteryPercent;
        return battery == null ? null : battery < c.percent;
      case ConditionType.timeOfDay:
        final local = s.now.toLocal();
        return local.hour * 60 + local.minute == c.minuteOfDay;
      case ConditionType.enterArea:
        return _inside(c, s);
      case ConditionType.leaveArea:
        final inside = _inside(c, s);
        return inside == null ? null : !inside;
      case ConditionType.messageReceived:
        return message != null && _messageMatches(c, message);
      case ConditionType.nodeOnline:
        return _heard(c, s);
      case ConditionType.nodeOffline:
        final heard = _heard(c, s);
        return heard == null ? null : !heard;
    }
  }

  bool _messageMatches(AutomationCondition c, AutomationMessage m) {
    switch (c.source) {
      case MessageSource.any:
        break;
      case MessageSource.direct:
        if (!m.isDirect) return false;
      case MessageSource.channel:
        if (m.isDirect) return false;
        if (c.channelIndex != null && c.channelIndex != m.channelIndex) {
          return false;
        }
    }
    final from = c.nodeKey;
    if (from != null && from != m.senderKey) return false;
    final needle = c.contains.trim().toLowerCase();
    return needle.isEmpty || m.text.toLowerCase().contains(needle);
  }

  bool? _inside(AutomationCondition c, AutomationSnapshot s) {
    final lat = s.latitude, lon = s.longitude;
    final cLat = c.latitude, cLon = c.longitude;
    if (lat == null || lon == null || cLat == null || cLon == null) {
      return null;
    }
    // A radio with no fix reports 0,0; don't treat that as a position.
    if (lat == 0 && lon == 0) return null;
    final meters = const Distance().as(
      LengthUnit.Meter,
      LatLng(lat, lon),
      LatLng(cLat, cLon),
    );
    return meters <= c.radiusMeters;
  }

  bool? _heard(AutomationCondition c, AutomationSnapshot s) {
    final seen = s.nodeLastSeen[c.nodeKey];
    if (seen == null) return null;
    return s.now.difference(seen) <= Duration(minutes: c.minutes);
  }
}

/// Caps automated transmissions across all rules: at most [maxSends] in
/// any [window], so a bad rule can't flood the band.
class AutomationTxLimiter {
  AutomationTxLimiter({
    this.maxSends = 3,
    this.window = const Duration(minutes: 10),
  });

  final int maxSends;
  final Duration window;
  final List<DateTime> _sends = [];

  /// Whether a send at [now] is allowed; if so, it is counted.
  bool take(DateTime now) {
    _sends.removeWhere((t) => now.difference(t) >= window);
    if (_sends.length >= maxSends) return false;
    _sends.add(now);
    return true;
  }
}
