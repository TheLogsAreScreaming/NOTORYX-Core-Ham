import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/models/channel_message.dart';
import 'package:meshcore_open/screens/channel_chat_screen.dart';
import 'package:meshcore_open/screens/channel_message_path_screen.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/services/chat_text_scale_service.dart';
import 'package:meshcore_open/services/image_codec_service.dart';
import 'package:meshcore_open/services/received_image_store.dart';
import 'package:meshcore_open/services/translation_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:meshcore_open/theme/mesh_theme.dart';
import 'package:meshcore_open/widgets/via_mqtt_label.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _channel = Channel(index: 0, name: 'Public', psk: Uint8List(16));

ChannelMessage _message(String text, {bool viaMqtt = false}) => ChannelMessage(
  senderName: 'Alice',
  text: text,
  timestamp: DateTime.now(),
  isOutgoing: false,
  status: ChannelMessageStatus.sent,
  pathLength: 2,
  pathBytes: Uint8List.fromList([0xAB, 0xCD]),
  channelIndex: 0,
  viaMqtt: viaMqtt,
);

class _FakeConnector extends MeshCoreConnector {
  _FakeConnector(this.messages);

  final List<ChannelMessage> messages;

  @override
  bool get isConnected => true;

  @override
  String? get selfName => 'Me';

  @override
  List<ChannelMessage> getChannelMessages(Channel channel) => messages;
}

Widget _app(MeshCoreConnector connector, ThemeData theme, Widget home) {
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
      theme: theme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: home,
    ),
  );
}

// The chat screen keeps periodic timers alive, so step time explicitly.
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

double _contrast(Color a, Color b) {
  final x = a.computeLuminance(), y = b.computeLuminance();
  return x > y ? (x + .05) / (y + .05) : (y + .05) / (x + .05);
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
  tearDown(() => MeshPalette.current = BastionTheme.fallback.palette);

  testWidgets('label has a cloud icon, text and a semantics label', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: ViaMqttLabel(color: Colors.grey)),
      ),
    );
    expect(find.text('via MQTT'), findsOneWidget);
    expect(find.byIcon(Icons.cloud_outlined), findsOneWidget);
    expect(
      find.bySemanticsLabel('Received via MQTT, not heard by your radio'),
      findsOneWidget,
    );
    handle.dispose();
  });

  for (final t in BastionTheme.values) {
    testWidgets('chat bubble shows a readable label in ${t.label}', (
      tester,
    ) async {
      MeshPalette.current = t.palette;
      final theme = MeshTheme.forPalette(t.palette);
      final connector = _FakeConnector([
        _message('heard on radio'),
        _message('heard on mqtt', viaMqtt: true),
      ]);
      await tester.pumpWidget(
        _app(connector, theme, ChannelChatScreen(channel: _channel)),
      );
      await _settle(tester);

      expect(find.text('heard on radio'), findsOneWidget);
      expect(find.text('heard on mqtt'), findsOneWidget);
      expect(find.byType(ViaMqttLabel), findsOneWidget);
      final text = tester.widget<Text>(
        find.descendant(
          of: find.byType(ViaMqttLabel),
          matching: find.text('via MQTT'),
        ),
      );
      final scheme = theme.colorScheme;
      expect(
        _contrast(text.style!.color!, scheme.surfaceContainerHigh),
        greaterThanOrEqualTo(4.5),
        reason: t.label,
      );
      await tester.pumpWidget(const SizedBox());
      await _settle(tester);
    });
  }

  testWidgets('packet path says a via-MQTT message has no RF path', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        _FakeConnector(const []),
        MeshTheme.forPalette(BastionTheme.fallback.palette),
        ChannelMessagePathScreen(
          message: _message('heard on mqtt', viaMqtt: true),
          channelMessage: true,
        ),
      ),
    );
    await tester.pump();
    expect(find.textContaining('arrived via MQTT'), findsOneWidget);
    expect(find.text('MQTT'), findsOneWidget);
    // The observer's hops are not presented as this radio's path.
    expect(find.textContaining('hops matched'), findsNothing);
  });
}
