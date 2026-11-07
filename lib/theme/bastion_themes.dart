import 'package:flutter/material.dart';

import 'okabe_ito.dart';

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
  // A second and third hue, so a theme isn't one accent on grey. Used for
  // icons, chips, highlights and the background glow; never for status.
  final Color secondary, tertiary;
  final Color magenta;
  // Your own chat bubbles.
  final Color me, meBorder, meInk;
  // Filled containers for the color scheme.
  final Color primaryContainer, secondaryContainer, tertiaryContainer;

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
    required this.secondary,
    required this.tertiary,
    required this.magenta,
    required this.me,
    required this.meBorder,
    required this.meInk,
    required this.primaryContainer,
    required this.secondaryContainer,
    required this.tertiaryContainer,
  });

  /// The theme's hues in order, for giving neighbouring icons or groups
  /// their own color. Pick by index with [hue].
  List<Color> get spectrum => [accent, secondary, tertiary, magenta, signal];

  /// The [spectrum] color for item [index], repeating.
  Color hue(int index) => spectrum[index % spectrum.length];

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
      // Glacier teal and ultraviolet against the blaze orange.
      secondary: Color(0xFF3FC8D8),
      tertiary: Color(0xFFB39BFF),
      magenta: Color(0xFFFF7AB8),
      me: Color(0xFF3A2A1C),
      meBorder: Color(0xFFB5732F),
      meInk: Color(0xFFF2EFEA),
      primaryContainer: Color(0xFF4A2E14),
      secondaryContainer: Color(0xFF12393F),
      tertiaryContainer: Color(0xFF2E2550),
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
      // Frost blue and cranberry beside the amber leaves.
      secondary: Color(0xFF8CC9E8),
      tertiary: Color(0xFFE8798E),
      magenta: Color(0xFFD98CC4),
      // Chestnut Ember
      me: Color(0xFF854D2B),
      meBorder: Color(0xFFA06A25),
      meInk: Color(0xFFFBF1E4),
      primaryContainer: Color(0xFF3A574C),
      // Bronze Leaf
      secondaryContainer: Color(0xFF87591F),
      tertiaryContainer: Color(0xFF5A2A33),
    ),
  ),
  bubbleGum(
    'bubble_gum',
    'Bubble Gum',
    'Rose pink, hot pink and lavender',
    BastionPalette(
      brightness: Brightness.light,
      // A rose pink page instead of near-white, so it's easier on the eyes.
      bg: Color(0xFFF2A9C9),
      bg1: Color(0xFFEE9DC1),
      bg2: Color(0xFFF7C3DA),
      bg3: Color(0xFFE890BA),
      bg4: Color(0xFFD9A2E6),
      line: Color(0xFFE48AB6),
      line2: Color(0xFFC9659C),
      line3: Color(0xFF9C3F78),
      ink: Color(0xFF3A0A2A),
      ink2: Color(0xFF561540),
      ink3: Color(0xFF6A1B4F),
      ink4: Color(0xFF6E1C52),
      signal: Color(0xFF1E5A3E),
      signalDim: Color(0xFF2E6E50),
      warn: Color(0xFF6E3F00),
      warnDim: Color(0xFF7F4E07),
      alert: Color(0xFF8F001E),
      accent: Color(0xFF8E0B56),
      accentDim: Color(0xFFC77DDB),
      onAccent: Color(0xFFFFEAF4),
      // Deep lagoon teal and grape, dark enough to read on the pink.
      secondary: Color(0xFF004E56),
      tertiary: Color(0xFF4B1FA0),
      magenta: Color(0xFF7A1F8C),
      me: Color(0xFFB5207A),
      meBorder: Color(0xFFD9A2E6),
      meInk: Color(0xFFFFF2F8),
      primaryContainer: Color(0xFFFAD3E6),
      secondaryContainer: Color(0xFFC7EDEB),
      tertiaryContainer: Color(0xFFE6C9F2),
    ),
  ),
  bronzedBlush(
    'bronzed_blush',
    'Bronzed Blush',
    'Deep bronze, pale and soft pinks, inner tone',
    BastionPalette(
      brightness: Brightness.dark,
      // Warm bronze-brown surfaces, darkest first.
      bg: Color(0xFF1C1412),
      bg1: Color(0xFF221816),
      bg2: Color(0xFF2A1D1B),
      bg3: Color(0xFF342422),
      bg4: Color(0xFF42302C),
      line: Color(0xFF342422),
      line2: Color(0xFF4A3531),
      line3: Color(0xFF6B504A),
      ink: Color(0xFFF8E9E4),
      ink2: Color(0xFFE6D0C9),
      ink3: Color(0xFFC9AEA6),
      ink4: Color(0xFFB39890),
      signal: Color(0xFF9ED3A6),
      signalDim: Color(0xFF74A47D),
      warn: Color(0xFFF2C46A),
      warnDim: Color(0xFFC29A45),
      alert: Color(0xFFFF6B6B),
      // Soft Pink
      accent: Color(0xFFF3A7AD),
      // Pale Pink
      accentDim: Color(0xFFE6A6A6),
      onAccent: Color(0xFF2A1214),
      // A lighter copper of the bronze, and a rose mauve of the inner tone,
      // so the pinks have company.
      secondary: Color(0xFFE0A27F),
      tertiary: Color(0xFFD896B0),
      // Pale Pink
      magenta: Color(0xFFE6A6A6),
      // Deep Bronze
      me: Color(0xFF8A4E3C),
      meBorder: Color(0xFFF3A7AD),
      meInk: Color(0xFFFFF1EC),
      // Inner Tone
      primaryContainer: Color(0xFF874D5A),
      // Deep Bronze
      secondaryContainer: Color(0xFF8A4E3C),
      tertiaryContainer: Color(0xFF5E3440),
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
      // Still only reds, for night vision: an ember orange-red and a coral.
      secondary: Color(0xFFFF7A45),
      tertiary: Color(0xFFE86A5E),
      magenta: Color(0xFFD9786F),
      me: Color(0xFF3A1412),
      meBorder: Color(0xFF8A2E28),
      meInk: Color(0xFFF0C2BC),
      primaryContainer: Color(0xFF4A1512),
      secondaryContainer: Color(0xFF3D1A10),
      tertiaryContainer: Color(0xFF3A1218),
    ),
  ),
  // Every status and accent color here is from the Okabe-Ito palette, so
  // good, warning and bad signal stay apart with color blindness.
  okabeIto(
    'okabe_ito',
    'Okabe-Ito',
    'Color-blind safe, on black',
    BastionPalette(
      brightness: Brightness.dark,
      // Black, the palette's eighth color, is the page.
      bg: Color(0xFF000000),
      bg1: Color(0xFF0C0F12),
      bg2: Color(0xFF12161A),
      bg3: Color(0xFF1A2026),
      bg4: Color(0xFF242B32),
      line: Color(0xFF242B32),
      line2: Color(0xFF36404A),
      line3: Color(0xFF56636F),
      ink: Color(0xFFF2F4F5),
      ink2: Color(0xFFD5DADE),
      ink3: Color(0xFFAEB6BD),
      ink4: Color(0xFF98A1A9),
      signal: OkabeIto.bluishGreen,
      signalDim: Color(0xFF00805E),
      warn: OkabeIto.yellow,
      warnDim: OkabeIto.orange,
      alert: OkabeIto.vermillion,
      accent: OkabeIto.skyBlue,
      accentDim: OkabeIto.blue,
      onAccent: OkabeIto.black,
      secondary: OkabeIto.orange,
      tertiary: OkabeIto.reddishPurple,
      magenta: OkabeIto.reddishPurple,
      me: OkabeIto.blue,
      meBorder: OkabeIto.skyBlue,
      meInk: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFF003A5C),
      secondaryContainer: Color(0xFF4A3300),
      tertiaryContainer: Color(0xFF4A2238),
    ),
  ),
  // The same Okabe-Ito colors on charcoal instead of black. Bluish green,
  // vermillion and reddish purple are lifted toward white (same hues) so
  // they still read on the lighter page.
  okabeItoSlate(
    'okabe_ito_slate',
    'Okabe-Ito Slate',
    'Color-blind safe, on charcoal',
    BastionPalette(
      brightness: Brightness.dark,
      bg: Color(0xFF23282E),
      bg1: Color(0xFF292F35),
      bg2: Color(0xFF2F353C),
      bg3: Color(0xFF384048),
      bg4: Color(0xFF434C55),
      line: Color(0xFF384048),
      line2: Color(0xFF4A535C),
      line3: Color(0xFF66717B),
      ink: Color(0xFFF2F4F5),
      ink2: Color(0xFFD5DADE),
      ink3: Color(0xFFB8C0C7),
      ink4: Color(0xFFA6AFB7),
      signal: Color(0xFF40B696),
      signalDim: OkabeIto.bluishGreen,
      warn: OkabeIto.yellow,
      warnDim: OkabeIto.orange,
      alert: Color(0xFFE08640),
      accent: OkabeIto.skyBlue,
      accentDim: OkabeIto.blue,
      onAccent: OkabeIto.black,
      secondary: OkabeIto.orange,
      tertiary: Color(0xFFD694B9),
      magenta: Color(0xFFD694B9),
      me: OkabeIto.blue,
      meBorder: OkabeIto.skyBlue,
      meInk: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFF0B4A6E),
      secondaryContainer: Color(0xFF5A4110),
      tertiaryContainer: Color(0xFF5A3049),
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
