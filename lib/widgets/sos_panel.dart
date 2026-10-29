import '../theme/mesh_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/l10n.dart';
import '../models/field_ops.dart';
import '../services/field_ops_service.dart';
import 'quick_trip_setup.dart';

const _red = Color(0xFFD9534F);
Color get _muted => MeshPalette.ink3;

/// The home screen's SOS control: a hold-to-send button while idle, and a
/// status banner with Stop while an SOS is active.
class SosPanel extends StatelessWidget {
  const SosPanel({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<MeshCoreConnector>();
    final ops = context.watch<FieldOpsService>();
    if (ops.sos.active) return _ActiveSos(ops: ops);
    final l10n = context.l10n;
    // Only a missing radio or loading blocks the button. With nobody to
    // send to yet, the hold asks who should get it, then sends.
    final reason = hardBlockReason(ops);
    final channel = ops.sosChannel;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HoldToConfirmButton(
          key: const ValueKey('sos-hold'),
          enabled: reason == null,
          onConfirmed: () => _start(context, ops),
        ),
        const SizedBox(height: 4),
        Text(
          reason ??
              (!hasSosTarget(ops)
                  ? "Hold 2 seconds. You'll choose who gets it, then it sends."
                  : channel == null
                  ? l10n.sos_holdHint
                  : l10n.sos_holdHintChannel(channel.name)),
          style: TextStyle(color: _muted, fontSize: 12),
        ),
      ],
    );
  }

  Future<void> _start(BuildContext context, FieldOpsService ops) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    if (!hasSosTarget(ops)) {
      final saved = await showQuickTripSetup(context, ops, forSos: true);
      if (!saved || !hasSosTarget(ops)) return;
    }
    try {
      await ops.startSos();
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.sos_notSent('$e'))));
    }
  }
}

class _ActiveSos extends StatelessWidget {
  final FieldOpsService ops;
  const _ActiveSos({required this.ops});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final sos = ops.sos;
    final next = sos.nextSendAt;
    final String status;
    if (sos.acknowledgedBy case final by?) {
      status = l10n.sos_acknowledged(by);
    } else if (sos.sends == 0) {
      status = l10n.sos_waitingForRadio;
    } else if (next == null) {
      status = l10n.sos_repeatsFinished(sos.sends, sosMaxSends);
    } else {
      status = l10n.sos_nextAt(
        sos.sends,
        sosMaxSends,
        TimeOfDay.fromDateTime(next).format(context),
      );
    }
    return Container(
      key: const ValueKey('sos-active'),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _red.withValues(alpha: .16),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _red),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.sos_rounded, color: _red),
              const SizedBox(width: 8),
              Text(
                l10n.sos_active,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(status, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => ops.stopSos(),
                  child: Text(l10n.sos_stop),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton(
                  onPressed: () => ops.stopSos(allClear: true),
                  child: Text(l10n.sos_imSafe),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A button that fires [onConfirmed] only after being held for [holdFor],
/// so the SOS can't be sent by a stray tap.
class HoldToConfirmButton extends StatefulWidget {
  final bool enabled;
  final VoidCallback onConfirmed;
  final Duration holdFor;

  const HoldToConfirmButton({
    super.key,
    required this.enabled,
    required this.onConfirmed,
    this.holdFor = const Duration(seconds: 2),
  });

  @override
  State<HoldToConfirmButton> createState() => _HoldToConfirmButtonState();
}

class _HoldToConfirmButtonState extends State<HoldToConfirmButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _hold = AnimationController(
    vsync: this,
    duration: widget.holdFor,
  )..addStatusListener(_status);

  void _status(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _hold.reset();
      // A firm buzz says it fired, for someone not looking at the screen.
      HapticFeedback.heavyImpact();
      widget.onConfirmed();
    }
  }

  Offset? _start;

  void _cancel() {
    _start = null;
    // The SOS replaces this button once it starts, before the finger lifts.
    if (!mounted) return;
    if (_hold.status != AnimationStatus.completed) _hold.reverse();
  }

  @override
  void dispose() {
    _hold.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.enabled ? _red : _red.withValues(alpha: .35);
    // A faint red track reads as disabled on a light background, so light
    // themes get a solid track with a darker fill sweeping across it; the
    // white label keeps its contrast either way.
    final light = MeshPalette.current.brightness == Brightness.light;
    // Darkened 15% so white text clears 4.5:1 (about 5.2:1).
    final track = light
        ? Color.lerp(color, Colors.black, .15)!
        : color.withValues(alpha: .25);
    final fill = light ? Color.lerp(color, Colors.black, .35)! : color;
    return Semantics(
      button: true,
      enabled: widget.enabled,
      label: context.l10n.sos_holdSemantics,
      onLongPress: widget.enabled ? widget.onConfirmed : null,
      excludeSemantics: true,
      // Raw pointer events: a gesture recognizer would cancel the hold when
      // its long-press timer wins the arena.
      child: Listener(
        onPointerDown: widget.enabled
            ? (e) {
                _start = e.position;
                HapticFeedback.lightImpact();
                _hold.forward();
              }
            : null,
        onPointerMove: widget.enabled
            ? (e) {
                // Scrolling the page is not a hold.
                if (_start != null && (e.position - _start!).distance > 24) {
                  _cancel();
                }
              }
            : null,
        onPointerUp: widget.enabled ? (_) => _cancel() : null,
        onPointerCancel: widget.enabled ? (_) => _cancel() : null,
        child: AnimatedBuilder(
          animation: _hold,
          builder: (context, _) => ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Stack(
              children: [
                Container(height: 56, color: track),
                FractionallySizedBox(
                  widthFactor: _hold.value,
                  child: Container(height: 56, color: fill),
                ),
                SizedBox(
                  height: 56,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.sos_rounded,
                          color: widget.enabled ? Colors.white : _muted,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _hold.value > 0
                              ? context.l10n.sos_keepHolding
                              : context.l10n.sos_holdForSos,
                          style: TextStyle(
                            color: widget.enabled ? Colors.white : _muted,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
