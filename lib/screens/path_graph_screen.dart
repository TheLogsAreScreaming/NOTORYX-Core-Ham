import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../models/path_graph.dart';
import '../services/path_graph_source.dart';
import '../theme/mesh_theme.dart';
import '../widgets/path_sankey.dart';

/// How messages reach you: every path heard on channel messages, combined
/// into one graph and drawn as flows from far repeaters to you.
class PathGraphScreen extends StatefulWidget {
  const PathGraphScreen({super.key});

  @override
  State<PathGraphScreen> createState() => _PathGraphScreenState();
}

enum _Range {
  day('24 hours', Duration(days: 1)),
  week('7 days', Duration(days: 7)),
  all('All', null);

  const _Range(this.label, this.age);
  final String label;
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

  @override
  Widget build(BuildContext context) {
    final graph = _graph;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Path graph')),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Wrap(
              spacing: 8,
              children: [
                for (final r in _Range.values)
                  ChoiceChip(
                    label: Text(r.label),
                    selected: r == _range,
                    onSelected: (_) {
                      setState(() => _range = r);
                      _load();
                    },
                  ),
              ],
            ),
            const SizedBox(height: 12),
            if (_loading && graph == null)
              const Center(child: CircularProgressIndicator())
            else if (graph == null || graph.links.isEmpty)
              const _Empty()
            else ...[
              Text(
                '$_messages paths heard • ${graph.busiest.length} repeaters',
                key: const ValueKey('path-graph-summary'),
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                graph.upgradedHops == 0 && graph.ambiguousHops == 0
                    ? 'Each hop is shown by its hash prefix, or its name when you know the repeater.'
                    : '${graph.upgradedHops} short (1-byte) hops matched to a specific repeater using longer paths'
                          '${graph.ambiguousHops == 0 ? '.' : ' • ${graph.ambiguousHops} still ambiguous (marked ?).'}',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              _Chart(graph: graph),
              const SizedBox(height: 4),
              Text(
                'Left: repeaters farther away. Right: you. Band width is how many messages took that hop.',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              Text('Busiest repeaters', style: theme.textTheme.titleSmall),
              const SizedBox(height: 4),
              for (final n in graph.busiest.take(15))
                _RepeaterRow(node: n, max: graph.busiest.first.relays),
            ],
          ],
        ),
      ),
    );
  }
}

class _Chart extends StatelessWidget {
  final PathGraph graph;
  const _Chart({required this.graph});

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
          label:
              'Path graph. Busiest repeater ${graph.busiest.first.label}, relayed ${graph.busiest.first.relays} messages.',
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
        );
      },
    );
  }
}

class _RepeaterRow extends StatelessWidget {
  final PathNode node;
  final int max;
  const _RepeaterRow({required this.node, required this.max});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              node.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: node.relays / max,
                minHeight: 8,
                color: node.ambiguous ? MapPalette.stale : scheme.primary,
                backgroundColor: scheme.surfaceContainerHighest,
              ),
            ),
          ),
          SizedBox(
            width: 44,
            child: Text(
              '${node.relays}',
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(vertical: 32),
    child: Text(
      'No channel message paths in this period yet. Paths are collected from channel messages you receive while message tracing is on.',
      textAlign: TextAlign.center,
    ),
  );
}
