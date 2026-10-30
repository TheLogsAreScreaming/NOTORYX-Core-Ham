import 'package:flutter/material.dart';

import '../connector/meshcore_connector.dart';
import '../screens/channel_chat_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/discovery_screen.dart';

/// Opens the screen a clicked notification is about: the conversation for
/// a message, the channel for a channel post, Discovered contacts for a new
/// advert. Anything else, or a contact or channel that is gone, just brings
/// the app back to its main screen.
class NotificationRouter {
  NotificationRouter(this.navigator, this.connector);

  final GlobalKey<NavigatorState> navigator;
  final MeshCoreConnector connector;
  String? _pending;

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
