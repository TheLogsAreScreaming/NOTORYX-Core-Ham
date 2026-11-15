import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../services/backdrop_store.dart';

/// Draws a background the person chose: a colour, a gradient, a mesh of
/// soft colour or a photo, with the theme's ground laid over it at
/// [BackdropStyle.dim] so the glass cards and their text stay readable.
class CustomBackdrop extends StatelessWidget {
  const CustomBackdrop({
    super.key,
    required this.style,
    required this.ground,
    this.photo,
    this.reduceEffects = false,
  });

  final BackdropStyle style;
  final Uint8List? photo;

  /// The theme's background colour, used for the dimming layer.
  final Color ground;

  /// Skips the photo blur (reduced motion / low power).
  final bool reduceEffects;

  @override
  Widget build(BuildContext context) {
    final c1 = Color(style.color1);
    final c2 = Color(style.color2);
    final Widget base = switch (style.kind) {
      BackdropKind.theme || BackdropKind.solid => ColoredBox(color: c1),
      BackdropKind.linear => DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [c1, c2],
          ),
        ),
      ),
      BackdropKind.mesh => RepaintBoundary(
        child: CustomPaint(painter: MeshGradientPainter(c1, c2)),
      ),
      BackdropKind.photo => _photo(c1),
    };
    return ExcludeSemantics(
      child: Stack(
        fit: StackFit.expand,
        children: [
          base,
          ColoredBox(color: ground.withValues(alpha: style.dim)),
        ],
      ),
    );
  }

  Widget _photo(Color fallback) {
    final bytes = photo;
    if (bytes == null || bytes.isEmpty) return ColoredBox(color: fallback);
    final image = Image.memory(
      bytes,
      fit: BoxFit.cover,
      gaplessPlayback: true,
      errorBuilder: (_, _, _) => ColoredBox(color: fallback),
    );
    final sigma = reduceEffects ? 0.0 : style.blur;
    if (sigma <= 0) return RepaintBoundary(child: image);
    return RepaintBoundary(
      child: ClipRect(
        child: ImageFiltered(
          imageFilter: ui.ImageFilter.blur(
            sigmaX: sigma,
            sigmaY: sigma,
            tileMode: TileMode.clamp,
          ),
          child: image,
        ),
      ),
    );
  }
}

/// Soft overlapping blobs of two colours, blended between them, like a
/// mesh gradient.
class MeshGradientPainter extends CustomPainter {
  MeshGradientPainter(this.a, this.b);

  final Color a;
  final Color b;

  @override
  void paint(Canvas canvas, Size size) {
    final darker = a.computeLuminance() <= b.computeLuminance() ? a : b;
    canvas.drawRect(Offset.zero & size, Paint()..color = darker);
    final mid = Color.lerp(a, b, 0.5)!;
    final s = size.shortestSide;
    final blobs = [
      (Offset(size.width * 0.15, size.height * 0.12), s * 0.95, a),
      (Offset(size.width * 0.95, size.height * 0.35), s * 0.85, b),
      (Offset(size.width * 0.25, size.height * 0.80), s * 0.90, b),
      (Offset(size.width * 0.85, size.height * 0.95), s * 0.80, a),
      (Offset(size.width * 0.55, size.height * 0.55), s * 0.70, mid),
    ];
    for (final (centre, radius, colour) in blobs) {
      canvas.drawCircle(
        centre,
        radius,
        Paint()
          ..shader = RadialGradient(
            colors: [colour, colour.withValues(alpha: 0)],
          ).createShader(Rect.fromCircle(center: centre, radius: radius)),
      );
    }
  }

  @override
  bool shouldRepaint(MeshGradientPainter old) => old.a != a || old.b != b;
}
