import 'dart:async';

import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../services/battery_optimization_gateway.dart';
import '../theme/mesh_theme.dart';

/// Says whether Android may stop the app in the background, and opens the
/// system setting to stop it. Shows nothing off Android.
///
/// Checks again whenever the app returns to the foreground, so the status
/// updates as soon as the user comes back from the system screen.
class BatteryOptimizationTile extends StatefulWidget {
  const BatteryOptimizationTile({
    super.key,
    this.gateway = const PlatformBatteryOptimizationGateway(),
  });

  final BatteryOptimizationGateway gateway;

  @override
  State<BatteryOptimizationTile> createState() =>
      _BatteryOptimizationTileState();
}

class _BatteryOptimizationTileState extends State<BatteryOptimizationTile>
    with WidgetsBindingObserver {
  bool? _exempt;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    unawaited(_refresh());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) unawaited(_refresh());
  }

  Future<void> _refresh() async {
    final exempt = await widget.gateway.isExempt();
    if (!mounted) return;
    setState(() => _exempt = exempt);
  }

  @override
  Widget build(BuildContext context) {
    final exempt = _exempt;
    if (exempt == null) return const SizedBox.shrink();
    final l10n = context.l10n;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          key: const ValueKey('battery-optimization-tile'),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          leading: Icon(
            exempt ? Icons.battery_charging_full : Icons.battery_alert,
            size: 20,
            color: exempt ? MeshPalette.signal : MeshPalette.warn,
          ),
          title: Text(l10n.batteryOpt_title),
          subtitle: Text(exempt ? l10n.batteryOpt_off : l10n.batteryOpt_on),
          isThreeLine: !exempt,
          trailing: exempt
              ? null
              : TextButton(
                  key: const ValueKey('battery-optimization-fix'),
                  onPressed: () => unawaited(widget.gateway.openSettings()),
                  child: Text(l10n.batteryOpt_fix),
                ),
        ),
        const Divider(height: 1, indent: 16),
      ],
    );
  }
}
