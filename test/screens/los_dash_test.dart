import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/screens/line_of_sight_map_screen.dart';

void main() {
  group('dashRuns', () {
    test('one long segment alternates dash and gap', () {
      final r = dashRuns(20, 0, dash: 5, gap: 4);
      expect(r.runs, [(0.0, 5.0), (9.0, 14.0), (18.0, 20.0)]);
      expect(r.phase, closeTo(2, 1e-9));
    });

    test('short segments carry the pattern instead of drawing solid', () {
      // 9 segments of 3 px: 27 px in all, so 3 dashes of 5 and 3 gaps of 4.
      var phase = 0.0;
      var drawn = 0.0;
      for (var i = 0; i < 9; i++) {
        final r = dashRuns(3, phase, dash: 5, gap: 4);
        for (final (a, b) in r.runs) {
          drawn += b - a;
        }
        phase = r.phase;
      }
      expect(drawn, closeTo(15, 1e-9));
    });

    test('a segment inside a gap draws nothing', () {
      final r = dashRuns(2, 6, dash: 5, gap: 4);
      expect(r.runs, isEmpty);
      expect(r.phase, closeTo(8, 1e-9));
    });
  });
}
