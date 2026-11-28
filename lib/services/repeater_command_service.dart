import 'dart:async';

import 'package:flutter/foundation.dart';
import '../models/contact.dart';
import '../models/path_selection.dart';
import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';

/// Companion firmware since MeshCore 4a869163 (2025-12-30) replaces the CLI
/// frame timestamp with the companion radio's own clock for
/// TXT_TYPE_CLI_DATA, so a plain `clock sync` copies the radio's clock to the
/// repeater instead of the phone's. Send an explicit `time <epoch>` instead,
/// the same as meshcore-cli does.
String normalizeRepeaterClockSyncCommand(String command, {int? nowSeconds}) {
  if (command.trim().toLowerCase() != 'clock sync') return command;
  final epoch = nowSeconds ?? DateTime.now().millisecondsSinceEpoch ~/ 1000;
  return 'time $epoch';
}

/// One command, across all its attempts. Every attempt goes out with its
/// own reply tag (`AB|`), and a reply to any of them answers the command,
/// so a reply that arrives just after an attempt timed out isn't wasted.
class _Request {
  _Request(this.repeaterKey, this.command);
  final String repeaterKey;
  final String command;
  final Completer<String> reply = Completer<String>();
  final List<String> tags = [];
}

class RepeaterCommandService {
  final MeshCoreConnector _connector;

  /// Commands waiting for a reply, by reply tag.
  final Map<String, _Request> _pending = {};

  /// Commands that already gave up, by reply tag, kept for [lateReplyWindow]
  /// so a reply that turns up later is reported (see [onLateReply]) instead
  /// of being taken as the answer to some other command.
  final Map<String, _Request> _late = {};
  final List<Timer> _lateTimers = [];

  /// Shared by every service, so two screens talking to the same repeater
  /// never hand out the same reply tag and take each other's replies.
  static int _tagCounter = DateTime.now().microsecond & 0xFF;

  static const int maxRetries = 5;

  /// The shortest wait for a reply. The timeout model is trained on message
  /// acks, but a command reply is a full message the repeater sends 0.6 s
  /// after running the command, so it takes longer than an ack.
  static const Duration minDirectWait = Duration(seconds: 12);
  static const Duration minFloodWait = Duration(seconds: 20);

  /// How long a reply to a command that already timed out is still noticed.
  static const Duration lateReplyWindow = Duration(minutes: 2);

  /// [txtTypeCliData] for repeaters and room servers (after login), or
  /// [txtTypeCliCommand] for another companion radio that allows us.
  final int txtType;

  /// Called with a command and its reply when the reply arrives after the
  /// command already timed out.
  final void Function(String command, String reply)? onLateReply;

  RepeaterCommandService(
    this._connector, {
    this.txtType = txtTypeCliData,
    this.onLateReply,
  });

  /// Send a CLI command to a repeater with automatic retries
  /// Returns a future that completes when a response is received or after max retries
  Future<String> sendCommand(
    Contact repeater,
    String command, {
    Function(String)? onResponse,
    Function(int)? onAttempt,
    int retries = maxRetries,
  }) async {
    final attemptCount = retries < 1 ? 1 : retries;
    final selection = await _connector.preparePathForContactSend(repeater);
    final request = _Request(repeater.publicKeyHex, command);
    var waited = Duration.zero;

    try {
      for (int attempt = 0; attempt < attemptCount; attempt++) {
        onAttempt?.call(attempt + 1);
        final wait = await _sendAttempt(repeater, request, selection, attempt);
        waited = wait;
        String? response;
        try {
          response = await request.reply.future.timeout(wait);
        } on TimeoutException {
          response = null;
        }
        if (response != null) {
          onResponse?.call(response);
          return response;
        }
      }
      throw 'Command timeout after ${(waited.inMilliseconds / 1000).ceil()} seconds';
    } finally {
      _retire(request);
    }
  }

  /// Sends one attempt of [request] and returns how long to wait for it.
  Future<Duration> _sendAttempt(
    Contact repeater,
    _Request request,
    PathSelection selection,
    int attempt,
  ) async {
    final tag = _nextPrefixToken();
    request.tags.add(tag);
    _pending[tag] = request;

    try {
      final framedCommand =
          '$tag${normalizeRepeaterClockSyncCommand(request.command)}';
      final pathLengthValue = selection.useFlood ? -1 : selection.hopCount;
      final timestampSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      _connector.trackRepeaterAck(
        contact: repeater,
        selection: selection,
        text: framedCommand,
        timestampSeconds: timestampSeconds,
        attempt: attempt,
      );
      final frame = buildSendCliCommandFrame(
        repeater.publicKey,
        framedCommand,
        attempt: attempt,
        timestampSeconds: timestampSeconds,
        txtType: txtType,
      );
      final responseBytes = frame.length > maxFrameSize
          ? frame.length
          : maxFrameSize;
      final modelWait = Duration(
        milliseconds: _connector.calculateTimeout(
          pathLength: pathLengthValue,
          messageBytes: responseBytes,
        ),
      );
      await _connector.sendFrame(frame);
      return waitFor(modelWait, flood: selection.useFlood);
    } catch (e) {
      throw Exception('Failed to send command: $e');
    }
  }

  /// How long to wait for a reply: the model's estimate, but never less than
  /// [minDirectWait] / [minFloodWait].
  @visibleForTesting
  static Duration waitFor(Duration modelWait, {required bool flood}) {
    final floor = flood ? minFloodWait : minDirectWait;
    return modelWait > floor ? modelWait : floor;
  }

  void _retire(_Request request) {
    for (final tag in request.tags) {
      if (_pending[tag] == request) _pending.remove(tag);
      if (request.reply.isCompleted) continue;
      _late[tag] = request;
    }
    if (request.reply.isCompleted) return;
    _lateTimers.add(
      Timer(lateReplyWindow, () {
        for (final tag in request.tags) {
          if (_late[tag] == request) _late.remove(tag);
        }
      }),
    );
  }

  /// Call this when a text message response is received from a repeater
  void handleResponse(Contact repeater, String responseText) {
    final repeaterKey = repeater.publicKeyHex;
    if (responseText.length >= 3 && responseText[2] == '|') {
      final tag = responseText.substring(0, 3);
      final payload = responseText.substring(3).trimLeft();
      final request = _pending[tag];
      if (request != null) {
        if (!request.reply.isCompleted) request.reply.complete(payload);
        return;
      }
      final late = _late.remove(tag);
      if (late != null) onLateReply?.call(late.command, payload);
      // A tag we didn't send (another app, or one long expired) answers
      // nothing here; guessing would show it as the reply to another command.
      return;
    }

    // Untagged reply (older firmware): the oldest waiting command for this
    // repeater.
    for (final request in _pending.values) {
      if (request.repeaterKey == repeaterKey && !request.reply.isCompleted) {
        request.reply.complete(responseText);
        return;
      }
    }
  }

  void dispose() {
    for (final timer in _lateTimers) {
      timer.cancel();
    }
    _lateTimers.clear();
    _pending.clear();
    _late.clear();
  }

  String _nextPrefixToken() {
    for (var i = 0; i < 256; i++) {
      final value = _tagCounter++ & 0xFF;
      final token = '${value.toRadixString(16).padLeft(2, '0').toUpperCase()}|';
      if (!_pending.containsKey(token)) {
        return token;
      }
    }
    return '00|';
  }
}
