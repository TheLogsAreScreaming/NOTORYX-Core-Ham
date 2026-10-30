import 'package:flutter/material.dart';

import 'tactical_glass_panel.dart';

/// Presentation-only wrapper for chat information.
class GlassChatCard extends StatelessWidget {
  const GlassChatCard({super.key, required this.child, this.unreadCount = 0});

  final Widget child;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    return TacticalGlassPanel(
      blur: false,
      child: Row(
        children: [
          Expanded(child: child),
          if (unreadCount > 0) ...[
            const SizedBox(width: 12),
            Semantics(
              label: '$unreadCount unread messages',
              child: Badge(label: Text('$unreadCount')),
            ),
          ],
        ],
      ),
    );
  }
}
