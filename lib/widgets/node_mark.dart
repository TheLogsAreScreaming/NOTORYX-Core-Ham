import 'package:flutter/material.dart';

import '../models/node_journal.dart';

/// A node's generated mark: the same pattern and colours for the same
/// public key on every phone.
class NodeMark extends StatelessWidget {
  const NodeMark({
    super.key,
    required this.nodeKey,
    this.size = 40,
    this.semanticLabel,
  });

  final String nodeKey;
  final double size;

  /// Read out when set; otherwise the mark is decoration only.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final mark = SizedBox.square(
      dimension: size,
      child: CustomPaint(painter: _NodeMarkPainter(nodeMarkFor(nodeKey))),
    );
    final label = semanticLabel;
    if (label == null) return ExcludeSemantics(child: mark);
    return Semantics(
      image: true,
      label: label,
      child: ExcludeSemantics(child: mark),
    );
  }
}

class _NodeMarkPainter extends CustomPainter {
  _NodeMarkPainter(this.spec);
  final NodeMarkSpec spec;

  @override
  void paint(Canvas canvas, Size size) {
    final r = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(size.width * 0.22),
    );
    canvas.drawRRect(
      r,
      Paint()
        ..color = HSLColor.fromAHSL(1, spec.accentHue, 0.35, 0.22).toColor(),
    );
    final pad = size.width * 0.14;
    final cell = (size.width - 2 * pad) / 5;
    final fill = Paint()
      ..color = HSLColor.fromAHSL(1, spec.hue, 0.65, 0.62).toColor();
    for (var i = 0; i < 25; i++) {
      if (!spec.cells[i]) continue;
      final rect = Rect.fromLTWH(
        pad + (i % 5) * cell,
        pad + (i ~/ 5) * cell,
        cell,
        cell,
      ).deflate(cell * 0.08);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(cell * 0.25)),
        fill,
      );
    }
  }

  @override
  bool shouldRepaint(_NodeMarkPainter old) => old.spec != spec;
}
