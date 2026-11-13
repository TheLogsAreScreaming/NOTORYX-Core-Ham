import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/trace_card.dart';
import 'package:meshcore_open/screens/trace_card_screen.dart';

TraceCard _card({bool senderPosition = true}) => TraceCard(
  sender: 'Base',
  target: 'Ridge',
  sentAt: DateTime.utc(2026, 11, 13, 15, 4),
  roundTrip: const Duration(milliseconds: 2400),
  senderLat: senderPosition ? 45.0 : null,
  senderLon: senderPosition ? -122.0 : null,
  returnSnr: 6.25,
  hops: const [
    TraceCardHop(id: '3D', name: 'Tower', snr: 9.5, lat: 45.1, lon: -122.1),
    TraceCardHop(id: '7A', snr: -4.75),
    TraceCardHop(
      id: '5B',
      name: 'Pass',
      snr: 2,
      lat: 45.2,
      lon: -122.0,
      positionGuessed: true,
    ),
  ],
);

void main() {
  setUpAll(initializeDateFormatting);

  test('route starts and ends at the sender, skipping unplaced hops', () {
    final points = _card().routePoints;
    expect(points, hasLength(4));
    expect(points.first, (lat: 45.0, lon: -122.0));
    expect(points.last, points.first);
    expect(points[1], (lat: 45.1, lon: -122.1));
  });

  test('no route without two distinct places', () {
    final lone = TraceCard(
      sender: 'Base',
      sentAt: DateTime(2026),
      roundTrip: Duration.zero,
      senderLat: 45,
      senderLon: -122,
      hops: const [TraceCardHop(id: '3D')],
    );
    expect(lone.routePoints, isEmpty);
    expect(lone.routeMeters, 0);
  });

  test('weakest link includes the return leg', () {
    expect(_card().weakestSnr, -4.75);
    final card = TraceCard(
      sender: 'A',
      sentAt: DateTime(2026),
      roundTrip: Duration.zero,
      returnSnr: -9,
      hops: const [TraceCardHop(id: '01', snr: 3)],
    );
    expect(card.weakestSnr, -9);
  });

  test('route length is the sum of its legs', () {
    final m = _card().routeMeters;
    final legs =
        haversineMeters(45, -122, 45.1, -122.1) +
        haversineMeters(45.1, -122.1, 45.2, -122) +
        haversineMeters(45.2, -122, 45, -122);
    expect(m, closeTo(legs, 0.001));
    expect(haversineMeters(0, 0, 0, 1), closeTo(111195, 5));
  });

  test('projection keeps every point inside the padded box', () {
    final xy = projectRoute(
      _card().routePoints,
      width: 320,
      height: 180,
      padding: 10,
    );
    for (final p in xy) {
      expect(p.x, inInclusiveRange(10, 310));
      expect(p.y, inInclusiveRange(10, 170));
    }
    // North is up: the northernmost point has the smallest y.
    expect(xy[2].y, lessThan(xy[0].y));
  });

  test('text card lists every hop and the way back', () async {
    final l10n = lookupAppLocalizations(const Locale('en'));
    final text = traceCardText(l10n, _card(), imperial: false, locale: 'en');
    expect(text, contains('From Base'));
    expect(text, contains('To Ridge'));
    expect(text, contains('Round trip 2.4 s'));
    expect(text, contains('Hops: 3'));
    expect(text, contains('1. Tower [3D] · 9.5 dB'));
    expect(text, contains('2. 7A [7A] · -4.8 dB'));
    expect(text, contains('Back to you · 6.3 dB'));
    expect(text, contains('Weakest link -4.8 dB'));
    expect(text, contains(' km'));
    expect(
      traceCardText(l10n, _card(), imperial: true, locale: 'en'),
      contains(' mi'),
    );
  });

  testWidgets('card shows hops, a labelled map and share buttons', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: TraceCardScreen(card: _card()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('From Base'), findsOneWidget);
    expect(find.text('Tower'), findsOneWidget);
    expect(find.text('5B · estimated position'), findsOneWidget);
    expect(find.text('Back to you'), findsOneWidget);
    expect(find.bySemanticsLabel('Map of the round trip'), findsOneWidget);
    expect(find.text('Share image'), findsOneWidget);
    expect(find.text('Share text'), findsOneWidget);
    handle.dispose();
  });

  testWidgets('card without positions says there is no map', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            child: TraceCardView(
              card: TraceCard(
                sender: 'Base',
                sentAt: DateTime(2026),
                roundTrip: Duration.zero,
                hops: const [TraceCardHop(id: '3D')],
              ),
              imperial: false,
            ),
          ),
        ),
      ),
    );
    expect(find.textContaining('No positions known'), findsOneWidget);
  });
}
