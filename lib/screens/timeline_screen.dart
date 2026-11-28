import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/timeline.dart';
import '../services/timeline_service.dart';
import '../theme/mesh_theme.dart';
import '../widgets/ember_backdrop.dart';

String timelineKindName(AppLocalizations l10n, TimelineKind k) => switch (k) {
  TimelineKind.message => l10n.timeline_kindMessages,
  TimelineKind.nodeJoined => l10n.timeline_kindNodes,
  TimelineKind.signalChange => l10n.timeline_kindSignal,
  TimelineKind.waypoint => l10n.timeline_kindPlaces,
};

IconData _icon(TimelineEvent e) => switch (e.kind) {
  TimelineKind.message => e.outgoing ? Icons.north_east : Icons.south_west,
  TimelineKind.nodeJoined => Icons.person_add_alt,
  TimelineKind.signalChange =>
    (e.toSnr ?? 0) >= (e.fromSnr ?? 0)
        ? Icons.trending_up
        : Icons.trending_down,
  TimelineKind.waypoint => Icons.place_outlined,
};

/// The headline of one event in words.
String timelineTitle(AppLocalizations l10n, TimelineEvent e) {
  String snr(double? v) => v == null ? '?' : v.toStringAsFixed(1);
  return switch (e.kind) {
    TimelineKind.message => l10n.timeline_messageFrom(e.subject, e.key ?? ''),
    TimelineKind.nodeJoined => l10n.timeline_nodeJoined(e.subject),
    TimelineKind.signalChange =>
      (e.toSnr ?? 0) >= (e.fromSnr ?? 0)
          ? l10n.timeline_signalUp(e.subject, snr(e.fromSnr), snr(e.toSnr))
          : l10n.timeline_signalDown(e.subject, snr(e.fromSnr), snr(e.toSnr)),
    TimelineKind.waypoint =>
      e.detail == null
          ? l10n.timeline_placeSaved(e.subject)
          : l10n.timeline_placeShared(e.subject, e.key ?? ''),
  };
}

/// One filterable feed of messages, nodes showing up, signal changes and
/// places, newest first.
class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  final Set<TimelineKind> _kinds = {...TimelineKind.values};
  String _query = '';
  List<TimelineEvent> _messages = const [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    unawaited(_reload());
  }

  Future<void> _reload() async {
    final service = context.read<TimelineService?>();
    setState(() => _loading = true);
    final messages = await service?.loadMessages() ?? const <TimelineEvent>[];
    if (!mounted) return;
    setState(() {
      _messages = messages;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final service = context.watch<TimelineService?>();
    final locale = Localizations.localeOf(context).toLanguageTag();
    final events = filterTimeline(
      [...?service?.events, ..._messages],
      kinds: _kinds,
      query: _query,
    );
    final dayFormat = DateFormat.yMMMEd(locale);
    final timeFormat = DateFormat.Hm(locale);
    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          foregroundColor: MeshPalette.ink,
          title: Text(l10n.timeline_title),
          actions: [
            IconButton(
              tooltip: l10n.timeline_refresh,
              icon: const Icon(Icons.refresh),
              onPressed: _loading ? null : _reload,
            ),
          ],
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  MeshSpace.lg,
                  MeshSpace.sm,
                  MeshSpace.lg,
                  0,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: l10n.timeline_search,
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: MeshSpace.lg,
                  vertical: MeshSpace.sm,
                ),
                child: Wrap(
                  spacing: MeshSpace.sm,
                  runSpacing: MeshSpace.xs,
                  children: [
                    for (final k in TimelineKind.values)
                      FilterChip(
                        label: Text(timelineKindName(l10n, k)),
                        selected: _kinds.contains(k),
                        onSelected: (on) => setState(
                          () => on ? _kinds.add(k) : _kinds.remove(k),
                        ),
                      ),
                  ],
                ),
              ),
              if (_loading) const LinearProgressIndicator(),
              Expanded(
                child: events.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(MeshSpace.xl),
                          child: Text(
                            _loading ? '' : l10n.timeline_empty,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: MeshPalette.ink2),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: events.length,
                        itemBuilder: (context, i) {
                          final e = events[i];
                          final day = dayFormat.format(e.at);
                          final newDay =
                              i == 0 ||
                              dayFormat.format(events[i - 1].at) != day;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (newDay)
                                Semantics(
                                  header: true,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      MeshSpace.lg,
                                      MeshSpace.md,
                                      MeshSpace.lg,
                                      MeshSpace.xs,
                                    ),
                                    child: Text(
                                      day,
                                      style: TextStyle(
                                        color: MeshPalette.ink3,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ListTile(
                                leading: Icon(
                                  _icon(e),
                                  color: MeshPalette.hue(e.kind.index),
                                  semanticLabel: timelineKindName(l10n, e.kind),
                                ),
                                title: Text(timelineTitle(l10n, e)),
                                subtitle: e.detail == null
                                    ? null
                                    : Text(
                                        e.detail!,
                                        maxLines: 3,
                                        overflow: TextOverflow.fade,
                                      ),
                                trailing: Text(
                                  timeFormat.format(e.at),
                                  style: TextStyle(color: MeshPalette.ink3),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
