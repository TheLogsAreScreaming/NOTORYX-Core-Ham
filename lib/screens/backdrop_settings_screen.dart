import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../services/backdrop_store.dart';
import '../theme/mesh_theme.dart';
import '../utils/platform_info.dart';
import '../widgets/ember_backdrop.dart';
import '../widgets/tactical_glass_panel.dart';

/// Picks what sits behind the app's glass cards: the theme's glow, a
/// colour, a gradient, a mesh of colour or a photo, with dim and blur.
class BackdropSettingsScreen extends StatefulWidget {
  const BackdropSettingsScreen({super.key, this.store});

  /// Defaults to [BackdropStore.instance].
  final BackdropStore? store;

  @override
  State<BackdropSettingsScreen> createState() => _BackdropSettingsScreenState();
}

class _BackdropSettingsScreenState extends State<BackdropSettingsScreen> {
  bool _busy = false;

  BackdropStore get _store => widget.store ?? BackdropStore.instance;

  void _set(BackdropStyle next) => unawaited(_store.setStyle(next));

  Future<void> _pickPhoto() async {
    final messenger = ScaffoldMessenger.of(context);
    final failed = context.l10n.bg_photoFailed;
    setState(() => _busy = true);
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: BackdropStore.photoMaxSide,
        maxHeight: BackdropStore.photoMaxSide,
        imageQuality: 85,
      );
      if (picked == null) return;
      final ok = await _store.setPhoto(await picked.readAsBytes());
      if (!ok) messenger.showSnackBar(SnackBar(content: Text(failed)));
    } on Exception catch (e, st) {
      debugPrint('Background photo failed: $e\n$st');
      messenger.showSnackBar(SnackBar(content: Text(failed)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  static String _kindLabel(AppLocalizations l10n, BackdropKind k) =>
      switch (k) {
        BackdropKind.theme => l10n.bg_kindTheme,
        BackdropKind.solid => l10n.bg_kindSolid,
        BackdropKind.linear => l10n.bg_kindLinear,
        BackdropKind.mesh => l10n.bg_kindMesh,
        BackdropKind.photo => l10n.bg_kindPhoto,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.bg_title)),
      body: ListenableBuilder(
        listenable: _store,
        builder: (context, _) {
          final style = _store.style;
          final kinds = [
            BackdropKind.theme,
            BackdropKind.solid,
            BackdropKind.linear,
            BackdropKind.mesh,
            if (!PlatformInfo.isWeb) BackdropKind.photo,
          ];
          final usesColours =
              style.kind == BackdropKind.solid ||
              style.kind == BackdropKind.linear ||
              style.kind == BackdropKind.mesh;
          final twoColours =
              style.kind == BackdropKind.linear ||
              style.kind == BackdropKind.mesh;
          return ListView(
            padding: const EdgeInsets.all(MeshSpace.lg),
            children: [
              // Preview: the real backdrop with a glass card on it.
              ClipRRect(
                borderRadius: BorderRadius.circular(MeshRadii.lg),
                child: SizedBox(
                  height: 190,
                  child: EmberBackdrop(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(MeshSpace.xl),
                        child: TacticalGlassPanel(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.bg_previewTitle,
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: MeshSpace.xs),
                              Text(l10n.bg_previewBody),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: MeshSpace.sm),
              Text(l10n.bg_hint, style: textTheme.bodySmall),
              const SizedBox(height: MeshSpace.lg),
              Wrap(
                spacing: MeshSpace.sm,
                runSpacing: MeshSpace.sm,
                children: [
                  for (final k in kinds)
                    ChoiceChip(
                      label: Text(_kindLabel(l10n, k)),
                      selected: style.kind == k,
                      onSelected: (_) {
                        if (k == BackdropKind.photo && _store.photo == null) {
                          unawaited(_pickPhoto());
                        } else {
                          _set(style.copyWith(kind: k));
                        }
                      },
                    ),
                ],
              ),
              if (usesColours) ...[
                const SizedBox(height: MeshSpace.lg),
                _ColourRow(
                  title: twoColours ? l10n.bg_color1 : l10n.bg_kindSolid,
                  selected: style.color1,
                  labelFor: l10n.bg_colorN,
                  onPick: (c) => _set(style.copyWith(color1: c)),
                ),
              ],
              if (twoColours) ...[
                const SizedBox(height: MeshSpace.md),
                _ColourRow(
                  title: l10n.bg_color2,
                  selected: style.color2,
                  labelFor: l10n.bg_colorN,
                  onPick: (c) => _set(style.copyWith(color2: c)),
                ),
              ],
              if (style.kind == BackdropKind.photo) ...[
                const SizedBox(height: MeshSpace.md),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: OutlinedButton.icon(
                    onPressed: _busy ? null : () => unawaited(_pickPhoto()),
                    icon: _busy
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.photo_library_outlined),
                    label: Text(l10n.bg_choosePhoto),
                  ),
                ),
                const SizedBox(height: MeshSpace.xs),
                Text(l10n.bg_photoNotBackedUp, style: textTheme.bodySmall),
              ],
              if (style.isCustom) ...[
                const SizedBox(height: MeshSpace.lg),
                _LabelledSlider(
                  label: l10n.bg_dim,
                  value: style.dim,
                  min: BackdropStyle.minDim,
                  max: BackdropStyle.maxDim,
                  valueText: '${(style.dim * 100).round()}%',
                  onChanged: (v) => _set(style.copyWith(dim: v)),
                ),
                if (style.kind == BackdropKind.photo)
                  _LabelledSlider(
                    label: l10n.bg_blur,
                    value: style.blur,
                    min: 0,
                    max: BackdropStyle.maxBlur,
                    valueText: style.blur.round().toString(),
                    onChanged: (v) => _set(style.copyWith(blur: v)),
                  ),
                const SizedBox(height: MeshSpace.md),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextButton.icon(
                    onPressed: () => unawaited(_store.reset()),
                    icon: const Icon(Icons.restart_alt),
                    label: Text(l10n.bg_reset),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _ColourRow extends StatelessWidget {
  const _ColourRow({
    required this.title,
    required this.selected,
    required this.labelFor,
    required this.onPick,
  });

  final String title;
  final int selected;
  final String Function(int index) labelFor;
  final ValueChanged<int> onPick;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: MeshSpace.sm),
        Wrap(
          spacing: MeshSpace.sm,
          runSpacing: MeshSpace.sm,
          children: [
            for (final (i, c) in BackdropPalette.colors.indexed)
              Semantics(
                button: true,
                selected: c.toARGB32() == selected,
                label: labelFor(i + 1),
                child: ExcludeSemantics(
                  child: InkResponse(
                    onTap: () => onPick(c.toARGB32()),
                    radius: 26,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: c.toARGB32() == selected
                              ? MeshPalette.ink
                              : MeshPalette.line2,
                          width: c.toARGB32() == selected ? 3 : 1,
                        ),
                      ),
                      child: c.toARGB32() == selected
                          ? Icon(
                              Icons.check,
                              color: MeshPalette.readable(MeshPalette.bg, c),
                            )
                          : null,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _LabelledSlider extends StatelessWidget {
  const _LabelledSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.valueText,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final String valueText;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 72, child: Text(label)),
        Expanded(
          child: Slider(
            value: value.clamp(min, max),
            min: min,
            max: max,
            label: valueText,
            semanticFormatterCallback: (_) => valueText,
            onChanged: onChanged,
          ),
        ),
        SizedBox(width: 44, child: Text(valueText, textAlign: TextAlign.end)),
      ],
    );
  }
}

/// The settings row that opens [BackdropSettingsScreen].
class BackdropSettingsTile extends StatelessWidget {
  const BackdropSettingsTile({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final store = BackdropStore.instance;
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) => ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const Icon(Icons.wallpaper_outlined),
        title: Text(l10n.bg_title),
        subtitle: Text(
          _BackdropSettingsScreenState._kindLabel(l10n, store.style.kind),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const BackdropSettingsScreen(),
          ),
        ),
      ),
    );
  }
}
