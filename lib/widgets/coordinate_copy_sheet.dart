import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';
import '../services/app_settings_service.dart';
import '../theme/mesh_theme.dart';
import '../utils/grid_coords.dart';

/// [lat], [lon] in the format chosen in settings.
String formatCoordinateFor(BuildContext context, double lat, double lon) {
  final format = context.read<AppSettingsService>().coordinateFormat;
  return formatCoordinate(lat, lon, format);
}

/// The display name of [format].
String coordinateFormatLabel(BuildContext context, CoordinateFormat format) {
  final l10n = context.l10n;
  switch (format) {
    case CoordinateFormat.decimal:
      return l10n.coords_decimal;
    case CoordinateFormat.dms:
      return l10n.coords_dms;
    case CoordinateFormat.utm:
      return l10n.coords_utm;
    case CoordinateFormat.mgrs:
      return l10n.coords_mgrs;
  }
}

/// A position written in every format, each with its own copy button.
Future<void> showCoordinateCopySheet(
  BuildContext context, {
  required double lat,
  required double lon,
}) {
  return showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    builder: (sheetContext) {
      final l10n = sheetContext.l10n;
      final theme = Theme.of(sheetContext);
      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Text(
                  l10n.coords_copyTitle,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              for (final format in CoordinateFormat.values)
                _CoordinateLine(
                  label: coordinateFormatLabel(sheetContext, format),
                  value: formatCoordinate(lat, lon, format),
                  format: format,
                ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );
    },
  );
}

class _CoordinateLine extends StatelessWidget {
  const _CoordinateLine({
    required this.label,
    required this.value,
    required this.format,
  });

  final String label;
  final String value;
  final CoordinateFormat format;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListTile(
      key: ValueKey('coords-${format.value}'),
      title: Text(label),
      subtitle: Text(value, style: MeshTheme.mono(fontSize: 14)),
      trailing: IconButton(
        icon: const Icon(Icons.copy),
        tooltip: l10n.common_copy,
        onPressed: () async {
          final messenger = ScaffoldMessenger.of(context);
          final message = l10n.coords_copied(label);
          Navigator.pop(context);
          await Clipboard.setData(ClipboardData(text: value));
          messenger
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(message)));
        },
      ),
    );
  }
}
