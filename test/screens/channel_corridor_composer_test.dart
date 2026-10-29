import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/models/channel_message.dart';
import 'package:meshcore_open/models/flood_corridor.dart';
import 'package:meshcore_open/screens/channel_chat_screen.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/services/chat_text_scale_service.dart';
import 'package:meshcore_open/services/image_codec_service.dart';
import 'package:meshcore_open/services/received_image_store.dart';
import 'package:meshcore_open/services/translation_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeConnector extends MeshCoreConnector {
  _FakeConnector({required this.supported, this.hasPosition = true});

  final bool supported;
  final bool hasPosition;
  final List<String> plainSends = [];
  final List<(String, List<CorridorTriple>)> corridorSends = [];

  @override
  bool get isConnected => true;

  @override
  bool? get floodCorridorSupported => supported;

  @override
  String? get selfName => 'Me';

  @override
  double? get selfLatitude => hasPosition ? 49.25 : null;

  @override
  double? get selfLongitude => hasPosition ? -123.1 : null;

  @override
  List<ChannelMessage> getChannelMessages(Channel channel) => const [];

  @override
  Future<void> sendChannelMessage(
    Channel channel,
    String text, {
    String? originalText,
    String? translatedLanguageCode,
    String? translationModelId,
    bool sign = false,
  }) async => plainSends.add(text);

  @override
  Future<void> sendChannelMessageWithCorridor(
    Channel channel,
    String text,
    List<CorridorTriple> corridor, {
    String? originalText,
    String? translatedLanguageCode,
    String? translationModelId,
  }) async => corridorSends.add((text, corridor));
}

final _channel = Channel(index: 0, name: 'Public', psk: Uint8List(16));

Widget _app(MeshCoreConnector connector) {
  final settings = AppSettingsService();
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<MeshCoreConnector>.value(value: connector),
      ChangeNotifierProvider.value(value: settings),
      ChangeNotifierProvider(create: (_) => ChatTextScaleService()),
      ChangeNotifierProvider(create: (_) => TranslationService(settings)),
      ChangeNotifierProvider(create: (_) => ImageCodecService(settings)),
      ChangeNotifierProvider(create: (_) => ReceivedImageStore()),
    ],
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ChannelChatScreen(channel: _channel),
    ),
  );
}

// The chat screen keeps periodic timers alive, so step time explicitly.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

Future<void> _type(WidgetTester tester, String text) async {
  await tester.enterText(find.byType(TextField).last, text);
  await tester.pump();
}

Future<void> _pickRadius(WidgetTester tester, String label) async {
  await tester.tap(find.byIcon(Icons.add_circle_outline));
  await _settle(tester);
  await tester.tap(find.text('Limit to an area'));
  await _settle(tester);
  await tester.tap(find.text(label));
  await _settle(tester);
}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    final tmp = Directory.systemTemp.createTempSync('chat').path;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (call) async => tmp,
        );
  });

  testWidgets('limits messages to the chosen area until cleared', (
    tester,
  ) async {
    final connector = _FakeConnector(supported: true);
    await tester.pumpWidget(_app(connector));
    await _settle(tester);

    await _pickRadius(tester, '12 km of you');
    expect(find.text('Only within 12 km of you'), findsOneWidget);

    await _type(tester, 'local only');
    await tester.tap(find.byIcon(Icons.send));
    await _settle(tester);
    expect(connector.plainSends, isEmpty);
    expect(connector.corridorSends, hasLength(1));
    final (text, corridor) = connector.corridorSends.single;
    expect(text, 'local only');
    expect(corridor.single.radiusKm, 12);
    expect(corridor.single.lat, 49.25);

    await tester.tap(find.byTooltip('Clear'));
    await _settle(tester);
    expect(find.text('Only within 12 km of you'), findsNothing);

    // The send cooldown reads the wall clock, which pump() doesn't advance.
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 1100)),
    );
    await _type(tester, 'everywhere');
    await tester.tap(find.byIcon(Icons.send));
    await _settle(tester);
    expect(connector.plainSends, ['everywhere']);
  });

  testWidgets('hides the option on stock firmware', (tester) async {
    await tester.pumpWidget(_app(_FakeConnector(supported: false)));
    await _settle(tester);
    await tester.tap(find.byIcon(Icons.add_circle_outline));
    await _settle(tester);
    expect(find.text('Limit to an area'), findsNothing);
  });

  testWidgets('asks for a position before limiting', (tester) async {
    final connector = _FakeConnector(supported: true, hasPosition: false);
    await tester.pumpWidget(_app(connector));
    await _settle(tester);
    await tester.tap(find.byIcon(Icons.add_circle_outline));
    await _settle(tester);
    await tester.tap(find.text('Limit to an area'));
    await _settle(tester);
    expect(
      find.text("Set your radio's position to limit messages to an area."),
      findsOneWidget,
    );
    expect(find.text('Only send within…'), findsNothing);
  });
}
