import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../helpers/path_helper.dart';
import '../l10n/l10n.dart';
import '../theme/mesh_theme.dart';
import '../widgets/ember_backdrop.dart';

/// Entry for one repeater observed in the hop path of received or outgoing
/// packets — derived entirely from already-stored data, no transmissions.
class _RepEntry {
  final String nameOrHex;
  final double? snr;
  final bool relaysIncoming;
  final bool relaysOutgoing;

  const _RepEntry({
    required this.nameOrHex,
    this.snr,
    required this.relaysIncoming,
    required this.relaysOutgoing,
  });
}

/// Shows which repeaters have been observed relaying packets that
/// involve this device — derived from stored path and advert data.
class WhoRepeatsMeScreen extends StatelessWidget {
  const WhoRepeatsMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final connector = context.watch<MeshCoreConnector>();
    final entries = _buildEntries(connector);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.whoRepeatsMe_title), centerTitle: true),
      body: EmberBackdrop(
        child: entries.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cell_tower,
                        size: 48,
                        color: scheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.whoRepeatsMe_empty,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 88),
                itemCount: entries.length,
                itemBuilder: (context, i) => _RepTile(entry: entries[i]),
              ),
      ),
    );
  }

  List<_RepEntry> _buildEntries(MeshCoreConnector connector) {
    final width = connector.pathHashByteWidth;

    // Map from pubkeyPrefix-hex → mutable entry data.
    final map =
        <
          String,
          ({String nameOrHex, double? snr, bool incoming, bool outgoing})
        >{};

    // 1. Direct repeaters (relayed incoming packets through to our radio).
    for (final dr in connector.directRepeaters) {
      final prefixHex = dr.pubkeyPrefixHex;
      final contact = dr.contactKeyHex != null
          ? connector.contacts
                .where(
                  (c) =>
                      c.publicKeyHex.toLowerCase() ==
                      dr.contactKeyHex!.toLowerCase(),
                )
                .firstOrNull
          : null;
      map[prefixHex] = (
        nameOrHex: contact?.name ?? prefixHex,
        snr: dr.snr,
        incoming: true,
        outgoing: map[prefixHex]?.outgoing ?? false,
      );
    }

    // 2. Contacts whose stored path starts with a known repeater prefix
    //    (that repeater relays our outgoing packets to reach them).
    for (final contact in connector.contacts) {
      if (contact.type == advTypeChat && contact.pathLength > 0) {
        final hops = PathHelper.splitPathBytes(
          contact.pathBytesForDisplay,
          width,
        );
        if (hops.isEmpty) continue;
        final firstHopHex = PathHelper.formatHopHex(hops.first);

        final repeater = connector.contacts
            .where((c) => c.type == advTypeRepeater)
            .where(
              (c) =>
                  c.publicKey.length >= width &&
                  PathHelper.formatHopHex(c.publicKey.sublist(0, width)) ==
                      firstHopHex,
            )
            .firstOrNull;

        final nameOrHex = repeater?.name ?? firstHopHex;
        final existing = map[firstHopHex];
        map[firstHopHex] = (
          nameOrHex: nameOrHex,
          snr: existing?.snr,
          incoming: existing?.incoming ?? false,
          outgoing: true,
        );
      }
    }

    final entries = map.values
        .map(
          (e) => _RepEntry(
            nameOrHex: e.nameOrHex,
            snr: e.snr,
            relaysIncoming: e.incoming,
            relaysOutgoing: e.outgoing,
          ),
        )
        .toList();

    // Both roles first, then incoming-only, then outgoing-only; ties break by SNR.
    entries.sort((a, b) {
      final aScore = (a.relaysIncoming ? 2 : 0) + (a.relaysOutgoing ? 1 : 0);
      final bScore = (b.relaysIncoming ? 2 : 0) + (b.relaysOutgoing ? 1 : 0);
      if (bScore != aScore) return bScore.compareTo(aScore);
      final aSNR = a.snr ?? -999;
      final bSNR = b.snr ?? -999;
      return bSNR.compareTo(aSNR);
    });

    return entries;
  }
}

class _RepTile extends StatelessWidget {
  final _RepEntry entry;

  const _RepTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Row(
          children: [
            Icon(Icons.cell_tower, color: MeshPalette.signal, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.nameOrHex,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: [
                      if (entry.relaysIncoming)
                        _Chip(
                          label: l10n.whoRepeatsMe_inbound,
                          icon: Icons.arrow_downward,
                          color: MeshPalette.signal,
                        ),
                      if (entry.relaysOutgoing)
                        _Chip(
                          label: l10n.whoRepeatsMe_outbound,
                          icon: Icons.arrow_upward,
                          color: MeshPalette.warn,
                        ),
                    ],
                  ),
                  if (entry.snr != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'SNR ${entry.snr!.toStringAsFixed(1)} dB',
                      style: MeshTheme.mono(
                        fontSize: 12,
                        color: MeshPalette.ink3,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _Chip({required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
