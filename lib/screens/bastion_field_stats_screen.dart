import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../l10n/l10n.dart';

class BastionFieldStatsScreen extends StatelessWidget {
  const BastionFieldStatsScreen({super.key});

  static const _cyan = Color(0xFF8AB6AA);
  static const _bg = Color(0xFF182126);
  static const _panel = Color(0xFF202D33);

  @override
  Widget build(BuildContext context) {
    final connector = context.watch<MeshCoreConnector>();
    final contacts = connector.contacts;
    final now = DateTime.now();

    final repeaters = contacts.where((c) => c.type == advTypeRepeater).length;
    final rooms = contacts.where((c) => c.type == advTypeRoom).length;
    final sensors = contacts.where((c) => c.type == advTypeSensor).length;
    final chats = contacts.where((c) => c.type == advTypeChat).length;
    final located = contacts.where((c) => c.hasLocation).length;
    final favorites = contacts.where((c) => c.isFavorite).length;
    final recent = contacts
        .where((c) => now.difference(c.lastSeen).inMinutes <= 60)
        .length;
    final routed = contacts
        .where((c) => c.pathLength > 0 || c.path.isNotEmpty)
        .length;
    final direct = contacts.where((c) => c.pathLength == 0).length;
    final flood = contacts.where((c) => c.pathLength < 0).length;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Color(0xFFE4E6DF),
        title: Text(
          l10n.fieldStats_title,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
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
                  l10n.fieldStats_snapshot,
                  style: const TextStyle(
                    color: _cyan,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.fieldStats_headline,
                  style: const TextStyle(
                    color: Color(0xFFE4E6DF),
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.fieldStats_body,
                  style: const TextStyle(color: Color(0xFFCED8D2), height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _grid([
            [l10n.fieldStats_total, '${contacts.length}'],
            [l10n.bastion_active1h, '$recent'],
            [l10n.bastion_repeaters, '$repeaters'],
            [l10n.fieldStats_chatNodes, '$chats'],
            [l10n.fieldStats_rooms, '$rooms'],
            [l10n.fieldStats_sensors, '$sensors'],
            [l10n.fieldStats_located, '$located'],
            [l10n.fieldStats_favorites, '$favorites'],
          ]),
          const SizedBox(height: 18),
          _Title(l10n.fieldStats_routeSnapshot),
          const SizedBox(height: 8),
          _grid([
            [l10n.fieldStats_routed, '$routed'],
            [l10n.fieldStats_direct, '$direct'],
            [l10n.fieldStats_flood, '$flood'],
            ['GPS', '$located'],
          ]),
          const SizedBox(height: 18),
          _Panel(
            Icons.route_rounded,
            l10n.fieldStats_pathIntel,
            l10n.fieldStats_pathIntelBody,
          ),
          const SizedBox(height: 10),
          _Panel(
            Icons.map_rounded,
            l10n.fieldStats_coverageSessions,
            l10n.fieldStats_coverageSessionsBody,
          ),
        ],
      ),
    );
  }

  Widget _grid(List<List<String>> values) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.8,
      ),
      itemCount: values.length,
      itemBuilder: (_, i) {
        return Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: const Color(0xFF1C272D),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF36474E)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                values[i][1],
                style: const TextStyle(
                  color: Color(0xFFE4E6DF),
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                values[i][0],
                style: const TextStyle(
                  color: _cyan,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Title extends StatelessWidget {
  final String text;
  const _Title(this.text);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      color: Color(0xFF8AB6AA),
      fontSize: 11,
      fontWeight: FontWeight.w900,
      letterSpacing: 1.3,
    ),
  );
}

class _Panel extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  const _Panel(this.icon, this.title, this.body);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFF1C272D),
      borderRadius: BorderRadius.circular(15),
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
