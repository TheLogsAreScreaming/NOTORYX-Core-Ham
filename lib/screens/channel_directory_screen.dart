import 'dart:async';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../helpers/join_channel.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/channel_directory.dart';
import '../services/channel_directory_service.dart';
import '../services/corescope.dart';
import '../theme/mesh_theme.dart';
import '../widgets/ember_backdrop.dart';
import '../widgets/connect_ui.dart';
import '../widgets/mesh_ui.dart';

/// Browse public hashtag channels (local ones near the radio first) and join
/// one with a tap.
class ChannelDirectoryScreen extends StatefulWidget {
  const ChannelDirectoryScreen({super.key, this.service});

  /// Injected in tests; otherwise the screen makes and owns one.
  final ChannelDirectoryService? service;

  @override
  State<ChannelDirectoryScreen> createState() => _ChannelDirectoryScreenState();
}

class _ChannelDirectoryScreenState extends State<ChannelDirectoryScreen> {
  late final ChannelDirectoryService _service =
      widget.service ?? ChannelDirectoryService();
  String _query = '';
  ChannelCategory? _category;
  String? _joining;

  /// Hashtag channels the online analyzer has seen in use; null until
  /// loaded or when it couldn't be reached.
  List<ActiveChannel>? _active;

  @override
  void initState() {
    super.initState();
    _service.addListener(_changed);
    unawaited(_service.load());
    final analyzer = context.read<AnalyzerService?>();
    if (analyzer != null) {
      unawaited(
        analyzer.activeChannels().then((list) {
          if (mounted) setState(() => _active = list);
        }),
      );
    }
  }

  Future<void> _joinName(MeshCoreConnector connector, String name) async {
    setState(() => _joining = name);
    try {
      await joinHashtagChannel(context, connector, name);
    } finally {
      if (mounted) setState(() => _joining = null);
    }
  }

  String _ago(AppLocalizations l10n, DateTime? at) {
    if (at == null) return '';
    final d = DateTime.now().difference(at);
    if (d.inMinutes < 1) return l10n.time_justNow;
    if (d.inHours < 1) return l10n.time_minutesAgo(d.inMinutes);
    if (d.inDays < 1) return l10n.time_hoursAgo(d.inHours);
    return l10n.time_daysAgo(d.inDays);
  }

  void _changed() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _service.removeListener(_changed);
    if (widget.service == null) _service.dispose();
    super.dispose();
  }

  LatLng? _position(MeshCoreConnector connector) {
    final lat = connector.selfLatitude, lon = connector.selfLongitude;
    if (lat == null || lon == null || (lat == 0 && lon == 0)) return null;
    return LatLng(lat, lon);
  }

  Future<void> _join(
    MeshCoreConnector connector,
    ChannelDirectoryEntry e,
  ) async {
    setState(() => _joining = e.name);
    try {
      await joinHashtagChannel(context, connector, e.name);
    } finally {
      if (mounted) setState(() => _joining = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final connector = context.watch<MeshCoreConnector>();
    final joined = {for (final c in connector.channels) c.name};
    final position = _position(connector);
    final filtered = [
      for (final e in _service.entries)
        if ((_category == null || e.category == _category) && e.matches(_query))
          e,
    ];
    final near = position == null
        ? const <ChannelDirectoryEntry>[]
        : channelsNear(filtered, position);
    final rest = [
      for (final e in filtered)
        if (!near.contains(e)) e,
    ];

    final query = _query.trim().toLowerCase();
    final activeShown = [
      for (final a in _active ?? const <ActiveChannel>[])
        if (query.isEmpty || a.name.toLowerCase().contains(query)) a,
    ].take(15).toList();
    Widget tile(ChannelDirectoryEntry e) => Padding(
      key: ValueKey(e.name),
      padding: const EdgeInsets.only(bottom: 10),
      child: _DirectoryTile(
        entry: e,
        joined: joined.contains(e.name),
        joining: _joining == e.name,
        canJoin: connector.isConnected && _joining == null,
        onJoin: () => _join(connector, e),
      ),
    );

    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: Text(l10n.channelDirectory_title),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
              children: [
                TextField(
                  key: const ValueKey('channel-directory-search'),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: l10n.channelDirectory_search,
                  ),
                  textInputAction: TextInputAction.search,
                  onChanged: (v) => setState(() => _query = v),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ChoiceChip(
                      label: Text(l10n.channelDirectory_catAll),
                      selected: _category == null,
                      onSelected: (_) => setState(() => _category = null),
                    ),
                    for (final c in ChannelCategory.values)
                      ChoiceChip(
                        label: Text(categoryLabel(l10n, c)),
                        selected: _category == c,
                        onSelected: (_) => setState(
                          () => _category = _category == c ? null : c,
                        ),
                      ),
                  ],
                ),
                if (!connector.isConnected) ...[
                  const SizedBox(height: 14),
                  ConsolePanel(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: MeshPalette.warn),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            l10n.channelDirectory_connectFirst,
                            style: TextStyle(color: MeshPalette.ink2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 22),
                if (activeShown.isNotEmpty) ...[
                  ConsoleKicker(l10n.activeChannels_title),
                  for (final a in activeShown)
                    ListTile(
                      key: ValueKey('active-${a.name}'),
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.forum_outlined,
                        color: MeshPalette.ink3,
                      ),
                      title: Text(a.name),
                      subtitle: Text(
                        [
                          l10n.activeChannels_messages(a.messages),
                          _ago(l10n, a.lastActivity),
                        ].where((s) => s.isNotEmpty).join(' · '),
                      ),
                      trailing: joined.contains(a.name)
                          ? Text(
                              l10n.channelDirectory_joined,
                              style: TextStyle(color: MeshPalette.ink3),
                            )
                          : TextButton(
                              onPressed:
                                  connector.isConnected && _joining == null
                                  ? () => _joinName(connector, a.name)
                                  : null,
                              child: Text(l10n.channelDirectory_join),
                            ),
                    ),
                  Text(
                    l10n.activeChannels_source(
                      Uri.tryParse(
                            context.read<AnalyzerService?>()?.url ?? '',
                          )?.host ??
                          '',
                    ),
                    style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
                  ),
                  const SizedBox(height: 18),
                ],
                if (near.isNotEmpty) ...[
                  ConsoleKicker(l10n.channelDirectory_nearYou),
                  for (final e in near) tile(e),
                  const SizedBox(height: 12),
                ],
                if (rest.isNotEmpty) ...[
                  ConsoleKicker(
                    _category == null
                        ? l10n.channelDirectory_all
                        : categoryLabel(l10n, _category!),
                  ),
                  for (final e in rest) tile(e),
                ],
                if (filtered.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      l10n.channelDirectory_noMatches,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: MeshPalette.ink3),
                    ),
                  ),
                const SizedBox(height: 12),
                Text(
                  l10n.channelDirectory_addHint,
                  style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Label for a [ChannelCategory] chip or heading.
String categoryLabel(AppLocalizations l10n, ChannelCategory c) => switch (c) {
  ChannelCategory.emergency => l10n.channelDirectory_catEmergency,
  ChannelCategory.local => l10n.channelDirectory_catLocal,
  ChannelCategory.general => l10n.channelDirectory_catGeneral,
  ChannelCategory.interest => l10n.channelDirectory_catInterest,
  ChannelCategory.test => l10n.channelDirectory_catTest,
};

IconData _categoryIcon(ChannelCategory c) => switch (c) {
  ChannelCategory.emergency => Icons.emergency_outlined,
  ChannelCategory.local => Icons.place_outlined,
  ChannelCategory.general => Icons.forum_outlined,
  ChannelCategory.interest => Icons.interests_outlined,
  ChannelCategory.test => Icons.network_check,
};

class _DirectoryTile extends StatelessWidget {
  const _DirectoryTile({
    required this.entry,
    required this.joined,
    required this.joining,
    required this.canJoin,
    required this.onJoin,
  });

  final ChannelDirectoryEntry entry;
  final bool joined;
  final bool joining;
  final bool canJoin;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final emergency = entry.category == ChannelCategory.emergency;
    final iconColor = emergency ? MeshPalette.alert : MeshPalette.accent;
    final Widget action;
    if (joined) {
      action = StatusChip(
        label: l10n.channelDirectory_joined,
        color: MeshPalette.signal,
        icon: Icons.check,
      );
    } else if (joining) {
      action = SizedBox.square(
        dimension: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          color: MeshPalette.accent,
        ),
      );
    } else {
      action = FilledButton.tonal(
        onPressed: canJoin ? onJoin : null,
        child: Text(l10n.channelDirectory_join),
      );
    }
    return ConsolePanel(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(_categoryIcon(entry.category), color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  entry.name,
                  style: TextStyle(
                    color: MeshPalette.ink,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (entry.description.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    entry.description,
                    style: TextStyle(
                      color: MeshPalette.ink2,
                      fontSize: 12.5,
                      height: 1.35,
                    ),
                  ),
                ],
                if (entry.area != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.place, size: 13, color: MeshPalette.ink3),
                      const SizedBox(width: 3),
                      Flexible(
                        child: Text(
                          entry.area!.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: MeshPalette.ink3,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 10),
          action,
        ],
      ),
    );
  }
}
