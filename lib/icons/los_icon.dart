import 'dart:math' as math;

import 'package:flutter/material.dart';

class LosIcon extends StatelessWidget {
  final double size;
  final Color? color;

  const LosIcon({
    super.key,
    this.size = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? IconTheme.of(context).color ?? Colors.black;
    final canvasSize = size;

    return SizedBox(
      width: canvasSize,
      height: canvasSize,
      child: CustomPaint(
        painter: _LosIconPainter(iconColor),
      ),
    );
  }
}

class _LosIconPainter extends CustomPainter {
  final Color color;

  _LosIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(82, -120)
      ..relativeLineTo(258, -360)
      ..relativeLineTo(202, 0)
      ..relativeLineTo(298, -348)
      ..relativeLineTo(0, 708)
      ..lineTo(82, -120)
      ..close()
      ..moveTo(152, -353)
      ..relativeLineTo(-64, -46)
      ..relativeLineTo(172, -241)
      ..relativeLineTo(202, 0)
      ..relativeLineTo(188, -219)
      ..relativeLineTo(60, 52)
      ..relativeLineTo(-212, 247)
      ..lineTo(300, -560)
      ..lineTo(152, -353)
      ..close()
      ..moveTo(238, -200)
      ..relativeLineTo(522, 0)
      ..relativeLineTo(0, -412)
      ..lineTo(578, -400)
      ..lineTo(380, -400)
      ..lineTo(238, -200)
      ..close();

    final scale = math.min(size.width, size.height) / 960;

    canvas.save();
    canvas.translate(0, 960);
    canvas.scale(scale, scale);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _LosIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
