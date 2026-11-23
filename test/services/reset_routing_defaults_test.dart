import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/app_settings.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
  });

  test(
    'reset puts route weights and retry counts back, nothing else',
    () async {
      final service = AppSettingsService();
      await service.setAutoRouteRotationEnabled(false);
      await service.setMaxRouteWeight(9);
      await service.setInitialRouteWeight(1);
      await service.setRouteWeightSuccessIncrement(2);
      await service.setRouteWeightFailureDecrement(1.5);
      await service.setMaxMessageRetries(10);
      await service.setMessageFloodAttempts(0);

      await service.resetRoutingSettingsToDefault();

      final s = service.settings;
      expect(s.maxRouteWeight, AppSettings.defaultMaxRouteWeight);
      expect(s.initialRouteWeight, AppSettings.defaultInitialRouteWeight);
      expect(
        s.routeWeightSuccessIncrement,
        AppSettings.defaultRouteWeightSuccessIncrement,
      );
      expect(
        s.routeWeightFailureDecrement,
        AppSettings.defaultRouteWeightFailureDecrement,
      );
      expect(s.maxMessageRetries, AppSettings.defaultMaxMessageRetries);
      expect(s.messageFloodAttempts, AppSettings.defaultMessageFloodAttempts);
      // The on/off switch is the person's choice, not a tuning value.
      expect(s.autoRouteRotationEnabled, isFalse);
    },
  );

  test('the defaults match a fresh install and an empty settings file', () {
    for (final s in [AppSettings(), AppSettings.fromJson(const {})]) {
      expect(s.maxRouteWeight, 5.0);
      expect(s.initialRouteWeight, 3.0);
      expect(s.routeWeightSuccessIncrement, 0.5);
      expect(s.routeWeightFailureDecrement, 0.2);
      expect(s.maxMessageRetries, 5);
      expect(s.messageFloodAttempts, 2);
    }
  });
}
