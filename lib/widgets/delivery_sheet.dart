import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/contact.dart';
import '../models/delivery_diagnosis.dart';
import '../models/message.dart';
import '../services/app_settings_service.dart';
import '../theme/mesh_theme.dart';
import 'instrument.dart';
import 'mesh_ui.dart';

/// The verdict in plain words.
String deliveryVerdictText(
  AppLocalizations l10n,
  DeliveryDiagnosis d,
  String name,
) => switch (d.verdict) {
  DeliveryVerdict.delivered => l10n.deliv_vDelivered(name),
  DeliveryVerdict.deliveredByFlood => l10n.deliv_vDeliveredFlood(name),
  DeliveryVerdict.pending => l10n.deliv_vPending(
    d.attemptsMade < 1 ? 1 : d.attemptsMade,
    d.totalTries < 1 ? 1 : d.totalTries,
  ),
  DeliveryVerdict.notSent => l10n.deliv_vNotSent,
  DeliveryVerdict.failedQuiet => l10n.deliv_vQuiet(
    name,
    d.contactQuiet?.inHours ?? 0,
  ),
  DeliveryVerdict.failedNoFlood => l10n.deliv_vNoFlood,
  DeliveryVerdict.failedNoAck => l10n.deliv_vNoAck,
};

/// Shows how an outgoing direct message got on: queued, sent, attempts,
/// last route and confirmation, with a plain-words verdict.
Future<void> showDeliverySheet(
  BuildContext context, {
  required Message message,
  required Contact contact,
  VoidCallback? onRetry,
}) {
  final settings = context.read<AppSettingsService>().settings;
  final d = diagnoseDelivery(
    message,
    maxRetries: settings.maxMessageRetries,
    floodAttempts: settings.messageFloodAttempts,
    contact: contact,
  );
  return showMeshSheet<void>(
    context,
    builder: (sheet) => _DeliverySheet(
      diagnosis: d,
      contact: contact,
      onRetry: onRetry == null
          ? null
          : () {
              Navigator.pop(sheet);
              onRetry();
            },
    ),
  );
}

class _DeliverySheet extends StatelessWidget {
  const _DeliverySheet({
    required this.diagnosis,
    required this.contact,
    this.onRetry,
  });
  final DeliveryDiagnosis diagnosis;
  final Contact contact;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final d = diagnosis;
    final time = DateFormat.Hms(
      Localizations.localeOf(context).toLanguageTag(),
    );
    final (icon, color) = switch (d.verdict) {
      DeliveryVerdict.delivered || DeliveryVerdict.deliveredByFlood => (
        Icons.check_circle,
        MeshPalette.signal,
      ),
      DeliveryVerdict.pending => (Icons.schedule, MeshPalette.warn),
      _ => (Icons.error_outline, MeshPalette.alert),
    };
    final failed = switch (d.verdict) {
      DeliveryVerdict.notSent ||
      DeliveryVerdict.failedQuiet ||
      DeliveryVerdict.failedNoFlood ||
      DeliveryVerdict.failedNoAck => true,
      _ => false,
    };
    final route = d.lastRouteFlood
        ? l10n.deliv_routeFlood
        : d.lastRouteHashes.isEmpty
        ? l10n.deliv_routeNeighbor
        : l10n.deliv_routeVia(d.lastRouteHashes.join(' → '));

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.85,
        ),
        child: Column(
          key: const ValueKey('delivery-sheet'),
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BottomSheetHeader(title: l10n.deliv_title, subtitle: contact.name),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: MeshSpace.lg),
                children: [
                  MeshCard(
                    margin: const EdgeInsets.only(bottom: MeshSpace.md),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(icon, color: color),
                        const SizedBox(width: MeshSpace.md),
                        Expanded(
                          child: Text(
                            deliveryVerdictText(l10n, d, contact.name),
                            key: const ValueKey('delivery-verdict'),
                            style: TextStyle(
                              color: MeshPalette.ink,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InstrumentRow(
                    icon: Icons.edit_note,
                    title: l10n.deliv_queued,
                    trailing: Text(time.format(d.queuedAt)),
                  ),
                  InstrumentRow(
                    icon: d.attemptsMade > 0
                        ? Icons.send_outlined
                        : Icons.portable_wifi_off,
                    title: d.attemptsMade > 0
                        ? l10n.deliv_sent
                        : l10n.deliv_notSent,
                    trailing: d.sentAt == null
                        ? null
                        : Text(time.format(d.sentAt!)),
                  ),
                  if (d.attemptsMade > 0) ...[
                    InstrumentRow(
                      key: const ValueKey('delivery-attempts'),
                      icon: Icons.repeat,
                      title: l10n.deliv_attempts,
                      subtitle: l10n.deliv_plan(d.directTries, d.floodTries),
                      trailing: Text(
                        l10n.deliv_attemptsValue(
                          d.attemptsMade,
                          d.totalTries < d.attemptsMade
                              ? d.attemptsMade
                              : d.totalTries,
                        ),
                      ),
                    ),
                    InstrumentRow(
                      key: const ValueKey('delivery-route'),
                      icon: d.lastRouteFlood ? Icons.waves : Icons.alt_route,
                      title: l10n.deliv_lastRoute,
                      subtitle: route,
                    ),
                  ],
                  switch (d.verdict) {
                    DeliveryVerdict.delivered ||
                    DeliveryVerdict.deliveredByFlood => InstrumentRow(
                      icon: Icons.done_all,
                      title: l10n.deliv_confirmed,
                      subtitle: d.tripTime == null
                          ? null
                          : l10n.deliv_tripTime(
                              (d.tripTime!.inMilliseconds / 1000)
                                  .toStringAsFixed(1),
                            ),
                      trailing: d.deliveredAt == null
                          ? null
                          : Text(time.format(d.deliveredAt!)),
                    ),
                    DeliveryVerdict.pending => InstrumentRow(
                      icon: Icons.hourglass_top,
                      title: l10n.deliv_waiting,
                    ),
                    _ => InstrumentRow(
                      icon: Icons.close,
                      title: l10n.deliv_noConfirm,
                    ),
                  },
                  if (d.contactQuiet != null)
                    InstrumentRow(
                      icon: Icons.person_off_outlined,
                      title: l10n.deliv_lastHeard(contact.name),
                      trailing: Text(
                        l10n.deliv_hoursAgo(d.contactQuiet!.inHours),
                      ),
                      divider: false,
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: MeshSpace.sm),
                    child: Text(
                      l10n.deliv_note,
                      style: TextStyle(color: MeshPalette.ink3, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            if (failed && onRetry != null)
              Padding(
                padding: const EdgeInsets.all(MeshSpace.lg),
                child: InstrumentButton(
                  key: const ValueKey('delivery-retry'),
                  label: l10n.common_retry,
                  icon: Icons.refresh,
                  onPressed: onRetry,
                ),
              )
            else
              const SizedBox(height: MeshSpace.lg),
          ],
        ),
      ),
    );
  }
}
