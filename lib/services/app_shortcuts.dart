import 'package:flutter/material.dart';
import 'package:quick_actions/quick_actions.dart';

import '../l10n/app_localizations.dart';
import '../screens/bastion_field_ops_screen.dart';
import '../utils/main_tab_navigation.dart';

/// Long-press shortcuts on the app icon (Android and iOS).
enum AppShortcut {
  checkIn('bastion.check_in'),
  trip('bastion.trip'),
  chats('bastion.chats'),
  map('bastion.map');

  const AppShortcut(this.type);
  final String type;

  /// The title shown on the launcher, in [t]'s language.
  String labelIn(AppLocalizations t) => switch (this) {
    checkIn => t.shortcuts_checkIn,
    trip => t.shortcuts_trip,
    chats => t.shortcuts_chats,
    map => t.shortcuts_map,
  };

  static AppShortcut? fromType(String? type) {
    for (final s in values) {
      if (s.type == type) return s;
    }
    return null;
  }
}

/// The screen a shortcut opens on top of the home screen. Check in opens the
/// Trip page with the usual review step; nothing is sent without it.
Widget shortcutScreen(AppShortcut shortcut) => switch (shortcut) {
  AppShortcut.checkIn => const BastionFieldOpsScreen(initialCheckIn: true),
  AppShortcut.trip => const BastionFieldOpsScreen(),
  AppShortcut.chats => mainTabScreen(MainTab.chats),
  AppShortcut.map => mainTabScreen(MainTab.map),
};

/// Registers the shortcuts and opens the right screen when one is used,
/// including when it launched the app.
class AppShortcuts {
  final GlobalKey<NavigatorState> navigator;
  final QuickActions _actions;
  final Widget Function(AppShortcut) _screenFor;
  AppShortcut? _pending;
  AppLocalizations _labels = lookupAppLocalizations(const Locale('en'));
  Future<void> _ready = Future<void>.value();

  AppShortcuts(
    this.navigator, {
    QuickActions? actions,
    Widget Function(AppShortcut)? screenFor,
  }) : _actions = actions ?? const QuickActions(),
       _screenFor = screenFor ?? shortcutScreen;

  Future<void> install() => _ready = _install();

  Future<void> _install() async {
    await _actions.initialize((type) => open(AppShortcut.fromType(type)));
    await _setItems();
  }

  /// Retitles the shortcuts, after [install], when the app language is known
  /// or changes.
  Future<void> setLabels(AppLocalizations labels) {
    _labels = labels;
    return _ready = _ready.then((_) => _setItems());
  }

  Future<void> _setItems() => _actions.setShortcutItems([
    for (final s in AppShortcut.values)
      ShortcutItem(type: s.type, localizedTitle: s.labelIn(_labels)),
  ]);

  /// Opens [shortcut]. If the app is still starting, waits for its first
  /// frame so the navigator exists.
  @visibleForTesting
  void open(AppShortcut? shortcut) {
    if (shortcut == null) return;
    final nav = navigator.currentState;
    if (nav == null) {
      _pending = shortcut;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final next = _pending;
        _pending = null;
        if (next != null && navigator.currentState != null) open(next);
      });
      return;
    }
    nav.popUntil((route) => route.isFirst);
    nav.push(MaterialPageRoute<void>(builder: (_) => _screenFor(shortcut)));
  }
}
