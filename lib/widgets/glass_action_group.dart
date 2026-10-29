import 'package:flutter/material.dart';
import 'tactical_glass_panel.dart';

/// Presentation-only wrapper for home action controls.
class GlassActionGroup extends StatelessWidget {
  const GlassActionGroup({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TacticalGlassPanel(
      blur: false,
      child: child,
    );
  }
}
