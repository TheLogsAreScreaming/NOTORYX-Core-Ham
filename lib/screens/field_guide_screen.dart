import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/l10n.dart';
import '../theme/mesh_theme.dart';
import '../widgets/instrument.dart';
import '../widgets/ember_backdrop.dart';

/// Short, practical tips for getting on the mesh and keeping a radio
/// running outdoors, with links to the longer community guides.
class FieldGuideScreen extends StatelessWidget {
  const FieldGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    Widget tip(String text) => Padding(
      padding: const EdgeInsets.fromLTRB(
        MeshSpace.lg,
        MeshSpace.sm,
        MeshSpace.lg,
        MeshSpace.sm,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7, right: 10),
            child: Container(width: 5, height: 5, color: MeshPalette.ink3),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: MeshPalette.ink,
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
    void open(String url) => unawaited(
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
    );
    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: Text(t.guide_title),
        ),
        body: ListView(
          padding: const EdgeInsets.only(bottom: MeshSpace.xxl),
          children: [
            InstrumentLabel(t.guide_secMesh),
            tip(t.guide_mesh1),
            tip(t.guide_mesh2),
            tip(t.guide_mesh3),
            InstrumentLabel(t.guide_secCold),
            tip(t.guide_cold1),
            tip(t.guide_cold2),
            tip(t.guide_cold3),
            InstrumentLabel(t.guide_secSolar),
            tip(t.guide_solar1),
            tip(t.guide_solar2),
            InstrumentLabel(t.guide_secAntenna),
            tip(t.guide_ant1),
            tip(t.guide_ant2),
            InstrumentLabel(t.guide_secMore),
            InstrumentRow(
              icon: Icons.open_in_new,
              title: 'meshcore.io',
              subtitle: t.guide_moreMeshcore,
              onTap: () => open('https://meshcore.io'),
            ),
            InstrumentRow(
              icon: Icons.open_in_new,
              title: 'cascadiamesh.org',
              subtitle: t.guide_moreCascadia,
              onTap: () => open('https://cascadiamesh.org'),
            ),
          ],
        ),
      ),
    );
  }
}
