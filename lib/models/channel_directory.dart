import 'dart:convert';

import 'package:latlong2/latlong.dart';

/// What a directory channel is for, used to group and filter the list.
enum ChannelCategory {
  emergency,
  local,
  general,
  interest,
  test;

  static ChannelCategory? fromId(String? id) {
    for (final c in values) {
      if (c.name == id) return c;
    }
    return null;
  }
}

/// Where a local channel is used: a named circle on the map.
class ChannelArea {
  final String name;
  final LatLng center;
  final double radiusKm;

  const ChannelArea({
    required this.name,
    required this.center,
    required this.radiusKm,
  });

  static const _distance = Distance();

  /// Kilometres from [point] to the middle of the area.
  double distanceKm(LatLng point) =>
      _distance.as(LengthUnit.Kilometer, center, point);

  bool contains(LatLng point) => distanceKm(point) <= radiusKm;
}

/// One public hashtag channel from the shared `channel_directory.json` list.
class ChannelDirectoryEntry {
  /// Starts with '#', e.g. "#seattle". Kept exactly as written: the
  /// channel key is derived from the name, so "#F1" and "#f1" differ.
  final String name;
  final ChannelCategory category;
  final String description;

  /// Null for channels used everywhere, like #test.
  final ChannelArea? area;

  const ChannelDirectoryEntry({
    required this.name,
    required this.category,
    required this.description,
    this.area,
  });

  static final _validName = RegExp(r'^#[A-Za-z0-9][A-Za-z0-9_-]{0,30}$');

  /// Reads one entry, or null if anything is missing or malformed.
  static ChannelDirectoryEntry? fromJson(Map<String, dynamic> j) {
    try {
      final name = (j['name'] as String).trim();
      final category = ChannelCategory.fromId(j['category'] as String?);
      if (!_validName.hasMatch(name) || category == null) return null;
      ChannelArea? area;
      final a = j['area'];
      if (a is Map<String, dynamic>) {
        final center = (a['center'] as List).cast<num>();
        final radius = (a['radiusKm'] as num).toDouble();
        final lat = center[0].toDouble(), lon = center[1].toDouble();
        if (lat.abs() > 90 || lon.abs() > 180 || radius <= 0) return null;
        area = ChannelArea(
          name: a['name'] as String,
          center: LatLng(lat, lon),
          radiusKm: radius,
        );
      }
      return ChannelDirectoryEntry(
        name: name,
        category: category,
        description: (j['description'] as String? ?? '').trim(),
        area: area,
      );
    } catch (_) {
      return null;
    }
  }

  /// Whether [query] appears in the name, description or area name.
  bool matches(String query) {
    final q = query.trim().toLowerCase().replaceFirst('#', '');
    if (q.isEmpty) return true;
    return name.toLowerCase().contains(q) ||
        description.toLowerCase().contains(q) ||
        (area?.name.toLowerCase().contains(q) ?? false);
  }
}

/// Reads a `channel_directory.json` document, skipping invalid entries and
/// repeats of a name already listed.
List<ChannelDirectoryEntry> parseChannelDirectory(String source) {
  try {
    final doc = jsonDecode(source) as Map<String, dynamic>;
    final seen = <String>{};
    final out = <ChannelDirectoryEntry>[];
    for (final raw in (doc['channels'] as List)) {
      if (raw is! Map<String, dynamic>) continue;
      final entry = ChannelDirectoryEntry.fromJson(raw);
      if (entry != null && seen.add(entry.name)) out.add(entry);
    }
    return out;
  } catch (_) {
    return const [];
  }
}

/// Local channels whose area includes [position], most local (smallest
/// area) first, so a city comes before its state and region.
List<ChannelDirectoryEntry> channelsNear(
  List<ChannelDirectoryEntry> entries,
  LatLng position,
) {
  final near = [
    for (final e in entries)
      if (e.area?.contains(position) ?? false) e,
  ];
  near.sort((a, b) {
    final bySize = a.area!.radiusKm.compareTo(b.area!.radiusKm);
    return bySize != 0
        ? bySize
        : a.area!.distanceKm(position).compareTo(b.area!.distanceKm(position));
  });
  return near;
}
