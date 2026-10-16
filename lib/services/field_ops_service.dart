import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../models/contact.dart';
import '../models/field_ops.dart';
import '../models/message.dart';
import 'notification_service.dart';

class FieldOpsService extends ChangeNotifier {
  final MeshCoreConnector connector;
  FieldOpsService(this.connector);
  static const _key = 'bastion_field_ops_v1';
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
      error =
          'Field data could not be loaded. Saved data was retained; automations remain off.';
    }
    if (_disposed) return;
    ready = true;
    _connected = connector.isConnected;
    _primeNodes();
    connector.addListener(_changed);
    _messages = connector.receivedDirectMessages.listen(_incoming);
    _timer = Timer.periodic(
      const Duration(seconds: 15),
      (_) => unawaited(tick()),
    );
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
      error =
          'Field data could not be saved. Automations stopped; existing stored data is retained.';
      automationEnabled = false;
      _notify();
      return false;
    }
  }

  Future<void> configureTrip(TripPlan value) async {
    if (!ready || busy || error != null) return;
    trip = value.copyWith(members: value.members.toSet().take(6).toList());
    await _save();
    _notify();
  }

  Future<void> startTrip() async {
    if (trip.members.isEmpty || !connector.isConnected) {
      throw StateError('Connect a radio and choose trip contacts first.');
    }
    trip = trip.copyWith(active: true);
    await record('trip', 'Started ${trip.name}');
    _notify();
  }

  Future<void> endTrip() async {
    trip = trip.copyWith(active: false);
    automationEnabled = false;
    await record('trip', 'Ended ${trip.name}');
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

  Future<void> sendCheckIn(String text, {bool automatic = false}) async {
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
    final targets = members.where((c) => c.type == advTypeChat).toList();
    if (targets.isEmpty || targets.length != trip.members.length) {
      throw StateError(
        'Some selected contacts are unavailable. Review the trip roster.',
      );
    }
    final now = DateTime.now();
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
            );
            continue;
          }
          final message = added.last;
          await record(
            'check-in',
            '${contact.name}: $text',
            contactKey: contact.publicKeyHex,
            messageId: message.messageId,
            status: message.status.name,
          );
        } catch (e) {
          await record(
            'check-in',
            '${contact.name}: send could not be confirmed: $e',
            contactKey: contact.publicKeyHex,
            status: 'failed',
          );
        }
      }
    } finally {
      busy = false;
      _notify();
    }
  }

  void _incoming(Message message) {
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
          }
        }
      }
    }
    if (changed) unawaited(_save());
    _notify();
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
      _timer = Timer.periodic(
        const Duration(seconds: 15),
        (_) => unawaited(tick()),
      );
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
    _messages?.cancel();
    connector.removeListener(_changed);
    super.dispose();
  }
}
