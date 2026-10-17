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
  topoNight(
    'topo_night',
    'Topo night',
    'Deep navy with glacier cyan',
    BastionPalette(
      brightness: Brightness.dark,
      bg: Color(0xFF0E1621),
      bg1: Color(0xFF121C28),
      bg2: Color(0xFF16222F),
      bg3: Color(0xFF1D2B3A),
      bg4: Color(0xFF24384A),
      line: Color(0xFF24384A),
      line2: Color(0xFF34495C),
      line3: Color(0xFF4F6478),
      ink: Color(0xFFE4EEF5),
      ink2: Color(0xFFC5D3DF),
      ink3: Color(0xFF8FA3B5),
      ink4: Color(0xFF7A90A6),
      signal: Color(0xFF7FD8A4),
      signalDim: Color(0xFF5FAE82),
      warn: Color(0xFFF5B841),
      warnDim: Color(0xFFC79231),
      alert: Color(0xFFFF6B6B),
      accent: Color(0xFF5CE1E6),
      accentDim: Color(0xFF3BAAB0),
      onAccent: Color(0xFF062027),
      magenta: Color(0xFFB9A7E8),
      me: Color(0xFF173A48),
      meBorder: Color(0xFF3E8E9A),
      meInk: Color(0xFFE4EEF5),
      primaryContainer: Color(0xFF123E46),
      secondaryContainer: Color(0xFF4A3A16),
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
  ),
  alpineDay(
    'alpine_day',
    'Alpine day',
    'Light, for bright sun',
    BastionPalette(
      brightness: Brightness.light,
      bg: Color(0xFFF3F4EF),
      bg1: Color(0xFFECEEE8),
      bg2: Color(0xFFFFFFFF),
      bg3: Color(0xFFE3E7E0),
      bg4: Color(0xFFD6DBD3),
      line: Color(0xFFD6DBD3),
      line2: Color(0xFFB9C2B8),
      line3: Color(0xFF8E998F),
      ink: Color(0xFF16201B),
      ink2: Color(0xFF33413A),
      ink3: Color(0xFF5A685F),
      ink4: Color(0xFF616E66),
      signal: Color(0xFF2F7D4A),
      signalDim: Color(0xFF3F8F5A),
      warn: Color(0xFF9A5F08),
      warnDim: Color(0xFF7F4E07),
      alert: Color(0xFFB83A16),
      accent: Color(0xFF1F6B4F),
      accentDim: Color(0xFF2E8A68),
      onAccent: Color(0xFFFFFFFF),
      magenta: Color(0xFF7B4E8A),
      me: Color(0xFFDCEBE3),
      meBorder: Color(0xFF6FA58C),
      meInk: Color(0xFF16201B),
      primaryContainer: Color(0xFFCFE6DA),
      secondaryContainer: Color(0xFFF3E3C3),
    ),
  );

  const BastionTheme(this.id, this.label, this.description, this.palette);
  final String id;
  final String label;
  final String description;
  final BastionPalette palette;

  static const fallback = BastionTheme.blaze;

  static BastionTheme fromId(String? id) {
    for (final t in values) {
      if (t.id == id) return t;
    }
    return fallback;
  }
}
