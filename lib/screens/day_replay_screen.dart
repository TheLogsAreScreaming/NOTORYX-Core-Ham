import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/day_replay.dart';
import '../services/map_tile_cache_service.dart';
import '../services/position_history_service.dart';
import '../theme/okabe_ito.dart';
import 'map_screen.dart' show parseMarkerText;

/// Team position posts (shared markers flagged `t`) in every chat the
/// radio holds.
List<({String sender, double lat, double lon, DateTime at})> teamPositionPosts(
  MeshCoreConnector c,
) {
  final self = c.selfName ?? 'Me';
  final posts = <({String sender, double lat, double lon, DateTime at})>[];
  void add(String sender, String text, DateTime at) {
    final m = parseMarkerText(text);
    if (m == null || !m.flags.split('').contains('t')) return;
    final name = m.label.isNotEmpty ? m.label : sender;
    posts.add((
      sender: name,
      lat: m.position.latitude,
      lon: m.position.longitude,
      at: at,
    ));
  }

  for (final contact in c.contacts) {
    for (final m in c.getMessages(contact)) {
      add(m.isOutgoing ? self : contact.name, m.text, m.timestamp);
    }
  }
  for (final channel in c.channels.where((ch) => !ch.isEmpty)) {
    for (final m in c.getChannelMessages(channel)) {
      add(m.isOutgoing ? self : m.senderName, m.text, m.timestamp);
    }
  }
  return posts;
}

/// Plays back where the team (or every node) was over one day, on the map
/// with a time scrubber, and in words below it.
class DayReplayScreen extends StatefulWidget {
  const DayReplayScreen({
    super.key,
    this.tracks,
    this.showMap = true,
    this.now,
  });

  /// For tests; read from the radio and position history otherwise.
  final List<ReplayTrack>? tracks;
  final bool showMap;
  final DateTime Function()? now;

  /// Replayed minutes per real second.
  static const speeds = [1, 5, 15, 60];

  @override
  State<DayReplayScreen> createState() => _DayReplayScreenState();
}

class _DayReplayScreenState extends State<DayReplayScreen> {
  static const _tick = Duration(milliseconds: 250);

  late DateTime _day;
  bool _everyone = false;
  DateTime? _time;
  bool _playing = false;
  int _speed = 5;
  final Set<String> _hidden = {};
  Timer? _timer;

  DateTime _today() {
    final n = (widget.now ?? DateTime.now)();
    return DateTime(n.year, n.month, n.day);
  }

  @override
  void initState() {
    super.initState();
    _day = _today();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  List<ReplayTrack> _allTracks() {
    final given = widget.tracks;
    if (given != null) return given;
    final c = context.watch<MeshCoreConnector>();
    final history = context.watch<PositionHistoryService>();
    return [...teamTracks(teamPositionPosts(c)), ...history.tracks()];
  }

  ({DateTime start, DateTime end}) _bounds(List<ReplayTrack> shown) {
    final span = replaySpan(shown);
    if (span != null) return span;
    return (start: _day, end: _day.add(const Duration(days: 1)));
  }

  void _togglePlay(({DateTime start, DateTime end}) bounds) {
    if (_playing) {
      _timer?.cancel();
      setState(() => _playing = false);
      return;
    }
    if (!(_time ?? bounds.start).isBefore(bounds.end)) _time = bounds.start;
    setState(() => _playing = true);
    _timer = Timer.periodic(_tick, (_) {
      if (!mounted) return;
      final step = Duration(
        seconds: _speed * 60 * _tick.inMilliseconds ~/ 1000,
      );
      final next = (_time ?? bounds.start).add(step);
      setState(() {
        if (next.isBefore(bounds.end)) {
          _time = next;
        } else {
          _time = bounds.end;
          _playing = false;
          _timer?.cancel();
        }
      });
    });
  }

  void _pickDay(DateTime day) {
    _timer?.cancel();
    setState(() {
      _day = day;
      _time = null;
      _playing = false;
    });
  }

  Color _colorFor(int i) =>
      OkabeIto.categorical[i % OkabeIto.categorical.length];

  String _initials(String name) {
    final words = name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
    return words.take(2).map((w) => w.characters.first.toUpperCase()).join();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toString();
    final all = _allTracks();
    final days = {_today(), ...replayDays(all)}.toList()
      ..sort((a, b) => b.compareTo(a));
    final ofDay = [
      for (final t in all)
        if (_everyone || t.team) ?t.onDay(_day),
    ];
    final shown = ofDay.where((t) => !_hidden.contains(t.id)).toList();
    final bounds = _bounds(ofDay);
    final time = _time ?? bounds.end;
    final clock = DateFormat.jm(locale);
    final dayFormat = DateFormat.yMMMEd(locale);
    final timeText = clock.format(time);
    final present = [
      for (final t in shown)
        if (t.at(time) != null) t,
    ];
    final totalMs = bounds.end.difference(bounds.start).inMilliseconds;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.replay_title)),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: DropdownButtonFormField<DateTime>(
              key: const ValueKey('replay-day'),
              initialValue: _day,
              isExpanded: true,
              decoration: InputDecoration(labelText: l10n.replay_day),
              items: [
                for (final d in days)
                  DropdownMenuItem(value: d, child: Text(dayFormat.format(d))),
              ],
              onChanged: (d) {
                if (d != null) _pickDay(d);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SegmentedButton<bool>(
              segments: [
                ButtonSegment(value: false, label: Text(l10n.replay_team)),
                ButtonSegment(value: true, label: Text(l10n.replay_everyone)),
              ],
              selected: {_everyone},
              onSelectionChanged: (s) => setState(() {
                _everyone = s.first;
                _time = null;
              }),
            ),
          ),
          if (ofDay.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _everyone ? l10n.replay_emptyEveryone : l10n.replay_emptyTeam,
              ),
            )
          else ...[
            if (widget.showMap)
              Semantics(
                label: l10n.replay_mapSummary(timeText, present.length),
                excludeSemantics: true,
                child: SizedBox(height: 320, child: _map(ofDay, shown, time)),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Text(
                timeText,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Slider(
              key: const ValueKey('replay-scrubber'),
              value: totalMs == 0
                  ? 0
                  : time.difference(bounds.start).inMilliseconds / totalMs,
              semanticFormatterCallback: (_) => timeText,
              label: timeText,
              onChanged: totalMs == 0
                  ? null
                  : (v) => setState(() {
                      _time = bounds.start.add(
                        Duration(milliseconds: (v * totalMs).round()),
                      );
                    }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  IconButton(
                    key: const ValueKey('replay-play'),
                    tooltip: _playing ? l10n.replay_pause : l10n.replay_play,
                    icon: Icon(_playing ? Icons.pause : Icons.play_arrow),
                    onPressed: totalMs == 0 ? null : () => _togglePlay(bounds),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      initialValue: _speed,
                      isExpanded: true,
                      decoration: InputDecoration(labelText: l10n.replay_speed),
                      items: [
                        for (final s in DayReplayScreen.speeds)
                          DropdownMenuItem(
                            value: s,
                            child: Text(l10n.replay_speedValue(s)),
                          ),
                      ],
                      onChanged: (s) => setState(() => _speed = s ?? _speed),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                children: [
                  for (var i = 0; i < ofDay.length; i++)
                    FilterChip(
                      avatar: CircleAvatar(
                        backgroundColor: _colorFor(i),
                        child: Text(
                          _initials(ofDay[i].name),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      label: Text(ofDay[i].name),
                      tooltip: l10n.replay_showNode(ofDay[i].name),
                      selected: !_hidden.contains(ofDay[i].id),
                      onSelected: (on) => setState(() {
                        on
                            ? _hidden.remove(ofDay[i].id)
                            : _hidden.add(ofDay[i].id);
                      }),
                    ),
                ],
              ),
            ),
            for (final t in shown) _whereabouts(l10n, clock, t, time),
          ],
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              l10n.replay_explainer,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _whereabouts(
    AppLocalizations l10n,
    DateFormat clock,
    ReplayTrack t,
    DateTime time,
  ) {
    final p = t.at(time);
    return ListTile(
      dense: true,
      leading: Icon(t.team ? Icons.groups_outlined : Icons.cell_tower_rounded),
      title: Text(t.name),
      subtitle: Text(
        p == null
            ? l10n.replay_notYet
            : l10n.replay_lastSeen(
                clock.format(p.at),
                p.lat.toStringAsFixed(5),
                p.lon.toStringAsFixed(5),
              ),
      ),
    );
  }

  Widget _map(List<ReplayTrack> ofDay, List<ReplayTrack> shown, DateTime t) {
    final points = [
      for (final track in ofDay)
        for (final p in track.points) LatLng(p.lat, p.lon),
    ];
    final fit = points.length < 2
        ? null
        : CameraFit.coordinates(
            coordinates: points,
            padding: const EdgeInsets.all(32),
            maxZoom: 15,
          );
    return FlutterMap(
      key: ValueKey('replay-map-$_day-$_everyone'),
      options: MapOptions(
        initialCenter: points.first,
        initialZoom: 13,
        initialCameraFit: fit,
        interactionOptions: const InteractionOptions(
          flags: ~InteractiveFlag.rotate,
        ),
      ),
      children: [
        context.read<MapTileCacheService>().buildTileLayer(context),
        PolylineLayer(
          polylines: [
            for (final track in shown)
              Polyline(
                points: [
                  for (final p in track.trailUntil(t)) LatLng(p.lat, p.lon),
                ],
                strokeWidth: 3,
                color: _colorFor(ofDay.indexOf(track)),
              ),
          ],
        ),
        MarkerLayer(
          markers: [
            for (final track in shown)
              if (track.at(t) case final p?)
                Marker(
                  point: LatLng(p.lat, p.lon),
                  width: 120,
                  height: 44,
                  child: Column(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: _colorFor(ofDay.indexOf(track)),
                      ),
                      Text(
                        track.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                          backgroundColor: Color(0xCCFFFFFF),
                        ),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ],
    );
  }
}
