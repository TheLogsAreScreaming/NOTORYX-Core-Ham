import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:meshcore_open/utils/station_id_check.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/mesh_packet_fixtures.dart';

/// A flood advert named [name] that has come [hops] hops.
Uint8List advert(String name, {int keyByte = 0xAB, int hops = 0}) {
  final b = BytesBuilder()
    ..addByte((0x04 << 2) | 0x01)
    ..addByte(hops)
    ..add(List.filled(hops, 0x11))
    ..add(List.filled(32, keyByte))
    ..add(List.filled(4, 0))
    ..add(List.filled(64, 0))
    ..addByte(0x80 | 0x02)
    ..add(utf8.encode(name));
  return b.toBytes();
}

void main() {
  final at = DateTime.utc(2026, 11, 8, 12);

  group('checkStationId', () {
    test('a matching station ID passes, SSIDs and case aside', () {
      expect(checkStationId(advert('W1AW Hilltop'), 'W1AW', at: at), isNull);
      expect(checkStationId(advert('w1aw-7 Car'), 'W1AW', at: at), isNull);
      expect(checkStationId(advert('W1AW Base'), 'w1aw-2', at: at), isNull);
    });

    test('a different call sign is a mismatch', () {
      final m = checkStationId(advert('W1AW Hilltop'), 'KD2ABC', at: at)!;
      expect(m.advertName, 'W1AW Hilltop');
      expect(m.station, 'KD2ABC');
      expect(m.namedCall, 'W1AW');
      expect(m.nodeKey, 'abababab');
      expect(m.at, at);
    });

    test('a name with no call sign is a mismatch', () {
      final m = checkStationId(advert('Ridge Repeater'), 'N0RPT', at: at)!;
      expect(m.namedCall, isNull);
    });

    test('relayed frames carry the repeater call, so are not checked', () {
      expect(
        checkStationId(advert('W1AW Hilltop', hops: 2), 'N0RPT', at: at),
        isNull,
      );
    });

    test('anything but a named advert is ignored', () {
      final unnamed = Uint8List.fromList(advert('x').sublist(0, 102))
        ..[101] = 0x02;
      expect(checkStationId(unnamed, 'N0RPT', at: at), isNull);
      expect(
        checkStationId(Uint8List.fromList([0x15, 0, 1, 2]), 'N0RPT', at: at),
        isNull,
      );
      expect(checkStationId(Uint8List(0), 'N0RPT', at: at), isNull);
      expect(checkStationId(advert('W1AW'), '', at: at), isNull);
    });
  });

  group('connector', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    late MeshCoreConnector connector;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      PrefsManager.reset();
      await PrefsManager.initialize();
      connector = MeshCoreConnector();
    });

    void hear(Uint8List raw, String station) => connector.handleFrameForTest([
      pushCodeLogRxData,
      0x1C,
      0xA4,
      ...onAir(raw, station: station),
    ]);

    test('records direct adverts whose ID differs, once per node', () async {
      hear(advert('W1AW Hilltop'), 'W1AW');
      hear(advert('W1AW Hilltop', hops: 1), 'N0RPT');
      expect(connector.stationIdMismatches, isEmpty);

      var notified = 0;
      connector.addListener(() => notified++);
      hear(advert('W1AW Hilltop'), 'KD2ABC');
      hear(advert('W1AW Hilltop'), 'KD2ABC');
      hear(advert('Valley', keyByte: 0xCD), 'N0RPT');

      final list = connector.stationIdMismatches;
      expect(list.map((m) => m.station), ['N0RPT', 'KD2ABC']);
      expect(list.last.advertName, 'W1AW Hilltop');
      // Notifications are batched; the screen hears about it once flushed.
      await Future<void>.delayed(const Duration(milliseconds: 300));
      expect(notified, greaterThan(0));
    });

    test('keeps the 20 newest', () {
      for (var i = 0; i < 25; i++) {
        hear(advert('Node $i', keyByte: i + 1), 'N0RPT');
      }
      final list = connector.stationIdMismatches;
      expect(list, hasLength(20));
      expect(list.first.advertName, 'Node 24');
      expect(list.last.advertName, 'Node 5');
    });
  });
}
