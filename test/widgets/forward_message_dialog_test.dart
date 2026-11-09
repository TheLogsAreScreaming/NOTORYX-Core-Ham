import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/forwarded_message.dart';
import 'package:meshcore_open/models/operator_profile.dart';
import 'package:meshcore_open/services/operator_profile_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:meshcore_open/widgets/forward_message_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _w1aw = Contact(
  publicKey: Uint8List.fromList(List.filled(32, 1)),
  name: 'W1AW Base',
  type: advTypeChat,
  pathLength: -1,
  path: Uint8List(0),
  lastSeen: DateTime(2026),
);

class _Radio extends MeshCoreConnector {
  final sent = <String>[];
  @override
  bool get isConnected => true;
  @override
  List<Contact> get contacts => [_w1aw];
  @override
  Future<void> sendMessage(
    Contact contact,
    String text, {
    String? originalText,
    String? translatedLanguageCode,
    String? translationModelId,
  }) async => sent.add('${contact.name}|$text');
}

void main() {
  test('the forwarded text names the sender and the writer', () {
    expect(
      forwardedText(callsign: 'kd2abc', from: ' N0RPT ', body: ' hello '),
      'FWD de KD2ABC from N0RPT: hello',
    );
  });

  Future<_Radio> open(WidgetTester tester, {String? callsign}) async {
    tester.view.physicalSize = const Size(1000, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    final radio = _Radio();
    final profile = OperatorProfileService()..load();
    if (callsign != null) {
      await profile.save(OperatorProfile(callsign: callsign));
    }
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MeshCoreConnector>.value(value: radio),
          ChangeNotifierProvider.value(value: profile),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => showForwardMessageDialog(
                  context,
                  from: 'N0RPT',
                  body: 'trail closed',
                ),
                child: const Text('go'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();
    return radio;
  }

  bool canSend(WidgetTester tester) =>
      tester
          .widget<FilledButton>(find.byKey(const ValueKey('forward-send')))
          .onPressed !=
      null;

  testWidgets('sends only after a destination is chosen', (tester) async {
    final radio = await open(tester, callsign: 'KD2ABC');
    expect(canSend(tester), false);
    await tester.tap(find.byKey(const ValueKey('forward-target')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('W1AW Base').last);
    await tester.pumpAndSettle();
    expect(radio.sent, isEmpty);
    await tester.tap(find.byKey(const ValueKey('forward-send')));
    await tester.pumpAndSettle();
    expect(radio.sent, ['W1AW Base|FWD de KD2ABC from N0RPT: trail closed']);
  });

  testWidgets('no call sign, no forwarding', (tester) async {
    await open(tester);
    await tester.tap(find.byKey(const ValueKey('forward-target')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('W1AW Base').last);
    await tester.pumpAndSettle();
    expect(find.textContaining('call sign under Licensed'), findsOneWidget);
    expect(canSend(tester), false);
  });
}
