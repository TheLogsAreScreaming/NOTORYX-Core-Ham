import 'dart:ui';

import 'package:flutter/material.dart';

/// Reusable NOTORYX frosted-glass panel.
///
/// A see-through surface with a bright top edge, so the
/// [EmberBackdrop] glow shows through it. [blur] adds a backdrop blur for
/// large panels; rows in long lists leave it off, since a blur per row is
/// costly on older phones. Reduced motion also turns the blur off.
/// This is visual-only: it does not interact with radio state.
class TacticalGlassPanel extends StatelessWidget {
  const TacticalGlassPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.blur = true,
    this.borderRadius = 22,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool blur;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final radius = BorderRadius.circular(borderRadius);
    final useBlur = blur && !MediaQuery.disableAnimationsOf(context);
    // Light grounds need more white to read as glass; dark ones less.
    final top = isDark ? 0.14 : 0.70;
    final upper = isDark ? 0.08 : 0.55;
    final bottom = isDark ? 0.035 : 0.40;
    final panel = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // The first stop is the lit top edge.
          stops: const [0, 0.06, 1],
          colors: [
            Colors.white.withValues(alpha: top),
            Colors.white.withValues(alpha: upper),
            Colors.white.withValues(alpha: bottom),
          ],
        ),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.black.withValues(alpha: 0.08),
        ),
      ),
      child: Padding(padding: padding, child: child),
    );

    // No drop shadow: Flutter paints it under the whole box, so it would
    // show through the glass and darken it.
    return ClipRRect(
      borderRadius: radius,
      child: useBlur
          ? BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: panel,
            )
          : panel,
    );
  }
}
