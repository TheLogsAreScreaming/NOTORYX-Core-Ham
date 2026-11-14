import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/day_replay.dart';
import 'package:meshcore_open/screens/day_replay_screen.dart';

/// intl writes a narrow no-break space before AM/PM.
DateTime _t(int h, [int m = 0]) => DateTime(2026, 11, 13, h, m);

final _tracks = [
  ReplayTrack(
    id: 'team:Al',
    name: 'Al',
    team: true,
    points: [
      ReplayPoint(_t(9), 45.52, -122.6),
      ReplayPoint(_t(11), 45.53, -122.61),
    ],
  ),
  ReplayTrack(
    id: 'team:Bo',
    name: 'Bo',
    team: true,
    points: [ReplayPoint(_t(10), 45.5, -122.5)],
  ),
  ReplayTrack(
    id: 'abcd',
    name: 'Ridge',
    points: [ReplayPoint(_t(9, 30), 45.6, -122.7)],
  ),
];

Widget _app() => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: DayReplayScreen(tracks: _tracks, showMap: false, now: () => _t(18)),
);

void main() {
  testWidgets('team only by default, scrub, play and Everyone', (tester) async {
    await tester.binding.setSurfaceSize(const Size(500, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(_app());
    expect(find.text('Al'), findsWidgets);
    expect(find.text('Ridge'), findsNothing);
    // Starts at the end of the day's data.
    expect(find.text('11:00\u202fAM'), findsOneWidget);
    expect(
      find.textContaining('Last seen 11:00\u202fAM at 45.53000'),
      findsOneWidget,
    );

    // Scrub to the start: only Al has been seen.
    final slider = find.byKey(const ValueKey('replay-scrubber'));
    await tester.drag(slider, const Offset(-600, 0));
    await tester.pump();
    expect(find.text('9:00\u202fAM'), findsOneWidget);
    expect(find.text('Not seen yet at this time'), findsOneWidget);
    expect(
      tester.widget<Slider>(slider).semanticFormatterCallback!(0),
      '9:00\u202fAM',
    );

    // Play at 5 min/s: 2 s moves 10 minutes.
    await tester.tap(find.byTooltip('Play'));
    await tester.pump(const Duration(seconds: 2));
    expect(find.text('9:10\u202fAM'), findsOneWidget);
    await tester.tap(find.byTooltip('Pause'));
    await tester.pump(const Duration(seconds: 2));
    expect(find.text('9:10\u202fAM'), findsOneWidget);

    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    await tester.tap(find.text('Everyone'));
    await tester.pump();
    expect(find.text('Ridge'), findsWidgets);
    handle.dispose();
  });

  testWidgets('hiding a node removes it from the list', (tester) async {
    await tester.binding.setSurfaceSize(const Size(500, 1600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_app());
    expect(find.textContaining('Last seen 10:00\u202fAM'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilterChip, 'Bo'));
    await tester.pump();
    expect(find.textContaining('Last seen 10:00\u202fAM'), findsNothing);
  });
}
