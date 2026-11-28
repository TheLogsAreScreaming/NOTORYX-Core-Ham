import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/message.dart';
import 'package:meshcore_open/screens/station_log_screen.dart';
import 'package:meshcore_open/services/operator_profile_service.dart';
import 'package:meshcore_open/services/station_log_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:meshcore_open/theme/mesh_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Contact _contact(int seed, String name) => Contact(
  publicKey: Uint8List.fromList(List.filled(32, seed)),
  name: name,
  type: advTypeChat,
  pathLength: -1,
  path: Uint8List(0),
  lastSeen: DateTime.now(),
);

class _Radio extends MeshCoreConnector {
  final received = StreamController<Message>.broadcast();
  final sent = StreamController<Contact>.broadcast();
  final known = <Contact>[];

  @override
  Stream<Message> get receivedDirectMessages => received.stream;
  @override
  Stream<Contact> get sentDirectMessages => sent.stream;
  @override
  Contact? getContactByPubKeyHex(String hex) =>
      known.where((c) => c.publicKeyHex == hex).firstOrNull;
  @override
  int? get currentFreqHz => 906875;
}

Message _from(Contact c, {bool cli = false}) => Message(
  senderKey: c.publicKey,
  text: 'hi',
  timestamp: DateTime.now(),
  isOutgoing: false,
  isCli: cli,
);

void main() {
  late _Radio radio;
  var now = DateTime.utc(2026, 11, 8, 14);

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    radio = _Radio();
    now = DateTime.utc(2026, 11, 8, 14);
  });

  StationLogService service() =>
      StationLogService(radio, clock: () => now)..start();

  test(
    'logs messages with call-sign stations, both ways, and keeps them',
    () async {
      final w1aw = _contact(1, 'W1AW Base');
      final ridge = _contact(2, 'Ridge Repeater');
      radio.known.addAll([w1aw, ridge]);
      final log = service();

      radio.sent.add(w1aw);
      await pumpEventQueue();
      now = now.add(const Duration(minutes: 5));
      radio.received.add(_from(w1aw));
      radio.received.add(_from(w1aw, cli: true)); // repeater console: skipped
      radio.received.add(_from(ridge)); // no call sign: skipped
      radio.received.add(_from(_contact(3, 'N0RPT'))); // unknown contact
      await pumpEventQueue();

      expect(log.entries, hasLength(1));
      final e = log.entries.single;
      expect(e.call, 'W1AW');
      expect((e.sent, e.received), (1, 1));
      expect(e.freqKhz, 906875);
      log.dispose();

      // A new session reads the saved log back.
      final again = service();
      expect(again.entries.single.call, 'W1AW');
      await again.clear();
      expect(again.entries, isEmpty);
      expect(service().entries, isEmpty);
    },
  );

  test('an unreadable saved log is set aside, not lost', () async {
    SharedPreferences.setMockInitialValues({'ham_station_log': '{broken'});
    PrefsManager.reset();
    await PrefsManager.initialize();
    final log = service();
    expect(log.entries, isEmpty);
    await pumpEventQueue();
    expect(
      PrefsManager.instance.getString('ham_station_log_unreadable'),
      '{broken',
    );
  });

  testWidgets('the screen lists entries and clears after confirming', (
    tester,
  ) async {
    final w1aw = _contact(1, 'W1AW Base');
    radio.known.add(w1aw);
    final log = service();

    Widget app() => MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: log),
        ChangeNotifierProvider(create: (_) => OperatorProfileService()..load()),
      ],
      child: MaterialApp(
        theme: MeshTheme.dark(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const StationLogScreen(),
      ),
    );

    await tester.pumpWidget(app());
    expect(find.text('No stations logged yet'), findsOneWidget);
    expect(find.byKey(const ValueKey('station-log-menu')), findsNothing);

    await tester.runAsync(() async {
      radio.sent.add(w1aw);
      await pumpEventQueue();
    });
    await tester.pumpAndSettle();
    expect(find.text('W1AW'), findsOneWidget);
    expect(find.textContaining('33cm'), findsOneWidget);
    expect(find.textContaining('1 sent, 0 received'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('station-log-menu')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Clear the log'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    expect(find.text('No stations logged yet'), findsOneWidget);
    log.dispose();
  });
}
