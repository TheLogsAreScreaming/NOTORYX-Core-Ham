/// Design system v2: the type scale, status colours and motion every screen
/// should use instead of hardcoded sizes and colours. See docs/design/REDESIGN.md.
library;

import 'package:flutter/material.dart';

import 'bastion_themes.dart';
import 'mesh_theme.dart' show MeshFonts;

/// The app's type scale: Material 3 roles, sized for Inter.
///
/// Use `Theme.of(context).textTheme.<role>` (optionally `.copyWith(color:)`)
/// rather than a raw `TextStyle(fontSize: ...)`, so text follows the scale and
/// the system text size.
TextTheme meshTextTheme(ColorScheme scheme) {
  TextStyle s(
    double size,
    FontWeight weight, {
    double spacing = 0,
    double height = 1.3,
    Color? color,
  }) => TextStyle(
    fontFamily: MeshFonts.sans,
    fontFamilyFallback: MeshFonts.sansFallback,
    fontSize: size,
    fontWeight: weight,
    letterSpacing: spacing,
    height: height,
    color: color ?? scheme.onSurface,
  );
  final muted = scheme.onSurfaceVariant;
  return TextTheme(
    displayLarge: s(44, FontWeight.w700, spacing: -1.0, height: 1.1),
    displayMedium: s(36, FontWeight.w700, spacing: -0.8, height: 1.1),
    displaySmall: s(30, FontWeight.w700, spacing: -0.6, height: 1.15),
    headlineLarge: s(28, FontWeight.w700, spacing: -0.5, height: 1.2),
    headlineMedium: s(24, FontWeight.w700, spacing: -0.4, height: 1.2),
    headlineSmall: s(22, FontWeight.w700, spacing: -0.3, height: 1.25),
    titleLarge: s(20, FontWeight.w600, spacing: -0.2, height: 1.25),
    titleMedium: s(16, FontWeight.w600, spacing: -0.1),
    titleSmall: s(14, FontWeight.w600),
    bodyLarge: s(16, FontWeight.w400, height: 1.45),
    bodyMedium: s(14, FontWeight.w400, height: 1.42),
    bodySmall: s(12.5, FontWeight.w400, height: 1.4, color: muted),
    labelLarge: s(14, FontWeight.w600, spacing: 0.1),
    labelMedium: s(12.5, FontWeight.w600, spacing: 0.2, color: muted),
    labelSmall: s(11, FontWeight.w600, spacing: 0.4, color: muted),
  );
}

/// Monospaced figures for radio readings (frequency, SNR, dBm).
TextStyle meshMono(BuildContext context, {double? size, Color? color}) {
  final base = Theme.of(context).textTheme.bodyMedium!;
  return base.copyWith(
    fontFamily: MeshFonts.mono,
    fontFamilyFallback: MeshFonts.monoFallback,
    fontSize: size ?? base.fontSize,
    color: color,
    fontFeatures: const [FontFeature.tabularFigures()],
  );
}

/// What a status message is about.
enum MeshStatus { info, success, warning, error }

/// Colours for success, warning, error and info, matched to the theme.
/// Read with `MeshStatusColors.of(context)`.
@immutable
class MeshStatusColors extends ThemeExtension<MeshStatusColors> {
  const MeshStatusColors({
    required this.info,
    required this.infoContainer,
    required this.success,
    required this.successContainer,
    required this.warning,
    required this.warningContainer,
    required this.error,
    required this.errorContainer,
    required this.onContainer,
  });

  /// Foregrounds (icons, short labels) and the tinted fills behind them.
  final Color info, infoContainer;
  final Color success, successContainer;
  final Color warning, warningContainer;
  final Color error, errorContainer;

  /// Text on any of the containers.
  final Color onContainer;

  factory MeshStatusColors.fromPalette(BastionPalette p) {
    Color tint(Color c) => Color.alphaBlend(c.withAlpha(0x2E), p.bg1);
    return MeshStatusColors(
      info: p.accent,
      infoContainer: tint(p.accent),
      success: p.signal,
      successContainer: tint(p.signal),
      warning: p.warn,
      warningContainer: tint(p.warn),
      error: p.alert,
      errorContainer: tint(p.alert),
      onContainer: p.ink,
    );
  }

  static MeshStatusColors of(BuildContext context) =>
      Theme.of(context).extension<MeshStatusColors>()!;

  Color color(MeshStatus s) => switch (s) {
    MeshStatus.info => info,
    MeshStatus.success => success,
    MeshStatus.warning => warning,
    MeshStatus.error => error,
  };

  Color container(MeshStatus s) => switch (s) {
    MeshStatus.info => infoContainer,
    MeshStatus.success => successContainer,
    MeshStatus.warning => warningContainer,
    MeshStatus.error => errorContainer,
  };

  @override
  MeshStatusColors copyWith() => this;

  @override
  MeshStatusColors lerp(MeshStatusColors? other, double t) {
    if (other == null) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return MeshStatusColors(
      info: l(info, other.info),
      infoContainer: l(infoContainer, other.infoContainer),
      success: l(success, other.success),
      successContainer: l(successContainer, other.successContainer),
      warning: l(warning, other.warning),
      warningContainer: l(warningContainer, other.warningContainer),
      error: l(error, other.error),
      errorContainer: l(errorContainer, other.errorContainer),
      onContainer: l(onContainer, other.onContainer),
    );
  }
}

/// Animation timing. Use [duration] so the system's reduce-motion setting
/// turns animations off.
class MeshMotion {
  MeshMotion._();

  static const short = Duration(milliseconds: 150);
  static const medium = Duration(milliseconds: 250);
  static const long = Duration(milliseconds: 400);
  static const curve = Curves.easeOutCubic;

  static bool reduced(BuildContext context) =>
      MediaQuery.maybeDisableAnimationsOf(context) ?? false;

  /// [d], or zero when the user asked for less motion.
  static Duration duration(BuildContext context, [Duration d = medium]) =>
      reduced(context) ? Duration.zero : d;
}

/// Corner radii by role, so every control of a kind matches.
class MeshShape {
  MeshShape._();

  /// Buttons, inputs, chips and segmented controls.
  static const control = 12.0;

  /// Cards and list groups (matches the frosted glass cards).
  static const card = 16.0;

  /// Dialogs and bottom sheets.
  static const sheet = 24.0;

  /// Minimum touch target.
  static const minTouch = 48.0;
}
