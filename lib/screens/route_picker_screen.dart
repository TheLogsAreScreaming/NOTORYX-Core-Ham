import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/contact.dart';
import '../models/route_choice.dart';
import '../services/path_history_service.dart';
import '../services/route_link_service.dart';
import '../theme/mesh_theme.dart';
import '../widgets/instrument.dart';
import '../widgets/path_editor_sheet.dart';

/// Shows each hop of the route to a contact with how well its link works,
/// and lets the user measure it or pick a more reliable route.
class RoutePickerScreen extends StatefulWidget {
  const RoutePickerScreen({super.key, required this.contact, this.links});

  final Contact contact;

  /// For tests; made from the connector otherwise.
  final RouteLinkService? links;

  @override
  State<RoutePickerScreen> createState() => _RoutePickerScreenState();
}

class _RoutePickerScreenState extends State<RoutePickerScreen> {
  late final RouteLinkService _links =
      widget.links ?? RouteLinkService(context.read<MeshCoreConnector>());
  bool _measuring = false;
  String? _status;

  Contact _contact(MeshCoreConnector c) =>
      c.getContactByPubKeyHex(widget.contact.publicKeyHex) ?? widget.contact;

  /// The route messages use now; null while flooding.
  List<int>? _currentPath(Contact c) {
    final override = c.pathOverride;
    if (override != null) {
      return override < 0 ? null : (c.pathOverrideBytes ?? Uint8List(0));
    }
    return c.pathLength < 0 ? null : c.path;
  }

  String? _nameOf(MeshCoreConnector c, String hopId) {
    final id = hopId.toLowerCase();
    final matches = c.allContacts
        .where(
          (x) =>
              (x.type == advTypeRepeater || x.type == advTypeRoom) &&
              x.publicKeyHex.toLowerCase().startsWith(id),
        )
        .toList();
    return matches.length == 1 && matches.first.name.isNotEmpty
        ? matches.first.name
        : null;
  }

  String _hopName(AppLocalizations l10n, RouteHop h) =>
      h.name ?? l10n.routePick_hopUnknown(h.id);

  String _routeName(AppLocalizations l10n, RouteOption o) => o.isDirect
      ? l10n.routePick_direct
      : o.hops.map((h) => _hopName(l10n, h)).join(' → ');

  String _quality(AppLocalizations l10n, double? snr) => snr == null
      ? l10n.routePick_notMeasured
      : snr >= 5
      ? l10n.rptTest_strong
      : snr >= -5
      ? l10n.rptTest_usable
      : l10n.rptTest_weak;

  Future<void> _measure(List<int> path, int width) async {
    setState(() {
      _measuring = true;
      _status = null;
    });
    final ok = await _links.measure(path, width);
    if (!mounted) return;
    setState(() {
      _measuring = false;
      _status = ok
          ? context.l10n.routePick_measured
          : context.l10n.routePick_noAnswer;
    });
  }

  Future<void> _use(
    MeshCoreConnector c,
    Contact contact,
    List<int> path,
  ) async {
    final l10n = context.l10n;
    final bytes = Uint8List.fromList(path);
    await c.setPathOverride(
      contact,
      pathLen: bytes.length ~/ c.pathHashByteWidth,
      pathBytes: bytes,
    );
    String status;
    if (!c.isConnected) {
      status = l10n.chat_pathSavedLocally;
    } else {
      final verified = await c.verifyContactPathOnDevice(contact, bytes);
      status = verified
          ? l10n.chat_pathDeviceConfirmed
          : l10n.chat_pathDeviceNotConfirmed;
    }
    if (mounted) setState(() => _status = status);
  }

  Future<void> _build(MeshCoreConnector c, Contact contact) async {
    final result = await PathEditorSheet.show(
      context,
      availableContacts: c.allContacts
          .where((x) => x.publicKeyHex != contact.publicKeyHex)
          .toList(),
      initialPath: Uint8List.fromList(_currentPath(contact) ?? const []),
      pathHashByteWidth: c.pathHashByteWidth,
    );
    if (result == null || !mounted) return;
    await _use(c, contact, result);
  }

  Future<void> _flood(MeshCoreConnector c, Contact contact) async {
    final l10n = context.l10n;
    if (contact.pathOverride != null) {
      await c.setPathOverride(contact, pathLen: null);
    }
    await c.clearContactPath(contact);
    if (mounted) setState(() => _status = l10n.routePick_floodDone);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.watch<MeshCoreConnector>();
    final history = context.watch<PathHistoryService>();
    final contact = _contact(c);
    final width = c.pathHashByteWidth;
    final current = _currentPath(contact);
    final links = _links.links;
    String? nameOf(String id) => _nameOf(c, id);
    final options = buildRouteOptions(
      currentPath: current,
      history: history.getRecentPaths(contact.publicKeyHex),
      width: width,
      links: links,
      nameOf: nameOf,
      now: DateTime.now(),
    );
    final currentOption = options.where((o) => o.isCurrent).firstOrNull;
    final suggestion = suggestRoute(options);
    final canTrace =
        current != null &&
        current.isNotEmpty &&
        RouteLinkService.traceFlag(width) != null &&
        c.isConnected;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.routePick_title(contact.name))),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          InstrumentLabel(l10n.routePick_current),
          if (current == null)
            InstrumentRow(icon: Icons.waves, title: l10n.routePick_flooding)
          else
            _chart(
              l10n,
              contact,
              routeHops(current, width: width, links: links, nameOf: nameOf),
              currentOption?.score,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: MeshSpace.lg,
              vertical: MeshSpace.sm,
            ),
            child: InstrumentButton(
              key: const ValueKey('route-measure'),
              label: _measuring
                  ? l10n.routePick_measuring
                  : l10n.routePick_measure,
              icon: Icons.timeline,
              onPressed: canTrace && !_measuring
                  ? () => _measure(current, width)
                  : null,
            ),
          ),
          if (_status != null)
            Semantics(
              liveRegion: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: MeshSpace.lg),
                child: Text(_status!),
              ),
            ),
          if (suggestion != null)
            Card(
              key: const ValueKey('route-suggestion'),
              margin: const EdgeInsets.all(MeshSpace.lg),
              child: ListTile(
                leading: const Icon(Icons.lightbulb_outline),
                title: Text(l10n.routePick_suggested),
                subtitle: Text(
                  l10n.routePick_suggestBody(
                    _routeName(l10n, suggestion),
                    suggestion.score,
                  ),
                ),
                trailing: TextButton(
                  onPressed: () => _use(c, contact, suggestion.pathBytes),
                  child: Text(l10n.routePick_use),
                ),
              ),
            ),
          InstrumentLabel(l10n.routePick_options),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MeshSpace.lg),
            child: Text(
              l10n.routePick_optionsHint,
              style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
            ),
          ),
          if (options.isEmpty) InstrumentRow(title: l10n.routePick_none),
          for (final o in options) _optionTile(l10n, c, contact, o, suggestion),
          InstrumentLabel(l10n.routePick_other),
          InstrumentRow(
            icon: Icons.edit_road,
            title: l10n.routePick_build,
            onTap: () => _build(c, contact),
          ),
          InstrumentRow(
            icon: Icons.waves,
            title: l10n.routePick_flood,
            onTap: () => _flood(c, contact),
          ),
          Padding(
            padding: const EdgeInsets.all(MeshSpace.lg),
            child: Text(
              l10n.routePick_explainer,
              style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chart(
    AppLocalizations l10n,
    Contact contact,
    List<RouteHop> hops,
    int? score,
  ) {
    String snr(double? v) => v == null ? '—' : v.toStringAsFixed(1);
    return Column(
      children: [
        if (score != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MeshSpace.lg),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(l10n.routePick_score(score)),
            ),
          ),
        _node(l10n.pathTrace_you, Icons.my_location),
        for (var i = 0; i < hops.length; i++) ...[
          _linkBar(
            l10n,
            hops[i].link,
            l10n.routePick_hopLabel(
              i + 1,
              _hopName(l10n, hops[i]),
              _quality(l10n, hops[i].link?.weaker),
              snr(hops[i].link?.snrOut),
              snr(hops[i].link?.snrBack),
            ),
          ),
          _node(_hopName(l10n, hops[i]), Icons.cell_tower_rounded),
        ],
        Semantics(
          label: l10n.routePick_lastLink,
          excludeSemantics: true,
          child: _bar(null, l10n.routePick_lastLink),
        ),
        _node(contact.name, Icons.person_pin_circle_outlined),
      ],
    );
  }

  Widget _node(String name, IconData icon) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: MeshSpace.lg, vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 20, color: MeshPalette.ink2),
        const SizedBox(width: MeshSpace.sm),
        Expanded(child: Text(name)),
      ],
    ),
  );

  Widget _linkBar(AppLocalizations l10n, RouteLink? link, String label) {
    final text = link?.weaker == null
        ? l10n.routePick_notMeasured
        : l10n.routePick_linkLine(
            link!.snrOut?.toStringAsFixed(1) ?? '—',
            link.snrBack?.toStringAsFixed(1) ?? '—',
          );
    return Semantics(
      container: true,
      label: label,
      excludeSemantics: true,
      child: _bar(link?.weaker, text),
    );
  }

  /// A short vertical connector with a bar whose length and colour follow
  /// the link's weaker SNR, and the numbers as text.
  Widget _bar(double? snr, String text) {
    final fill = snr == null ? 0.0 : ((snr + 15) / 25).clamp(0.05, 1.0);
    final color = MeshTheme.snrColor(snr, blocked: false);
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: MeshSpace.lg + 9,
        end: MeshSpace.lg,
      ),
      child: Row(
        children: [
          Container(width: 2, height: 36, color: color),
          const SizedBox(width: MeshSpace.md),
          SizedBox(
            width: 64,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: fill,
                minHeight: 6,
                color: color,
                backgroundColor: MeshPalette.ink3.withValues(alpha: 0.25),
              ),
            ),
          ),
          if (snr != null) ...[const SizedBox(width: 6), SignalReadout(snr)],
          const SizedBox(width: MeshSpace.sm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: MeshPalette.ink2, fontSize: 12.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionTile(
    AppLocalizations l10n,
    MeshCoreConnector c,
    Contact contact,
    RouteOption o,
    RouteOption? suggestion,
  ) {
    final name = _routeName(l10n, o);
    final weakest = o.weakestSnr;
    final details = [
      l10n.routePick_optionLine(o.score, o.hops.length),
      if (o.attempts > 0) l10n.routePick_record(o.successes, o.attempts),
      weakest == null
          ? l10n.routePick_notMeasured
          : l10n.routePick_weakest(weakest.toStringAsFixed(1)),
      if (o.isCurrent) l10n.routePick_inUse,
      if (identical(o, suggestion)) l10n.routePick_suggested,
    ].join(' · ');
    return ListTile(
      leading: Icon(
        o.isCurrent ? Icons.check_circle : Icons.alt_route,
        color: MeshTheme.snrColor(weakest, blocked: false),
      ),
      title: Text(name),
      subtitle: Text(details),
      trailing: o.isCurrent
          ? null
          : TextButton(
              onPressed: () => _use(c, contact, o.pathBytes),
              child: Text(
                l10n.routePick_use,
                semanticsLabel: l10n.routePick_useLabel(name),
              ),
            ),
    );
  }
}
