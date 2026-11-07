import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../services/app_settings_service.dart';
import '../theme/mesh_theme.dart';

/// The eight themes as cards, each with a miniature of the app in that
/// theme. A tap applies and saves the theme at once. When Seasonal is
/// chosen, its season and holiday controls appear below.
class ThemePicker extends StatelessWidget {
  const ThemePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final service = context.watch<AppSettingsService>();
    final settings = service.settings;
    final selected = BastionTheme.fromId(settings.appTheme);
    final season = activeSeason(
      override: settings.seasonalOverride,
      holidays: settings.seasonalHolidays,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 300 ? 2 : 1;
            const gap = 12.0;
            final width =
                (constraints.maxWidth - gap * (columns - 1)) / columns;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final t in BastionTheme.values)
                  SizedBox(
                    width: width,
                    child: _ThemeCard(
                      theme: t,
                      palette: t == BastionTheme.seasonal
                          ? season.palette
                          : t.palette,
                      selected: t == selected,
                      onTap: () => service.setAppTheme(t.id),
                    ),
                  ),
              ],
            );
          },
        ),
        if (selected == BastionTheme.seasonal) ...[
          const SizedBox(height: 12),
          _SeasonalControls(service: service, active: season),
        ],
      ],
    );
  }
}

/// The short description of [theme], in the app's language.
String themeDescription(AppLocalizations l10n, BastionTheme theme) =>
    switch (theme) {
      BastionTheme.blaze => l10n.theme_descBlaze,
      BastionTheme.neonAnarchy => l10n.theme_descNeonAnarchy,
      BastionTheme.tactical => l10n.theme_descTactical,
      BastionTheme.pinkOverload => l10n.theme_descPinkOverload,
      BastionTheme.bareBeauty => l10n.theme_descBareBeauty,
      BastionTheme.okabeIto => l10n.theme_descOkabeIto,
      BastionTheme.nightOps => l10n.theme_descNightOps,
      BastionTheme.seasonal => l10n.theme_descSeasonal,
    };

/// The name of [season], in the app's language.
String seasonName(AppLocalizations l10n, Season season) => switch (season) {
  Season.spring => l10n.season_spring,
  Season.summer => l10n.season_summer,
  Season.autumn => l10n.season_autumn,
  Season.winter => l10n.season_winter,
  Season.halloween => l10n.season_halloween,
  Season.christmas => l10n.season_christmas,
  Season.valentine => l10n.season_valentine,
};

class _ThemeCard extends StatelessWidget {
  const _ThemeCard({
    required this.theme,
    required this.palette,
    required this.selected,
    required this.onTap,
  });

  final BastionTheme theme;
  final BastionPalette palette;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final p = palette;
    final ring = Theme.of(context).colorScheme.primary;
    final description = themeDescription(l10n, theme);
    final radius = BorderRadius.circular(MeshRadii.lg);
    return Semantics(
      button: true,
      selected: selected,
      label: '${theme.label}. $description',
      // Excluding the children drops the InkWell's tap, so add it back or
      // screen-reader users couldn't choose a theme.
      onTap: onTap,
      excludeSemantics: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          key: ValueKey('theme-${theme.id}'),
          onTap: onTap,
          borderRadius: radius,
          child: AnimatedContainer(
            duration: MediaQuery.disableAnimationsOf(context)
                ? Duration.zero
                : const Duration(milliseconds: 180),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: p.bg,
              borderRadius: radius,
              border: Border.all(
                color: selected ? ring : p.line2,
                width: selected ? 3 : 1,
              ),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: ring.withValues(alpha: 0.35),
                        blurRadius: 12,
                      ),
                    ]
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _MiniApp(palette: p),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        theme.label,
                        style: TextStyle(
                          color: p.ink,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    if (selected)
                      Icon(Icons.check_circle, size: 20, color: p.accent),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(color: p.ink3, fontSize: 12, height: 1.25),
                ),
                if (selected) ...[
                  const SizedBox(height: 4),
                  Text(
                    l10n.theme_selected,
                    style: TextStyle(
                      color: p.accent,
                      fontSize: 12,
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

/// A miniature of the app: app bar, a received and a sent message, a
/// button, an SOS chip and the navigation bar, all in [palette].
class _MiniApp extends StatelessWidget {
  const _MiniApp({required this.palette});

  final BastionPalette palette;

  @override
  Widget build(BuildContext context) {
    final p = palette;
    Widget bar(double width, Color color, {double height = 5}) => Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(MeshRadii.sm),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [p.bg1, Color.lerp(p.bg1, p.secondary, 0.10)!],
          ),
          border: Border.all(color: p.line),
          borderRadius: BorderRadius.circular(MeshRadii.sm),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // App bar.
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
                  const SizedBox(width: 6),
                  bar(36, p.ink),
                  const Spacer(),
                  bar(14, p.ink3),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Received message.
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: p.bg3,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bar(20, p.tertiary, height: 4),
                          const SizedBox(height: 3),
                          bar(44, p.ink2, height: 4),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Sent message.
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: p.me,
                        border: Border.all(color: p.meBorder),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: bar(38, p.meInk, height: 4),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 16,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: p.accent,
                            borderRadius: BorderRadius.circular(MeshRadii.pill),
                          ),
                          child: bar(22, p.onAccent, height: 4),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        height: 16,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: p.alert,
                          borderRadius: BorderRadius.circular(MeshRadii.pill),
                        ),
                        child: Text(
                          'SOS',
                          style: TextStyle(
                            color: p.brightness == Brightness.dark
                                ? p.bg
                                : Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Navigation bar.
            Container(
              color: p.bg2,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (final c in [p.accent, p.ink4, p.ink4, p.ink4])
                    Container(
                      width: c == p.accent ? 16 : 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: c,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SeasonalControls extends StatelessWidget {
  const _SeasonalControls({required this.service, required this.active});

  final AppSettingsService service;
  final Season active;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final settings = service.settings;
    final auto = seasonFor(DateTime.now(), holidays: settings.seasonalHolidays);
    final value = Season.fromId(settings.seasonalOverride)?.id ?? 'auto';
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MeshRadii.md),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          ListTile(
            key: const ValueKey('seasonal-season'),
            leading: const Icon(Icons.eco_outlined),
            title: Text(l10n.seasonal_season),
            subtitle: Text(
              value == 'auto'
                  ? l10n.seasonal_autoHint
                  : seasonName(l10n, active),
            ),
            trailing: DropdownButton<String>(
              value: value,
              underline: const SizedBox.shrink(),
              onChanged: (v) {
                if (v != null) service.setSeasonalOverride(v);
              },
              items: [
                DropdownMenuItem(
                  value: 'auto',
                  child: Text(l10n.seasonal_auto(seasonName(l10n, auto))),
                ),
                for (final s in Season.values)
                  DropdownMenuItem(
                    value: s.id,
                    child: Text(seasonName(l10n, s)),
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          SwitchListTile(
            key: const ValueKey('seasonal-holidays'),
            secondary: const Icon(Icons.celebration_outlined),
            title: Text(l10n.seasonal_holidays),
            subtitle: Text(l10n.seasonal_holidaysHint),
            value: settings.seasonalHolidays,
            onChanged: service.setSeasonalHolidays,
          ),
        ],
      ),
    );
  }
}
