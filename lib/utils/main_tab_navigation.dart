import 'package:flutter/material.dart';

import '../screens/bastion_home_screen.dart';
import '../screens/bastion_tools_screen.dart';
import '../screens/channels_screen.dart';
import '../screens/contacts_screen.dart';
import '../screens/map_screen.dart';
import 'route_transitions.dart';

/// The destinations in Bastion's bottom bar, in bar order.
enum MainTab {
  /// The Field Console (check-in, SOS): the app's first screen.
  home,
  chats,
  nodes,
  map,

  /// Tools and Settings. Opens on top of the current tab rather than
  /// replacing it.
  more,
}

/// The screen shown for [tab] when it is opened from the bottom bar.
Widget mainTabScreen(MainTab tab) {
  switch (tab) {
    case MainTab.home:
      return const BastionHomeScreen();
    case MainTab.nodes:
      return const ContactsScreen(hideBackButton: true);
    case MainTab.chats:
      return const ChannelsScreen(hideBackButton: true);
    case MainTab.map:
      return const MapScreen(hideBackButton: true);
    case MainTab.more:
      return const BastionToolsScreen();
  }
}

/// Opens [tab]: Nodes, Chats and Map replace the current tab screen with a
/// crossfade so the bar stays put; More is pushed on top.
///
/// Home returns to the Field Console, which is always the first screen, so
/// SOS is one tap away after connecting. From HOME the other tabs open on
/// top of it instead of replacing it.
void switchMainTab(
  BuildContext context,
  MainTab tab, {
  MainTab? from,
  @visibleForTesting Widget Function(MainTab) screenFor = mainTabScreen,
}) {
  final navigator = Navigator.of(context);
  switch (tab) {
    case MainTab.home:
      navigator.popUntil((route) => route.isFirst);
    case MainTab.more:
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => screenFor(tab)));
    case MainTab.nodes:
    case MainTab.chats:
    case MainTab.map:
      final route = buildQuickSwitchRoute(screenFor(tab));
      if (from == MainTab.home || !navigator.canPop()) {
        navigator.push(route);
      } else {
        navigator.pushReplacement(route);
      }
  }
}
