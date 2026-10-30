import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/cayenne_lpp.dart';
import '../l10n/l10n.dart';
import '../models/app_settings.dart';
import '../services/app_settings_service.dart';
import '../services/my_sensors_service.dart';
import '../theme/mesh_theme.dart';
import 'instrument.dart';
import 'tactical_glass_panel.dart';

/// Home's "Sensors": the connected radio's own readings as chips, with a
/// refresh button. It reads once on its own the first time it's shown.
class MySensorsPanel extends StatefulWidget {
  const MySensorsPanel({super.key});

  @override
  State<MySensorsPanel> createState() => _MySensorsPanelState();
}

class _MySensorsPanelState extends State<MySensorsPanel> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final sensors = context.read<MySensorsService?>();
      if (mounted && sensors != null && sensors.updated == null) {
        sensors.refresh();
      }
    });
  }

  static IconData _icon(int type) => switch (type) {
    CayenneLpp.lppVoltage => Icons.battery_full_rounded,
    CayenneLpp.lppTemperature => Icons.thermostat_rounded,
    CayenneLpp.lppLuminosity => Icons.wb_sunny_outlined,
    CayenneLpp.lppRelativeHumidity => Icons.water_drop_outlined,
    CayenneLpp.lppBarometricPressure => Icons.speed_rounded,
    CayenneLpp.lppGps => Icons.near_me_outlined,
    _ => Icons.sensors_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final sensors = context.watch<MySensorsService?>();
    if (sensors == null) return const SizedBox.shrink();
    final l10n = context.l10n;
    // Settings → App settings → Units.
    final imperial =
        context.watch<AppSettingsService?>()?.settings.unitSystem ==
        UnitSystem.imperial;
    final chips = [
      for (final r in sensors.readings)
        if (formatSensorReading(r, imperial: imperial) case final text?)
          (icon: _icon(r['type'] as int), text: text),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InstrumentLabel(l10n.mySensors_title),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            MeshSpace.lg,
            0,
            MeshSpace.lg,
            MeshSpace.sm,
          ),
          child: TacticalGlassPanel(
            blur: false,
            padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
            child: Row(
              children: [
                Expanded(
                  child: chips.isEmpty
                      ? Text(
                          sensors.loading
                              ? l10n.mySensors_reading
                              : sensors.failed
                              ? l10n.mySensors_failed
                              : l10n.mySensors_none,
                          style: TextStyle(color: MeshPalette.ink3),
                        )
                      : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final c in chips)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.06),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      c.icon,
                                      size: 15,
                                      color: MeshPalette.ink3,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      c.text,
                                      style: MeshTheme.mono(
                                        fontSize: 13,
                                        color: MeshPalette.ink,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                ),
                IconButton(
                  key: const ValueKey('my-sensors-refresh'),
                  tooltip: l10n.mySensors_refresh,
                  onPressed: sensors.loading ? null : sensors.refresh,
                  icon: sensors.loading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.refresh_rounded),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
