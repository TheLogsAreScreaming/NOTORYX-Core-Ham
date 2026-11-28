import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../screens/channel_chat_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/discovery_screen.dart';
import '../storage/draft_store.dart';

/// Opens the screen a clicked notification is about: the conversation for
/// a message, the channel for a channel post, Discovered contacts for a new
/// advert. Anything else, or a contact or channel that is gone, just brings
/// the app back to its main screen.
class NotificationRouter {
  NotificationRouter(
    this.navigator,
    this.connector, {
    bool Function()? isLocked,
  }) : _isLocked = isLocked ?? _never;

  static bool _never() => false;

  final GlobalKey<NavigatorState> navigator;
  final MeshCoreConnector connector;
  final bool Function() _isLocked;
  String? _pending;
  final List<(String, String)> _heldReplies = [];

  /// The screen for [payload], or null when it names nothing that exists.
  @visibleForTesting
  Widget? screenFor(String payload) {
    final split = payload.indexOf(':');
    final kind = split < 0 ? payload : payload.substring(0, split);
    final id = split < 0 ? '' : payload.substring(split + 1);
    switch (kind) {
      case 'message':
        final contact = connector.getContactByPubKeyHex(id);
        return contact == null ? null : ChatScreen(contact: contact);
      case 'channel':
        final index = int.tryParse(id);
        for (final channel in connector.channels) {
          if (channel.index == index) {
            return ChannelChatScreen(channel: channel);
          }
        }
        return null;
      case 'advert':
        return const DiscoveryScreen();
    }
    return null;
  }

  /// Sends [text] to the conversation [payload] names, then opens it. A
  /// reply that can't go out now (no radio, app locked, too long, target
  /// gone) becomes that conversation's draft rather than being lost.
  Future<void> reply(String payload, String text) async {
    if (await _trySend(payload, text)) {
      open(payload);
    } else if (connector.selfPublicKeyHex.isEmpty) {
      // Drafts are kept per radio, and none is known yet (cold start).
      if (_heldReplies.isEmpty) connector.addListener(_flushHeldReplies);
      _heldReplies.add((payload, text));
    } else {
      await _keepAsDraft(payload, text);
      open(payload);
    }
  }

  Future<bool> _trySend(String payload, String text) async {
    if (!connector.isConnected || _isLocked()) return false;
    final split = payload.indexOf(':');
    if (split < 0) return false;
    final id = payload.substring(split + 1);
    switch (payload.substring(0, split)) {
      case 'message':
        final contact = connector.getContactByPubKeyHex(id);
        if (contact == null) return false;
        final outbound = connector.prepareContactOutboundText(contact, text);
        if (utf8.encode(outbound).length > maxContactMessageBytes()) {
          return false;
        }
        await connector.sendMessage(contact, text);
        return true;
      case 'channel':
        final index = int.tryParse(id);
        for (final channel in connector.channels) {
          if (channel.index != index) continue;
          if (utf8.encode(text).length >
              maxChannelMessageBytes(connector.selfName)) {
            return false;
          }
          await connector.sendChannelMessage(channel, text);
          return true;
        }
    }
    return false;
  }

  Future<void> _keepAsDraft(String payload, String text) async {
    final split = payload.indexOf(':');
    if (split < 0) return;
    final id = payload.substring(split + 1);
    final self = connector.selfPublicKeyHex;
    final String key;
    switch (payload.substring(0, split)) {
      case 'message':
        key = DraftStore.contactKey(self, id);
      case 'channel':
        final index = int.tryParse(id);
        if (index == null) return;
        key = DraftStore.channelKey(self, index);
      default:
        return;
    }
    final existing = DraftStore.load(key);
    await DraftStore.save(key, existing == null ? text : '$existing\n$text');
  }

  void _flushHeldReplies() {
    if (connector.selfPublicKeyHex.isEmpty) return;
    connector.removeListener(_flushHeldReplies);
    final held = List.of(_heldReplies);
    _heldReplies.clear();
    for (final (payload, text) in held) {
      unawaited(
        reply(payload, text).catchError((Object e) {
          debugPrint('Quick reply failed: $e');
        }),
      );
    }
  }

  /// Opens [payload]'s screen on top of the main screen. Before the first
  /// frame the navigator doesn't exist yet, so it waits for it.
  void open(String payload) {
    final nav = navigator.currentState;
    if (nav == null) {
      _pending = payload;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final next = _pending;
        _pending = null;
        if (next != null && navigator.currentState != null) open(next);
      });
      return;
    }
    nav.popUntil((route) => route.isFirst);
    final screen = screenFor(payload);
    if (screen != null) {
      nav.push(MaterialPageRoute<void>(builder: (_) => screen));
    }
  }
}
