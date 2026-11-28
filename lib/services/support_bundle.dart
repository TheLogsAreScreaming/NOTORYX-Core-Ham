import 'connection_timeline.dart';

/// Strips what a support file must not carry: node and channel names, public
/// keys and other long hex runs, and positions. Names become `node-1`,
/// `node-2`… in the order given, so one name always maps to the same label
/// and the file still reads as a story.
class SupportRedactor {
  SupportRedactor(Iterable<String> names) {
    var i = 0;
    // Longest first, so "Base Camp 2" is replaced before "Base Camp".
    final sorted = {
      for (final n in names)
        if (n.trim().length >= 2) n.trim(),
    }.toList()..sort((a, b) => b.length.compareTo(a.length));
    for (final n in sorted) {
      _labels[n] = 'node-${++i}';
    }
  }

  final Map<String, String> _labels = {};

  // 12+ hex digits, optionally split by spaces or colons per byte: public
  // keys, key prefixes long enough to identify a node, raw frames.
  static final _hexRun = RegExp(
    r'\b[0-9a-fA-F]{2}(?:[ :]?[0-9a-fA-F]{2}){5,}\b',
  );

  // US amateur call signs (K1ABC, W1AW, KD2XYZ): station IDs show up in
  // log lines for stations that are not contacts.
  static final _callsign = RegExp(r'\b[AKNW][A-Z]{0,2}[0-9][A-Z]{1,3}\b');

  // Decimal coordinates such as 40.12345, -75.5 (2+ decimals) in a pair.
  static final _latLon = RegExp(r'-?\d{1,3}\.\d{2,}\s*,\s*-?\d{1,3}\.\d{2,}');

  String redact(String text) {
    var out = text;
    for (final e in _labels.entries) {
      out = out.replaceAll(e.key, e.value);
    }
    out = out.replaceAll(_latLon, '[position]');
    out = out.replaceAll(_callsign, '[call]');
    out = out.replaceAll(_hexRun, '[hex]');
    return out;
  }
}

/// Builds the plain-text support file: versions, the current link, the
/// connection timeline and the recent app log, all run through [redactor].
/// Message text and raw frames are never included.
String buildSupportBundle({
  required DateTime generatedAt,
  required String appVersion,
  required String platform,
  required Map<String, String> radio,
  required List<ConnectionEvent> timeline,
  required List<String> appLog,
  required SupportRedactor redactor,
}) {
  final lines = <String>[
    'NOTORYX Core Ham support bundle',
    'Generated: ${generatedAt.toIso8601String()}',
    'App: $appVersion',
    'Platform: $platform',
    'Names, keys and positions are replaced before this file is written.',
    '',
    '== Radio',
    for (final e in radio.entries) '${e.key}: ${e.value}',
    '',
    '== Connection timeline (${timeline.length})',
    if (timeline.isEmpty) '(no changes since the app started)',
    for (final e in timeline) e.toLogLine(),
    '',
    '== App log (${appLog.length})',
    if (appLog.isEmpty) '(app debug log is off or empty)',
    ...appLog,
  ];
  return redactor.redact(lines.join('\n'));
}
