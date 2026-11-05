import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/operator_profile.dart';
import '../storage/prefs_manager.dart';
import '../utils/app_logger.dart';

/// Keeps the [OperatorProfile] on this device. Nothing here is sent to a
/// radio or the internet.
class OperatorProfileService extends ChangeNotifier {
  static const _prefKey = 'operator_profile';

  OperatorProfile _profile = const OperatorProfile();

  OperatorProfile get profile => _profile;

  void load() {
    final stored = PrefsManager.instance.getString(_prefKey);
    if (stored == null) return;
    try {
      _profile = OperatorProfile.fromJson(
        jsonDecode(stored) as Map<String, dynamic>,
      );
    } catch (e) {
      appLogger.warn('Operator profile unreadable, starting fresh: $e');
      _profile = const OperatorProfile();
    }
  }

  Future<void> save(OperatorProfile profile) async {
    _profile = profile;
    notifyListeners();
    await PrefsManager.instance.setString(
      _prefKey,
      jsonEncode(profile.toJson()),
    );
  }
}
