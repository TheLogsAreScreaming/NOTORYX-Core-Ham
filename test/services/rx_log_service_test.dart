import 'dart:async';
import 'dart:typed_data';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/radio_rx_packet.dart';
import 'package:meshcore_open/services/rx_log_service.dart';

/// A flood packet of [payloadType] that passed through [path] (1-byte hops).
RadioRxPacket packet(
  int payloadType, {
  List<int> path = const [],
  int routeType = 1,
  double snr = 6.25,
  int rssi = -92,
  DateTime? at,
}) => RadioRxPacket(
  raw: Uint8List.fromList([
    (payloadType << 2) | routeType,
    if (routeType == 0 || routeType == 3) ...[0, 0, 0, 0],
    path.length,
    ...path,
    0xDE,
    0xAD,
    0xBE,
    0xEF,
  ]),
  snr: snr,
  rssi: rssi,
  receivedAt: at ?? DateTime.utc(2026, 11, 7, 12),
);

void main() {
  test('decodes kind, route, hops and path', () {
    final e = RxLogEntry.from(packet(payloadTypeADVERT, path: [0xA1, 0x3F]))!;
    expect(e.kind, RxKind.advert);
    expect(e.isDirect, isFalse);
    expect(e.hops, 2);
    expect(e.pathHashes, ['A1', '3F']);
    expect(e.info.payload, [0xDE, 0xAD, 0xBE, 0xEF]);

    final direct = RxLogEntry.from(packet(payloadTypeTXTMSG, routeType: 2))!;
    expect(direct.kind, RxKind.direct);
    expect(direct.isDirect, isTrue);
    expect(direct.hops, 0);
    expect(direct.pathHashes, isEmpty);
  });

  test('two-byte path hashes are grouped per hop', () {
    final raw = Uint8List.fromList([
      (payloadTypeGRPTXT << 2) | 1,
      0x40 | 2, // two hops, two bytes each
      0xA1, 0xB2, 0x3F, 0x4E,
      0x01,
    ]);
    final e = RxLogEntry.from(
      RadioRxPacket(raw: raw, snr: 0, rssi: -100, receivedAt: DateTime(2026)),
    )!;
    expect(e.kind, RxKind.channel);
    expect(e.pathHashes, ['A1B2', '3F4E']);
  });

  test('malformed packets are skipped', () {
    final short = RadioRxPacket(
      raw: Uint8List.fromList([0x11, 0x05, 0x01]),
      snr: 0,
      rssi: 0,
      receivedAt: DateTime(2026),
    );
    expect(RxLogEntry.from(short), isNull);
  });

  test('keeps the newest packets up to its capacity', () {
    fakeAsync((async) {
      final controller = StreamController<RadioRxPacket>.broadcast();
      final log = RxLogService(controller.stream, capacity: 3);
      for (var i = 0; i < 5; i++) {
        controller.add(packet(payloadTypeACK, rssi: -100 + i));
      }
      async.flushMicrotasks();
      expect(log.entries.map((e) => e.rssi), [-96, -97, -98]);
      expect(log.total, 5);
      log.dispose();
      unawaited(controller.close());
    });
  });

  test('pause ignores packets and clear empties the log', () {
    fakeAsync((async) {
      final controller = StreamController<RadioRxPacket>.broadcast();
      final log = RxLogService(controller.stream);
      var notified = 0;
      log.addListener(() => notified++);

      controller.add(packet(payloadTypeADVERT));
      controller.add(packet(payloadTypeADVERT));
      async.flushMicrotasks();
      expect(notified, 0, reason: 'redraws are batched');
      async.elapse(const Duration(milliseconds: 250));
      expect(notified, 1);

      log.paused = true;
      controller.add(packet(payloadTypeADVERT));
      async.flushMicrotasks();
      expect(log.entries, hasLength(2));

      log.clear();
      expect(log.entries, isEmpty);
      expect(log.total, 0);
      log.dispose();
      unawaited(controller.close());
    });
  });

  test('CSV is oldest first with the raw packet in hex', () {
    final entries = [
      RxLogEntry.from(
        packet(
          payloadTypeTXTMSG,
          routeType: 2,
          at: DateTime.utc(2026, 11, 7, 12, 1),
        ),
      )!,
      RxLogEntry.from(
        packet(
          payloadTypeADVERT,
          path: [0xA1],
          at: DateTime.utc(2026, 11, 7, 12),
        ),
      )!,
    ];
    final lines = rxLogCsv(entries).trim().split('\n');
    expect(lines, hasLength(3));
    expect(lines.first, startsWith('time_utc,kind,'));
    expect(
      lines[1],
      startsWith('2026-11-07T12:00:00.000Z,advert,4,flood,1,A1,6.25,-92,7,'),
    );
    // No station ID on these packets: the station column is empty.
    expect(lines[1], endsWith(',0,,1101A1DEADBEEF'));
    expect(lines[2], contains(',direct,2,direct,0,,'));
  });

  test('the station ID is kept and exported', () {
    final e = RxLogEntry.from(
      RadioRxPacket(
        raw: Uint8List.fromList([0x11, 0, 0xCA, 0xFE]),
        snr: 1,
        rssi: -90,
        receivedAt: DateTime.utc(2026, 11, 8),
        station: 'N0RPT',
      ),
    )!;
    expect(e.station, 'N0RPT');
    expect(
      rxLogCsv([e]).trim().split('\n').last,
      endsWith(',0,N0RPT,1100CAFE'),
    );
  });

  test('every payload type has a kind', () {
    expect(rxKindFor(payloadTypeACK), RxKind.ack);
    expect(rxKindFor(payloadTypePATH), RxKind.path);
    expect(rxKindFor(payloadTypeTRACE), RxKind.trace);
    expect(rxKindFor(payloadTypeCONTROL), RxKind.control);
    expect(rxKindFor(payloadTypeRESPONSE), RxKind.direct);
    expect(rxKindFor(0x0F), RxKind.other);
  });
}
