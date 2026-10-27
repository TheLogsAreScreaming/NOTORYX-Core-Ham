import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/screens/contacts_screen.dart';
import 'package:meshcore_open/services/ui_view_state_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:meshcore_open/theme/mesh_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Radio extends MeshCoreConnector {
  final frames = <Uint8List>[];
  final known = <Contact>[];
  final responses = StreamController<Uint8List>.broadcast();
  Completer<void>? acknowledgement;
  int refreshes = 0;
  String selfKey = '';
  bool connected = true;

  @override
  bool get isConnected => connected;
  @override
  String get selfPublicKeyHex => selfKey;
  @override
  bool get isLoadingContacts => false;
  @override
  List<Contact> get contacts => known;
  @override
  Stream<Uint8List> get receivedFrames => responses.stream;
  @override
  Future<void> sendFrame(
    Uint8List frame, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async {
    frames.add(frame);
    if (waitForGenericAck) await acknowledgement?.future;
  }

  @override
  Future<void> refreshContacts() async => refreshes++;
}

void main() {
  late _Radio radio;
  late UiViewStateService viewState;
  const key =
      '9cd8fcf22a47333b591d96a2b848b73f457b1bb1a3ea2453a885f9e5787765b1';
  const link =
      'meshcore://contact/add?name=Ridge+Repeater&public_key=$key&type=2';

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    radio = _Radio();
    viewState = UiViewStateService();
  });

  tearDown(() async {
    await radio.responses.close();
    radio.dispose();
    viewState.dispose();
  });

  Future<void> paste(WidgetTester tester, String text) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MeshCoreConnector>.value(value: radio),
          ChangeNotifierProvider<UiViewStateService>.value(value: viewState),
        ],
        child: MaterialApp(
          theme: MeshTheme.dark(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ContactsScreen(),
        ),
      ),
    );
    await Clipboard.setData(ClipboardData(text: text));
    await tester.tap(find.byTooltip('More options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Contact from Clipboard'));
    await tester.pumpAndSettle();
  }

  testWidgets(
    'standard link previews and waits for acknowledgement before success',
    (tester) async {
      radio.acknowledgement = Completer<void>();
      await paste(tester, link);
      expect(find.text('Ridge Repeater'), findsOneWidget);
      expect(radio.frames, isEmpty);
      await tester.tap(find.text('Add contact'));
      await tester.pump();
      expect(radio.frames.single[0], cmdAddUpdateContact);
      expect(radio.frames.single.sublist(1, 33), hex2Uint8List(key));
      expect(radio.frames.single[33], advTypeRepeater);
      expect(radio.frames.single[35], 0xFF);
      expect(find.text('Adding…'), findsOneWidget);
      expect(radio.refreshes, 0);
      radio.acknowledgement!.complete();
      await tester.pumpAndSettle();
      expect(radio.refreshes, 1);
      expect(find.text('Added Ridge Repeater.'), findsOneWidget);
      expect(find.text('Add contact'), findsNothing);
    },
  );

  testWidgets('failed add stays retryable and never reports success', (
    tester,
  ) async {
    radio.acknowledgement = Completer<void>();
    await paste(tester, link);
    await tester.tap(find.text('Add contact'));
    await tester.pump();
    radio.acknowledgement!.completeError(StateError('Radio rejected contact'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Could not add Ridge Repeater'), findsOneWidget);
    expect(find.text('Add contact'), findsOneWidget);
    expect(radio.refreshes, 0);
  });

  testWidgets('existing contact is not overwritten', (tester) async {
    radio.known.add(
      Contact(
        publicKey: hex2Uint8List(key),
        name: 'Saved name',
        type: advTypeRepeater,
        pathLength: 1,
        path: Uint8List.fromList([7]),
        lastSeen: DateTime.now(),
      ),
    );
    await paste(tester, link);
    expect(find.text('Already in your contacts.'), findsOneWidget);
    expect(find.text('Add contact'), findsNothing);
    expect(radio.frames, isEmpty);
    expect(radio.known.single.path, [7]);
  });

  testWidgets('local identity cannot be added', (tester) async {
    radio.selfKey = key;
    await paste(tester, link);
    expect(find.text('This is you.'), findsOneWidget);
    expect(find.text('Add contact'), findsNothing);
    expect(radio.frames, isEmpty);
  });

  testWidgets('disconnect disables the preview add action', (tester) async {
    await paste(tester, link);
    radio.connected = false;
    radio.notifyListeners();
    await tester.pumpAndSettle();
    expect(radio.frames, isEmpty);
    // The screen may navigate away on disconnect; any surviving preview
    // must not offer an enabled radio operation.
    for (final button in tester.widgetList<FilledButton>(
      find.byType(FilledButton),
    )) {
      expect(button.onPressed, isNull);
    }
  });

  testWidgets('closing the preview sends nothing', (tester) async {
    await paste(tester, link);
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(radio.frames, isEmpty);
  });

  testWidgets('legacy advertisement still uses import command', (tester) async {
    await paste(tester, 'meshcore://${'ab' * 98}');
    expect(radio.frames.single, [cmdImportContact, ...List.filled(98, 0xAB)]);
    expect(find.byType(AlertDialog), findsNothing);
  });

  for (final text in [
    '$link&type=1',
    '$link&name=%FF',
    'meshcore://ab',
    'meshcore://${'ab' * maxFrameSize}',
    'meshcore://${'a' * 197}',
  ]) {
    testWidgets('rejects malformed clipboard data: $text', (tester) async {
      await paste(tester, text);
      expect(radio.frames, isEmpty);
      expect(find.byType(AlertDialog), findsNothing);
    });
  }
}
