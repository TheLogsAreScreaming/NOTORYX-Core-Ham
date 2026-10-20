/// Local, user-controlled inbound message moderation.
///
/// This policy does not authenticate senders or stop radio transmissions.
/// Callers must bypass filtering for trusted emergency/control traffic.
class InboundSpamPolicy {
  InboundSpamPolicy({
    this.window = const Duration(minutes: 1),
    this.maxMessagesPerWindow = 20,
  });

  final Duration window;
  final int maxMessagesPerWindow;
  final Set<String> blockedSenders = <String>{};
  final Set<String> mutedSenders = <String>{};
  final Map<String, List<DateTime>> _recent = <String, List<DateTime>>{};

  SpamDecision evaluate({
    required String senderKey,
    required DateTime receivedAt,
    bool emergencyOrControl = false,
  }) {
    if (emergencyOrControl) return SpamDecision.allow;
    if (blockedSenders.contains(senderKey)) return SpamDecision.block;
    if (mutedSenders.contains(senderKey)) return SpamDecision.mute;
    final events = _recent.putIfAbsent(senderKey, () => <DateTime>[]);
    events.removeWhere(
      (event) =>
          receivedAt.difference(event) >= window ||
          event.isAfter(receivedAt),
    );
    if (events.length >= maxMessagesPerWindow) {
      return SpamDecision.rateLimited;
    }
    events.add(receivedAt);
    return SpamDecision.allow;
  }

  void clearHistory() => _recent.clear();
}

enum SpamDecision { allow, mute, block, rateLimited }
