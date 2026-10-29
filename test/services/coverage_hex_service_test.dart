import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/models/coverage_hex.dart';
import 'package:meshcore_open/models/radio_rx_packet.dart';
import 'package:meshcore_open/services/coverage_hex_service.dart';
import 'package:meshcore_open/services/network_monitor.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Cells implements CellIndexer {
  @override
  String cellOf(double lat, double lon) => 'cell-${lat.round()}';
  @override
  ({double lat, double lon}) centerOf(String cell) => (lat: 1, lon: 2);
  @override
  List<({double lat, double lon})> boundaryOf(String cell) => const [];
}

class _Net implements NetworkMonitor {
  NetworkStatus status = const NetworkStatus({'wifi'});
  @override
  Future<NetworkStatus> current() async => status;
  @override
  Stream<NetworkStatus> get changes => const Stream.empty();
}

class _Store implements CoverageStore {
  String? data;
  @override
  Future<String?> read() async => data;
  @override
  Future<void> write(String d) async => data = d;
}

/// A flooded packet whose last hop was repeater [hop].
RadioRxPacket _packet(DateTime at, int hop, {double snr = 4}) => RadioRxPacket(
  raw: Uint8List.fromList([0x15, 0x01, hop, 0x00]),
  snr: snr,
  rssi: -90,
  receivedAt: at,
);

void main() {
  late DateTime now;
  late _Net net;
  late List<http.Request> posts;
  late CoverageHexService service;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    now = DateTime.utc(2026, 10, 28, 9, 5);
    net = _Net();
    posts = [];
    service = CoverageHexService(
      MeshCoreConnector(),
      indexer: _Cells(),
      fixes: () => const Stream.empty(),
      network: net,
      store: _Store(),
      clock: () => now,
      client: MockClient((req) async {
        posts.add(req);
        return http.Response('', 200);
      }),
    );
    await service.load();
  });

  tearDown(() => service.dispose());

  test('rough or stale fixes record nothing', () {
    service.fixForTesting = PositionFix(47, -122, 500, now);
    service.recordForTesting(_packet(now, 0x5a));
    expect(service.sampleCount, 0);
    service.fixForTesting = PositionFix(47, -122, 10, now);
    service.recordForTesting(
      _packet(now.add(const Duration(minutes: 2)), 0x5a),
    );
    expect(service.sampleCount, 0);
    service.recordForTesting(_packet(now, 0x5a));
    expect(service.sampleCount, 1);
    expect(service.cells.keys, ['cell-47']);
  });

  test('queued samples upload once due, and only once', () async {
    service.fixForTesting = PositionFix(47, -122, 10, now);
    service.recordForTesting(_packet(now, 0x5a));
    final target = CoverageTarget(
      id: 't',
      name: 'Map',
      url: 'https://map.example/up',
      apiKey: 'k',
      privacy: CoveragePrivacy.live,
    );
    await service.saveTarget(target);

    await service.upload(); // bucket still open
    expect(posts, isEmpty);

    now = DateTime.utc(2026, 10, 28, 9, 20);
    net.status = NetworkStatus.offline;
    await service.upload(); // offline: stays queued
    expect(posts, isEmpty);
    expect(service.pendingFor(target), 1);

    net.status = const NetworkStatus({'wifi'});
    await service.upload();
    await service.upload();
    expect(posts, hasLength(1));
    expect(posts.single.headers['X-API-Key'], 'k');
    expect(posts.single.headers['X-Notoryx-Signature'], isNotNull);
    final body = jsonDecode(posts.single.body) as Map;
    expect((body['cells'] as List).single['cell'], 'cell-47');
    expect(service.pendingFor(target), 0);
  });

  test('wifi-only waits for wifi; anonymous uploads are unsigned', () async {
    service.fixForTesting = PositionFix(47, -122, 10, now);
    service.recordForTesting(_packet(now, 0x5a));
    await service.saveTarget(
      const CoverageTarget(
        id: 'a',
        name: 'Anon',
        url: 'https://map.example/up',
        privacy: CoveragePrivacy.anonymous,
      ),
    );
    now = now.add(const Duration(hours: 25));
    net.status = const NetworkStatus({'mobile'});
    await service.upload();
    expect(posts, isEmpty);
    await service.setWifiOnly(false);
    await service.upload();
    expect(posts, hasLength(1));
    expect(posts.single.headers.containsKey('X-Notoryx-Signature'), isFalse);
  });
}
