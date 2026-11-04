import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/app_localizations.dart';
import 'app_shortcuts.dart';

/// What the home-screen widget shows, already in the app's language.
Map<String, String> homeWidgetValues({
  required AppLocalizations t,
  required bool connected,
  required String? radioName,
  required int? batteryPercent,
  required int unread,
}) => {
  'radio': (radioName == null || radioName.isEmpty)
      ? 'NOTORYX Core Ham'
      : radioName,
  'status': connected
      ? t.connections_statusConnected
      : t.connections_statusNotConnected,
  'battery': connected && batteryPercent != null ? '$batteryPercent%' : '—',
  'unread': '$unread',
  'lbl_battery': t.radioOverview_battery,
  'lbl_unread': t.contacts_unread,
  'lbl_checkin': t.shortcuts_checkIn,
  'lbl_sos': t.fieldOps_kindSos,
};

/// What a widget tap asks for.
enum HomeWidgetAction { open, checkIn, sos }

HomeWidgetAction? homeWidgetActionFor(Uri? uri) {
  if (uri == null || uri.scheme != 'notoryx' || uri.host != 'widget') {
    return null;
  }
  return switch (uri.path) {
    '/checkin' => HomeWidgetAction.checkIn,
    '/sos' => HomeWidgetAction.sos,
    _ => HomeWidgetAction.open,
  };
}

/// The home_widget plugin, behind an interface for tests.
abstract class HomeWidgetBridge {
  Future<void> save(String key, String value);
  Future<void> update();
  Future<Uri?> initialLaunch();
  Stream<Uri?> get clicks;
}

class PluginHomeWidgetBridge implements HomeWidgetBridge {
  @override
  Future<void> save(String key, String value) =>
      HomeWidget.saveWidgetData<String>(key, value);

  @override
  Future<void> update() => HomeWidget.updateWidget(
    qualifiedAndroidName: 'com.meshcore.meshcore_open.NotoryxWidgetProvider',
  );

  @override
  Future<Uri?> initialLaunch() => HomeWidget.initiallyLaunchedFromHomeWidget();

  @override
  Stream<Uri?> get clicks => HomeWidget.widgetClicked;
}

/// Keeps the Android home-screen widget current and opens what its buttons
/// ask for. Check in opens the usual review step and SOS opens Home, where
/// the SOS button still needs its hold: a widget tap never sends anything.
class HomeWidgetSync {
  HomeWidgetSync(
    this.connector,
    this.navigator, {
    HomeWidgetBridge? bridge,
    Widget Function(AppShortcut)? screenFor,
  }) : _bridge = bridge ?? PluginHomeWidgetBridge(),
       _screenFor = screenFor ?? shortcutScreen;

  final MeshCoreConnector connector;
  final GlobalKey<NavigatorState> navigator;
  final HomeWidgetBridge _bridge;
  final Widget Function(AppShortcut) _screenFor;

  AppLocalizations _t = lookupAppLocalizations(const Locale('en'));
  Map<String, String> _last = const {};
  Timer? _debounce;
  StreamSubscription<Uri?>? _clicks;

  Future<void> start() async {
    connector.addListener(_schedule);
    _clicks = _bridge.clicks.listen(_handle);
    _handle(await _bridge.initialLaunch());
    await push();
  }

  void setLabels(AppLocalizations t) {
    _t = t;
    _schedule();
  }

  // Battery and unread change often; the widget only needs to be current
  // within a few seconds.
  void _schedule() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 3), () => unawaited(push()));
  }

  @visibleForTesting
  Future<void> push() async {
    final values = homeWidgetValues(
      t: _t,
      connected: connector.isConnected,
      radioName: connector.isConnected ? connector.selfName : null,
      batteryPercent: connector.batteryPercent,
      unread: connector.getTotalUnreadCount(),
    );
    if (_mapEquals(values, _last)) return;
    _last = values;
    try {
      for (final e in values.entries) {
        await _bridge.save(e.key, e.value);
      }
      await _bridge.update();
    } catch (e) {
      debugPrint('Home widget not updated: $e');
    }
  }

  static bool _mapEquals(Map<String, String> a, Map<String, String> b) =>
      a.length == b.length && a.entries.every((e) => b[e.key] == e.value);

  void _handle(Uri? uri) {
    final action = homeWidgetActionFor(uri);
    if (action == null) return;
    final nav = navigator.currentState;
    if (nav == null) {
      // Launched by the tap: wait for the first frame's navigator.
      WidgetsBinding.instance.addPostFrameCallback((_) => _handle(uri));
      return;
    }
    nav.popUntil((route) => route.isFirst);
    if (action == HomeWidgetAction.checkIn) {
      nav.push(
        MaterialPageRoute<void>(
          builder: (_) => _screenFor(AppShortcut.checkIn),
        ),
      );
    }
  }

  void dispose() {
    _debounce?.cancel();
    unawaited(_clicks?.cancel());
    connector.removeListener(_schedule);
  }
}
