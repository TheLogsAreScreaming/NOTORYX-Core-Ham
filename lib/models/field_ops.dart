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
    'Activity overdue after: ${trip.overdueMinutes} minutes (this phone alerts when a contact goes quiet)',
    'Check-in reminder: ${trip.reminderMinutes == 0 ? 'Off' : 'every ${trip.reminderMinutes} minutes without a check-in'}',
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

  /// Channel index an SOS is also sent to, or -1 for trip contacts only.
  final int sosChannel;

  /// Minutes after the last check-in before a reminder notification, or 0.
  final int reminderMinutes;
  const TripPlan({
    this.name = 'My trip',
    this.members = const [],
    this.active = false,
    this.shareLocation = false,
    this.shareBattery = false,
    this.overdueMinutes = 60,
    this.sosChannel = -1,
    this.reminderMinutes = 0,
  });
  TripPlan copyWith({
    String? name,
    List<String>? members,
    bool? active,
    bool? shareLocation,
    bool? shareBattery,
    int? overdueMinutes,
    int? sosChannel,
    int? reminderMinutes,
  }) => TripPlan(
    name: name ?? this.name,
    members: members ?? this.members,
    active: active ?? this.active,
    shareLocation: shareLocation ?? this.shareLocation,
    shareBattery: shareBattery ?? this.shareBattery,
    overdueMinutes: overdueMinutes ?? this.overdueMinutes,
    sosChannel: sosChannel ?? this.sosChannel,
    reminderMinutes: reminderMinutes ?? this.reminderMinutes,
  );
  Map<String, dynamic> toJson() => {
    'name': name,
    'members': members,
    'active': active,
    'shareLocation': shareLocation,
    'shareBattery': shareBattery,
    'overdueMinutes': overdueMinutes,
    'sosChannel': sosChannel,
    'reminderMinutes': reminderMinutes,
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
    sosChannel: (j['sosChannel'] as num?)?.toInt() ?? -1,
    reminderMinutes: reminderChoices.contains(j['reminderMinutes'])
        ? j['reminderMinutes'] as int
        : 0,
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
  'sent' =>
    'The radio accepted the send. No delivery acknowledgment has been recorded.',
  'delivered' =>
    'The app recorded a delivery acknowledgment. It does not prove the person read it.',
  'failed' =>
    'No confirmed delivery. Check radio connection, recipient reachability and retry history.',
  _ => 'Delivery state is unavailable. Do not assume this message arrived.',
};

/// Time between SOS repeats; keeps an emergency from flooding the mesh.
const sosRepeatInterval = Duration(minutes: 5);

/// SOS transmissions per activation (the first plus repeats): one hour.
const sosMaxSends = 12;

/// The SOS message. Unlike a check-in it always carries the radio's
/// position when one is known, because that is what responders need.
String sosText(
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
  var text = '[Bastion SOS] Need help | $stamp UTC';
  if (usablePosition(latitude, longitude)) {
    text +=
        ' | Radio advert ${latitude!.toStringAsFixed(4)},${longitude!.toStringAsFixed(4)} (may be stale)';
  } else {
    text += ' | No position';
  }
  if (battery != null) text += ' | Battery $battery%';
  if (utf8.encode(text).length > 140) {
    throw ArgumentError('SOS exceeds the 140-byte field limit.');
  }
  return text;
}

/// Sent when an SOS is stopped and the sender chose to say they are safe.
String sosAllClearText(DateTime at) {
  final stamp = at
      .toUtc()
      .toIso8601String()
      .substring(0, 16)
      .replaceFirst('T', ' ');
  return '[Bastion SOS] All clear | $stamp UTC';
}

/// Why an SOS can't be sent right now, or null when it can.
String? sosUnavailableReason({
  required bool ready,
  required bool storageError,
  required bool connected,
  required int selectedContacts,
  required int availableContacts,
  required bool hasChannel,
}) {
  if (!ready) return 'Loading your trip…';
  if (storageError) return 'Resolve the Field Log storage error first.';
  if (!connected) return 'Connect your MeshCore radio to send an SOS.';
  if (availableContacts == 0 && !hasChannel) {
    return 'Choose trip contacts or an SOS channel in Plan trip.';
  }
  if (availableContacts != selectedContacts && !hasChannel) {
    return 'Some trip contacts are unavailable. Review your roster.';
  }
  return null;
}

/// The state of an SOS for this app session (never resumed after a restart).
class SosState {
  final bool active;
  final DateTime? startedAt;
  final DateTime? lastSentAt;
  final int sends;

  /// Name of the trip contact whose reply acknowledged the SOS.
  final String? acknowledgedBy;

  const SosState({
    this.active = false,
    this.startedAt,
    this.lastSentAt,
    this.sends = 0,
    this.acknowledgedBy,
  });

  static const idle = SosState();

  /// Whether another transmission is due at [now].
  bool dueAt(DateTime now) =>
      active &&
      acknowledgedBy == null &&
      sends < sosMaxSends &&
      (lastSentAt == null || now.difference(lastSentAt!) >= sosRepeatInterval);

  /// When the next repeat goes out, or null when none will.
  DateTime? get nextSendAt =>
      !active || acknowledgedBy != null || sends >= sosMaxSends
      ? null
      : lastSentAt?.add(sosRepeatInterval);

  SosState sent(DateTime at) => SosState(
    active: active,
    startedAt: startedAt,
    lastSentAt: at,
    sends: sends + 1,
    acknowledgedBy: acknowledgedBy,
  );

  SosState acknowledged(String by) => SosState(
    active: active,
    startedAt: startedAt,
    lastSentAt: lastSentAt,
    sends: sends,
    acknowledgedBy: by,
  );
}

/// Check-in reminder choices in minutes; 0 is off.
const reminderChoices = [0, 30, 60, 120, 240];

/// Trip contacts with no activity (message or advert) for [overdue]. Time
/// before the trip started doesn't count, so nobody is overdue at once.
List<String> overdueMembers({
  required List<String> members,
  required Map<String, DateTime> lastHeard,
  required DateTime tripStarted,
  required DateTime now,
  required Duration overdue,
}) => members.where((key) {
  final heard = lastHeard[key];
  final since = heard == null || heard.isBefore(tripStarted)
      ? tripStarted
      : heard;
  return now.difference(since) >= overdue;
}).toList();
