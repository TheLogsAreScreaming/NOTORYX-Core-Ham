import 'dart:convert';

/// The rules MeshCore applies to region names.
final _validRegionName = RegExp(r'^[a-z0-9-]{1,29}$');

/// Most regions one repeater can carry.
const maxRegionsPerRepeater = 32;

/// Whether [name] is a usable MeshCore region name: lowercase letters,
/// digits and hyphens, at most 29 characters.
bool isValidRegionName(String name) => _validRegionName.hasMatch(name);

/// One region in a [RegionTree].
class RegionNode {
  final String name;
  final String? parent;
  final String label;

  const RegionNode({required this.name, this.parent, this.label = ''});
}

/// A named hierarchy of regions, like usa › us-ne › ct.
class RegionTree {
  final String id;
  final String name;
  final Map<String, RegionNode> regions;

  const RegionTree({
    required this.id,
    required this.name,
    required this.regions,
  });

  /// [name] and every region above it, broadest first. Stops at a missing
  /// parent or a loop.
  List<String> chainFor(String name) {
    final out = <String>[];
    String? current = name;
    while (current != null && regions.containsKey(current)) {
      if (out.contains(current)) break;
      out.insert(0, current);
      current = regions[current]!.parent;
    }
    return out;
  }

  /// Regions ordered as a tree (each parent followed by its children),
  /// with their depth, for an indented picker.
  List<(RegionNode, int)> ordered() {
    final out = <(RegionNode, int)>[];
    void walk(String? parent, int depth) {
      final children = regions.values.where((r) => r.parent == parent).toList()
        ..sort((a, b) => a.name.compareTo(b.name));
      for (final child in children) {
        out.add((child, depth));
        walk(child.name, depth + 1);
      }
    }

    walk(null, 0);
    return out;
  }
}

/// Reads a `region_trees.json` document, skipping trees or regions with
/// invalid names.
List<RegionTree> parseRegionTrees(String source) {
  try {
    final doc = jsonDecode(source) as Map<String, dynamic>;
    final out = <RegionTree>[];
    for (final raw in (doc['trees'] as List)) {
      if (raw is! Map<String, dynamic>) continue;
      final regions = <String, RegionNode>{};
      for (final r in (raw['regions'] as List)) {
        if (r is! Map<String, dynamic>) continue;
        final name = r['name'];
        final parent = r['parent'];
        if (name is! String || !isValidRegionName(name)) continue;
        if (parent != null &&
            (parent is! String || !isValidRegionName(parent))) {
          continue;
        }
        regions[name] = RegionNode(
          name: name,
          parent: parent as String?,
          label: (r['label'] as String? ?? '').trim(),
        );
      }
      if (regions.isEmpty) continue;
      out.add(
        RegionTree(
          id: raw['id'] as String,
          name: raw['name'] as String,
          regions: regions,
        ),
      );
    }
    return out;
  } catch (_) {
    return const [];
  }
}

/// Splits "west > pnw > wa" (or commas, spaces, ›) into region names,
/// lowercased, dropping repeats.
List<String> parseRegionChain(String text) {
  final out = <String>[];
  for (final part in text.toLowerCase().split(RegExp(r'[>›,\s]+'))) {
    final name = part.trim();
    if (name.isNotEmpty && !out.contains(name)) out.add(name);
  }
  return out;
}

/// The repeater commands that give it [chain] (broadest first): one
/// `region put` per region, each under the one before it.
///
/// [legacyFirmware] adds `region allowf <name>` after each put, which
/// firmware 1.14 needs. [defaultRegion] scopes the repeater's own adverts.
/// [denyUnscoped] stops it flooding packets that carry no region, which
/// only makes sense once the whole area uses regions.
List<String> regionSetupCommands(
  List<String> chain, {
  String? defaultRegion,
  bool legacyFirmware = false,
  bool denyUnscoped = false,
}) {
  final out = <String>[];
  for (var i = 0; i < chain.length; i++) {
    out.add(
      i == 0
          ? 'region put ${chain[i]}'
          : 'region put ${chain[i]} ${chain[i - 1]}',
    );
    if (legacyFirmware) out.add('region allowf ${chain[i]}');
  }
  if (defaultRegion != null && chain.contains(defaultRegion)) {
    out.add('region default $defaultRegion');
  }
  if (denyUnscoped) out.add('region denyf *');
  out.add('region save');
  return out;
}
