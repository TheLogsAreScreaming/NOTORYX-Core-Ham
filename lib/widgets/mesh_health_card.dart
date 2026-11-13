import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/mesh_health.dart';
import '../services/direct_repeater_service.dart';
import '../theme/mesh_theme.dart';
import 'tactical_glass_panel.dart';

/// Builds the mesh health from what the radio and app know right now.
MeshHealth currentMeshHealth(BuildContext context) {
  final radio = context.watch<MeshCoreConnector>();
  final direct = context.watch<DirectRepeaterService?>();
  final stats = radio.latestRadioStats;
  final now = DateTime.now();
  // Old stats describe a different moment; leave them out.
  final fresh =
      stats != null &&
      now.difference(stats.receivedAt) < const Duration(minutes: 10);
  final deliveries = radio.recentDirectDeliveries();
  return assessMeshHealth(
    MeshHealthInputs(
      noiseFloorDbm: fresh ? stats.noiseFloorDbm : null,
      lastSnrDb: fresh ? stats.lastSnrDb : null,
      busyFraction: busyFraction(radio.airtimeSamples),
      neighboursLastHour: direct == null
          ? 0
          : direct.heard
                .where(
                  (h) => now.difference(h.lastHeard) < const Duration(hours: 1),
                )
                .length,
      delivered: deliveries.delivered,
      failed: deliveries.failed,
    ),
  );
}

String healthGradeLabel(AppLocalizations l10n, HealthGrade grade) =>
    switch (grade) {
      HealthGrade.good => l10n.mesh_gradeGood,
      HealthGrade.fair => l10n.mesh_gradeFair,
      HealthGrade.poor => l10n.mesh_gradePoor,
      HealthGrade.unknown => l10n.mesh_gradeUnknown,
    };

/// Each grade's icon, so colour is never the only sign.
IconData healthGradeIcon(HealthGrade grade) => switch (grade) {
  HealthGrade.good => Icons.check_circle_outline,
  HealthGrade.fair => Icons.remove_circle_outline,
  HealthGrade.poor => Icons.error_outline,
  HealthGrade.unknown => Icons.help_outline,
};

/// Okabe-Ito-safe through the theme: signal, warn and alert are tuned per
/// palette, and the icon and word carry the grade too.
Color healthGradeColor(HealthGrade grade) => switch (grade) {
  HealthGrade.good => MeshPalette.signal,
  HealthGrade.fair => MeshPalette.warn,
  HealthGrade.poor => MeshPalette.alert,
  HealthGrade.unknown => MeshPalette.ink3,
};

String _factorName(AppLocalizations l10n, HealthFactor f) => switch (f) {
  HealthFactor.noise => l10n.mesh_noise,
  HealthFactor.signal => l10n.mesh_signal,
  HealthFactor.busy => l10n.mesh_busy,
  HealthFactor.neighbours => l10n.mesh_neighbours,
  HealthFactor.delivery => l10n.mesh_delivery,
};

String? _factorValue(AppLocalizations l10n, HealthReading r) {
  final v = r.value;
  if (r.grade == HealthGrade.unknown && r.factor != HealthFactor.neighbours) {
    return null;
  }
  return switch (r.factor) {
    HealthFactor.noise => l10n.mesh_noiseValue('$v'),
    HealthFactor.signal => l10n.mesh_signalValue((v as num).toStringAsFixed(1)),
    HealthFactor.busy => l10n.mesh_busyValue(v!.toInt()),
    HealthFactor.neighbours => l10n.mesh_neighboursValue(v!.toInt()),
    HealthFactor.delivery => l10n.mesh_deliveryValue(v!.toInt(), r.of ?? 0),
  };
}

String _tip(AppLocalizations l10n, HealthFactor f) => switch (f) {
  HealthFactor.noise => l10n.mesh_tipNoise,
  HealthFactor.signal => l10n.mesh_tipSignal,
  HealthFactor.busy => l10n.mesh_tipBusy,
  HealthFactor.neighbours => l10n.mesh_tipNeighbours,
  HealthFactor.delivery => l10n.mesh_tipDelivery,
};

/// The mesh health in plain words: an overall line, each factor with its
/// grade and number, and one tip for the weakest.
class MeshHealthCard extends StatelessWidget {
  const MeshHealthCard({super.key, this.health});

  /// For tests and previews; otherwise worked out from the app.
  final MeshHealth? health;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final h = health ?? currentMeshHealth(context);
    final overall = switch (h.overall) {
      HealthGrade.good => l10n.mesh_overallGood,
      HealthGrade.fair => l10n.mesh_overallFair,
      HealthGrade.poor => l10n.mesh_overallPoor,
      HealthGrade.unknown => l10n.mesh_overallUnknown,
    };
    final weakest = h.weakest;
    return TacticalGlassPanel(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.mesh_title,
            style: TextStyle(color: MeshPalette.ink3, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                healthGradeIcon(h.overall),
                color: healthGradeColor(h.overall),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  overall,
                  style: TextStyle(
                    color: MeshPalette.ink,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (final r in h.readings)
            Padding(
              key: ValueKey('mesh-${r.factor.name}'),
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: MergeSemantics(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      healthGradeIcon(r.grade),
                      size: 18,
                      color: healthGradeColor(r.grade),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '${_factorName(l10n, r.factor)}: '
                                  '${healthGradeLabel(l10n, r.grade)}',
                              style: TextStyle(
                                color: MeshPalette.ink,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (_factorValue(l10n, r) case final value?)
                              TextSpan(
                                text: ' · $value',
                                style: TextStyle(color: MeshPalette.ink2),
                              ),
                          ],
                        ),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (weakest != null) ...[
            const SizedBox(height: 8),
            Text(
              _tip(l10n, weakest.factor),
              key: const ValueKey('mesh-tip'),
              style: TextStyle(color: MeshPalette.ink2, fontSize: 13),
            ),
          ],
        ],
      ),
    );
  }
}
