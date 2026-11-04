import 'package:flutter/material.dart';

/// Every color a Bastion theme defines. [MeshPalette] reads the current one.
class BastionPalette {
  final Brightness brightness;

  // Surfaces, darkest (or base) first.
  final Color bg, bg1, bg2, bg3, bg4;
  // Lines, faint to strong.
  final Color line, line2, line3;
  // Text, strongest to faintest.
  final Color ink, ink2, ink3, ink4;
  // Signal quality (SNR) colors.
  final Color signal, signalDim;
  final Color warn, warnDim;
  final Color alert;
  final Color accent, accentDim, onAccent;
  final Color magenta;
  // Your own chat bubbles.
  final Color me, meBorder, meInk;
  // Filled containers for the color scheme.
  final Color primaryContainer, secondaryContainer;

  const BastionPalette({
    required this.brightness,
    required this.bg,
    required this.bg1,
    required this.bg2,
    required this.bg3,
    required this.bg4,
    required this.line,
    required this.line2,
    required this.line3,
    required this.ink,
    required this.ink2,
    required this.ink3,
    required this.ink4,
    required this.signal,
    required this.signalDim,
    required this.warn,
    required this.warnDim,
    required this.alert,
    required this.accent,
    required this.accentDim,
    required this.onAccent,
    required this.magenta,
    required this.me,
    required this.meBorder,
    required this.meInk,
    required this.primaryContainer,
    required this.secondaryContainer,
  });

  Color get warnBg => warn.withAlpha(0x1F);
  Color get warnLine => warn.withAlpha(0x66);
  Color get alertBg => alert.withAlpha(0x1F);
  Color get alertLine => alert.withAlpha(0x66);
  Color get accentBg => accent.withAlpha(0x29);
  Color get accentLine => accent.withAlpha(0x80);
  Color get magentaBg => magenta.withAlpha(0x1C);
  Color get magentaLine => magenta.withAlpha(0x47);
}

/// The themes offered in Settings.
enum BastionTheme {
  blaze(
    'blaze',
    'Blaze',
    'Slate with hi-vis blaze orange',
    BastionPalette(
      brightness: Brightness.dark,
      bg: Color(0xFF15181B),
      bg1: Color(0xFF1A1E21),
      bg2: Color(0xFF1F2428),
      bg3: Color(0xFF272D32),
      bg4: Color(0xFF33393E),
      line: Color(0xFF33393E),
      line2: Color(0xFF454C52),
      line3: Color(0xFF61686E),
      ink: Color(0xFFF2EFEA),
      ink2: Color(0xFFD9D5CE),
      ink3: Color(0xFFB3AFA8),
      ink4: Color(0xFF9A9A95),
      signal: Color(0xFF8FCB9B),
      signalDim: Color(0xFF6FA37B),
      warn: Color(0xFFF5C85A),
      warnDim: Color(0xFFC9A043),
      alert: Color(0xFFFF5A4E),
      accent: Color(0xFFFF9A3C),
      accentDim: Color(0xFFC97526),
      onAccent: Color(0xFF2A1300),
      magenta: Color(0xFFC8A6D6),
      me: Color(0xFF3A2A1C),
      meBorder: Color(0xFFB5732F),
      meInk: Color(0xFFF2EFEA),
      primaryContainer: Color(0xFF4A2E14),
      secondaryContainer: Color(0xFF4A3F22),
    ),
  ),
  autumnFrost(
    'autumn_frost',
    'Autumn Frost',
    'Frozen slate, pine and amber leaves',
    BastionPalette(
      brightness: Brightness.dark,
      bg: Color(0xFF1A262C),
      bg1: Color(0xFF1F2D34),
      // Frozen Slate
      bg2: Color(0xFF24343C),
      bg3: Color(0xFF2C3F48),
      // Pine Frost
      bg4: Color(0xFF3A574C),
      line: Color(0xFF2C3F48),
      line2: Color(0xFF3E525C),
      line3: Color(0xFF5C727C),
      ink: Color(0xFFF1E9DC),
      ink2: Color(0xFFD9CDBB),
      ink3: Color(0xFFB9AD9A),
      ink4: Color(0xFFA69A87),
      signal: Color(0xFF8FC79F),
      signalDim: Color(0xFF6F9F7E),
      warn: Color(0xFFE8C062),
      warnDim: Color(0xFFB8963F),
      alert: Color(0xFFFF7A63),
      // A brighter Amber Oak, so buttons and links read on the slate.
      accent: Color(0xFFD9A04E),
      // Amber Oak
      accentDim: Color(0xFFA06A25),
      onAccent: Color(0xFF24170A),
      magenta: Color(0xFFC9A0B8),
      // Chestnut Ember
      me: Color(0xFF854D2B),
      meBorder: Color(0xFFA06A25),
      meInk: Color(0xFFFBF1E4),
      primaryContainer: Color(0xFF3A574C),
      // Bronze Leaf
      secondaryContainer: Color(0xFF87591F),
    ),
  ),
  bubbleGum(
    'bubble_gum',
    'Bubble Gum',
    'Pastel lavender, pink and sky blue',
    BastionPalette(
      brightness: Brightness.light,
      bg: Color(0xFFFAF4FC),
      bg1: Color(0xFFFFC8DC),
      bg2: Color(0xFFFFF7FC),
      bg3: Color(0xFFBEE0FE),
      bg4: Color(0xFFCDB4DA),
      line: Color(0xFFCDB4DA),
      line2: Color(0xFFAF8DC0),
      line3: Color(0xFF80648F),
      ink: Color(0xFF34243F),
      ink2: Color(0xFF53445F),
      ink3: Color(0xFF685572),
      ink4: Color(0xFF705C7A),
      signal: Color(0xFF27684D),
      signalDim: Color(0xFF397D63),
      warn: Color(0xFF80510C),
      warnDim: Color(0xFF936718),
      alert: Color(0xFFA32655),
      accent: Color(0xFF704887),
      accentDim: Color(0xFFA2D2FF),
      onAccent: Color(0xFFFFF7FC),
      magenta: Color(0xFF8E3A6A),
      me: Color(0xFFFFAFCC),
      meBorder: Color(0xFFCDB4DA),
      meInk: Color(0xFF34243F),
      primaryContainer: Color(0xFFBEE0FE),
      secondaryContainer: Color(0xFFFFC8DC),
    ),
  ),
  redLight(
    'red_light',
    'Red light',
    'All red, keeps your night vision',
    BastionPalette(
      brightness: Brightness.dark,
      bg: Color(0xFF0A0606),
      bg1: Color(0xFF110909),
      bg2: Color(0xFF160C0C),
      bg3: Color(0xFF1E1010),
      bg4: Color(0xFF2C1715),
      line: Color(0xFF3A1A18),
      line2: Color(0xFF4E2421),
      line3: Color(0xFF6A322E),
      ink: Color(0xFFE8B4AE),
      ink2: Color(0xFFD69A93),
      ink3: Color(0xFFB98179),
      ink4: Color(0xFFA06C66),
      signal: Color(0xFFE08A7E),
      signalDim: Color(0xFFB06A60),
      warn: Color(0xFFFF8A5C),
      warnDim: Color(0xFFC96A45),
      alert: Color(0xFFFF2D20),
      accent: Color(0xFFFF4A3D),
      accentDim: Color(0xFFC23A30),
      onAccent: Color(0xFF1A0503),
      magenta: Color(0xFFC98C88),
      me: Color(0xFF3A1412),
      meBorder: Color(0xFF8A2E28),
      meInk: Color(0xFFF0C2BC),
      primaryContainer: Color(0xFF4A1512),
      secondaryContainer: Color(0xFF3D1A10),
    ),
  );

  const BastionTheme(this.id, this.label, this.description, this.palette);
  final String id;
  final String label;
  final String description;
  final BastionPalette palette;

  static const fallback = BastionTheme.blaze;

  static BastionTheme fromId(String? id) {
    // Existing Topo night selections follow its replacement without losing
    // the saved preference or falling back to an unrelated theme.
    if (id == 'topo_night') return bubbleGum;
    // Christmas became Autumn Frost. Alpine day is gone; its people get the
    // default.
    if (id == 'christmas') return autumnFrost;
    if (id == 'alpine_day') return fallback;
    for (final t in values) {
      if (t.id == id) return t;
    }
    return fallback;
  }
}
