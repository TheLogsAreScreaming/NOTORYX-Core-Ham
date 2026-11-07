import 'package:flutter/material.dart';

import 'okabe_ito.dart';

/// Every color a Bastion theme defines; the app's single set of color
/// tokens. [MeshPalette] reads the current one and `MeshTheme.forPalette`
/// turns it into the Material color scheme, so cards, navigation, buttons,
/// inputs, dialogs, chat bubbles and status colors all follow the theme.
class BastionPalette {
  final Brightness brightness;

  // Surfaces, page first: page, raised, cards, elevated, highest.
  final Color bg, bg1, bg2, bg3, bg4;
  // Lines, faint to strong.
  final Color line, line2, line3;
  // Text, strongest to faintest.
  final Color ink, ink2, ink3, ink4;
  // Signal quality (SNR) colors.
  final Color signal, signalDim;
  final Color warn, warnDim;
  // Errors, SOS and emergencies. Always a red or vermillion.
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

  /// A full palette from a theme's few defining colors.
  ///
  /// Surfaces and lines step from [bg] toward [surface]; secondary text
  /// sits between [ink] and [muted]. Each theme still picks its own status
  /// colors and containers, since those carry meaning.
  factory BastionPalette.derive({
    required Brightness brightness,
    required Color bg,
    required Color surface,
    required Color ink,
    required Color muted,
    required Color accent,
    required Color onAccent,
    required Color secondary,
    required Color tertiary,
    required Color signal,
    required Color warn,
    required Color alert,
    required Color me,
    required Color meInk,
    required Color primaryContainer,
    required Color secondaryContainer,
    required Color tertiaryContainer,
    Color? accentDim,
    Color? magenta,
    Color? meBorder,
    Color? faint,
  }) {
    Color mix(Color a, Color b, double t) => Color.lerp(a, b, t)!;
    return BastionPalette(
      brightness: brightness,
      bg: bg,
      bg1: mix(bg, surface, 0.25),
      bg2: mix(bg, surface, 0.5),
      bg3: surface,
      bg4: mix(surface, ink, 0.08),
      line: mix(bg, surface, 0.9),
      line2: mix(surface, ink, 0.16),
      line3: mix(surface, ink, 0.32),
      ink: ink,
      ink2: mix(ink, muted, 0.45),
      ink3: muted,
      ink4: faint ?? mix(muted, bg, 0.12),
      signal: signal,
      signalDim: mix(signal, bg, 0.3),
      warn: warn,
      warnDim: mix(warn, bg, 0.3),
      alert: alert,
      accent: accent,
      accentDim: accentDim ?? mix(accent, bg, 0.3),
      onAccent: onAccent,
      secondary: secondary,
      tertiary: tertiary,
      magenta: magenta ?? tertiary,
      me: me,
      meBorder: meBorder ?? accent,
      meInk: meInk,
      primaryContainer: primaryContainer,
      secondaryContainer: secondaryContainer,
      tertiaryContainer: tertiaryContainer,
    );
  }

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

/// The eight themes offered in Settings, in display order.
enum BastionTheme {
  blaze('blaze', 'Blaze'),
  neonAnarchy('neon_anarchy', 'Neon Anarchy'),
  tactical('tactical', 'Tactical'),
  pinkOverload('pink_overload', 'Pink Overload'),
  bareBeauty('bare_beauty', 'Bare Beauty'),
  okabeIto('okabe_ito', 'Okabe-Ito'),
  nightOps('night_ops', 'Night Ops'),
  seasonal('seasonal', 'Seasonal');

  const BastionTheme(this.id, this.label);

  /// The stored settings value.
  final String id;

  /// The theme's name, the same in every language.
  final String label;

  static const fallback = BastionTheme.blaze;

  /// This theme's palette. For [seasonal] it is the autumn palette; use
  /// [resolveThemePalette] to get the one for today's date.
  BastionPalette get palette => switch (this) {
    blaze => _blaze,
    neonAnarchy => _neonAnarchy,
    tactical => _tactical,
    pinkOverload => _pinkOverload,
    bareBeauty => _bareBeauty,
    okabeIto => _okabeIto,
    nightOps => _nightOps,
    seasonal => Season.autumn.palette,
  };

  /// Saved ids from earlier versions and the theme each now opens as.
  static const Map<String, BastionTheme> legacyIds = {
    'autumn_frost': seasonal,
    'christmas': seasonal,
    'bubble_gum': pinkOverload,
    'topo_night': pinkOverload,
    'bronzed_blush': bareBeauty,
    'red_light': nightOps,
    'okabe_ito_slate': okabeIto,
    'alpine_day': blaze,
    'halloween': blaze,
  };

  static BastionTheme fromId(String? id) {
    final legacy = legacyIds[id];
    if (legacy != null) return legacy;
    for (final t in values) {
      if (t.id == id) return t;
    }
    return fallback;
  }
}

/// The palettes inside the [BastionTheme.seasonal] theme.
enum Season {
  spring('spring'),
  summer('summer'),
  autumn('autumn'),
  winter('winter'),
  halloween('halloween'),
  christmas('christmas'),
  valentine('valentine');

  const Season(this.id);

  /// The stored settings value.
  final String id;

  /// Whether this is a holiday rather than one of the four seasons.
  bool get isHoliday => index >= Season.halloween.index;

  BastionPalette get palette => switch (this) {
    spring => _spring,
    summer => _summer,
    autumn => _autumn,
    winter => _winter,
    halloween => _halloween,
    christmas => _christmas,
    valentine => _valentine,
  };

  static Season? fromId(String? id) {
    for (final s in values) {
      if (s.id == id) return s;
    }
    return null;
  }
}

/// The season or holiday for [date], by the device's local calendar.
///
/// Seasons follow the northern-hemisphere months (spring is March to May);
/// people elsewhere can pick their season by hand. Holidays apply only when
/// [holidays] is on: Valentine's Day Feb 7–14, Halloween Oct 24–31 and
/// Christmas Dec 10–26.
Season seasonFor(DateTime date, {bool holidays = true}) {
  final m = date.month, d = date.day;
  if (holidays) {
    if (m == 2 && d >= 7 && d <= 14) return Season.valentine;
    if (m == 10 && d >= 24) return Season.halloween;
    if (m == 12 && d >= 10 && d <= 26) return Season.christmas;
  }
  if (m >= 3 && m <= 5) return Season.spring;
  if (m >= 6 && m <= 8) return Season.summer;
  if (m >= 9 && m <= 11) return Season.autumn;
  return Season.winter;
}

/// The season the Seasonal theme shows: [override] when it names one,
/// otherwise the one for [now].
Season activeSeason({
  String override = 'auto',
  bool holidays = true,
  DateTime? now,
}) =>
    Season.fromId(override) ??
    seasonFor(now ?? DateTime.now(), holidays: holidays);

/// The palette for the saved theme [themeId]. Only the Seasonal theme looks
/// at the date or the season override; every other theme ignores them.
BastionPalette resolveThemePalette(
  String? themeId, {
  String seasonalOverride = 'auto',
  bool seasonalHolidays = true,
  DateTime? now,
}) {
  final theme = BastionTheme.fromId(themeId);
  if (theme != BastionTheme.seasonal) return theme.palette;
  return activeSeason(
    override: seasonalOverride,
    holidays: seasonalHolidays,
    now: now,
  ).palette;
}

const _dark = Brightness.dark;
const _light = Brightness.light;

// 1. Blaze: charcoal and slate with high-visibility orange. The default.
final _blaze = BastionPalette.derive(
  brightness: _dark,
  bg: const Color(0xFF111820),
  surface: const Color(0xFF273443),
  ink: const Color(0xFFF4F6F8),
  muted: const Color(0xFFAAB5C3),
  accent: const Color(0xFFFF8A00),
  onAccent: const Color(0xFF2A1300),
  secondary: const Color(0xFFF07A12),
  tertiary: const Color(0xFF22D3E6),
  magenta: const Color(0xFFA985FF),
  signal: const Color(0xFF5FD98A),
  warn: const Color(0xFFFFC83D),
  alert: const Color(0xFFFF5A4E),
  me: const Color(0xFF3D2A18),
  meInk: const Color(0xFFF4F6F8),
  primaryContainer: const Color(0xFF4A2E10),
  secondaryContainer: const Color(0xFF4A2A0C),
  tertiaryContainer: const Color(0xFF12393F),
);

// 2. Neon Anarchy: toxic green and electric purple on near-black.
final _neonAnarchy = BastionPalette.derive(
  brightness: _dark,
  bg: const Color(0xFF08060D),
  surface: const Color(0xFF21112F),
  ink: const Color(0xFFF1E9FF),
  muted: const Color(0xFFBBA8D8),
  accent: const Color(0xFFADFF2F),
  onAccent: const Color(0xFF0B1400),
  // Electric purple, lifted so it reads as text on black.
  secondary: const Color(0xFFC766FF),
  tertiary: const Color(0xFFFF4FD8),
  magenta: const Color(0xFFB026FF),
  signal: const Color(0xFF5CFF9A),
  warn: const Color(0xFFFFD23F),
  alert: const Color(0xFFFF4D6D),
  me: const Color(0xFF3B1466),
  meInk: const Color(0xFFF1E9FF),
  meBorder: const Color(0xFFB026FF),
  primaryContainer: const Color(0xFF2A3D0A),
  secondaryContainer: const Color(0xFF7022C4),
  tertiaryContainer: const Color(0xFF4A1660),
);

// 3. Tactical: olive, gunmetal, forest and earth.
final _tactical = BastionPalette.derive(
  brightness: _dark,
  bg: const Color(0xFF171C19),
  surface: const Color(0xFF303B32),
  ink: const Color(0xFFE4E9DC),
  muted: const Color(0xFFB4BEAA),
  accent: const Color(0xFFA8BA79),
  onAccent: const Color(0xFF141A0E),
  secondary: const Color(0xFF8FB584),
  tertiary: const Color(0xFFC9AE73),
  signal: const Color(0xFF8FD18A),
  warn: const Color(0xFFE6C55A),
  alert: const Color(0xFFF06A55),
  me: const Color(0xFF3E4A2A),
  meInk: const Color(0xFFE4E9DC),
  primaryContainer: const Color(0xFF3E4A2A),
  secondaryContainer: const Color(0xFF3F4F38),
  tertiaryContainer: const Color(0xFF4F4128),
);

// 4. Pink Overload: hot pink, bubblegum and lavender, unapologetically.
final _pinkOverload = BastionPalette.derive(
  brightness: _light,
  bg: const Color(0xFFFFF0FA),
  surface: const Color(0xFFFFC1E3),
  ink: const Color(0xFF542044),
  muted: const Color(0xFF7A2B62),
  // Hot pink, deep enough for white button text and pink-page links.
  accent: const Color(0xFFBD0065),
  onAccent: const Color(0xFFFFFFFF),
  secondary: const Color(0xFFA3127F),
  tertiary: const Color(0xFF7A2FC9),
  magenta: const Color(0xFFFF1493),
  signal: const Color(0xFF1E6B3F),
  warn: const Color(0xFF7A4A00),
  alert: const Color(0xFFB00020),
  me: const Color(0xFFC2127F),
  meInk: const Color(0xFFFFFFFF),
  meBorder: const Color(0xFFFF69B4),
  primaryContainer: const Color(0xFFFFC1E3),
  secondaryContainer: const Color(0xFFFFD6EC),
  tertiaryContainer: const Color(0xFFEBD3FF),
  faint: const Color(0xFF7A2B62),
);

// 5. Bare Beauty: warm nude, dusty rose, cocoa and hazel-sage.
final _bareBeauty = BastionPalette.derive(
  brightness: _light,
  bg: const Color(0xFFFFF0E7),
  surface: const Color(0xFFE8B69E),
  ink: const Color(0xFF38232B),
  muted: const Color(0xFF5E3D3F),
  // Dusty rose, deepened for white text.
  accent: const Color(0xFF84464F),
  onAccent: const Color(0xFFFFFFFF),
  // Cocoa and a hazel-sage.
  secondary: const Color(0xFF754B43),
  tertiary: const Color(0xFF44625A),
  magenta: const Color(0xFFC77D87),
  signal: const Color(0xFF2F6B45),
  warn: const Color(0xFF7A4E00),
  alert: const Color(0xFFA3122A),
  me: const Color(0xFF8E4F58),
  meInk: const Color(0xFFFFFFFF),
  meBorder: const Color(0xFFC77D87),
  primaryContainer: const Color(0xFFE8B69E),
  secondaryContainer: const Color(0xFFF0C9C4),
  tertiaryContainer: const Color(0xFFCFDDD5),
  faint: const Color(0xFF5E3D3F),
);

// 6. Okabe-Ito: every accent and status color from the color-blind safe
// palette, on charcoal. Vermillion is lifted slightly so SOS reads on cards.
final _okabeIto = BastionPalette.derive(
  brightness: _dark,
  bg: const Color(0xFF161A20),
  surface: const Color(0xFF343C48),
  ink: const Color(0xFFFFFFFF),
  muted: const Color(0xFFC3CBD5),
  accent: OkabeIto.skyBlue,
  accentDim: OkabeIto.blue,
  onAccent: OkabeIto.black,
  secondary: OkabeIto.orange,
  tertiary: const Color(0xFF33B08A),
  magenta: const Color(0xFFD694B9),
  // Bluish green, lifted like vermillion so it reads on cards.
  signal: const Color(0xFF33B08A),
  warn: OkabeIto.yellow,
  alert: const Color(0xFFF07A3A),
  me: OkabeIto.blue,
  meInk: const Color(0xFFFFFFFF),
  meBorder: OkabeIto.skyBlue,
  primaryContainer: OkabeIto.blue,
  secondaryContainer: const Color(0xFF5A4110),
  tertiaryContainer: const Color(0xFF0B4F3E),
);

// 7. Night Ops: near-black with restrained reds for low light.
final _nightOps = BastionPalette.derive(
  brightness: _dark,
  bg: const Color(0xFF080808),
  surface: const Color(0xFF251010),
  ink: const Color(0xFFF3D6D3),
  muted: const Color(0xFFC9A09B),
  accent: const Color(0xFFE0574D),
  accentDim: const Color(0xFFC23A32),
  onAccent: const Color(0xFF1A0503),
  secondary: const Color(0xFFE07A6E),
  tertiary: const Color(0xFFF3A29A),
  signal: const Color(0xFFE08A7E),
  warn: const Color(0xFFFF8A5C),
  alert: const Color(0xFFFF3B30),
  me: const Color(0xFF3A1412),
  meInk: const Color(0xFFF3D6D3),
  meBorder: const Color(0xFF852722),
  primaryContainer: const Color(0xFF5A1A16),
  secondaryContainer: const Color(0xFF852722),
  tertiaryContainer: const Color(0xFF3A1218),
);

// 8. Seasonal.
final _spring = BastionPalette.derive(
  brightness: _light,
  bg: const Color(0xFFFAFBEA),
  surface: const Color(0xFFDDE8CF),
  ink: const Color(0xFF26331F),
  muted: const Color(0xFF465640),
  accent: const Color(0xFF4A7040),
  onAccent: const Color(0xFFFFFFFF),
  secondary: const Color(0xFF6A4BA3),
  tertiary: const Color(0xFFB0306A),
  magenta: const Color(0xFFE59BC0),
  signal: const Color(0xFF2E6B3A),
  warn: const Color(0xFF7A5200),
  alert: const Color(0xFFB0201E),
  me: const Color(0xFF4A7040),
  meInk: const Color(0xFFFFFFFF),
  meBorder: const Color(0xFFB9A3E3),
  primaryContainer: const Color(0xFFDDE8CF),
  secondaryContainer: const Color(0xFFE6DDF5),
  tertiaryContainer: const Color(0xFFF9D9E6),
  faint: const Color(0xFF465640),
);

final _summer = BastionPalette.derive(
  brightness: _light,
  bg: const Color(0xFFFFF7EA),
  surface: const Color(0xFFF2DFC2),
  ink: const Color(0xFF1F2A2E),
  muted: const Color(0xFF475155),
  accent: const Color(0xFF006D77),
  onAccent: const Color(0xFFFFFFFF),
  secondary: const Color(0xFFB8402A),
  tertiary: const Color(0xFF00708A),
  magenta: const Color(0xFFFF7F6B),
  signal: const Color(0xFF1F6B3A),
  warn: const Color(0xFF7A4E00),
  alert: const Color(0xFFB0201E),
  me: const Color(0xFF006D77),
  meInk: const Color(0xFFFFFFFF),
  meBorder: const Color(0xFF40C9C6),
  primaryContainer: const Color(0xFFCDEDEB),
  secondaryContainer: const Color(0xFFFFD9CF),
  tertiaryContainer: const Color(0xFFCCEAF2),
  faint: const Color(0xFF475155),
);

final _autumn = BastionPalette.derive(
  brightness: _dark,
  bg: const Color(0xFF1C1712),
  surface: const Color(0xFF3A2E22),
  ink: const Color(0xFFF4EADB),
  muted: const Color(0xFFC9B9A2),
  accent: const Color(0xFFF08A3C),
  onAccent: const Color(0xFF24140A),
  secondary: const Color(0xFFF2B544),
  tertiary: const Color(0xFF7DBA84),
  magenta: const Color(0xFFD9826B),
  signal: const Color(0xFF7FD69A),
  warn: const Color(0xFFF2C14A),
  alert: const Color(0xFFFF6A55),
  me: const Color(0xFF6E3A1A),
  meInk: const Color(0xFFFBF1E4),
  primaryContainer: const Color(0xFF5A3218),
  secondaryContainer: const Color(0xFF5A4512),
  tertiaryContainer: const Color(0xFF23432A),
);

final _winter = BastionPalette.derive(
  brightness: _dark,
  bg: const Color(0xFF0F1A2B),
  surface: const Color(0xFF263A55),
  ink: const Color(0xFFF3F8FC),
  muted: const Color(0xFFB4C4D6),
  accent: const Color(0xFF8FD3FF),
  onAccent: const Color(0xFF07182A),
  secondary: const Color(0xFFC9D3DE),
  tertiary: const Color(0xFFA9B8FF),
  signal: const Color(0xFF7FD6B0),
  warn: const Color(0xFFFFD36B),
  alert: const Color(0xFFFF6B6B),
  me: const Color(0xFF1E4A6E),
  meInk: const Color(0xFFF3F8FC),
  primaryContainer: const Color(0xFF1E4A6E),
  secondaryContainer: const Color(0xFF3A4656),
  tertiaryContainer: const Color(0xFF2E3770),
);

final _halloween = BastionPalette.derive(
  brightness: _dark,
  bg: const Color(0xFF0C0A0F),
  surface: const Color(0xFF2A1F33),
  ink: const Color(0xFFF2E9F7),
  muted: const Color(0xFFBFAFCB),
  accent: const Color(0xFFFF8C1A),
  onAccent: const Color(0xFF241000),
  secondary: const Color(0xFFB57BFF),
  tertiary: const Color(0xFF9FE870),
  signal: const Color(0xFF7FD69A),
  warn: const Color(0xFFFFD23F),
  alert: const Color(0xFFFF5A5A),
  me: const Color(0xFF5A3008),
  meInk: const Color(0xFFF2E9F7),
  primaryContainer: const Color(0xFF5A3008),
  secondaryContainer: const Color(0xFF3E2160),
  tertiaryContainer: const Color(0xFF2A4A1A),
);

final _christmas = BastionPalette.derive(
  brightness: _dark,
  bg: const Color(0xFF0E1A14),
  surface: const Color(0xFF23402F),
  ink: const Color(0xFFF5F1E6),
  muted: const Color(0xFFC2C9B8),
  accent: const Color(0xFFF66478),
  onAccent: const Color(0xFF240008),
  secondary: const Color(0xFFE8C15A),
  tertiary: const Color(0xFF5FC48A),
  signal: const Color(0xFF7FD69A),
  warn: const Color(0xFFFFD36B),
  alert: const Color(0xFFFF5A4E),
  me: const Color(0xFF7A1C2A),
  meInk: const Color(0xFFF5F1E6),
  primaryContainer: const Color(0xFF5A1420),
  secondaryContainer: const Color(0xFF4F4012),
  tertiaryContainer: const Color(0xFF1D4A30),
);

final _valentine = BastionPalette.derive(
  brightness: _light,
  bg: const Color(0xFFFFF1F3),
  surface: const Color(0xFFF7C9D2),
  ink: const Color(0xFF3D0F1C),
  muted: const Color(0xFF6B2A3B),
  accent: const Color(0xFFC2185B),
  onAccent: const Color(0xFFFFFFFF),
  secondary: const Color(0xFF7A1033),
  tertiary: const Color(0xFF9C3D6E),
  magenta: const Color(0xFFF48FB1),
  signal: const Color(0xFF1E6B3F),
  warn: const Color(0xFF7A4A00),
  alert: const Color(0xFFB00020),
  me: const Color(0xFFC2185B),
  meInk: const Color(0xFFFFFFFF),
  meBorder: const Color(0xFFF48FB1),
  primaryContainer: const Color(0xFFF7C9D2),
  secondaryContainer: const Color(0xFFF1D0D8),
  tertiaryContainer: const Color(0xFFEFD3E4),
  faint: const Color(0xFF6B2A3B),
);
