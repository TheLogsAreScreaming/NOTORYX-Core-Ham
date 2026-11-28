import 'package:flutter/material.dart';

import '../connector/meshcore_protocol.dart';

/// The Okabe-Ito categorical palette (Okabe & Ito, 2002). Its eight colors
/// stay distinct under the common forms of color blindness, so the app uses
/// it wherever a color names a category, such as a node type on the map.
abstract final class OkabeIto {
  static const orange = Color(0xFFE69F00);
  static const skyBlue = Color(0xFF56B4E9);
  static const bluishGreen = Color(0xFF009E73);
  static const yellow = Color(0xFFF0E442);
  static const blue = Color(0xFF0072B2);
  static const vermillion = Color(0xFFD55E00);
  static const reddishPurple = Color(0xFFCC79A7);
  static const black = Color(0xFF000000);

  /// The seven colors, in the palette's order, for categories drawn on any
  /// background. Black is left out: it vanishes on dark themes and maps.
  static const categorical = [
    orange,
    skyBlue,
    bluishGreen,
    yellow,
    blue,
    vermillion,
    reddishPurple,
  ];

  /// Node types on maps and in lists.
  static Color nodeType(int type) => switch (type) {
    advTypeChat => skyBlue,
    advTypeRepeater => orange,
    advTypeRoom => reddishPurple,
    advTypeSensor => bluishGreen,
    _ => const Color(0xFF6B7280),
  };
}
