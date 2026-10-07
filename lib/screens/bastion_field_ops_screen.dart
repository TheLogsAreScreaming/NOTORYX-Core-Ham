import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../connector/meshcore_connector.dart';
import '../models/field_ops.dart';
import '../services/coverage_capture_service.dart';
import '../services/app_settings_service.dart';
import '../services/field_ops_service.dart';
import '../services/map_tile_cache_service.dart';
import '../services/notification_service.dart';
import 'bastion_coverage_capture_screen.dart';
import 'bastion_diagnostics_screen.dart';
import 'bastion_path_hub_screen.dart';
import 'bot_settings_screen.dart';
import 'map_cache_screen.dart';
import 'scanner_screen.dart';

class BastionFieldOpsScreen extends StatefulWidget {
  const BastionFieldOpsScreen({super.key, this.initialCheckIn = false});
  final bool initialCheckIn;
  @override
  State<BastionFieldOpsScreen> createState() => _FieldOpsState();
}

class _FieldOpsState extends State<BastionFieldOpsScreen> {
  final CoverageCaptureService _coverage = CoverageCaptureService();
  String _search = '', _kind = 'all';
  String? _firstSession, _secondSession;
  CachedTileInventory? _inventory;
  String? _cacheError;
  ({int expected, int available})? _region;
  String _regionLabel = "Select an area and zoom levels in Offline maps.";
  bool _loadingMaps = false;
  @override
  void initState() {
    super.initState();
    unawaited(_loadCoverage());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_loadMaps());
      if (mounted && widget.initialCheckIn) {
        unawaited(_checkIn(context.read<FieldOpsService>(), "I'm OK"));
      }
    });
  }

  Future<void> _loadCoverage() async {
    await _coverage.loadHistory();
    if (!_coverage.history.any((s) => s.id == _firstSession)) {
      _firstSession = null;
    }
    if (!_coverage.history.any((s) => s.id == _secondSession)) {
      _secondSession = null;
    }
    if (mounted) setState(() {});
  }

  Future<void> _loadMaps() async {
    if (!mounted || _loadingMaps) return;
    setState(() {
      _loadingMaps = true;
      _cacheError = null;
      _region = null;
    });
    try {
      _inventory = await context
          .read<MapTileCacheService>()
          .getCachedTileInventory();
      if (!mounted) return;
      final settings = context.read<AppSettingsService>().settings;
      final bounds = MapTileCacheService.boundsFromJson(
        settings.mapCacheBounds,
      );
      if (bounds != null) {
        final cache = context.read<MapTileCacheService>();
        _regionLabel =
            '${cache.source.label} • zoom ${settings.mapCacheMinZoom}–${settings.mapCacheMaxZoom}';
        _region = await cache.verifyOfflineRegion(
          bounds: bounds,
          minZoom: settings.mapCacheMinZoom,
          maxZoom: settings.mapCacheMaxZoom,
        );
      } else {
        _regionLabel = 'Select an area and zoom levels in Offline maps.';
      }
    } catch (e) {
      _cacheError = 'Map area could not be verified: $e';
    }
    if (mounted) setState(() => _loadingMaps = false);
  }

  @override
  void dispose() {
    _coverage.dispose();
    super.dispose();
  }

  Future<void> _perform(Future<void> Function() action) async {
    try {
      await action();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  void _open(Widget screen) =>
      Navigator.push(context, MaterialPageRoute<void>(builder: (_) => screen));
  Widget _card(String title, List<Widget> children) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    ),
  );
  Widget _page(List<Widget> children) =>
      ListView(padding: const EdgeInsets.all(12), children: children);

  @override
  Widget build(BuildContext context) {
    final ops = context.watch<FieldOpsService>();
    final radio = context.watch<MeshCoreConnector>();
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bastion Field Operations'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'TRIP'),
              Tab(text: 'READY'),
              Tab(text: 'LOG'),
              Tab(text: 'AUTO'),
              Tab(text: 'COVERAGE'),
              Tab(text: 'CONNECTION'),
            ],
          ),
        ),
        body: !ops.ready
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  if (ops.error != null)
                    MaterialBanner(
                      content: Text(ops.error!),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              _open(const BastionDiagnosticsScreen()),
                          child: const Text('Diagnostics'),
                        ),
                      ],
                    ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _trip(ops, radio),
                        _readiness(ops, radio),
                        _log(ops),
                        _automations(ops),
                        _coveragePage(),
                        _connection(ops, radio),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _trip(FieldOpsService ops, MeshCoreConnector radio) => _page([
    _card(ops.trip.name, [
      Text(
        ops.trip.active
            ? 'Trip active • ${ops.trip.members.length} contacts'
            : 'Trip stopped. Start it when you are ready.',
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          OutlinedButton.icon(
            onPressed: ops.busy ? null : () => _editTrip(ops),
            icon: const Icon(Icons.edit),
            label: const Text('Plan trip'),
          ),
          FilledButton.icon(
            onPressed: ops.busy || ops.error != null
                ? null
                : () => _perform(ops.trip.active ? ops.endTrip : ops.startTrip),
            icon: Icon(
              ops.trip.active ? Icons.stop_circle_outlined : Icons.play_arrow,
            ),
            label: Text(ops.trip.active ? 'End trip' : 'Start trip'),
          ),
          OutlinedButton.icon(
            onPressed: () => _shareTripBrief(ops),
            icon: const Icon(Icons.description_outlined),
            label: const Text('Trip brief'),
          ),
          OutlinedButton.icon(
            onPressed: () => _open(const ScannerScreen()),
            icon: const Icon(Icons.bluetooth),
            label: const Text('Connect radio'),
          ),
        ],
      ),
    ]),
    _card('Previewed check-ins', [
      const Text(
        'Choose a status, review the actual recipients and message, then send. Queued does not mean delivered.',
      ),
      const SizedBox(height: 10),
      if (_checkInReason(ops, radio) case final reason?)
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(reason, style: Theme.of(context).textTheme.bodyMedium),
        ),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final label in ["I'm OK", 'At Camp', 'Delayed', 'Heading Back'])
            FilledButton.tonal(
              onPressed: _checkInReason(ops, radio) != null
                  ? null
                  : () => _checkIn(ops, label),
              child: Text(label),
            ),
        ],
      ),
      if (ops.busy) const LinearProgressIndicator(),
    ]),
    _card('Trip roster', [
      if (ops.trip.members.isEmpty)
        const Text('Choose up to six known chat contacts in Plan trip.'),
      for (final key in ops.trip.members) _memberTile(ops, key),
      const Text(
        'Last heard is evidence of past activity. It does not establish current reachability. Overdue badges mean no recent contact activity, not a confirmed emergency.',
      ),
    ]),
    _tripMap(ops),
    _card('Offline maps', [
      Text(
        _cacheError ??
            (_inventory == null
                ? 'Checking saved tiles…'
                : '${_inventory!.tiles.length} cached tiles. This does not guarantee your entire route is covered.'),
      ),
      TextButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (_) => const MapCacheScreen()),
          );
          await _loadMaps();
        },
        child: const Text('Download / inspect offline areas'),
      ),
    ]),
  ]);

  String? _checkInReason(FieldOpsService ops, MeshCoreConnector radio) =>
      checkInUnavailableReason(
        ready: ops.ready,
        storageError: ops.error != null,
        active: ops.trip.active,
        connected: radio.isConnected,
        busy: ops.busy,
        selectedContacts: ops.trip.members.length,
        availableContacts: ops.members.length,
      );

  Widget _memberTile(FieldOpsService ops, String key) {
    final matches = ops.members.where((c) => c.publicKeyHex == key);
    if (matches.isEmpty) {
      return const ListTile(
        leading: Icon(Icons.person_off),
        title: Text('Selected contact unavailable'),
        subtitle: Text('Review this trip before sending.'),
      );
    }
    final c = matches.first;
    final activity = c.lastMessageAt.isAfter(c.lastSeen)
        ? c.lastMessageAt
        : c.lastSeen;
    final minutes = DateTime.now()
        .difference(activity)
        .inMinutes
        .clamp(0, 1000000);
    final overdue = minutes >= ops.trip.overdueMinutes;
    final incoming = ops.entries.where(
      (e) => e.kind == 'received' && e.contactKey == key,
    );
    return ListTile(
      leading: Icon(overdue ? Icons.schedule : Icons.person_outline),
      title: Text(c.name),
      subtitle: Text(
        'Last activity ${minutes}m ago${overdue ? ' • overdue' : ''}\n${incoming.isEmpty ? 'No check-in recorded in this log.' : incoming.first.text}',
      ),
      isThreeLine: true,
    );
  }

  Widget _tripMap(FieldOpsService ops) {
    final positioned = ops.members.where((c) => c.hasLocation).toList();
    if (positioned.isEmpty) {
      return _card('Trip map', [
        const Text('No selected contacts have advertised coordinates yet.'),
      ]);
    }
    return _card('Last advertised positions', [
      const Text(
        'Positions can be stale. This map does not track phone GPS or prove members are currently here.',
      ),
      const SizedBox(height: 8),
      SizedBox(
        height: 260,
        child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(
              positioned.first.latitude!,
              positioned.first.longitude!,
            ),
            initialZoom: 11,
          ),
          children: [
            context.read<MapTileCacheService>().buildTileLayer(context),
            MarkerLayer(
              markers: [
                for (final c in positioned)
                  Marker(
                    point: LatLng(c.latitude!, c.longitude!),
                    width: 110,
                    height: 60,
                    child: Column(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        Text(
                          c.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  'Map data © OpenStreetMap contributors; tiles by selected provider',
                ),
              ],
            ),
          ],
        ),
      ),
    ]);
  }

  Future<void> _shareTripBrief(FieldOpsService ops) async {
    final brief = tripBrief(ops.trip, {
      for (final contact in ops.members) contact.publicKeyHex: contact.name,
    });
    final share = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Preview Trip Brief'),
        content: SizedBox(
          width: 420,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Includes trip and contact names. Review before sharing. Coordinates, keys and message history are omitted.',
                ),
                const SizedBox(height: 16),
                SelectableText(brief),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Close'),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.pop(ctx, true),
            icon: const Icon(Icons.share_outlined),
            label: const Text('Share brief'),
          ),
        ],
      ),
    );
    if (share != true || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    await _perform(() async {
      await SharePlus.instance.share(
        ShareParams(
          text: brief,
          subject: 'Bastion Trip Brief',
          sharePositionOrigin: box == null
              ? null
              : box.localToGlobal(Offset.zero) & box.size,
        ),
      );
    });
  }

  Future<void> _editTrip(FieldOpsService ops) async {
    final name = TextEditingController(text: ops.trip.name);
    final selected = ops.trip.members.toSet();
    var location = ops.trip.shareLocation, battery = ops.trip.shareBattery;
    var overdue = ops.trip.overdueMinutes;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Plan trip'),
          content: SizedBox(
            width: 420,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: name,
                    maxLength: 48,
                    decoration: const InputDecoration(labelText: 'Trip name'),
                  ),
                  SwitchListTile(
                    title: const Text('Include advertised radio position'),
                    subtitle: const Text(
                      'May be stale; sharing is off by default.',
                    ),
                    value: location,
                    onChanged: (v) => setDialogState(() => location = v),
                  ),
                  SwitchListTile(
                    title: const Text('Include radio battery'),
                    value: battery,
                    onChanged: (v) => setDialogState(() => battery = v),
                  ),
                  DropdownButtonFormField<int>(
                    initialValue: overdue,
                    decoration: const InputDecoration(
                      labelText: 'Activity overdue after',
                    ),
                    items: {15, 30, 60, 120, 240, 1440, overdue}
                        .toList()
                        .map(
                          (n) => DropdownMenuItem(
                            value: n,
                            child: Text('$n minutes'),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setDialogState(() => overdue = v);
                    },
                  ),
                  const SizedBox(height: 12),
                  const Text('Select up to six known chat contacts'),
                  for (final c in ops.eligibleContacts)
                    CheckboxListTile(
                      title: Text(c.name),
                      value: selected.contains(c.publicKeyHex),
                      onChanged: (v) => setDialogState(() {
                        if (v == true && selected.length < 6) {
                          selected.add(c.publicKeyHex);
                        } else if (v == false) {
                          selected.remove(c.publicKeyHex);
                        }
                      }),
                    ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                await ops.configureTrip(
                  ops.trip.copyWith(
                    name: name.text.trim().isEmpty
                        ? 'My trip'
                        : name.text.trim(),
                    members: selected.toList(),
                    shareLocation: location,
                    shareBattery: battery,
                    overdueMinutes: overdue,
                  ),
                );
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
    name.dispose();
  }

  Future<void> _checkIn(FieldOpsService ops, String label) async {
    final text = ops.previewCheckIn(label);
    final approved = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Send check-in?'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('To: ${ops.members.map((c) => c.name).join(', ')}'),
              const SizedBox(height: 12),
              SelectableText(text),
              const SizedBox(height: 12),
              const Text(
                'This uses normal direct-message sends. Delivery will be tracked in Field Log.',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Send'),
          ),
        ],
      ),
    );
    if (approved == true) await _perform(() => ops.sendCheckIn(text));
  }

  Widget _readiness(FieldOpsService ops, MeshCoreConnector radio) => _page([
    _card('Before you leave', [
      _readyRow(
        radio.isConnected,
        'Radio connected',
        radio.isConnected
            ? '${radio.deviceDisplayName} • ${radio.activeTransport.name}'
            : 'Connect with Bluetooth, USB or TCP.',
      ),
      _readyRow(
        radio.batteryPercent != null && radio.batteryPercent! >= 30,
        'Radio battery',
        radio.batteryPercent == null
            ? 'Unknown; inspect the radio.'
            : '${radio.batteryPercent}% • charge for your planned trip.',
      ),
      _readyRow(
        ops.trip.members.isNotEmpty &&
            ops.members.length == ops.trip.members.length,
        'Trip contacts',
        '${ops.members.length}/${ops.trip.members.length} available. Check they have compatible radios and channels.',
      ),
      _readyRow(
        !_loadingMaps &&
            _region != null &&
            _region!.available == _region!.expected,
        'Selected offline map area',
        _cacheError ??
            (_loadingMaps
                ? 'Checking local files…'
                : _region == null
                ? _regionLabel
                : '$_regionLabel\n${_region!.available}/${_region!.expected} tile files available; ${_region!.expected - _region!.available} missing. This is a snapshot; open the area offline before leaving.'),
      ),
      _readyRow(
        !ops.trip.shareLocation ||
            usablePosition(radio.selfLatitude, radio.selfLongitude),
        'Location-sharing choice',
        ops.trip.shareLocation
            ? 'Opted in: radio advertised coordinates may be stale.'
            : 'Sharing is off. Your check-ins omit coordinates.',
      ),
      _readyRow(
        !ops.automationEnabled || ops.foreground,
        'Automation availability',
        'Runs only while this app is active. Sleep, closure or loss of radio can prevent scheduled actions.',
      ),
      const Divider(),
      const Text(
        'Readiness checks are advisory; they do not prove radio range or guarantee message delivery.',
      ),
      Wrap(
        spacing: 8,
        children: [
          TextButton(
            onPressed: () => _open(const ScannerScreen()),
            child: const Text('Radio'),
          ),
          TextButton(
            onPressed: () => _open(const MapCacheScreen()),
            child: const Text('Offline maps'),
          ),
          TextButton(
            onPressed: _loadingMaps ? null : _loadMaps,
            child: const Text('Refresh checks'),
          ),
        ],
      ),
    ]),
  ]);
  Widget _readyRow(bool good, String title, String detail) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Icon(
      good ? Icons.check_circle_outline : Icons.info_outline,
      color: good
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.secondary,
    ),
    title: Text(title),
    subtitle: Text(detail),
  );

  Widget _log(FieldOpsService ops) {
    final rows = ops.entries
        .where(
          (e) =>
              (_kind == 'all' || e.kind == _kind) &&
              '${e.text} ${e.kind} ${e.contactKey ?? ''} ${e.tripName ?? ''}'
                  .toLowerCase()
                  .contains(_search.toLowerCase()),
        )
        .toList();
    return _page([
      TextField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          labelText: 'Search Field Log',
        ),
        onChanged: (v) => setState(() => _search = v),
      ),
      const SizedBox(height: 10),
      Wrap(
        spacing: 8,
        children: [
          for (final kind in [
            'all',
            'check-in',
            'received',
            'note',
            'dead-zone',
            'radio',
            'automation',
            'missed',
          ])
            ChoiceChip(
              label: Text(kind),
              selected: _kind == kind,
              onSelected: (_) => setState(() => _kind = kind),
            ),
        ],
      ),
      Wrap(
        spacing: 8,
        children: [
          TextButton.icon(
            onPressed: () => _note(ops),
            icon: const Icon(Icons.add),
            label: const Text('Add note'),
          ),
          TextButton.icon(
            onPressed: () => _perform(() async {
              await SharePlus.instance.share(
                ShareParams(
                  text: ops.exportLog(),
                  subject: 'Bastion Field Log',
                ),
              );
            }),
            icon: const Icon(Icons.share),
            label: const Text('Export JSON'),
          ),
          TextButton(
            onPressed: () => _clear(ops),
            child: const Text('Delete log'),
          ),
        ],
      ),
      const Text(
        'Stored locally, up to 1,000 entries. Exports may contain contact keys, messages and locations; review before sharing.',
      ),
      const SizedBox(height: 12),
      if (rows.isEmpty) const Text('No matching entries.'),
      for (final e in rows)
        Card(
          child: ListTile(
            title: Text(e.text),
            subtitle: Text(
              '${e.at.toLocal()} • ${e.kind} • ${e.tripName ?? 'Trip unspecified'}${e.status == null ? '' : '\n${e.status}: ${explainMessageStatus(e.status!)}'}${e.latitude == null ? '' : '\nRecorded radio-advertised position ${e.latitude}, ${e.longitude} (may be stale)'}',
            ),
          ),
        ),
    ]);
  }

  Future<void> _note(FieldOpsService ops) async {
    final text = TextEditingController();
    var deadZone = false;
    var includePosition = false;
    final radio = context.read<MeshCoreConnector>();
    final lat = radio.selfLatitude, lon = radio.selfLongitude;
    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Field observation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: text,
                maxLength: 500,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'What did you observe?',
                ),
              ),
              SwitchListTile(
                title: const Text('Reported dead zone'),
                subtitle: const Text(
                  'Your observation, not a verified coverage prediction.',
                ),
                value: deadZone,
                onChanged: (v) => setDialogState(() => deadZone = v),
              ),
              SwitchListTile(
                title: const Text('Save radio-advertised position'),
                subtitle: Text(
                  usablePosition(lat, lon)
                      ? '$lat, $lon • may be stale; not phone GPS'
                      : 'No usable advertised coordinates',
                ),
                value: includePosition,
                onChanged: usablePosition(lat, lon)
                    ? (v) => setDialogState(() => includePosition = v)
                    : null,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                if (text.text.trim().isEmpty) return;
                await ops.record(
                  deadZone ? 'dead-zone' : 'note',
                  text.text.trim(),
                  latitude: includePosition ? lat : null,
                  longitude: includePosition ? lon : null,
                );
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
    text.dispose();
  }

  Future<void> _clear(FieldOpsService ops) async {
    final yes = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Field Log?'),
        content: const Text(
          'This removes all saved entries on this phone. Trip settings are kept.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (yes == true) await ops.clearLog();
  }

  Widget _automations(FieldOpsService ops) => _page([
    _card('Local automations', [
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Enable for this trip'),
        value: ops.automationEnabled,
        onChanged: (v) => _perform(() => ops.enableAutomations(v)),
      ),
      const Text(
        'Starts off after every app restart. Rules run only while the app is active. Missed scheduled actions appear in Field Log and are never replayed in a burst. Automatic check-ins are limited to one batch per 10 minutes.',
      ),
      TextButton(
        onPressed: () => _open(const BotSettingsScreen()),
        child: const Text('Open Bastion Bot Mode'),
      ),
    ]),
    for (final rule in ops.rules)
      _card(_triggerLabel(rule.trigger), [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Rule enabled'),
          value: rule.enabled,
          onChanged: (v) => ops.configureRule(rule.copyWith(enabled: v)),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Dry run'),
          subtitle: const Text(
            'Record the action without sending or notifying.',
          ),
          value: rule.dryRun,
          onChanged: (v) => ops.configureRule(rule.copyWith(dryRun: v)),
        ),
        DropdownButtonFormField<FieldAction>(
          key: ValueKey('${rule.id}_${rule.action}'),
          initialValue: rule.action,
          decoration: const InputDecoration(labelText: 'THEN'),
          items: FieldAction.values
              .map(
                (a) => DropdownMenuItem(
                  value: a,
                  child: Text(switch (a) {
                    FieldAction.log => 'Write to Field Log',
                    FieldAction.notify => 'Show local notification',
                    FieldAction.checkIn => "Send I'm OK to trip contacts",
                  }),
                ),
              )
              .toList(),
          onChanged: (v) {
            if (v != null) ops.configureRule(rule.copyWith(action: v));
          },
        ),
        if (rule.trigger == FieldTrigger.lowBattery)
          DropdownButtonFormField<int>(
            key: ValueKey('${rule.id}_${rule.batteryThreshold}'),
            initialValue: rule.batteryThreshold,
            decoration: const InputDecoration(labelText: 'Battery at or below'),
            items: {5, 10, 15, 20, 30, 40, 50, rule.batteryThreshold}
                .toList()
                .map((n) => DropdownMenuItem(value: n, child: Text('$n%')))
                .toList(),
            onChanged: (v) {
              if (v != null) {
                ops.configureRule(rule.copyWith(batteryThreshold: v));
              }
            },
          ),
        if (rule.trigger == FieldTrigger.scheduled) ...[
          DropdownButtonFormField<int>(
            key: ValueKey('${rule.id}_${rule.intervalMinutes}'),
            initialValue: rule.intervalMinutes,
            decoration: const InputDecoration(labelText: 'Interval'),
            items: {15, 30, 60, 120, 240, 1440, rule.intervalMinutes}
                .toList()
                .map(
                  (n) => DropdownMenuItem(value: n, child: Text('$n minutes')),
                )
                .toList(),
            onChanged: (v) {
              if (v != null) {
                ops.configureRule(rule.copyWith(intervalMinutes: v));
              }
            },
          ),
          Text('Next due: ${rule.nextDue?.toLocal() ?? 'not scheduled'}'),
        ],
        const SizedBox(height: 8),
        if (rule.action == FieldAction.checkIn)
          Text(
            'To: ${ops.members.map((c) => c.name).join(', ')}\n${ops.previewCheckIn("I'm OK")}',
          ),
        Wrap(
          spacing: 8,
          children: [
            TextButton(
              onPressed: () => ops.previewRule(rule),
              child: const Text('Preview in log'),
            ),
            if (rule.action == FieldAction.notify)
              TextButton(
                onPressed: () => _perform(() async {
                  await NotificationService().requestPermissions();
                }),
                child: const Text('Allow notifications'),
              ),
          ],
        ),
      ]),
  ]);
  String _triggerLabel(FieldTrigger t) => switch (t) {
    FieldTrigger.reconnect => 'WHEN radio reconnects',
    FieldTrigger.disconnect => 'WHEN radio disconnects',
    FieldTrigger.lowBattery => 'WHEN radio battery crosses threshold',
    FieldTrigger.newNode => 'WHEN a new node is added',
    FieldTrigger.repeater => 'WHEN a new repeater is added',
    FieldTrigger.scheduled => 'WHEN a scheduled check-in is due',
  };

  Widget _connection(FieldOpsService ops, MeshCoreConnector radio) {
    final pending = ops.entries
        .where(
          (e) =>
              e.kind == 'check-in' &&
              (e.status == 'pending' || e.status == 'sent'),
        )
        .length;
    return _page([
      _card('Explain my connection', [
        Text('State: ${radio.state.name} • ${radio.activeTransport.name}'),
        const SizedBox(height: 8),
        Text(
          radio.isConnected
              ? 'The phone has a radio connection. That alone does not establish a route to your recipients.'
              : 'No active radio connection. Check Bluetooth permissions, radio power and range; USB/TCP are available from Connect radio.',
        ),
        Text('Trip check-ins awaiting confirmation: $pending'),
        for (final status in ['pending', 'sent', 'delivered', 'failed'])
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(status.toUpperCase()),
            subtitle: Text(explainMessageStatus(status)),
          ),
        const Text(
          'Node last-seen times and advertised positions can be stale. Route intelligence shows routes learned from observed attempts; it does not invent paths.',
        ),
        Wrap(
          spacing: 8,
          children: [
            TextButton(
              onPressed: () => _open(const ScannerScreen()),
              child: const Text('Connect radio'),
            ),
            TextButton(
              onPressed: () => _open(const BastionDiagnosticsScreen()),
              child: const Text('Diagnostics'),
            ),
            TextButton(
              onPressed: () => _open(const BastionPathHubScreen()),
              child: const Text('Route intelligence'),
            ),
          ],
        ),
      ]),
    ]);
  }

  Widget _coveragePage() {
    final sessions = _coverage.history;
    CoverageCaptureSession? a, b;
    for (final s in sessions) {
      if (s.id == _firstSession) a = s;
      if (s.id == _secondSession) b = s;
    }
    final keysA = a?.observations.map((o) => o.nodeKey).toSet() ?? <String>{};
    final keysB = b?.observations.map((o) => o.nodeKey).toSet() ?? <String>{};
    final points = <Marker>[];
    void add(CoverageCaptureSession? s, Color color) {
      if (s == null) return;
      for (final o in s.observations) {
        if (usablePosition(o.recorderLatitude, o.recorderLongitude)) {
          points.add(
            Marker(
              point: LatLng(o.recorderLatitude!, o.recorderLongitude!),
              width: 18,
              height: 18,
              child: Tooltip(
                message:
                    '${o.nodeName} • ${o.timestamp.toLocal()}\nHeard-node observation; not proof of a successful link',
                child: Icon(Icons.circle, size: 14, color: color),
              ),
            ),
          );
        }
      }
    }

    add(a, Theme.of(context).colorScheme.primary);
    add(b, Theme.of(context).colorScheme.secondary);
    for (final entry in context.watch<FieldOpsService>().entries) {
      if ((entry.kind == 'note' || entry.kind == 'dead-zone') &&
          usablePosition(entry.latitude, entry.longitude)) {
        points.add(
          Marker(
            point: LatLng(entry.latitude!, entry.longitude!),
            width: 28,
            height: 28,
            child: Tooltip(
              message:
                  '${entry.kind} • ${entry.at.toLocal()}\n${entry.text}\nLocal note at radio-advertised coordinates; may be stale.',
              child: Icon(
                entry.kind == 'dead-zone'
                    ? Icons.warning_amber
                    : Icons.edit_location_alt_outlined,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        );
      }
    }
    return _page([
      _card('Coverage intelligence', [
        const Text(
          'Compare recorded observations between two field sessions. Dots mark recorder radio-advertised positions where nodes were heard. They do not imply continuous coverage. RSSI/SNR snapshots are not per-node measurements.',
        ),
        Wrap(
          spacing: 8,
          children: [
            TextButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => const BastionCoverageCaptureScreen(),
                  ),
                );
                await _loadCoverage();
              },
              child: const Text('Capture a session'),
            ),
            TextButton(
              onPressed: _loadCoverage,
              child: const Text('Refresh history'),
            ),
          ],
        ),
        if (_coverage.loadWarning != null) Text(_coverage.loadWarning!),
        if (sessions.isEmpty) const Text('No saved coverage sessions yet.'),
        for (final slot in [0, 1])
          DropdownButtonFormField<String>(
            key: ValueKey('session_$slot'),
            initialValue: slot == 0 ? _firstSession : _secondSession,
            decoration: InputDecoration(
              labelText: slot == 0 ? 'Session A • teal' : 'Session B • amber',
            ),
            items: sessions
                .map(
                  (s) => DropdownMenuItem(
                    value: s.id,
                    child: Text(
                      '${s.startedAt.toLocal()} • ${s.observations.length} observations',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
                .toList(),
            onChanged: (v) => setState(() {
              if (slot == 0) {
                _firstSession = v;
              } else {
                _secondSession = v;
              }
            }),
          ),
        if (a != null && b != null) ...[
          const SizedBox(height: 12),
          Text(
            'A: ${keysA.length} unique nodes • B: ${keysB.length} unique nodes',
          ),
          Text(
            'Shared: ${keysA.intersection(keysB).length} • Only A: ${keysA.difference(keysB).length} • Only B: ${keysB.difference(keysA).length}',
          ),
          const Text(
            'Not hearing a node during one session does not establish a dead zone. Conditions and observation duration differ.',
          ),
        ],
        if (points.isNotEmpty)
          SizedBox(
            height: 300,
            child: FlutterMap(
              key: ValueKey('$_firstSession/$_secondSession'),
              options: MapOptions(
                initialCenter: points.first.point,
                initialZoom: 12,
              ),
              children: [
                context.read<MapTileCacheService>().buildTileLayer(context),
                MarkerLayer(markers: points),
                const RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      'Map data © OpenStreetMap contributors; tiles by selected provider',
                    ),
                  ],
                ),
              ],
            ),
          ),
      ]),
    ]);
  }
}
