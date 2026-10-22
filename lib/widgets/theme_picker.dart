import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/app_settings_service.dart';
import '../theme/mesh_theme.dart';

/// The Bastion themes as tappable swatches; the choice applies at once.
class ThemePicker extends StatelessWidget {
  const ThemePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettingsService>();
    final selected = BastionTheme.fromId(settings.settings.appTheme);
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 720
            ? BastionTheme.values.length
            : constraints.maxWidth >= 560
            ? 3
            : 2;
        const gap = 10.0;
        final width = (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final t in BastionTheme.values)
              SizedBox(
                width: width,
                child: _Swatch(
                  theme: t,
                  selected: t == selected,
                  onTap: () => settings.setAppTheme(t.id),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _Swatch extends StatelessWidget {
  final BastionTheme theme;
  final bool selected;
  final VoidCallback onTap;
  const _Swatch({
    required this.theme,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final p = theme.palette;
    final ring = Theme.of(context).colorScheme.primary;
    return Semantics(
      button: true,
      selected: selected,
      label: '${theme.label} theme. ${theme.description}',
      excludeSemantics: true,
      child: InkWell(
        key: ValueKey('theme-${theme.id}'),
        onTap: onTap,
        borderRadius: BorderRadius.circular(MeshRadii.md),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: p.bg,
            borderRadius: BorderRadius.circular(MeshRadii.md),
            border: Border.all(
              color: selected ? ring : p.line,
              width: selected ? 2.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: p.bg2,
                  borderRadius: BorderRadius.circular(MeshRadii.xs),
                  border: Border.all(color: p.line),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: p.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(child: Container(height: 6, color: p.ink3)),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 16,
                      decoration: BoxDecoration(
                        color: p.accent,
                        borderRadius: BorderRadius.circular(MeshRadii.xs),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 22,
                    height: 16,
                    decoration: BoxDecoration(
                      color: p.alert,
                      borderRadius: BorderRadius.circular(MeshRadii.xs),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      theme.label,
                      style: TextStyle(
                        color: p.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (selected)
                    Icon(Icons.check_circle, size: 18, color: p.accent),
                ],
              ),
              Text(
                theme.description,
                maxLines: 2,
                style: TextStyle(color: p.ink3, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
