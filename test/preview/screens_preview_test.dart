// Renders the main screens with fake data to PNGs for design review.
//
// Skipped unless PREVIEW_OUT is set:
//   PREVIEW_OUT=/some/dir flutter test test/preview
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/l10n/app_localizations.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/models/channel_message.dart';
import 'package:meshcore_open/models/contact.dart';
import 'package:meshcore_open/models/access_control.dart';
import 'package:meshcore_open/models/message.dart';
import 'package:meshcore_open/screens/access_control_screen.dart';
import 'package:meshcore_open/screens/channel_chat_screen.dart';
import 'package:meshcore_open/screens/channels_screen.dart';
import 'package:meshcore_open/screens/companion_cli_screen.dart';
import 'package:meshcore_open/screens/wifi_settings_screen.dart';
import 'package:meshcore_open/screens/chat_screen.dart';
import 'package:meshcore_open/screens/contacts_screen.dart';
import 'package:meshcore_open/screens/messages_screen.dart';
import 'package:meshcore_open/screens/settings_screen.dart';
import 'package:meshcore_open/services/access_control_service.dart';
import 'package:meshcore_open/services/app_debug_log_service.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/services/chat_text_scale_service.dart';
import 'package:meshcore_open/services/image_codec_service.dart';
import 'package:meshcore_open/services/map_tile_cache_service.dart';
import 'package:meshcore_open/services/message_retry_service.dart';
import 'package:meshcore_open/services/path_history_service.dart';
import 'package:meshcore_open/services/repeater_command_service.dart';
import 'package:meshcore_open/services/received_image_store.dart';
import 'package:meshcore_open/services/storage_service.dart';
import 'package:meshcore_open/services/translation_service.dart';
import 'package:meshcore_open/services/ui_view_state_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:meshcore_open/theme/mesh_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _now = DateTime(2026, 10, 14, 9, 30);

Uint8List _key(int seed) =>
    Uint8List.fromList(List.generate(32, (i) => (seed * 37 + i * 11) & 0xFF));

Contact _contact(
  int seed,
  String name,
  int type, {
  int hops = 1,
  int ago = 5,
}) => Contact(
  publicKey: _key(seed),
  name: name,
  type: type,
  pathLength: hops,
  path: Uint8List.fromList(List.generate(hops, (i) => seed + i)),
  latitude: 49.25 + seed / 100,
  longitude: -123.1 - seed / 100,
  lastSeen: _now.subtract(Duration(minutes: ago)),
);

final _contacts = [
  _contact(1, 'Ridge Camp', advTypeChat, ago: 2),
  _contact(2, 'Sam (trail crew)', advTypeChat, hops: 2, ago: 14),
  _contact(3, 'Hollyburn RPT', advTypeRepeater, hops: 0, ago: 1),
  _contact(4, 'Cypress Bowl RPT', advTypeRepeater, hops: 1, ago: 40),
  _contact(5, 'Basecamp Room', advTypeRoom, hops: 2, ago: 90),
  _contact(6, 'Weather Stn 3', advTypeSensor, hops: 3, ago: 300),
];

final _channels = [
  Channel(index: 0, name: 'Public', psk: Uint8List(16)),
  Channel(index: 1, name: '#backcountry', psk: Uint8List(16)),
  Channel(index: 2, name: '#sar-north', psk: Uint8List(16)),
];

List<ChannelMessage> _channelMessages(int index) => [
  ChannelMessage(
    senderName: 'Ridge Camp',
    text: 'Anyone near the north trailhead? Snow is starting.',
    timestamp: _now.subtract(const Duration(minutes: 22)),
    isOutgoing: false,
    channelIndex: index,
    pathLength: 2,
  ),
  ChannelMessage(
    senderName: 'Me',
    text: 'Copy, 20 min out. Repeater at Hollyburn is solid.',
    timestamp: _now.subtract(const Duration(minutes: 18)),
    isOutgoing: true,
    status: ChannelMessageStatus.sent,
    repeatCount: 3,
    channelIndex: index,
  ),
  ChannelMessage(
    senderName: 'Sam (trail crew)',
    text: 'Gate is open, road is icy past km 4 👍',
    timestamp: _now.subtract(const Duration(minutes: 5)),
    isOutgoing: false,
    channelIndex: index,
    pathLength: 1,
  ),
];

List<Message> _dmMessages(Contact c) => [
  Message(
    senderKey: c.publicKey,
    text: 'Made it to the hut. Battery at 60%.',
    timestamp: _now.subtract(const Duration(minutes: 30)),
    isOutgoing: false,
  ),
  Message(
    senderKey: c.publicKey,
    text: 'Great, check in again at 6?',
    timestamp: _now.subtract(const Duration(minutes: 28)),
    isOutgoing: true,
    status: MessageStatus.delivered,
  ),
  Message(
    senderKey: c.publicKey,
    text: 'Will do.',
    timestamp: _now.subtract(const Duration(minutes: 27)),
    isOutgoing: false,
  ),
];

class _PreviewConnector extends MeshCoreConnector {
  @override
  bool get isConnected => true;
  @override
  String? get selfName => 'Trail Lead';
  @override
  String get deviceDisplayName => 'Trail Lead';
  @override
  Uint8List? get selfPublicKey => _key(99);
  @override
  bool get hasLoadedContacts => true;
  @override
  bool get isLoadingContacts => false;
  @override
  bool get isLoadingChannels => false;
  @override
  int? get batteryPercent => 78;
  @override
  String? get firmwareVersionString => 'v1.9.1';
  @override
  int? get currentFreqHz => 910525000;
  @override
  int? get currentBwHz => 62500;
  @override
  int? get currentSf => 7;
  @override
  int? get currentCr => 5;
  @override
  int? get currentTxPower => 22;
  @override
  List<Contact> get contacts => _contacts;
  @override
  List<Contact> get allContactsUnfiltered => _contacts;
  @override
  List<Channel> get channels => _channels;
  @override
  List<ChannelMessage> getChannelMessages(Channel channel) =>
      _channelMessages(channel.index);
  @override
  List<Message> getMessages(Contact contact) => _dmMessages(contact);
  @override
  int getUnreadCountForChannelIndex(int index) => index == 1 ? 3 : 0;
  @override
  int getTotalChannelsUnreadCount() => 3;
  @override
  int getTotalContactsUnreadCount() => 1;
  @override
  Future<void> sendFrame(
    Uint8List frame, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async {}
}

class _PreviewAclService extends AccessControlService {
  _PreviewAclService(MeshCoreConnector c) : super(c, RepeaterCommandService(c));

  static AclEntry _e(Uint8List key, AclRole role) => AclEntry(
    keyPrefix: Uint8List.fromList(key.sublist(0, 6)),
    permissions: role.value,
  );

  @override
  Future<AccessListResult> fetch(Contact node) async => AccessListResult(
    complete: true,
    entries: [
      _e(_key(99), AclRole.admin),
      _e(_contacts[0].publicKey, AclRole.admin),
      _e(_contacts[1].publicKey, AclRole.readWrite),
      _e(_key(77), AclRole.readOnly),
    ],
  );
}

Future<void> _loadFonts() async {
  Future<void> load(String family, List<String> paths) async {
    final loader = FontLoader(family);
    for (final p in paths) {
      final bytes = File(p).readAsBytesSync();
      loader.addFont(Future.value(ByteData.view(bytes.buffer)));
    }
    await loader.load();
  }

  final sdk = Platform.environment['FLUTTER_ROOT']!;
  await load('Inter', ['assets/fonts/Inter.ttf']);
  await load('JetBrains Mono', ['assets/fonts/JetBrainsMono.ttf']);
  await load('MaterialIcons', [
    '$sdk/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
  ]);
  // material_symbols_icons ships its fonts inside the package.
  final pkgConfig = File('.dart_tool/package_config.json').readAsStringSync();
  final m = RegExp(
    r'"name":\s*"material_symbols_icons",\s*"rootUri":\s*"([^"]+)"',
  ).firstMatch(pkgConfig);
  if (m != null) {
    final root = Uri.parse(m.group(1)!).toFilePath();
    for (final style in ['Outlined', 'Rounded', 'Sharp']) {
      final f = '$root/lib/fonts/MaterialSymbols$style.ttf';
      if (File(f).existsSync()) {
        await load('packages/material_symbols_icons/MaterialSymbols$style', [
          f,
        ]);
      }
    }
  }
}

Widget _app(Widget home, ThemeMode mode) {
  final settings = AppSettingsService();
  final storage = StorageService();
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<MeshCoreConnector>(
        create: (_) => _PreviewConnector(),
      ),
      ChangeNotifierProvider.value(value: settings),
      ChangeNotifierProvider(create: (_) => MessageRetryService()),
      ChangeNotifierProvider(create: (_) => PathHistoryService(storage)),
      ChangeNotifierProvider(create: (_) => AppDebugLogService()),
      ChangeNotifierProvider(create: (_) => ChatTextScaleService()),
      ChangeNotifierProvider(create: (_) => TranslationService(settings)),
      ChangeNotifierProvider(create: (_) => UiViewStateService()),
      Provider.value(value: storage),
      ChangeNotifierProvider(
        create: (_) => MapTileCacheService(appSettingsService: settings),
      ),
      ChangeNotifierProvider(create: (_) => ImageCodecService(settings)),
      ChangeNotifierProvider(create: (_) => ReceivedImageStore()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MeshTheme.light(),
      darkTheme: MeshTheme.dark(),
      themeMode: mode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: home,
    ),
  );
}

void main() {
  final out = Platform.environment['PREVIEW_OUT'];
  final screens = <String, Widget Function()>{
    'messages': () => const MessagesScreen(),
    'contacts': () => const ContactsScreen(hideBackButton: true),
    'channels': () => const ChannelsScreen(),
    'channel_chat': () => ChannelChatScreen(channel: _channels[1]),
    'dm_chat': () => ChatScreen(contact: _contacts[0]),
    'radio': () => const SettingsScreen(asTab: true),
    'access_control': () => Builder(
      builder: (context) => AccessControlScreen(
        node: _contacts[2],
        service: _PreviewAclService(context.read<MeshCoreConnector>()),
      ),
    ),
    'wifi': () => WifiSettingsScreen(
      run: (c) async =>
          const {
            'get wifi.enabled': '> 1',
            'get wifi.ssid': '> Basecamp',
            'get wifi.status': '> connected',
            'get wifi.ip': '> 192.168.4.20',
          }[c] ??
          '> ok',
    ),
    'companion_cli': () =>
        CompanionCliScreen(run: (c) async => 'v1.18.0 (Build: 15-Oct-2026)'),
  };

  setUpAll(() async {
    if (out != null) await _loadFonts();
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    final tmp = Directory.systemTemp.createTempSync('preview').path;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (call) async => tmp,
        );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('dev.fluttercommunity.plus/package_info'),
          (call) async => {
            'appName': 'BCS Connect',
            'packageName': 'preview',
            'version': '0.0.0',
            'buildNumber': '0',
          },
        );
  });

  for (final mode in [ThemeMode.dark, ThemeMode.light]) {
    for (final entry in screens.entries) {
      testWidgets('${entry.key} ${mode.name}', (tester) async {
        await tester.binding.setSurfaceSize(const Size(390, 844));
        tester.view.devicePixelRatio = 2;
        addTearDown(tester.view.reset);
        final boundary = GlobalKey();
        await tester.pumpWidget(
          RepaintBoundary(key: boundary, child: _app(entry.value(), mode)),
        );
        for (var i = 0; i < 10; i++) {
          await tester.pump(const Duration(milliseconds: 100));
        }
        await tester.runAsync(() async {
          final ro =
              boundary.currentContext!.findRenderObject()!
                  as RenderRepaintBoundary;
          final image = await ro.toImage(pixelRatio: 2);
          final png = await image.toByteData(format: ui.ImageByteFormat.png);
          File('$out/${entry.key}_${mode.name}.png')
            ..createSync(recursive: true)
            ..writeAsBytesSync(png!.buffer.asUint8List());
        });
      }, skip: out == null);
    }
  }
}
