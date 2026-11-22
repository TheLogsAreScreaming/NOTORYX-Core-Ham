import 'package:flutter/material.dart';

/// The decoration a theme's backdrop draws behind the page. All of them are
/// static: nothing moves, so reduced motion has nothing to turn off.
enum BackdropMotif {
  /// Faint topographic contour lines.
  contours,
}

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
  // The selected tab in the bottom bar.
  final Color nav;
  // What the backdrop draws behind the page.
  final BackdropMotif motif;

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
    required this.nav,
    this.motif = BackdropMotif.contours,
  });

  /// A second hue for things that sit beside the accent: the bottom bar's
  /// selection colour.
  Color get secondary => nav;

  /// A third hue, after [accent] and [secondary].
  Color get tertiary => signal;

  /// The theme's hues in order, for giving neighbouring icons or groups
  /// their own colour. Pick by index with [hue].
  List<Color> get spectrum => [accent, nav, signal, magenta];

  /// The [spectrum] colour for item [index], repeating.
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

/// The five themes offered in Settings, in the order they are shown.
enum BastionTheme {
  // The BLACKOUT brand look and the default for new installs: matte black,
  // charcoal cards, gunmetal lines, steel and frost text. Monochrome, with
  // no brand accent; signal, warning and alert keep their colours because
  // they carry meaning. Steel (#888888) is lifted to #9A9A9A for the
  // faintest text so it reaches 4.5:1 on charcoal.
  blackout(
    'blackout',
    'BLACKOUT',
    'Matte black and steel. The default.',
    BastionPalette(
      brightness: Brightness.dark,
      bg: Color(0xFF080808),
      bg1: Color(0xFF121212),
      bg2: Color(0xFF1A1A1A),
      bg3: Color(0xFF242424),
      bg4: Color(0xFF2E2E2E),
      line: Color(0xFF2A2A2A),
      line2: Color(0xFF484848),
      line3: Color(0xFF7A7A7A),
      ink: Color(0xFFE8E8E8),
      ink2: Color(0xFFCDCDCD),
      ink3: Color(0xFFB0B0B0),
      ink4: Color(0xFF9A9A9A),
      signal: Color(0xFF8FD19E),
      signalDim: Color(0xFF6FA37B),
      warn: Color(0xFFF5C85A),
      warnDim: Color(0xFFC9A043),
      alert: Color(0xFFFF6B5E),
      accent: Color(0xFFE8E8E8),
      accentDim: Color(0xFFB0B0B0),
      onAccent: Color(0xFF080808),
      magenta: Color(0xFFBDBDBD),
      me: Color(0xFF2A2A2A),
      meBorder: Color(0xFF6A6A6A),
      meInk: Color(0xFFE8E8E8),
      primaryContainer: Color(0xFF2E2E2E),
      secondaryContainer: Color(0xFF242424),
      nav: Color(0xFFE8E8E8),
    ),
  ),
  // The orange signature theme, the default before BLACKOUT.
  blaze(
    'blaze',
    'Blaze',
    'Charcoal slate with hi-vis orange',
    BastionPalette(
      brightness: Brightness.dark,
      bg: Color(0xFF111820),
      bg1: Color(0xFF17202A),
      bg2: Color(0xFF1E2935),
      bg3: Color(0xFF273443),
      bg4: Color(0xFF324154),
      line: Color(0xFF2C3A4A),
      line2: Color(0xFF3D4E61),
      line3: Color(0xFF6E8096),
      ink: Color(0xFFF4F6F8),
      ink2: Color(0xFFD6DCE3),
      ink3: Color(0xFFB9C2CD),
      ink4: Color(0xFFAAB5C3),
      signal: Color(0xFF8FD19E),
      signalDim: Color(0xFF6FA37B),
      warn: Color(0xFFF5C85A),
      warnDim: Color(0xFFC9A043),
      alert: Color(0xFFFF6B5E),
      accent: Color(0xFFFF8A00),
      accentDim: Color(0xFFE76F00),
      onAccent: Color(0xFF1A0E00),
      magenta: Color(0xFFFFB15C),
      me: Color(0xFF3B2A17),
      meBorder: Color(0xFFE76F00),
      meInk: Color(0xFFF4F6F8),
      primaryContainer: Color(0xFF4A2C0A),
      secondaryContainer: Color(0xFF3F3420),
      nav: Color(0xFFFF8A00),
    ),
  ),
  // Utilitarian olive and earth tones.
  tactical(
    'tactical',
    'Tactical',
    'Olive, gunmetal and earth tones for the field',
    BastionPalette(
      brightness: Brightness.dark,
      bg: Color(0xFF171C19),
      bg1: Color(0xFF1C231F),
      bg2: Color(0xFF242C27),
      bg3: Color(0xFF303B32),
      bg4: Color(0xFF3C4A3F),
      line: Color(0xFF334036),
      line2: Color(0xFF46564A),
      line3: Color(0xFF7C8C74),
      ink: Color(0xFFE4E9DC),
      ink2: Color(0xFFCDD4C3),
      ink3: Color(0xFFB7BFAB),
      ink4: Color(0xFFA9B29C),
      signal: Color(0xFFA8BA79),
      signalDim: Color(0xFF809060),
      warn: Color(0xFFD9B86A),
      warnDim: Color(0xFFA88E52),
      alert: Color(0xFFED8773),
      accent: Color(0xFFA8BA79),
      accentDim: Color(0xFF64785A),
      onAccent: Color(0xFF141A0C),
      magenta: Color(0xFFC2A66B),
      me: Color(0xFF2E3A2A),
      meBorder: Color(0xFF64785A),
      meInk: Color(0xFFE4E9DC),
      primaryContainer: Color(0xFF3A4728),
      secondaryContainer: Color(0xFF4A3F27),
      nav: Color(0xFFA8BA79),
    ),
  ),
  // Hues from the Okabe-Ito palette, lightened where needed so text still
  // reaches 4.5:1. Red (error) and amber (warning) stay far apart in hue.
  okabeIto(
    'okabe_ito',
    'Okabe-Ito',
    'Colour-vision friendly, on blue-grey',
    BastionPalette(
      brightness: Brightness.dark,
      bg: Color(0xFF161A20),
      bg1: Color(0xFF1C2129),
      bg2: Color(0xFF252B35),
      bg3: Color(0xFF343C48),
      bg4: Color(0xFF414A58),
      line: Color(0xFF303844),
      line2: Color(0xFF454F5D),
      line3: Color(0xFF7D8898),
      ink: Color(0xFFFFFFFF),
      ink2: Color(0xFFE2E6EB),
      ink3: Color(0xFFC9CFD7),
      ink4: Color(0xFFBCC3CC),
      signal: Color(0xFF00BC8B),
      signalDim: Color(0xFF00805E),
      warn: Color(0xFFE69F00),
      warnDim: Color(0xFFB07A00),
      alert: Color(0xFFFF8070),
      accent: Color(0xFF56B4E9),
      accentDim: Color(0xFF0072B2),
      onAccent: Color(0xFF000000),
      magenta: Color(0xFFCC79A7),
      me: Color(0xFF0072B2),
      meBorder: Color(0xFF56B4E9),
      meInk: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFF003A5C),
      secondaryContainer: Color(0xFF4A3300),
      nav: Color(0xFF56B4E9),
    ),
  ),
  // Near-black with restrained red, for low light. It reduces glare; it can't
  // promise to keep night vision, which also depends on screen brightness.
  nightOps(
    'night_ops',
    'Night Ops',
    'Dim red for working in the dark',
    BastionPalette(
      brightness: Brightness.dark,
      bg: Color(0xFF080808),
      bg1: Color(0xFF0F0A0A),
      bg2: Color(0xFF180C0C),
      bg3: Color(0xFF251010),
      bg4: Color(0xFF331614),
      line: Color(0xFF2E1513),
      line2: Color(0xFF451E1B),
      line3: Color(0xFF9A4237),
      ink: Color(0xFFF3D6D3),
      ink2: Color(0xFFE3BDB9),
      ink3: Color(0xFFD2A39E),
      ink4: Color(0xFFC9958F),
      signal: Color(0xFFE89A90),
      signalDim: Color(0xFFB87068),
      warn: Color(0xFFF0A070),
      warnDim: Color(0xFFC07A52),
      alert: Color(0xFFFF5A4A),
      accent: Color(0xFFE0574D),
      accentDim: Color(0xFF852722),
      onAccent: Color(0xFF140303),
      magenta: Color(0xFFF3A29A),
      me: Color(0xFF3A1412),
      meBorder: Color(0xFF852722),
      meInk: Color(0xFFF3D6D3),
      primaryContainer: Color(0xFF4A1512),
      secondaryContainer: Color(0xFF3D1A10),
      nav: Color(0xFFE0574D),
    ),
  );

  const BastionTheme(this.id, this.label, this.description, this._palette);
  final String id;
  final String label;
  final String description;
  final BastionPalette _palette;

  /// This theme's colours.
  BastionPalette get palette => _palette;

  static const fallback = BastionTheme.blackout;

  /// Ids saved by earlier versions, mapped to the theme that replaced them,
  /// so nobody's choice is reset to the default by an update.
  static const _renamed = {
    // Themes removed when BLACKOUT became the default.
    'neon_anarchy': blackout,
    'pink_overload': blackout,
    'bare_beauty': blackout,
    'seasonal': blackout,
    // Older ids whose replacement was later removed.
    'bubble_gum': blackout,
    'topo_night': blackout,
    'bronzed_blush': blackout,
    'autumn_frost': blackout,
    'christmas': blackout,
    // Older ids whose replacement is still offered.
    'red_light': nightOps,
    'okabe_ito_slate': okabeIto,
    'alpine_day': blaze,
  };

  static BastionTheme fromId(String? id) {
    final renamed = _renamed[id];
    if (renamed != null) return renamed;
    for (final t in values) {
      if (t.id == id) return t;
    }
    return fallback;
  }
}
