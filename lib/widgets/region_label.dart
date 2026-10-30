import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../models/region_scope.dart';

/// Quiet marker for a channel post its sender scoped to a region: a pin and
/// the region's name, or "Regional" when the region can't be named.
///
/// [color] should be a muted text color already checked for contrast against
/// the bubble it sits on.
class RegionLabel extends StatelessWidget {
  final String region;
  final Color color;
  final double textScale;

  const RegionLabel({
    super.key,
    required this.region,
    required this.color,
    this.textScale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final known = region != unknownRegion;
    return Semantics(
      label: known
          ? l10n.channels_regionSemantics(region)
          : l10n.channels_regionUnknownSemantics,
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.place_outlined, size: 11 * textScale, color: color),
          const SizedBox(width: 2),
          Text(
            known ? region : l10n.channels_regionUnknown,
            style: TextStyle(fontSize: 10.5 * textScale, color: color),
          ),
        ],
      ),
    );
  }
}
