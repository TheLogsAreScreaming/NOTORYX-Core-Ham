import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../models/channel.dart';
import '../models/contact.dart';
import '../models/field_ops.dart';
import '../models/message.dart';
import 'notification_service.dart';

class FieldOpsService extends ChangeNotifier {
  final MeshCoreConnector connector;
  FieldOpsService(this.connector);
  static const _key = 'bastion_field_ops_v1';

  /// [error] values, which the app shows in the user's language.
  static const loadErrorText =
      'Field data could not be loaded. Saved data was retained; automations remain off.';
  static const saveErrorText =
      'Field data could not be saved. Automations stopped; existing stored data is retained.';
  TripPlan trip = const TripPlan();
  List<FieldRule> rules = [
    for (final t in FieldTrigger.values) FieldRule(id: t.name, trigger: t),
  ];
  final List<FieldEntry> _entries = [];
  List<FieldEntry> get entries => List.unmodifiable(_entries);
  bool ready = false,
      foreground = true,
      automationEnabled = false,
      busy = false;
  bool _disposed = false, _connected = false, _primed = false;
  String? error;
  final Set<String> _knownNodes = {};
  final Set<String> _received = {};
  final Set<String> _lowBattery = {};
  DateTime? _lastAutoSend;
  Timer? _timer;
  StreamSubscription<Message>? _messages;

  /// The SOS for this app session. It has its own timer so repeats continue
  /// while the app is in the background (as long as the OS keeps it running).
  SosState sos = SosState.idle;
  Timer? _sosTimer;
  bool _sosSending = false;

  /// Trip watch: when the trip started, when this phone last checked in, and
  /// when each trip contact was last heard (message or advert). The watch
  /// timer, like the SOS timer, keeps running in the background.
  DateTime? tripStartedAt, lastCheckInAt, reminderAt;
  final Map<String, DateTime> _lastHeard = {};
  final Map<String, DateTime> _lastSeen = {};
  final Set<String> _overdue = {};
  Timer? _watchTimer;

  /// Battery saver checks automations and overdue contacts less often. SOS
  /// repeats keep their own timing.
  bool batterySaver = false;
  Duration get tickInterval => Duration(seconds: batterySaver ? 60 : 15);
  Duration get watchInterval => Duration(seconds: batterySaver ? 120 : 30);

  void setBatterySaver(bool on) {
    if (on == batterySaver) return;
    batterySaver = on;
    if (_disposed || !ready) return;
    if (_timer != null && foreground) {
      _timer!.cancel();
      _timer = Timer.periodic(tickInterval, (_) => unawaited(tick()));
    }
    if (_watchTimer != null) {
      _watchTimer!.cancel();
      _watchTimer = Timer.periodic(
        watchInterval,
        (_) => unawaited(watchTick()),
      );
    }
    _notify();
  }

  /// Names of trip contacts currently overdue.
  List<String> get overdueNames => members
      .where((c) => _overdue.contains(c.publicKeyHex))
      .map((c) => c.name)
      .toList();
  Future<void> _writes = Future<void>.value();

  List<Contact> get members => connector.contacts
      .where((c) => trip.members.contains(c.publicKeyHex))
      .toList();
  List<Contact> get eligibleContacts => connector.contacts
      .where(
        (c) =>
            c.type == advTypeChat &&
            c.publicKeyHex != connector.selfPublicKeyHex,
      )
      .toList();

  /// The channel an SOS also goes to, if one is configured and still exists.
  Channel? get sosChannel {
    for (final channel in connector.channels) {
      if (channel.index == trip.sosChannel && !channel.isEmpty) return channel;
    }
    return null;
  }

  String? get sosUnavailable => sosUnavailableReason(
    ready: ready,
    storageError: error != null,
    connected: connector.isConnected,
    selectedContacts: trip.members.length,
    availableContacts: members.length,
    hasChannel: sosChannel != null,
  );

  /// Starts an SOS: sends now to the trip contacts and the SOS channel, then
  /// repeats every [sosRepeatInterval] until acknowledged, stopped, or
  /// [sosMaxSends] transmissions. Works without an active trip.
  Future<void> startSos() async {
    final reason = sosUnavailable;
    if (reason != null) throw StateError(reason);
    if (sos.active) return;
    sos = SosState(active: true, startedAt: DateTime.now());
    await record('sos', 'SOS started.');
    _sosTimer?.cancel();
    _sosTimer = Timer.periodic(
      const Duration(seconds: 15),
      (_) => unawaited(sosTick()),
    );
    await sosTick();
  }

  /// Stops the SOS. With [allClear] the recipients are told the sender is
  /// safe (one transmission, no repeats).
  Future<void> stopSos({bool allClear = false}) async {
    if (!sos.active) return;
    _sosTimer?.cancel();
    _sosTimer = null;
    sos = SosState.idle;
    await record(
      'sos',
      allClear ? 'SOS stopped; all clear sent.' : 'SOS stopped.',
    );
    if (allClear && connector.isConnected) {
      await _sendSosText(sosAllClearText(DateTime.now()), 'All clear');
    }
    _notify();
  }

  /// Sends the SOS when one is due. Called by the SOS timer.
  @visibleForTesting
  Future<void> sosTick() async {
    if (_disposed || !sos.active || _sosSending) return;
    final now = DateTime.now();
    // A disconnected radio retries on the next tick instead of using a send.
    if (!sos.dueAt(now) || !connector.isConnected) return;
    _sosSending = true;
    sos = sos.sent(now);
    _notify();
    try {
      final text = sosText(
        now,
        latitude: connector.selfLatitude,
        longitude: connector.selfLongitude,
        battery: connector.batteryPercent,
      );
      await _sendSosText(text, 'SOS ${sos.sends}/$sosMaxSends');
      if (sos.active && sos.sends >= sosMaxSends) {
        await record(
          'sos',
          'SOS repeats finished after $sosMaxSends sends. The SOS stays shown until you stop it.',
        );
      }
    } finally {
      _sosSending = false;
      _notify();
    }
  }

  Future<void> _sendSosText(String text, String label) async {
    for (final contact in members.where((c) => c.type == advTypeChat)) {
      final before = connector
          .getMessages(contact)
          .map((m) => m.messageId)
          .toSet();
      try {
        await connector.sendMessage(contact, text);
        final added = connector
            .getMessages(contact)
            .where((m) => m.isOutgoing && !before.contains(m.messageId))
            .toList();
        await record(
          'sos',
          '${contact.name}: $label',
          contactKey: contact.publicKeyHex,
          messageId: added.isEmpty ? null : added.last.messageId,
          status: added.isEmpty ? 'failed' : added.last.status.name,
        );
      } catch (e) {
        await record(
          'sos',
          '${contact.name}: $label could not be sent: $e',
          contactKey: contact.publicKeyHex,
          status: 'failed',
        );
      }
    }
    final channel = sosChannel;
    if (channel == null) return;
    try {
      await connector.sendChannelMessage(channel, text);
      await record('sos', '${channel.name}: $label sent to channel');
    } catch (e) {
      await record('sos', '${channel.name}: $label could not be sent: $e');
    }
  }

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_key);
      if (raw != null) {
        final j = jsonDecode(raw) as Map<String, dynamic>;
        trip = TripPlan.fromJson(Map<String, dynamic>.from(j['trip'] as Map));
        rules = (j['rules'] as List)
            .map((r) => FieldRule.fromJson(Map<String, dynamic>.from(r as Map)))
            .toList();
        for (final t in FieldTrigger.values) {
          if (!rules.any((r) => r.trigger == t)) {
            rules.add(FieldRule(id: t.name, trigger: t));
          }
        }
        for (final row in (j['entries'] as List? ?? []).take(1000)) {
          _entries.add(
            FieldEntry.fromJson(Map<String, dynamic>.from(row as Map)),
          );
        }
        _lastAutoSend = DateTime.tryParse(j['lastAutoSend'] as String? ?? '');
      }
    } catch (_) {
      error = loadErrorText;
    }
    if (_disposed) return;
    // Trips never resume after a restart, so neither does their reminder.
    unawaited(NotificationService().cancelCheckInReminder());
    ready = true;
    _connected = connector.isConnected;
    _primeNodes();
    connector.addListener(_changed);
    _messages = connector.receivedDirectMessages.listen(_incoming);
    _timer = Timer.periodic(tickInterval, (_) => unawaited(tick()));
    _notify();
  }

  void _primeNodes() {
    _knownNodes.addAll(connector.contacts.map((c) => c.publicKeyHex));
    _primed = connector.isConnected && !connector.isLoadingContacts;
  }

  Future<bool> _save() async {
    if (_disposed || !ready || error != null) return false;
    final payload = jsonEncode({
      'trip': trip.toJson(),
      'rules': rules.map((r) => r.toJson()).toList(),
      'entries': _entries.map((e) => e.toJson()).toList(),
      'lastAutoSend': _lastAutoSend?.toIso8601String(),
    });
    final write = _writes.then((_) async {
      final prefs = await SharedPreferences.getInstance();
      if (!await prefs.setString(_key, payload)) {
        throw StateError('Storage rejected write');
      }
    });
    _writes = write.catchError((Object _) {});
    try {
      await write;
      return true;
    } catch (_) {
      error = saveErrorText;
      automationEnabled = false;
      _notify();
      return false;
    }
  }

  Future<void> configureTrip(TripPlan value) async {
    if (!ready || busy || error != null) return;
    trip = value.copyWith(members: value.members.toSet().take(6).toList());
    await _save();
    if (trip.active) await _scheduleReminder();
    _notify();
  }

  Future<void> startTrip() async {
    if (trip.members.isEmpty || !connector.isConnected) {
      throw StateError('Connect a radio and choose trip contacts first.');
    }
    trip = trip.copyWith(active: true);
    tripStartedAt = DateTime.now();
    lastCheckInAt = null;
    _lastHeard.clear();
    _overdue.clear();
    _snapshotSeen();
    _watchTimer?.cancel();
    _watchTimer = Timer.periodic(watchInterval, (_) => unawaited(watchTick()));
    await record('trip', 'Started ${trip.name}');
    await _scheduleReminder();
    _notify();
  }

  Future<void> endTrip() async {
    trip = trip.copyWith(active: false);
    automationEnabled = false;
    _watchTimer?.cancel();
    _watchTimer = null;
    _overdue.clear();
    reminderAt = null;
    unawaited(NotificationService().cancelCheckInReminder());
    await record('trip', 'Ended ${trip.name}');
    _notify();
  }

  /// Schedules (or clears) the OS reminder for the next check-in.
  Future<void> _scheduleReminder() async {
    final minutes = trip.reminderMinutes;
    if (!trip.active || minutes == 0) {
      reminderAt = null;
      await NotificationService().cancelCheckInReminder();
      return;
    }
    final from = lastCheckInAt ?? tripStartedAt ?? DateTime.now();
    reminderAt = from.add(Duration(minutes: minutes));
    final notifications = NotificationService();
    final ok = await notifications.scheduleCheckInReminder(
      reminderAt!,
      notifications.l10n.notification_checkInReminderBody(minutes, trip.name),
    );
    if (!ok) {
      await record(
        'missed',
        'Check-in reminder could not be scheduled. Check notification permission.',
      );
    }
  }

  void _snapshotSeen() {
    for (final c in members) {
      _lastSeen[c.publicKeyHex] = c.lastSeen;
    }
  }

  void _heard(String key, DateTime at) {
    _lastHeard[key] = at;
    if (_overdue.remove(key)) {
      final name = members
          .where((c) => c.publicKeyHex == key)
          .map((c) => c.name)
          .firstOrNull;
      unawaited(
        record('overdue', '${name ?? 'A trip contact'} heard from again.'),
      );
      _notify();
    }
  }

  /// Checks trip contacts for overdue silence. Called by the watch timer.
  @visibleForTesting
  Future<void> watchTick([DateTime? at]) async {
    if (_disposed || !trip.active || tripStartedAt == null) return;
    final now = at ?? DateTime.now();
    final late = overdueMembers(
      members: trip.members,
      lastHeard: _lastHeard,
      tripStarted: tripStartedAt!,
      now: now,
      overdue: Duration(minutes: trip.overdueMinutes),
    ).where((k) => !_overdue.contains(k)).toList();
    if (late.isEmpty) return;
    for (final key in late) {
      _overdue.add(key);
      final name = members
          .where((c) => c.publicKeyHex == key)
          .map((c) => c.name)
          .firstOrNull;
      final text =
          '${name ?? 'A trip contact'} not heard from in ${trip.overdueMinutes} minutes. This is not a confirmed emergency.';
      await record('overdue', text, contactKey: key);
      final notifications = NotificationService();
      final t = notifications.l10n;
      final shown = await notifications.showFieldAlert(
        t.notification_overdueBody(
          name ?? t.notification_aTripContact,
          trip.overdueMinutes,
        ),
      );
      if (!shown) {
        await record(
          'missed',
          'Overdue alert could not be shown. Check notification permission.',
        );
      }
    }
    _notify();
  }

  Future<void> record(
    String kind,
    String text, {
    String? contactKey,
    String? messageId,
    String? status,
    double? latitude,
    double? longitude,
    String? batch,
  }) async {
    if (!ready || _disposed || error != null) return;
    final now = DateTime.now();
    _entries.insert(
      0,
      FieldEntry(
        id: '${now.microsecondsSinceEpoch}_${_entries.length}',
        at: now,
        kind: kind,
        text: text,
        contactKey: contactKey,
        messageId: messageId,
        status: status,
        tripName: trip.name,
        latitude: latitude,
        longitude: longitude,
        batch: batch,
      ),
    );
    if (_entries.length > 1000) _entries.removeRange(1000, _entries.length);
    _notify();
    await _save();
  }

  Future<void> clearLog() async {
    _entries.clear();
    await _save();
    _notify();
  }

  String exportLog() => const JsonEncoder.withIndent('  ').convert({
    'schema': 1,
    'trip': trip.toJson(),
    'note':
        'Radio advertised positions may be stale. Queued and sent messages do not prove delivery.',
    'entries': _entries.map((e) => e.toJson()).toList(),
  });

  String previewCheckIn(String label) => checkInText(
    label,
    DateTime.now(),
    latitude: trip.shareLocation ? connector.selfLatitude : null,
    longitude: trip.shareLocation ? connector.selfLongitude : null,
    battery: trip.shareBattery ? connector.batteryPercent : null,
  );

  /// Where the newest check-in stands with each trip contact.
  CheckInDelivery? get latestDelivery => CheckInDelivery.latest(_entries);
  String? _announcedBatch;

  /// Sends the newest check-in again, unchanged, to the contacts it did not
  /// reach. The results join that check-in's delivery.
  Future<void> resendCheckIn() async {
    final delivery = latestDelivery;
    if (delivery == null || delivery.failedKeys.isEmpty) return;
    await sendCheckIn(
      delivery.text,
      only: delivery.failedKeys,
      batch: delivery.batch,
    );
  }

  Future<void> sendCheckIn(
    String text, {
    bool automatic = false,
    List<String>? only,
    String? batch,
  }) async {
    if (!ready ||
        error != null ||
        busy ||
        !trip.active ||
        !foreground ||
        !connector.isConnected) {
      throw StateError(
        'An active trip, running app and radio connection are required.',
      );
    }
    if (utf8.encode(text).length > 140 ||
        !text.startsWith('[Bastion Check-in] ')) {
      throw ArgumentError('Invalid field check-in.');
    }
    final targets = members
        .where(
          (c) =>
              c.type == advTypeChat &&
              (only == null || only.contains(c.publicKeyHex)),
        )
        .toList();
    if (targets.isEmpty ||
        targets.length != (only?.length ?? trip.members.length)) {
      throw StateError(
        'Some selected contacts are unavailable. Review the trip roster.',
      );
    }
    final now = DateTime.now();
    final batchId = batch ?? '${now.microsecondsSinceEpoch}';
    if (automatic &&
        _lastAutoSend != null &&
        now.difference(_lastAutoSend!) < const Duration(minutes: 10)) {
      await record(
        'automation',
        'Automatic check-in suppressed by the 10-minute transmission limit.',
      );
      return;
    }
    busy = true;
    _notify();
    try {
      // Reserve the automation budget before invoking any radio sends.
      if (automatic) {
        _lastAutoSend = now;
        if (!await _save()) {
          throw StateError('Could not reserve transmission budget.');
        }
      }
      for (final contact in targets) {
        if (!trip.active ||
            !foreground ||
            !connector.isConnected ||
            error != null ||
            (automatic && !automationEnabled)) {
          await record(
            'check-in',
            'Stopped before remaining recipients; connection or trip state changed.',
          );
          break;
        }
        final before = connector
            .getMessages(contact)
            .map((m) => m.messageId)
            .toSet();
        try {
          await connector.sendMessage(contact, text);
          final added = connector
              .getMessages(contact)
              .where(
                (m) =>
                    m.isOutgoing &&
                    m.text == text &&
                    !before.contains(m.messageId),
              )
              .toList();
          if (added.isEmpty) {
            await record(
              'check-in',
              '${contact.name}: no queued message was recorded.',
              contactKey: contact.publicKeyHex,
              status: 'failed',
              batch: batchId,
            );
            continue;
          }
          final message = added.last;
          lastCheckInAt = now;
          await record(
            'check-in',
            '${contact.name}: $text',
            contactKey: contact.publicKeyHex,
            messageId: message.messageId,
            status: message.status.name,
            batch: batchId,
          );
        } catch (e) {
          await record(
            'check-in',
            '${contact.name}: send could not be confirmed: $e',
            contactKey: contact.publicKeyHex,
            status: 'failed',
            batch: batchId,
          );
        }
      }
    } finally {
      busy = false;
      if (lastCheckInAt == now) await _scheduleReminder();
      _notify();
    }
  }

  void _incoming(Message message) {
    // A reply from a trip contact acknowledges an SOS, trip or no trip.
    if (sos.active &&
        sos.acknowledgedBy == null &&
        trip.members.contains(message.senderKeyHex)) {
      final name = members
          .where((c) => c.publicKeyHex == message.senderKeyHex)
          .map((c) => c.name)
          .firstOrNull;
      sos = sos.acknowledged(name ?? 'a trip contact');
      unawaited(
        record(
          'sos',
          'SOS acknowledged by ${sos.acknowledgedBy}: ${message.text}',
          contactKey: message.senderKeyHex,
        ),
      );
      final notifications = NotificationService();
      unawaited(
        notifications.showFieldAlert(
          notifications.l10n.notification_sosAcknowledged(sos.acknowledgedBy!),
        ),
      );
      _notify();
    }
    if (trip.active && trip.members.contains(message.senderKeyHex)) {
      _heard(message.senderKeyHex, DateTime.now());
    }
    if (!trip.active ||
        !foreground ||
        !trip.members.contains(message.senderKeyHex) ||
        !_received.add(message.messageId)) {
      return;
    }
    if (_received.length > 2000) _received.remove(_received.first);
    unawaited(
      record('received', message.text, contactKey: message.senderKeyHex),
    );
  }

  void _changed() {
    if (_disposed || !ready) return;
    if (trip.active) {
      // A new advert from a trip contact counts as activity.
      for (final c in members) {
        final seen = _lastSeen[c.publicKeyHex];
        if (seen != null && c.lastSeen != seen) {
          _heard(c.publicKeyHex, DateTime.now());
        }
        _lastSeen[c.publicKeyHex] = c.lastSeen;
      }
    }
    final connected = connector.isConnected;
    if (connected != _connected) {
      _connected = connected;
      _primed = false;
      _knownNodes.clear();
      if (trip.active) {
        unawaited(
          record(
            'radio',
            connected ? 'Radio reconnected.' : 'Radio disconnected.',
          ),
        );
      }
      unawaited(
        _event(connected ? FieldTrigger.reconnect : FieldTrigger.disconnect),
      );
    }
    if (connected && !connector.isLoadingContacts) {
      if (!_primed) {
        _primeNodes();
      } else {
        for (final contact in connector.contacts) {
          if (_knownNodes.add(contact.publicKeyHex)) {
            unawaited(
              _event(
                contact.type == advTypeRepeater
                    ? FieldTrigger.repeater
                    : FieldTrigger.newNode,
                detail: contact.name,
              ),
            );
          }
        }
      }
    }
    final battery = connector.batteryPercent;
    if (battery != null && connected) {
      for (final rule in rules.where(
        (r) => r.trigger == FieldTrigger.lowBattery,
      )) {
        if (battery <= rule.batteryThreshold && _lowBattery.add(rule.id)) {
          unawaited(
            _event(FieldTrigger.lowBattery, detail: 'Radio battery $battery%'),
          );
        } else if (battery > rule.batteryThreshold + 5) {
          _lowBattery.remove(rule.id);
        }
      }
    }
    var changed = false;
    final failedTo = <String>[];
    for (var i = 0; i < _entries.length; i++) {
      final entry = _entries[i];
      if (entry.messageId == null || entry.contactKey == null) continue;
      for (final contact in members.where(
        (c) => c.publicKeyHex == entry.contactKey,
      )) {
        for (final message
            in connector
                .getMessages(contact)
                .where((m) => m.messageId == entry.messageId)) {
          if (message.status.name != entry.status) {
            _entries[i] = entry.withStatus(message.status.name);
            changed = true;
            if (entry.kind == 'check-in' &&
                entry.batch != null &&
                message.status == MessageStatus.failed) {
              failedTo.add(contact.name);
            }
          }
        }
      }
    }
    if (changed) {
      unawaited(_save());
      _deliveryChanged(failedTo);
    }
    _notify();
  }

  void _deliveryChanged(List<String> failedTo) {
    for (final name in failedTo) {
      final text =
          'Check-in not delivered to $name. You can resend it from Trip.';
      unawaited(record('check-in', text));
      final notifications = NotificationService();
      unawaited(
        notifications.showFieldAlert(
          notifications.l10n.notification_checkInNotDelivered(name),
        ),
      );
    }
    final delivery = latestDelivery;
    if (delivery != null &&
        delivery.total > 0 &&
        delivery.delivered == delivery.total &&
        _announcedBatch != delivery.batch) {
      _announcedBatch = delivery.batch;
      unawaited(record('check-in', '${delivery.headline}.'));
    }
  }

  Future<void> configureRule(FieldRule value) async {
    final i = rules.indexWhere((r) => r.id == value.id);
    if (i < 0) return;
    rules[i] = value.copyWith(
      nextDue: DateTime.now().add(Duration(minutes: value.intervalMinutes)),
    );
    _lowBattery.remove(value.id);
    await _save();
    _notify();
  }

  Future<void> enableAutomations(bool enabled) async {
    if (enabled && (!ready || error != null || !trip.active)) {
      throw StateError('Start a trip before enabling automations.');
    }
    automationEnabled = enabled;
    await record(
      'automation',
      enabled
          ? 'Automations enabled for this app session.'
          : 'Automations disabled.',
    );
    _notify();
  }

  void setForeground(bool value) {
    foreground = value;
    if (!value) {
      _timer?.cancel();
    } else if (!_disposed) {
      _timer?.cancel();
      _timer = Timer.periodic(tickInterval, (_) => unawaited(tick()));
      unawaited(tick());
    }
    _notify();
  }

  Future<void> tick() async {
    if (!ready || !foreground || _disposed || error != null) return;
    final now = DateTime.now();
    for (final rule in List<FieldRule>.from(
      rules,
    ).where((r) => r.enabled && r.trigger == FieldTrigger.scheduled)) {
      final state = scheduleState(rule, now);
      if (state == ScheduleState.waiting) continue;
      final i = rules.indexWhere((r) => r.id == rule.id);
      rules[i] = rule.copyWith(
        nextDue: now.add(Duration(minutes: rule.intervalMinutes)),
      );
      if (!await _save()) return;
      if (state == ScheduleState.missed || !automationEnabled || !trip.active) {
        await record(
          'missed',
          'Scheduled check-in was missed or disabled. No catch-up transmission was sent.',
        );
      } else {
        await _run(rule, 'Scheduled check-in');
      }
    }
    _notify();
  }

  Future<void> _event(FieldTrigger trigger, {String detail = ''}) async {
    if (!automationEnabled ||
        !trip.active ||
        !foreground ||
        !ready ||
        error != null) {
      return;
    }
    for (final rule in List<FieldRule>.from(
      rules,
    ).where((r) => r.enabled && r.trigger == trigger)) {
      await _run(rule, '${trigger.name}${detail.isEmpty ? '' : ': $detail'}');
    }
  }

  Future<void> _run(FieldRule rule, String detail) async {
    final now = DateTime.now();
    if (!ruleCooldownPassed(rule, now)) return;
    final i = rules.indexWhere((r) => r.id == rule.id);
    rules[i] = rule.copyWith(lastRun: now);
    if (!await _save()) return;
    await record(
      'automation',
      '${rule.dryRun ? 'DRY RUN: ' : ''}$detail → ${rule.action.name}',
    );
    if (rule.dryRun || !automationEnabled || !foreground || !trip.active) {
      return;
    }
    if (rule.action == FieldAction.notify) {
      final shown = await NotificationService().showFieldAlert(detail);
      if (!shown) {
        await record(
          'missed',
          'Notification could not be shown. Check notification permission.',
        );
      }
    }
    if (rule.action == FieldAction.checkIn) {
      try {
        await sendCheckIn(previewCheckIn("I'm OK"), automatic: true);
      } catch (e) {
        await record('missed', 'Automatic check-in not sent: $e');
      }
    }
  }

  Future<void> previewRule(FieldRule rule) => record(
    'preview',
    'WHEN ${rule.trigger.name} THEN ${rule.action.name}; dry run ${rule.dryRun ? 'on' : 'off'}. No radio send.',
  );

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _timer?.cancel();
    _sosTimer?.cancel();
    _watchTimer?.cancel();
    _messages?.cancel();
    connector.removeListener(_changed);
    super.dispose();
  }
}
