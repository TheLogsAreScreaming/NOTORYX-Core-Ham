import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../helpers/direct_heard_name.dart';
import '../helpers/path_helper.dart';
import '../helpers/path_hop_resolver.dart';
import '../l10n/l10n.dart';
import '../models/contact.dart';
import '../models/direct_repeaters.dart';
import '../models/path_history.dart';
import '../services/corescope.dart';
import '../services/direct_repeater_service.dart';
import '../services/path_history_service.dart';
import '../theme/mesh_theme.dart';
import '../widgets/mesh_ui.dart';
import 'discovery_screen.dart';
import 'map_screen.dart';

class BastionPathHubScreen extends StatelessWidget {
  const BastionPathHubScreen({super.key});

  static Color get _bg => MeshPalette.bg;

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
        foregroundColor: MeshPalette.ink,
        title: Text(l10n.routes_title),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          MeshSpace.lg,
          MeshSpace.sm,
          MeshSpace.lg,
          MeshSpace.xxl,
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(MeshSpace.lg),
            decoration: BoxDecoration(
              border: Border.all(color: MeshPalette.line),
              borderRadius: BorderRadius.circular(MeshRadii.xs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.routes_headline,
                  style: TextStyle(
                    color: MeshPalette.ink,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: MeshSpace.xs),
                Text(
                  l10n.routes_body,
                  style: TextStyle(
                    color: MeshPalette.ink3,
                    fontSize: 13.5,
                    height: 1.4,
                  ),
                ),
                // Counts only mean something once routes have been learned.
                if (routeCount > 0) ...[
                  const SizedBox(height: MeshSpace.lg),
                  Row(
                    children: [
                      Expanded(
                        child: MeshStat(
                          value: '${entries.length}',
                          label: l10n.bastion_nodes,
                        ),
                      ),
                      Expanded(
                        child: MeshStat(
                          value: '$routeCount',
                          label: l10n.routes_routes,
                        ),
                      ),
                      Expanded(
                        child: MeshStat(
                          value: '$successful',
                          label: l10n.routes_success,
                        ),
                      ),
                      Expanded(
                        child: MeshStat(
                          value: '$failed',
                          label: l10n.routes_failed,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: MeshSpace.md),
          MeshGroup(
            children: [
              MeshNavRow(
                icon: Icons.map_outlined,
                title: l10n.routes_routeMap,
                subtitle: l10n.routes_routeMapHint,
                onTap: () => Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const MapScreen())),
              ),
              MeshNavRow(
                icon: Icons.radar_rounded,
                title: l10n.routes_discover,
                subtitle: l10n.routes_discoverHint,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const DiscoveryScreen()),
                ),
              ),
            ],
          ),
          _BestRepeaters(connector: connector),
          _sectionTitle(l10n.routes_learned),
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

  static Widget _sectionTitle(String text) => SectionHeader(
    text,
    padding: const EdgeInsets.fromLTRB(
      MeshSpace.xs,
      MeshSpace.xl,
      MeshSpace.xs,
      MeshSpace.sm,
    ),
  );

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

  /// Repeater names along [path] ("?" where the ID can't be pinned to one
  /// known repeater), or null when none are known.
  String? _names(MeshCoreConnector connector, PathRecord path) {
    if (path.pathBytes.isEmpty) return null;
    final lat = connector.selfLatitude, lon = connector.selfLongitude;
    final hops = PathHopResolver.resolve(
      pathBytes: path.pathBytes,
      contacts: connector.allContactsUnfiltered,
      endpoint: lat == null || lon == null || (lat == 0 && lon == 0)
          ? null
          : LatLng(lat, lon),
      pathHashByteWidth: path.hashByteWidth,
    );
    if (hops.every((c) => c == null)) return null;
    return hops.map((c) => c?.name ?? '?').join(' › ');
  }

  String _path(BuildContext context, PathRecord path) {
    if (path.pathBytes.isEmpty) return context.l10n.routes_direct;
    return PathHelper.splitPathBytes(
      path.pathBytes,
      path.hashByteWidth,
    ).map(PathHelper.formatHopHex).join(' › ');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final best = entry.paths.isEmpty ? null : entry.paths.first;
    final names = best == null
        ? null
        : _names(context.read<MeshCoreConnector>(), best);
    final fastest = entry.paths
        .where((p) => p.tripTimeMs > 0)
        .fold<PathRecord?>(null, (current, p) {
          if (current == null || p.tripTimeMs < current.tripTimeMs) return p;
          return current;
        });

    return Container(
      margin: const EdgeInsets.only(bottom: MeshSpace.sm),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: MeshPalette.line),
        borderRadius: BorderRadius.circular(MeshRadii.xs),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.hub_outlined, color: MeshPalette.ink3, size: 20),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  entry.contact.name,
                  style: TextStyle(
                    color: MeshPalette.ink,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                l10n.routes_routeCount(entry.paths.length),
                style: TextStyle(color: MeshPalette.ink3, fontSize: 12),
              ),
            ],
          ),
          if (best != null) ...[
            const SizedBox(height: 10),
            Text(
              l10n.routes_best(_path(context, best)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: MeshTheme.mono(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: MeshPalette.accent,
              ),
            ),
            if (names != null) ...[
              const SizedBox(height: 3),
              Text(
                l10n.routes_via(names),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: MeshPalette.ink2, fontSize: 12.5),
              ),
            ],
            const SizedBox(height: 5),
            Text(
              l10n.routes_bestDetail(
                l10n.bastion_hopsCount(best.hopCount),
                best.routeWeight.toStringAsFixed(1),
                '${best.successCount}',
                '${best.failureCount}',
              ),
              style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
            ),
          ],
          if (fastest != null) ...[
            const SizedBox(height: 4),
            Text(
              l10n.routes_fastest('${fastest.tripTimeMs}'),
              style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
            ),
          ],
          if (entry.flood != null) ...[
            const SizedBox(height: 4),
            Text(
              l10n.routes_flood(
                '${entry.flood!.successCount}',
                '${entry.flood!.failureCount}',
              ),
              style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
            ),
          ],
        ],
      ),
    );
  }
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
    padding: const EdgeInsets.all(MeshSpace.lg),
    decoration: BoxDecoration(
      border: Border.all(color: MeshPalette.line),
      borderRadius: BorderRadius.circular(MeshRadii.xs),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: MeshPalette.ink3),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: MeshPalette.ink,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: MeshSpace.xs),
              Text(
                body,
                style: TextStyle(color: MeshPalette.ink3, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// The nodes this radio hears directly, strongest and most recent first.
class _BestRepeaters extends StatelessWidget {
  const _BestRepeaters({required this.connector});

  final MeshCoreConnector connector;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final service = context.watch<DirectRepeaterService?>();
    final analyzer = context.watch<AnalyzerService?>();
    if (service == null) return const SizedBox.shrink();
    final best = service.best();
    final now = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BastionPathHubScreen._sectionTitle(l10n.routes_nearbyTitle),
        if (best.isEmpty)
          _InfoPanel(
            icon: Icons.cell_tower_rounded,
            title: l10n.routes_nearbyEmptyTitle,
            body: l10n.routes_nearbyEmpty,
          )
        else
          for (var i = 0; i < best.length; i++)
            _BestRepeaterRow(
              rank: i + 1,
              name: heardNameWithOnline(connector, analyzer, best[i].id),
              id: directHeardShortId(best[i].id),
              heard: best[i],
              minutesAgo: now.difference(best[i].lastHeard).inMinutes,
            ),
      ],
    );
  }
}

class _BestRepeaterRow extends StatelessWidget {
  const _BestRepeaterRow({
    required this.rank,
    required this.name,
    required this.id,
    required this.heard,
    required this.minutesAgo,
  });

  final int rank;

  /// Null when the repeater isn't known by name; it's shown by [id].
  final String? name;
  final String id;
  final DirectHeard heard;
  final int minutesAgo;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final snr = heard.snrAverage;
    // SNR above ~5 dB is a solid LoRa link; below -5 dB it's marginal.
    final color = snr >= 5
        ? MeshPalette.signal
        : snr >= -5
        ? MeshPalette.warn
        : MeshPalette.alert;
    return Container(
      margin: const EdgeInsets.only(bottom: MeshSpace.sm),
      padding: const EdgeInsets.all(MeshSpace.md),
      decoration: BoxDecoration(
        border: Border.all(color: MeshPalette.line),
        borderRadius: BorderRadius.circular(MeshRadii.xs),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 22,
            child: Text(
              '$rank',
              style: TextStyle(
                color: MeshPalette.ink3,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? l10n.routes_repeaterWithId(id),
                  style: TextStyle(
                    color: MeshPalette.ink,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.routes_nearbyDetail(
                    heard.count,
                    l10n.routes_minutesAgo(minutesAgo),
                  ),
                  style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'SNR ${snr.toStringAsFixed(1)} dB',
                style: MeshTheme.mono(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              // The title already shows the ID when the name is unknown.
              if (name != null)
                Text(
                  id,
                  style: MeshTheme.mono(fontSize: 11, color: MeshPalette.ink3),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
