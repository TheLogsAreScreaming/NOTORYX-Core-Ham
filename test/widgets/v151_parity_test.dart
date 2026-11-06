import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/message.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:meshcore_open/widgets/add_first_banner.dart';
import 'package:meshcore_open/widgets/quick_messages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Radio extends MeshCoreConnector {
  final sent = <Uint8List>[];
  @override
  bool get isConnected => true;
  @override
  Future<void> sendFrame(
    Uint8List data, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async => sent.add(data);
}

Contact _contact({int pathLength = -1, double? lat, double? lon}) => Contact(
  publicKey: Uint8List.fromList(List.filled(32, 7)),
  name: 'Sam',
  type: advTypeChat,
  pathLength: pathLength,
  path: Uint8List(0),
  lastSeen: DateTime.now(),
  latitude: lat,
  longitude: lon,
);

Message _message({bool outgoing = true, MessageStatus? status}) => Message(
  senderKey: Uint8List.fromList(List.filled(32, 7)),
  text: 'Hi',
  timestamp: DateTime.now(),
  isOutgoing: outgoing,
  status: status ?? MessageStatus.pending,
);

Widget _app(Widget child) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(body: child),
);

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
  });
  tearDown(PrefsManager.reset);

  // CMD_ADD_UPDATE_CONTACT: [cmd][key x32][type][flags][path len][path x64]
  // [name x32][last advert time x4][lat x4][lon x4].
  const advertTimeAt = 1 + 32 + 1 + 1 + 1 + 64 + 32;

  test(
    'forgetting the last advert clears its time and keeps the contact',
    () async {
      final radio = _Radio();
      await radio.forgetLastAdvert(_contact(lat: 41.5, lon: -73.25));
      final f = radio.sent.single;
      expect(f[0], cmdAddUpdateContact);
      expect(f[1 + 32], advTypeChat);
      expect(f[1 + 32 + 2], 0xFF); // flood route kept
      expect(f.sublist(advertTimeAt, advertTimeAt + 4), [0, 0, 0, 0]);
      final d = ByteData.sublistView(f);
      expect(d.getInt32(advertTimeAt + 4, Endian.little), 41500000);
      expect(d.getInt32(advertTimeAt + 8, Endian.little), -73250000);
      radio.dispose();
    },
  );

  test('a normal contact update still stamps the current time', () {
    final f = buildUpdateContactPathFrame(Uint8List(32), Uint8List(0), 0xFF);
    final t = ByteData.sublistView(f).getUint32(advertTimeAt, Endian.little);
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    expect((now - t).abs(), lessThan(5));
  });

  test('stopping retries marks a pending message failed', () {
    final radio = _Radio();
    final m = _message();
    radio.debugAddMessage(m);
    radio.stopRetrying(m);
    expect(radio.getMessages(_contact()).single.status, MessageStatus.failed);
    // A delivered message is left alone.
    final done = _message(status: MessageStatus.delivered);
    radio.debugAddMessage(done);
    radio.stopRetrying(done);
    expect(radio.getMessages(_contact()).last.status, MessageStatus.delivered);
    radio.dispose();
  });

  testWidgets('quick messages: defaults, pick, add, remove and reset', (
    tester,
  ) async {
    String? picked;
    await tester.pumpWidget(
      _app(
        Builder(
          builder: (context) => TextButton(
            onPressed: () async => picked = await pickQuickMessage(context),
            child: const Text('open'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.text('On my way'), findsOneWidget);
    await tester.tap(find.text('On my way'));
    await tester.pumpAndSettle();
    expect(picked, 'On my way');
    expect(savedQuickMessages(), isNull);

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('quick-edit')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('quick-add-field')),
      'Back at the truck',
    );
    await tester.tap(find.byKey(const ValueKey('quick-add')));
    await tester.pumpAndSettle();
    expect(savedQuickMessages(), contains('Back at the truck'));
    expect(savedQuickMessages(), hasLength(7));
    await tester.tap(find.byTooltip('Remove').first);
    await tester.pumpAndSettle();
    expect(savedQuickMessages(), isNot(contains('OK')));
    await tester.tap(find.text('Reset to the defaults'));
    await tester.pumpAndSettle();
    expect(savedQuickMessages(), isNull);
  });

  testWidgets('the add-you-first note shows until they reply or you hide it', (
    tester,
  ) async {
    final contact = _contact();
    await tester.pumpWidget(
      _app(AddFirstBanner(contact: contact, messages: [_message()])),
    );
    expect(find.byKey(const ValueKey('add-first-banner')), findsOneWidget);
    expect(find.textContaining('Sam can only read'), findsOneWidget);

    await tester.pumpWidget(
      _app(
        AddFirstBanner(
          contact: contact,
          messages: [_message(), _message(outgoing: false)],
        ),
      ),
    );
    expect(find.byKey(const ValueKey('add-first-banner')), findsNothing);

    await tester.pumpWidget(
      _app(AddFirstBanner(contact: contact, messages: const [])),
    );
    await tester.tap(find.byTooltip('Hide'));
    await tester.pump();
    expect(find.byKey(const ValueKey('add-first-banner')), findsNothing);
    await tester.pumpWidget(const SizedBox());
    await tester.pumpWidget(
      _app(AddFirstBanner(contact: contact, messages: const [])),
    );
    expect(find.byKey(const ValueKey('add-first-banner')), findsNothing);
  });
}
