import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/channel.dart';
import 'package:meshcore_open/models/team_config.dart';
import 'package:meshcore_open/services/team_config_apply.dart';

class _Radio extends MeshCoreConnector {
  final frames = <Uint8List>[];
  final list = <Channel>[
    Channel(index: 0, name: 'Public', psk: Uint8List(16)),
    Channel(index: 2, name: '#have', psk: Uint8List(16)),
  ];
  @override
  List<Channel> get channels => list;
  @override
  int get maxChannels => 4;
  @override
  int? get currentCr => 5;
  @override
  Future<void> refreshDeviceInfo() async {}
  @override
  Future<void> setChannel(int index, String name, Uint8List psk) async =>
      list.add(Channel(index: index, name: name, psk: psk));
  @override
  Future<void> sendFrame(
    Uint8List data, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async => frames.add(data);
}

void main() {
  test(
    'sets the radio, joins missing channels and reports what will not fit',
    () async {
      final radio = _Radio();
      final skipped = await applyTeamConfig(
        radio,
        const TeamConfig(
          freqKhz: 906875,
          bandwidthHz: 250000,
          spreadingFactor: 11,
          codingRate: 5,
          channels: ['#have', '#a', '#b', '#c'],
        ),
      );
      expect(
        radio.frames.single,
        buildSetRadioParamsFrame(906875, 250000, 11, 5),
      );
      expect(radio.list.map((c) => (c.index, c.name)), [
        (0, 'Public'),
        (2, '#have'),
        (1, '#a'),
        (3, '#b'),
      ]);
      expect(radio.list.last.psk, Channel.derivePskFromHashtag('#b'));
      expect(skipped, ['#c']);
    },
  );
}
