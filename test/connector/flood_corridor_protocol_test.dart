import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/flood_corridor.dart';

int _u32le(Uint8List b, int offset) =>
    ByteData.sublistView(b).getUint32(offset, Endian.little);

void main() {
  group('CorridorTriple wire encoding', () {
    test('matches the firmware bit layout', () {
      // Firmware: lat_enc = (lat+90)/180*16383+0.5, lon_enc likewise over 360.
      final triple = CorridorTriple(lat: 0, lon: 0, radiusCode: 8);
      const latEnc = 8192; // (90/180*16383 + 0.5).floor()
      const lonEnc = 8192;
      expect(triple.encode(), (latEnc << 18) | (lonEnc << 4) | 8);
    });

    test('clamps the poles and antimeridian to 14 bits', () {
      final word = CorridorTriple(lat: 90, lon: 180, radiusCode: 15).encode();
      expect((word >> 18) & 0x3FFF, 16383);
      expect((word >> 4) & 0x3FFF, 16383);
      expect(word & 0x0F, 15);
      expect(word, lessThanOrEqualTo(0xFFFFFFFF));
    });

    test('round-trips within the ~1.2 km quantization', () {
      final original = CorridorTriple(
        lat: 49.282729,
        lon: -123.120738,
        radiusCode: 6,
      );
      final decoded = CorridorTriple.decode(original.encode());
      expect(decoded.lat, closeTo(original.lat, 180 / 16383));
      expect(decoded.lon, closeTo(original.lon, 360 / 16383));
      expect(decoded.radiusKm, 20);
      expect(decoded, original);
    });

    test('radiusCodeFor picks the smallest covering radius', () {
      expect(CorridorTriple.radiusCodeFor(0.5), 0);
      expect(CorridorTriple.radiusCodeFor(5), 3);
      expect(CorridorTriple.radiusCodeFor(5.1), 4);
      expect(CorridorTriple.radiusCodeFor(5000), 14);
      expect(corridorRadiusKm[corridorRadiusCodeUnlimited], double.infinity);
    });
  });

  group('buildSendChannelTextMsgCorridorFrame', () {
    final corridor = [
      CorridorTriple(lat: 49.0, lon: -123.0, radiusCode: 4),
      CorridorTriple(lat: 49.5, lon: -122.5, radiusCode: 6),
    ];

    test('lays out text, triples, count and flags without a NUL', () {
      final frame = buildSendChannelTextMsgCorridorFrame(
        2,
        'hi',
        corridor,
        flags: corridorFlagFailClosed | corridorFlagDestLastTriple,
      );
      expect(frame[0], cmdSendChannelTxtMsgCorridor);
      expect(frame[1], txtTypePlain);
      expect(frame[2], 2);
      expect(frame.sublist(7, 9), 'hi'.codeUnits);
      expect(_u32le(frame, 9), corridor[0].encode());
      expect(_u32le(frame, 13), corridor[1].encode());
      expect(frame[frame.length - 2], 2);
      expect(frame.last, corridorFlagFailClosed | corridorFlagDestLastTriple);
      expect(frame.length, 7 + 2 + 8 + 2);
    });

    test('masks the firmware-reserved auto-generated flag', () {
      final frame = buildSendChannelTextMsgCorridorFrame(
        0,
        'x',
        corridor,
        flags: 0xFF,
      );
      expect(frame.last, corridorFlagFailClosed | corridorFlagDestLastTriple);
    });

    test('rejects empty or oversized corridors and oversized frames', () {
      expect(
        () => buildSendChannelTextMsgCorridorFrame(0, 'x', const []),
        throwsArgumentError,
      );
      expect(
        () => buildSendChannelTextMsgCorridorFrame(
          0,
          'x',
          List.filled(9, corridor.first),
        ),
        throwsArgumentError,
      );
      expect(
        () => buildSendChannelTextMsgCorridorFrame(
          0,
          'a' * 160,
          List.filled(8, corridor.first),
        ),
        throwsArgumentError,
      );
    });
  });

  test('buildProposeCorridorFrame encodes microdegrees and mode', () {
    final frame = buildProposeCorridorFrame(49.25, -123.1, dense: true);
    final data = ByteData.sublistView(frame);
    expect(frame[0], cmdProposeCorridor);
    expect(data.getInt32(1, Endian.little), 49250000);
    expect(data.getInt32(5, Endian.little), -123100000);
    expect(frame[9], 0x02);
    expect(buildProposeCorridorFrame(1, 1)[9], 0x00);
  });

  group('corridor region frames', () {
    test('set strips a leading # and empty resets', () {
      expect(buildSetCorridorRegionFrame('#bc-south'), [
        cmdSetCorridorRegion,
        ...'bc-south'.codeUnits,
      ]);
      expect(buildSetCorridorRegionFrame(''), [cmdSetCorridorRegion]);
      expect(() => buildSetCorridorRegionFrame('x' * 32), throwsArgumentError);
    });

    test('parses a NUL-padded region reply', () {
      final frame = Uint8List(32)..[0] = respCodeCorridorRegion;
      frame.setRange(1, 4, 'van'.codeUnits);
      expect(parseCorridorRegionFrame(frame), 'van');
      expect(
        parseCorridorRegionFrame(Uint8List(32)..[0] = respCodeCorridorRegion),
        '',
      );
      expect(parseCorridorRegionFrame(Uint8List(5)), isNull);
    });
  });

  group('parseCorridorProposalFrame', () {
    test('decodes reason and triples', () {
      final a = CorridorTriple(lat: 49, lon: -123, radiusCode: 5);
      final b = CorridorTriple(lat: 50, lon: -122, radiusCode: 8);
      final frame = Uint8List(3 + 8)
        ..[0] = respCodeProposeCorridor
        ..[1] = 0x80 | 0x08 | 0x01
        ..[2] = 2;
      ByteData.sublistView(frame)
        ..setUint32(3, a.encode(), Endian.little)
        ..setUint32(7, b.encode(), Endian.little);

      final proposal = parseCorridorProposalFrame(frame)!;
      expect(proposal.triples, [a, b]);
      expect(proposal.tier, 1);
      expect(proposal.hasThinStretch, isTrue);
      expect(proposal.isHorizonLimited, isTrue);
    });

    test('rejects truncated frames', () {
      final frame = Uint8List.fromList([respCodeProposeCorridor, 0, 2, 1, 2]);
      expect(parseCorridorProposalFrame(frame), isNull);
    });
  });
}
