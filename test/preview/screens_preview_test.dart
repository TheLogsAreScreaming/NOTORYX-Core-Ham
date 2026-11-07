// Renders the main screens with fake data to PNGs for design review.
//
// Skipped unless PREVIEW_OUT is set:
//   PREVIEW_OUT=/some/dir flutter test test/preview
// PREVIEW_LOCALE=de (for example) renders a translation.
// PREVIEW_ONLY=home,tools renders just those screens; PREVIEW_HEIGHT=2400
// renders taller than a phone screen, for reviewing long screens whole.
// PREVIEW_TEXT_SCALE=1.5 renders with the system text size turned up.
import 'dart:async';
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
import 'package:meshcore_open/screens/path_graph_screen.dart';
import 'package:meshcore_open/screens/access_control_screen.dart';
import 'package:meshcore_open/screens/channel_chat_screen.dart';
import 'package:meshcore_open/screens/channels_screen.dart';
import 'package:meshcore_open/screens/companion_cli_screen.dart';
import 'package:meshcore_open/screens/wifi_settings_screen.dart';
import 'package:meshcore_open/screens/chat_screen.dart';
import 'package:meshcore_open/screens/contacts_screen.dart';
import 'package:meshcore_open/screens/bastion_home_screen.dart';
import 'package:meshcore_open/widgets/theme_picker.dart';
import 'package:meshcore_open/screens/bastion_tools_screen.dart';
import 'package:meshcore_open/screens/settings_screen.dart';
import 'package:meshcore_open/services/sensor_subscription_service.dart';
import 'package:meshcore_open/services/access_control_service.dart';
import 'package:meshcore_open/services/app_debug_log_service.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/services/operator_profile_service.dart';
import 'package:meshcore_open/services/bot_service.dart';
import 'package:meshcore_open/services/field_ops_service.dart';
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
import 'package:meshcore_open/screens/connection_dashboard_screen.dart';
import 'package:meshcore_open/services/mqtt_broker_service.dart';
import 'package:meshcore_open/services/mqtt_client_transport.dart';
import 'package:meshcore_open/services/secure_mqtt_credentials_store.dart';
import 'package:provider/provider.dart';
import 'package:meshcore_open/models/radio_rx_packet.dart';
import 'package:meshcore_open/screens/bastion_path_hub_screen.dart';
import 'package:meshcore_open/services/direct_repeater_service.dart';
import 'package:meshcore_open/models/track_log.dart';
import 'package:meshcore_open/screens/track_log_screen.dart';
import 'package:meshcore_open/services/track_log_service.dart';
import 'package:meshcore_open/screens/region_setup_screen.dart';
import 'package:meshcore_open/models/network_scan.dart';
import 'package:meshcore_open/screens/bastion_field_stats_screen.dart';
import 'package:meshcore_open/screens/bastion_repeater_tools_screen.dart';
import 'package:meshcore_open/screens/networks_screen.dart';
import 'package:meshcore_open/screens/prefix_tool_screen.dart';
import 'package:meshcore_open/services/network_scan_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:meshcore_open/screens/channel_directory_screen.dart';
import 'package:meshcore_open/services/channel_directory_service.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:meshcore_open/screens/scanner_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meshcore_open/models/operator_profile.dart';
import 'package:meshcore_open/models/radio_settings.dart';
import 'package:meshcore_open/screens/licensed_operator_screen.dart';
import 'package:meshcore_open/widgets/operator_setup_banner.dart';
import 'package:meshcore_open/widgets/ui/mesh_states.dart';

// Anchored to today so time-filtered screens (path graph) have data in range.
final _today = DateTime.now();
final _now = DateTime(_today.year, _today.month, _today.day, 9, 30);

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
  _contact(1, 'KD2ABC Ridge Camp', advTypeChat, ago: 2),
  _contact(2, 'N7SAM trail crew', advTypeChat, hops: 2, ago: 14),
  _contact(3, 'N0RPT Hollyburn', advTypeRepeater, hops: 0, ago: 1),
  _contact(4, 'K7CYP Cypress Bowl', advTypeRepeater, hops: 1, ago: 40),
  _contact(5, 'W1BC Basecamp Room', advTypeRoom, hops: 2, ago: 90),
  _contact(6, 'KE7WX Weather', advTypeSensor, hops: 3, ago: 300),
];

final _channels = [
  Channel(index: 0, name: 'Public', psk: Uint8List(16)),
  Channel(index: 1, name: '#trailhead', psk: Uint8List(16)),
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

/// Sample heard paths for the path graph: repeaters 3 and 4 are known
/// contacts; 0x5A/0x5B share first byte 0x5A in 1-byte mode.
List<ChannelMessage> _pathHistory() {
  final k3 = _key(3), k4 = _key(4);
  ChannelMessage m(List<int> path, int width, int minutes) => ChannelMessage(
    senderKey: null,
    senderName: 'Alex',
    text: 'hi',
    timestamp: _now.subtract(Duration(minutes: minutes)),
    isOutgoing: false,
    status: ChannelMessageStatus.sent,
    channelIndex: 1,
    pathBytes: Uint8List.fromList(path),
    pathHashWidth: width,
  );
  return [
    for (var i = 0; i < 6; i++)
      m([0x5a, 0x10, k4[0], k4[1], k3[0], k3[1]], 2, 10 + i),
    for (var i = 0; i < 4; i++)
      m([0x5a, 0x20, 0x77, 0x01, k3[0], k3[1]], 2, 30 + i),
    for (var i = 0; i < 9; i++) m([0x5a, k4[0], k3[0]], 1, 50 + i),
    for (var i = 0; i < 5; i++) m([0x5a, 0x77, k3[0]], 1, 70 + i),
    for (var i = 0; i < 7; i++) m([k4[0], k3[0]], 1, 90 + i),
    for (var i = 0; i < 3; i++) m([0x91, 0x77, k3[0]], 1, 110 + i),
    for (var i = 0; i < 4; i++) m([k3[0]], 1, 130 + i),
  ];
}

class _PreviewConnector extends MeshCoreConnector {
  @override
  double? get selfLatitude => 47.62;
  @override
  double? get selfLongitude => -122.35;
  @override
  bool get isConnected => true;
  @override
  MeshCoreConnectionState get state => MeshCoreConnectionState.connected;
  @override
  int? get batteryMillivolts => 4050;
  @override
  double? get lastRxSnr => 7.25;
  @override
  int? get lastRxRssi => -92;
  @override
  Future<List<ChannelMessage>> loadFullChannelHistory(Channel channel) async =>
      channel.index == 1 ? _pathHistory() : const [];
  @override
  String? get selfName => 'W1AW Trail';
  @override
  String get deviceDisplayName => 'W1AW Trail';
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
  String? get firmwareVersionString => 'v1.18.0-ham';
  @override
  int? get currentFreqHz => 906875; // kHz, as radios report it
  @override
  int? get currentBwHz => 250000;
  @override
  int? get currentSf => 10;
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

/// Mid-scan, with three radios heard at different strengths.
class _PreviewScanConnector extends _PreviewConnector {
  @override
  bool get isConnected => false;
  @override
  MeshCoreConnectionState get state => MeshCoreConnectionState.scanning;
  @override
  List<ScanResult> get scanResults => [
    _scan('MeshCore-W1AW Trail', 'CF57FC24-9872-0AFC-7DEC-E36A387DE23D', -48),
    _scan('MeshCore-Ridge Base', '7A10B2C3-1F4E-4D21-9A0B-5C6D7E8F9012', -71),
    _scan('MeshCore-Cabin Relay', 'E2B4C6D8-0A1C-4E3F-8B2D-4F6A8C0E2B44', -88),
  ];
}

ScanResult _scan(String name, String id, int rssi) => ScanResult(
  device: BluetoothDevice.fromId(id),
  advertisementData: AdvertisementData(
    advName: name,
    txPowerLevel: null,
    appearance: null,
    connectable: true,
    manufacturerData: const {},
    serviceData: const {},
    serviceUuids: const [],
  ),
  rssi: rssi,
  timeStamp: _now,
);

/// A short loop walk, for the track log preview.
Track _sampleTrack() {
  final start = _now.subtract(const Duration(hours: 2));
  const route = [
    (47.6205, -122.3493),
    (47.6221, -122.3471),
    (47.6240, -122.3460),
    (47.6262, -122.3478),
    (47.6270, -122.3512),
    (47.6255, -122.3540),
    (47.6231, -122.3546),
    (47.6212, -122.3525),
  ];
  return Track(
    id: 'sample',
    started: start,
    ended: start.add(const Duration(minutes: 74)),
    points: [
      for (var i = 0; i < route.length; i++)
        TrackPoint(
          at: start.add(Duration(minutes: i * 10)),
          lat: route[i].$1,
          lon: route[i].$2,
        ),
    ],
  );
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
  // Every static weight file of a family, e.g. Inter-Bold.ttf.
  List<String> fontFiles(String prefix) => Directory('assets/fonts')
      .listSync()
      .whereType<File>()
      .map((f) => f.path)
      .where((p) => p.split('/').last.startsWith(prefix) && p.endsWith('.ttf'))
      .toList();
  await load('Inter', fontFiles('Inter-'));
  await load('JetBrains Mono', fontFiles('JetBrainsMono-'));
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
  final connector = _PreviewConnector();
  final settings = AppSettingsService();
  final storage = StorageService();
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<MeshCoreConnector>.value(value: connector),
      ChangeNotifierProvider(create: (_) => FieldOpsService(connector)..load()),
      ChangeNotifierProvider(
        create: (_) => SensorSubscriptionService(connector),
      ),
      ChangeNotifierProvider(create: (_) => BotService(connector)),
      ChangeNotifierProvider.value(value: settings),
      ChangeNotifierProvider(create: (_) => OperatorProfileService()),
      ChangeNotifierProvider(create: (_) => MessageRetryService()),
      ChangeNotifierProvider(create: (_) => PathHistoryService(storage)),
      ChangeNotifierProvider(
        create: (_) => MqttBrokerService(
          prefs: PrefsManager.instance,
          credentials: MemoryMqttCredentialsStore(),
          transportFactory: createMqttClientTransport,
        )..load(),
      ),
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
      theme: MeshTheme.forPalette(MeshPalette.current),
      darkTheme: MeshTheme.forPalette(MeshPalette.current),
      themeMode: mode,
      locale: switch (Platform.environment['PREVIEW_LOCALE']) {
        final code? => Locale(code),
        null => null,
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        final scale = double.tryParse(
          Platform.environment['PREVIEW_TEXT_SCALE'] ?? '',
        );
        if (scale == null) return child!;
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(scale)),
          child: child!,
        );
      },
      home: home,
    ),
  );
}

void main() {
  final out = Platform.environment['PREVIEW_OUT'];
  final screens = <String, Widget Function()>{
    'home': () => const BastionHomeScreen(),
    'tools': () => const BastionToolsScreen(),
    'path_graph': () => const PathGraphScreen(),
    'contacts': () => const ContactsScreen(hideBackButton: true),
    'channels': () => const ChannelsScreen(),
    'channel_chat': () => ChannelChatScreen(channel: _channels[1]),
    'dm_chat': () => ChatScreen(contact: _contacts[0]),
    'settings': () => const SettingsScreen(),
    'theme_picker': () => Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [ThemePicker()],
        ),
      ),
    ),
    'connections': () => const ConnectionDashboardScreen(),
    'routes': () => Builder(
      builder: (context) {
        final heard = DirectRepeaterService(context.read<MeshCoreConnector>());
        final now = DateTime.now();
        Uint8List flood(int lastHop) =>
            Uint8List.fromList([(5 << 2) | 1, 1, lastHop, 1, 2, 3]);
        for (final (hop, snr, mins) in const [
          (0x6F, 9.5, 1),
          (0x6F, 8.0, 3),
          (0x6F, 10.25, 6),
          (0x94, 3.5, 12),
          (0x94, 2.0, 20),
          (0x5A, -6.5, 30),
        ]) {
          heard.record(
            RadioRxPacket(
              raw: flood(hop),
              snr: snr,
              rssi: -100,
              receivedAt: now.subtract(Duration(minutes: mins)),
            ),
          );
        }
        return ChangeNotifierProvider<DirectRepeaterService?>.value(
          value: heard,
          child: const BastionPathHubScreen(),
        );
      },
    ),
    'track_log': () => Builder(
      builder: (context) {
        final log = TrackLogService(context.read<MeshCoreConnector>())
          ..tracks = [_sampleTrack()];
        return ChangeNotifierProvider<TrackLogService>.value(
          value: log,
          child: const TrackLogScreen(),
        );
      },
    ),
    'networks': () => Builder(
      builder: (context) {
        final scan = NetworkScanService(context.read<MeshCoreConnector>())
          ..debugSeed(
            log: _sampleSightings(),
            saved: [
              const ScanTarget(
                name: 'Hilltop club',
                freqKHz: 918000,
                bwHz: 250000,
                sf: 11,
                cr: 8,
              ),
            ],
          );
        return ChangeNotifierProvider<NetworkScanService>.value(
          value: scan,
          child: const NetworksScreen(),
        );
      },
    ),
    'region_setup': () => RegionSetupScreen(
      loadTrees: () async =>
          File('assets/region_trees.json').readAsStringSync(),
    ),
    'prefix_tool': () => const PrefixToolScreen(),
    'field_stats': () => const BastionFieldStatsScreen(),
    'repeater_tools': () => const BastionRepeaterToolsScreen(),
    'channel_directory': () => ChannelDirectoryScreen(
      service: ChannelDirectoryService(
        httpClient: MockClient((_) async => http.Response('', 503)),
        loadBundled: () async =>
            File('assets/channel_directory.json').readAsStringSync(),
      ),
    ),
    'scanner': () => ChangeNotifierProvider<MeshCoreConnector>.value(
      value: _PreviewScanConnector(),
      child: const ScannerScreen(),
    ),
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
    'licensed_operator': () => ChangeNotifierProvider(
      create: (_) => OperatorProfileService()
        ..save(
          OperatorProfile(
            callsign: 'W1AW',
            licenseClass: LicenseClass.general,
            acknowledgedAt: DateTime(2026, 11, 5),
          ),
        ),
      child: const LicensedOperatorScreen(),
    ),
    'home_ready': () => ChangeNotifierProvider(
      create: (_) => OperatorProfileService()
        ..save(
          OperatorProfile(
            callsign: 'W1AW',
            licenseClass: LicenseClass.general,
            acknowledgedAt: DateTime(2026, 11, 5),
          ),
        ),
      child: const BastionHomeScreen(),
    ),
    'setup_banner': () => OperatorSetupBanner(
      navigatorKey: GlobalKey(),
      child: const BastionHomeScreen(),
    ),
    'radio_presets': () => Scaffold(
      body: RadioPresetPicker(
        indexes: [for (var i = 0; i < RadioSettings.presets.length; i++) i],
        selected: 0,
        suggested: 'US 33cm',
      ),
    ),
    'companion_cli': () =>
        CompanionCliScreen(run: (c) async => 'v1.18.0 (Build: 15-Oct-2026)'),
    'confirm_destructive': () => _OpensDialog(
      (context) => confirmDestructive(
        context,
        title: 'Delete channel?',
        message: 'This removes #trailhead and its history from this phone.',
      ),
    ),
    'confirm_action': () => _OpensDialog(
      (context) => confirmAction(
        context,
        title: 'Join network?',
        message: 'Switch the radio to Hilltop club settings.',
        confirmLabel: 'Join',
      ),
    ),
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
            'appName': 'NOTORYX Core Ham',
            'packageName': 'preview',
            'version': '0.0.0',
            'buildNumber': '0',
          },
        );
  });

  final only = Platform.environment['PREVIEW_ONLY']?.split(',').toSet();
  final height =
      double.tryParse(Platform.environment['PREVIEW_HEIGHT'] ?? '') ?? 844;
  // PREVIEW_THEME=okabe_ito,night_ops (etc.) picks themes; by default the
  // dark Blaze theme and the light Pink Overload theme.
  // seasonal_winter (etc.) renders one of Seasonal's looks.
  (String, BastionPalette) themeFor(String id) {
    final season = Season.fromId(id.replaceFirst('seasonal_', ''));
    if (id.startsWith('seasonal_') && season != null) {
      return (id, SeasonalTheme.paletteFor(season));
    }
    final t = BastionTheme.fromId(id);
    return (t.id, t.palette);
  }

  final themes =
      (Platform.environment['PREVIEW_THEME'] ?? 'blaze,pink_overload')
          .split(',')
          .map(themeFor)
          .toList();
  // PREVIEW_A11Y=1 also runs Flutter's accessibility guidelines on every
  // screen and writes the findings to a11y.txt instead of failing.
  final a11y = Platform.environment['PREVIEW_A11Y'] != null;
  for (final (themeId, palette) in themes) {
    for (final entry in screens.entries) {
      if (only != null && !only.contains(entry.key)) continue;
      testWidgets('${entry.key} $themeId', (tester) async {
        MeshPalette.current = palette;
        final semantics = a11y ? tester.ensureSemantics() : null;
        await tester.binding.setSurfaceSize(Size(390, height));
        tester.view.devicePixelRatio = 2;
        addTearDown(tester.view.reset);
        final boundary = GlobalKey();
        await tester.pumpWidget(
          RepaintBoundary(
            key: boundary,
            child: _app(entry.value(), ThemeMode.light),
          ),
        );
        for (var i = 0; i < 10; i++) {
          await tester.pump(const Duration(milliseconds: 100));
        }
        // Asset images decode off the fake clock, so wait for them for real.
        await tester.runAsync(() async {
          for (final element in find.byType(Image).evaluate()) {
            await precacheImage((element.widget as Image).image, element);
          }
        });
        await tester.pump();
        await tester.runAsync(() async {
          final ro =
              boundary.currentContext!.findRenderObject()!
                  as RenderRepaintBoundary;
          final image = await ro.toImage(pixelRatio: 2);
          final png = await image.toByteData(format: ui.ImageByteFormat.png);
          File('$out/${entry.key}_$themeId.png')
            ..createSync(recursive: true)
            ..writeAsBytesSync(png!.buffer.asUint8List());
        });
        if (semantics != null) {
          final report = StringBuffer();
          for (final guideline in [
            androidTapTargetGuideline,
            labeledTapTargetGuideline,
          ]) {
            final result = await guideline.evaluate(tester);
            if (!result.passed) report.writeln(result.reason);
          }
          // The guideline runs its own runAsync to read pixels.
          final contrast = await textContrastGuideline.evaluate(tester);
          if (!contrast.passed) {
            report.writeln(contrast.reason);
          }
          File('$out/a11y.txt').writeAsStringSync(
            '## ${entry.key} $themeId\n'
            '${report.isEmpty ? 'ok\n' : report}',
            mode: FileMode.append,
          );
          semantics.dispose();
        }
        // Screens start polling and debounce timers; let them run out so
        // the test ends clean.
        await tester.pumpWidget(const SizedBox());
        await tester.pump(const Duration(minutes: 2));
      }, skip: out == null);
    }
  }
}

List<NetworkSighting> _sampleSightings() {
  final now = DateTime.now();
  return [
    NetworkSighting(
      target: const ScanTarget(
        name: 'MediumSlow',
        freqKHz: 914875,
        bwHz: 250000,
        sf: 10,
        cr: 5,
      ),
      at: now.subtract(const Duration(minutes: 12)),
      latitude: 49.3,
      longitude: -123.1,
      packets: 14,
      bestSnr: 7.25,
      bestRssi: -92,
      nodes: const [
        HeardNode(key: 'a1b2c3d4', name: 'Hollyburn RPT', type: 2),
        HeardNode(key: 'e5f60718', name: 'Cypress Bowl RPT', type: 2),
        HeardNode(key: '99aa0011', name: 'Ridge Camp', type: 1),
      ],
    ),
    NetworkSighting(
      target: const ScanTarget(
        name: 'Canada',
        freqKHz: 910525,
        bwHz: 250000,
        sf: 11,
        cr: 5,
      ),
      at: now.subtract(const Duration(hours: 3)),
      latitude: 49.32,
      longitude: -123.05,
      packets: 3,
      bestSnr: -4.5,
      bestRssi: -118,
      nodes: const [HeardNode(key: '0badf00d', name: 'Seymour RPT', type: 2)],
    ),
  ];
}

/// A blank screen that opens [open] after its first frame, for dialog shots.
class _OpensDialog extends StatefulWidget {
  const _OpensDialog(this.open);

  final Future<Object?> Function(BuildContext context) open;

  @override
  State<_OpensDialog> createState() => _OpensDialogState();
}

class _OpensDialogState extends State<_OpensDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) unawaited(widget.open(context));
    });
  }

  @override
  Widget build(BuildContext context) => const Scaffold(body: SizedBox());
}
