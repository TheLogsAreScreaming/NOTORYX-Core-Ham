import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/field_ops.dart';

void main() {
  test('brief resolves names and omits keys and message history', () {
    const trip = TripPlan(
      name: 'Mountain loop',
      members: ['private-key-1', 'missing-key'],
      shareLocation: true,
      active: true,
    );
    final text = tripBrief(trip, {'private-key-1': 'Alex'});
    expect(text, contains('Mountain loop'));
    expect(text, contains('Alex, Unavailable contact'));
    expect(text, contains('Status: Active'));
    expect(text, contains('Included; may be stale'));
    expect(text, isNot(contains('private-key-1')));
    expect(text, isNot(contains('missing-key')));
    expect(text, contains('does not send a radio message'));
  });

  test('default brief accurately describes a stopped private trip', () {
    final text = tripBrief(const TripPlan(), {});
    expect(text, contains('Status: Stopped'));
    expect(text, contains('None selected'));
    expect(text, contains('Radio position in check-ins: Off'));
    expect(text, contains('Radio battery in check-ins: Off'));
  });

  test(
    'check-in requires complete roster even on an active connected trip',
    () {
      String? reason(int selected, int available) => checkInUnavailableReason(
        ready: true,
        storageError: false,
        active: true,
        connected: true,
        busy: false,
        selectedContacts: selected,
        availableContacts: available,
      );
      expect(reason(0, 0), contains('Choose trip contacts'));
      expect(reason(2, 1), contains('unavailable'));
      expect(reason(2, 2), isNull);
    },
  );

  test('storage failure takes precedence over a disconnected radio', () {
    expect(
      checkInUnavailableReason(
        ready: true,
        storageError: true,
        active: false,
        connected: false,
        busy: false,
        selectedContacts: 0,
        availableContacts: 0,
      ),
      contains('storage error'),
    );
  });
}
