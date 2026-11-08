import 'package:flutter/material.dart';

import 'seasonal_theme.dart';

/// The decoration a theme's backdrop draws behind the page. All of them are
/// static: nothing moves, so reduced motion has nothing to turn off.
enum BackdropMotif {
  /// Faint topographic contour lines.
  contours,

  /// Contours plus a faint terminal grid (Neon Anarchy).
  grid,

  /// Contours plus a scatter of small four-point sparkles (Pink Overload).
  sparkle,
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

/// The eight themes offered in Settings, in the order they are shown.
enum BastionTheme {
  // The signature theme and the default for new installs.
  blaze(
    'blaze',
    'Blaze',
    'Charcoal slate with hi-vis orange. The default.',
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
  // Hacker-terminal neon: green for actions, purple for navigation, a faint
  // grid behind everything.
  neonAnarchy(
    'neon_anarchy',
    'Neon Anarchy',
    'Toxic green and electric purple on black',
    BastionPalette(
      brightness: Brightness.dark,
      bg: Color(0xFF08060D),
      bg1: Color(0xFF100A18),
      bg2: Color(0xFF170E23),
      bg3: Color(0xFF21112F),
      bg4: Color(0xFF2E1842),
      line: Color(0xFF2A1840),
      line2: Color(0xFF3F2460),
      line3: Color(0xFF8A5CC4),
      ink: Color(0xFFF1E9FF),
      ink2: Color(0xFFDCCDF5),
      ink3: Color(0xFFC2AEE6),
      ink4: Color(0xFFB39CDB),
      signal: Color(0xFFADFF2F),
      signalDim: Color(0xFF7DBF1F),
      warn: Color(0xFFFFD23F),
      warnDim: Color(0xFFC9A22E),
      alert: Color(0xFFFF4D6D),
      accent: Color(0xFFADFF2F),
      accentDim: Color(0xFF7DBF1F),
      onAccent: Color(0xFF0B1400),
      magenta: Color(0xFFC35BFF),
      me: Color(0xFF22123A),
      meBorder: Color(0xFFB026FF),
      meInk: Color(0xFFF1E9FF),
      primaryContainer: Color(0xFF243A06),
      secondaryContainer: Color(0xFF3A1660),
      nav: Color(0xFFC35BFF),
      motif: BackdropMotif.grid,
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
  // Loud and glossy on purpose: hot-pink actions, lavender highlights and a
  // light sparkle behind the page.
  pinkOverload(
    'pink_overload',
    'Pink Overload',
    'Hot pink, bubblegum and lavender',
    BastionPalette(
      brightness: Brightness.light,
      bg: Color(0xFFFFF0FA),
      bg1: Color(0xFFFFE3F3),
      bg2: Color(0xFFFFD3EC),
      bg3: Color(0xFFFFC1E3),
      bg4: Color(0xFFF7A8D4),
      line: Color(0xFFF5B3D9),
      line2: Color(0xFFE58BC0),
      line3: Color(0xFFB8447F),
      ink: Color(0xFF542044),
      ink2: Color(0xFF5E2550),
      ink3: Color(0xFF6B2A5A),
      ink4: Color(0xFF70295E),
      signal: Color(0xFF0E6742),
      signalDim: Color(0xFF2E7D5A),
      warn: Color(0xFF7A4100),
      warnDim: Color(0xFF8F5410),
      alert: Color(0xFFB0002A),
      accent: Color(0xFFB00062),
      accentDim: Color(0xFFFF1493),
      onAccent: Color(0xFFFFFFFF),
      magenta: Color(0xFF7B2CBF),
      me: Color(0xFFE6007C),
      meBorder: Color(0xFFC77DFF),
      meInk: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFFFC1E3),
      secondaryContainer: Color(0xFFEBD3FF),
      nav: Color(0xFFC4006E),
      motif: BackdropMotif.sparkle,
    ),
  ),
  // Warm natural tones across a range of skin, lip and eye colours: nude and
  // peach pages, dusty-rose actions, cocoa lines and sage-hazel highlights.
  bareBeauty(
    'bare_beauty',
    'Bare Beauty',
    'Warm nude, dusty rose, cocoa and sage',
    BastionPalette(
      brightness: Brightness.light,
      bg: Color(0xFFFFF0E7),
      bg1: Color(0xFFFBE5D8),
      bg2: Color(0xFFF4D3C2),
      bg3: Color(0xFFE8B69E),
      bg4: Color(0xFFD9A088),
      line: Color(0xFFEBC9B6),
      line2: Color(0xFFD4A48C),
      line3: Color(0xFF8E5E52),
      ink: Color(0xFF38232B),
      ink2: Color(0xFF45303A),
      ink3: Color(0xFF553B40),
      ink4: Color(0xFF5A3F3F),
      signal: Color(0xFF305541),
      signalDim: Color(0xFF4F7A66),
      warn: Color(0xFF70440C),
      warnDim: Color(0xFF8E5E20),
      alert: Color(0xFF961D2C),
      accent: Color(0xFF753C47),
      accentDim: Color(0xFFA96870),
      onAccent: Color(0xFFFFF6F1),
      magenta: Color(0xFF586C63),
      me: Color(0xFFA35F67),
      meBorder: Color(0xFF754B43),
      meInk: Color(0xFFFFF8F4),
      primaryContainer: Color(0xFFF2C9C8),
      secondaryContainer: Color(0xFFD8E3DC),
      nav: Color(0xFF8A4A55),
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
  ),
  // Its colours come from [SeasonalTheme] when read through [palette]; the
  // palette stored here is only the autumn fallback.
  seasonal(
    'seasonal',
    'Seasonal',
    'Follows the season, or pick one',
    BastionPalette(
      brightness: Brightness.dark,
      bg: Color(0xFF1A120C),
      bg1: Color(0xFF211710),
      bg2: Color(0xFF2A1E15),
      bg3: Color(0xFF36271B),
      bg4: Color(0xFF453223),
      line: Color(0xFF3A2A1D),
      line2: Color(0xFF553D2A),
      line3: Color(0xFF8E6A4A),
      ink: Color(0xFFF5E8DA),
      ink2: Color(0xFFE5D2BE),
      ink3: Color(0xFFD2BBA2),
      ink4: Color(0xFFC6AD92),
      signal: Color(0xFF8FC28A),
      signalDim: Color(0xFF6E9A6A),
      warn: Color(0xFFF2B33D),
      warnDim: Color(0xFFC08C2C),
      alert: Color(0xFFFF6A55),
      accent: Color(0xFFF08A3C),
      accentDim: Color(0xFFC2410C),
      onAccent: Color(0xFF1F0E00),
      magenta: Color(0xFFE0B04A),
      me: Color(0xFF3A2614),
      meBorder: Color(0xFFC2410C),
      meInk: Color(0xFFF5E8DA),
      primaryContainer: Color(0xFF4F2A0E),
      secondaryContainer: Color(0xFF2E3A1E),
      nav: Color(0xFFF08A3C),
    ),
  );

  const BastionTheme(this.id, this.label, this.description, this._palette);
  final String id;
  final String label;
  final String description;
  final BastionPalette _palette;

  /// This theme's colours. Seasonal resolves to the palette for today's
  /// date (or the season the operator picked) each time it is read.
  BastionPalette get palette =>
      this == seasonal ? SeasonalTheme.palette() : _palette;

  static const fallback = BastionTheme.blaze;

  /// Ids saved by earlier versions, mapped to the theme that replaced them,
  /// so nobody's choice is reset to the default by an update.
  static const _renamed = {
    'bubble_gum': pinkOverload,
    'topo_night': pinkOverload,
    'bronzed_blush': bareBeauty,
    'red_light': nightOps,
    'okabe_ito_slate': okabeIto,
    'autumn_frost': seasonal,
    'christmas': seasonal,
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
