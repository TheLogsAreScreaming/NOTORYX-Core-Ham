import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/field_report.dart';

void main() {
  List<String> filled(FieldReportKind kind, String value) => [
    for (final _ in kind.lines) value,
  ];

  test('a short SALUTE is one plain-text message with the call sign', () {
    final r = buildFieldReport(
      FieldReportKind.salute,
      ['3 hikers', 'moving north', '35.1,-80.5', '', '14:05Z', ' two   packs '],
      callsign: 'kd2abc',
      maxBytes: 120,
    );
    expect((r as FieldReportParts).parts, [
      'SALUTE de KD2ABC 1/1 S:3 hikers | A:moving north | L:35.1,-80.5 | '
          'T:14:05Z | E:two packs',
    ]);
  });

  test('a long 9-Line splits between lines; every part has the call sign', () {
    final r = buildFieldReport(
      FieldReportKind.nineLine,
      filled(FieldReportKind.nineLine, 'x' * 40),
      callsign: 'W1AW',
      maxBytes: 120,
    );
    final parts = (r as FieldReportParts).parts;
    expect(parts.length, greaterThan(1));
    for (final (i, p) in parts.indexed) {
      expect(p, startsWith('9LINE de W1AW ${i + 1}/${parts.length} '));
      expect(utf8.encode(p).length, lessThanOrEqualTo(120));
    }
    final all = parts.join(' ');
    for (var n = 1; n <= 9; n++) {
      expect(all, contains('$n:${'x' * 40}'));
    }
  });

  test('blank forms and lines that cannot fit are refused', () {
    expect(
      buildFieldReport(
        FieldReportKind.salute,
        filled(FieldReportKind.salute, '  '),
        callsign: 'W1AW',
        maxBytes: 120,
      ),
      isA<FieldReportEmpty>(),
    );
    expect(
      buildFieldReport(
        FieldReportKind.salute,
        filled(FieldReportKind.salute, 'é' * 80),
        callsign: 'W1AW',
        maxBytes: 120,
      ),
      isA<FieldReportTooLong>(),
    );
  });
}
