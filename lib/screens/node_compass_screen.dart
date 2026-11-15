import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/app_settings.dart';
import '../models/contact.dart';
import '../models/field_intel.dart';
import '../services/app_settings_service.dart';
import '../services/device_compass.dart';
import '../services/phone_location.dart';
import '../theme/mesh_theme.dart';
import '../widgets/node_sheet.dart';

/// Where your own position comes from.
enum CompassPositionSource { phone, radio, none }

/// A big arrow that points at [node] as you turn, with how far it is.
///
/// Uses the phone's compass (true north when the phone knows where it is)
/// and your phone's GPS if location is already allowed, else the radio's
/// position. Without a compass the arrow is drawn north-up instead.
class NodeCompassScreen extends StatefulWidget {
  const NodeCompassScreen({
    super.key,
    required this.node,
    this.compass = const DeviceCompass(),
  });

  final Contact node;
  final DeviceCompass compass;

  @override
  State<NodeCompassScreen> createState() => _NodeCompassScreenState();
}

class _NodeCompassScreenState extends State<NodeCompassScreen> {
  StreamSubscription<CompassReading>? _compassSub;
  StreamSubscription<PhoneFix>? _fixSub;
  double? _heading;
  bool _calibrate = false;
  bool _noCompass = false;
  double? _declination;
  bool _declinationAsked = false;
  PhoneFix? _phoneFix;
  bool _wasOnTarget = false;

  @override
  void initState() {
    super.initState();
    _compassSub = widget.compass.readings().listen(
      _onReading,
      onError: (Object e, StackTrace st) {
        debugPrint('Compass unavailable: $e');
        if (mounted) setState(() => _noCompass = true);
      },
    );
    unawaited(_startPhoneLocation(ask: false));
  }

  @override
  void dispose() {
    _compassSub?.cancel();
    _fixSub?.cancel();
    super.dispose();
  }

  void _onReading(CompassReading r) {
    if (!mounted) return;
    setState(() {
      _heading = smoothHeading(_heading, r.magneticHeading);
      _calibrate = r.needsCalibration;
    });
  }

  /// Follows the phone's GPS. With [ask] false it only starts when
  /// location is already allowed, so opening the screen never prompts.
  Future<void> _startPhoneLocation({required bool ask}) async {
    try {
      if (!ask) {
        final last = await lastKnownPhoneFix();
        if (!mounted) return;
        if (last == null) return;
        setState(() => _phoneFix = last);
      }
      await _fixSub?.cancel();
      _fixSub = phoneFixStream().listen(
        (fix) {
          if (mounted) setState(() => _phoneFix = fix);
        },
        onError: (Object e, StackTrace st) {
          debugPrint('Phone location stopped: $e');
        },
      );
    } on Exception catch (e, st) {
      debugPrint('Phone location unavailable: $e\n$st');
    }
  }

  Future<void> _askDeclination(double lat, double lon) async {
    _declinationAsked = true;
    final d = await widget.compass.declination(lat, lon);
    if (mounted && d != null) setState(() => _declination = d);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final connector = context.watch<MeshCoreConnector>();
    final imperial =
        context.watch<AppSettingsService>().settings.unitSystem ==
        UnitSystem.imperial;
    final node =
        connector.allContactsUnfiltered
            .where((c) => c.publicKeyHex == widget.node.publicKeyHex)
            .firstOrNull ??
        widget.node;

    final radioLat = connector.selfLatitude, radioLon = connector.selfLongitude;
    final radioKnown =
        radioLat != null &&
        radioLon != null &&
        (radioLat != 0 || radioLon != 0);
    final (
      double? lat,
      double? lon,
      CompassPositionSource source,
    ) = _phoneFix != null
        ? (_phoneFix!.lat, _phoneFix!.lon, CompassPositionSource.phone)
        : radioKnown
        ? (radioLat, radioLon, CompassPositionSource.radio)
        : (null, null, CompassPositionSource.none);

    if (lat != null && lon != null && !_declinationAsked && !_noCompass) {
      unawaited(_askDeclination(lat, lon));
    }

    final hasTarget = node.hasLocation && lat != null && lon != null;
    final bearing = hasTarget
        ? bearingDeg(lat, lon, node.latitude!, node.longitude!)
        : null;
    final km = hasTarget
        ? distanceKm(lat, lon, node.latitude!, node.longitude!)
        : null;
    final trueHeading = _heading == null
        ? null
        : normalizeDegrees(_heading! + (_declination ?? 0));
    final turn = bearing == null
        ? null
        : _noCompass || trueHeading == null
        ? null
        : turnAngle(bearing: bearing, heading: trueHeading);
    final onTarget = turn != null && turn.abs() <= onTargetDegrees;
    if (onTarget && !_wasOnTarget) {
      unawaited(HapticFeedback.selectionClick());
    }
    _wasOnTarget = onTarget;

    // The arrow's angle on screen: relative to where you face, or to north
    // when there's no compass.
    final arrowDeg = bearing == null
        ? null
        : _noCompass
        ? bearing
        : turn;

    final direction = turn == null
        ? null
        : onTarget
        ? l10n.compass_onTarget
        : turn > 0
        ? l10n.compass_turnRight(turn.round())
        : l10n.compass_turnLeft(turn.abs().round());

    final arrowColor = onTarget ? MeshPalette.signal : MeshPalette.accent;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(node.name)),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final dial = math.min(
              constraints.maxWidth - MeshSpace.xl * 2,
              math.max(160.0, constraints.maxHeight * 0.5),
            );
            return ListView(
              padding: const EdgeInsets.all(MeshSpace.xl),
              children: [
                Center(
                  child: Semantics(
                    container: true,
                    liveRegion: true,
                    label: [
                      node.name,
                      if (km != null) distanceLabel(km, imperial),
                      ?direction,
                    ].join(', '),
                    child: ExcludeSemantics(
                      child: SizedBox.square(
                        dimension: dial,
                        child: CustomPaint(
                          painter: _CompassDialPainter(
                            arrowDeg: arrowDeg,
                            headingDeg: _noCompass ? 0 : trueHeading,
                            arrowColor: arrowColor,
                            ringColor: MeshPalette.line2,
                            tickColor: MeshPalette.ink3,
                            northColor: MeshPalette.alert,
                            labelStyle:
                                textTheme.labelMedium?.copyWith(
                                  color: MeshPalette.ink2,
                                  fontWeight: FontWeight.w700,
                                ) ??
                                TextStyle(color: MeshPalette.ink2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: MeshSpace.xl),
                if (km != null)
                  Text(
                    distanceLabel(km, imperial),
                    textAlign: TextAlign.center,
                    style: textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                if (direction != null)
                  Padding(
                    padding: const EdgeInsets.only(top: MeshSpace.xs),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          onTarget
                              ? Icons.check_circle
                              : turn! > 0
                              ? Icons.turn_right
                              : Icons.turn_left,
                          color: arrowColor,
                        ),
                        const SizedBox(width: MeshSpace.sm),
                        Flexible(
                          child: Text(
                            direction,
                            style: textTheme.titleMedium?.copyWith(
                              color: arrowColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (bearing != null)
                  Padding(
                    padding: const EdgeInsets.only(top: MeshSpace.sm),
                    child: Text(
                      l10n.compass_bearing(
                        bearing.round(),
                        compassPoint(bearing),
                      ),
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium,
                    ),
                  ),
                const SizedBox(height: MeshSpace.xl),
                ..._notes(l10n, node, source),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _notes(
    AppLocalizations l10n,
    Contact node,
    CompassPositionSource source,
  ) {
    Widget note(IconData icon, String text, {Color? color}) => Padding(
      padding: const EdgeInsets.only(bottom: MeshSpace.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: color ?? MeshPalette.ink3),
          const SizedBox(width: MeshSpace.sm),
          Expanded(child: Text(text)),
        ],
      ),
    );
    return [
      if (!node.hasLocation)
        note(Icons.location_off_outlined, l10n.compass_noNodePosition),
      if (source == CompassPositionSource.none)
        note(
          Icons.my_location,
          l10n.compass_noPosition,
          color: MeshPalette.warn,
        ),
      if (_noCompass) note(Icons.explore_off_outlined, l10n.compass_noSensor),
      if (!_noCompass && _calibrate)
        note(
          Icons.screen_rotation_alt,
          l10n.compass_calibrate,
          color: MeshPalette.warn,
        ),
      if (!_noCompass && _heading != null && _declination == null)
        note(Icons.info_outline, l10n.compass_magneticNote),
      if (source == CompassPositionSource.phone)
        note(Icons.smartphone, l10n.compass_sourcePhone),
      if (source == CompassPositionSource.radio)
        note(Icons.router_outlined, l10n.compass_sourceRadio),
      if (source != CompassPositionSource.phone)
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: OutlinedButton.icon(
            onPressed: () => unawaited(_startPhoneLocation(ask: true)),
            icon: const Icon(Icons.gps_fixed),
            label: Text(l10n.compass_usePhoneLocation),
          ),
        ),
    ];
  }
}

/// A compass rose that turns with the phone, and an arrow towards the node.
class _CompassDialPainter extends CustomPainter {
  const _CompassDialPainter({
    required this.arrowDeg,
    required this.headingDeg,
    required this.arrowColor,
    required this.ringColor,
    required this.tickColor,
    required this.northColor,
    required this.labelStyle,
  });

  /// Arrow angle on screen, clockwise from straight up; null hides it.
  final double? arrowDeg;

  /// Which way you face; the rose turns the other way. Null keeps it still.
  final double? headingDeg;
  final Color arrowColor;
  final Color ringColor;
  final Color tickColor;
  final Color northColor;
  final TextStyle labelStyle;

  static double _rad(double deg) => deg * math.pi / 180;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.shortestSide / 2;

    canvas.drawCircle(
      c,
      r - 2,
      Paint()
        ..color = ringColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Rose: ticks every 10°, letters at the cardinal points.
    canvas.save();
    canvas.translate(c.dx, c.dy);
    canvas.rotate(-_rad(headingDeg ?? 0));
    final tick = Paint()
      ..color = tickColor
      ..strokeWidth = 1.5;
    for (var d = 0; d < 360; d += 10) {
      final major = d % 90 == 0;
      final a = _rad(d.toDouble());
      final outer = Offset(math.sin(a), -math.cos(a)) * (r - 6);
      final inner = Offset(math.sin(a), -math.cos(a)) * (r - (major ? 22 : 14));
      canvas.drawLine(inner, outer, tick);
    }
    const letters = ['N', 'E', 'S', 'W'];
    for (var i = 0; i < 4; i++) {
      final a = _rad(i * 90.0);
      final pos = Offset(math.sin(a), -math.cos(a)) * (r - 38);
      final tp = TextPainter(
        text: TextSpan(
          text: letters[i],
          style: labelStyle.copyWith(color: i == 0 ? northColor : null),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      canvas.save();
      canvas.translate(pos.dx, pos.dy);
      canvas.rotate(_rad(headingDeg ?? 0));
      tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
      canvas.restore();
    }
    canvas.restore();

    // Fixed marker at the top: the way the phone points.
    final marker = Path()
      ..moveTo(c.dx, c.dy - r + 2)
      ..lineTo(c.dx - 7, c.dy - r - 10)
      ..lineTo(c.dx + 7, c.dy - r - 10)
      ..close();
    canvas.drawPath(marker, Paint()..color = tickColor);

    final deg = arrowDeg;
    if (deg == null) return;
    canvas.save();
    canvas.translate(c.dx, c.dy);
    canvas.rotate(_rad(deg));
    final len = r * 0.62;
    final arrow = Path()
      ..moveTo(0, -len)
      ..lineTo(len * 0.32, len * 0.12)
      ..lineTo(0, -len * 0.08)
      ..lineTo(-len * 0.32, len * 0.12)
      ..close();
    canvas.drawPath(arrow, Paint()..color = arrowColor);
    canvas.drawPath(
      arrow,
      Paint()
        ..color = arrowColor.withValues(alpha: 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeJoin = StrokeJoin.round,
    );
    canvas.restore();
    canvas.drawCircle(c, 6, Paint()..color = tickColor);
  }

  @override
  bool shouldRepaint(_CompassDialPainter old) =>
      old.arrowDeg != arrowDeg ||
      old.headingDeg != headingDeg ||
      old.arrowColor != arrowColor ||
      old.ringColor != ringColor ||
      old.tickColor != tickColor ||
      old.northColor != northColor ||
      old.labelStyle != labelStyle;
}

/// Opens the compass for [node].
void openNodeCompass(BuildContext context, Contact node) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => NodeCompassScreen(node: node)),
  );
}
