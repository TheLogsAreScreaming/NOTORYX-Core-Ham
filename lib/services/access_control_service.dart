import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../models/access_control.dart';
import '../models/contact.dart';
import 'repeater_command_service.dart';

/// A `setperm` the node answered with something other than "OK".
class AccessControlException implements Exception {
  final String reply;

  const AccessControlException(this.reply);

  @override
  String toString() => 'AccessControlException: $reply';
}

/// Reads and changes a repeater's or room server's access list. The caller
/// must already be logged in to the node as admin.
class AccessControlService {
  final MeshCoreConnector _connector;
  final RepeaterCommandService _commands;
  final Random _random;

  AccessControlService(this._connector, this._commands, {Random? random})
    : _random = random ?? Random.secure();

  /// Fetches the node's access list. Throws [TimeoutException] when no reply
  /// arrives in time.
  Future<List<AclEntry>> fetch(Contact node) async {
    final selection = await _connector.preparePathForContactSend(node);
    final nonce = Uint8List.fromList(
      List.generate(4, (_) => _random.nextInt(256)),
    );
    final reply = Completer<List<AclEntry>>();
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
        reply.complete(parseAccessListResponse(frame.sublist(6)));
      }
    });

    try {
      await _connector.sendFrame(
        buildSendBinaryReq(
          node.publicKey,
          payload: buildGetAccessListPayload(nonce),
        ),
      );
      final timeoutMs = _connector.calculateTimeout(
        pathLength: selection.useFlood ? -1 : selection.hopCount,
        messageBytes: 184,
      );
      final entries = await reply.future.timeout(
        Duration(milliseconds: timeoutMs),
      );
      _connector.recordRepeaterPathResult(node, selection, true, null);
      return entries;
    } on TimeoutException {
      _connector.recordRepeaterPathResult(node, selection, false, null);
      rethrow;
    } finally {
      await subscription.cancel();
    }
  }

  /// Gives [publicKey] the [role] on [node]; [AclRole.guest] removes it.
  /// Throws [AccessControlException] if the node refuses.
  Future<void> setRole(Contact node, Uint8List publicKey, AclRole role) async {
    final response = await _commands.sendCommand(
      node,
      buildSetPermCommand(publicKey, role),
    );
    final text = response.trim();
    if (!text.toLowerCase().startsWith('ok')) {
      throw AccessControlException(text);
    }
  }
}
