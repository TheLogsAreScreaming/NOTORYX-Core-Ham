import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/models/direct_repeaters.dart';
import 'package:meshcore_open/models/radio_rx_packet.dart';
import 'package:meshcore_open/services/direct_repeater_service.dart';

/// A flood packet (route type 1) with [path] hops of [width] bytes each.
Uint8List _flood(List<int> path, {int width = 1, int payloadType = 5}) {
  final hops = path.length ~/ width;
  return Uint8List.fromList([
    (payloadType << 2) | 1,
    hops | ((width - 1) << 6),
    ...path,
    1,
    2,
    3,
    4,
  ]);
}

RadioRxPacket _rx(Uint8List raw, double snr, DateTime at) =>
    RadioRxPacket(raw: raw, snr: snr, rssi: -90, receivedAt: at);

void main() {
  group('heardDirectlyFrom', () {
    test('is the last hop of a flood', () {
      expect(heardDirectlyFrom(_flood([0x11, 0x3d])), [0x3d]);
      expect(heardDirectlyFrom(_flood([0x11, 0x22, 0x3d, 0x4a], width: 2)), [
        0x3d,
        0x4a,
      ]);
    });

    test('is the sender of a zero-hop advert', () {
      final key = List<int>.generate(32, (i) => i + 1);
      final raw = Uint8List.fromList([(4 << 2) | 1, 0, ...key, 9, 9]);
      expect(heardDirectlyFrom(raw), key);
    });

    test('is unknown for direct routes, zero-hop messages and junk', () {
      final direct = _flood([0x3d])..[0] = (5 << 2) | 2;
      expect(heardDirectlyFrom(direct), isNull);
      expect(heardDirectlyFrom(_flood([])), isNull);
      expect(heardDirectlyFrom(Uint8List.fromList([5, 3, 1])), isNull);
    });

    test('skips transport codes on transport floods', () {
      final raw = Uint8List.fromList([(5 << 2) | 0, 9, 9, 9, 9, 1, 0x3d, 7]);
      expect(heardDirectlyFrom(raw), [0x3d]);
    });
  });

  test('ranking favours strong signal and recent contact', () {
    final now = DateTime.utc(2026, 10, 28, 12);
    final strongButQuiet = DirectHeard(
      id: 'AA',
      snr: 10,
      lastHeard: now.subtract(const Duration(minutes: 50)),
    );
    final steady = DirectHeard(id: 'BB', snr: 6, lastHeard: now);
    final old = DirectHeard(
      id: 'CC',
      snr: 12,
      lastHeard: now.subtract(const Duration(hours: 2)),
    );
    final ranked = rankDirect([strongButQuiet, steady, old], now);
    expect(ranked.map((h) => h.id), ['BB', 'AA']);
  });

  test('the service averages repeated readings per repeater', () async {
    final connector = MeshCoreConnector();
    final service = DirectRepeaterService(
      connector,
      clock: () => DateTime.utc(2026, 10, 28, 12),
    );
    addTearDown(service.dispose);
    final at = DateTime.utc(2026, 10, 28, 11, 59);
    service.record(_rx(_flood([0x11, 0x3d]), 10, at));
    service.record(_rx(_flood([0x3d]), 0, at));
    service.record(_rx(_flood([0x22, 0x4b]), -8, at));
    final best = service.best();
    expect(best.map((h) => h.id), ['3D', '4B']);
    expect(best.first.count, 2);
    expect(best.first.snrAverage, closeTo(7, 0.01)); // 10 + 0.3 * (0 - 10)
  });
}
