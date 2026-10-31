import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/services/signed_posts.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/mesh_packet_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final psk = Uint8List.fromList(List.generate(16, (i) => 0xA0 + i));
  final channel = Channel(index: 2, name: 'Hike', psk: psk);
  late MeshCoreConnector connector;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    connector = MeshCoreConnector()..debugSetChannels([channel]);
  });

  test('decodes a channel text with its hops', () {
    final heard = connector.decodeHeardChannelPacket(
      groupTextPacket(
        psk: psk,
        text: 'Ann: [NOTORYX SOS] Need help',
        timestamp: 1770000000,
        path: [7, 8],
      ),
    )!;
    expect(heard.isText, isTrue);
    expect(heard.channelIndex, 2);
    expect(heard.hopCount, 2);
    expect(heard.senderName, 'Ann');
    expect(heard.text, '[NOTORYX SOS] Need help');
    expect(heard.timestamp, 1770000000);
  });

  test('every copy of a packet has the same hash', () {
    String hashOf(List<int> path) => connector
        .decodeHeardChannelPacket(
          groupTextPacket(psk: psk, text: 'Ann: hi', path: path),
        )!
        .packetHash;
    expect(hashOf([]), hashOf([5, 6]));
    expect(
      hashOf([]),
      isNot(
        connector
            .decodeHeardChannelPacket(
              groupTextPacket(psk: psk, text: 'Ann: hello'),
            )!
            .packetHash,
      ),
    );
  });

  test('decodes a signed-post signature packet', () {
    final post = SignedPostPayload(
      publicKey: Uint8List.fromList(List.filled(32, 0x11)),
      timestamp: 1770000000,
      signature: Uint8List.fromList(List.filled(64, 0x22)),
    );
    final heard = connector.decodeHeardChannelPacket(
      groupDataPacket(
        psk: psk,
        dataType: dataTypeSignedPost,
        data: post.encode(),
      ),
    )!;
    expect(heard.isText, isFalse);
    expect(heard.timestamp, 1770000000);
    expect(heard.signedPost!.publicKey, post.publicKey);
  });

  test('ignores other data types, other channels and direct packets', () {
    expect(
      connector.decodeHeardChannelPacket(
        groupDataPacket(psk: psk, dataType: 0xAE1C, data: [1, 2, 3]),
      ),
      isNull,
    );
    expect(
      connector.decodeHeardChannelPacket(
        groupTextPacket(psk: Uint8List(16), text: 'Bob: elsewhere'),
      ),
      isNull,
    );
    final direct = groupTextPacket(psk: psk, text: 'Ann: hi')..[0] = 0x16;
    expect(connector.decodeHeardChannelPacket(direct), isNull);
  });

  test('raw packet frame carries the packet unchanged', () {
    final raw = groupTextPacket(psk: psk, text: 'Ann: hi');
    expect(buildSendRawPacketFrame(raw), [cmdSendRawPacket, 1, ...raw]);
  });

  test('cannot send raw packets without a radio', () {
    expect(connector.supportsRawPacketSend, isFalse);
    expect(
      () => connector.sendRawPacket(Uint8List(4)),
      throwsA(isA<StateError>()),
    );
  });
}
