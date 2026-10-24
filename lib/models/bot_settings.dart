import 'dart:convert';

const botPrefix = '[NOTORYX Bot] ';

/// Bot prefixes older releases sent; their replies are never answered, so
/// two bots can't keep replying to each other.
const legacyBotPrefixes = ['[Bastion Bot]', '[BCS Bot]'];
const botCommands = <String>[
  '!ping',
  '!status',
  '!battery',
  '!help',
  '!info',
  '!checkin',
  '!repeater',
];

class BotRule {
  final String trigger;
  final String response;
  final bool enabled;
  final bool contains;
  final String? senderKey;

  const BotRule({
    required this.trigger,
    required this.response,
    this.enabled = true,
    this.contains = false,
    this.senderKey,
  });

  bool matches(String text, String sender) =>
      enabled &&
      (senderKey == null || senderKey == sender) &&
      trigger.trim().isNotEmpty &&
      (contains
          ? text.toLowerCase().contains(trigger.trim().toLowerCase())
          : text.trim().toLowerCase() == trigger.trim().toLowerCase());

  Map<String, dynamic> toJson() => {
    'trigger': trigger,
    'response': response,
    'enabled': enabled,
    'contains': contains,
    'senderKey': senderKey,
  };

  factory BotRule.fromJson(Map<String, dynamic> json) => BotRule(
    trigger: json['trigger'] as String,
    response: json['response'] as String,
    enabled: json['enabled'] as bool? ?? true,
    contains: json['contains'] as bool? ?? false,
    senderKey: json['senderKey'] as String?,
  );
}

class BotSettings {
  final bool enabled;
  final bool awayEnabled;
  final bool shareLocation;
  final String awayMessage;
  final String info;
  final String checkIn;
  final int cooldownSeconds;
  final int repliesPerMinute;
  final Set<String> commands;
  final List<BotRule> rules;
  final Set<String> allowedSenders;

  BotSettings({
    this.enabled = false,
    this.awayEnabled = true,
    this.shareLocation = false,
    this.awayMessage = "I'm away. Your message was received by NOTORYX Core.",
    this.info = 'NOTORYX Core',
    this.checkIn = 'No check-in status configured.',
    this.cooldownSeconds = 300,
    this.repliesPerMinute = 3,
    Set<String>? commands,
    List<BotRule> rules = const [],
    Set<String> allowedSenders = const {},
  }) : commands = Set.unmodifiable(commands ?? botCommands.toSet()),
       rules = List.unmodifiable(rules),
       allowedSenders = Set.unmodifiable(allowedSenders);

  BotSettings copyWith({
    bool? enabled,
    bool? awayEnabled,
    bool? shareLocation,
    String? awayMessage,
    String? info,
    String? checkIn,
    int? cooldownSeconds,
    int? repliesPerMinute,
    Set<String>? commands,
    List<BotRule>? rules,
    Set<String>? allowedSenders,
  }) => BotSettings(
    enabled: enabled ?? this.enabled,
    awayEnabled: awayEnabled ?? this.awayEnabled,
    shareLocation: shareLocation ?? this.shareLocation,
    awayMessage: awayMessage ?? this.awayMessage,
    info: info ?? this.info,
    checkIn: checkIn ?? this.checkIn,
    cooldownSeconds: cooldownSeconds ?? this.cooldownSeconds,
    repliesPerMinute: repliesPerMinute ?? this.repliesPerMinute,
    commands: commands ?? this.commands,
    rules: rules ?? this.rules,
    allowedSenders: allowedSenders ?? this.allowedSenders,
  );

  Map<String, dynamic> toJson() => {
    'enabled': enabled,
    'awayEnabled': awayEnabled,
    'shareLocation': shareLocation,
    'awayMessage': awayMessage,
    'info': info,
    'checkIn': checkIn,
    'cooldownSeconds': cooldownSeconds,
    'repliesPerMinute': repliesPerMinute,
    'commands': commands.toList(),
    'rules': rules.map((r) => r.toJson()).toList(),
    'allowedSenders': allowedSenders.toList(),
  };

  factory BotSettings.fromJson(Map<String, dynamic> json) => BotSettings(
    enabled: json['enabled'] as bool? ?? false,
    awayEnabled: json['awayEnabled'] as bool? ?? true,
    shareLocation: json['shareLocation'] as bool? ?? false,
    awayMessage:
        json['awayMessage'] as String? ??
        "I'm away. Your message was received by NOTORYX Core.",
    info: json['info'] as String? ?? 'NOTORYX Core',
    checkIn: json['checkIn'] as String? ?? 'No check-in status configured.',
    cooldownSeconds: (json['cooldownSeconds'] as int? ?? 300).clamp(60, 3600),
    repliesPerMinute: (json['repliesPerMinute'] as int? ?? 3).clamp(1, 6),
    commands: (json['commands'] as List?)?.cast<String>().toSet(),
    rules: (json['rules'] as List? ?? [])
        .map((r) => BotRule.fromJson(Map<String, dynamic>.from(r as Map)))
        .toList(),
    allowedSenders: (json['allowedSenders'] as List? ?? [])
        .cast<String>()
        .toSet(),
  );
}

/// Keep automated replies comfortably below MeshCore's text payload limit.
/// Counts UTF-8 bytes (including the bot marker), rather than characters.
bool isValidBotResponse(String response) =>
    response.trim().isNotEmpty &&
    utf8.encode('$botPrefix${response.trim()}').length <= 140;
