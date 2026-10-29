import 'package:flutter/material.dart';

import '../helpers/path_hash_filter_command.dart';
import '../l10n/l10n.dart';
import '../theme/mesh_theme.dart';

/// Drafts a path-width forwarding rule and returns the command text. It
/// sends nothing: the command lands in the console for you to check.
class PathHashFilterDialog extends StatefulWidget {
  const PathHashFilterDialog({super.key});

  @override
  State<PathHashFilterDialog> createState() => _PathHashFilterDialogState();
}

class _PathHashFilterDialogState extends State<PathHashFilterDialog> {
  final _rate = TextEditingController(text: '10');
  // 0 = any width; 22 = "2 or more".
  int _width = 1;
  String _mode = 'radio';
  bool _limit = false;

  @override
  void dispose() {
    _rate.dispose();
    super.dispose();
  }

  int? get _rateValue => int.tryParse(_rate.text.trim());

  String? get _command {
    final rate = _limit ? _rateValue : null;
    if (_limit && (rate == null || rate < 1 || rate > 65534)) return null;
    return buildPathHashFilterCommand(
      hashBytes: _width == 22 ? 2 : _width,
      orMore: _width == 22,
      mode: _mode,
      ratePerMinute: rate,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.l10n;
    final command = _command;
    return AlertDialog(
      title: Text(t.pathFilter_title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              t.pathFilter_firmwareNote,
              style: TextStyle(color: MeshPalette.warn, fontSize: 13),
            ),
            const SizedBox(height: MeshSpace.md),
            DropdownButtonFormField<int>(
              isExpanded: true,
              initialValue: _width,
              decoration: InputDecoration(labelText: t.pathFilter_width),
              items: [
                DropdownMenuItem(value: 0, child: Text(t.pathFilter_anyWidth)),
                for (final w in [1, 2, 3])
                  DropdownMenuItem(
                    value: w,
                    child: Text(t.pathFilter_bytes(w)),
                  ),
                DropdownMenuItem(
                  value: 22,
                  child: Text(t.pathFilter_twoOrMore),
                ),
              ],
              onChanged: (v) => setState(() => _width = v ?? _width),
            ),
            const SizedBox(height: MeshSpace.md),
            DropdownButtonFormField<String>(
              isExpanded: true,
              initialValue: _mode,
              decoration: InputDecoration(labelText: t.pathFilter_path),
              items: [
                DropdownMenuItem(
                  value: 'radio',
                  child: Text(t.pathFilter_radio),
                ),
                DropdownMenuItem(
                  value: 'bridge',
                  child: Text(t.pathFilter_bridge),
                ),
                DropdownMenuItem(
                  value: 'cross',
                  child: Text(t.pathFilter_cross),
                ),
                DropdownMenuItem(
                  value: 'bridge,cross',
                  child: Text(t.pathFilter_bridgeCross),
                ),
              ],
              onChanged: (v) => setState(() => _mode = v ?? _mode),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(t.pathFilter_limit),
              subtitle: Text(_limit ? t.pathFilter_limitOn : t.pathFilter_drop),
              value: _limit,
              onChanged: (v) => setState(() => _limit = v),
            ),
            if (_limit)
              TextField(
                controller: _rate,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: t.pathFilter_perMinute,
                  errorText: command == null ? t.pathFilter_rateInvalid : null,
                ),
                onChanged: (_) => setState(() {}),
              ),
            const SizedBox(height: MeshSpace.md),
            SelectableText(
              command ?? '',
              style: MeshTheme.mono(fontSize: 13, color: MeshPalette.ink),
            ),
            const SizedBox(height: MeshSpace.sm),
            Text(
              t.pathFilter_reviewNote,
              style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(t.common_cancel),
        ),
        FilledButton(
          onPressed: command == null
              ? null
              : () => Navigator.pop(context, command),
          child: Text(t.pathFilter_useCommand),
        ),
      ],
    );
  }
}
