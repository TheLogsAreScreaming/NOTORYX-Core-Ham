import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/radio_rx_packet.dart';
import 'package:meshcore_open/screens/rx_log_screen.dart';
import 'package:meshcore_open/services/rx_log_service.dart';
import 'package:provider/provider.dart';

RadioRxPacket _packet(
  int payloadType, {
  List<int> path = const [],
  String? station,
}) => RadioRxPacket(
  station: station,
  raw: Uint8List.fromList([
    (payloadType << 2) | 1,
    path.length,
    ...path,
    0xCA,
    0xFE,
  ]),
  snr: 7.5,
  rssi: -88,
  receivedAt: DateTime(2026, 11, 7, 9, 30, 5),
);

void main() {
  late StreamController<RadioRxPacket> packets;
  late RxLogService log;

  setUp(() {
    packets = StreamController<RadioRxPacket>.broadcast();
    log = RxLogService(packets.stream);
  });
  tearDown(() {
    log.dispose();
    unawaited(packets.close());
  });

  Future<void> show(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      ChangeNotifierProvider<RxLogService>.value(
        value: log,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: RxLogScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('empty log explains itself', (tester) async {
    await show(tester);
    expect(find.textContaining('No packets yet'), findsOneWidget);
    expect(find.textContaining('Nothing is saved or sent'), findsOneWidget);
  });

  testWidgets('packets appear live and filter by kind', (tester) async {
    await show(tester);
    log
      ..add(_packet(payloadTypeADVERT, path: [0xA1, 0x3F]))
      ..add(_packet(payloadTypeGRPTXT))
      ..add(_packet(payloadTypeGRPTXT));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('All · 3'), findsOneWidget);
    expect(find.text('Adverts · 1'), findsOneWidget);
    expect(find.text('Channel · 2'), findsOneWidget);
    expect(find.text('3 shown · 3 heard'), findsOneWidget);
    expect(find.text('Flood · 2 hops · 6 bytes'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('rx-kind-advert')));
    await tester.pumpAndSettle();
    expect(find.text('1 shown · 3 heard'), findsOneWidget);
    expect(find.text('Channel'), findsNothing);
  });

  testWidgets('tapping a packet shows its path and raw bytes', (tester) async {
    await show(tester);
    log.add(_packet(payloadTypeADVERT, path: [0xA1, 0x3F]));
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.text('Adverts'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('rx-packet-sheet')), findsOneWidget);
    expect(find.text('A1 → 3F'), findsOneWidget);
    expect(find.text('11 02 A1 3F CA FE'), findsOneWidget);
    expect(find.text('SNR 7.5 · -88 dBm'), findsWidgets);
  });

  testWidgets('each packet shows the call sign it was sent with', (
    tester,
  ) async {
    await show(tester);
    log.add(_packet(payloadTypeADVERT, path: [0xA1], station: 'N0RPT'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('ID N0RPT · Flood · 1 hop · 5 bytes'), findsOneWidget);

    await tester.tap(find.text('Adverts'));
    await tester.pumpAndSettle();
    expect(find.text('Station ID'), findsOneWidget);
    expect(find.text('N0RPT'), findsOneWidget);
  });

  testWidgets('pause stops logging and says so', (tester) async {
    await show(tester);
    await tester.tap(find.byKey(const ValueKey('rx-log-pause')));
    await tester.pump();
    expect(find.textContaining('Paused'), findsOneWidget);
    log.add(_packet(payloadTypeADVERT));
    await tester.pump(const Duration(milliseconds: 300));
    expect(log.entries, isEmpty);
  });
}
