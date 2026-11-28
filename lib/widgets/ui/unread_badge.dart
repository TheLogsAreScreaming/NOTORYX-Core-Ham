import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../../theme/mesh_theme.dart';

/// A filled count pill for unread messages, matching the tab bar's badges, so
/// unread items stand out in long lists. Shows "99+" above 99.
class UnreadBadge extends StatelessWidget {
  const UnreadBadge(this.count, {super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    final label = count > 99 ? '99+' : '$count';
    return Semantics(
      label: context.l10n.messages_unreadCount(count),
      excludeSemantics: true,
      child: Container(
        constraints: const BoxConstraints(minWidth: 22),
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
        decoration: BoxDecoration(
          color: MeshPalette.accent,
          borderRadius: BorderRadius.circular(MeshRadii.pill),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: MeshTheme.mono(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: MeshPalette.onAccent,
          ),
        ),
      ),
    );
  }
}
