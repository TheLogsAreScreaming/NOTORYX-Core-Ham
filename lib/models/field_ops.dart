import 'dart:convert';
import 'dart:ui' show Locale;

import '../l10n/app_localizations.dart';

/// English strings, for text that isn't shown in the app's language (the
/// Field Log) and for callers without a BuildContext.
final AppLocalizations _en = lookupAppLocalizations(const Locale('en'));

enum FieldTrigger {
  reconnect,
  disconnect,
  lowBattery,
  newNode,
  repeater,
  scheduled,
}

enum FieldAction { log, notify, checkIn }

/// Check-in statuses as the radio sends them. Never translated: recipients
/// see these words, whatever language the sender's app uses.
/// Tag that opens every check-in this app sends.
const checkInTag = '[NOTORYX Check-in]';

/// Tag that opens every SOS and all-clear this app sends.
const sosTag = '[NOTORYX SOS]';

/// Tags sent by releases from before the NOTORYX rename. People on those
/// versions still send them, so incoming text is matched against both.
const legacyCheckInTag = '[Bastion Check-in]';
const legacySosTag = '[Bastion SOS]';

/// Whether [text] is a check-in from this app or an older Bastion release.
bool isCheckInText(String text) {
  final t = text.trimLeft();
  return t.startsWith(checkInTag) || t.startsWith(legacyCheckInTag);
}

/// Whether [text] is an SOS or all-clear from this app or an older Bastion
/// release.
bool isSosText(String text) {
  final t = text.trimLeft();
  return t.startsWith(sosTag) || t.startsWith(legacySosTag);
}

const checkInLabels = ["I'm OK", 'At Camp', 'Delayed', 'Heading Back'];

/// A local summary: never includes message history, public keys or coordinates.
String tripBrief(
  TripPlan trip,
  Map<String, String> contactNames, {
  AppLocalizations? l10n,
}) {
  final t = l10n ?? _en;
  final roster = trip.members.map(
    (key) => contactNames[key] ?? t.tripBrief_unavailableContact,
  );
  return [
    t.tripBrief_heading,
    t.bastion_tagline,
    '',
    t.tripBrief_trip(trip.name),
    t.tripBrief_status(trip.active ? t.tripBrief_active : t.tripBrief_stopped),
    t.tripBrief_contacts(
      roster.isEmpty ? t.tripBrief_noneSelected : roster.join(', '),
    ),
    t.tripBrief_overdueAfter(trip.overdueMinutes),
    t.tripBrief_reminder(
      trip.reminderMinutes == 0
          ? t.tripBrief_off
          : t.tripBrief_reminderEvery(trip.reminderMinutes),
    ),
    t.tripBrief_choices(checkInLabels.join(' • ')),
    t.tripBrief_position(
      trip.shareLocation ? t.tripBrief_includedMayBeStale : t.tripBrief_off,
    ),
    t.tripBrief_battery(
      trip.shareBattery ? t.tripBrief_included : t.tripBrief_off,
    ),
    '',
    t.tripBrief_review,
    t.tripBrief_noProof,
    t.tripBrief_overdueMeaning,
    t.tripBrief_automations,
    t.tripBrief_sharesOnly,
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
  AppLocalizations? l10n,
}) {
  final t = l10n ?? _en;
  if (!ready) return t.checkIn_blockLoading;
  if (storageError) return t.checkIn_blockStorage;
  if (busy) return t.checkIn_blockBusy;
  if (selectedContacts == 0) return t.checkIn_blockNoContacts;
  if (availableContacts != selectedContacts) {
    return t.checkIn_blockRosterIncomplete;
  }
  if (!connected) return t.checkIn_blockNotConnected;
  if (!active) return t.checkIn_blockNotActive;
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

  /// Channel index check-ins are also posted to, signed, or -1 for trip
  /// contacts only.
  final int checkInChannel;

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
    this.checkInChannel = -1,
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
    int? checkInChannel,
    int? reminderMinutes,
  }) => TripPlan(
    name: name ?? this.name,
    members: members ?? this.members,
    active: active ?? this.active,
    shareLocation: shareLocation ?? this.shareLocation,
    shareBattery: shareBattery ?? this.shareBattery,
    overdueMinutes: overdueMinutes ?? this.overdueMinutes,
    sosChannel: sosChannel ?? this.sosChannel,
    checkInChannel: checkInChannel ?? this.checkInChannel,
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
    'checkInChannel': checkInChannel,
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
    checkInChannel: (j['checkInChannel'] as num?)?.toInt() ?? -1,
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

  /// Groups the per-contact entries of one check-in send.
  final String? batch;
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
    this.batch,
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
    batch: batch,
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
    if (batch != null) 'batch': batch,
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
    batch: j['batch'] as String?,
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
  var text = '$checkInTag $label | $stamp UTC';
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

String explainMessageStatus(String status, {AppLocalizations? l10n}) {
  final t = l10n ?? _en;
  return switch (status) {
    'pending' => t.checkIn_explainPending,
    'sent' => t.checkIn_explainSent,
    'delivered' => t.checkIn_explainDelivered,
    'failed' => t.checkIn_explainFailed,
    _ => t.checkIn_explainUnknown,
  };
}

/// A short name for a message status, or [status] itself if unknown.
String messageStatusLabel(String status, {AppLocalizations? l10n}) {
  final t = l10n ?? _en;
  return switch (status) {
    'pending' => t.checkIn_statusPending,
    'sent' => t.checkIn_statusSent,
    'delivered' => t.checkIn_statusDelivered,
    'failed' => t.checkIn_statusFailed,
    _ => status,
  };
}

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
  var text = '$sosTag Need help | $stamp UTC';
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
  return '$sosTag All clear | $stamp UTC';
}

/// Why an SOS can't be sent right now, or null when it can.
String? sosUnavailableReason({
  required bool ready,
  required bool storageError,
  required bool connected,
  required int selectedContacts,
  required int availableContacts,
  required bool hasChannel,
  AppLocalizations? l10n,
}) {
  final t = l10n ?? _en;
  if (!ready) return t.checkIn_blockLoading;
  if (storageError) return t.sos_blockStorage;
  if (!connected) return t.sos_blockNotConnected;
  if (availableContacts == 0 && !hasChannel) return t.sos_blockNoTarget;
  if (availableContacts != selectedContacts && !hasChannel) {
    return t.checkIn_blockRosterIncomplete;
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

/// Where one check-in stands, per trip contact.
class CheckInDelivery {
  final String batch;
  final DateTime at;

  /// The check-in message, without the recipient prefix.
  final String text;

  /// Latest status per contact key (a resend replaces the earlier one).
  final Map<String, String> statuses;

  /// Contact names by key, as logged.
  final Map<String, String> names;

  const CheckInDelivery({
    required this.batch,
    required this.at,
    required this.text,
    required this.statuses,
    required this.names,
  });

  int get total => statuses.length;
  int get delivered => statuses.values.where((s) => s == 'delivered').length;
  List<String> get failedKeys => [
    for (final e in statuses.entries)
      if (e.value == 'failed') e.key,
  ];
  bool get waiting => statuses.values.any((s) => s == 'pending' || s == 'sent');

  /// The summary in English, as the Field Log records it.
  String get headline => headlineIn(_en);

  String headlineIn(AppLocalizations t) {
    if (total == 0) return t.checkIn_notSent;
    if (delivered == total) {
      return total == 1
          ? t.checkIn_deliveredToOne(names.values.first)
          : t.checkIn_deliveredToAll(total);
    }
    final failed = failedKeys
        .map((k) => names[k] ?? t.checkIn_aContact)
        .toList();
    final parts = [t.checkIn_deliveredSome('$delivered', '$total')];
    if (failed.isNotEmpty) {
      parts.add(t.checkIn_notDeliveredTo(failed.join(', ')));
    }
    if (waiting) parts.add(t.checkIn_waitingForRest);
    return parts.join(' • ');
  }

  /// Builds the delivery for the newest check-in batch in [entries] (newest
  /// first, as the Field Log keeps them), or null if there is none.
  static CheckInDelivery? latest(List<FieldEntry> entries) {
    final first = entries
        .where((e) => e.kind == 'check-in' && e.batch != null)
        .firstOrNull;
    if (first == null) return null;
    final batch = entries.where(
      (e) => e.batch == first.batch && e.contactKey != null,
    );
    final statuses = <String, String>{};
    final names = <String, String>{};
    String? text;
    DateTime at = first.at;
    // Oldest first, so a resend's status replaces the original's.
    for (final e in batch.toList().reversed) {
      statuses[e.contactKey!] = e.status ?? 'failed';
      final split = e.text.indexOf(': ');
      if (split > 0) {
        names[e.contactKey!] = e.text.substring(0, split);
        if (e.text.contains('$checkInTag ') ||
            e.text.contains('$legacyCheckInTag ')) {
          text ??= e.text.substring(split + 2);
        }
      }
      if (e.at.isBefore(at)) at = e.at;
    }
    return CheckInDelivery(
      batch: first.batch!,
      at: at,
      text: text ?? '',
      statuses: statuses,
      names: names,
    );
  }
}
