import 'package:flutter/material.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/widgets/battery_indicator.dart';
import 'package:provider/provider.dart';

import 'radio_stats_entry.dart';
import 'snr_indicator.dart';

class AppBarTitle extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget? trailing;
  final bool indicators;
  final bool showBatteryIndicator;
  final bool subtitle;

  const AppBarTitle(
    this.title, {
    this.leading,
    this.trailing,
    this.indicators = true,
    this.showBatteryIndicator = true,
    this.subtitle = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final connector = context.watch<MeshCoreConnector>();
    final selfName = connector.selfName;
    const cyan = Color(0xFF18D3D3);

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;
        final showBattery = showBatteryIndicator && availableWidth >= 60;
        final showSnr = availableWidth >= 110;
        final showIndicators = (showBattery || showSnr) && indicators;

        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            leading ?? const SizedBox.shrink(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'BASTION',
                    maxLines: 1,
                    style: TextStyle(
                      color: cyan,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.7,
                    ),
                  ),
                  Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
                  if (subtitle && connector.isConnected && selfName != null)
                    Text(
                      selfName,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF9AA6AF),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            if (showIndicators) const SizedBox(width: 6),
            if (showIndicators)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showBattery) BatteryIndicator(connector: connector),
                  if (showSnr) SNRIndicator(connector: connector),
                  if (connector.supportsCompanionRadioStats)
                    const RadioStatsIconButton(compact: true),
                ],
              ),
            trailing ?? const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
