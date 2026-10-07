import 'dart:convert';

enum FieldTrigger {
  reconnect,
  disconnect,
  lowBattery,
  newNode,
  repeater,
  scheduled,
}

enum FieldAction { log, notify, checkIn }

/// A local summary: never includes message history, public keys or coordinates.
String tripBrief(TripPlan trip, Map<String, String> contactNames) {
  final roster = trip.members.map(
    (key) => contactNames[key] ?? 'Unavailable contact (review roster)',
  );
  return [
    'BASTION • MeshCore Trip Brief',
    'Communication without infrastructure.',
    '',
    'Trip: ${trip.name}',
    'Status: ${trip.active ? 'Active' : 'Stopped'}',
    'Contacts: ${roster.isEmpty ? 'None selected' : roster.join(', ')}',
    'Activity overdue after: ${trip.overdueMinutes} minutes',
    'Check-in choices: I’m OK • At Camp • Delayed • Heading Back',
    'Radio position in check-ins: ${trip.shareLocation ? 'Included; may be stale' : 'Off'}',
    'Radio battery in check-ins: ${trip.shareBattery ? 'Included' : 'Off'}',
    '',
    'Review recipients and message before sending a check-in.',
    'Queued or sent does not prove delivery. An acknowledgment does not prove it was read.',
    'Overdue means no recent contact activity; it is not a confirmed emergency.',
    'Field automations run only while the app is active. Agree on a separate plan for missed contact.',
    'This brief shares information only; it does not send a radio message or start a trip.',
  ].join('\n');
}

String? checkInUnavailableReason({
  required bool ready,
  required bool storageError,
  required bool active,
  required bool connected,
  required bool busy,
  required int selectedContacts,
  required int availableContacts,
}) {
  if (!ready) return 'Loading your trip…';
  if (storageError) {
    return 'Resolve the Field Log storage error before sending.';
  }
  if (busy) return 'A check-in is being sent. Please wait.';
  if (selectedContacts == 0) return 'Choose trip contacts in Plan trip.';
  if (availableContacts != selectedContacts) {
    return 'Some trip contacts are unavailable. Review your roster.';
  }
  if (!connected) return 'Connect your MeshCore radio to check in.';
  if (!active) return 'Start your trip to enable check-ins.';
  return null;
}

class TripPlan {
  final String name;
  final List<String> members;
  final bool active;
  final bool shareLocation;
  final bool shareBattery;
  final int overdueMinutes;
  const TripPlan({
    this.name = 'My trip',
    this.members = const [],
    this.active = false,
    this.shareLocation = false,
    this.shareBattery = false,
    this.overdueMinutes = 60,
  });
  TripPlan copyWith({
    String? name,
    List<String>? members,
    bool? active,
    bool? shareLocation,
    bool? shareBattery,
    int? overdueMinutes,
  }) => TripPlan(
    name: name ?? this.name,
    members: members ?? this.members,
    active: active ?? this.active,
    shareLocation: shareLocation ?? this.shareLocation,
    shareBattery: shareBattery ?? this.shareBattery,
    overdueMinutes: overdueMinutes ?? this.overdueMinutes,
  );
  Map<String, dynamic> toJson() => {
    'name': name,
    'members': members,
    'active': active,
    'shareLocation': shareLocation,
    'shareBattery': shareBattery,
    'overdueMinutes': overdueMinutes,
  };
  factory TripPlan.fromJson(Map<String, dynamic> j) => TripPlan(
    name: (j['name'] as String? ?? 'My trip').trim(),
    members: (j['members'] as List? ?? [])
        .whereType<String>()
        .toSet()
        .take(6)
        .toList(),
    // A restarted app must not silently resume transmissions.
    active: false,
    shareLocation: j['shareLocation'] == true,
    shareBattery: j['shareBattery'] == true,
    overdueMinutes: ((j['overdueMinutes'] as num?)?.toInt() ?? 60).clamp(
      15,
      1440,
    ),
  );
}

class FieldEntry {
  final String id;
  final DateTime at;
  final String kind;
  final String text;
  final String? contactKey;
  final String? messageId;
  final String? status;
  final String? tripName;
  final double? latitude;
  final double? longitude;
  const FieldEntry({
    required this.id,
    required this.at,
    required this.kind,
    required this.text,
    this.contactKey,
    this.messageId,
    this.status,
    this.tripName,
    this.latitude,
    this.longitude,
  });
  FieldEntry withStatus(String value) => FieldEntry(
    id: id,
    at: at,
    kind: kind,
    text: text,
    contactKey: contactKey,
    messageId: messageId,
    status: value,
    tripName: tripName,
    latitude: latitude,
    longitude: longitude,
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'at': at.toIso8601String(),
    'kind': kind,
    'text': text,
    'contactKey': contactKey,
    'messageId': messageId,
    'status': status,
    'tripName': tripName,
    'latitude': latitude,
    'longitude': longitude,
  };
  factory FieldEntry.fromJson(Map<String, dynamic> j) => FieldEntry(
    id: j['id'] as String,
    at: DateTime.parse(j['at'] as String),
    kind: j['kind'] as String,
    text: j['text'] as String,
    contactKey: j['contactKey'] as String?,
    messageId: j['messageId'] as String?,
    status: j['status'] as String?,
    tripName: j['tripName'] as String?,
    latitude: (j['latitude'] as num?)?.toDouble(),
    longitude: (j['longitude'] as num?)?.toDouble(),
  );
}

class FieldRule {
  final String id;
  final FieldTrigger trigger;
  final FieldAction action;
  final bool enabled;
  final bool dryRun;
  final int batteryThreshold;
  final int intervalMinutes;
  final DateTime? nextDue;
  final DateTime? lastRun;
  const FieldRule({
    required this.id,
    required this.trigger,
    this.action = FieldAction.log,
    this.enabled = false,
    this.dryRun = true,
    this.batteryThreshold = 20,
    this.intervalMinutes = 60,
    this.nextDue,
    this.lastRun,
  });
  FieldRule copyWith({
    FieldAction? action,
    bool? enabled,
    bool? dryRun,
    int? batteryThreshold,
    int? intervalMinutes,
    DateTime? nextDue,
    DateTime? lastRun,
  }) => FieldRule(
    id: id,
    trigger: trigger,
    action: action ?? this.action,
    enabled: enabled ?? this.enabled,
    dryRun: dryRun ?? this.dryRun,
    batteryThreshold: batteryThreshold ?? this.batteryThreshold,
    intervalMinutes: intervalMinutes ?? this.intervalMinutes,
    nextDue: nextDue ?? this.nextDue,
    lastRun: lastRun ?? this.lastRun,
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'trigger': trigger.name,
    'action': action.name,
    'enabled': enabled,
    'dryRun': dryRun,
    'batteryThreshold': batteryThreshold,
    'intervalMinutes': intervalMinutes,
    'nextDue': nextDue?.toIso8601String(),
    'lastRun': lastRun?.toIso8601String(),
  };
  factory FieldRule.fromJson(Map<String, dynamic> j) => FieldRule(
    id: j['id'] as String,
    trigger: FieldTrigger.values.byName(j['trigger'] as String),
    action: FieldAction.values.byName(j['action'] as String),
    enabled: j['enabled'] == true,
    dryRun: j['dryRun'] != false,
    batteryThreshold: ((j['batteryThreshold'] as num?)?.toInt() ?? 20).clamp(
      5,
      50,
    ),
    intervalMinutes: ((j['intervalMinutes'] as num?)?.toInt() ?? 60).clamp(
      15,
      1440,
    ),
    nextDue: DateTime.tryParse(j['nextDue'] as String? ?? ''),
    lastRun: DateTime.tryParse(j['lastRun'] as String? ?? ''),
  );
}

bool usablePosition(double? lat, double? lon) =>
    lat != null &&
    lon != null &&
    lat.isFinite &&
    lon.isFinite &&
    lat >= -90 &&
    lat <= 90 &&
    lon >= -180 &&
    lon <= 180 &&
    (lat.abs() > 0.000001 || lon.abs() > 0.000001);

String checkInText(
  String label,
  DateTime at, {
  double? latitude,
  double? longitude,
  int? battery,
}) {
  final stamp = at
      .toUtc()
      .toIso8601String()
      .substring(0, 16)
      .replaceFirst('T', ' ');
  var text = '[Bastion Check-in] $label | $stamp UTC';
  if (usablePosition(latitude, longitude)) {
    text +=
        ' | Radio advert ${latitude!.toStringAsFixed(4)},${longitude!.toStringAsFixed(4)} (may be stale)';
  }
  if (battery != null) text += ' | Battery $battery%';
  if (utf8.encode(text).length > 140) {
    throw ArgumentError('Check-in exceeds the 140-byte field limit.');
  }
  return text;
}

bool ruleCooldownPassed(FieldRule rule, DateTime now) =>
    rule.lastRun == null ||
    now.difference(rule.lastRun!) >= const Duration(minutes: 10);

enum ScheduleState { waiting, due, missed }

ScheduleState scheduleState(FieldRule rule, DateTime now) {
  final due = rule.nextDue;
  if (due == null || now.isBefore(due)) return ScheduleState.waiting;
  // Late timers never send a burst of historical check-ins.
  return now.difference(due) > const Duration(minutes: 2)
      ? ScheduleState.missed
      : ScheduleState.due;
}

String explainMessageStatus(String status) => switch (status) {
  'pending' =>
    'Queued locally. This does not confirm radio transmission or receipt.',
  'sent' => 'The radio accepted the send. No delivery acknowledgment has been recorded.',
  'delivered' => 'The app recorded a delivery acknowledgment. It does not prove the person read it.',
  'failed' => 'No confirmed delivery. Check radio connection, recipient reachability and retry history.',
  _ => 'Delivery state is unavailable. Do not assume this message arrived.',
};
