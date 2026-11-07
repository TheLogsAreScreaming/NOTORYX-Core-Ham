import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../l10n/l10n.dart';
import '../models/path_graph.dart';
import '../services/path_graph_source.dart';
import '../theme/mesh_theme.dart';
import '../widgets/ember_backdrop.dart';
import '../widgets/instrument.dart';
import '../widgets/mesh_ui.dart';
import '../widgets/node_sheet.dart';
import '../widgets/path_sankey.dart';

/// How messages reach you: every path heard on channel messages, combined
/// into one graph and drawn as flows from far repeaters to you. Tap a box
/// in the chart, or a busiest repeater, to see where its traffic comes from
/// and goes.
class PathGraphScreen extends StatefulWidget {
  const PathGraphScreen({super.key});

  @override
  State<PathGraphScreen> createState() => _PathGraphScreenState();
}

enum _Range {
  day(Duration(days: 1)),
  week(Duration(days: 7)),
  all(null);

  const _Range(this.age);
  final Duration? age;
}

class _PathGraphScreenState extends State<PathGraphScreen> {
  _Range _range = _Range.week;
  PathGraph? _graph;
  int _messages = 0;
  bool _loading = true;
  int _run = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final run = ++_run;
    setState(() => _loading = true);
    final connector = context.read<MeshCoreConnector>();
    final age = _range.age;
    final paths = await collectChannelPaths(
      connector,
      since: age == null ? null : DateTime.now().subtract(age),
    );
    if (!mounted || run != _run) return;
    setState(() {
      _graph = PathGraph.build(paths, contacts: connector.contacts);
      _messages = paths.length;
      _loading = false;
    });
  }

  String _label(PathGraph graph, String id) => id == pathGraphSelf
      ? context.l10n.pathGraph_you
      : (graph.nodes[id]?.label ?? id);

  /// Where [id]'s traffic comes from and goes, and the repeater itself
  /// when it's one of your contacts.
  void _showHop(PathGraph graph, String id) {
    final l10n = context.l10n;
    final node = graph.nodes[id];
    if (node == null) return;
    final from = graph.links.where((l) => l.to == id).toList()
      ..sort((a, b) => b.count.compareTo(a.count));
    final to = graph.links.where((l) => l.from == id).toList()
      ..sort((a, b) => b.count.compareTo(a.count));
    final matches = node.ambiguous
        ? const []
        : context
              .read<MeshCoreConnector>()
              .contacts
              .where(
                (c) =>
                    c.type == advTypeRepeater &&
                    c.publicKeyHex.toUpperCase().startsWith(id.toUpperCase()),
              )
              .toList();
    final contact = matches.length == 1 ? matches.single : null;

    showMeshSheet<void>(
      context,
      builder: (sheet) => SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(sheet).height * 0.8,
          ),
          child: Column(
            key: const ValueKey('hop-sheet'),
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BottomSheetHeader(
                title: node.label,
                subtitle: l10n.pathGraph_relayed(node.relays),
              ),
              if (node.ambiguous)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: MeshSpace.lg),
                  child: Text(
                    l10n.pathGraph_ambiguousNote,
                    style: TextStyle(color: MeshPalette.warn, fontSize: 13),
                  ),
                ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    if (from.isNotEmpty)
                      InstrumentLabel(l10n.pathGraph_comesFrom),
                    for (final l in from)
                      InstrumentRow(
                        icon: Icons.call_received,
                        title: _label(graph, l.from),
                        trailing: Text('${l.count}'),
                        onTap: () {
                          Navigator.pop(sheet);
                          _showHop(graph, l.from);
                        },
                        divider: false,
                      ),
                    if (to.isNotEmpty) InstrumentLabel(l10n.pathGraph_goesTo),
                    for (final l in to)
                      InstrumentRow(
                        icon: Icons.call_made,
                        title: _label(graph, l.to),
                        trailing: Text('${l.count}'),
                        onTap: l.to == pathGraphSelf
                            ? null
                            : () {
                                Navigator.pop(sheet);
                                _showHop(graph, l.to);
                              },
                        divider: false,
                      ),
                  ],
                ),
              ),
              if (contact != null)
                Padding(
                  padding: const EdgeInsets.all(MeshSpace.lg),
                  child: InstrumentButton(
                    key: const ValueKey('hop-repeater-details'),
                    label: l10n.pathGraph_repeaterDetails,
                    icon: Icons.cell_tower,
                    onPressed: () {
                      Navigator.pop(sheet);
                      showNodeSheet(context, contact);
                    },
                  ),
                )
              else
                const SizedBox(height: MeshSpace.lg),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final graph = _graph;
    String rangeLabel(_Range r) => switch (r) {
      _Range.day => l10n.fieldIntel_h24,
      _Range.week => l10n.pathGraph_days7,
      _Range.all => l10n.repeaterTools_filterAll,
    };

    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: Text(l10n.tools_pathGraph),
        ),
        body: RefreshIndicator(
          onRefresh: _load,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              MeshSpace.lg,
              MeshSpace.sm,
              MeshSpace.lg,
              MeshSpace.xxl,
            ),
            children: [
              Wrap(
                spacing: MeshSpace.sm,
                children: [
                  for (final r in _Range.values)
                    ChoiceChip(
                      label: Text(rangeLabel(r)),
                      selected: r == _range,
                      onSelected: (_) {
                        setState(() => _range = r);
                        _load();
                      },
                    ),
                ],
              ),
              const SizedBox(height: MeshSpace.md),
              if (_loading && graph == null)
                const Center(child: CircularProgressIndicator())
              else if (graph == null || graph.links.isEmpty)
                MeshCard(
                  margin: EdgeInsets.zero,
                  child: Text(
                    l10n.pathGraph_empty,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: MeshPalette.ink2),
                  ),
                )
              else ...[
                Text(
                  l10n.pathGraph_summary(_messages, graph.busiest.length),
                  key: const ValueKey('path-graph-summary'),
                  style: TextStyle(
                    color: MeshPalette.ink,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  graph.upgradedHops == 0 && graph.ambiguousHops == 0
                      ? l10n.pathGraph_hashOnly
                      : graph.ambiguousHops == 0
                      ? l10n.pathGraph_matched(graph.upgradedHops)
                      : l10n.pathGraph_matchedAmbiguous(
                          graph.upgradedHops,
                          graph.ambiguousHops,
                        ),
                  style: TextStyle(color: MeshPalette.ink3, fontSize: 12),
                ),
                const SizedBox(height: MeshSpace.md),
                MeshCard(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.all(MeshSpace.sm),
                  child: _Chart(
                    graph: graph,
                    onTapNode: (id) => _showHop(graph, id),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.pathGraph_chartHint,
                  style: TextStyle(color: MeshPalette.ink3, fontSize: 12),
                ),
                InstrumentLabel(l10n.pathGraph_busiest),
                MeshCard(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      for (final n in graph.busiest.take(15))
                        _RepeaterRow(
                          key: ValueKey('busiest-${n.id}'),
                          node: n,
                          max: graph.busiest.first.relays,
                          onTap: () => _showHop(graph, n.id),
                        ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Chart extends StatelessWidget {
  final PathGraph graph;
  final ValueChanged<String> onTapNode;
  const _Chart({required this.graph, required this.onTapNode});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, 280);
        final layout = layoutSankey(graph, size);
        final ambiguous = {
          for (final n in graph.nodes.values)
            if (n.ambiguous) n.id,
        };
        return Semantics(
          label: context.l10n.pathGraph_chartSemantics(
            graph.busiest.first.label,
            graph.busiest.first.relays,
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            // Boxes are thin, so a tap near one counts.
            onTapUp: (d) {
              for (final box in layout.boxes) {
                if (box.id == pathGraphSelf) continue;
                if (box.rect.inflate(14).contains(d.localPosition)) {
                  onTapNode(box.id);
                  return;
                }
              }
            },
            child: SizedBox.fromSize(
              key: const ValueKey('path-sankey'),
              size: size,
              child: CustomPaint(
                painter: PathSankeyPainter(
                  layout: layout,
                  nodeColor: scheme.primary,
                  selfColor: MapPalette.cluster,
                  bandColor: scheme.primary.withValues(alpha: .28),
                  ambiguousColor: MapPalette.stale,
                  ambiguous: ambiguous,
                  labelStyle:
                      (Theme.of(context).textTheme.labelSmall ??
                              const TextStyle())
                          .copyWith(
                            color: scheme.onSurface,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                  labelBackground: scheme.surface.withValues(alpha: .8),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RepeaterRow extends StatelessWidget {
  final PathNode node;
  final int max;
  final VoidCallback onTap;
  const _RepeaterRow({
    super.key,
    required this.node,
    required this.max,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          children: [
            SizedBox(
              width: 130,
              child: Text(
                node.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: MeshPalette.ink),
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: node.relays / max,
                  minHeight: 8,
                  color: node.ambiguous ? MapPalette.stale : scheme.primary,
                  backgroundColor: MeshPalette.line,
                ),
              ),
            ),
            SizedBox(
              width: 44,
              child: Text(
                '${node.relays}',
                textAlign: TextAlign.end,
                style: MeshTheme.mono(color: MeshPalette.ink, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
