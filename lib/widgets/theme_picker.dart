import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../services/app_settings_service.dart';
import '../theme/mesh_theme.dart';

/// The themes as cards with a miniature of each one; a tap applies the
/// theme at once and saves it.
class ThemePicker extends StatelessWidget {
  const ThemePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettingsService>();
    final selected = BastionTheme.fromId(settings.settings.appTheme);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            // Two columns on a phone, four on a tablet, one on a very
            // narrow screen or at very large text.
            final scale = MediaQuery.textScalerOf(context).scale(1);
            final columns = constraints.maxWidth >= 720
                ? 4
                : constraints.maxWidth >= 300 && scale < 1.8
                ? 2
                : 1;
            const gap = MeshSpace.sm;
            final width =
                (constraints.maxWidth - gap * (columns - 1)) / columns;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final t in BastionTheme.values)
                  SizedBox(
                    width: width,
                    child: ThemeCard(
                      theme: t,
                      selected: t == selected,
                      onTap: () => settings.setAppTheme(t.id),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

String _description(AppLocalizations l10n, BastionTheme t) => switch (t) {
  BastionTheme.blackout => l10n.theme_desc_blackout,
  BastionTheme.blaze => l10n.theme_desc_blaze,
  BastionTheme.tactical => l10n.theme_desc_tactical,
  BastionTheme.okabeIto => l10n.theme_desc_okabe_ito,
  BastionTheme.nightOps => l10n.theme_desc_night_ops,
};

/// One theme: a miniature screen drawn in that theme's own colours, its
/// name and description, and a tick plus "Selected" when it is in use.
class ThemeCard extends StatelessWidget {
  const ThemeCard({
    super.key,
    required this.theme,
    required this.selected,
    required this.onTap,
  });

  final BastionTheme theme;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = theme.palette;
    final text = Theme.of(context).textTheme;
    final ring = Theme.of(context).colorScheme.primary;
    final description = _description(l10n, theme);
    final radius = BorderRadius.circular(MeshShape.card);
    return Semantics(
      button: true,
      selected: selected,
      label: '${theme.label}. $description',
      excludeSemantics: true,
      child: Material(
        color: p.bg,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(
            color: selected ? ring : p.line2,
            width: selected ? 3 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          key: ValueKey('theme-${theme.id}'),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(MeshSpace.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExcludeSemantics(child: _Miniature(p)),
                const SizedBox(height: MeshSpace.sm),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        theme.label,
                        style: text.titleSmall?.copyWith(
                          color: p.ink,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (selected)
                      Icon(Icons.check_circle_rounded, size: 20, color: p.nav),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: text.bodySmall?.copyWith(color: p.ink3),
                ),
                if (selected) ...[
                  const SizedBox(height: MeshSpace.xs),
                  Text(
                    l10n.theme_selected,
                    style: text.labelMedium?.copyWith(
                      color: p.nav,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A small screen in [p]'s colours: header, a received and a sent message,
/// a button, the three status colours, and the bottom bar.
class _Miniature extends StatelessWidget {
  const _Miniature(this.p);

  final BastionPalette p;

  @override
  Widget build(BuildContext context) {
    Widget bar(double w, Color c, {double h = 5}) => Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: c,
        borderRadius: BorderRadius.circular(h),
      ),
    );
    Widget bubble(Color fill, Color ink, {required bool mine, Color? edge}) =>
        Align(
          alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            decoration: BoxDecoration(
              color: fill,
              border: edge == null ? null : Border.all(color: edge),
              borderRadius: BorderRadius.circular(8),
            ),
            child: bar(mine ? 34 : 46, ink.withValues(alpha: 0.85), h: 4),
          ),
        );
    return AspectRatio(
      aspectRatio: 1.25,
      child: Container(
        decoration: BoxDecoration(
          color: p.bg1,
          borderRadius: BorderRadius.circular(MeshShape.control),
          border: Border.all(color: p.line),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Container(
              color: p.bg2,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: p.signal,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  bar(40, p.ink),
                  const Spacer(),
                  bar(14, p.ink4),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    bubble(p.bg3, p.ink, mine: false),
                    bubble(p.me, p.meInk, mine: true, edge: p.meBorder),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 14,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: p.accent,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: bar(22, p.onAccent, h: 3),
                          ),
                        ),
                        const SizedBox(width: 5),
                        for (final c in [p.signal, p.warn, p.alert]) ...[
                          Container(
                            width: 9,
                            height: 9,
                            decoration: BoxDecoration(
                              color: c,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 3),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: p.bg2,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  bar(12, p.nav, h: 6),
                  for (var i = 0; i < 3; i++) bar(10, p.ink4, h: 6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
