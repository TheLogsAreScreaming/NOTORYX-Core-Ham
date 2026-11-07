import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/services/image_chunk_transport.dart';
import 'package:meshcore_open/utils/amateur_radio.dart';

Uint8List _hex(String s) => Uint8List.fromList([
  for (var i = 0; i < s.length; i += 2)
    int.parse(s.substring(i, i + 2), radix: 16),
]);

void main() {
  group('AmateurFrame.unwrap', () {
    // A DM the repeater N0RPT relayed in the mcsim test (firmware PR 1).
    const relayedDm =
        '490173a770a2c00100000000444d20312066726f6d2057314157'
        '000000000000000000000000004e30525054000000';

    test('splits off the station ID and marks the header V1', () {
      final frame = AmateurFrame.unwrap(_hex(relayedDm))!;
      expect(frame.station, 'N0RPT');
      expect(frame.packet.length, _hex(relayedDm).length - stationIdBytes);
      expect(frame.packet[0], 0x09); // TXT_MSG, flood, version bits cleared
      expect(
        String.fromCharCodes(frame.packet.sublist(12, 26)),
        'DM 1 from W1AW',
      );
    });

    test('ignores stock MeshCore (V1) frames', () {
      final v1 = _hex(relayedDm)..[0] = 0x09;
      expect(AmateurFrame.unwrap(v1), isNull);
    });

    test('ignores frames too short to hold an ID', () {
      expect(AmateurFrame.unwrap(Uint8List.fromList([0x49, 0, 0x57])), isNull);
    });

    test('reads a full 8-letter ID without a terminator', () {
      final raw = Uint8List.fromList([0x55, 0x00, ...'ABCDEFGH'.codeUnits]);
      expect(AmateurFrame.unwrap(raw)!.station, 'ABCDEFGH');
    });
  });

  group('call signs', () {
    test('accepts US formats', () {
      for (final c in [
        'W1AW',
        'K7A',
        'N0ABC',
        'KD2ABC',
        'WA6XY',
        'AL7Q',
        'kd2abc',
      ]) {
        expect(isUsCallsign(c), isTrue, reason: c);
      }
    });

    test('rejects others', () {
      for (final c in [
        '',
        'W1',
        '1AW',
        'ABC1D',
        'AM1X',
        'VE3ABC',
        'W1ABCD',
        'W12AB',
        'NONAME',
      ]) {
        expect(isUsCallsign(c), isFalse, reason: c);
      }
    });

    test('takes the call sign from a node name', () {
      expect(callsignOf('W1AW'), 'W1AW');
      expect(callsignOf('kd2abc-7'), 'KD2ABC');
      expect(callsignOf('N0XY Hilltop repeater'), 'N0XY');
      expect(callsignOf('Heltec Repeater'), isNull);
      expect(callsignOf('Base W1AW'), isNull);
    });
  });

  test('allows only 70 cm and 33 cm', () {
    expect(isAmateurFrequencyMHz(906.875), isTrue);
    expect(isAmateurFrequencyMHz(433.5), isTrue);
    expect(isAmateurFrequencyMHz(902.0), isTrue);
    expect(isAmateurFrequencyMHz(928.0), isTrue);
    expect(isAmateurFrequencyMHz(869.618), isFalse);
    expect(isAmateurFrequencyMHz(910.525 + 20), isFalse);
    expect(isAmateurFrequencyMHz(419.9), isFalse);
  });

  test('picture chunks fit a ham GRP_DATA packet', () {
    expect(amateurMaxGroupDataBytes, 157);
    expect(kImageChunkBlobBytes, lessThanOrEqualTo(amateurMaxGroupDataBytes));
  });
}
