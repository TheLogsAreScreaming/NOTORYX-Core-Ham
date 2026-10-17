import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/message.dart';
import 'package:meshcore_open/services/field_ops_service.dart';
import 'package:meshcore_open/widgets/quick_trip_setup.dart';
import 'package:meshcore_open/widgets/sos_panel.dart';

class _Radio extends MeshCoreConnector {
  bool connected = true;
  final stream = StreamController<Message>.broadcast();
  final sent = <Message>[];
  final sam = Contact(
    publicKey: Uint8List.fromList(List.filled(32, 7)),
    name: 'Sam',
    type: advTypeChat,
    pathLength: -1,
    path: Uint8List(0),
    lastSeen: DateTime.now(),
  );
  @override
  bool get isConnected => connected;
  @override
  bool get isLoadingContacts => false;
  @override
  List<Contact> get contacts => [sam];
  @override
  List<Channel> get channels => const [];
  @override
  Stream<Message> get receivedDirectMessages => stream.stream;
  @override
  List<Message> getMessages(Contact c) => sent;
  @override
  Future<void> sendMessage(
    Contact contact,
    String text, {
    String? originalText,
    String? translatedLanguageCode,
    String? translationModelId,
  }) async {
    sent.add(
      Message(
        senderKey: contact.publicKey,
        text: text,
        timestamp: DateTime.now(),
        isOutgoing: true,
        status: MessageStatus.pending,
      ),
    );
  }
}

void main() {
  late _Radio radio;
  late FieldOpsService ops;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    radio = _Radio();
    ops = FieldOpsService(radio);
    await ops.load();
  });

  test('only a missing radio or loading truly blocks', () {
    expect(hardBlockReason(ops), isNull);
    expect(hasCheckInContacts(ops), isFalse);
    expect(hasSosTarget(ops), isFalse);
    radio.connected = false;
    expect(hardBlockReason(ops), 'Connect your radio first.');
  });

  testWidgets('a first SOS asks who gets it, then sends', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MeshCoreConnector>.value(value: radio),
          ChangeNotifierProvider<FieldOpsService>.value(value: ops),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: SosPanel()),
        ),
      ),
    );
    expect(find.textContaining("You'll choose who gets it"), findsOneWidget);

    final hold = await tester.startGesture(
      tester.getCenter(find.byKey(const ValueKey('sos-hold'))),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 2100));
    await hold.up();
    await tester.pumpAndSettle();
    expect(find.text('Who should get your SOS?'), findsOneWidget);

    await tester.tap(find.text('Sam'));
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('quick-trip-save')));
    for (var i = 0; i < 4; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 20)),
      );
      await tester.pump();
    }
    expect(ops.trip.members, [radio.sam.publicKeyHex]);
    expect(radio.sent.single.text, startsWith('[Bastion SOS]'));
    expect(ops.sos.active, isTrue);
    ops.dispose();
    await radio.stream.close();
  });
}
