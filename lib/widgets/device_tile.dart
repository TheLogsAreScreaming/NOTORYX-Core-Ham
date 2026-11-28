import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../l10n/l10n.dart';
import '../theme/mesh_theme.dart';
import 'connect_ui.dart';

/// One radio found by a Bluetooth scan: its name, signal strength (bars, a
/// word and dBm), ID, and a Connect button. While connecting, the card is
/// outlined in the accent color and shows a progress ring instead.
class DeviceTile extends StatelessWidget {
  final ScanResult scanResult;
  final VoidCallback? onTap;
  final bool isConnecting;

  const DeviceTile({
    super.key,
    required this.scanResult,
    required this.onTap,
    this.isConnecting = false,
  });

  /// "MeshCore-Trail Lead" reads as "Trail Lead"; other names are unchanged.
  static String friendlyName(String advertisedName) {
    const prefix = 'MeshCore-';
    if (advertisedName.startsWith(prefix) &&
        advertisedName.length > prefix.length) {
      return advertisedName.substring(prefix.length);
    }
    return advertisedName;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final device = scanResult.device;
    final rssi = scanResult.rssi;
    final name = device.platformName.isNotEmpty
        ? device.platformName
        : scanResult.advertisementData.advName;
    final displayName = name.isNotEmpty
        ? friendlyName(name)
        : l10n.common_unknownDevice;
    final id = device.remoteId.toString();
    final quality = bleSignalQuality(rssi);
    final qualityColor = bleSignalColor(quality);
    final tap = onTap == null
        ? null
        : () {
            HapticFeedback.selectionClick();
            onTap!();
          };

    return Semantics(
      button: tap != null,
      label: '$displayName, ${bleSignalQualityLabel(l10n, quality)}',
      excludeSemantics: true,
      onTap: tap,
      child: Material(
        color: isConnecting ? MeshPalette.accentBg : MeshPalette.bg2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isConnecting ? MeshPalette.accentLine : MeshPalette.line,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: tap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: MeshPalette.accentBg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: MeshPalette.accentLine),
                  ),
                  child: Icon(
                    Icons.settings_input_antenna_rounded,
                    color: MeshPalette.accent,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        displayName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: MeshPalette.ink,
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      if (isConnecting)
                        Text(
                          l10n.scanner_connecting,
                          style: TextStyle(
                            color: MeshPalette.accent,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      else
                        Row(
                          children: [
                            BleSignalBars(quality: quality),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                rssi == 0
                                    ? bleSignalQualityLabel(l10n, quality)
                                    : '${bleSignalQualityLabel(l10n, quality)} · $rssi dBm',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    MeshTheme.mono(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: qualityColor,
                                    ).copyWith(
                                      fontFeatures: const [
                                        FontFeature.tabularFigures(),
                                      ],
                                    ),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 4),
                      Text(
                        id,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: MeshTheme.mono(
                          fontSize: 10,
                          color: MeshPalette.ink4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                if (isConnecting)
                  SizedBox.square(
                    dimension: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: MeshPalette.accent,
                    ),
                  )
                else
                  // Quiet outline: the whole row is the tap target, and a
                  // list of filled buttons would compete for attention.
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(MeshRadii.pill),
                      border: Border.all(
                        color: tap == null
                            ? MeshPalette.line2
                            : MeshPalette.accent.withValues(alpha: 0.7),
                      ),
                    ),
                    child: Text(
                      l10n.common_connect,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: tap == null
                            ? MeshPalette.ink3
                            : MeshPalette.accent,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
