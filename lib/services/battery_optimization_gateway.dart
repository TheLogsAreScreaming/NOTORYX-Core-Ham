import 'package:flutter/foundation.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

/// Android's battery optimisation for this app, behind a seam so the
/// settings tile can be tested without a device.
abstract interface class BatteryOptimizationGateway {
  /// Whether Android exempts this app from battery optimisation, or null
  /// where the question doesn't apply (iOS, macOS, desktop, web).
  Future<bool?> isExempt();

  /// Opens Android's battery optimisation list so the user can exempt the
  /// app. Returns whether the screen opened.
  Future<bool> openSettings();
}

/// The real gateway, using the foreground-task plugin the app already ships.
///
/// It opens the system list rather than asking directly, so the app needs no
/// REQUEST_IGNORE_BATTERY_OPTIMIZATIONS permission, which app stores review.
class PlatformBatteryOptimizationGateway implements BatteryOptimizationGateway {
  const PlatformBatteryOptimizationGateway();

  bool get _isAndroid =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  @override
  Future<bool?> isExempt() async {
    if (!_isAndroid) return null;
    try {
      return await FlutterForegroundTask.isIgnoringBatteryOptimizations;
    } on Exception {
      return null;
    }
  }

  @override
  Future<bool> openSettings() async {
    if (!_isAndroid) return false;
    try {
      return await FlutterForegroundTask.openIgnoreBatteryOptimizationSettings();
    } on Exception {
      return false;
    }
  }
}
