import 'package:flutter/material.dart';
import 'tactical_glass_panel.dart';

/// Presentation-only wrapper for chat information.
class GlassChatCard extends StatelessWidget {
  const GlassChatCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TacticalGlassPanel(
      blur: false,
      child: child,
    );
  }
}
