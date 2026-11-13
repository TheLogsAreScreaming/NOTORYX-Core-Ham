import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/troubleshooting.dart';
import '../services/direct_repeater_service.dart';
import '../theme/mesh_theme.dart';
import '../widgets/ember_backdrop.dart';
import '../widgets/tactical_glass_panel.dart';

/// What the troubleshooting checks see right now.
TroubleSnapshot troubleSnapshot(BuildContext context) {
  final radio = context.watch<MeshCoreConnector>();
  DirectRepeaterService? direct;
  try {
    direct = context.watch<DirectRepeaterService?>();
  } on ProviderNotFoundException {
    direct = null;
  }
  final now = DateTime.now();
  final messaged = radio.recentlyMessagedContacts();
  final stats = radio.latestRadioStats;
  return TroubleSnapshot(
    connected: radio.isConnected,
    messagedContacts: messaged.length,
    messagedWithoutRoute: messaged.where((c) => c.pathLength < 0).length,
    messagedNotHeardInDay: messaged
        .where((c) => now.difference(c.lastSeen) > const Duration(days: 1))
        .length,
    neighboursLastHour:
        direct?.heard
            .where(
              (h) => now.difference(h.lastHeard) < const Duration(hours: 1),
            )
            .length ??
        0,
    noisePoor: stats == null ? null : stats.noiseFloorDbm > -100,
  );
}

String _guideTitle(AppLocalizations l10n, TroubleGuide g) => switch (g) {
  TroubleGuide.noDelivery => l10n.trouble_noDelivery,
  TroubleGuide.noConnect => l10n.trouble_noConnect,
  TroubleGuide.hearNobody => l10n.trouble_hearNobody,
};

(String, String) _stepText(AppLocalizations l10n, TroubleStep s) => switch (s) {
  TroubleStep.connected => (
    l10n.trouble_connected,
    l10n.trouble_connectedAdvice,
  ),
  TroubleStep.routes => (l10n.trouble_routes, l10n.trouble_routesAdvice),
  TroubleStep.heardRecently => (
    l10n.trouble_heardRecently,
    l10n.trouble_heardRecentlyAdvice,
  ),
  TroubleStep.neighbours => (
    l10n.trouble_neighbours,
    l10n.trouble_neighboursAdvice,
  ),
  TroubleStep.bluetooth => (
    l10n.trouble_bluetooth,
    l10n.trouble_bluetoothAdvice,
  ),
  TroubleStep.otherApp => (l10n.trouble_otherApp, l10n.trouble_otherAppAdvice),
  TroubleStep.inRange => (l10n.trouble_inRange, l10n.trouble_inRangeAdvice),
  TroubleStep.otherTransport => (
    l10n.trouble_otherTransport,
    l10n.trouble_otherTransportAdvice,
  ),
  TroubleStep.noise => (l10n.trouble_noise, l10n.trouble_noiseAdvice),
  TroubleStep.region => (l10n.trouble_region, l10n.trouble_regionAdvice),
  TroubleStep.antenna => (l10n.trouble_antenna, l10n.trouble_antennaAdvice),
};

/// Three step-by-step guides with live checks: messages not delivered,
/// can't connect, and hearing no one. The first problem is marked
/// "Start here".
class TroubleshootingScreen extends StatefulWidget {
  const TroubleshootingScreen({super.key, this.guide});

  /// The guide to open, for links from error states.
  final TroubleGuide? guide;

  @override
  State<TroubleshootingScreen> createState() => _TroubleshootingScreenState();
}

class _TroubleshootingScreenState extends State<TroubleshootingScreen> {
  late TroubleGuide _guide = widget.guide ?? TroubleGuide.noDelivery;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final snapshot = troubleSnapshot(context);
    final steps = runGuide(_guide, snapshot);
    final start = startHere(steps);
    final allOk = steps.every((s) => s.$2 == StepResult.ok);
    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          foregroundColor: MeshPalette.ink,
          title: Text(l10n.trouble_title),
        ),
        body: SafeArea(
          top: false,
          child: ListView(
            padding: const EdgeInsets.all(MeshSpace.lg),
            children: [
              Text(
                l10n.trouble_pick,
                style: TextStyle(color: MeshPalette.ink2),
              ),
              const SizedBox(height: 8),
              RadioGroup<TroubleGuide>(
                groupValue: _guide,
                onChanged: (v) {
                  if (v != null) setState(() => _guide = v);
                },
                child: Column(
                  children: [
                    for (final g in TroubleGuide.values)
                      RadioListTile<TroubleGuide>(
                        key: ValueKey('guide-${g.name}'),
                        contentPadding: EdgeInsets.zero,
                        value: g,
                        title: Text(_guideTitle(l10n, g)),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              if (_guide == TroubleGuide.noConnect && snapshot.connected)
                _Note(l10n.trouble_connectedNow)
              else if (allOk)
                _Note(l10n.trouble_allOk),
              for (final (i, (step, result)) in steps.indexed)
                Padding(
                  padding: const EdgeInsets.only(bottom: MeshSpace.md),
                  child: _StepCard(
                    key: ValueKey('step-${step.name}'),
                    number: i + 1,
                    step: step,
                    result: result,
                    startHere: step == start,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Note extends StatelessWidget {
  const _Note(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: MeshSpace.md),
    child: Text(text, style: TextStyle(color: MeshPalette.ink2)),
  );
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    super.key,
    required this.number,
    required this.step,
    required this.result,
    required this.startHere,
  });

  final int number;
  final TroubleStep step;
  final StepResult result;
  final bool startHere;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (title, advice) = _stepText(l10n, step);
    final (icon, color, label) = switch (result) {
      StepResult.ok => (
        Icons.check_circle_outline,
        MeshPalette.signal,
        l10n.trouble_resultOk,
      ),
      StepResult.problem => (
        Icons.error_outline,
        MeshPalette.alert,
        l10n.trouble_resultProblem,
      ),
      StepResult.unchecked => (
        Icons.help_outline,
        MeshPalette.ink3,
        l10n.trouble_resultUnchecked,
      ),
    };
    return TacticalGlassPanel(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (startHere)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                l10n.trouble_startHere,
                style: TextStyle(
                  color: MeshPalette.accent,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          MergeSemantics(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$number. $title',
                        style: TextStyle(
                          color: MeshPalette.ink,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(label, style: TextStyle(color: color, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (result != StepResult.ok) ...[
            const SizedBox(height: 6),
            Text(
              advice,
              style: TextStyle(color: MeshPalette.ink2, fontSize: 13),
            ),
          ],
        ],
      ),
    );
  }
}
