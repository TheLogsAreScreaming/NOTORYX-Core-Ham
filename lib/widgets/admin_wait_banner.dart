import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../models/admin_wait.dart';
import '../theme/mesh_theme.dart';
import 'tactical_glass_panel.dart';

/// Says what a remote admin request is waiting on: the route it took, how
/// long it may take, and whether this is the automatic retry.
///
/// The bar fills over the attempt's timeout, so a slow multi-hop reply
/// reads as "still on its way" instead of a frozen spinner.
class AdminWaitBanner extends StatelessWidget {
  const AdminWaitBanner({super.key, required this.wait});

  final AdminWait wait;

  /// The route and time limit in words, for example "Direct, 3 hops · up to
  /// 12 s".
  static String routeText(BuildContext context, AdminWait wait) {
    final l10n = context.l10n;
    final route = wait.isFlood
        ? l10n.routing_modeFlood
        : l10n.adminWait_direct(wait.hops);
    return '$route · ${l10n.adminWait_upTo(wait.timeoutSeconds)}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final title = wait.isRetry
        ? l10n.adminWait_retrying(wait.attempt, wait.maxAttempts)
        : l10n.adminWait_waiting;
    final route = routeText(context, wait);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return Semantics(
      liveRegion: true,
      label: '$title. $route',
      child: ExcludeSemantics(
        child: TacticalGlassPanel(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    wait.isRetry ? Icons.replay : Icons.hourglass_top,
                    size: 20,
                    color: wait.isRetry ? MeshPalette.warn : MeshPalette.accent,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(title, style: theme.textTheme.titleSmall),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 30),
                child: Text(route, style: theme.textTheme.bodySmall),
              ),
              const SizedBox(height: 10),
              if (reduceMotion)
                const LinearProgressIndicator()
              else
                TweenAnimationBuilder<double>(
                  key: ValueKey(wait.attempt),
                  tween: Tween(begin: 0, end: 1),
                  duration: wait.timeout,
                  builder: (context, value, _) =>
                      LinearProgressIndicator(value: value),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
