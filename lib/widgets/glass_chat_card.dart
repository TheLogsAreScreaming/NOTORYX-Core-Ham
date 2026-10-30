import 'package:flutter/material.dart';

import 'tactical_glass_panel.dart';

/// Presentation-only wrapper for chat information.
class GlassChatCard extends StatelessWidget {
  const GlassChatCard({super.key, required this.child, this.unreadCount = 0});

  final Widget child;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: TacticalGlassPanel(
        blur: false,
        borderRadius: 18,
        padding: const EdgeInsets.only(right: 12),
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
      ),
    );
  }
}
