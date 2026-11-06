import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../helpers/contact_ui.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/app_settings.dart';
import '../models/contact.dart';
import '../models/field_intel.dart';
import '../screens/chat_screen.dart';
import '../screens/map_screen.dart';
import '../screens/repeater_hub_screen.dart';
import '../services/app_settings_service.dart';
import '../theme/mesh_theme.dart';
import 'instrument.dart';
import 'mesh_ui.dart';
import 'repeater_login_dialog.dart';

/// "Direct", "1 hop", … for a node's route.
String hopLabel(AppLocalizations l10n, HopBand b) => switch (b) {
  HopBand.direct => l10n.fieldStats_direct,
  HopBand.one => l10n.fieldIntel_hops1,
  HopBand.two => l10n.fieldIntel_hops2,
  HopBand.threePlus => l10n.fieldIntel_hops3,
  HopBand.unknown => l10n.fieldIntel_noRoute,
};

/// "just now", "5 min ago", "3 h ago", "2 days ago".
String agoLabel(AppLocalizations l10n, DateTime at) {
  final m = DateTime.now().difference(at).inMinutes;
  if (m < 1) return l10n.time_justNow;
  if (m < 60) return l10n.time_minutesAgo(m);
  if (m < 48 * 60) return l10n.time_hoursAgo(m ~/ 60);
  return l10n.time_daysAgo(m ~/ (24 * 60));
}

/// "4.2 km" or "2.6 mi".
String distanceLabel(double km, bool imperial) {
  final v = imperial ? km * 0.621371 : km;
  final unit = imperial ? 'mi' : 'km';
  return '${v < 10 ? v.toStringAsFixed(1) : v.round()} $unit';
}

/// Logs in to [repeater] and opens its status, neighbours, telemetry and
/// command line.
void loginToRepeater(BuildContext context, Contact repeater) {
  showDialog<void>(
    context: context,
    builder: (dialogContext) => RepeaterLoginDialog(
      repeater: repeater,
      onLogin: (password, isAdmin) {
        Navigator.of(dialogContext).pop();
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => RepeaterHubScreen(
              repeater: repeater,
              password: password,
              isAdmin: isAdmin,
            ),
          ),
        );
      },
    ),
  );
}

/// One node's details, with what you can do with it: show it on the map,
/// open a chat with a person, or log in to a repeater.
void showNodeSheet(BuildContext context, Contact c) {
  final l10n = context.l10n;
  final connector = context.read<MeshCoreConnector>();
  final imperial =
      context.read<AppSettingsService>().settings.unitSystem ==
      UnitSystem.imperial;
  final lat = connector.selfLatitude, lon = connector.selfLongitude;
  final hasSelf = lat != null && lon != null && (lat != 0 || lon != 0);
  final repeater = c.type == advTypeRepeater;
  final mv = repeater
      ? connector.getRepeaterBatteryMillivolts(c.publicKeyHex)
      : null;
  final direct = repeater
      ? connector.directRepeaters
            .where(
              (r) =>
                  r.contactKeyHex?.toLowerCase() ==
                  c.publicKeyHex.toLowerCase(),
            )
            .firstOrNull
      : null;

  Widget action(String label, IconData icon, VoidCallback onPressed) =>
      Expanded(
        child: InstrumentButton(label: label, icon: icon, onPressed: onPressed),
      );

  showMeshSheet<void>(
    context,
    builder: (sheet) {
      void go(Widget page) {
        Navigator.pop(sheet);
        Navigator.of(
          context,
        ).push(MaterialPageRoute<void>(builder: (_) => page));
      }

      final actions = [
        if (c.hasLocation)
          action(
            l10n.fieldIntel_showOnMap,
            Icons.map_outlined,
            () => go(
              MapScreen(
                highlightPosition: LatLng(c.latitude!, c.longitude!),
                highlightLabel: c.name,
                highlightMarkerKey: c.publicKeyHex,
              ),
            ),
          ),
        if (c.type == advTypeChat)
          action(
            l10n.fieldIntel_openChat,
            Icons.chat_bubble_outline,
            () => go(ChatScreen(contact: c)),
          ),
        if (repeater)
          action(l10n.repeaterTools_login, Icons.login_rounded, () {
            Navigator.pop(sheet);
            loginToRepeater(context, c);
          }),
      ];

      return SafeArea(
        child: Column(
          key: const ValueKey('node-sheet'),
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BottomSheetHeader(title: c.name, subtitle: c.typeLabelRaw),
            InstrumentRow(
              icon: contactTypeIcon(c.type),
              title: hopLabel(l10n, hopBand(c)),
              subtitle: l10n.fieldIntel_lastHeard(agoLabel(l10n, c.lastSeen)),
              divider: false,
            ),
            if (direct != null)
              InstrumentRow(
                icon: Icons.settings_input_antenna,
                title: l10n.repeaterTools_heardDirect,
                trailing: SignalReadout(direct.snr),
                divider: false,
              ),
            if (hasSelf && c.hasLocation)
              InstrumentRow(
                icon: Icons.near_me_outlined,
                title:
                    '${distanceLabel(distanceKm(lat, lon, c.latitude!, c.longitude!), imperial)} '
                    '${compassPoint(bearingDeg(lat, lon, c.latitude!, c.longitude!))}',
                divider: false,
              ),
            if (mv != null && mv > 0)
              InstrumentRow(
                icon: Icons.battery_std,
                title: '${(mv / 1000).toStringAsFixed(2)} V',
                titleColor: mv < lowBatteryMv ? MeshPalette.alert : null,
                divider: false,
              ),
            if (actions.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(MeshSpace.lg),
                child: Row(
                  children: [
                    for (final (i, a) in actions.indexed) ...[
                      if (i > 0) const SizedBox(width: MeshSpace.sm),
                      a,
                    ],
                  ],
                ),
              ),
          ],
        ),
      );
    },
  );
}
