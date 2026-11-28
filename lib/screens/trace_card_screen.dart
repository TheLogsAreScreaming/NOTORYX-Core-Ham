import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/app_settings.dart';
import '../models/trace_card.dart';
import '../services/app_settings_service.dart';
import '../theme/mesh_theme.dart';

String _snr(AppLocalizations l10n, double? snr) =>
    snr == null ? l10n.traceCard_snrUnknown : '${snr.toStringAsFixed(1)} dB';

String _distance(double meters, bool imperial) => imperial
    ? '${(meters / 1609.344).toStringAsFixed(2)} mi'
    : '${(meters / 1000).toStringAsFixed(2)} km';

String _roundTrip(Duration d) => (d.inMilliseconds / 1000).toStringAsFixed(1);

String _when(DateTime t, String locale) =>
    DateFormat.yMMMd(locale).add_Hm().format(t.toLocal());

/// The trace card as plain text, for sharing where images don't fit.
String traceCardText(
  AppLocalizations l10n,
  TraceCard card, {
  required bool imperial,
  required String locale,
}) {
  final lines = <String>[
    l10n.traceCard_title,
    l10n.traceCard_from(card.sender),
    if (card.target != null) l10n.traceCard_to(card.target!),
    l10n.traceCard_sentAt(_when(card.sentAt, locale)),
    l10n.traceCard_roundTrip(_roundTrip(card.roundTrip)),
    l10n.traceCard_hops(card.hops.length),
    for (final (i, h) in card.hops.indexed)
      '${i + 1}. ${h.label} [${h.id}] · ${_snr(l10n, h.snr)}',
    '${l10n.traceCard_backToYou} · ${_snr(l10n, card.returnSnr)}',
    if (card.routePoints.isNotEmpty)
      l10n.traceCard_distance(_distance(card.routeMeters, imperial)),
    if (card.weakestSnr != null)
      l10n.traceCard_weakest(_snr(l10n, card.weakestSnr)),
  ];
  return lines.join('\n');
}

/// Shows one finished trace as a card that can be shared as an image or
/// as text.
class TraceCardScreen extends StatefulWidget {
  const TraceCardScreen({super.key, required this.card});

  final TraceCard card;

  @override
  State<TraceCardScreen> createState() => _TraceCardScreenState();
}

class _TraceCardScreenState extends State<TraceCardScreen> {
  final _boundary = GlobalKey();
  bool _sharing = false;

  bool get _imperial =>
      context.read<AppSettingsService?>()?.settings.unitSystem ==
      UnitSystem.imperial;

  Future<void> _share({required bool image}) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final text = traceCardText(
      l10n,
      widget.card,
      imperial: _imperial,
      locale: locale,
    );
    setState(() => _sharing = true);
    try {
      if (image) {
        final render =
            _boundary.currentContext!.findRenderObject()!
                as RenderRepaintBoundary;
        final picture = await render.toImage(pixelRatio: 3);
        final bytes = await picture.toByteData(format: ui.ImageByteFormat.png);
        await SharePlus.instance.share(
          ShareParams(
            text: text,
            files: [
              XFile.fromData(
                bytes!.buffer.asUint8List(),
                mimeType: 'image/png',
                name: 'trace-card.png',
              ),
            ],
          ),
        );
      } else {
        await SharePlus.instance.share(ShareParams(text: text));
      }
    } catch (_) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.traceCard_shareFailed)),
      );
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.traceCard_title), centerTitle: true),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(MeshSpace.lg),
          children: [
            RepaintBoundary(
              key: _boundary,
              child: TraceCardView(card: widget.card, imperial: _imperial),
            ),
            const SizedBox(height: MeshSpace.lg),
            Wrap(
              spacing: MeshSpace.sm,
              runSpacing: MeshSpace.sm,
              alignment: WrapAlignment.center,
              children: [
                FilledButton.icon(
                  onPressed: _sharing ? null : () => _share(image: true),
                  icon: const Icon(Icons.image_outlined),
                  label: Text(l10n.traceCard_shareImage),
                ),
                OutlinedButton.icon(
                  onPressed: _sharing ? null : () => _share(image: false),
                  icon: const Icon(Icons.notes),
                  label: Text(l10n.traceCard_shareText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// The card itself: header, timing, the route sketch and every hop.
class TraceCardView extends StatelessWidget {
  const TraceCardView({super.key, required this.card, required this.imperial});

  final TraceCard card;
  final bool imperial;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final ink2 = TextStyle(color: MeshPalette.ink2);
    final points = card.routePoints;
    return Container(
      padding: const EdgeInsets.all(MeshSpace.lg),
      decoration: BoxDecoration(
        color: MeshPalette.bg1,
        borderRadius: BorderRadius.circular(MeshRadii.md),
        border: Border.all(color: MeshPalette.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.traceCard_from(card.sender),
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: MeshPalette.ink),
          ),
          if (card.target != null)
            Text(l10n.traceCard_to(card.target!), style: ink2),
          Text(l10n.traceCard_sentAt(_when(card.sentAt, locale)), style: ink2),
          const SizedBox(height: MeshSpace.sm),
          Wrap(
            spacing: MeshSpace.md,
            runSpacing: MeshSpace.xs,
            children: [
              _Fact(
                Icons.timer_outlined,
                l10n.traceCard_roundTrip(_roundTrip(card.roundTrip)),
              ),
              _Fact(Icons.hub_outlined, l10n.traceCard_hops(card.hops.length)),
              if (points.isNotEmpty)
                _Fact(
                  Icons.straighten,
                  l10n.traceCard_distance(
                    _distance(card.routeMeters, imperial),
                  ),
                ),
              if (card.weakestSnr != null)
                _Fact(
                  Icons.signal_cellular_alt_1_bar,
                  l10n.traceCard_weakest(_snr(l10n, card.weakestSnr)),
                ),
            ],
          ),
          const SizedBox(height: MeshSpace.md),
          if (points.isEmpty)
            Text(l10n.traceCard_noMap, style: ink2)
          else
            Semantics(
              container: true,
              image: true,
              label: l10n.traceCard_mapLabel,
              child: ExcludeSemantics(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CustomPaint(
                    painter: TraceRoutePainter(
                      points: points,
                      line: MeshPalette.accent,
                      dot: MeshPalette.signal,
                      home: MeshPalette.warn,
                      background: MeshPalette.bg2,
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(height: MeshSpace.md),
          for (final (i, h) in card.hops.indexed)
            _HopRow(
              index: '${i + 1}',
              title: h.label,
              detail: h.positionGuessed
                  ? '${h.id} · ${l10n.traceCard_guessed}'
                  : h.id,
              snr: _snr(l10n, h.snr),
            ),
          _HopRow(
            index: '↩',
            title: l10n.traceCard_backToYou,
            detail: card.sender,
            snr: _snr(l10n, card.returnSnr),
          ),
        ],
      ),
    );
  }
}

class _Fact extends StatelessWidget {
  const _Fact(this.icon, this.text);
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      ExcludeSemantics(child: Icon(icon, size: 16, color: MeshPalette.accent)),
      const SizedBox(width: MeshSpace.xs),
      Text(text, style: TextStyle(color: MeshPalette.ink)),
    ],
  );
}

class _HopRow extends StatelessWidget {
  const _HopRow({
    required this.index,
    required this.title,
    required this.detail,
    required this.snr,
  });
  final String index, title, detail, snr;

  @override
  Widget build(BuildContext context) => MergeSemantics(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: MeshSpace.xs),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(index, style: TextStyle(color: MeshPalette.ink3)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: MeshPalette.ink)),
                Text(
                  detail,
                  style: TextStyle(color: MeshPalette.ink3, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(snr, style: TextStyle(color: MeshPalette.ink2)),
        ],
      ),
    ),
  );
}

/// Draws the round trip on a plain backdrop: the route, a dot per hop and
/// a ring where it started and ended. Needs no map tiles, so it works
/// offline and in a shared image.
class TraceRoutePainter extends CustomPainter {
  TraceRoutePainter({
    required this.points,
    required this.line,
    required this.dot,
    required this.home,
    required this.background,
  });

  final List<({double lat, double lon})> points;
  final Color line, dot, home, background;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(8)),
      Paint()..color = background,
    );
    final xy = projectRoute(points, width: size.width, height: size.height);
    if (xy.length < 2) return;
    final path = Path()..moveTo(xy.first.x, xy.first.y);
    for (final p in xy.skip(1)) {
      path.lineTo(p.x, p.y);
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = line
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeJoin = StrokeJoin.round,
    );
    for (final p in xy.skip(1).take(xy.length - 2)) {
      canvas.drawCircle(Offset(p.x, p.y), 5, Paint()..color = dot);
    }
    canvas.drawCircle(
      Offset(xy.first.x, xy.first.y),
      7,
      Paint()
        ..color = home
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }

  @override
  bool shouldRepaint(TraceRoutePainter old) =>
      old.points != points || old.line != line || old.background != background;
}
