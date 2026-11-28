import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../theme/mesh_theme.dart';

/// A small "2B" tag: how many bytes per hop a contact's route uses.
///
/// It is drawn in the warning color when the route's width differs from the
/// radio's own setting, which is when messages along it are most likely to
/// go astray.
class PathHashBadge extends StatelessWidget {
  const PathHashBadge({
    super.key,
    required this.width,
    required this.radioWidth,
  });

  /// Bytes per hop in the contact's route.
  final int width;

  /// Bytes per hop the connected radio is set to use.
  final int radioWidth;

  /// Whether the route's width differs from the radio's.
  bool get isMismatch => width != radioWidth;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final color = isMismatch ? MeshPalette.warn : MeshPalette.ink3;
    final label = isMismatch
        ? '${l10n.pathHash_badge(width)}. ${l10n.pathHash_mismatch(radioWidth)}'
        : l10n.pathHash_badge(width);
    return Tooltip(
      message: label,
      child: Semantics(
        label: label,
        child: ExcludeSemantics(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: color.withValues(alpha: isMismatch ? 0.9 : 0.5),
                width: isMismatch ? 1.2 : 1,
              ),
            ),
            child: Text(
              '${width}B',
              style: MeshTheme.mono(
                fontSize: 11,
                fontWeight: isMismatch ? FontWeight.w700 : FontWeight.w500,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
