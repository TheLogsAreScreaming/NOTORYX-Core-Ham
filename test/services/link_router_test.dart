import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/services/link_router.dart';

void main() {
  late StreamController<Uri> links;
  late LinkRouter router;
  late MeshCoreConnector radio;
  final key = GlobalKey<NavigatorState>();

  Future<void> pump(WidgetTester tester) async {
    links = StreamController<Uri>();
    radio = MeshCoreConnector();
    router = LinkRouter(key, radio, links: () => links.stream)..start();
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: key,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: SizedBox()),
      ),
    );
  }

  tearDown(() {
    router.dispose();
    links.close();
    radio.dispose();
  });

  testWidgets('a contact link opens its preview card', (tester) async {
    await pump(tester);
    links.add(
      Uri.parse(
        'meshcore://contact/add?name=Ridge%20Camp&public_key=${'ab' * 32}&type=1',
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('link-contact')), findsOneWidget);
    expect(find.text('Ridge Camp'), findsOneWidget);
    expect(find.byKey(const ValueKey('contact-link-card')), findsOneWidget);
  });

  testWidgets('an advert link asks before adding, and needs a radio', (
    tester,
  ) async {
    await pump(tester);
    links.add(Uri.parse('meshcore://${'ab' * 110}'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('link-advert')), findsOneWidget);
    expect(find.textContaining('Connect your radio first'), findsOneWidget);
    final add = tester.widget<FilledButton>(
      find.byKey(const ValueKey('link-advert-add')),
    );
    expect(add.onPressed, isNull);
  });

  testWidgets('other links are ignored or explained', (tester) async {
    await pump(tester);
    links.add(Uri.parse('https://example.com'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    links.add(Uri.parse('meshcore://nothing-here'));
    await tester.pumpAndSettle();
    expect(find.textContaining("isn't a MeshCore contact"), findsOneWidget);
  });
}
