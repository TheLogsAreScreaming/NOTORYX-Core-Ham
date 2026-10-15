import 'package:flutter/material.dart';

import '../screens/contacts_screen.dart';
import '../screens/map_screen.dart';
import '../screens/messages_screen.dart';
import '../screens/settings_screen.dart';
import 'route_transitions.dart';

/// The top-level destinations in the bottom navigation bar.
enum MainTab { messages, nodes, map, radio }

/// The screen shown for [tab] when it is opened from the bottom bar.
Widget mainTabScreen(MainTab tab) {
  switch (tab) {
    case MainTab.messages:
      return const MessagesScreen();
    case MainTab.nodes:
      return const ContactsScreen(hideBackButton: true);
    case MainTab.map:
      return const MapScreen(hideBackButton: true);
    case MainTab.radio:
      return const SettingsScreen(asTab: true);
  }
}

/// Replaces the current tab screen with [tab], crossfading so the bar stays
/// put.
void switchMainTab(BuildContext context, MainTab tab) {
  Navigator.pushReplacement(context, buildQuickSwitchRoute(mainTabScreen(tab)));
}
