import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/mesh_theme.dart';

/// One point on a [TimeSeriesChart].
typedef TimePoint = ({DateTime at, double value});

/// A small line chart of values over time, from [start] to [end].
///
/// The painter is decorative; screen readers get [semanticsLabel].
class TimeSeriesChart extends StatelessWidget {
  const TimeSeriesChart({
    super.key,
    required this.points,
    required this.start,
    required this.end,
    required this.semanticsLabel,
    this.format,
    this.minSpan = 1,
    this.threshold,
    this.height = 120,
    this.color,
  });

  final List<TimePoint> points;
  final DateTime start;
  final DateTime end;
  final String semanticsLabel;

  /// How the high and low labels are written; one decimal by default.
  final String Function(double value)? format;

  /// The smallest value range drawn, so steady readings read as flat.
  final double minSpan;

  /// A dashed line drawn at this value, such as an alert threshold.
  final double? threshold;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final style = DefaultTextStyle.of(
      context,
    ).style.copyWith(color: MeshPalette.ink3, fontSize: 10);
    return Semantics(
      container: true,
      label: semanticsLabel,
      child: ExcludeSemantics(
        child: SizedBox(
          height: height,
          width: double.infinity,
          child: points.isEmpty
              ? null
              : CustomPaint(
                  painter: _TimeSeriesPainter(
                    points: points,
                    start: start,
                    end: end,
                    format: format ?? (v) => v.toStringAsFixed(1),
                    minSpan: minSpan,
                    threshold: threshold,
                    labelStyle: style,
                    line: color ?? MeshPalette.accent,
                    grid: MeshPalette.line,
                  ),
                ),
        ),
      ),
    );
  }
}

class _TimeSeriesPainter extends CustomPainter {
  _TimeSeriesPainter({
    required this.points,
    required this.start,
    required this.end,
    required this.format,
    required this.minSpan,
    required this.threshold,
    required this.labelStyle,
    required this.line,
    required this.grid,
  });

  final List<TimePoint> points;
  final DateTime start;
  final DateTime end;
  final String Function(double) format;
  final double minSpan;
  final double? threshold;
  final TextStyle labelStyle;
  final Color line;
  final Color grid;

  @override
  void paint(Canvas canvas, Size size) {
    var lo = points.map((p) => p.value).reduce(math.min);
    var hi = points.map((p) => p.value).reduce(math.max);
    final t = threshold;
    if (t != null) {
      lo = math.min(lo, t);
      hi = math.max(hi, t);
    }
    if (hi - lo < minSpan) {
      final mid = (hi + lo) / 2;
      lo = mid - minSpan / 2;
      hi = mid + minSpan / 2;
    }
    final span = math.max(1, end.difference(start).inMilliseconds).toDouble();
    const labelWidth = 40.0;
    final plot = Rect.fromLTWH(
      labelWidth,
      6,
      math.max(1, size.width - labelWidth),
      math.max(1, size.height - 12),
    );
    double y(double v) => plot.bottom - plot.height * (v - lo) / (hi - lo);
    Offset at(TimePoint p) => Offset(
      plot.left +
          plot.width *
              (p.at.difference(start).inMilliseconds / span).clamp(0.0, 1.0),
      y(p.value),
    );

    final gridPaint = Paint()
      ..color = grid
      ..strokeWidth = 1;
    for (final (py, v) in [(plot.top, hi), (plot.bottom, lo)]) {
      canvas.drawLine(Offset(plot.left, py), Offset(plot.right, py), gridPaint);
      final tp = TextPainter(
        text: TextSpan(text: format(v), style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: labelWidth - 4);
      tp.paint(canvas, Offset(0, py - tp.height / 2));
    }

    if (t != null) {
      final ty = y(t);
      final dash = Paint()
        ..color = MeshPalette.warn
        ..strokeWidth = 1.5;
      for (var x = plot.left; x < plot.right; x += 8) {
        canvas.drawLine(
          Offset(x, ty),
          Offset(math.min(x + 4, plot.right), ty),
          dash,
        );
      }
    }

    final offsets = points.map(at).toList();
    final paint = Paint()
      ..color = line
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    if (offsets.length == 1) {
      canvas.drawCircle(offsets.single, 3, paint..style = PaintingStyle.fill);
      return;
    }
    final path = Path()..moveTo(offsets.first.dx, offsets.first.dy);
    for (final p in offsets.skip(1)) {
      path.lineTo(p.dx, p.dy);
    }
    canvas.drawPath(path, paint);
    canvas.drawCircle(offsets.last, 3, paint..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(_TimeSeriesPainter old) =>
      old.points != points ||
      old.start != start ||
      old.end != end ||
      old.threshold != threshold ||
      old.line != line ||
      old.labelStyle != labelStyle;
}
