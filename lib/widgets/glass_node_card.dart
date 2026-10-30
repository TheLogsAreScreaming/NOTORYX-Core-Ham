import 'package:flutter/material.dart';

import 'tactical_glass_panel.dart';

/// Presentation-only wrapper for node information.
class GlassNodeCard extends StatelessWidget {
  const GlassNodeCard({super.key, required this.child, this.isOnline});

  final Widget child;
  final bool? isOnline;

  @override
  Widget build(BuildContext context) {
    final status = isOnline;
    return TacticalGlassPanel(
      blur: false,
      borderRadius: 18,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        children: [
          if (status != null) ...[
            Semantics(
              label: status ? 'Node online' : 'Node offline',
              child: Icon(
                Icons.circle,
                size: 8,
                color: status
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline,
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(child: child),
        ],
      ),
    );
  }
}
