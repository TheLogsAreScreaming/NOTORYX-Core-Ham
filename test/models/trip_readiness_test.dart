import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/trip_readiness.dart';

ReadinessInputs inputs({
  bool connected = true,
  int? battery = 80,
  String? sosUnavailable,
  bool hasSosChannel = false,
  int tripMembers = 2,
  int presentMembers = 2,
  List<String> noRoute = const [],
  ({int available, int expected})? map = (available: 10, expected: 10),
  bool shareLocation = false,
  bool hasPosition = false,
  bool? notifications = true,
  bool? exempt = true,
  bool automation = false,
  bool foreground = true,
}) => ReadinessInputs(
  connected: connected,
  radioBatteryPercent: battery,
  sosUnavailable: sosUnavailable,
  hasSosChannel: hasSosChannel,
  tripMembers: tripMembers,
  presentMembers: presentMembers,
  membersWithoutRoute: noRoute,
  offlineMap: map,
  shareLocation: shareLocation,
  hasPosition: hasPosition,
  notificationsAllowed: notifications,
  batteryOptimisationExempt: exempt,
  automationEnabled: automation,
  foreground: foreground,
);

ReadinessLevel levelOf(List<ReadinessItem> items, ReadinessCheck check) =>
    items.firstWhere((i) => i.check == check).level;

void main() {
  test('everything set up passes, and the trip can start', () {
    final items = assessTrip(inputs());
    expect(readinessProblems(items), isEmpty);
    expect(canStartTrip(items), isTrue);
    expect(items.first.check, ReadinessCheck.sosRecipients);
  });

  group('SOS recipients block the trip', () {
    test('connected, SOS rules say no one to reach', () {
      final items = assessTrip(inputs(sosUnavailable: 'no target'));
      expect(
        levelOf(items, ReadinessCheck.sosRecipients),
        ReadinessLevel.block,
      );
      expect(canStartTrip(items), isFalse);
    });

    test('not connected and no trip contacts or SOS channel', () {
      final items = assessTrip(
        inputs(connected: false, tripMembers: 0, sosUnavailable: 'offline'),
      );
      expect(canStartTrip(items), isFalse);
    });

    test('not connected alone only warns', () {
      final items = assessTrip(
        inputs(connected: false, sosUnavailable: 'not connected'),
      );
      expect(levelOf(items, ReadinessCheck.sosRecipients), ReadinessLevel.ok);
      expect(levelOf(items, ReadinessCheck.radio), ReadinessLevel.warn);
      expect(canStartTrip(items), isTrue);
    });

    test('an SOS channel counts as a recipient', () {
      final items = assessTrip(
        inputs(connected: false, tripMembers: 0, hasSosChannel: true),
      );
      expect(canStartTrip(items), isTrue);
    });
  });

  test('warnings never block', () {
    final items = assessTrip(
      inputs(
        battery: 12,
        presentMembers: 1,
        noRoute: ['Sam'],
        map: null,
        shareLocation: true,
        notifications: false,
        exempt: false,
        automation: true,
        foreground: false,
      ),
    );
    expect(canStartTrip(items), isTrue);
    expect(
      readinessProblems(items).map((i) => i.check),
      containsAll([
        ReadinessCheck.radioBattery,
        ReadinessCheck.tripContacts,
        ReadinessCheck.routes,
        ReadinessCheck.offlineMap,
        ReadinessCheck.location,
        ReadinessCheck.notifications,
        ReadinessCheck.batteryOptimisation,
        ReadinessCheck.automation,
      ]),
    );
    expect(items.firstWhere((i) => i.check == ReadinessCheck.routes).names, [
      'Sam',
    ]);
  });

  test('battery threshold and unknown battery', () {
    expect(
      levelOf(assessTrip(inputs(battery: 30)), ReadinessCheck.radioBattery),
      ReadinessLevel.ok,
    );
    expect(
      levelOf(assessTrip(inputs(battery: 29)), ReadinessCheck.radioBattery),
      ReadinessLevel.warn,
    );
    expect(
      levelOf(assessTrip(inputs(battery: null)), ReadinessCheck.radioBattery),
      ReadinessLevel.warn,
    );
  });

  test('platform checks are left out where the platform can\'t say', () {
    final items = assessTrip(inputs(notifications: null, exempt: null));
    expect(
      items.map((i) => i.check),
      isNot(contains(ReadinessCheck.notifications)),
    );
    expect(
      items.map((i) => i.check),
      isNot(contains(ReadinessCheck.batteryOptimisation)),
    );
  });

  test('a partly cached map area warns', () {
    expect(
      levelOf(
        assessTrip(inputs(map: (available: 9, expected: 10))),
        ReadinessCheck.offlineMap,
      ),
      ReadinessLevel.warn,
    );
  });
}
