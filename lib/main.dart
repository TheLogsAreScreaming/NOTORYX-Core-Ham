import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'screens/chrome_required_screen.dart';
import 'utils/platform_info.dart';

import 'connector/meshcore_connector.dart';
import 'models/image_codec_support.dart';
import 'screens/scanner_screen.dart';
import 'services/image_chunk_transport.dart';
import 'services/image_codec_service.dart';
import 'services/image_codec_settings_store.dart';
import 'services/received_image_blob_store_factory.dart';
import 'services/received_image_store.dart';
import 'services/storage_service.dart';
import 'services/message_retry_service.dart';
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
  final mapTileCacheService = MapTileCacheService(appSettingsService: appSettingsService);
  final chatTextScaleService = ChatTextScaleService();
  final translationService = TranslationService(appSettingsService);
  final uiViewStateService = UiViewStateService();
  final timeoutPredictionService = TimeoutPredictionService(storage);
  await appSettingsService.loadSettings();
  final imageCodecService = ImageCodecService(appSettingsService, settingsStore: AppSettingsImageCodecStore(appSettingsService));
  final receivedImageStore = ReceivedImageStore(blobs: createReceivedImageBlobStore(), decoder: ImageCodecServiceDecoder(imageCodecService), processAutomatically: appSettingsService.settings.imageProcessAutomatically);
  appSettingsService.addListener(() { receivedImageStore.processAutomatically = appSettingsService.settings.imageProcessAutomatically; });
  imageCodecService.addListener(receivedImageStore.notifyDecoderChanged);
  final imageReassembler = ImageStreamReassembler(store: receivedImageStore);
  final imageTransport = ImageChunkTransport(reassembler: imageReassembler, send: (blob, channelIndex) => connector.sendImageChunks(<Uint8List>[blob], channelIndex: channelIndex, interChunkDelay: Duration.zero), senderPrefix: 0);
  appLogger.initialize(appDebugLogService, enabled: appSettingsService.settings.appDebugLogEnabled);
  final notificationService = NotificationService();
  await notificationService.initialize();
  await backgroundService.initialize();
  backgroundService.setLanguageOverrideProvider(() => appSettingsService.settings.languageOverride);
  _registerThirdPartyLicenses();
  await chatTextScaleService.initialize();
  await translationService.refreshDownloadedModels();
  await imageCodecService.refreshDownloadedModels();
  await receivedImageStore.load();
  await uiViewStateService.initialize();
  await timeoutPredictionService.initialize();
  connector.initialize(retryService: retryService, pathHistoryService: pathHistoryService, appSettingsService: appSettingsService, translationService: translationService, bleDebugLogService: bleDebugLogService, appDebugLogService: appDebugLogService, backgroundService: backgroundService, timeoutPredictionService: timeoutPredictionService, imageCodecService: imageCodecService, imageTransport: imageTransport, onImageSenderPrefix: (prefix) => imageReassembler.selfPrefix = prefix);
  await connector.loadContactCache();
  await connector.loadChannelSettings();
  await connector.loadCachedChannels();
  await connector.loadAllChannelMessages();
  await connector.loadUnreadState();
  runApp(MeshCoreApp(connector: connector, retryService: retryService, pathHistoryService: pathHistoryService, storage: storage, appSettingsService: appSettingsService, bleDebugLogService: bleDebugLogService, appDebugLogService: appDebugLogService, mapTileCacheService: mapTileCacheService, chatTextScaleService: chatTextScaleService, translationService: translationService, uiViewStateService: uiViewStateService, timeoutPredictionService: timeoutPredictionService, imageCodecService: imageCodecService, receivedImageStore: receivedImageStore, imageReassembler: imageReassembler));
}

class ImageCodecServiceDecoder implements ReceivedImageDecoder {
  final ImageCodecService service;
  const ImageCodecServiceDecoder(this.service);
  @override ImageCodecAvailability get availability => service.availability;
  @override bool get isBusy => service.isBusy;
  @override Future<ImageCodecResult?> decodeBitstream({required Uint8List bitstream, required AeicRatePoint ratePoint, required int resolution}) => service.decodeBitstream(bitstream: bitstream, ratePoint: ratePoint, resolution: resolution);
  @override void cancelCodecJob() => service.cancelCodecJob();
}

class AppSettingsImageCodecStore implements ImageCodecSettingsStore {
  final AppSettingsService _service;
  const AppSettingsImageCodecStore(this._service);
  @override ImageCodecPreferences get preferences => _service.settings.imageCodec;
  @override Future<void> load() async {}
  @override Future<void> save(ImageCodecPreferences preferences) => _service.setImageCodecPreferences(preferences);
}

class ImageStreamReassembler extends ImageReassembler {
  final ReceivedImageStore store;
  int? _selfPrefix;
  ImageStreamReassembler({required this.store}) : super(onFailed: ((failure) => unawaited(store.handleFailure(failure))));
  @override int? get selfPrefix => _selfPrefix;
  set selfPrefix(int? value) => _selfPrefix = value;
  @override ImageChunkOutcome addChunk(Uint8List blob, {int channelIndex = 0, DateTime? now}) {
    final outcome = super.addChunk(blob, channelIndex: channelIndex, now: now);
    unawaited(store.handleOutcome(outcome, channelIndex: channelIndex));
    return outcome;
  }
}

void _registerThirdPartyLicenses() {
  LicenseRegistry.addLicense(() async* {
    yield const LicenseEntryWithLineBreaks(<String>['Open-Meteo Elevation API Data'], '''Data used by LOS elevation lookups is provided by Open-Meteo.\n\nhttps://open-meteo.com/en/terms\n''');
  });
}

class MeshCoreApp extends StatefulWidget {
  final MeshCoreConnector connector; final MessageRetryService retryService; final PathHistoryService pathHistoryService; final StorageService storage; final AppSettingsService appSettingsService; final BleDebugLogService bleDebugLogService; final AppDebugLogService appDebugLogService; final MapTileCacheService mapTileCacheService; final ChatTextScaleService chatTextScaleService; final TranslationService translationService; final UiViewStateService uiViewStateService; final TimeoutPredictionService timeoutPredictionService; final ImageCodecService imageCodecService; final ReceivedImageStore receivedImageStore; final ImageStreamReassembler imageReassembler;
  const MeshCoreApp({super.key, required this.connector, required this.retryService, required this.pathHistoryService, required this.storage, required this.appSettingsService, required this.bleDebugLogService, required this.appDebugLogService, required this.mapTileCacheService, required this.chatTextScaleService, required this.translationService, required this.uiViewStateService, required this.timeoutPredictionService, required this.imageCodecService, required this.receivedImageStore, required this.imageReassembler});
  @override State<MeshCoreApp> createState() => _MeshCoreAppState();
}
const Duration _kImageSweepInterval = Duration(seconds: 5);
class _MeshCoreAppState extends State<MeshCoreApp> with WidgetsBindingObserver {
  Timer? _imageSweepTimer;
  @override void initState() { super.initState(); WidgetsBinding.instance.addObserver(this); _imageSweepTimer = Timer.periodic(_kImageSweepInterval, (_) => widget.imageReassembler.evictExpired()); }
  @override void dispose() { _imageSweepTimer?.cancel(); WidgetsBinding.instance.removeObserver(this); super.dispose(); }
  @override void didChangeAppLifecycleState(AppLifecycleState state) { super.didChangeAppLifecycleState(state); widget.receivedImageStore.setForeground(state == AppLifecycleState.resumed); if (state == AppLifecycleState.paused || state == AppLifecycleState.hidden) { unawaited(widget.imageCodecService.handleMemoryPressure()); unawaited(widget.receivedImageStore.handleMemoryPressure()); } }
  @override void didHaveMemoryPressure() { super.didHaveMemoryPressure(); unawaited(widget.imageCodecService.handleMemoryPressure()); unawaited(widget.receivedImageStore.handleMemoryPressure()); }
  @override Widget build(BuildContext context) {
    final connector = widget.connector; final storage = widget.storage;
    return MultiProvider(providers: [ChangeNotifierProvider.value(value: connector), ChangeNotifierProvider.value(value: widget.retryService), ChangeNotifierProvider.value(value: widget.pathHistoryService), ChangeNotifierProvider.value(value: widget.appSettingsService), ChangeNotifierProvider.value(value: widget.bleDebugLogService), ChangeNotifierProvider.value(value: widget.appDebugLogService), ChangeNotifierProvider.value(value: widget.chatTextScaleService), ChangeNotifierProvider.value(value: widget.translationService), ChangeNotifierProvider.value(value: widget.uiViewStateService), Provider.value(value: storage), ChangeNotifierProvider.value(value: widget.mapTileCacheService), ChangeNotifierProvider.value(value: widget.timeoutPredictionService), ChangeNotifierProvider.value(value: widget.imageCodecService), ChangeNotifierProvider.value(value: widget.receivedImageStore)], child: Consumer<AppSettingsService>(builder: (context, settingsService, child) {
      return MaterialApp(title: 'Bastion', debugShowCheckedModeBanner: false, localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate], supportedLocales: AppLocalizations.supportedLocales, locale: _localeFromSetting(settingsService.settings.languageOverride), theme: MeshTheme.light(), darkTheme: MeshTheme.dark(), themeMode: _themeModeFromSetting(settingsService.settings.themeMode), builder: (context, child) { final locale = Localizations.localeOf(context); NotificationService().setLocale(locale); return AnnotatedRegion<SystemUiOverlayStyle>(value: _systemUiOverlayStyle(context), child: child ?? const SizedBox.shrink()); }, home: (PlatformInfo.isWeb && !PlatformInfo.isChrome) ? const ChromeRequiredScreen() : const ScannerScreen());
    }));
  }
  ThemeMode _themeModeFromSetting(String value) { switch (value) { case 'light': return ThemeMode.light; case 'dark': return ThemeMode.dark; default: return ThemeMode.system; } }
  SystemUiOverlayStyle _systemUiOverlayStyle(BuildContext context) { final theme = Theme.of(context); final colorScheme = theme.colorScheme; final isDark = theme.brightness == Brightness.dark; final iconBrightness = isDark ? Brightness.light : Brightness.dark; return SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: iconBrightness, statusBarBrightness: isDark ? Brightness.dark : Brightness.light, systemNavigationBarColor: colorScheme.surface, systemNavigationBarIconBrightness: iconBrightness, systemNavigationBarDividerColor: colorScheme.surface, systemNavigationBarContrastEnforced: false); }
  Locale? _localeFromSetting(String? languageCode) { if (languageCode == null) return null; return Locale(languageCode); }
}
