import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/contact_table_health.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:meshcore_open/widgets/contact_table_banner.dart';
import 'package:shared_preferences/shared_preferences.dart';

Contact contact(int n, {int daysAgo = 0, bool favorite = false}) => Contact(
  publicKey: Uint8List.fromList(List.filled(32, n)),
  name: 'Node $n',
  type: advTypeChat,
  pathLength: 0,
  path: Uint8List(0),
  flags: favorite ? contactFlagFavorite : 0,
  lastSeen: DateTime.now().subtract(Duration(days: daysAgo)),
);

Future<void> pumpNotice(
  WidgetTester tester,
  ContactTableHealth health, {
  VoidCallback? onFreeUp,
}) => tester.pumpWidget(
  MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: ContactTableNotice(health: health, onFreeUp: onFreeUp ?? () {}),
    ),
  ),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ContactTableHealth', () {
    ContactTableHealth h(int used, int max) =>
        ContactTableHealth(used: used, max: max, overwriteOldest: false);

    test('below 90% is fine', () {
      expect(h(314, 350).level, ContactTableLevel.ok);
      expect(h(314, 350).needsAttention, isFalse);
    });

    test('90% and up is nearly full', () {
      expect(h(315, 350).level, ContactTableLevel.nearlyFull);
      expect(h(315, 350).percent, 90);
      expect(h(349, 350).level, ContactTableLevel.nearlyFull);
    });

    test('at the limit is full', () {
      expect(h(350, 350).level, ContactTableLevel.full);
      expect(h(351, 350).fraction, 1);
    });

    test('percent rounds down so 89.9% is not shown as 90%', () {
      expect(h(899, 1000).percent, 89);
    });

    test('an unknown limit never warns', () {
      expect(h(10, 0).level, ContactTableLevel.ok);
      expect(h(10, 0).fraction, 0);
    });
  });

  group('contactRemovalSuggestions', () {
    test('least recently heard first, favorites never suggested', () {
      final list = contactRemovalSuggestions([
        contact(1, daysAgo: 2),
        contact(2, daysAgo: 30, favorite: true),
        contact(3, daysAgo: 9),
        contact(4),
      ]);
      expect(list.map((c) => c.name), ['Node 3', 'Node 1', 'Node 4']);
    });

    test('all favorites gives nothing to suggest', () {
      expect(contactRemovalSuggestions([contact(1, favorite: true)]), isEmpty);
    });
  });

  group('contactTableHealthOf', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      PrefsManager.reset();
      await PrefsManager.initialize();
    });

    test('nothing while disconnected', () {
      final connector = MeshCoreConnector()
        ..debugSetContactTable(maxContacts: 10);
      expect(connector.maxContactsReported, isTrue);
      expect(contactTableHealthOf(connector), isNull);
    });

    test('the default limit is not treated as reported', () {
      expect(MeshCoreConnector().maxContactsReported, isFalse);
    });
  });

  group('ContactTableNotice', () {
    testWidgets('nearly full, radio replaces oldest', (tester) async {
      var tapped = false;
      await pumpNotice(
        tester,
        const ContactTableHealth(used: 322, max: 350, overwriteOldest: true),
        onFreeUp: () => tapped = true,
      );
      expect(find.text('Radio contact list 92% full'), findsOneWidget);
      expect(find.text('322 of 350 contacts'), findsOneWidget);
      expect(find.textContaining('replaces the contact heard'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('contact-table-free-up')));
      expect(tapped, isTrue);
    });

    testWidgets('full, radio stops adding', (tester) async {
      await pumpNotice(
        tester,
        const ContactTableHealth(used: 350, max: 350, overwriteOldest: false),
      );
      expect(find.text('Radio contact list is full'), findsOneWidget);
      expect(find.textContaining('stops adding new contacts'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });
  });
}
