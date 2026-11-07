import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/models/channel_message.dart';
import 'package:meshcore_open/models/path_graph.dart';
import 'package:meshcore_open/screens/path_graph_screen.dart';
import 'package:meshcore_open/services/path_graph_source.dart';
import 'package:meshcore_open/widgets/path_sankey.dart';

ChannelMessage _msg(
  List<int> path, {
  int? width,
  List<List<int>> variants = const [],
  bool outgoing = false,
  Duration age = const Duration(hours: 1),
}) => ChannelMessage(
  senderKey: null,
  senderName: 'Alex',
  text: 'hi',
  timestamp: DateTime.now().subtract(age),
  isOutgoing: outgoing,
  status: ChannelMessageStatus.sent,
  channelIndex: 0,
  pathBytes: Uint8List.fromList(path),
  pathHashWidth: width,
  pathVariants: [for (final v in variants) Uint8List.fromList(v)],
);

final _public = Channel(
  index: 0,
  name: 'Public',
  psk: Uint8List.fromList(List.filled(16, 1)),
);

class _Radio extends MeshCoreConnector {
  @override
  List<Channel> get channels => [_public];
  @override
  Future<List<ChannelMessage>> loadFullChannelHistory(Channel c) async => [
    _msg([0xab, 0x12, 0xcd, 0x34], width: 2),
    _msg([0xef, 0x56, 0xcd, 0x34], width: 2),
    _msg(
      [0xab, 0xcd],
      width: 1,
      variants: [
        [0xef, 0xcd],
      ],
    ),
    _msg([0x11], outgoing: true),
    _msg([0x22, 0x33], width: 1, age: const Duration(days: 30)),
  ];
}

void main() {
  test('a message counts once per distinct path it arrived by', () {
    final paths = pathsOf(
      _msg(
        [0xab, 0xcd],
        width: 1,
        variants: [
          [0xab, 0xcd],
          [0xef, 0xcd],
        ],
      ),
      1,
      'Alex on Public',
    );
    expect(paths.map((p) => p.hops), [
      ['AB', 'CD'],
      ['EF', 'CD'],
    ]);
    expect(pathsOf(_msg([0xab, 0xcd, 0xef], width: 2), 1, 's'), isEmpty);
  });

  test('collects incoming channel paths in the time range', () async {
    final radio = _Radio();
    final week = await collectChannelPaths(
      radio,
      since: DateTime.now().subtract(const Duration(days: 7)),
    );
    expect(week, hasLength(4));
    expect(await collectChannelPaths(radio), hasLength(5));
    radio.dispose();
  });

  test('sankey layout: you on the right, bands stack within boxes', () {
    final graph = PathGraph.build([
      PathObservation(hops: ['AB12', 'CD34'], width: 2, at: _t, source: 's'),
      PathObservation(hops: ['EF56', 'CD34'], width: 2, at: _t, source: 's'),
      PathObservation(hops: ['CD34'], width: 2, at: _t, source: 's'),
    ]);
    final layout = layoutSankey(graph, const Size(300, 200));
    final you = layout.boxes.firstWhere((b) => b.id == pathGraphSelf);
    final cd = layout.boxes.firstWhere((b) => b.id == 'CD34');
    final ab = layout.boxes.firstWhere((b) => b.id == 'AB12');
    expect(you.rect.left, greaterThan(cd.rect.left));
    expect(cd.rect.left, greaterThan(ab.rect.left));
    expect(you.rect.right, lessThanOrEqualTo(300));
    for (final b in layout.boxes) {
      expect(b.rect.bottom, lessThanOrEqualTo(200.001));
    }
    final intoCd = layout.bands.where((b) => b.to == 'CD34').toList();
    expect(intoCd, hasLength(2));
    expect(intoCd[1].y1, closeTo(intoCd[0].y1 + intoCd[0].thickness, 0.001));
    expect(
      layoutSankey(PathGraph.build(const []), const Size(300, 200)).boxes,
      isEmpty,
    );
  });

  testWidgets('the screen shows the summary, chart and busiest repeaters', (
    tester,
  ) async {
    final radio = _Radio();
    await tester.pumpWidget(
      ChangeNotifierProvider<MeshCoreConnector>.value(
        value: radio,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: PathGraphScreen(),
        ),
      ),
    );
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await tester.pump();
    expect(find.text('4 paths heard · 3 repeaters'), findsOneWidget);
    expect(find.byKey(const ValueKey('path-sankey')), findsOneWidget);
    expect(find.text('Busiest repeaters'), findsOneWidget);
    expect(
      find.textContaining('matched to a specific repeater'),
      findsOneWidget,
    );

    // A busiest repeater opens where its traffic comes from and goes.
    final first = find.byWidgetPredicate(
      (w) =>
          w.key is ValueKey<String> &&
          (w.key! as ValueKey<String>).value.startsWith('busiest-'),
    );
    await tester.ensureVisible(first.first);
    await tester.tap(first.first);
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('hop-sheet')), findsOneWidget);
    expect(find.textContaining('Relayed'), findsOneWidget);
  });
}

final _t = DateTime.utc(2026, 10, 16);
