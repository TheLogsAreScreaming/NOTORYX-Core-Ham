import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
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
  String? _regionLabel;
  bool _loadingMaps = false;
  @override
  void initState() {
    super.initState();
    unawaited(_loadCoverage());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_loadMaps());
      if (mounted && widget.initialCheckIn) {
        unawaited(_checkIn(context.read<FieldOpsService>(), checkInLabels[0]));
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
      final l10n = context.l10n;
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
        _regionLabel = l10n.fieldOps_regionLabel(
          cache.source.label,
          '${settings.mapCacheMinZoom}',
          '${settings.mapCacheMaxZoom}',
        );
        _region = await cache.verifyOfflineRegion(
          bounds: bounds,
          minZoom: settings.mapCacheMinZoom,
          maxZoom: settings.mapCacheMaxZoom,
        );
      } else {
        _regionLabel = null;
      }
    } catch (e) {
      _cacheError = '$e';
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
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
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
    final l10n = context.l10n;
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.fieldOps_title),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: l10n.fieldOps_tabTrip),
              Tab(text: l10n.fieldOps_tabReady),
              Tab(text: l10n.fieldOps_tabLog),
              Tab(text: l10n.fieldOps_tabAuto),
              Tab(text: l10n.fieldOps_tabCoverage),
              Tab(text: l10n.fieldOps_tabConnection),
            ],
          ),
        ),
        body: !ops.ready
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  if (ops.error != null)
                    MaterialBanner(
                      content: Text(switch (ops.error) {
                        FieldOpsService.loadErrorText =>
                          l10n.fieldOps_storageLoadError,
                        FieldOpsService.saveErrorText =>
                          l10n.fieldOps_storageSaveError,
                        final error => error!,
                      }),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              _open(const BastionDiagnosticsScreen()),
                          child: Text(l10n.fieldOps_diagnostics),
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

  AppLocalizations get _l10n => context.l10n;

  /// The on-screen name for a check-in status; the radio sends the English.
  String _checkInLabel(String label) => switch (label) {
    "I'm OK" => _l10n.checkIn_labelOk,
    'At Camp' => _l10n.checkIn_labelAtCamp,
    'Delayed' => _l10n.checkIn_labelDelayed,
    'Heading Back' => _l10n.checkIn_labelHeadingBack,
    _ => label,
  };

  String _kindLabel(String kind) => switch (kind) {
    'all' => _l10n.fieldOps_kindAll,
    'check-in' => _l10n.fieldOps_kindCheckIn,
    'received' => _l10n.fieldOps_kindReceived,
    'note' => _l10n.fieldOps_kindNote,
    'dead-zone' => _l10n.fieldOps_kindDeadZone,
    'radio' => _l10n.fieldOps_kindRadio,
    'automation' => _l10n.fieldOps_kindAutomation,
    'missed' => _l10n.fieldOps_kindMissed,
    'sos' => _l10n.fieldOps_kindSos,
    'trip' => _l10n.fieldOps_kindTrip,
    'overdue' => _l10n.fieldOps_kindOverdue,
    _ => kind,
  };

  Widget _trip(FieldOpsService ops, MeshCoreConnector radio) => _page([
    _card(ops.trip.name, [
      Text(
        ops.trip.active
            ? _l10n.fieldOps_tripActive(ops.trip.members.length)
            : _l10n.fieldOps_tripStopped,
      ),
      if (ops.trip.active && ops.reminderAt != null)
        Text(
          _l10n.fieldOps_reminderAt(
            TimeOfDay.fromDateTime(ops.reminderAt!).format(context),
          ),
          key: const ValueKey('reminder-at'),
        ),
      if (ops.overdueNames.isNotEmpty)
        Text(
          _l10n.fieldOps_quietTooLong(ops.overdueNames.join(', ')),
          key: const ValueKey('overdue-names'),
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          OutlinedButton.icon(
            onPressed: ops.busy ? null : () => _editTrip(ops),
            icon: const Icon(Icons.edit),
            label: Text(_l10n.fieldOps_planTrip),
          ),
          FilledButton.icon(
            onPressed: ops.busy || ops.error != null
                ? null
                : () => _perform(ops.trip.active ? ops.endTrip : ops.startTrip),
            icon: Icon(
              ops.trip.active ? Icons.stop_circle_outlined : Icons.play_arrow,
            ),
            label: Text(
              ops.trip.active
                  ? _l10n.fieldOps_endTrip
                  : _l10n.fieldOps_startTrip,
            ),
          ),
          OutlinedButton.icon(
            onPressed: () => _shareTripBrief(ops),
            icon: const Icon(Icons.description_outlined),
            label: Text(_l10n.fieldOps_tripBrief),
          ),
          OutlinedButton.icon(
            onPressed: () => _open(const ScannerScreen()),
            icon: const Icon(Icons.bluetooth),
            label: Text(_l10n.fieldOps_connectRadio),
          ),
        ],
      ),
    ]),
    _card(_l10n.fieldOps_previewedCheckIns, [
      Text(_l10n.fieldOps_previewedCheckInsHint),
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
          for (final label in checkInLabels)
            FilledButton.tonal(
              onPressed: _checkInReason(ops, radio) != null
                  ? null
                  : () => _checkIn(ops, label),
              child: Text(_checkInLabel(label)),
            ),
        ],
      ),
      if (ops.busy) const LinearProgressIndicator(),
      if (ops.latestDelivery case final delivery?) ...[
        const SizedBox(height: 12),
        _deliveryView(ops, delivery),
      ],
    ]),
    _card(_l10n.fieldOps_tripRoster, [
      if (ops.trip.members.isEmpty) Text(_l10n.fieldOps_rosterEmpty),
      for (final key in ops.trip.members) _memberTile(ops, key),
      Text(_l10n.fieldOps_rosterCaveat),
    ]),
    _tripMap(ops),
    _card(_l10n.fieldOps_offlineMaps, [
      Text(
        _cacheError != null
            ? _l10n.fieldOps_mapVerifyFailed(_cacheError!)
            : _inventory == null
            ? _l10n.fieldOps_checkingTiles
            : _l10n.fieldOps_cachedTiles(_inventory!.tiles.length),
      ),
      TextButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (_) => const MapCacheScreen()),
          );
          await _loadMaps();
        },
        child: Text(_l10n.fieldOps_downloadAreas),
      ),
    ]),
  ]);

  Widget _deliveryView(FieldOpsService ops, CheckInDelivery delivery) {
    final failed = delivery.failedKeys.length;
    return Column(
      key: const ValueKey('check-in-delivery'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _l10n.fieldOps_lastCheckIn(
            TimeOfDay.fromDateTime(delivery.at).format(context),
          ),
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        Text(delivery.headlineIn(_l10n)),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final MapEntry(:key, :value) in delivery.statuses.entries)
              Chip(
                avatar: Icon(switch (value) {
                  'delivered' => Icons.done_all,
                  'failed' => Icons.error_outline,
                  _ => Icons.schedule,
                }, size: 18),
                label: Text(
                  _l10n.fieldOps_deliveryChip(
                    delivery.names[key] ?? _l10n.fieldOps_contactFallback,
                    messageStatusLabel(value, l10n: _l10n),
                  ),
                ),
              ),
          ],
        ),
        if (failed > 0)
          TextButton.icon(
            onPressed:
                _checkInReason(ops, context.read<MeshCoreConnector>()) == null
                ? () => _perform(ops.resendCheckIn)
                : null,
            icon: const Icon(Icons.replay),
            label: Text(_l10n.fieldOps_resendFailed(failed)),
          ),
      ],
    );
  }

  String? _checkInReason(FieldOpsService ops, MeshCoreConnector radio) =>
      checkInUnavailableReason(
        ready: ops.ready,
        storageError: ops.error != null,
        active: ops.trip.active,
        connected: radio.isConnected,
        busy: ops.busy,
        selectedContacts: ops.trip.members.length,
        availableContacts: ops.members.length,
        l10n: _l10n,
      );

  Widget _memberTile(FieldOpsService ops, String key) {
    final matches = ops.members.where((c) => c.publicKeyHex == key);
    if (matches.isEmpty) {
      return ListTile(
        leading: const Icon(Icons.person_off),
        title: Text(_l10n.fieldOps_memberUnavailable),
        subtitle: Text(_l10n.fieldOps_memberUnavailableHint),
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
        '${overdue ? _l10n.fieldOps_lastActivityOverdue(minutes) : _l10n.fieldOps_lastActivity(minutes)}\n${incoming.isEmpty ? _l10n.fieldOps_noCheckInRecorded : incoming.first.text}',
      ),
      isThreeLine: true,
    );
  }

  Widget _tripMap(FieldOpsService ops) {
    final positioned = ops.members.where((c) => c.hasLocation).toList();
    if (positioned.isEmpty) {
      return _card(_l10n.fieldOps_tripMap, [Text(_l10n.fieldOps_tripMapEmpty)]);
    }
    return _card(_l10n.fieldOps_lastPositions, [
      Text(_l10n.fieldOps_positionsCaveat),
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
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .surface,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            RichAttributionWidget(
              attributions: [
                TextSourceAttribution(_l10n.bastion_mapAttribution),
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
    }, l10n: _l10n);
    final share = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(_l10n.fieldOps_briefPreviewTitle),
        content: SizedBox(
          width: 420,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_l10n.fieldOps_briefPreviewHint),
                const SizedBox(height: 16),
                SelectableText(brief),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(_l10n.common_close),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.pop(ctx, true),
            icon: const Icon(Icons.share_outlined),
            label: Text(_l10n.fieldOps_shareBrief),
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
          subject: _l10n.fieldOps_briefSubject,
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
    var reminder = ops.trip.reminderMinutes;
    final channels = ops.connector.channels.where((c) => !c.isEmpty).toList();
    var sosChannel = channels.any((c) => c.index == ops.trip.sosChannel)
        ? ops.trip.sosChannel
        : -1;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(_l10n.fieldOps_planTrip),
          content: SizedBox(
            width: 420,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: name,
                    maxLength: 48,
                    decoration: InputDecoration(
                      labelText: _l10n.fieldOps_tripName,
                    ),
                  ),
                  SwitchListTile(
                    title: Text(_l10n.fieldOps_includePosition),
                    subtitle: Text(_l10n.fieldOps_includePositionHint),
                    value: location,
                    onChanged: (v) => setDialogState(() => location = v),
                  ),
                  SwitchListTile(
                    title: Text(_l10n.fieldOps_includeBattery),
                    value: battery,
                    onChanged: (v) => setDialogState(() => battery = v),
                  ),
                  DropdownButtonFormField<int>(
                    initialValue: overdue,
                    decoration: InputDecoration(
                      labelText: _l10n.fieldOps_overdueLabel,
                    ),
                    items: {15, 30, 60, 120, 240, 1440, overdue}
                        .toList()
                        .map(
                          (n) => DropdownMenuItem(
                            value: n,
                            child: Text(_l10n.bastion_minutesCount(n)),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setDialogState(() => overdue = v);
                    },
                  ),
                  DropdownButtonFormField<int>(
                    initialValue: reminder,
                    decoration: InputDecoration(
                      labelText: _l10n.fieldOps_reminderLabel,
                      helperText: _l10n.fieldOps_reminderHelper,
                    ),
                    items: [
                      for (final n in reminderChoices)
                        DropdownMenuItem(
                          value: n,
                          child: Text(
                            n == 0
                                ? _l10n.fieldOps_reminderOff
                                : _l10n.fieldOps_reminderAfter(n),
                          ),
                        ),
                    ],
                    onChanged: (v) {
                      if (v != null) setDialogState(() => reminder = v);
                    },
                  ),
                  DropdownButtonFormField<int>(
                    initialValue: sosChannel,
                    decoration: InputDecoration(
                      labelText: _l10n.fieldOps_sosChannelLabel,
                    ),
                    items: [
                      DropdownMenuItem(
                        value: -1,
                        child: Text(_l10n.fieldOps_sosChannelNone),
                      ),
                      for (final c in channels)
                        DropdownMenuItem(value: c.index, child: Text(c.name)),
                    ],
                    onChanged: (v) {
                      if (v != null) setDialogState(() => sosChannel = v);
                    },
                  ),
                  const SizedBox(height: 12),
                  Text(_l10n.fieldOps_selectContacts),
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
              child: Text(_l10n.common_cancel),
            ),
            FilledButton(
              onPressed: () async {
                await ops.configureTrip(
                  ops.trip.copyWith(
                    name: name.text.trim().isEmpty
                        ? _l10n.fieldOps_defaultTripName
                        : name.text.trim(),
                    members: selected.toList(),
                    sosChannel: sosChannel,
                    reminderMinutes: reminder,
                    shareLocation: location,
                    shareBattery: battery,
                    overdueMinutes: overdue,
                  ),
                );
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: Text(_l10n.common_save),
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
        title: Text(_l10n.fieldOps_sendCheckInTitle),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _l10n.fieldOps_recipients(
                  ops.members.map((c) => c.name).join(', '),
                ),
              ),
              const SizedBox(height: 12),
              SelectableText(text),
              const SizedBox(height: 12),
              Text(_l10n.fieldOps_sendCheckInHint),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(_l10n.common_cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(_l10n.fieldOps_send),
          ),
        ],
      ),
    );
    if (approved == true) await _perform(() => ops.sendCheckIn(text));
  }

  Widget _readiness(FieldOpsService ops, MeshCoreConnector radio) => _page([
    _card(_l10n.fieldOps_beforeYouLeave, [
      _readyRow(
        radio.isConnected,
        _l10n.fieldOps_radioConnected,
        radio.isConnected
            ? '${radio.deviceDisplayName} • ${radio.activeTransport.name}'
            : _l10n.fieldOps_connectHint,
      ),
      _readyRow(
        radio.batteryPercent != null && radio.batteryPercent! >= 30,
        _l10n.fieldOps_radioBattery,
        radio.batteryPercent == null
            ? _l10n.fieldOps_batteryUnknown
            : _l10n.fieldOps_batteryDetail('${radio.batteryPercent}'),
      ),
      _readyRow(
        ops.trip.members.isNotEmpty &&
            ops.members.length == ops.trip.members.length,
        _l10n.fieldOps_tripContacts,
        _l10n.fieldOps_tripContactsDetail(
          '${ops.members.length}',
          '${ops.trip.members.length}',
        ),
      ),
      _readyRow(
        !_loadingMaps &&
            _region != null &&
            _region!.available == _region!.expected,
        _l10n.fieldOps_offlineArea,
        _cacheError != null
            ? _l10n.fieldOps_mapVerifyFailed(_cacheError!)
            : _loadingMaps
            ? _l10n.fieldOps_checkingFiles
            : _region == null
            ? _regionLabel ?? _l10n.fieldOps_regionHint
            : '${_regionLabel ?? _l10n.fieldOps_regionHint}\n${_l10n.fieldOps_regionStatus('${_region!.available}', '${_region!.expected}', '${_region!.expected - _region!.available}')}',
      ),
      _readyRow(
        !ops.trip.shareLocation ||
            usablePosition(radio.selfLatitude, radio.selfLongitude),
        _l10n.fieldOps_locationChoice,
        ops.trip.shareLocation
            ? _l10n.fieldOps_locationOptedIn
            : _l10n.fieldOps_locationOff,
      ),
      _readyRow(
        !ops.automationEnabled || ops.foreground,
        _l10n.fieldOps_automationAvailability,
        _l10n.fieldOps_automationAvailabilityDetail,
      ),
      const Divider(),
      Text(_l10n.fieldOps_readinessCaveat),
      Wrap(
        spacing: 8,
        children: [
          TextButton(
            onPressed: () => _open(const ScannerScreen()),
            child: Text(_l10n.fieldOps_radio),
          ),
          TextButton(
            onPressed: () => _open(const MapCacheScreen()),
            child: Text(_l10n.fieldOps_offlineMaps),
          ),
          TextButton(
            onPressed: _loadingMaps ? null : _loadMaps,
            child: Text(_l10n.fieldOps_refreshChecks),
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
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          labelText: _l10n.fieldOps_searchLog,
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
              label: Text(_kindLabel(kind)),
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
            label: Text(_l10n.fieldOps_addNote),
          ),
          TextButton.icon(
            onPressed: () => _perform(() async {
              await SharePlus.instance.share(
                ShareParams(
                  text: ops.exportLog(),
                  subject: _l10n.fieldOps_logSubject,
                ),
              );
            }),
            icon: const Icon(Icons.share),
            label: Text(_l10n.fieldOps_exportJson),
          ),
          TextButton(
            onPressed: () => _clear(ops),
            child: Text(_l10n.fieldOps_deleteLog),
          ),
        ],
      ),
      Text(_l10n.fieldOps_logCaveat),
      const SizedBox(height: 12),
      if (rows.isEmpty) Text(_l10n.fieldOps_noEntries),
      for (final e in rows)
        Card(
          child: ListTile(
            title: Text(e.text),
            subtitle: Text(
              [
                '${e.at.toLocal()} • ${_kindLabel(e.kind)} • ${e.tripName ?? _l10n.fieldOps_tripUnspecified}',
                if (e.status case final status?)
                  _l10n.fieldOps_entryStatus(
                    messageStatusLabel(status, l10n: _l10n),
                    explainMessageStatus(status, l10n: _l10n),
                  ),
                if (e.latitude != null)
                  _l10n.fieldOps_entryPosition(
                    '${e.latitude}',
                    '${e.longitude}',
                  ),
              ].join('\n'),
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
          title: Text(_l10n.fieldOps_noteTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: text,
                maxLength: 500,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: _l10n.fieldOps_noteLabel,
                ),
              ),
              SwitchListTile(
                title: Text(_l10n.fieldOps_deadZone),
                subtitle: Text(_l10n.fieldOps_deadZoneHint),
                value: deadZone,
                onChanged: (v) => setDialogState(() => deadZone = v),
              ),
              SwitchListTile(
                title: Text(_l10n.fieldOps_savePosition),
                subtitle: Text(
                  usablePosition(lat, lon)
                      ? _l10n.fieldOps_positionDetail('$lat', '$lon')
                      : _l10n.fieldOps_noPosition,
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
              child: Text(_l10n.common_cancel),
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
              child: Text(_l10n.common_save),
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
        title: Text(_l10n.fieldOps_deleteLogTitle),
        content: Text(_l10n.fieldOps_deleteLogBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(_l10n.common_cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(_l10n.common_delete),
          ),
        ],
      ),
    );
    if (yes == true) await ops.clearLog();
  }

  Widget _automations(FieldOpsService ops) => _page([
    _card(_l10n.fieldOps_localAutomations, [
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(_l10n.fieldOps_enableForTrip),
        value: ops.automationEnabled,
        onChanged: (v) => _perform(() => ops.enableAutomations(v)),
      ),
      Text(_l10n.fieldOps_automationsCaveat),
      TextButton(
        onPressed: () => _open(const BotSettingsScreen()),
        child: Text(_l10n.fieldOps_openBotMode),
      ),
    ]),
    for (final rule in ops.rules)
      _card(_triggerLabel(rule.trigger), [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(_l10n.fieldOps_ruleEnabled),
          value: rule.enabled,
          onChanged: (v) => ops.configureRule(rule.copyWith(enabled: v)),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(_l10n.fieldOps_dryRun),
          subtitle: Text(_l10n.fieldOps_dryRunHint),
          value: rule.dryRun,
          onChanged: (v) => ops.configureRule(rule.copyWith(dryRun: v)),
        ),
        DropdownButtonFormField<FieldAction>(
          key: ValueKey('${rule.id}_${rule.action}'),
          initialValue: rule.action,
          decoration: InputDecoration(labelText: _l10n.fieldOps_then),
          items: FieldAction.values
              .map(
                (a) => DropdownMenuItem(
                  value: a,
                  child: Text(switch (a) {
                    FieldAction.log => _l10n.fieldOps_actionLog,
                    FieldAction.notify => _l10n.fieldOps_actionNotify,
                    FieldAction.checkIn => _l10n.fieldOps_actionCheckIn,
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
            decoration: InputDecoration(
              labelText: _l10n.fieldOps_batteryThreshold,
            ),
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
            decoration: InputDecoration(labelText: _l10n.common_interval),
            items: {15, 30, 60, 120, 240, 1440, rule.intervalMinutes}
                .toList()
                .map(
                  (n) => DropdownMenuItem(
                    value: n,
                    child: Text(_l10n.bastion_minutesCount(n)),
                  ),
                )
                .toList(),
            onChanged: (v) {
              if (v != null) {
                ops.configureRule(rule.copyWith(intervalMinutes: v));
              }
            },
          ),
          Text(
            rule.nextDue == null
                ? _l10n.fieldOps_nextDueNone
                : _l10n.fieldOps_nextDue('${rule.nextDue!.toLocal()}'),
          ),
        ],
        const SizedBox(height: 8),
        if (rule.action == FieldAction.checkIn)
          Text(
            '${_l10n.fieldOps_recipients(ops.members.map((c) => c.name).join(', '))}\n${ops.previewCheckIn(checkInLabels[0])}',
          ),
        Wrap(
          spacing: 8,
          children: [
            TextButton(
              onPressed: () => ops.previewRule(rule),
              child: Text(_l10n.fieldOps_previewInLog),
            ),
            if (rule.action == FieldAction.notify)
              TextButton(
                onPressed: () => _perform(() async {
                  await NotificationService().requestPermissions();
                }),
                child: Text(_l10n.fieldOps_allowNotifications),
              ),
          ],
        ),
      ]),
  ]);
  String _triggerLabel(FieldTrigger t) => switch (t) {
    FieldTrigger.reconnect => _l10n.fieldOps_triggerReconnect,
    FieldTrigger.disconnect => _l10n.fieldOps_triggerDisconnect,
    FieldTrigger.lowBattery => _l10n.fieldOps_triggerLowBattery,
    FieldTrigger.newNode => _l10n.fieldOps_triggerNewNode,
    FieldTrigger.repeater => _l10n.fieldOps_triggerRepeater,
    FieldTrigger.scheduled => _l10n.fieldOps_triggerScheduled,
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
      _card(_l10n.fieldOps_explainConnection, [
        Text(
          _l10n.fieldOps_connectionState(
            radio.state.name,
            radio.activeTransport.name,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          radio.isConnected
              ? _l10n.fieldOps_connectedCaveat
              : _l10n.fieldOps_disconnectedHint,
        ),
        Text(_l10n.fieldOps_awaitingConfirmation(pending)),
        for (final status in ['pending', 'sent', 'delivered', 'failed'])
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(messageStatusLabel(status, l10n: _l10n).toUpperCase()),
            subtitle: Text(explainMessageStatus(status, l10n: _l10n)),
          ),
        Text(_l10n.fieldOps_staleCaveat),
        Wrap(
          spacing: 8,
          children: [
            TextButton(
              onPressed: () => _open(const ScannerScreen()),
              child: Text(_l10n.fieldOps_connectRadio),
            ),
            TextButton(
              onPressed: () => _open(const BastionDiagnosticsScreen()),
              child: Text(_l10n.fieldOps_diagnostics),
            ),
            TextButton(
              onPressed: () => _open(const BastionPathHubScreen()),
              child: Text(_l10n.fieldOps_routeIntelligence),
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
                    '${o.nodeName} • ${o.timestamp.toLocal()}\n${_l10n.fieldOps_heardTooltip}',
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
                  '${_kindLabel(entry.kind)} • ${entry.at.toLocal()}\n${entry.text}\n${_l10n.fieldOps_noteTooltip}',
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
      _card(_l10n.fieldOps_coverageIntelligence, [
        Text(_l10n.fieldOps_coverageIntelligenceHint),
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
              child: Text(_l10n.fieldOps_captureSession),
            ),
            TextButton(
              onPressed: _loadCoverage,
              child: Text(_l10n.fieldOps_refreshHistory),
            ),
          ],
        ),
        if (_coverage.loadWarning != null) Text(_coverage.loadWarning!),
        if (sessions.isEmpty) Text(_l10n.fieldOps_noCoverageSessions),
        for (final slot in [0, 1])
          DropdownButtonFormField<String>(
            key: ValueKey('session_$slot'),
            initialValue: slot == 0 ? _firstSession : _secondSession,
            decoration: InputDecoration(
              labelText: slot == 0
                  ? _l10n.fieldOps_sessionA
                  : _l10n.fieldOps_sessionB,
            ),
            items: sessions
                .map(
                  (s) => DropdownMenuItem(
                    value: s.id,
                    child: Text(
                      '${s.startedAt.toLocal()} • ${_l10n.bastion_observationsCount(s.observations.length)}',
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
            _l10n.fieldOps_uniqueCompare('${keysA.length}', '${keysB.length}'),
          ),
          Text(
            _l10n.fieldOps_overlap(
              '${keysA.intersection(keysB).length}',
              '${keysA.difference(keysB).length}',
              '${keysB.difference(keysA).length}',
            ),
          ),
          Text(_l10n.fieldOps_compareCaveat),
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
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(_l10n.bastion_mapAttribution),
                  ],
                ),
              ],
            ),
          ),
      ]),
    ]);
  }
}
