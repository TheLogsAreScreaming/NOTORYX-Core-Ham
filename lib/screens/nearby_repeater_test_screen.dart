import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/nearby_repeaters.dart';
import '../models/wardrive.dart';
import '../services/nearby_repeater_probe.dart';
import '../theme/mesh_theme.dart';
import '../widgets/ember_backdrop.dart';
import '../widgets/instrument.dart';

/// One tap sends a zero-hop discover request; the repeaters that answer
/// are listed with the signal in both directions.
class NearbyRepeaterTestScreen extends StatefulWidget {
  const NearbyRepeaterTestScreen({super.key, this.probe, this.clock});

  /// For tests; made from the connector otherwise.
  final Future<List<WardriveReply>> Function()? probe;
  final DateTime Function()? clock;

  @override
  State<NearbyRepeaterTestScreen> createState() =>
      _NearbyRepeaterTestScreenState();
}

class _NearbyRepeaterTestScreenState extends State<NearbyRepeaterTestScreen> {
  List<NearbyRepeater>? _results;
  bool _running = false;
  DateTime? _lastRun;
  Timer? _tick;

  DateTime _now() => (widget.clock ?? DateTime.now)();

  Duration get _wait {
    final last = _lastRun;
    if (last == null) return Duration.zero;
    final left = NearbyRepeaterProbe.spacing - _now().difference(last);
    return left.isNegative ? Duration.zero : left;
  }

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }

  Future<void> _run() async {
    final connector = context.read<MeshCoreConnector>();
    final probe = widget.probe ?? NearbyRepeaterProbe(connector).run;
    HapticFeedback.selectionClick();
    setState(() {
      _running = true;
      _results = null;
    });
    List<WardriveReply> replies;
    try {
      replies = await probe();
    } catch (_) {
      replies = const [];
    }
    if (!mounted) return;
    setState(() {
      _running = false;
      _lastRun = _now();
      _results = rankNearbyRepeaters(replies, connector.allContacts);
    });
    _tick?.cancel();
    _tick = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (_wait == Duration.zero) t.cancel();
      setState(() {});
    });
  }

  String _quality(AppLocalizations l10n, NearbyLink link) => switch (link) {
    NearbyLink.strong => l10n.rptTest_strong,
    NearbyLink.usable => l10n.rptTest_usable,
    NearbyLink.weak => l10n.rptTest_weak,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final online = context.watch<MeshCoreConnector>().isConnected;
    final wait = _wait;
    final results = _results;
    final label = _running
        ? l10n.rptTest_listening
        : wait > Duration.zero
        ? l10n.rptTest_wait((wait.inMilliseconds / 1000).ceil())
        : l10n.rptTest_start;
    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: Text(l10n.rptTest_title),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(MeshSpace.lg),
              child: InstrumentButton(
                key: const ValueKey('rpt-test-start'),
                label: label,
                icon: Icons.cell_tower_rounded,
                onPressed: !online || _running || wait > Duration.zero
                    ? null
                    : _run,
              ),
            ),
            if (!online)
              InstrumentRow(
                title: l10n.rptTest_notConnected,
                titleColor: MeshPalette.ink3,
              ),
            if (results != null)
              Semantics(
                liveRegion: true,
                child: InstrumentLabel(l10n.rptTest_found(results.length)),
              ),
            if (results != null && results.isEmpty)
              InstrumentRow(title: l10n.rptTest_none),
            for (final r in results ?? const <NearbyRepeater>[]) _row(l10n, r),
            Padding(
              padding: const EdgeInsets.all(MeshSpace.lg),
              child: Text(
                l10n.rptTest_explainer,
                style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(AppLocalizations l10n, NearbyRepeater r) {
    final name = r.name ?? l10n.rptTest_unknown(r.prefix.toUpperCase());
    final quality = _quality(l10n, r.link);
    final there = r.reply.snrThere.toStringAsFixed(1);
    final here = r.reply.snrHere.toStringAsFixed(1);
    final rssi = '${r.reply.rssiHere}';
    return Semantics(
      container: true,
      label: l10n.rptTest_rowLabel(name, quality, there, here, rssi),
      excludeSemantics: true,
      child: InstrumentRow(
        icon: Icons.cell_tower_rounded,
        iconColor: MeshTheme.snrColor(r.weakerSnr, blocked: false),
        title: '$name · $quality',
        subtitle: l10n.rptTest_line(there, here, rssi),
        trailing: SignalReadout(r.weakerSnr),
      ),
    );
  }
}
