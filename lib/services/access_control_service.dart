import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../models/access_control.dart';
import '../models/contact.dart';
import '../models/path_selection.dart';
import 'repeater_command_service.dart';

/// A `setperm` the node answered with something other than "OK".
class AccessControlException implements Exception {
  final String reply;

  const AccessControlException(this.reply);

  @override
  String toString() => 'AccessControlException: $reply';
}

/// A node's access list and whether every entry was received.
class AccessListResult {
  final List<AclEntry> entries;

  /// False when the list filled a reply and the rest couldn't be fetched.
  final bool complete;

  const AccessListResult({required this.entries, required this.complete});
}

/// Reads and changes a repeater's or room server's access list. The caller
/// must already be logged in to the node as admin.
class AccessControlService {
  final MeshCoreConnector _connector;
  final RepeaterCommandService _commands;
  final Random _random;

  AccessControlService(this._connector, this._commands, {Random? random})
    : _random = random ?? Random.secure();

  /// Fetches the node's access list. Throws [TimeoutException] when the node
  /// doesn't answer at all. A full first reply is followed up with paged
  /// requests; on firmware without paging those go unanswered and the result
  /// is marked incomplete.
  Future<AccessListResult> fetch(Contact node) async {
    final selection = await _connector.preparePathForContactSend(node);
    final List<AclEntry> entries;
    try {
      entries = List.of(
        parseAccessListResponse(await _request(node, selection, null)),
      );
      _connector.recordRepeaterPathResult(node, selection, true, null);
    } on TimeoutException {
      _connector.recordRepeaterPathResult(node, selection, false, null);
      rethrow;
    }
    if (entries.length < maxAccessListEntriesPerReply) {
      return AccessListResult(entries: entries, complete: true);
    }

    while (true) {
      AccessListPage? page;
      // A lost page is retried once; firmware without paging never answers,
      // so after that the list is reported as incomplete.
      for (var attempt = 0; attempt < 2 && page == null; attempt++) {
        try {
          page = parsePagedAccessListResponse(
            await _request(node, selection, entries.length),
          );
        } on TimeoutException {
          // fall through to the retry
        }
      }
      if (page == null) {
        return AccessListResult(entries: entries, complete: false);
      }
      entries.addAll(page.entries);
      if (page.entries.isEmpty || entries.length >= page.total) {
        return AccessListResult(entries: entries, complete: true);
      }
    }
  }

  /// Sends one GET_ACCESS_LIST request and returns the reply data after the
  /// tag. [start] makes it a paged request.
  Future<Uint8List> _request(
    Contact node,
    PathSelection selection,
    int? start,
  ) async {
    final nonce = Uint8List.fromList(
      List.generate(4, (_) => _random.nextInt(256)),
    );
    final reply = Completer<Uint8List>();
    Uint8List? tag;

    // Subscribe before sending: the firmware first answers RESP_CODE_SENT
    // with the tag its later binary response will carry.
    final subscription = _connector.receivedFrames.listen((frame) {
      if (frame.length < 6 || reply.isCompleted) return;
      if (tag == null && frame[0] == respCodeSent) {
        tag = Uint8List.fromList(frame.sublist(2, 6));
      } else if (tag != null &&
          frame[0] == pushCodeBinaryResponse &&
          listEquals(frame.sublist(2, 6), tag)) {
        reply.complete(Uint8List.fromList(frame.sublist(6)));
      }
    });

    try {
      await _connector.sendFrame(
        buildSendBinaryReq(
          node.publicKey,
          payload: buildGetAccessListPayload(nonce, start: start),
        ),
      );
      final timeoutMs = _connector.calculateTimeout(
        pathLength: selection.useFlood ? -1 : selection.hopCount,
        messageBytes: 184,
      );
      return await reply.future.timeout(Duration(milliseconds: timeoutMs));
    } finally {
      await subscription.cancel();
    }
  }

  /// Gives [publicKey] the [role] on [node]; [AclRole.guest] removes it.
  /// Throws [AccessControlException] if the node refuses.
  Future<void> setRole(Contact node, Uint8List publicKey, AclRole role) async {
    // RepeaterCommandService doesn't read the radio itself: whoever sends a
    // command must hand it the node's text replies.
    final replies = _connector.receivedFrames.listen((frame) {
      if (frame.isEmpty ||
          (frame[0] != respCodeContactMsgRecv &&
              frame[0] != respCodeContactMsgRecvV3)) {
        return;
      }
      final parsed = parseContactMessageText(frame);
      if (parsed == null || !_isFrom(node, parsed.senderPrefix)) return;
      _commands.handleResponse(node, parsed.text);
    });
    final String response;
    try {
      response = await _commands.sendCommand(
        node,
        buildSetPermCommand(publicKey, role),
      );
    } finally {
      await replies.cancel();
    }
    final text = response.trim();
    if (!text.toLowerCase().startsWith('ok')) {
      throw AccessControlException(text);
    }
  }

  static bool _isFrom(Contact node, Uint8List senderPrefix) {
    final key = node.publicKey;
    if (senderPrefix.length < 6 || key.length < 6) return false;
    for (var i = 0; i < 6; i++) {
      if (senderPrefix[i] != key[i]) return false;
    }
    return true;
  }
}
