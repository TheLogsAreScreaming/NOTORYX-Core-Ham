import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/message.dart';
import 'package:meshcore_open/screens/bastion_setup_screen.dart';
import 'package:meshcore_open/services/operator_profile_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Radio extends MeshCoreConnector {
  bool connected = false;
  final people = <Contact>[];
  final messages = <Message>[];
  @override
  bool get isConnected => connected;
  @override
  bool get isLoadingContacts => false;
  @override
  List<Contact> get contacts => people;
  @override
  String get deviceDisplayName => 'Test radio';
  @override
  List<Message> getMessages(Contact contact) => messages;
  void changed() => notifyListeners();
}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
  });

  testWidgets('disconnected guide explains connection and disables test chat', (
    tester,
  ) async {
    final radio = _Radio();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MeshCoreConnector>.value(value: radio),
          ChangeNotifierProvider(
            create: (_) => OperatorProfileService()..load(),
          ),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BastionSetupScreen(),
        ),
      ),
    );
    expect(find.text('No radio connected yet.'), findsOneWidget);
    expect(find.text('Before you transmit'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('setup-coordination-guide')),
      findsOneWidget,
    );
    expect(
      find.text('Set your call sign and read the coordination guide'),
      findsOneWidget,
    );
    await tester.scrollUntilVisible(find.text('Open test chat'), 200);
    final button = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Open test chat'),
    );
    expect(button.onPressed, isNull);
    await tester.pumpWidget(const SizedBox());
    radio.dispose();
  });

  testWidgets('session status excludes old and incoming messages', (
    tester,
  ) async {
    final radio = _Radio()..connected = true;
    final contact = Contact(
      publicKey: Uint8List.fromList(List.filled(32, 7)),
      name: 'Trail partner',
      type: advTypeChat,
      pathLength: -1,
      path: Uint8List(0),
      lastSeen: DateTime.now(),
    );
    radio.people.add(contact);
    radio.messages.add(
      Message(
        senderKey: contact.publicKey,
        text: 'Earlier test',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isOutgoing: true,
        status: MessageStatus.delivered,
      ),
    );
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MeshCoreConnector>.value(value: radio),
          ChangeNotifierProvider(
            create: (_) => OperatorProfileService()..load(),
          ),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BastionSetupScreen(),
        ),
      ),
    );
    await tester.scrollUntilVisible(
      find.byType(DropdownButtonFormField<String>),
      200,
    );
    await tester.ensureVisible(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Trail partner').last);
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Open test chat'), 200);
    expect(
      find.text('No outgoing test message recorded in this guide session.'),
      findsOneWidget,
    );
    radio.messages.add(
      Message(
        senderKey: contact.publicKey,
        text: 'Received reply',
        timestamp: DateTime.now(),
        isOutgoing: false,
        status: MessageStatus.delivered,
      ),
    );
    radio.changed();
    await tester.pumpAndSettle();
    expect(
      find.text('No outgoing test message recorded in this guide session.'),
      findsOneWidget,
    );
    radio.messages.add(
      Message(
        senderKey: contact.publicKey,
        text: 'New test',
        timestamp: DateTime.now(),
        isOutgoing: true,
        status: MessageStatus.sent,
      ),
    );
    radio.changed();
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.textContaining('Latest message: Sent'),
      100,
    );
    expect(find.textContaining('Latest message: Sent'), findsOneWidget);
    expect(find.textContaining('No delivery acknowledgment'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    radio.dispose();
  });
}
