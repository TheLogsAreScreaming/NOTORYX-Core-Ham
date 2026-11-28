part of 'meshcore_connector.dart';

/// The on-device channel message filter: tags spam and repeats on arrival,
/// keeps rule tags in step with the rules, and keeps emergency traffic out
/// of its reach. Filtered messages are stored and never deleted.
///
/// Adapted from meshcore-open (MIT, copyright zjs81 and contributors).
extension _ConnectorMessageFilter on MeshCoreConnector {
  /// Matches the words people use for emergencies in any channel post, so a
  /// rule, a repeat or the learned model can never hide a call for help.
  static final _emergencyWords = RegExp(
    r'\b(sos|mayday|emergency)\b',
    caseSensitive: false,
  );

  /// Whether [text] must always be shown: this app's SOS and check-in
  /// posts (current and legacy tags) and anything naming an emergency.
  static bool _isProtectedFromFilter(String text) =>
      isSosText(text) || isCheckInText(text) || _emergencyWords.hasMatch(text);

  String _messageFilterChannelIdForSlot(int slot) {
    final channel = _findChannelByIndex(slot);
    if (channel != null) {
      return MeshCoreConnector.messageFilterChannelId(channel);
    }
    return 'slot:$slot';
  }

  /// Text the filter sees: the stored text, without a leading `@[name] `
  /// reply mention.
  static String _messageFilterText(ChannelMessage message) =>
      ChannelMessage.parseReplyMention(message.text)?.actualMessage ??
      message.text;

  /// Runs a new incoming channel message through the filter. Filtered
  /// messages come back tagged (never dropped). Outgoing messages,
  /// reactions, structured payloads and emergency traffic pass untouched.
  ChannelMessage _applyMessageFilter(int slot, ChannelMessage message) {
    final service = _messageFilterService;
    if (service == null || message.isOutgoing) return message;
    final text = _messageFilterText(message);
    if (_isProtectedFromFilter(message.text)) return message;
    final verdict = service.evaluate(
      channelId: _messageFilterChannelIdForSlot(slot),
      sender: message.senderName,
      text: text,
      // The sender's timestamp, not arrival time: queued history synced
      // after reconnecting arrives in a burst but was sent spread out.
      sentAt: message.timestamp,
      isReaction: message.parseReaction() != null,
      isReply:
          message.replyToSenderName != null ||
          ChannelMessage.parseReplyMention(message.text) != null,
    );
    return MeshCoreConnector.applyFilterVerdict(message, verdict);
  }

  /// Remembers a newly stored, unfiltered incoming message as an implicit
  /// "not spam" example. Called once per message, after dedup.
  void _recordCleanChannelMessage(int slot, ChannelMessage message) {
    final service = _messageFilterService;
    if (service == null) return;
    if (message.isOutgoing || message.isFiltered) return;
    if (message.parseReaction() != null) return;
    service.recordClean(
      channelId: _messageFilterChannelIdForSlot(slot),
      sender: message.senderName,
      text: _messageFilterText(message),
    );
  }

  /// Whether the stored copy of [message] is hidden by the filter, in which
  /// case it neither notifies, counts as unread, gets translated nor reaches
  /// bots and automations.
  bool _isHiddenByFilter(ChannelMessage message) {
    final slot = message.channelIndex;
    final service = _messageFilterService;
    if (slot == null || service == null || message.isOutgoing) return false;
    if (!service.isChannelFiltered(_messageFilterChannelIdForSlot(slot))) {
      return false;
    }
    final messages = _channelMessages[slot];
    if (messages == null) return false;
    for (var i = messages.length - 1; i >= 0; i--) {
      if (messages[i].messageId == message.messageId) {
        return messages[i].isFiltered;
      }
    }
    return false;
  }

  void _onMessageFilterChanged() {
    final service = _messageFilterService;
    if (service == null ||
        service.rulesRevision == _appliedFilterRulesRevision) {
      return;
    }
    _appliedFilterRulesRevision = service.rulesRevision;
    var changed = false;
    _channelMessages.forEach((slot, messages) {
      if (_applyFilterRules(slot, messages)) {
        _channelMessageStore.saveChannelMessages(slot, messages);
        changed = true;
      }
    });
    if (changed) notifyListeners();
  }

  /// Brings rule tags on stored [messages] in line with the current rules:
  /// a new rule hides messages that already arrived, and a deleted or
  /// disabled rule shows again what only it was hiding. Tags from other
  /// reasons are left alone. Returns whether anything changed.
  bool _applyFilterRules(int slot, List<ChannelMessage> messages) {
    final service = _messageFilterService;
    if (service == null || messages.isEmpty) return false;
    final channelId = _messageFilterChannelIdForSlot(slot);
    if (!service.isChannelFiltered(channelId)) return false;
    var changed = false;
    for (var i = 0; i < messages.length; i++) {
      final message = messages[i];
      if (message.isOutgoing || message.parseReaction() != null) continue;
      if (_isProtectedFromFilter(message.text)) continue;
      final reason = filterReasonFromJson(message.filterReason);
      final ruleTagged =
          reason == FilterReason.senderRule || reason == FilterReason.textRule;
      if (message.isFiltered && !ruleTagged) continue;
      final verdict = service.ruleVerdict(
        channelId: channelId,
        sender: message.senderName,
        text: _messageFilterText(message),
      );
      if (verdict == null) {
        if (ruleTagged) {
          messages[i] = message.copyWith(clearFilter: true);
          changed = true;
        }
      } else if (reason != verdict.reason ||
          message.filterDetail != verdict.detail) {
        messages[i] = MeshCoreConnector.applyFilterVerdict(
          message.copyWith(clearFilter: true),
          verdict,
        );
        changed = true;
      }
    }
    return changed;
  }

  /// Replaces the stored message [messageId] in [channel] with [update]'s
  /// result and saves. Returns false when it is not loaded.
  bool _updateLoadedChannelMessageById(
    Channel channel,
    String messageId,
    ChannelMessage Function(ChannelMessage existing) update,
  ) {
    final messages = _channelMessages[channel.index];
    if (messages == null) return false;
    final index = messages.indexWhere((m) => m.messageId == messageId);
    if (index < 0) return false;
    messages[index] = update(messages[index]);
    _channelMessageStore.saveChannelMessages(channel.index, messages);
    return true;
  }
}
