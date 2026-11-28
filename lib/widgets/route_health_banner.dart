import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/contact.dart';
import '../models/route_health.dart';
import '../services/path_history_service.dart';
import '../theme/mesh_theme.dart';

/// The route health of [contact] from its path history.
RouteHealth routeHealthFor(
  Contact contact,
  PathHistoryService? history, {
  DateTime? now,
}) {
  final records = history?.getRecentPaths(contact.publicKeyHex) ?? const [];
  final current = records
      .where((r) => listEquals(r.pathBytes, contact.path))
      .firstOrNull;
  return assessRoute(
    pathLength: contact.pathLength,
    lastWorked: current?.timestamp,
    successes: current?.successCount ?? 0,
    failures: current?.failureCount ?? 0,
    lastHeard: contact.lastSeen,
    now: now ?? DateTime.now(),
  );
}

/// The reasons behind a route grade, in words, joined for one line.
String routeReasonsText(AppLocalizations l10n, RouteHealth health) => [
  for (final (reason, v) in health.reasons)
    switch (reason) {
      RouteReason.flooding => null,
      RouteReason.lastWorked =>
        v >= 48
            ? l10n.routeHealth_lastWorkedDays(v ~/ 24)
            : l10n.routeHealth_lastWorkedHours(v),
      RouteReason.notHeard => l10n.routeHealth_notHeard(v),
      RouteReason.failures => l10n.routeHealth_failures(v, health.attempts),
      RouteReason.longPath => l10n.routeHealth_longPath(v),
    },
].whereType<String>().join(' · ');

/// Above the composer: warns before sending when the route to [contact]
/// looks stale or unreliable, and offers to find a new one by flooding.
class RouteHealthBanner extends StatefulWidget {
  const RouteHealthBanner({super.key, required this.contact});

  final Contact contact;

  @override
  State<RouteHealthBanner> createState() => _RouteHealthBannerState();
}

class _RouteHealthBannerState extends State<RouteHealthBanner> {
  /// The route the user chose to keep; the banner stays hidden for it.
  List<int>? _keptPath;

  @override
  Widget build(BuildContext context) {
    final contact = widget.contact;
    PathHistoryService? history;
    try {
      history = context.watch<PathHistoryService>();
    } on ProviderNotFoundException {
      history = null; // Screen tests without path history.
    }
    final health = routeHealthFor(contact, history);
    if (!health.worthWarning || listEquals(_keptPath, contact.path)) {
      return const SizedBox.shrink();
    }
    final l10n = context.l10n;
    final stale = health.grade == RouteHealthGrade.stale;
    return Container(
      key: const ValueKey('route-health-banner'),
      margin: const EdgeInsets.fromLTRB(12, 6, 12, 0),
      padding: const EdgeInsets.fromLTRB(12, 8, 8, 4),
      decoration: BoxDecoration(
        color: MeshPalette.warnBg,
        border: Border.all(color: MeshPalette.warnLine),
        borderRadius: BorderRadius.circular(MeshRadii.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                stale ? Icons.history_toggle_off : Icons.alt_route,
                color: MeshPalette.warn,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stale
                          ? l10n.routeHealth_staleTitle(contact.name)
                          : l10n.routeHealth_weakTitle(contact.name),
                      style: TextStyle(
                        color: MeshPalette.ink,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      routeReasonsText(l10n, health),
                      style: TextStyle(color: MeshPalette.ink2, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Wrap(
            alignment: WrapAlignment.end,
            spacing: 4,
            children: [
              TextButton(
                onPressed: () =>
                    setState(() => _keptPath = List.of(contact.path)),
                child: Text(l10n.routeHealth_keep),
              ),
              TextButton(
                key: const ValueKey('route-health-flood'),
                onPressed: () =>
                    context.read<MeshCoreConnector>().clearContactPath(contact),
                child: Text(l10n.routeHealth_useFlood),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
