import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_logger.dart';

/// Asks the phone to confirm it's the owner. Separate so tests needn't touch
/// the platform.
abstract interface class DeviceAuthenticator {
  /// Whether this device can check a fingerprint, face or screen lock.
  Future<bool> isAvailable();

  /// Shows the system prompt; true when the owner was confirmed.
  Future<bool> authenticate(String reason);
}

class LocalDeviceAuthenticator implements DeviceAuthenticator {
  final _auth = LocalAuthentication();

  @override
  Future<bool> isAvailable() async {
    try {
      return await _auth.isDeviceSupported();
    } on PlatformException catch (e) {
      appLogger.warn('Device lock check failed: $e');
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  @override
  Future<bool> authenticate(String reason) =>
      _auth.authenticate(localizedReason: reason);
}

/// Covers the app until the phone's owner is confirmed. Only the screen is
/// locked: the radio, alerts and background work carry on underneath.
class AppLockService extends ChangeNotifier {
  AppLockService(
    this._prefs, {
    DeviceAuthenticator? authenticator,
    DateTime Function()? now,
  }) : _authenticator = authenticator ?? LocalDeviceAuthenticator(),
       _now = now ?? DateTime.now {
    _enabled = _prefs.getBool(_key) ?? false;
    _locked = _enabled;
  }

  static const _key = 'app_lock_enabled';

  /// Time away after which returning to the app asks again.
  static const grace = Duration(minutes: 1);

  final SharedPreferences _prefs;
  final DeviceAuthenticator _authenticator;
  final DateTime Function() _now;

  late bool _enabled;
  late bool _locked;
  bool _busy = false;
  DateTime? _leftAt;

  bool get enabled => _enabled;
  bool get locked => _locked;

  Future<bool> isAvailable() => _authenticator.isAvailable();

  /// Turns the lock on or off. Either way the owner must be confirmed first,
  /// so nobody can be locked out by a lock they never managed to open.
  /// Returns whether the change was made.
  Future<bool> setEnabled(bool value, String reason) async {
    if (value == _enabled) return true;
    if (!await _confirm(reason)) return false;
    _enabled = value;
    _locked = false;
    await _prefs.setBool(_key, value);
    notifyListeners();
    return true;
  }

  /// Asks for the owner, and opens the app if confirmed. A device that no
  /// longer has any screen lock opens straight away rather than trapping the
  /// user's data behind a prompt that can't be answered.
  Future<void> unlock(String reason) async {
    if (!_locked || _busy) return;
    _busy = true;
    try {
      final open =
          !await _authenticator.isAvailable() || await _confirm(reason);
      if (open) {
        _locked = false;
        _leftAt = null;
        notifyListeners();
      }
    } finally {
      _busy = false;
    }
  }

  Future<bool> _confirm(String reason) async {
    try {
      return await _authenticator.authenticate(reason);
    } on PlatformException catch (e) {
      appLogger.warn('Unlock failed: $e');
      return false;
    } on MissingPluginException {
      return false;
    } on Exception catch (e) {
      appLogger.warn('Unlock failed: $e');
      return false;
    }
  }

  /// Call when the app goes to the background.
  void onBackground() => _leftAt ??= _now();

  /// Call when the app comes back.
  void onForeground() {
    final left = _leftAt;
    _leftAt = null;
    if (!_enabled || _locked || left == null) return;
    if (_now().difference(left) >= grace) {
      _locked = true;
      notifyListeners();
    }
  }
}
