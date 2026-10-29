import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/models/channel_directory.dart';
import 'package:meshcore_open/models/radio_rx_packet.dart';
import 'package:meshcore_open/services/channel_discovery_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/mesh_packet_fixtures.dart';

RadioRxPacket _heard(String channel, String text) => RadioRxPacket(
  raw: groupTextPacket(psk: Channel.derivePskFromHashtag(channel), text: text),
  snr: 5,
  rssi: -90,
  receivedAt: DateTime.now(),
);

void main() {
  late ChannelDiscoveryService discovery;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    discovery = ChannelDiscoveryService(
      MeshCoreConnector(),
      entries: () async => const [
        ChannelDirectoryEntry(
          name: '#seattle',
          category: ChannelCategory.local,
          description: 'Seattle area chat.',
        ),
        ChannelDirectoryEntry(
          name: '#pnw',
          category: ChannelCategory.local,
          description: 'Pacific Northwest.',
        ),
      ],
    );
    await discovery.load();
  });

  tearDown(() => discovery.dispose());

  test('a message that decrypts with a directory key is discovered', () {
    discovery.onPacket(_heard('#seattle', 'Alice: hi'));
    discovery.onPacket(_heard('#seattle', 'Bob: hello'));
    expect(discovery.discovered.single.entry.name, '#seattle');
    expect(discovery.discovered.single.heard, 2);
  });

  test('channels outside the directory are not offered', () {
    discovery.onPacket(_heard('#somewhere-else', 'Carol: hey'));
    expect(discovery.discovered, isEmpty);
  });

  test('ignored channels stay hidden and the choice is saved', () async {
    discovery.onPacket(_heard('#pnw', 'Dan: rain'));
    await discovery.ignore(['#pnw']);
    expect(discovery.discovered, isEmpty);
    expect(PrefsManager.instance.getStringList('notoryx_ignored_channels_v1'), [
      '#pnw',
    ]);
  });
}
