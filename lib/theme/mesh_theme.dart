import 'package:flutter/material.dart';

import 'bastion_themes.dart';
import 'mesh_design.dart';

export 'bastion_themes.dart';
export 'mesh_design.dart';
import 'okabe_ito.dart';

export 'okabe_ito.dart';

/// Bastion palette: the colors of the theme chosen in Settings. Read these
/// at build time (they are not constants) so a theme switch repaints.
class MeshPalette {
  MeshPalette._();

  /// The palette in use; set from settings before the app builds.
  static BastionPalette current = BastionTheme.fallback.palette;

  static Color get bg => current.bg;
  static Color get bg1 => current.bg1;
  static Color get bg2 => current.bg2;
  static Color get bg3 => current.bg3;
  static Color get bg4 => current.bg4;
  static Color get line => current.line;
  static Color get line2 => current.line2;
  static Color get line3 => current.line3;
  static Color get ink => current.ink;
  static Color get ink2 => current.ink2;
  static Color get ink3 => current.ink3;
  static Color get ink4 => current.ink4;
  static Color get signal => current.signal;
  static Color get signalDim => current.signalDim;
  static Color get warn => current.warn;
  static Color get warnDim => current.warnDim;
  static Color get warnBg => current.warnBg;
  static Color get warnLine => current.warnLine;
  static Color get alert => current.alert;
  static Color get alertBg => current.alertBg;
  static Color get alertLine => current.alertLine;
  static Color get accent => current.accent;
  static Color get accentDim => current.accentDim;
  static Color get accentBg => current.accentBg;
  static Color get accentLine => current.accentLine;
  static Color get onAccent => current.onAccent;
  static Color get magenta => current.magenta;
  static Color get magentaBg => current.magentaBg;
  static Color get magentaLine => current.magentaLine;
  static Color get me => current.me;
  static Color get meBorder => current.meBorder;
  static Color get meInk => current.meInk;

  // ── Light variant (used when user explicitly picks light theme)
  static const lightBg = Color(0xFFF1F1E9);
  static const lightBg1 = Color(0xFFE7EAE2);
  static const lightBg2 = Color(0xFFDDE3DA);
  static const lightLine = Color(0xFFB6C3B9);
  static const lightInk = Color(0xFF24332D);
  static const lightInk2 = Color(0xFF43564B);
  static const lightInk3 = Color(0xFF5D7065);
  static const lightAccent = Color(0xFF386C60);
}

/// High-contrast semantic colors for UI rendered over variable map tiles.
class MapPalette {
  MapPalette._();

  static const online = Color(0xFF93B99D);
  static const offline = Color(0xFF6B7280);
  static const stale = Color(0xFFD6B77C);
  // Node types use the color-blind safe Okabe-Ito palette.
  static const repeater = OkabeIto.orange;
  static const router = OkabeIto.reddishPurple;
  static const batteryLow = Color(0xFFDB8D85);
  static const cluster = OkabeIto.vermillion;
  static const selected = OkabeIto.skyBlue;
  static const sensor = OkabeIto.bluishGreen;
  static const shared = Color(0xFF6D978C);

  static const panelLight = Color(0xF0FFFFFF);
  static const panelDark = Color(0xF50B1220);
  static const textPrimary = Color(0xFFE4E6DF);
  static const textSecondary = Color(0xFFCBD5E1);
  static const textMuted = Color(0xFF94A3B8);
  static const border = Color(0x5264758B);
  static const markerOutline = Colors.white;
  static const markerShadow = Color(0xB3000000);
}

/// High-contrast colors for line-of-sight maps and elevation profiles.
class LosPalette {
  LosPalette._();

  static const terrain = Color(0xFFA3E635);
  static const beam = Color(0xFF38BDF8);
  static const horizon = Color(0xFFFBBF24);
  static const blocked = Color(0xFFDB8D85);
  static const marginal = Color(0xFFD6B77C);
  static const clear = Color(0xFF93B99D);
  static const selected = Color(0xFF8AB6AA);
  static const chartBackground = Color(0xFF0B1220);
  static const panelDark = Color(0xF00F172A);
  static const panelLight = Color(0xF5FFFFFF);
  static const text = Color(0xFFE4E6DF);
  static const textMuted = Color(0xFFCBD5E1);
  static const border = Color(0x5264758B);
  static const shadow = Color(0x99000000);
}

/// Named font stacks — Flutter falls back to system fonts when the named
/// family isn't installed, keeping things working without bundled assets.
class MeshFonts {
  MeshFonts._();

  static const sans = 'Inter';
  static const mono = 'JetBrains Mono';
  static const display = 'Instrument Serif';
  static const emoji = 'Noto Color Emoji';

  static const List<String> sansFallback = [
    'system-ui',
    '-apple-system',
    'Roboto',
    'Noto Sans',
    'sans-serif',
  ];
  static const List<String> monoFallback = [
    'SF Mono',
    'Menlo',
    'Consolas',
    'Roboto Mono',
    'monospace',
  ];
  static const List<String> displayFallback = [
    'Cormorant Garamond',
    'Georgia',
    'Times New Roman',
    'serif',
  ];
  static const List<String> emojiFallback = [
    'Apple Color Emoji',
    'Segoe UI Emoji',
    'Noto Emoji',
  ];
}

/// Radii used consistently across the app.
class MeshRadii {
  MeshRadii._();
  static const xs = 6.0;
  static const sm = 10.0;
  static const md = 14.0;
  static const lg = 18.0;
  static const xl = 24.0;
  static const pill = 999.0;
}

/// Spacing scale. Pick from these instead of one-off gaps so screens share
/// one rhythm.
class MeshSpace {
  MeshSpace._();
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const xxl = 32.0;
}

/// Shared helpers exposed via [MeshTheme.of].
class MeshTheme {
  MeshTheme._();

  /// The current theme if it's dark, otherwise Blaze.
  static ThemeData dark() => forPalette(
    MeshPalette.current.brightness == Brightness.dark
        ? MeshPalette.current
        : BastionTheme.blaze.palette,
  );

  /// The current theme if it's light, otherwise Bubble Gum (the light one).
  static ThemeData light() => forPalette(
    MeshPalette.current.brightness == Brightness.light
        ? MeshPalette.current
        : BastionTheme.bubbleGum.palette,
  );

  /// Material theme for one of the Bastion palettes.
  static ThemeData forPalette(BastionPalette p) {
    final isDark = p.brightness == Brightness.dark;
    final scheme = ColorScheme(
      brightness: p.brightness,
      primary: p.accent,
      onPrimary: p.onAccent,
      primaryContainer: p.primaryContainer,
      onPrimaryContainer: p.ink,
      secondary: p.warn,
      onSecondary: p.bg,
      secondaryContainer: p.secondaryContainer,
      onSecondaryContainer: p.ink,
      tertiary: p.warn,
      onTertiary: isDark ? p.bg : Colors.white,
      tertiaryContainer: p.secondaryContainer,
      onTertiaryContainer: p.ink,
      error: p.alert,
      onError: isDark ? p.bg : Colors.white,
      errorContainer: Color.alphaBlend(p.alert.withAlpha(0x40), p.bg2),
      onErrorContainer: p.ink,
      surface: p.bg,
      onSurface: p.ink,
      surfaceContainerLowest: p.bg,
      surfaceContainerLow: p.bg1,
      surfaceContainer: p.bg1,
      surfaceContainerHigh: p.bg2,
      surfaceContainerHighest: p.bg3,
      onSurfaceVariant: p.ink2,
      outline: p.line2,
      outlineVariant: p.line,
      shadow: Colors.black,
      scrim: Colors.black54,
      inverseSurface: p.ink,
      onInverseSurface: p.bg,
      inversePrimary: p.accentDim,
    );
    return _build(scheme, p.brightness, MeshStatusColors.fromPalette(p));
  }

  static ThemeData _build(
    ColorScheme scheme,
    Brightness brightness,
    MeshStatusColors status,
  ) {
    final text = meshTextTheme(scheme);
    const controlShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(MeshShape.control)),
    );
    const minControl = Size(64, MeshShape.minTouch);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      canvasColor: scheme.surface,
      fontFamily: MeshFonts.sans,
      fontFamilyFallback: MeshFonts.sansFallback,
      textTheme: text,
      extensions: [status],
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,
      dividerColor: scheme.outlineVariant,
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: text.titleLarge,
        iconTheme: IconThemeData(color: scheme.onSurface),
      ),
      // Field-instrument cards: no fill, a hairline outline, squared off.
      cardTheme: CardThemeData(
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: scheme.outlineVariant),
          borderRadius: BorderRadius.circular(MeshRadii.xs),
        ),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: scheme.onSurfaceVariant,
        textColor: scheme.onSurface,
        tileColor: Colors.transparent,
        titleTextStyle: text.bodyLarge,
        subtitleTextStyle: text.bodySmall,
        minVerticalPadding: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MeshShape.control),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        extendedTextStyle: const TextStyle(
          fontFamily: MeshFonts.sans,
          fontFamilyFallback: MeshFonts.sansFallback,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          elevation: 0,
          minimumSize: minControl,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: controlShape,
          textStyle: text.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.onSurface,
          side: BorderSide(color: scheme.outline),
          minimumSize: minControl,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: controlShape,
          textStyle: text.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          minimumSize: const Size(MeshShape.minTouch, MeshShape.minTouch),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          shape: controlShape,
          textStyle: text.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        // Help and error text wraps instead of cutting off at large sizes.
        helperMaxLines: 8,
        errorMaxLines: 8,
        filled: true,
        fillColor: scheme.surfaceContainerHigh,
        hintStyle: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        labelStyle: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        helperStyle: text.bodySmall,
        errorStyle: text.bodySmall?.copyWith(color: scheme.error),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MeshShape.control),
          borderSide: BorderSide(color: scheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MeshShape.control),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MeshShape.control),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        side: BorderSide(color: scheme.outlineVariant),
        labelStyle: text.labelMedium,
        shape: controlShape,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: scheme.primary,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MeshRadii.md),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontFamily: MeshFonts.sans,
            fontFamilyFallback: MeshFonts.sansFallback,
            fontSize: 11.5,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            letterSpacing: 0.1,
            color: selected ? scheme.onPrimary : scheme.onSurfaceVariant,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? scheme.onPrimary : scheme.onSurfaceVariant,
            size: 22,
          );
        }),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: scheme.surfaceContainerLow,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(MeshShape.sheet),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: text.titleLarge,
        contentTextStyle: text.bodyMedium?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MeshShape.sheet),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.surfaceContainerHigh,
        contentTextStyle: text.bodyMedium,
        actionTextColor: scheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MeshRadii.md),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: scheme.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MeshRadii.md),
        ),
      ),
      iconTheme: IconThemeData(color: scheme.onSurfaceVariant, size: 22),
      splashFactory: InkSparkle.splashFactory,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
        },
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          selectedBackgroundColor: scheme.primary.withValues(alpha: 0.16),
          selectedForegroundColor: scheme.primary,
          side: BorderSide(color: scheme.outlineVariant),
          minimumSize: const Size(MeshShape.minTouch, MeshShape.minTouch),
          shape: controlShape,
          textStyle: const TextStyle(
            fontFamily: MeshFonts.sans,
            fontFamilyFallback: MeshFonts.sansFallback,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? scheme.onPrimary
              : scheme.onSurfaceVariant,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? scheme.primary
              : scheme.surfaceContainerHighest,
        ),
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? Colors.transparent
              : scheme.outline,
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: scheme.primary,
        inactiveTrackColor: scheme.surfaceContainerHighest,
        thumbColor: scheme.primary,
        overlayColor: scheme.primary.withValues(alpha: 0.12),
        valueIndicatorColor: scheme.surfaceContainerHighest,
        valueIndicatorTextStyle: TextStyle(
          fontFamily: MeshFonts.mono,
          fontFamilyFallback: MeshFonts.monoFallback,
          color: scheme.onSurface,
          fontSize: 12,
        ),
        trackHeight: 3,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: scheme.primary,
        unselectedLabelColor: scheme.onSurfaceVariant,
        indicatorColor: scheme.primary,
        dividerColor: scheme.outlineVariant,
        labelStyle: const TextStyle(
          fontFamily: MeshFonts.sans,
          fontFamilyFallback: MeshFonts.sansFallback,
          fontSize: 13.5,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: MeshFonts.sans,
          fontFamilyFallback: MeshFonts.sansFallback,
          fontSize: 13.5,
          fontWeight: FontWeight.w500,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: scheme.surfaceContainerHigh,
        circularTrackColor: Colors.transparent,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(MeshRadii.sm),
          border: Border.all(color: scheme.outline),
        ),
        textStyle: text.bodySmall?.copyWith(color: scheme.onSurface),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          minimumSize: minControl,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: controlShape,
          textStyle: text.labelLarge,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(MeshShape.minTouch, MeshShape.minTouch),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? scheme.primary
              : Colors.transparent,
        ),
        checkColor: WidgetStatePropertyAll(scheme.onPrimary),
        side: BorderSide(color: scheme.outline, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? scheme.primary
              : scheme.outline,
        ),
      ),
    );
  }

  /// Mono text style — sizes default to the body size Inter is using.
  static TextStyle mono({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: MeshFonts.mono,
      fontFamilyFallback: MeshFonts.monoFallback,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing ?? 0.2,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }

  /// Serif display style.
  static TextStyle display({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: MeshFonts.display,
      fontFamilyFallback: MeshFonts.displayFallback,
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.w400,
      color: color,
      letterSpacing: letterSpacing ?? -0.2,
    );
  }

  /// Section-accent / chip label — sans for legibility, with light tracking
  /// to keep the "label" feel that section headers rely on.
  static TextStyle accentLabel({Color? color, double? fontSize}) {
    return TextStyle(
      fontFamily: MeshFonts.sans,
      fontFamilyFallback: MeshFonts.sansFallback,
      fontSize: fontSize ?? 11,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.6,
      color: color,
    );
  }

  /// Section title: sentence case, quiet, and never the accent color, so
  /// the accent stays free for actions and live status.
  static TextStyle sectionTitle({Color? color}) {
    return TextStyle(
      fontFamily: MeshFonts.sans,
      fontFamilyFallback: MeshFonts.sansFallback,
      fontSize: 13.5,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
      color: color ?? MeshPalette.ink3,
    );
  }

  /// Color-emoji style with platform fallbacks and stable vertical metrics.
  static TextStyle emoji({double fontSize = 28}) {
    return TextStyle(
      fontFamily: MeshFonts.emoji,
      fontFamilyFallback: MeshFonts.emojiFallback,
      fontSize: fontSize,
      height: 1,
    );
  }

  /// Color-code an SNR value for consistency across the app.
  static Color snrColor(num? snr, {required bool blocked}) {
    if (blocked) return MeshPalette.alert;
    if (snr == null) return MeshPalette.ink3;
    if (snr > -5) return MeshPalette.signal;
    if (snr > -12) return MeshPalette.warn;
    return MeshPalette.alert;
  }
}
