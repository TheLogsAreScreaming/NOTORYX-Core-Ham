import 'package:flutter/foundation.dart';

import 'contact.dart';
import 'message.dart';

/// Why a direct message did or didn't get through, in one of four kinds.
enum DeliveryVerdict {
  /// Confirmed received.
  delivered,

  /// Confirmed, but only by flood once the direct tries had failed.
  deliveredByFlood,

  /// Still being sent or waiting for confirmation.
  pending,

  /// The radio never accepted it (not connected, or it was rejected).
  notSent,

  /// Sent, no confirmation, and the contact hasn't been heard for a while.
  failedQuiet,

  /// Sent over the saved route only; flood attempts are turned off.
  failedNoFlood,

  /// Sent by every route allowed, and no confirmation came back.
  failedNoAck,
}

/// What was saved about a direct message's delivery, and a verdict.
@immutable
class DeliveryDiagnosis {
  const DeliveryDiagnosis({
    required this.verdict,
    required this.queuedAt,
    required this.attemptsMade,
    required this.directTries,
    required this.floodTries,
    required this.lastRouteFlood,
    required this.lastRouteHashes,
    this.sentAt,
    this.deliveredAt,
    this.tripTime,
    this.contactQuiet,
  });

  final DeliveryVerdict verdict;
  final DateTime queuedAt;

  /// When the radio accepted the first attempt; null if it never did.
  final DateTime? sentAt;
  final DateTime? deliveredAt;

  /// Round trip of the confirmation, when the radio reported it.
  final Duration? tripTime;

  /// Attempts made so far, counting the first send.
  final int attemptsMade;

  /// The plan: direct tries, then flood tries.
  final int directTries;
  final int floodTries;
  int get totalTries => directTries + floodTries;

  /// Whether the last attempt went out as a flood.
  final bool lastRouteFlood;

  /// The last direct route as hex hop hashes, nearest first; empty when the
  /// contact is a direct neighbour or the last attempt was a flood.
  final List<String> lastRouteHashes;

  /// How long since the contact was last heard, when it's been a while.
  final Duration? contactQuiet;
}

/// How long without hearing a contact before it's offered as the reason a
/// message failed.
const deliveryQuietThreshold = Duration(hours: 6);

/// Works out [message]'s delivery story from what's saved with it. Only for
/// outgoing direct messages. [maxRetries] and [floodAttempts] are the
/// current settings, which may have changed since it was sent.
DeliveryDiagnosis diagnoseDelivery(
  Message message, {
  required int maxRetries,
  required int floodAttempts,
  Contact? contact,
  DateTime? now,
}) {
  final at = now ?? DateTime.now();
  final sent = message.sentAt != null || message.retryCount > 0;
  final attempts = sent ? message.retryCount + 1 : 0;
  final lastFlood = (message.pathLength ?? 0) < 0;
  final hashes = <String>[];
  if (!lastFlood) {
    final bytes = message.pathBytes;
    final hops = message.pathLength ?? 0;
    final width = hops > 0 && bytes.length >= hops ? bytes.length ~/ hops : 1;
    for (
      var i = 0;
      i + width <= bytes.length && hashes.length < hops;
      i += width
    ) {
      hashes.add(
        bytes
            .sublist(i, i + width)
            .map((b) => b.toRadixString(16).padLeft(2, '0'))
            .join()
            .toUpperCase(),
      );
    }
  }

  Duration? quiet;
  final seen = contact?.lastSeen;
  if (seen != null && !seen.isAfter(at)) {
    final gap = at.difference(seen);
    if (gap >= deliveryQuietThreshold) quiet = gap;
  }

  final verdict = switch (message.status) {
    MessageStatus.delivered =>
      lastFlood && maxRetries > 0 && message.retryCount >= maxRetries
          ? DeliveryVerdict.deliveredByFlood
          : DeliveryVerdict.delivered,
    MessageStatus.pending || MessageStatus.sent => DeliveryVerdict.pending,
    MessageStatus.failed when !sent => DeliveryVerdict.notSent,
    MessageStatus.failed when quiet != null => DeliveryVerdict.failedQuiet,
    MessageStatus.failed when floodAttempts == 0 && !lastFlood =>
      DeliveryVerdict.failedNoFlood,
    MessageStatus.failed => DeliveryVerdict.failedNoAck,
  };

  final trip = message.tripTimeMs;
  return DeliveryDiagnosis(
    verdict: verdict,
    queuedAt: message.timestamp,
    sentAt: message.sentAt,
    deliveredAt: message.deliveredAt,
    tripTime: trip == null || trip <= 0 ? null : Duration(milliseconds: trip),
    attemptsMade: attempts,
    directTries: maxRetries,
    floodTries: floodAttempts,
    lastRouteFlood: lastFlood,
    lastRouteHashes: hashes,
    contactQuiet: quiet,
  );
}
