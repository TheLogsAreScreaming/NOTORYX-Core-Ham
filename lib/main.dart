import 'dart:async';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'screens/chrome_required_screen.dart';
import 'utils/platform_info.dart';

import 'connector/meshcore_connector.dart';
import 'connector/meshcore_protocol.dart';
import 'models/image_codec_support.dart';
import 'models/mqtt_mesh_packet.dart';
import 'models/mqtt_observer_status.dart';
import 'models/radio_rx_packet.dart';
import 'screens/bastion_home_screen.dart';
import 'services/regional_preset_service.dart';
import 'services/read_aloud_service.dart';
import 'services/app_shortcuts.dart';
import 'services/sensor_subscription_service.dart';
import 'services/mqtt_broker_service.dart';
import 'services/mqtt_client_transport.dart';
import 'services/network_monitor.dart';
import 'services/secure_mqtt_credentials_store.dart';
import 'services/image_chunk_transport.dart';
import 'services/image_codec_service.dart';
import 'services/image_codec_settings_store.dart';
import 'services/received_image_blob_store_factory.dart';
import 'services/received_image_store.dart';
import 'services/storage_service.dart';
import 'services/message_retry_service.dart';
import 'services/bot_service.dart';
import 'services/field_ops_service.dart';
import 'services/path_history_service.dart';
import 'services/app_settings_service.dart';
import 'services/notification_service.dart';
import 'services/ble_debug_log_service.dart';
import 'services/app_debug_log_service.dart';
import 'services/background_service.dart';
import 'services/map_tile_cache_service.dart';
import 'services/chat_text_scale_service.dart';
import 'services/translation_service.dart';
import 'services/ui_view_state_service.dart';
import 'services/timeout_prediction_service.dart';
import 'storage/prefs_manager.dart';
import 'theme/mesh_theme.dart';
import 'utils/app_logger.dart';
import 'widgets/image_send_codec_binding.dart';
import 'services/direct_repeater_service.dart';
import 'services/mqtt_uploaders_service.dart';
import 'services/track_log_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  await PrefsManager.initialize();
  final storage = StorageService();
  final connector = MeshCoreConnector();
  final pathHistoryService = PathHistoryService(storage);
  final retryService = MessageRetryService();
  final appSettingsService = AppSettingsService();
  final bleDebugLogService = BleDebugLogService();
  final appDebugLogService = AppDebugLogService();
  final backgroundService = BackgroundService();
  final mapTileCacheService = MapTileCacheService(
    appSettingsService: appSettingsService,
  );
  final chatTextScaleService = ChatTextScaleService();
  final translationService = TranslationService(appSettingsService);
  final uiViewStateService = UiViewStateService();
  final timeoutPredictionService = TimeoutPredictionService(storage);
  await appSettingsService.loadSettings();
  final imageCodecService = ImageCodecService(
    appSettingsService,
    settingsStore: AppSettingsImageCodecStore(appSettingsService),
  );
  final receivedImageStore = ReceivedImageStore(
    blobs: createReceivedImageBlobStore(),
    decoder: ImageCodecServiceDecoder(imageCodecService),
    processAutomatically: appSettingsService.settings.imageProcessAutomatically,
  );
  appSettingsService.addListener(() {
    receivedImageStore.processAutomatically =
        appSettingsService.settings.imageProcessAutomatically;
  });
  imageCodecService.addListener(receivedImageStore.notifyDecoderChanged);
  final imageReassembler = ImageStreamReassembler(store: receivedImageStore);
  final imageTransport = ImageChunkTransport(
    reassembler: imageReassembler,
    send: (blob, channelIndex) => connector.sendImageChunks(
      <Uint8List>[blob],
      channelIndex: channelIndex,
      interChunkDelay: Duration.zero,
    ),
    senderPrefix: 0,
  );
  appLogger.initialize(
    appDebugLogService,
    enabled: appSettingsService.settings.appDebugLogEnabled,
  );
  final notificationService = NotificationService();
  await notificationService.initialize();
  await backgroundService.initialize();
  backgroundService.setLanguageOverrideProvider(
    () => appSettingsService.settings.languageOverride,
  );
  _registerThirdPartyLicenses();
  await chatTextScaleService.initialize();
  await translationService.refreshDownloadedModels();
  await imageCodecService.refreshDownloadedModels();
  await receivedImageStore.load();
  await uiViewStateService.initialize();
  await timeoutPredictionService.initialize();
  connector.initialize(
    retryService: retryService,
    pathHistoryService: pathHistoryService,
    appSettingsService: appSettingsService,
    translationService: translationService,
    bleDebugLogService: bleDebugLogService,
    appDebugLogService: appDebugLogService,
    backgroundService: backgroundService,
    timeoutPredictionService: timeoutPredictionService,
    imageCodecService: imageCodecService,
    imageTransport: imageTransport,
    onImageSenderPrefix: (prefix) => imageReassembler.selfPrefix = prefix,
  );
  await connector.loadContactCache();
  await connector.loadChannelSettings();
  await connector.loadCachedChannels();
  await connector.loadAllChannelMessages();
  await connector.loadUnreadState();
  runApp(
    MeshCoreApp(
      connector: connector,
      retryService: retryService,
      pathHistoryService: pathHistoryService,
      storage: storage,
      appSettingsService: appSettingsService,
      bleDebugLogService: bleDebugLogService,
      appDebugLogService: appDebugLogService,
      mapTileCacheService: mapTileCacheService,
      chatTextScaleService: chatTextScaleService,
      translationService: translationService,
      uiViewStateService: uiViewStateService,
      timeoutPredictionService: timeoutPredictionService,
      imageCodecService: imageCodecService,
      receivedImageStore: receivedImageStore,
      imageReassembler: imageReassembler,
    ),
  );
}

class ImageCodecServiceDecoder implements ReceivedImageDecoder {
  final ImageCodecService service;
  const ImageCodecServiceDecoder(this.service);
  @override
  ImageCodecAvailability get availability => service.availability;
  @override
  bool get isBusy => service.isBusy;
  @override
  Future<ImageCodecResult?> decodeBitstream({
    required Uint8List bitstream,
    required AeicRatePoint ratePoint,
    required int resolution,
  }) => service.decodeBitstream(
    bitstream: bitstream,
    ratePoint: ratePoint,
    resolution: resolution,
  );
  @override
  void cancelCodecJob() => service.cancelCodecJob();
}

class AppSettingsImageCodecStore implements ImageCodecSettingsStore {
  final AppSettingsService _service;
  const AppSettingsImageCodecStore(this._service);
  @override
  ImageCodecPreferences get preferences => _service.settings.imageCodec;
  @override
  Future<void> load() async {}
  @override
  Future<void> save(ImageCodecPreferences preferences) =>
      _service.setImageCodecPreferences(preferences);
}

class ImageStreamReassembler extends ImageReassembler {
  final ReceivedImageStore store;
  int? _selfPrefix;
  ImageStreamReassembler({required this.store})
    : super(onFailed: ((failure) => unawaited(store.handleFailure(failure))));
  @override
  int? get selfPrefix => _selfPrefix;
  set selfPrefix(int? value) => _selfPrefix = value;
  @override
  ImageChunkOutcome addChunk(
    Uint8List blob, {
    int channelIndex = 0,
    DateTime? now,
  }) {
    final outcome = super.addChunk(blob, channelIndex: channelIndex, now: now);
    unawaited(store.handleOutcome(outcome, channelIndex: channelIndex));
    return outcome;
  }
}

void _registerThirdPartyLicenses() {
  LicenseRegistry.addLicense(() async* {
    yield const LicenseEntryWithLineBreaks(
      <String>['Open-Meteo Elevation API Data'],
      '''Data used by LOS elevation lookups is provided by Open-Meteo.\n\nhttps://open-meteo.com/en/terms\n''',
    );
  });
}

class MeshCoreApp extends StatefulWidget {
  final MeshCoreConnector connector;
  final MessageRetryService retryService;
  final PathHistoryService pathHistoryService;
  final StorageService storage;
  final AppSettingsService appSettingsService;
  final BleDebugLogService bleDebugLogService;
  final AppDebugLogService appDebugLogService;
  final MapTileCacheService mapTileCacheService;
  final ChatTextScaleService chatTextScaleService;
  final TranslationService translationService;
  final UiViewStateService uiViewStateService;
  final TimeoutPredictionService timeoutPredictionService;
  final ImageCodecService imageCodecService;
  final ReceivedImageStore receivedImageStore;
  final ImageStreamReassembler imageReassembler;
  const MeshCoreApp({
    super.key,
    required this.connector,
    required this.retryService,
    required this.pathHistoryService,
    required this.storage,
    required this.appSettingsService,
    required this.bleDebugLogService,
    required this.appDebugLogService,
    required this.mapTileCacheService,
    required this.chatTextScaleService,
    required this.translationService,
    required this.uiViewStateService,
    required this.timeoutPredictionService,
    required this.imageCodecService,
    required this.receivedImageStore,
    required this.imageReassembler,
  });
  @override
  State<MeshCoreApp> createState() => _MeshCoreAppState();
}

const Duration _kImageSweepInterval = Duration(seconds: 5);

class _MeshCoreAppState extends State<MeshCoreApp> with WidgetsBindingObserver {
  Timer? _imageSweepTimer;
  Timer? _channelPruneTimer;
  late final BotService _botService;
  late final FieldOpsService _fieldOps;
  late final RegionalPresetService _regionalPresets;
  late final DirectRepeaterService _directRepeaters;
  late final TrackLogService _trackLog;
  late final ReadAloudService _readAloud;
  final _navigatorKey = GlobalKey<NavigatorState>();
  AppShortcuts? _shortcuts;
  String? _shortcutLanguage;
  late final SensorSubscriptionService _sensorSubscriptions;
  late final MqttBrokerService _mqtt;
  late final MqttUploadersService _uploaders;
  StreamSubscription<MqttMeshPacket>? _mqttPackets;
  StreamSubscription<RadioRxPacket>? _radioRxPackets;
  @override
  void initState() {
    super.initState();
    _botService = BotService(widget.connector);
    unawaited(_botService.load());
    _fieldOps = FieldOpsService(widget.connector);
    unawaited(_fieldOps.load());
    _regionalPresets = RegionalPresetService(widget.connector);
    unawaited(_regionalPresets.start());
    _directRepeaters = DirectRepeaterService(widget.connector);
    _trackLog = TrackLogService(widget.connector);
    unawaited(_trackLog.load());
    _readAloud = ReadAloudService(widget.connector, widget.appSettingsService);
    _applyBatterySaver();
    widget.appSettingsService.addListener(_applyBatterySaver);
    if (PlatformInfo.isMobile) {
      final shortcuts = _shortcuts = AppShortcuts(_navigatorKey);
      unawaited(
        shortcuts.install().catchError((Object e) {
          debugPrint('App shortcuts unavailable: $e');
        }),
      );
    }
    _sensorSubscriptions = SensorSubscriptionService(widget.connector);
    _mqtt = MqttBrokerService(
      prefs: PrefsManager.instance,
      credentials: createMqttCredentialsStore(),
      transportFactory: createMqttClientTransport,
      networkMonitor: ConnectivityNetworkMonitor(),
      backlogStore: FileMqttBacklogStore('main'),
    );
    unawaited(_mqtt.load());
    _uploaders = MqttUploadersService(
      prefs: PrefsManager.instance,
      credentials: (namespace) =>
          createMqttCredentialsStore(namespace: namespace),
      transportFactory: createMqttClientTransport,
      networkMonitor: ConnectivityNetworkMonitor.new,
    );
    unawaited(_uploaders.load().then((_) => _syncMqttObserverIdentity()));
    unawaited(
      PackageInfo.fromPlatform()
          .then((info) {
            final version = 'notoryx-core/${info.version}';
            _uploaders.clientVersion = version;
            return _mqtt.clientVersion = version;
          })
          .catchError((Object _) => _mqtt.clientVersion),
    );
    _mqttPackets = _mqtt.packets.listen((packet) {
      if (_mqtt.deliverChannelMessages &&
          packet.payloadType == payloadTypeGRPTXT) {
        widget.connector.ingestMqttRawPacket(packet.raw);
      }
    });
    _radioRxPackets = widget.connector.rxPackets.listen((packet) {
      _mqtt.publishRadioPacket(packet);
      _uploaders.publishRadioPacket(packet);
    });
    _syncMqttObserverIdentity();
    widget.connector.addListener(_syncMqttObserverIdentity);
    WidgetsBinding.instance.addObserver(this);
    // Channel message auto-delete runs on load and then hourly.
    _channelPruneTimer = Timer.periodic(
      const Duration(hours: 1),
      (_) => unawaited(widget.connector.pruneOldChannelMessages()),
    );
    _imageSweepTimer = Timer.periodic(
      _kImageSweepInterval,
      (_) => widget.imageReassembler.evictExpired(),
    );
  }

  @override
  void dispose() {
    _botService.dispose();
    widget.appSettingsService.removeListener(_applyBatterySaver);
    _fieldOps.dispose();
    _regionalPresets.dispose();
    _directRepeaters.dispose();
    _trackLog.dispose();
    _readAloud.dispose();
    _sensorSubscriptions.dispose();
    unawaited(_mqttPackets?.cancel());
    unawaited(_radioRxPackets?.cancel());
    widget.connector.removeListener(_syncMqttObserverIdentity);
    _mqtt.dispose();
    _uploaders.dispose();
    _imageSweepTimer?.cancel();
    _channelPruneTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _syncMqttObserverIdentity() {
    final connector = widget.connector;
    _mqtt.setObserverIdentity(
      publicKeyHex: connector.selfPublicKey == null
          ? null
          : connector.selfPublicKeyHex,
      name: connector.selfName,
      details: MqttObserverDetails(
        radio: MqttObserverDetails.radioFrom(
          freqHz: connector.currentFreqHz,
          bwHz: connector.currentBwHz,
          sf: connector.currentSf,
          cr: connector.currentCr,
        ),
        model: connector.manufacturerName,
        firmwareVersion: connector.firmwareVersionString,
      ),
    );
    // Token sign-in asks the radio to sign; its private key stays there.
    _mqtt.setRadioSigner(
      connector.isConnected ? connector.signWithRadio : null,
    );
    _uploaders.setRadioIdentity(
      RadioIdentity(
        publicKeyHex: connector.selfPublicKey == null
            ? null
            : connector.selfPublicKeyHex,
        name: connector.selfName,
        details: MqttObserverDetails(
          radio: MqttObserverDetails.radioFrom(
            freqHz: connector.currentFreqHz,
            bwHz: connector.currentBwHz,
            sf: connector.currentSf,
            cr: connector.currentCr,
          ),
          model: connector.manufacturerName,
          firmwareVersion: connector.firmwareVersionString,
        ),
        signer: connector.isConnected ? connector.signWithRadio : null,
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _fieldOps.setForeground(state == AppLifecycleState.resumed);
    _readAloud.foreground = state == AppLifecycleState.resumed;
    widget.receivedImageStore.setForeground(state == AppLifecycleState.resumed);
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      unawaited(widget.imageCodecService.handleMemoryPressure());
      unawaited(widget.receivedImageStore.handleMemoryPressure());
    }
  }

  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();
    unawaited(widget.imageCodecService.handleMemoryPressure());
    unawaited(widget.receivedImageStore.handleMemoryPressure());
  }

  @override
  Widget build(BuildContext context) {
    final connector = widget.connector;
    final storage = widget.storage;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _botService),
        ChangeNotifierProvider.value(value: _fieldOps),
        ChangeNotifierProvider<DirectRepeaterService?>.value(
          value: _directRepeaters,
        ),
        ChangeNotifierProvider.value(value: _trackLog),
        ChangeNotifierProvider<RegionalPresetService?>.value(
          value: _regionalPresets,
        ),
        Provider.value(value: _readAloud),
        ChangeNotifierProvider.value(value: _sensorSubscriptions),
        ChangeNotifierProvider.value(value: _mqtt),
        ChangeNotifierProvider<MqttUploadersService?>.value(value: _uploaders),
        ChangeNotifierProvider.value(value: connector),
        ChangeNotifierProvider.value(value: widget.retryService),
        ChangeNotifierProvider.value(value: widget.pathHistoryService),
        ChangeNotifierProvider.value(value: widget.appSettingsService),
        ChangeNotifierProvider.value(value: widget.bleDebugLogService),
        ChangeNotifierProvider.value(value: widget.appDebugLogService),
        ChangeNotifierProvider.value(value: widget.chatTextScaleService),
        ChangeNotifierProvider.value(value: widget.translationService),
        ChangeNotifierProvider.value(value: widget.uiViewStateService),
        Provider.value(value: storage),
        ChangeNotifierProvider.value(value: widget.mapTileCacheService),
        ChangeNotifierProvider.value(value: widget.timeoutPredictionService),
        ChangeNotifierProvider.value(value: widget.imageCodecService),
        ChangeNotifierProvider.value(value: widget.receivedImageStore),
      ],
      child: Consumer<AppSettingsService>(
        builder: (context, settingsService, child) {
          final palette = _applyTheme(settingsService.settings.appTheme);
          return MaterialApp(
            navigatorKey: _navigatorKey,
            title: 'NOTORYX Core',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: _localeFromSetting(
              settingsService.settings.languageOverride,
            ),
            theme: MeshTheme.forPalette(palette),
            darkTheme: MeshTheme.forPalette(palette),
            themeMode: palette.brightness == Brightness.dark
                ? ThemeMode.dark
                : ThemeMode.light,
            builder: (context, child) {
              final locale = Localizations.localeOf(context);
              NotificationService().setLocale(locale);
              _relabelShortcuts(locale);
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: _systemUiOverlayStyle(context),
                child: child ?? const SizedBox.shrink(),
              );
            },
            home: (PlatformInfo.isWeb && !PlatformInfo.isChrome)
                ? const ChromeRequiredScreen()
                : const BastionHomeScreen(),
          );
        },
      ),
    );
  }

  void _relabelShortcuts(Locale locale) {
    final shortcuts = _shortcuts;
    if (shortcuts == null || locale.languageCode == _shortcutLanguage) return;
    _shortcutLanguage = locale.languageCode;
    unawaited(
      shortcuts.setLabels(lookupAppLocalizations(locale)).catchError((
        Object e,
      ) {
        debugPrint('App shortcuts not retitled: $e');
      }),
    );
  }

  void _applyBatterySaver() {
    final on = widget.appSettingsService.settings.batterySaver;
    widget.connector.setBatterySaver(on);
    _fieldOps.setBatterySaver(on);
  }

  /// Points [MeshPalette] at the chosen theme. Screens read the palette
  /// directly, so after a switch every widget is rebuilt once, in place, so
  /// nothing (open screens, scroll position) is lost.
  BastionPalette _applyTheme(String id) {
    final palette = BastionTheme.fromId(id).palette;
    if (!identical(MeshPalette.current, palette)) {
      MeshPalette.current = palette;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final root = WidgetsBinding.instance.rootElement;
        if (root == null) return;
        void mark(Element e) {
          e.markNeedsBuild();
          e.visitChildren(mark);
        }

        mark(root);
      });
    }
    return palette;
  }

  SystemUiOverlayStyle _systemUiOverlayStyle(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final iconBrightness = isDark ? Brightness.light : Brightness.dark;
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: iconBrightness,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: colorScheme.surface,
      systemNavigationBarIconBrightness: iconBrightness,
      systemNavigationBarDividerColor: colorScheme.surface,
      systemNavigationBarContrastEnforced: false,
    );
  }

  Locale? _localeFromSetting(String? languageCode) {
    if (languageCode == null) return null;
    return Locale(languageCode);
  }
}
