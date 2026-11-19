// A node not heard for the "Mark nodes stale after" time says so in the
// contacts list, in words and with an icon.
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    show FlutterLocalNotificationsPlatform;
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/screens/contacts_screen.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/services/ui_view_state_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:meshcore_open/theme/mesh_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Notifications extends FlutterLocalNotificationsPlatform {
  @override
  Future<void> cancel({required int id}) async {}
}

class _Radio extends MeshCoreConnector {
  final known = <Contact>[];

  @override
  bool get isConnected => true;
  @override
  bool get isLoadingContacts => false;
  @override
  bool get hasLoadedContacts => true;
  @override
  List<Contact> get contacts => known;
}

Contact _node(String name, int key, Duration ago, {int type = advTypeChat}) =>
    Contact(
      publicKey: Uint8List.fromList(List.filled(32, key)),
      name: name,
      type: type,
      pathLength: 1,
      path: Uint8List.fromList([key]),
      lastSeen: DateTime.now().subtract(ago),
    );

void main() {
  late _Radio radio;
  late UiViewStateService viewState;
  late AppSettingsService settings;

  setUp(() async {
    FlutterLocalNotificationsPlatform.instance = _Notifications();
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    radio = _Radio()
      ..known.addAll([
        _node('Fresh', 1, const Duration(hours: 2)),
        _node(
          'Ridge',
          2,
          const Duration(days: 3, hours: 1),
          type: advTypeRepeater,
        ),
      ]);
    viewState = UiViewStateService();
    settings = AppSettingsService();
  });

  tearDown(() {
    radio.dispose();
    viewState.dispose();
    settings.dispose();
    PrefsManager.reset();
  });

  Future<void> pumpList(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MeshCoreConnector>.value(value: radio),
          ChangeNotifierProvider<UiViewStateService>.value(value: viewState),
          ChangeNotifierProvider<AppSettingsService>.value(value: settings),
        ],
        child: MaterialApp(
          theme: MeshTheme.dark(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ContactsScreen(),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 400));
  }

  final staleIcon = find.byKey(const ValueKey('contact-stale-icon'));

  testWidgets('only the node unheard past 24 h is marked stale', (
    tester,
  ) async {
    await pumpList(tester);
    expect(find.textContaining('stale · 3 days ago'), findsOneWidget);
    expect(staleIcon, findsOneWidget);
  });

  testWidgets('nothing is marked when the setting is off', (tester) async {
    await settings.setStaleAfterHours(0);
    await pumpList(tester);
    expect(find.textContaining('stale'), findsNothing);
    expect(staleIcon, findsNothing);
  });

  testWidgets('a shorter threshold marks both', (tester) async {
    await settings.setStaleAfterHours(1);
    await pumpList(tester);
    expect(staleIcon, findsNWidgets(2));
  });
}
