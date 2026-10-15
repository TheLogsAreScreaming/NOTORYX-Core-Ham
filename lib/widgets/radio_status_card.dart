import 'package:flutter/material.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/l10n.dart';
import '../theme/mesh_theme.dart';
import 'battery_indicator.dart';

/// Compact at-a-glance status of the connected radio: who we are, how we are
/// connected and the radio's battery. Tapping it opens the Radio tab.
class RadioStatusCard extends StatelessWidget {
  final MeshCoreConnector connector;
  final VoidCallback onTap;

  const RadioStatusCard({
    super.key,
    required this.connector,
    required this.onTap,
  });

  String _transportLabel(BuildContext context) {
    final l10n = context.l10n;
    switch (connector.activeTransport) {
      case MeshCoreTransportType.bluetooth:
        return l10n.radioStatus_bluetooth;
      case MeshCoreTransportType.usb:
        return l10n.radioStatus_usb;
      case MeshCoreTransportType.tcp:
        return l10n.radioStatus_tcp;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final percent = connector.batteryPercent;
    final battery = batteryUiForPercent(percent);
    final subtitle = l10n.radioStatus_connectedVia(_transportLabel(context));

    return Semantics(
      button: true,
      label: [
        connector.deviceDisplayName,
        subtitle,
        if (percent != null) l10n.radioStatus_battery(percent),
      ].join(', '),
      hint: l10n.radioStatus_openRadio,
      excludeSemantics: true,
      child: Material(
        color: scheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MeshRadii.md),
          side: BorderSide(color: scheme.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 60),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(14, 10, 14, 10),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: MeshPalette.signal,
                      boxShadow: [
                        BoxShadow(
                          color: MeshPalette.signal.withValues(alpha: 0.25),
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          connector.deviceDisplayName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (percent != null) ...[
                    const SizedBox(width: 8),
                    Icon(
                      battery.icon,
                      size: 20,
                      color: battery.color ?? scheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$percent%',
                      style: MeshTheme.mono(
                        fontSize: 14,
                        color: scheme.onSurface,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
