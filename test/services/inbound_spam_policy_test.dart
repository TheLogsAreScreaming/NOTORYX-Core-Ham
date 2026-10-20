import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/services/inbound_spam_policy.dart';

void main() {
  test('rate limits individual senders without affecting others', () {
    final policy = InboundSpamPolicy(maxMessagesPerWindow: 2);
    final now = DateTime.utc(2026);
    expect(policy.evaluate(senderKey: 'a', receivedAt: now), SpamDecision.allow);
    expect(policy.evaluate(senderKey: 'a', receivedAt: now), SpamDecision.allow);
    expect(
      policy.evaluate(senderKey: 'a', receivedAt: now),
      SpamDecision.rateLimited,
    );
    expect(policy.evaluate(senderKey: 'b', receivedAt: now), SpamDecision.allow);
    expect(
      policy.evaluate(
        senderKey: 'a',
        receivedAt: now.add(const Duration(minutes: 2)),
      ),
      SpamDecision.allow,
    );
  });

  test('emergency and control traffic bypasses local moderation', () {
    final policy = InboundSpamPolicy();
    policy.blockedSenders.add('a');
    expect(
      policy.evaluate(senderKey: 'a', receivedAt: DateTime.utc(2026)),
      SpamDecision.block,
    );
    expect(
      policy.evaluate(
        senderKey: 'a',
        receivedAt: DateTime.utc(2026),
        emergencyOrControl: true,
      ),
      SpamDecision.allow,
    );
  });
}
