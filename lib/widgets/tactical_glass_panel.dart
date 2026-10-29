import 'dart:ui';

import 'package:flutter/material.dart';

/// Reusable NOTORYX glass-tactical panel.
///
/// Keeps readable, opaque fallback surfaces available for field use.
/// This is visual-only: it does not interact with radio state.
class TacticalGlassPanel extends StatelessWidget {
  const TacticalGlassPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.blur = true,
    this.borderRadius = 18,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool blur;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final radius = BorderRadius.circular(borderRadius);
    final panel = Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.surfaceContainerHigh.withValues(alpha: blur ? 0.82 : 1),
            scheme.surfaceContainerLow.withValues(alpha: blur ? 0.90 : 1),
          ],
        ),
        border: Border.all(
          color: scheme.outline.withValues(alpha: isDark ? 0.50 : 0.65),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.18 : 0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );

    return ClipRRect(
      borderRadius: radius,
      child: blur
          ? BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: panel,
            )
          : panel,
    );
  }
}
