import 'package:flutter/material.dart';

import '../theme/mesh_theme.dart';
import 'instrument.dart';
import 'tactical_glass_panel.dart';

/// A compact glass surface for a main-tab action or readout.
class GlassActionRow extends StatelessWidget {
  const GlassActionRow({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.trailing,
    this.onTap,
    this.titleColor,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      MeshSpace.lg,
      0,
      MeshSpace.lg,
      MeshSpace.sm,
    ),
    child: TacticalGlassPanel(
      blur: false,
      padding: EdgeInsets.zero,
      child: InstrumentRow(
        title: title,
        subtitle: subtitle,
        icon: icon,
        trailing: trailing,
        onTap: onTap,
        titleColor: titleColor,
        divider: false,
      ),
    ),
  );
}
