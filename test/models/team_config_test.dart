import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/team_config.dart';

void main() {
  TeamConfig make({int f = 906875}) => TeamConfig(
    freqKhz: f,
    bandwidthHz: 250000,
    spreadingFactor: 11,
    codingRate: 5,
    channels: const ['#net'],
  );

  test('round trips', () {
    final back = TeamConfig.tryParse(make().encode())!;
    expect(back.freqKhz, 906875);
    expect(back.codingRate, 5);
    expect(back.channels, ['#net']);
  });

  test('from the radio: only hashtag channels, coding rate normalised', () {
    final c = TeamConfig.fromRadio(
      freqKhz: 433000,
      bandwidthHz: 125000,
      spreadingFactor: 9,
      deviceCodingRate: 1,
      channelNames: const ['Public', '#net', 'private team'],
    );
    expect(c.channels, ['#net']);
    expect(c.codingRate, 5);
  });

  test('refuses frequencies outside the amateur bands', () {
    expect(TeamConfig.tryParse(make(f: 869525).encode()), isNull);
  });

  test('refuses keys, private channels, junk and bad values', () {
    Map<String, dynamic> base() =>
        jsonDecode(make().encode()) as Map<String, dynamic>;
    expect(TeamConfig.tryParse(jsonEncode(base()..['psk'] = 'abc')), isNull);
    expect(TeamConfig.tryParse(jsonEncode(base()..['ch'] = ['team'])), isNull);
    expect(TeamConfig.tryParse(jsonEncode(base()..['s'] = 13)), isNull);
    expect(TeamConfig.tryParse(jsonEncode(base()..['t'] = 'x')), isNull);
    expect(TeamConfig.tryParse('{broken'), isNull);
    expect(TeamConfig.tryParse('[]'), isNull);
  });
}
