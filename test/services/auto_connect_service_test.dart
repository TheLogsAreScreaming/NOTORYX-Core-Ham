import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/models/saved_radio.dart';
import 'package:meshcore_open/services/app_settings_service.dart';
import 'package:meshcore_open/services/auto_connect_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Radio extends MeshCoreConnector {
  SavedRadio? saved = const SavedRadio(
    transport: SavedRadioTransport.bluetooth,
    address: 'AA:BB',
    name: 'DirtyDanFullSend',
  );
  MeshCoreConnectionState current = MeshCoreConnectionState.disconnected;
  int attempts = 0;

  /// Attempts that fail before one succeeds.
  int failFirst = 0;

  @override
  SavedRadio? get savedRadio => saved;
  @override
  MeshCoreConnectionState get state => current;
  @override
  bool get isConnected => current == MeshCoreConnectionState.connected;
  @override
  Future<void> reconnectSavedRadio() async {
    attempts++;
    if (attempts <= failFirst) throw Exception('out of range');
    current = MeshCoreConnectionState.connected;
  }
}

void main() {
  late AppSettingsService settings;
  late _Radio radio;
  late AutoConnectService auto;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    settings = AppSettingsService();
    await settings.loadSettings();
    radio = _Radio();
    auto = AutoConnectService(
      radio,
      settings,
      delays: const [
        Duration.zero,
        Duration(milliseconds: 5),
        Duration(milliseconds: 5),
      ],
    );
  });
  tearDown(() {
    auto.dispose();
    PrefsManager.reset();
  });

  Future<void> settle() =>
      Future<void>.delayed(const Duration(milliseconds: 60));

  test('off by default: nothing happens at start', () async {
    auto.start();
    await settle();
    expect(radio.attempts, 0);
  });

  test('on: reconnects at start, retrying until the radio answers', () async {
    await settings.setAutoConnectRadio(true);
    radio.failFirst = 2;
    auto.start();
    await settle();
    expect(radio.attempts, 3);
    expect(radio.isConnected, isTrue);
  });

  test('gives up after the last try', () async {
    await settings.setAutoConnectRadio(true);
    radio.failFirst = 99;
    auto.start();
    await settle();
    expect(radio.attempts, 3);
  });

  test('turning the switch on tries straight away', () async {
    auto.start();
    await settings.setAutoConnectRadio(true);
    await settle();
    expect(radio.attempts, 1);
  });

  test('a connection already under way is left alone', () async {
    await settings.setAutoConnectRadio(true);
    radio.current = MeshCoreConnectionState.connecting;
    auto.start();
    await settle();
    expect(radio.attempts, 0);
  });

  test('USB and no saved radio are not tried', () async {
    await settings.setAutoConnectRadio(true);
    radio.saved = const SavedRadio(
      transport: SavedRadioTransport.usb,
      address: '/dev/tty',
      name: 'Cable',
    );
    auto.start();
    await settle();
    expect(radio.attempts, 0);
    radio.saved = null;
    await auto.run();
    expect(radio.attempts, 0);
  });
}
