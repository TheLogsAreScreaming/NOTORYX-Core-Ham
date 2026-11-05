import 'dart:convert';

import 'package:latlong2/latlong.dart';

import '../utils/amateur_radio.dart';

/// The radio settings a local mesh has agreed on, from the shared
/// `regional_presets.json` list.
class RegionalPreset {
  final String id;
  final String name;
  final LatLng center;
  final double radiusKm;
  final double frequencyMHz;
  final double bandwidthKHz;
  final int spreadingFactor;

  /// 5–8, meaning 4/5–4/8.
  final int codingRate;

  /// Bytes per hop in paths: 1, 2 or 3 (path hash mode 0, 1 or 2).
  final int pathHashBytes;

  /// When the area last changed its settings, as YYYY-MM-DD.
  final String updated;
  final String notes;

  const RegionalPreset({
    required this.id,
    required this.name,
    required this.center,
    required this.radiusKm,
    required this.frequencyMHz,
    required this.bandwidthKHz,
    required this.spreadingFactor,
    required this.codingRate,
    required this.pathHashBytes,
    required this.updated,
    this.notes = '',
  });

  /// Reads one entry, or null if any value is missing or out of range.
  static RegionalPreset? fromJson(Map<String, dynamic> j) {
    try {
      final center = (j['center'] as List).cast<num>();
      final p = RegionalPreset(
        id: j['id'] as String,
        name: j['name'] as String,
        center: LatLng(center[0].toDouble(), center[1].toDouble()),
        radiusKm: (j['radiusKm'] as num).toDouble(),
        frequencyMHz: (j['frequencyMHz'] as num).toDouble(),
        bandwidthKHz: (j['bandwidthKHz'] as num).toDouble(),
        spreadingFactor: (j['spreadingFactor'] as num).toInt(),
        codingRate: (j['codingRate'] as num).toInt(),
        pathHashBytes: (j['pathHashBytes'] as num? ?? 1).toInt(),
        updated: j['updated'] as String,
        notes: j['notes'] as String? ?? '',
      );
      final valid =
          p.id.isNotEmpty &&
          isAmateurFrequencyMHz(p.frequencyMHz) && // ham firmware bands only
          const [
            7.8,
            10.4,
            15.6,
            20.8,
            31.25,
            41.7,
            62.5,
            125,
            250,
            500,
          ].contains(p.bandwidthKHz) &&
          p.spreadingFactor >= 5 &&
          p.spreadingFactor <= 12 &&
          p.codingRate >= 5 &&
          p.codingRate <= 8 &&
          p.pathHashBytes >= 1 &&
          p.pathHashBytes <= 3 &&
          p.radiusKm > 0 &&
          RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(p.updated);
      return valid ? p : null;
    } catch (_) {
      return null;
    }
  }

  /// "919.500 MHz · BW500 · SF10 · CR5 · 2-byte paths"
  String get summary =>
      '${frequencyMHz.toStringAsFixed(3)} MHz · BW${_num(bandwidthKHz)} · SF$spreadingFactor · CR$codingRate · $pathHashBytes-byte paths';

  /// Identifies these exact settings, so a dismissal or "seen" mark lapses
  /// when the area changes them.
  String get signature =>
      '$id|$frequencyMHz|$bandwidthKHz|$spreadingFactor|$codingRate|$pathHashBytes|$updated';

  /// What differs between [radio] and this preset, as readable lines. Empty
  /// when the radio already matches (or hasn't reported its settings).
  List<String> differences(RadioSettingsState radio) {
    final out = <String>[];
    final f = radio.frequencyMHz;
    if (f != null && (f - frequencyMHz).abs() > 0.0005) {
      out.add(
        'Frequency ${f.toStringAsFixed(3)} → ${frequencyMHz.toStringAsFixed(3)} MHz',
      );
    }
    final bw = radio.bandwidthKHz;
    if (bw != null && (bw - bandwidthKHz).abs() > 0.05) {
      out.add('Bandwidth ${_num(bw)} → ${_num(bandwidthKHz)} kHz');
    }
    if (radio.spreadingFactor != null &&
        radio.spreadingFactor != spreadingFactor) {
      out.add('Spreading factor ${radio.spreadingFactor} → $spreadingFactor');
    }
    if (radio.codingRate != null && radio.codingRate != codingRate) {
      out.add('Coding rate 4/${radio.codingRate} → 4/$codingRate');
    }
    if (radio.pathHashBytes != null && radio.pathHashBytes != pathHashBytes) {
      out.add('Path hash ${radio.pathHashBytes}-byte → $pathHashBytes-byte');
    }
    return out;
  }
}

/// The settings a radio reports, in display units.
class RadioSettingsState {
  final double? frequencyMHz;
  final double? bandwidthKHz;
  final int? spreadingFactor;
  final int? codingRate;
  final int? pathHashBytes;
  const RadioSettingsState({
    this.frequencyMHz,
    this.bandwidthKHz,
    this.spreadingFactor,
    this.codingRate,
    this.pathHashBytes,
  });
}

/// Reads a `regional_presets.json` document, skipping invalid entries.
/// Returns an empty list when the document itself is unreadable.
List<RegionalPreset> parseRegionalPresets(String source) {
  try {
    final doc = jsonDecode(source) as Map<String, dynamic>;
    if (doc['version'] != 1) return const [];
    return [
      for (final r in doc['regions'] as List)
        if (r is Map<String, dynamic>) ?RegionalPreset.fromJson(r),
    ];
  } catch (_) {
    return const [];
  }
}

/// The preset whose area contains [position], nearest first; null if none.
RegionalPreset? presetForPosition(
  List<RegionalPreset> presets,
  LatLng? position,
) {
  if (position == null) return null;
  const distance = Distance();
  RegionalPreset? best;
  double? bestKm;
  for (final p in presets) {
    final km = distance.as(LengthUnit.Kilometer, position, p.center);
    if (km > p.radiusKm) continue;
    if (bestKm == null || km < bestKm) {
      best = p;
      bestKm = km;
    }
  }
  return best;
}

String _num(double v) =>
    v == v.roundToDouble() ? v.toInt().toString() : v.toString();
