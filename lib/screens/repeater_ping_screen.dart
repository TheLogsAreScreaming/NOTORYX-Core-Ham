import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../l10n/contact_localization.dart';
import '../l10n/l10n.dart';
import '../models/contact.dart';
import '../services/trace_pinger.dart';
import '../theme/mesh_theme.dart';
import '../widgets/instrument.dart';
import '../widgets/ember_backdrop.dart';

/// Repeaters to probe, the ones heard directly first: a one-hop probe only
/// reaches a repeater this radio can hear.
List<Contact> pingableRepeaters(MeshCoreConnector c) =>
    c.contacts.where((x) => x.type == advTypeRepeater).toList()..sort((a, b) {
      final direct = (a.pathLength == 0 ? 0 : 1).compareTo(
        b.pathLength == 0 ? 0 : 1,
      );
      return direct != 0 ? direct : b.lastSeen.compareTo(a.lastSeen);
    });

/// Picks a repeater for a probe screen.
Future<Contact?> pickRepeater(BuildContext context) {
  final c = context.read<MeshCoreConnector>();
  final repeaters = pingableRepeaters(c);
  final l10n = context.l10n;
  return showModalBottomSheet<Contact>(
    context: context,
    builder: (sheet) => SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: [
          InstrumentLabel(l10n.bastion_repeaters),
          if (repeaters.isEmpty)
            InstrumentRow(
              title: l10n.ping_noRepeaters,
              titleColor: MeshPalette.ink3,
            ),
          for (final r in repeaters)
            InstrumentRow(
              title: r.name,
              subtitle: r.pathLabel(l10n),
              onTap: () => Navigator.pop(sheet, r),
            ),
        ],
      ),
    ),
  );
}

/// Fires a burst of probes at one repeater and shows round-trip time and
/// SNR in both directions for each, with a summary.
class RepeaterPingScreen extends StatefulWidget {
  const RepeaterPingScreen({super.key, this.pinger});

  /// For tests; made from the connector otherwise.
  final TracePinger? pinger;

  static const burst = 5;

  @override
  State<RepeaterPingScreen> createState() => _RepeaterPingScreenState();
}

class _RepeaterPingScreenState extends State<RepeaterPingScreen> {
  late final TracePinger _pinger =
      widget.pinger ?? TracePinger(context.read<MeshCoreConnector>());
  Contact? _target;
  final List<PingResult?> _results = [];
  bool _running = false;

  Future<void> _run() async {
    final target = _target;
    if (target == null || _running) return;
    HapticFeedback.selectionClick();
    setState(() {
      _running = true;
      _results.clear();
    });
    for (var i = 0; i < RepeaterPingScreen.burst; i++) {
      final result = await _pinger.ping(target.publicKey);
      if (!mounted) return;
      setState(() => _results.add(result));
      if (i < RepeaterPingScreen.burst - 1) {
        await Future<void>.delayed(const Duration(milliseconds: 800));
      }
    }
    if (mounted) setState(() => _running = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final online = context.watch<MeshCoreConnector>().isConnected;
    final ok = _results.whereType<PingResult>().toList();
    String avg(double Function(PingResult) f) => ok.isEmpty
        ? '—'
        : (ok.map(f).reduce((a, b) => a + b) / ok.length).toStringAsFixed(1);
    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: Text(l10n.ping_title),
        ),
        body: ListView(
          children: [
            InstrumentRow(
              icon: Icons.cell_tower_rounded,
              title: _target?.name ?? l10n.ping_choose,
              subtitle: _target?.pathLabel(l10n),
              onTap: _running
                  ? null
                  : () async {
                      final picked = await pickRepeater(context);
                      if (picked != null && mounted) {
                        setState(() {
                          _target = picked;
                          _results.clear();
                        });
                      }
                    },
            ),
            ReadoutStrip([
              Readout(
                ok.isEmpty
                    ? '—'
                    : '${(ok.map((r) => r.roundTrip.inMilliseconds).reduce((a, b) => a + b) / ok.length).round()}',
                l10n.ping_avgMs,
              ),
              Readout(avg((r) => r.snrThere), l10n.ping_snrThere),
              Readout(avg((r) => r.snrBack), l10n.ping_snrBack),
              Readout(
                _results.isEmpty
                    ? '—'
                    : '${((_results.length - ok.length) * 100 / _results.length).round()}%',
                l10n.ping_loss,
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(MeshSpace.lg),
              child: InstrumentButton(
                label: _running
                    ? l10n.ping_running(
                        _results.length + 1,
                        RepeaterPingScreen.burst,
                      )
                    : l10n.ping_start(RepeaterPingScreen.burst),
                icon: Icons.network_ping,
                onPressed: _target == null || _running || !online ? null : _run,
              ),
            ),
            if (_results.isNotEmpty) InstrumentLabel(l10n.ping_results),
            for (var i = 0; i < _results.length; i++)
              InstrumentRow(
                title: '#${i + 1}',
                subtitle: _results[i] == null
                    ? l10n.ping_noReply
                    : l10n.ping_resultLine(
                        '${_results[i]!.roundTrip.inMilliseconds}',
                        _results[i]!.snrThere.toStringAsFixed(1),
                      ),
                trailing: _results[i] == null
                    ? null
                    : SignalReadout(_results[i]!.snrBack),
              ),
            Padding(
              padding: const EdgeInsets.all(MeshSpace.lg),
              child: Text(
                l10n.ping_explainer,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: MeshPalette.ink3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
