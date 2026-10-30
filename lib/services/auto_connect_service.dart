import 'dart:async';

import 'package:flutter/foundation.dart';

import '../connector/meshcore_connector.dart';
import '../models/saved_radio.dart';
import 'app_settings_service.dart';

/// "Connect to my radio automatically": when the app opens, or when the
/// switch is turned on, reconnect to the last radio without a tap. The radio
/// may still be waking up or out of range, so it tries a few times, then
/// leaves it to the user. Starting any other connection stops it.
class AutoConnectService {
  AutoConnectService(
    this.connector,
    this.settings, {
    this.delays = const [
      Duration.zero,
      Duration(seconds: 5),
      Duration(seconds: 15),
      Duration(seconds: 30),
    ],
  });

  final MeshCoreConnector connector;
  final AppSettingsService settings;
  final List<Duration> delays;

  bool _wasOn = false;
  bool _running = false;
  bool _disposed = false;

  void start() {
    _wasOn = settings.settings.autoConnectRadio;
    settings.addListener(_onSettings);
    if (_wasOn) unawaited(run());
  }

  void _onSettings() {
    final on = settings.settings.autoConnectRadio;
    if (on && !_wasOn) unawaited(run());
    _wasOn = on;
  }

  /// Whether there's a radio to go back to: Bluetooth or network. USB isn't
  /// tried, since it needs the cable and a permission prompt.
  bool get _hasTarget {
    final saved = connector.savedRadio;
    return saved != null && saved.transport != SavedRadioTransport.usb;
  }

  bool get _idle => connector.state == MeshCoreConnectionState.disconnected;

  @visibleForTesting
  Future<void> run() async {
    if (_running) return;
    _running = true;
    try {
      for (final delay in delays) {
        if (delay > Duration.zero) await Future<void>.delayed(delay);
        if (_disposed ||
            !settings.settings.autoConnectRadio ||
            !_hasTarget ||
            !_idle) {
          return;
        }
        try {
          await connector.reconnectSavedRadio();
        } catch (_) {
          // Out of range or still booting; the next attempt may find it.
        }
        if (connector.isConnected) return;
      }
    } finally {
      _running = false;
    }
  }

  void dispose() {
    _disposed = true;
    settings.removeListener(_onSettings);
  }
}
