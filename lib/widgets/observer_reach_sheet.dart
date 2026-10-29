import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';
import '../services/corescope.dart';
import '../theme/mesh_theme.dart';
import 'instrument.dart';

/// Asks the analyzer which observers heard the message with [packetHash]
/// and lists them. Nobody hearing it is worded as "not yet", not failure.
Future<void> showObserverReachSheet(BuildContext context, String? packetHash) {
  final analyzer = context.read<AnalyzerService?>();
  if (analyzer == null) return Future.value();
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (sheet) => _ReachSheet(analyzer: analyzer, hash: packetHash),
  );
}

class _ReachSheet extends StatefulWidget {
  const _ReachSheet({required this.analyzer, required this.hash});

  final AnalyzerService analyzer;
  final String? hash;

  @override
  State<_ReachSheet> createState() => _ReachSheetState();
}

class _ReachSheetState extends State<_ReachSheet> {
  Future<List<ObserverHit>?>? _lookup;

  @override
  void initState() {
    super.initState();
    _check();
  }

  void _check() {
    final hash = widget.hash;
    _lookup = hash == null ? null : widget.analyzer.observersOf(hash);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final host = Uri.tryParse(widget.analyzer.url)?.host ?? widget.analyzer.url;
    Widget note(String text) => Padding(
      padding: const EdgeInsets.all(MeshSpace.lg),
      child: Text(
        text,
        style: TextStyle(color: MeshPalette.ink3, fontSize: 14),
      ),
    );
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.75,
        ),
        child: _lookup == null
            ? ListView(
                shrinkWrap: true,
                children: [
                  InstrumentLabel(t.reach_title),
                  note(t.reach_noHash),
                ],
              )
            : FutureBuilder<List<ObserverHit>?>(
                future: _lookup,
                builder: (context, snap) {
                  final hits = snap.data;
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      InstrumentLabel(t.reach_title, trailing: host),
                      if (snap.connectionState != ConnectionState.done)
                        const Padding(
                          padding: EdgeInsets.all(MeshSpace.xl),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else if (hits == null)
                        note(t.reach_unreachable)
                      else if (hits.isEmpty)
                        note(t.reach_none)
                      else ...[
                        ReadoutStrip([
                          Readout('${hits.length}', t.reach_observers),
                          Readout(
                            '${hits.map((h) => h.hops).reduce((a, b) => a > b ? a : b)}',
                            t.reach_maxHops,
                          ),
                          Readout(
                            hits.first.snr == null
                                ? '—'
                                : hits.first.snr!.toStringAsFixed(1),
                            t.reach_bestSnr,
                          ),
                        ]),
                        for (final h in hits)
                          InstrumentRow(
                            title: h.name,
                            subtitle: t.reach_hops(h.hops),
                            trailing: h.snr == null
                                ? null
                                : SignalReadout(h.snr!),
                          ),
                      ],
                      if (snap.connectionState == ConnectionState.done)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            MeshSpace.lg,
                            MeshSpace.sm,
                            MeshSpace.lg,
                            MeshSpace.lg,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  t.reach_explainer,
                                  style: TextStyle(
                                    color: MeshPalette.ink3,
                                    fontSize: 12.5,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () => setState(_check),
                                child: Text(t.reach_checkAgain),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
