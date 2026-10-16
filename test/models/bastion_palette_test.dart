import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/theme/mesh_theme.dart';

double contrast(Color a, Color b) {
  final x = a.computeLuminance(), y = b.computeLuminance();
  return x > y ? (x + .05) / (y + .05) : (y + .05) / (x + .05);
}

void main() {
  test(
    'calm dark and light themes retain readable primary text and buttons',
    () {
      for (final theme in [MeshTheme.dark(), MeshTheme.light()]) {
        final scheme = theme.colorScheme;
        expect(
          contrast(scheme.onSurface, scheme.surface),
          greaterThanOrEqualTo(4.5),
        );
        expect(
          contrast(scheme.onSurfaceVariant, scheme.surfaceContainerHigh),
          greaterThanOrEqualTo(4.5),
        );
        expect(
          contrast(scheme.onPrimary, scheme.primary),
          greaterThanOrEqualTo(4.5),
        );
        expect(
          contrast(scheme.onSecondary, scheme.secondary),
          greaterThanOrEqualTo(4.5),
        );
      }
    },
  );
}
