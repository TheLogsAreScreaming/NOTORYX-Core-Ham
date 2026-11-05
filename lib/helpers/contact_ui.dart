import 'package:flutter/material.dart';

import '../connector/meshcore_protocol.dart';
import '../theme/okabe_ito.dart';
import '../utils/emoji_utils.dart';

IconData contactTypeIcon(int type) {
  switch (type) {
    case advTypeChat:
      return Icons.chat;
    case advTypeRepeater:
      return Icons.cell_tower;
    case advTypeRoom:
      return Icons.group;
    case advTypeSensor:
      return Icons.sensors;
    default:
      return Icons.device_unknown;
  }
}

/// Node-type colors from the color-blind safe Okabe-Ito palette.
Color contactTypeColor(int type) => OkabeIto.nodeType(type);

Color colorForName(String name) =>
    OkabeIto.categorical[name.hashCode.abs() % OkabeIto.categorical.length];

String firstCharacterOrEmoji(String name) {
  if (name.isEmpty) return '?';
  final emoji = firstEmoji(name);
  if (emoji != null) return emoji;
  final runes = name.runes.toList();
  if (runes.isEmpty) return '?';
  return String.fromCharCode(runes[0]).toUpperCase();
}
