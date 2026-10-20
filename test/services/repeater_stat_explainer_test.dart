import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/services/repeater_stat_explainer.dart';

void main() {
  test('explains why errors may exceed received packets', () {
    expect(RepeaterStatExplainer.explain('packet_errors'), contains('exceed'));
  });
  test('diagnostics excludes unknown and sensitive fields', () {
    final output = RepeaterStatExplainer.diagnostics(
      capturedAt: DateTime.utc(2026),
      stats: <String, Object?>{
        'packets_received': 291842,
        'packet_errors': 302103,
        'private_key': 'secret',
        'latitude': 1.0,
      },
    );
    expect(output, contains('302103'));
    expect(output, isNot(contains('secret')));
    expect(output, isNot(contains('latitude')));
  });
}
