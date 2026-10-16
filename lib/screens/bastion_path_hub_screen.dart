import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/l10n.dart';
import '../models/contact.dart';
import '../models/path_history.dart';
import '../services/path_history_service.dart';
import 'discovery_screen.dart';
import 'map_screen.dart';

class BastionPathHubScreen extends StatelessWidget {
  const BastionPathHubScreen({super.key});

  static const _cyan = Color(0xFF8AB6AA);
  static const _bg = Color(0xFF182126);
  static const _panel = Color(0xFF202D33);

  @override
  Widget build(BuildContext context) {
    final connector = context.watch<MeshCoreConnector>();
    final history = context.watch<PathHistoryService>();

    final entries = <_ContactRoutes>[];
    for (final contact in connector.contacts) {
      final paths = history.getRecentPaths(contact.publicKeyHex);
      final flood = history.getFloodStats(contact.publicKeyHex);
      if (paths.isNotEmpty || flood != null) {
        final ranked = List<PathRecord>.from(paths)
          ..sort((a, b) {
            final weight = b.routeWeight.compareTo(a.routeWeight);
            if (weight != 0) return weight;
            final aRate = _successRate(a);
            final bRate = _successRate(b);
            final reliability = bRate.compareTo(aRate);
            if (reliability != 0) return reliability;
            final aTrip = a.tripTimeMs <= 0 ? 1 << 30 : a.tripTimeMs;
            final bTrip = b.tripTimeMs <= 0 ? 1 << 30 : b.tripTimeMs;
            return aTrip.compareTo(bTrip);
          });
        entries.add(_ContactRoutes(contact, ranked, flood));
      }
    }

    final routeCount = entries.fold<int>(0, (sum, e) => sum + e.paths.length);
    final successful = entries.fold<int>(
      0,
      (sum, e) => sum + e.paths.fold<int>(0, (s, p) => s + p.successCount),
    );
    final failed = entries.fold<int>(
      0,
      (sum, e) => sum + e.paths.fold<int>(0, (s, p) => s + p.failureCount),
    );
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Color(0xFFE4E6DF),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BASTION',
              style: TextStyle(
                color: _cyan,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.7,
              ),
            ),
            Text(
              l10n.routes_title,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: _panel,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: _cyan.withValues(alpha: .45)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.bastion_routeIntelligence,
                  style: const TextStyle(
                    color: _cyan,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.routes_headline,
                  style: const TextStyle(
                    color: Color(0xFFE4E6DF),
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.routes_body,
                  style: const TextStyle(color: Color(0xFFCED8D2), height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _Metric(
                  label: l10n.bastion_nodes,
                  value: '${entries.length}',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _Metric(label: l10n.routes_routes, value: '$routeCount'),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _Metric(
                  label: l10n.routes_success,
                  value: '$successful',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _Metric(label: l10n.routes_failed, value: '$failed'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _PathAction(
                  icon: Icons.map_rounded,
                  title: l10n.routes_routeMap,
                  subtitle: l10n.routes_routeMapHint,
                  onTap: () => Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const MapScreen())),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _PathAction(
                  icon: Icons.radar_rounded,
                  title: l10n.routes_discover,
                  subtitle: l10n.routes_discoverHint,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const DiscoveryScreen()),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            l10n.routes_learned,
            style: const TextStyle(
              color: _cyan,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.3,
            ),
          ),
          const SizedBox(height: 10),
          if (entries.isEmpty)
            _InfoPanel(
              icon: Icons.alt_route_rounded,
              title: l10n.routes_none,
              body: l10n.routes_noneBody,
            )
          else
            ...entries.map((entry) => _ContactRouteCard(entry: entry)),
        ],
      ),
    );
  }

  static double _successRate(PathRecord path) {
    final attempts = path.successCount + path.failureCount;
    if (attempts == 0) return 0;
    return path.successCount / attempts;
  }
}

class _ContactRoutes {
  final Contact contact;
  final List<PathRecord> paths;
  final ({
    int successCount,
    int failureCount,
    int lastTripTimeMs,
    DateTime? lastUsed,
  })?
  flood;

  const _ContactRoutes(this.contact, this.paths, this.flood);
}

class _ContactRouteCard extends StatelessWidget {
  final _ContactRoutes entry;
  const _ContactRouteCard({required this.entry});

  String _path(BuildContext context, PathRecord path) {
    if (path.pathBytes.isEmpty) return context.l10n.routes_direct;
    return path.pathBytes
        .map((b) => b.toRadixString(16).padLeft(2, '0').toUpperCase())
        .join(' › ');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final best = entry.paths.isEmpty ? null : entry.paths.first;
    final fastest = entry.paths
        .where((p) => p.tripTimeMs > 0)
        .fold<PathRecord?>(null, (current, p) {
          if (current == null || p.tripTimeMs < current.tripTimeMs) return p;
          return current;
        });

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1C272D),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF36474E)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.hub_rounded, color: Color(0xFF8AB6AA), size: 20),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  entry.contact.name,
                  style: const TextStyle(
                    color: Color(0xFFE4E6DF),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                l10n.routes_routeCount(entry.paths.length),
                style: const TextStyle(color: Color(0xFFADBEB7), fontSize: 11),
              ),
            ],
          ),
          if (best != null) ...[
            const SizedBox(height: 10),
            Text(
              l10n.routes_best(_path(context, best)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF8AB6AA),
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              l10n.routes_bestDetail(
                l10n.bastion_hopsCount(best.hopCount),
                best.routeWeight.toStringAsFixed(1),
                '${best.successCount}',
                '${best.failureCount}',
              ),
              style: const TextStyle(color: Color(0xFFB3BDC5), fontSize: 11.5),
            ),
          ],
          if (fastest != null) ...[
            const SizedBox(height: 4),
            Text(
              l10n.routes_fastest('${fastest.tripTimeMs}'),
              style: const TextStyle(color: Color(0xFFADBEB7), fontSize: 11),
            ),
          ],
          if (entry.flood != null) ...[
            const SizedBox(height: 4),
            Text(
              l10n.routes_flood(
                '${entry.flood!.successCount}',
                '${entry.flood!.failureCount}',
              ),
              style: const TextStyle(color: Color(0xFFADBEB7), fontSize: 11),
            ),
          ],
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;
  const _Metric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 11),
    decoration: BoxDecoration(
      color: const Color(0xFF202D33),
      borderRadius: BorderRadius.circular(13),
      border: Border.all(color: const Color(0xFF36474E)),
    ),
    child: Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF8AB6AA),
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFADBEB7),
            fontSize: 8.5,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}

class _PathAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _PathAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Material(
    color: const Color(0xFF202D33),
    borderRadius: BorderRadius.circular(16),
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF36474E)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF8AB6AA)),
            const SizedBox(height: 9),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFFE4E6DF),
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              style: const TextStyle(color: Color(0xFFADBEB7), fontSize: 11),
            ),
          ],
        ),
      ),
    ),
  );
}

class _InfoPanel extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _InfoPanel({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF1C272D),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF36474E)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF8AB6AA)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFFE4E6DF),
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                body,
                style: const TextStyle(color: Color(0xFFADBEB7), height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
