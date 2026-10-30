import '../models/bot_settings.dart';
import '../models/field_ops.dart';

/// Deterministic local policy; no radio, UI, network or background dependency.
class BotEngine {
  final Map<String, DateTime> _seen = {};
  final Map<String, DateTime> _lastReply = {};
  final List<DateTime> _recentReplies = [];

  String? reply({
    required BotSettings settings,
    required String messageId,
    required String sender,
    required String text,
    required DateTime timestamp,
    required DateTime now,
    required Map<String, String> commandResponses,
    Map<String, String? Function(String args)> argCommands = const {},
    bool eligible = true,
    bool channel = false,
  }) {
    _seen.removeWhere((_, time) => now.difference(time).inMinutes > 10);
    _lastReply.removeWhere((_, time) => now.difference(time).inHours > 1);
    _recentReplies.removeWhere((time) => now.difference(time).inSeconds >= 60);
    if (_seen.containsKey(messageId)) {
      return null;
    }
    _seen[messageId] = now;
    // Bound memory even if a peer continuously sends unique ignored messages.
    if (_seen.length > 1000) {
      _seen.remove(_seen.keys.first);
    }
    final age = now.difference(timestamp);
    if (!eligible ||
        !settings.enabled ||
        age > const Duration(minutes: 2) ||
        age < const Duration(seconds: -30) ||
        text.trim().isEmpty ||
        text.trimLeft().startsWith(botPrefix.trim()) ||
        legacyBotPrefixes.any(text.trimLeft().startsWith) ||
        isCheckInText(text) ||
        // In a channel only !commands are answered: no away replies or
        // keyword matches in a room full of people.
        (channel && !text.trimLeft().startsWith('!')) ||
        (settings.allowedSenders.isNotEmpty &&
            !settings.allowedSenders.contains(sender))) {
      return null;
    }
    final previous = _lastReply[sender];
    if (previous != null &&
        now.difference(previous).inSeconds < settings.cooldownSeconds) {
      return null;
    }
    if (_recentReplies.length >= settings.repliesPerMinute) {
      return null;
    }

    final command = text.trim().toLowerCase();
    String? response;
    if (settings.commands.contains(command) ||
        (command == '!where' && settings.shareLocation && !channel)) {
      response = commandResponses[command];
    }
    // Commands that take an argument, like "!dice 2d6", match on the first
    // word; the rest are exact matches so "!ping now" stays unanswered.
    if (response == null) {
      final words = command.split(RegExp(r'\s+'));
      final handler = argCommands[words.first];
      if (handler != null && settings.commands.contains(words.first)) {
        response = handler(words.skip(1).join(' '));
      }
    }
    if (response == null) {
      for (final rule in settings.rules) {
        if (channel && rule.contains) continue;
        if (rule.matches(text, sender)) {
          response = rule.response;
          break;
        }
      }
    }
    // Unknown/disabled commands do not trigger an away reply.
    if (response == null &&
        !channel &&
        !command.startsWith('!') &&
        settings.awayEnabled) {
      response = settings.awayMessage;
    }
    if (response == null || !isValidBotResponse(response)) {
      return null;
    }
    // Reserve before any asynchronous send; concurrent arrivals share limits.
    _lastReply[sender] = now;
    _recentReplies.add(now);
    return '$botPrefix${response.trim()}';
  }

  Map<String, dynamic> get budget => {
    'senders': _lastReply.map(
      (key, time) => MapEntry(key, time.toIso8601String()),
    ),
    'recent': _recentReplies.map((time) => time.toIso8601String()).toList(),
  };

  void restoreBudget(Map<String, dynamic> json) {
    final senders = Map<String, dynamic>.from(json['senders'] as Map? ?? {});
    for (final entry in senders.entries) {
      final time = DateTime.tryParse(entry.value.toString());
      if (time != null) {
        _lastReply[entry.key] = time;
      }
    }
    for (final value in json['recent'] as List? ?? []) {
      final time = DateTime.tryParse(value.toString());
      if (time != null) {
        _recentReplies.add(time);
      }
    }
  }
}
