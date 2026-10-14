import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/field_ops.dart';

void main() {
  final now = DateTime.utc(2026, 10, 5, 12);
  test('schedule distinguishes timely action from missed deadline', () {
    final rule = FieldRule(
      id: 'scheduled',
      trigger: FieldTrigger.scheduled,
      nextDue: now,
    );
    expect(
      scheduleState(rule, now.subtract(const Duration(seconds: 1))),
      ScheduleState.waiting,
    );
    expect(scheduleState(rule, now), ScheduleState.due);
    expect(
      scheduleState(rule, now.add(const Duration(minutes: 3))),
      ScheduleState.missed,
    );
  });
  test('rule cooldown blocks repeated and backwards-clock events', () {
    final rule = FieldRule(
      id: 'battery',
      trigger: FieldTrigger.lowBattery,
      lastRun: now,
    );
    expect(
      ruleCooldownPassed(rule, now.subtract(const Duration(minutes: 1))),
      false,
    );
    expect(
      ruleCooldownPassed(rule, now.add(const Duration(minutes: 9))),
      false,
    );
    expect(
      ruleCooldownPassed(rule, now.add(const Duration(minutes: 10))),
      true,
    );
  });
  test('loaded rule settings bound airtime and battery thresholds', () {
    final rule = FieldRule.fromJson({
      'id': 'timer',
      'trigger': 'scheduled',
      'action': 'checkIn',
      'intervalMinutes': 1,
      'batteryThreshold': 99,
    });
    expect(rule.intervalMinutes, 15);
    expect(rule.batteryThreshold, 50);
    expect(rule.dryRun, true);
  });
  test('trip roster is deduplicated and bounded after restart', () {
    final trip = TripPlan.fromJson({
      'name': 'Trip',
      'members': ['a', 'a', 'b', 'c', 'd', 'e', 'f', 'g'],
      'active': true,
    });
    expect(trip.members, ['a', 'b', 'c', 'd', 'e', 'f']);
    expect(trip.active, false);
    expect(trip.shareLocation, false);
    expect(trip.shareBattery, false);
  });
  test('delivery explanations distinguish acknowledgment from reading', () {
    expect(explainMessageStatus('pending'), contains('does not confirm'));
    expect(
      explainMessageStatus('sent'),
      contains('No delivery acknowledgment'),
    );
    expect(explainMessageStatus('delivered'), contains('does not prove'));
  });
  test('location is omitted unless explicitly supplied', () {
    expect(checkInText('At Camp', now), isNot(contains('Radio advert')));
    expect(
      checkInText('At Camp', now, latitude: 35.4, longitude: -83.8),
      contains('may be stale'),
    );
  });
}
