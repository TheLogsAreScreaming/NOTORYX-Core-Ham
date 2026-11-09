import 'dart:convert';

/// One line of a report format: the short tag sent on the air and the label
/// the form shows. Both stay in English, because these are fixed formats that
/// the receiving station reads by line.
class FieldReportLine {
  const FieldReportLine(
    this.tag,
    this.label, {
    this.isLocation = false,
    this.isTime = false,
  });

  final String tag;
  final String label;

  /// Whether the form offers to fill this line from the radio's position.
  final bool isLocation;

  /// Whether the form starts this line with the current UTC time.
  final bool isTime;
}

/// The report formats the app can send.
enum FieldReportKind {
  salute('SALUTE', [
    FieldReportLine('S', 'Size'),
    FieldReportLine('A', 'Activity'),
    FieldReportLine('L', 'Location', isLocation: true),
    FieldReportLine('U', 'Unit or description'),
    FieldReportLine('T', 'Time (UTC)', isTime: true),
    FieldReportLine('E', 'Equipment'),
  ]),
  nineLine('9LINE', [
    FieldReportLine('1', 'Pickup location', isLocation: true),
    FieldReportLine('2', 'Frequency and call sign at the pickup site'),
    FieldReportLine('3', 'Patients by precedence'),
    FieldReportLine('4', 'Special equipment needed'),
    FieldReportLine('5', 'Patients by type (litter, ambulatory)'),
    FieldReportLine('6', 'Security at the pickup site'),
    FieldReportLine('7', 'How the pickup site is marked'),
    FieldReportLine('8', 'Patient status'),
    FieldReportLine('9', 'Terrain and obstacles'),
  ]);

  const FieldReportKind(this.wireName, this.lines);

  final String wireName;
  final List<FieldReportLine> lines;
}

/// What came of turning a filled-in form into messages.
sealed class FieldReportText {
  const FieldReportText();
}

/// Nothing has been filled in yet.
final class FieldReportEmpty extends FieldReportText {
  const FieldReportEmpty();
}

/// One line is too long to fit in a single message.
final class FieldReportTooLong extends FieldReportText {
  const FieldReportTooLong();
}

/// The messages to send, in order.
final class FieldReportParts extends FieldReportText {
  const FieldReportParts(this.parts);
  final List<String> parts;
}

/// Builds the plain-text messages for a report, each carrying the operator's
/// call sign so any one of them identifies the station on its own. Blank
/// lines are left out. Messages split between lines, never inside one.
///
/// [values] holds one entry per line of [kind]; [maxBytes] is the most one
/// message can carry.
FieldReportText buildFieldReport(
  FieldReportKind kind,
  List<String> values, {
  required String callsign,
  required int maxBytes,
}) {
  final items = <String>[
    for (final (i, line) in kind.lines.indexed)
      if (values[i].trim().isNotEmpty)
        '${line.tag}:${values[i].trim().replaceAll(RegExp(r'\s+'), ' ')}',
  ];
  if (items.isEmpty) return const FieldReportEmpty();

  // Part numbers are single digits: there are at most nine lines.
  final headerBytes = _bytes(_header(kind, callsign, 1, 1));
  final room = maxBytes - headerBytes;
  if (items.any((item) => _bytes(item) > room)) {
    return const FieldReportTooLong();
  }
  final bodies = <String>[];
  for (final item in items) {
    final joined = bodies.isEmpty ? null : '${bodies.last} | $item';
    if (joined != null && _bytes(joined) <= room) {
      bodies.last = joined;
    } else {
      bodies.add(item);
    }
  }
  return FieldReportParts([
    for (final (i, body) in bodies.indexed)
      '${_header(kind, callsign, i + 1, bodies.length)}$body',
  ]);
}

String _header(FieldReportKind kind, String callsign, int part, int total) =>
    '${kind.wireName} de ${callsign.toUpperCase()} $part/$total ';

int _bytes(String text) => utf8.encode(text).length;
