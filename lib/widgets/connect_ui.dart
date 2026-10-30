import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../theme/mesh_theme.dart';
import 'mesh_ui.dart' show glassEdge, glassFill, glassRadius;

/// Small uppercase accent heading that opens a section, matching the home
/// screen's "FIELD TOOLS" label.
class ConsoleKicker extends StatelessWidget {
  const ConsoleKicker(this.text, {super.key, this.trailing});

  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 4, 10),
      child: Row(
        children: [
          Expanded(child: Text(text, style: MeshTheme.sectionTitle())),
          ?trailing,
        ],
      ),
    );
  }
}

/// Rounded block used for the hero panels on the connection screens.
class ConsolePanel extends StatelessWidget {
  const ConsolePanel({
    super.key,
    required this.child,
    this.borderColor,
    this.padding = const EdgeInsets.all(18),
  });

  final Widget child;
  final Color? borderColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: glassFill(context),
        border: Border.all(color: borderColor ?? glassEdge(context)),
        borderRadius: BorderRadius.circular(glassRadius),
      ),
      child: child,
    );
  }
}

/// Concentric rings around a radio icon. While [active] they ripple outward,
/// unless the system asks for reduced motion.
class RadarPulse extends StatefulWidget {
  const RadarPulse({
    super.key,
    required this.active,
    required this.icon,
    required this.color,
    this.size = 112,
  });

  final bool active;
  final IconData icon;
  final Color color;
  final double size;

  @override
  State<RadarPulse> createState() => _RadarPulseState();
}

class _RadarPulseState extends State<RadarPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sync();
  }

  @override
  void didUpdateWidget(RadarPulse oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.active != widget.active) _sync();
  }

  void _sync() {
    final animate = widget.active && !MediaQuery.disableAnimationsOf(context);
    if (animate) {
      if (!_controller.isAnimating) _controller.repeat();
    } else {
      _controller
        ..stop()
        ..value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    return ExcludeSemantics(
      child: RepaintBoundary(
        child: SizedBox.square(
          dimension: size,
          child: CustomPaint(
            painter: _RadarPainter(
              progress: _controller,
              color: widget.color,
              active: widget.active,
            ),
            child: Center(
              child: Container(
                width: size * 0.42,
                height: size * 0.42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color.withValues(alpha: 0.14),
                  border: Border.all(
                    color: widget.color.withValues(alpha: 0.55),
                  ),
                ),
                child: Icon(widget.icon, color: widget.color, size: size * 0.2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  _RadarPainter({
    required this.progress,
    required this.color,
    required this.active,
  }) : super(repaint: progress);

  final Animation<double> progress;
  final Color color;
  final bool active;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final maxRadius = size.shortestSide / 2;
    final minRadius = maxRadius * 0.21;
    final guide = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = color.withValues(alpha: 0.16);
    for (final f in const [0.55, 0.78, 1.0]) {
      canvas.drawCircle(center, maxRadius * f - 1, guide);
    }
    if (!active) return;
    final wave = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (var i = 0; i < 3; i++) {
      final t = (progress.value + i / 3) % 1.0;
      wave.color = color.withValues(alpha: (1 - t) * 0.55);
      canvas.drawCircle(
        center,
        minRadius + (maxRadius - minRadius - 1) * t,
        wave,
      );
    }
  }

  @override
  bool shouldRepaint(_RadarPainter old) =>
      old.color != color || old.active != active;
}

/// How well a phone hears a radio over Bluetooth.
enum BleSignalQuality { strong, good, fair, weak }

/// Buckets a Bluetooth RSSI in dBm; 0 means unknown (Linux paired devices).
BleSignalQuality bleSignalQuality(int rssi) {
  if (rssi == 0 || rssi >= -62) return BleSignalQuality.strong;
  if (rssi >= -74) return BleSignalQuality.good;
  if (rssi >= -86) return BleSignalQuality.fair;
  return BleSignalQuality.weak;
}

/// The word shown next to the bars, so strength isn't told by color alone.
String bleSignalQualityLabel(AppLocalizations l10n, BleSignalQuality q) =>
    switch (q) {
      BleSignalQuality.strong => l10n.scanner_signalStrong,
      BleSignalQuality.good => l10n.scanner_signalGood,
      BleSignalQuality.fair => l10n.scanner_signalFair,
      BleSignalQuality.weak => l10n.scanner_signalWeak,
    };

/// Four rising bars for a [BleSignalQuality].
class BleSignalBars extends StatelessWidget {
  const BleSignalBars({super.key, required this.quality});

  final BleSignalQuality quality;

  @override
  Widget build(BuildContext context) {
    final lit = switch (quality) {
      BleSignalQuality.strong => 4,
      BleSignalQuality.good => 3,
      BleSignalQuality.fair => 2,
      BleSignalQuality.weak => 1,
    };
    final color = bleSignalColor(quality);
    return ExcludeSemantics(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < 4; i++)
            Container(
              width: 4,
              height: 6.0 + i * 3.5,
              margin: const EdgeInsetsDirectional.only(start: 2),
              decoration: BoxDecoration(
                color: i < lit ? color : MeshPalette.line2,
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
        ],
      ),
    );
  }
}

/// Signal color: green when strong, amber when fair, red when weak.
Color bleSignalColor(BleSignalQuality quality) => switch (quality) {
  BleSignalQuality.strong || BleSignalQuality.good => MeshPalette.signal,
  BleSignalQuality.fair => MeshPalette.warn,
  BleSignalQuality.weak => MeshPalette.alert,
};

/// A large button for one way to connect (Bluetooth, USB, Wi-Fi).
class TransportTile extends StatelessWidget {
  const TransportTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return Semantics(
      button: true,
      enabled: enabled,
      child: Material(
        color: MeshPalette.bg2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: MeshPalette.line),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Opacity(
            opacity: enabled ? 1 : 0.5,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: MeshPalette.accentBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: MeshPalette.accent, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: MeshPalette.ink,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: MeshPalette.ink3,
                            fontSize: 12,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: MeshPalette.ink3,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Lays [children] out in two columns when there's room, else stacked.
class ResponsiveTilePair extends StatelessWidget {
  const ResponsiveTilePair({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 520 || children.length < 2) {
          return Column(
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) const SizedBox(height: 10),
                children[i],
              ],
            ],
          );
        }
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) const SizedBox(width: 10),
                Expanded(child: children[i]),
              ],
            ],
          ),
        );
      },
    );
  }
}
