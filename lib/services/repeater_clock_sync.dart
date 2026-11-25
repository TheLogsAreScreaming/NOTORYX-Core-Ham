import 'dart:async';

import 'package:flutter/foundation.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../models/contact.dart';
import 'repeater_command_service.dart';

/// What happened when the phone's time was sent to a repeater.
enum RepeaterClockSyncResult {
  /// The repeater took the phone's time.
  set,

  /// The repeater's clock is ahead of the phone's; firmware never moves a
  /// clock backwards.
  ahead,

  /// No answer after every retry, or an answer we don't understand.
  failed,
}

/// Keeps repeater clocks right. A repeater with a wrong clock stamps its
/// adverts with the wrong time, so it looks long gone ("898 days ago") and
/// its logs and stats are off.
class RepeaterClockSync {
  /// Within this, a repeater's clock is close enough; no airtime is spent.
  static const closeEnough = Duration(minutes: 1);

  /// Beyond this, a repeater whose automatic sync is off gets a notice.
  static const worthANotice = Duration(minutes: 5);

  /// How far the repeater's clock (as it reported at login) is from the
  /// phone's: positive when behind, negative when ahead. Null when unknown.
  static Duration? behindBy(DateTime? repeaterClock, DateTime now) {
    if (repeaterClock == null) return null;
    return now.difference(repeaterClock);
  }

  /// Whether to send the phone's time right after login.
  static bool shouldSync({required bool enabled, required Duration? behind}) {
    if (!enabled) return false;
    // Unknown clock: sync anyway, it costs one short command.
    if (behind == null) return true;
    return behind.abs() > closeEnough;
  }

  /// Whether to tell the user about a wrong clock they chose not to sync.
  static bool shouldNotify({required bool enabled, required Duration? behind}) {
    if (enabled || behind == null) return false;
    return behind.abs() > worthANotice;
  }

  /// Reads the repeater's answer to a `time <epoch>` command.
  @visibleForTesting
  static RepeaterClockSyncResult resultOf(String? reply) {
    if (reply == null) return RepeaterClockSyncResult.failed;
    final text = reply.toLowerCase();
    if (text.contains('backwards')) return RepeaterClockSyncResult.ahead;
    if (text.contains('ok')) return RepeaterClockSyncResult.set;
    return RepeaterClockSyncResult.failed;
  }

  /// Sends the phone's time to [repeater] (as `time <epoch>`, see
  /// [normalizeRepeaterClockSyncCommand]), retrying until it answers.
  static Future<RepeaterClockSyncResult> sync(
    MeshCoreConnector connector,
    Contact repeater, {
    int retries = 3,
  }) async {
    final service = RepeaterCommandService(connector);
    final sub = connector.receivedFrames.listen((frame) {
      final parsed = parseContactMessageText(frame);
      if (parsed == null) return;
      if (!listEquals(parsed.senderPrefix, repeater.publicKey.sublist(0, 6))) {
        return;
      }
      service.handleResponse(repeater, parsed.text);
    });
    try {
      final reply = await service.sendCommand(
        repeater,
        'clock sync',
        retries: retries,
      );
      return resultOf(reply);
    } catch (_) {
      return RepeaterClockSyncResult.failed;
    } finally {
      await sub.cancel();
      service.dispose();
    }
  }
}
