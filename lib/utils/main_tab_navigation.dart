import 'package:flutter/material.dart';

import '../screens/bastion_tools_screen.dart';
import '../screens/channels_screen.dart';
import '../screens/contacts_screen.dart';
import '../screens/map_screen.dart';
import '../screens/settings_screen.dart';
import 'route_transitions.dart';

/// The destinations in Bastion's bottom bar, in bar order.
enum MainTab {
  nodes,
  chats,
  map,

  /// Opens on top of the current tab rather than replacing it.
  tools,

  /// Opens on top of the current tab rather than replacing it.
  settings,
}

/// The screen shown for [tab] when it is opened from the bottom bar.
Widget mainTabScreen(MainTab tab) {
  switch (tab) {
    case MainTab.nodes:
      return const ContactsScreen(hideBackButton: true);
    case MainTab.chats:
      return const ChannelsScreen(hideBackButton: true);
    case MainTab.map:
      return const MapScreen(hideBackButton: true);
    case MainTab.tools:
      return const BastionToolsScreen();
    case MainTab.settings:
      return const SettingsScreen();
  }
}

/// Opens [tab]: NODES, CHATS and MAP replace the current tab screen with a
/// crossfade so the bar stays put; TOOLS and SETTINGS are pushed on top.
void switchMainTab(BuildContext context, MainTab tab) {
  switch (tab) {
    case MainTab.tools:
    case MainTab.settings:
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => mainTabScreen(tab)));
    case MainTab.nodes:
    case MainTab.chats:
    case MainTab.map:
      Navigator.pushReplacement(
        context,
        buildQuickSwitchRoute(mainTabScreen(tab)),
      );
  }
}
