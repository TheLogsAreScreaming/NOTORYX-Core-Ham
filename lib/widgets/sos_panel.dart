import '../theme/mesh_theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/l10n.dart';
import '../models/field_ops.dart';
import '../services/field_ops_service.dart';
import '../screens/field_report_screen.dart';
import 'quick_trip_setup.dart';
import '../helpers/snack_bar_builder.dart';

Color get _red => MeshPalette.alert;
Color get _muted => MeshPalette.ink3;

/// The line under the idle SOS button: why it can't send, or who gets it.
String sosHint(BuildContext context, FieldOpsService ops) {
  final l10n = context.l10n;
  final channel = ops.sosChannel;
  return hardBlockReason(ops) ??
      (!hasSosTarget(ops)
          ? "Hold 2 seconds. You'll choose who gets it, then it sends."
          : channel == null
          ? l10n.sos_holdHint
          : l10n.sos_holdHintChannel(channel.name));
}

/// The home screen's SOS control: a hold-to-send button while idle, and a
/// status banner with Stop while an SOS is active.
class SosPanel extends StatelessWidget {
  /// Just the button, for a row beside Check in; the caller shows
  /// [sosHint]. An active SOS always shows its full banner.
  final bool compact;

  const SosPanel({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    context.watch<MeshCoreConnector>();
    final ops = context.watch<FieldOpsService>();
    if (ops.sos.active) return _ActiveSos(ops: ops);
    // Only a missing radio or loading blocks the button. With nobody to
    // send to yet, the hold asks who should get it, then sends.
    final reason = hardBlockReason(ops);
    final button = HoldToConfirmButton(
      key: const ValueKey('sos-hold'),
      enabled: reason == null,
      onConfirmed: () => _start(context, ops),
    );
    if (compact) return button;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        button,
        const SizedBox(height: 4),
        Text(
          sosHint(context, ops),
          style: TextStyle(color: _muted, fontSize: 12),
        ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton.icon(
            key: const ValueKey('sos-open-report'),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => const FieldReportScreen(),
              ),
            ),
            icon: const Icon(Icons.assignment_outlined),
            label: Text(context.l10n.fieldReport_open),
          ),
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
      messenger.showSnackBar(
        meshSnackBar(content: Text(l10n.sos_notSent(friendlyError(e)))),
      );
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
        color: _red.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(MeshRadii.xs),
        border: Border.all(color: _red),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.sos_rounded, color: _red),
              const SizedBox(width: 8),
              Text(
                l10n.sos_active,
                style: TextStyle(
                  color: _red,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(status, style: TextStyle(color: MeshPalette.ink)),
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
    // An alert-coloured outline and label on the page, with a translucent
    // fill sweeping across while held. Every theme's alert colour clears
    // 4.5:1 against its page, so the label stays readable throughout.
    final color = widget.enabled ? _red : _muted;
    final fill = _red.withValues(alpha: .24);
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
          builder: (context, _) => Container(
            height: 48,
            decoration: BoxDecoration(
              // A red-tinted glass fill, matching the frosted look.
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color, width: 1.2),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                FractionallySizedBox(
                  widthFactor: _hold.value,
                  heightFactor: 1,
                  child: ColoredBox(color: fill),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.sos_rounded, size: 20, color: color),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            _hold.value > 0
                                ? context.l10n.sos_keepHolding
                                : context.l10n.sos_holdForSos,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: TextStyle(
                              color: color,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.4,
                            ),
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
