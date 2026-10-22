import 'package:flutter/material.dart';

import '../l10n/l10n.dart';

/// Quiet "via MQTT" marker for a channel message the radio never heard.
///
/// [color] should be a muted text color already checked for contrast against
/// the bubble it sits on.
class ViaMqttLabel extends StatelessWidget {
  final Color color;
  final double textScale;

  const ViaMqttLabel({super.key, required this.color, this.textScale = 1.0});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Semantics(
      label: l10n.channels_viaMqttSemantics,
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.cloud_outlined, size: 11 * textScale, color: color),
          const SizedBox(width: 2),
          Text(
            l10n.channels_viaMqtt,
            style: TextStyle(fontSize: 10.5 * textScale, color: color),
          ),
        ],
      ),
    );
  }
}
