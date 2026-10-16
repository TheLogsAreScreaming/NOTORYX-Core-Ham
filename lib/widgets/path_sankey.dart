import 'dart:math';

import 'package:flutter/material.dart';

import '../models/path_graph.dart';

/// A node's box in the chart.
class SankeyBox {
  final String id;
  final String label;
  final Rect rect;
  final int column;
  const SankeyBox(this.id, this.label, this.rect, this.column);
}

/// A flow band from one box's right edge to another's left edge.
class SankeyBand {
  final String from;
  final String to;
  final int count;

  /// Top of the band at its start and end, and its thickness.
  final double y0;
  final double y1;
  final double thickness;
  final double x0;
  final double x1;
  const SankeyBand({
    required this.from,
    required this.to,
    required this.count,
    required this.y0,
    required this.y1,
    required this.thickness,
    required this.x0,
    required this.x1,
  });
}

class SankeyLayout {
  final List<SankeyBox> boxes;
  final List<SankeyBand> bands;
  const SankeyLayout(this.boxes, this.bands);
}

/// Lays out [graph] in [size]: far hops on the left, you on the right.
/// Each column keeps its [maxPerColumn] busiest repeaters.
SankeyLayout layoutSankey(
  PathGraph graph,
  Size size, {
  int maxDepth = 5,
  int maxPerColumn = 8,
  double nodeWidth = 10,
  double gap = 10,
}) {
  final columns = [
    for (final col in graph.columns(maxDepth: maxDepth))
      col.take(maxPerColumn).toList(),
  ].reversed.toList(); // left = farthest, right = you
  final shown = {for (final c in columns) ...c};
  final links = graph.links
      .where((l) => shown.contains(l.from) && shown.contains(l.to))
      .toList();
  if (links.isEmpty) return const SankeyLayout([], []);

  // A node's height follows the larger of its incoming and outgoing flow.
  final inFlow = <String, int>{}, outFlow = <String, int>{};
  for (final l in links) {
    outFlow[l.from] = (outFlow[l.from] ?? 0) + l.count;
    inFlow[l.to] = (inFlow[l.to] ?? 0) + l.count;
  }
  int flow(String id) => max(inFlow[id] ?? 0, outFlow[id] ?? 0);

  // One scale for every column, set by the most crowded one.
  var scale = double.infinity;
  for (final col in columns) {
    final total = col.fold<int>(0, (s, id) => s + flow(id));
    if (total == 0) continue;
    final room = size.height - gap * (col.length - 1);
    scale = min(scale, room / total);
  }
  if (!scale.isFinite || scale <= 0) return const SankeyLayout([], []);

  final step = columns.length == 1
      ? 0.0
      : (size.width - nodeWidth) / (columns.length - 1);
  final boxes = <String, SankeyBox>{};
  for (var c = 0; c < columns.length; c++) {
    var y = 0.0;
    for (final id in columns[c]) {
      final h = max(2.0, flow(id) * scale);
      final node = graph.nodes[id];
      boxes[id] = SankeyBox(
        id,
        node?.label ?? id,
        Rect.fromLTWH(c * step, y, nodeWidth, h),
        c,
      );
      y += h + gap;
    }
  }

  // Stack bands down each node's edges, biggest first.
  final outUsed = <String, double>{}, inUsed = <String, double>{};
  final bands = <SankeyBand>[];
  for (final l in links) {
    final a = boxes[l.from]!, b = boxes[l.to]!;
    final t = max(1.0, l.count * scale);
    final y0 = a.rect.top + (outUsed[l.from] ?? 0);
    final y1 = b.rect.top + (inUsed[l.to] ?? 0);
    outUsed[l.from] = (outUsed[l.from] ?? 0) + t;
    inUsed[l.to] = (inUsed[l.to] ?? 0) + t;
    bands.add(
      SankeyBand(
        from: l.from,
        to: l.to,
        count: l.count,
        y0: y0,
        y1: y1,
        thickness: t,
        x0: a.rect.right,
        x1: b.rect.left,
      ),
    );
  }
  return SankeyLayout(boxes.values.toList(), bands);
}

/// Draws a [SankeyLayout]. Colours come from the theme passed in.
class PathSankeyPainter extends CustomPainter {
  final SankeyLayout layout;
  final Color nodeColor;
  final Color selfColor;
  final Color bandColor;
  final Color ambiguousColor;
  final TextStyle labelStyle;
  final Color labelBackground;
  final Set<String> ambiguous;

  PathSankeyPainter({
    required this.layout,
    required this.nodeColor,
    required this.selfColor,
    required this.bandColor,
    required this.ambiguousColor,
    required this.labelStyle,
    required this.labelBackground,
    required this.ambiguous,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final band = Paint()..color = bandColor;
    for (final b in layout.bands) {
      final mid = (b.x0 + b.x1) / 2;
      final path = Path()
        ..moveTo(b.x0, b.y0)
        ..cubicTo(mid, b.y0, mid, b.y1, b.x1, b.y1)
        ..lineTo(b.x1, b.y1 + b.thickness)
        ..cubicTo(
          mid,
          b.y1 + b.thickness,
          mid,
          b.y0 + b.thickness,
          b.x0,
          b.y0 + b.thickness,
        )
        ..close();
      canvas.drawPath(path, band);
    }
    final lastColumn = layout.boxes.fold<int>(0, (m, b) => max(m, b.column));
    for (final box in layout.boxes) {
      final color = box.id == pathGraphSelf
          ? selfColor
          : ambiguous.contains(box.id)
          ? ambiguousColor
          : nodeColor;
      canvas.drawRRect(
        RRect.fromRectAndRadius(box.rect, const Radius.circular(2)),
        Paint()..color = color,
      );
      final text = TextPainter(
        text: TextSpan(text: box.label, style: labelStyle),
        textDirection: TextDirection.ltr,
        maxLines: 1,
        ellipsis: '…',
      )..layout(maxWidth: 90);
      // Labels sit inside the chart: right of a box, or left of the last one.
      final dx = box.column == lastColumn
          ? box.rect.left - text.width - 4
          : box.rect.right + 4;
      // The last column's label sits at its top so it can't meet the
      // centred label of the column beside it.
      final dy = box.column == lastColumn
          ? box.rect.top + 2
          : box.rect.center.dy - text.height / 2;
      final at = Offset(dx, dy.clamp(0, size.height - text.height));
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          (at & text.size).inflate(2),
          const Radius.circular(3),
        ),
        Paint()..color = labelBackground,
      );
      text.paint(canvas, at);
    }
  }

  @override
  bool shouldRepaint(PathSankeyPainter old) =>
      old.layout != layout ||
      old.nodeColor != nodeColor ||
      old.bandColor != bandColor;
}
