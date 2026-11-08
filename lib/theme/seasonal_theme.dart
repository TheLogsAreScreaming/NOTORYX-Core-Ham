import 'package:flutter/material.dart';

import 'bastion_themes.dart';

/// The looks the Seasonal theme moves through.
enum Season {
  spring,
  summer,
  autumn,
  winter,

  /// The holiday looks, used only when holiday colours are switched on.
  halloween,
  christmas,
  valentine;

  bool get isHoliday => index >= halloween.index;

  /// Its saved id, as stored in settings.
  String get id => name;

  static Season? fromId(String? id) {
    for (final s in values) {
      if (s.name == id) return s;
    }
    return null;
  }
}

/// The Seasonal theme's state: which season it shows and why.
///
/// The app sets [choice] and [holidays] from settings before it reads
/// [BastionTheme.seasonal]'s palette. Only that theme reads any of this, so
/// people on any other theme never see it change.
abstract final class SeasonalTheme {
  /// A season the operator picked, or null to follow the date.
  static Season? choice;

  /// Whether Automatic also shows Halloween, Christmas and Valentine's Day.
  static bool holidays = false;

  /// Today's date; replaced in tests.
  static DateTime Function() now = DateTime.now;

  /// The season Seasonal shows today.
  static Season current() => choice ?? seasonFor(now(), holidays: holidays);

  static BastionPalette palette() => paletteFor(current());

  /// The season for a local [date]: meteorological seasons for the northern
  /// hemisphere (spring is March to May), and, with [holidays], a short
  /// window before each holiday.
  static Season seasonFor(DateTime date, {bool holidays = false}) {
    final m = date.month, d = date.day;
    if (holidays) {
      if (m == 10 && d >= 24) return Season.halloween;
      if (m == 12 && d <= 26) return Season.christmas;
      if (m == 2 && d >= 7 && d <= 14) return Season.valentine;
    }
    return switch (m) {
      3 || 4 || 5 => Season.spring,
      6 || 7 || 8 => Season.summer,
      9 || 10 || 11 => Season.autumn,
      _ => Season.winter,
    };
  }

  static BastionPalette paletteFor(Season s) => switch (s) {
    Season.spring => SeasonalPalettes.spring,
    Season.summer => SeasonalPalettes.summer,
    Season.autumn => SeasonalPalettes.autumn,
    Season.winter => SeasonalPalettes.winter,
    Season.halloween => SeasonalPalettes.halloween,
    Season.christmas => SeasonalPalettes.christmas,
    Season.valentine => SeasonalPalettes.valentine,
  };
}

/// The Seasonal theme's colours, one palette per [Season].
abstract final class SeasonalPalettes {
  /// Sage, lavender, pale yellow and floral pink.
  static const spring = BastionPalette(
    brightness: Brightness.light,
    bg: Color(0xFFF6F8EC),
    bg1: Color(0xFFEEF2E0),
    bg2: Color(0xFFE4EAD3),
    bg3: Color(0xFFD8E0C4),
    bg4: Color(0xFFC8D2B0),
    line: Color(0xFFD3DBC0),
    line2: Color(0xFFB4C09A),
    line3: Color(0xFF6E7C58),
    ink: Color(0xFF26301F),
    ink2: Color(0xFF323D29),
    ink3: Color(0xFF3E4A33),
    ink4: Color(0xFF434F37),
    signal: Color(0xFF2F6B3A),
    signalDim: Color(0xFF4A7F52),
    warn: Color(0xFF7A5500),
    warnDim: Color(0xFF8F6714),
    alert: Color(0xFFA3203A),
    accent: Color(0xFF5E4A8C),
    accentDim: Color(0xFF9C88C9),
    onAccent: Color(0xFFFFFFFF),
    magenta: Color(0xFFA3336B),
    me: Color(0xFF5E4A8C),
    meBorder: Color(0xFF9C88C9),
    meInk: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFE2DAF5),
    secondaryContainer: Color(0xFFFBEFB0),
    nav: Color(0xFF5E4A8C),
  );

  /// Ocean teal, turquoise, coral and warm sand.
  static const summer = BastionPalette(
    brightness: Brightness.light,
    bg: Color(0xFFFBF5E9),
    bg1: Color(0xFFF5ECDA),
    bg2: Color(0xFFEDE1C8),
    bg3: Color(0xFFE3D4B4),
    bg4: Color(0xFFD6C49E),
    line: Color(0xFFE2D3B6),
    line2: Color(0xFFC9B48E),
    line3: Color(0xFF7E6A45),
    ink: Color(0xFF1E2B2E),
    ink2: Color(0xFF26363A),
    ink3: Color(0xFF2F4246),
    ink4: Color(0xFF33464A),
    signal: Color(0xFF1E6749),
    signalDim: Color(0xFF3A7F62),
    warn: Color(0xFF7A4E00),
    warnDim: Color(0xFF8F6012),
    alert: Color(0xFFA8262C),
    accent: Color(0xFF00676E),
    accentDim: Color(0xFF1FB5B0),
    onAccent: Color(0xFFFFFFFF),
    magenta: Color(0xFFA8442E),
    me: Color(0xFF00676E),
    meBorder: Color(0xFF1FB5B0),
    meInk: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFC8EDEA),
    secondaryContainer: Color(0xFFFFD9CC),
    nav: Color(0xFF00676E),
  );

  /// Burnt orange, amber, forest green and deep brown.
  static const autumn = BastionPalette(
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
  );

  /// Ice blue, navy, silver and frost white.
  static const winter = BastionPalette(
    brightness: Brightness.dark,
    bg: Color(0xFF0D1626),
    bg1: Color(0xFF121D30),
    bg2: Color(0xFF18253B),
    bg3: Color(0xFF213049),
    bg4: Color(0xFF2C3E5C),
    line: Color(0xFF243450),
    line2: Color(0xFF344A6C),
    line3: Color(0xFF7088AE),
    ink: Color(0xFFF2F6FB),
    ink2: Color(0xFFD8E2EE),
    ink3: Color(0xFFC0CEDF),
    ink4: Color(0xFFB2C1D4),
    signal: Color(0xFF8FD3B5),
    signalDim: Color(0xFF6AA88C),
    warn: Color(0xFFF2C96B),
    warnDim: Color(0xFFC29F4F),
    alert: Color(0xFFFF7A6E),
    accent: Color(0xFF9ED4F5),
    accentDim: Color(0xFF5BA3D0),
    onAccent: Color(0xFF06172A),
    magenta: Color(0xFFC9D3DE),
    me: Color(0xFF1E3555),
    meBorder: Color(0xFF5BA3D0),
    meInk: Color(0xFFF2F6FB),
    primaryContainer: Color(0xFF1D3F5E),
    secondaryContainer: Color(0xFF35414F),
    nav: Color(0xFF9ED4F5),
  );

  /// Black, purple and pumpkin orange.
  static const halloween = BastionPalette(
    brightness: Brightness.dark,
    bg: Color(0xFF0B0A0F),
    bg1: Color(0xFF120F18),
    bg2: Color(0xFF191421),
    bg3: Color(0xFF231B2E),
    bg4: Color(0xFF30243F),
    line: Color(0xFF2A2036),
    line2: Color(0xFF3E2F50),
    line3: Color(0xFF7E62A0),
    ink: Color(0xFFF4ECE2),
    ink2: Color(0xFFE2D6C8),
    ink3: Color(0xFFCDBFAF),
    ink4: Color(0xFFC0B0A0),
    signal: Color(0xFF9BD18F),
    signalDim: Color(0xFF76A36C),
    warn: Color(0xFFFFC24D),
    warnDim: Color(0xFFC9973A),
    alert: Color(0xFFFF5C5C),
    accent: Color(0xFFFF8C1A),
    accentDim: Color(0xFFC2600A),
    onAccent: Color(0xFF1A0B00),
    magenta: Color(0xFFB98AF0),
    me: Color(0xFF2E1E40),
    meBorder: Color(0xFF8E5BD0),
    meInk: Color(0xFFF4ECE2),
    primaryContainer: Color(0xFF4A2808),
    secondaryContainer: Color(0xFF3A2655),
    nav: Color(0xFFFF8C1A),
  );

  /// Evergreen, cranberry and gold.
  static const christmas = BastionPalette(
    brightness: Brightness.dark,
    bg: Color(0xFF0C1A14),
    bg1: Color(0xFF11231B),
    bg2: Color(0xFF162D23),
    bg3: Color(0xFF1E3A2E),
    bg4: Color(0xFF284A3B),
    line: Color(0xFF22402F),
    line2: Color(0xFF315A45),
    line3: Color(0xFF6E9A80),
    ink: Color(0xFFF7F1E3),
    ink2: Color(0xFFE6DCC6),
    ink3: Color(0xFFD3C7AE),
    ink4: Color(0xFFC6B89C),
    signal: Color(0xFF8FD3A0),
    signalDim: Color(0xFF6AA87A),
    warn: Color(0xFFE8C15A),
    warnDim: Color(0xFFB8963F),
    alert: Color(0xFFFF7070),
    accent: Color(0xFFE8C15A),
    accentDim: Color(0xFFB8963F),
    onAccent: Color(0xFF1C1400),
    magenta: Color(0xFFF08A9A),
    me: Color(0xFF4A1520),
    meBorder: Color(0xFFC23B4E),
    meInk: Color(0xFFF7F1E3),
    primaryContainer: Color(0xFF4A3C10),
    secondaryContainer: Color(0xFF4A1520),
    nav: Color(0xFFE8C15A),
  );

  /// Rose, blush and burgundy.
  static const valentine = BastionPalette(
    brightness: Brightness.light,
    bg: Color(0xFFFFF3F4),
    bg1: Color(0xFFFCE7EA),
    bg2: Color(0xFFF8D8DD),
    bg3: Color(0xFFF2C6CD),
    bg4: Color(0xFFE8AEB8),
    line: Color(0xFFF0C9D0),
    line2: Color(0xFFDDA0AC),
    line3: Color(0xFF9E4A5C),
    ink: Color(0xFF3D0F1C),
    ink2: Color(0xFF4A1424),
    ink3: Color(0xFF57192B),
    ink4: Color(0xFF5C1B2E),
    signal: Color(0xFF1D633F),
    signalDim: Color(0xFF3A7F5C),
    warn: Color(0xFF7A4300),
    warnDim: Color(0xFF8F5512),
    alert: Color(0xFFA30F2D),
    accent: Color(0xFF9B1B3C),
    accentDim: Color(0xFFD9667F),
    onAccent: Color(0xFFFFFFFF),
    magenta: Color(0xFF6E2A6E),
    me: Color(0xFF9B1B3C),
    meBorder: Color(0xFFD9667F),
    meInk: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFF8D0DA),
    secondaryContainer: Color(0xFFEBD3EB),
    nav: Color(0xFF9B1B3C),
  );
}
