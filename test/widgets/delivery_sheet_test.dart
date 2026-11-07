import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/message.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:meshcore_open/widgets/delivery_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sam = Contact(
  publicKey: Uint8List.fromList(List.filled(32, 7)),
  name: 'Sam',
  type: advTypeChat,
  pathLength: 2,
  path: Uint8List(0),
  lastSeen: DateTime.now().subtract(const Duration(minutes: 3)),
);

Message message(MessageStatus status, {int retries = 0, int path = 2}) =>
    Message(
      senderKey: Uint8List(32),
      text: 'At camp',
      timestamp: DateTime(2026, 11, 7, 9, 30),
      isOutgoing: true,
      status: status,
      retryCount: retries,
      sentAt: DateTime(2026, 11, 7, 9, 30, 2),
      deliveredAt: status == MessageStatus.delivered
          ? DateTime(2026, 11, 7, 9, 30, 6)
          : null,
      tripTimeMs: status == MessageStatus.delivered ? 3400 : null,
      pathLength: path,
      pathBytes: path < 0 ? Uint8List(0) : Uint8List.fromList([0xA1, 0x3F]),
    );

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
  });

  Future<void> open(
    WidgetTester tester,
    Message m, {
    VoidCallback? onRetry,
  }) async {
    await tester.binding.setSurfaceSize(const Size(400, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      ChangeNotifierProvider<AppSettingsService>.value(
        value: AppSettingsService(),
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () => showDeliverySheet(
                  context,
                  message: m,
                  contact: sam,
                  onRetry: onRetry,
                ),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  testWidgets('delivered shows route, round trip and verdict', (tester) async {
    await open(tester, message(MessageStatus.delivered));
    expect(find.text('Delivered. Sam confirmed it.'), findsOneWidget);
    expect(find.text('Direct via A1 → 3F'), findsOneWidget);
    expect(find.text('Round trip 3.4 s'), findsOneWidget);
    expect(find.text('1 of 7'), findsOneWidget);
    expect(find.text('Plan: 5 direct, then 2 flood'), findsOneWidget);
    expect(find.byKey(const ValueKey('delivery-retry')), findsNothing);
  });

  testWidgets('failed after every route offers retry', (tester) async {
    var retried = 0;
    await open(
      tester,
      message(MessageStatus.failed, retries: 6, path: -1),
      onRetry: () => retried++,
    );
    expect(
      find.textContaining('No confirmation from any route'),
      findsOneWidget,
    );
    expect(find.text('Flood, through every repeater'), findsOneWidget);
    expect(find.text('7 of 7'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('delivery-retry')));
    await tester.pumpAndSettle();
    expect(retried, 1);
    expect(find.byKey(const ValueKey('delivery-sheet')), findsNothing);
  });

  testWidgets('pending says which attempt it is on', (tester) async {
    await open(tester, message(MessageStatus.sent, retries: 1));
    expect(find.text('Still trying: attempt 2 of 7.'), findsOneWidget);
    expect(find.text('Waiting for confirmation'), findsOneWidget);
  });
}
