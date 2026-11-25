import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';

import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/traffic_route.dart';
import '../services/traffic_feed.dart';
import '../theme/mesh_theme.dart';
import 'mesh_ui.dart';

/// Line and dot colour for each packet kind.
Color trafficColor(TrafficKind kind) => switch (kind) {
  TrafficKind.advert => const Color(0xFFFF5FA2),
  TrafficKind.direct => const Color(0xFF4D9DFF),
  TrafficKind.channel => const Color(0xFF3DDC84),
  TrafficKind.ack => const Color(0xFF22D3EE),
  TrafficKind.trace => const Color(0xFFFF9F43),
  TrafficKind.path => const Color(0xFFB07CFF),
};

String trafficKindLabel(AppLocalizations l10n, TrafficKind kind) =>
    switch (kind) {
      TrafficKind.advert => l10n.traffic_kindAdvert,
      TrafficKind.direct => l10n.traffic_kindDirect,
      TrafficKind.channel => l10n.traffic_kindChannel,
      TrafficKind.ack => l10n.traffic_kindAck,
      TrafficKind.trace => l10n.traffic_kindTrace,
      TrafficKind.path => l10n.traffic_kindPath,
    };

/// A frosted-glass panel that sits over the map.
class FrostedPanel extends StatelessWidget {
  const FrostedPanel({
    super.key,
    required this.child,
    this.radius = MeshRadii.md,
  });

  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: dark
                ? MapPalette.panelDark.withValues(alpha: 0.72)
                : scheme.surfaceContainerLow.withValues(alpha: 0.78),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: dark ? MapPalette.border : scheme.outlineVariant,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Draws the routes [feed] is playing on the map, hop by hop.
class TrafficRouteLayer extends StatefulWidget {
  const TrafficRouteLayer({super.key, required this.feed});

  final TrafficFeed feed;

  @override
  State<TrafficRouteLayer> createState() => _TrafficRouteLayerState();
}

class _TrafficRouteLayerState extends State<TrafficRouteLayer>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker = createTicker((_) {
    if (!widget.feed.tick()) _ticker.stop();
    setState(() {});
  });

  @override
  void initState() {
    super.initState();
    widget.feed.addListener(_onFeed);
    _onFeed();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.feed.reduceMotion = MediaQuery.disableAnimationsOf(context);
  }

  @override
  void didUpdateWidget(TrafficRouteLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.feed != widget.feed) {
      oldWidget.feed.removeListener(_onFeed);
      widget.feed.addListener(_onFeed);
      _onFeed();
    }
  }

  void _onFeed() {
    if (widget.feed.active.isNotEmpty && !_ticker.isActive) _ticker.start();
  }

  @override
  void dispose() {
    widget.feed.removeListener(_onFeed);
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final camera = MapCamera.of(context);
    return IgnorePointer(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _TrafficPainter(
            routes: widget.feed.active,
            camera: camera,
            now: widget.feed.now,
            reduceMotion: widget.feed.reduceMotion,
            labelStyle:
                Theme.of(context).textTheme.labelSmall ?? const TextStyle(),
          ),
        ),
      ),
    );
  }
}

class _TrafficPainter extends CustomPainter {
  _TrafficPainter({
    required this.routes,
    required this.camera,
    required this.now,
    required this.reduceMotion,
    required this.labelStyle,
  });

  final TextStyle labelStyle;
  final List<ActiveTrafficRoute> routes;
  final MapCamera camera;
  final DateTime now;
  final bool reduceMotion;

  @override
  void paint(Canvas canvas, Size size) {
    for (final active in routes) {
      final hops = active.route.mapHops;
      if (hops.length < 2) continue;
      final points = [
        for (final hop in hops) camera.latLngToScreenOffset(hop.position!),
      ];
      final legs = points.length - 1;
      final elapsed = now.difference(active.startedAt);
      final frame = TrafficTiming.frameAt(
        elapsed,
        legs,
        reduceMotion: reduceMotion,
      );
      if (frame.finished) continue;
      final color = trafficColor(active.route.kind);
      final o = frame.opacity;

      final trail = Paint()
        ..color = color.withValues(alpha: 0.8 * o)
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round;
      final ahead = Paint()
        ..color = color.withValues(alpha: 0.5 * o)
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round;

      Offset? dot;
      for (var i = 0; i < legs; i++) {
        final a = points[i], b = points[i + 1];
        if (i < frame.leg) {
          canvas.drawLine(a, b, trail);
        } else if (i == frame.leg && !frame.arrived) {
          dot = Offset.lerp(a, b, frame.legProgress);
          canvas.drawLine(a, dot!, trail);
          _dotted(canvas, dot, b, ahead);
        } else {
          _dotted(canvas, a, b, ahead);
        }
      }

      final pulse = reduceMotion ? 0.5 : (elapsed.inMilliseconds % 1200) / 1200;
      _ring(canvas, points.first, color, pulse, o);
      if (frame.arrived) _ring(canvas, points.last, color, 1 - o, o);

      if (dot != null) {
        canvas.drawCircle(
          dot,
          10,
          Paint()
            ..color = color.withValues(alpha: 0.55)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7),
        );
        canvas.drawCircle(dot, 4.5, Paint()..color = Colors.white);
        canvas.drawCircle(dot, 3, Paint()..color = color);
      }

      for (var i = 0; i < hops.length; i++) {
        _label(canvas, points[i], hops[i].label, o);
      }
    }
  }

  void _dotted(Canvas canvas, Offset a, Offset b, Paint paint) {
    final length = (b - a).distance;
    if (length < 1) return;
    final step = (b - a) / length;
    for (var d = 0.0; d < length; d += 8) {
      final end = math.min(d + 3, length);
      canvas.drawLine(a + step * d, a + step * end, paint);
    }
  }

  void _ring(Canvas canvas, Offset at, Color color, double t, double o) {
    canvas.drawCircle(
      at,
      10 + 16 * t,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = color.withValues(alpha: (1 - t) * 0.8 * o),
    );
  }

  void _label(Canvas canvas, Offset at, String text, double o) {
    final short = text.length > 14 ? '${text.substring(0, 13)}…' : text;
    final painter = TextPainter(
      text: TextSpan(
        text: short,
        style: labelStyle.copyWith(
          color: Colors.white.withValues(alpha: o),
          fontSize: 11,
          fontWeight: FontWeight.w700,
          fontFeatures: const [ui.FontFeature.tabularFigures()],
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    final origin = at + const Offset(12, -20);
    final box = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        origin.dx - 4,
        origin.dy - 2,
        painter.width + 8,
        painter.height + 4,
      ),
      const Radius.circular(4),
    );
    canvas.drawRRect(
      box,
      Paint()..color = Colors.black.withValues(alpha: 0.55 * o),
    );
    painter.paint(canvas, origin);
  }

  @override
  bool shouldRepaint(_TrafficPainter old) => true;
}

/// The latest packet's route, signal and the colour legend.
class TrafficRouteCard extends StatefulWidget {
  const TrafficRouteCard({super.key, required this.route, this.onTap});

  final TrafficRoute? route;
  final VoidCallback? onTap;

  @override
  State<TrafficRouteCard> createState() => _TrafficRouteCardState();
}

class _TrafficRouteCardState extends State<TrafficRouteCard> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Keeps the age ticking.
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    final primary = dark ? MapPalette.textPrimary : theme.colorScheme.onSurface;
    final secondary = dark
        ? MapPalette.textSecondary
        : theme.colorScheme.onSurfaceVariant;
    final route = widget.route;

    final lines = <Widget>[];
    if (route == null) {
      lines.add(
        Text(
          l10n.traffic_listening,
          style: theme.textTheme.bodyMedium?.copyWith(color: secondary),
        ),
      );
    } else {
      final color = trafficColor(route.kind);
      final heard = route.heardFrom;
      final notOnMap = route.notOnMap;
      final snr = route.snr.toStringAsFixed(route.snr % 1 == 0 ? 0 : 1);
      lines
        ..add(
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              [
                for (final hop in route.hops)
                  hop.role == TrafficHopRole.self
                      ? (hop.name ?? context.l10n.pathTrace_you)
                      : hop.label,
              ].join(' → '),
              maxLines: 1,
              style: MeshTheme.mono(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: primary,
              ),
            ),
          ),
        )
        ..add(const SizedBox(height: 4))
        ..add(
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.22),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  trafficKindLabel(l10n, route.kind),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  // A repeater's SNR is only the last leg, not the sender's.
                  heard?.role == TrafficHopRole.repeater
                      ? l10n.traffic_lastHop(heard!.label, snr)
                      : l10n.traffic_heardFrom(
                          heard?.label ?? l10n.traffic_unknown,
                          snr,
                        ),
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: theme.textTheme.bodySmall?.copyWith(color: secondary),
                ),
              ),
            ],
          ),
        )
        ..add(const SizedBox(height: 4))
        ..add(
          Text(
            [
              route.isFlood
                  ? l10n.traffic_flood(route.hopCount)
                  : l10n.traffic_direct,
              l10n.traffic_rssi(route.rssi),
              l10n.traffic_snr(snr),
              if (notOnMap.isNotEmpty)
                l10n.traffic_notOnMapCount(notOnMap.length),
              l10n.traffic_age(route.ageSeconds(DateTime.now())),
            ].join(' · '),
            style: theme.textTheme.bodySmall?.copyWith(color: secondary),
          ),
        );
      if (notOnMap.isNotEmpty) {
        lines.add(
          Text(
            l10n.traffic_notOnMapList(
              notOnMap.map((hop) => hop.label).join(', '),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(color: secondary),
          ),
        );
      }
    }

    return FrostedPanel(
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: route == null ? null : widget.onTap,
          child: Semantics(
            hint: route == null ? null : l10n.traffic_cardHint,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...lines,
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 4,
                    children: [
                      for (final kind in TrafficKind.values)
                        _LegendEntry(
                          color: trafficColor(kind),
                          label: trafficKindLabel(l10n, kind),
                          textColor: secondary,
                        ),
                    ],
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

class _LegendEntry extends StatelessWidget {
  const _LegendEntry({
    required this.color,
    required this.label,
    required this.textColor,
  });

  final Color color;
  final String label;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 4,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: textColor),
        ),
      ],
    );
  }
}

/// One button in [MapToolPill].
class MapToolItem {
  const MapToolItem({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.selected,
    this.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  /// Non-null for toggles: whether it is on.
  final bool? selected;
  final Key? key;
}

/// The frosted vertical toolbar on the right of the map. When the space it
/// gets is too short for labelled buttons it shows icons only, and it
/// scrolls if even those don't fit.
class MapToolPill extends StatelessWidget {
  const MapToolPill({super.key, required this.items});

  final List<MapToolItem> items;

  static const _labelledHeight = 50.0;
  static const _compactHeight = 44.0;
  static const _padding = 6.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact =
            constraints.maxHeight <
            items.length * _labelledHeight + 2 * _padding;
        return SingleChildScrollView(child: _pill(context, compact));
      },
    );
  }

  Widget _pill(BuildContext context, bool compact) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    final idle = dark ? MapPalette.textPrimary : theme.colorScheme.onSurface;
    final on = dark ? MapPalette.selected : theme.colorScheme.primary;
    return FrostedPanel(
      radius: 28,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: _padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final item in items)
              Semantics(
                key: item.key,
                button: true,
                toggled: item.selected,
                label: item.label,
                excludeSemantics: true,
                child: Tooltip(
                  message: item.label,
                  child: InkWell(
                    onTap: item.onPressed,
                    customBorder: const StadiumBorder(),
                    child: SizedBox(
                      width: compact ? 52 : 64,
                      height: compact ? _compactHeight : _labelledHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            item.icon,
                            size: 22,
                            color: item.selected == true ? on : idle,
                          ),
                          if (!compact) const SizedBox(height: 2),
                          if (!compact)
                            Text(
                              item.label,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: item.selected == true ? on : idle,
                                fontWeight: item.selected == true
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Lets the user pick which packet kinds the Traffic map shows.
Future<void> showTrafficFilterSheet(
  BuildContext context, {
  required Set<TrafficKind> kinds,
  required ValueChanged<Set<TrafficKind>> onChanged,
}) {
  var current = kinds.toSet();
  return showMeshSheet<void>(
    context,
    builder: (sheet) => StatefulBuilder(
      builder: (sheet, setSheet) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomSheetHeader(title: sheet.l10n.traffic_filterTitle),
            for (final kind in TrafficKind.values)
              CheckboxListTile(
                key: ValueKey('traffic-filter-${kind.name}'),
                value: current.contains(kind),
                secondary: Icon(Icons.circle, color: trafficColor(kind)),
                title: Text(trafficKindLabel(sheet.l10n, kind)),
                onChanged: (value) {
                  setSheet(() {
                    current = {...current};
                    value == true ? current.add(kind) : current.remove(kind);
                  });
                  onChanged(current);
                },
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    ),
  );
}
