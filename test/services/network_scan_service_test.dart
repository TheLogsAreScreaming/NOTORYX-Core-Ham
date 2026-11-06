import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/connector/meshcore_connector.dart';
import 'package:meshcore_open/connector/meshcore_protocol.dart';
import 'package:meshcore_open/models/network_scan.dart';
import 'package:meshcore_open/models/radio_rx_packet.dart';
import 'package:meshcore_open/services/network_scan_service.dart';
import 'package:meshcore_open/storage/prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A flood advert from a node whose key starts with [keyByte], typed and
/// named as given, optionally with a position.
Uint8List advert(
  int keyByte,
  String name, {
  int type = 2,
  bool located = true,
}) {
  final b = BytesBuilder()
    ..addByte((0x04 << 2) | 0x01)
    ..addByte(0) // no path
    ..add(List.filled(32, keyByte))
    ..add(List.filled(4, 0))
    ..add(List.filled(64, 0))
    ..addByte(0x80 | (located ? 0x10 : 0) | type);
  if (located) b.add(List.filled(8, 1));
  b.add(utf8.encode(name));
  return b.toBytes();
}

class _Radio extends MeshCoreConnector {
  _Radio();

  final rx = StreamController<RadioRxPacket>.broadcast();
  final frames = StreamController<Uint8List>.broadcast();

  /// Nodes that answer a discover ping, per frequency (kHz): key byte, type.
  final answering = <int, List<(int, int)>>{};
  int tunedKHz = 910525;
  final sent = <Uint8List>[];
  bool connected = true;
  int? freq = 910525, bw = 62500, sf = 7, cr = 5;
  bool autoAdd = true;

  /// What each frequency (kHz) has on air.
  final onAir = <int, List<Uint8List>>{};

  @override
  bool get isConnected => connected;
  @override
  int? get currentFreqHz => freq;
  @override
  int? get currentBwHz => bw;
  @override
  int? get currentSf => sf;
  @override
  int? get currentCr => cr;
  @override
  bool? get autoAddUsers => autoAdd;
  @override
  bool? get autoAddRepeaters => autoAdd;
  @override
  bool? get autoAddRoomServers => autoAdd;
  @override
  bool? get autoAddSensors => autoAdd;
  @override
  bool? get autoAddOverwriteOldest => false;
  @override
  Stream<RadioRxPacket> get rxPackets => rx.stream;
  @override
  Stream<Uint8List> get receivedFrames => frames.stream;
  @override
  Future<void> refreshDeviceInfo() async {}

  List<int> get tunedTo => [
    for (final f in sent)
      if (f[0] == cmdSetRadioParams)
        ByteData.sublistView(f).getUint32(1, Endian.little),
  ];

  List<int> get autoAddFlags => [
    for (final f in sent)
      if (f[0] == cmdSetAutoAddConfig) f[1],
  ];

  @override
  Future<void> sendFrame(
    Uint8List data, {
    String? channelSendQueueId,
    bool expectsGenericAck = false,
    bool waitForGenericAck = false,
  }) async {
    sent.add(data);
    if (!connected) return;
    if (data[0] == cmdSendControlData) {
      final tag = ByteData.sublistView(data).getUint32(3, Endian.little);
      for (final (keyByte, type)
          in answering[tunedKHz] ?? const <(int, int)>[]) {
        final b = BytesBuilder()
          ..add([pushCodeControlData, 20, 0xA0, 0])
          ..addByte((controlSubtypeDiscoverResp << 4) | type)
          ..addByte(8);
        final t = ByteData(4)..setUint32(0, tag, Endian.little);
        b
          ..add(t.buffer.asUint8List())
          ..add(List.filled(8, keyByte));
        Timer(const Duration(milliseconds: 5), () => frames.add(b.toBytes()));
      }
      return;
    }
    if (data[0] != cmdSetRadioParams) return;
    final f = ByteData.sublistView(data).getUint32(1, Endian.little);
    tunedKHz = f;
    for (final raw in onAir[f] ?? const <Uint8List>[]) {
      Timer(const Duration(milliseconds: 5), () {
        rx.add(
          RadioRxPacket(
            raw: raw,
            snr: 6.5,
            rssi: -97,
            receivedAt: DateTime.now(),
          ),
        );
      });
    }
  }
}

const usa = ScanTarget(name: 'USA', freqKHz: 910525, bwHz: 62500, sf: 7, cr: 5);
const ms = ScanTarget(
  name: 'MediumSlow',
  freqKHz: 914875,
  bwHz: 250000,
  sf: 10,
  cr: 5,
);
const quiet = ScanTarget(
  name: 'Quiet',
  freqKHz: 918000,
  bwHz: 250000,
  sf: 11,
  cr: 8,
);

void main() {
  late _Radio radio;
  late NetworkScanService service;
  var sos = false, trip = false;
  const dwell = Duration(milliseconds: 40);

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    PrefsManager.reset();
    await PrefsManager.initialize();
    sos = false;
    trip = false;
    radio = _Radio();
    service = NetworkScanService(
      radio,
      sosActive: () => sos,
      tripActive: () => trip,
      locate: () async => (lat: 41.3, lon: -73.1),
      settleTime: Duration.zero,
      quickListen: const Duration(milliseconds: 40),
      quickLinger: const Duration(milliseconds: 40),
    )..load();
  });
  tearDown(() {
    service.dispose();
    PrefsManager.reset();
  });

  test('reads a node from its advert, and nothing from other packets', () {
    final node = parseAdvertNode(advert(0xAB, 'Ridge RPT'))!;
    expect(node.key, 'abababab');
    expect(node.name, 'Ridge RPT');
    expect(node.type, 2);
    expect(
      parseAdvertNode(advert(1, 'Cam', type: 1, located: false))!.name,
      'Cam',
    );
    expect(parseAdvertNode(Uint8List.fromList([0x15, 0, 1, 2])), isNull);
    expect(parseAdvertNode(Uint8List(0)), isNull);
    expect(parseAdvertNode(Uint8List.fromList([0x11, 0, 1])), isNull);
  });

  test(
    'scans each network, logs what it heard and puts the radio back',
    () async {
      radio.onAir[ms.freqKHz] = [
        advert(0xAB, 'Hilltop'),
        advert(0xCD, 'Valley'),
      ];
      final results = await service.scan(
        [usa, ms, quiet],
        mode: ScanMode.thorough,
        dwell: dwell,
      );

      // The radio's own settings are skipped, then it's tuned back to them.
      expect(radio.tunedTo, [ms.freqKHz, quiet.freqKHz, usa.freqKHz]);
      // Auto-add off for the scan, then back on.
      expect(radio.autoAddFlags.first & 0x0F, 0);
      expect(radio.autoAddFlags.last & 0x0F, isNot(0));

      final s = results.single;
      expect(s.target.name, 'MediumSlow');
      expect(s.packets, 2);
      expect(s.bestSnr, 6.5);
      expect(s.bestRssi, -97);
      expect(s.latitude, 41.3);
      expect(
        s.nodes.map((n) => n.name),
        unorderedEquals(['Hilltop', 'Valley']),
      );
      expect(service.running, isFalse);
      expect(service.lastResults, results);
      expect(
        PrefsManager.instance.getString('notoryx_network_scan_restore_v1'),
        isNull,
      );

      final reloaded = NetworkScanService(radio)..load();
      expect(reloaded.log.single.target.signature, ms.signature);
      expect(reloaded.latestByNetwork().single.nodes, hasLength(2));
      reloaded.dispose();
    },
  );

  test('cancelling stops at once and still restores the radio', () async {
    final scan = service.scan(
      [ms, quiet],
      mode: ScanMode.thorough,
      dwell: const Duration(seconds: 5),
    );
    await Future<void>.delayed(const Duration(milliseconds: 20));
    expect(service.running, isTrue);
    expect(service.current?.name, 'MediumSlow');
    service.cancel();
    await scan;
    expect(radio.tunedTo, [ms.freqKHz, usa.freqKHz]);
    expect(service.stoppedBy, ScanBlock.none);
  });

  test('an SOS blocks a scan, and a trip stops one at the next step', () async {
    sos = true;
    expect(
      await service.scan([ms], mode: ScanMode.thorough, dwell: dwell),
      isEmpty,
    );
    expect(radio.sent, isEmpty);
    expect(service.stoppedBy, ScanBlock.sos);

    sos = false;
    final scan = service.scan(
      [ms, quiet],
      mode: ScanMode.thorough,
      dwell: dwell,
    );
    await Future<void>.delayed(const Duration(milliseconds: 10));
    trip = true;
    await scan;
    expect(radio.tunedTo, [ms.freqKHz, usa.freqKHz]);
    expect(service.stoppedBy, ScanBlock.trip);
  });

  test('without a radio or its settings, nothing is sent', () async {
    radio.freq = null;
    expect(service.block, ScanBlock.noSettings);
    await service.scan([ms], mode: ScanMode.thorough, dwell: dwell);
    radio.freq = 910525;
    radio.connected = false;
    expect(service.block, ScanBlock.noRadio);
    await service.scan([ms], mode: ScanMode.thorough, dwell: dwell);
    expect(radio.sent, isEmpty);
  });

  test(
    'a scan the app could not finish is undone on the next connect',
    () async {
      await PrefsManager.instance.setString(
        'notoryx_network_scan_restore_v1',
        jsonEncode(usa.toJson()),
      );
      // The radio came back still tuned to the network being scanned.
      radio.freq = ms.freqKHz;
      radio.bw = ms.bwHz;
      radio.sf = ms.sf;
      radio.notifyListeners();
      // The connector batches change notices.
      await Future<void>.delayed(const Duration(milliseconds: 300));
      expect(radio.tunedTo, [usa.freqKHz]);
      expect(
        PrefsManager.instance.getString('notoryx_network_scan_restore_v1'),
        isNull,
      );
    },
  );

  test('suggests same-band presets and saved networks, not your own', () async {
    await service.saveNetwork(ms);
    final names = service.suggestedTargets().map((t) => t.name).toList();
    expect(names, contains('MediumSlow'));
    expect(names, isNot(contains('USA')));
    expect(
      service.suggestedTargets().every(
        (t) => t.freqKHz >= 902000 && t.freqKHz <= 928000,
      ),
      isTrue,
    );
    expect(service.isSaved(ms), isTrue);
    await service.removeSaved(ms);
    expect(service.saved, isEmpty);
  });

  test('joining a network tunes the radio to it', () async {
    await service.join(ms);
    expect(radio.tunedTo, [ms.freqKHz]);
  });

  test('exports CSV safely and GPX for located sightings', () {
    final s = NetworkSighting(
      target: ms.withName('=HYPERLINK("x")'),
      at: DateTime.utc(2026, 11, 5, 12),
      latitude: 41.3,
      longitude: -73.1,
      packets: 3,
      bestSnr: 4.25,
      bestRssi: -101,
      nodes: const [HeardNode(key: 'abcd', name: 'A "B"')],
    );
    final csv = networkLogCsv([s]);
    expect(csv, contains('"\'=HYPERLINK(""x"")"'));
    expect(csv, contains('914.875,250.0,10,5,41.300000,-73.100000,3,4.3,-101'));
    expect(csv, contains('"A ""B"""'));
    final gpx = networkLogGpx([
      s,
      NetworkSighting(
        target: quiet,
        at: DateTime.utc(2026),
        packets: 1,
        bestSnr: 0,
        bestRssi: -120,
      ),
    ]);
    expect('<wpt'.allMatches(gpx), hasLength(1));
    expect(gpx, contains('=HYPERLINK(&quot;x&quot;)'));
  });

  test('targets outside what radios accept are refused', () {
    expect(ScanTarget.fromJson({...ms.toJson(), 'sf': 13}), isNull);
    expect(ScanTarget.fromJson({...ms.toJson(), 'freqKHz': 'x'}), isNull);
    expect(ms.summary, '914.875 MHz · 250 kHz · SF10 · CR 4/5');
    expect(usa.summary, '910.525 MHz · 62.5 kHz · SF7 · CR 4/5');
  });

  test('a quick scan pings each network and logs who answered', () async {
    radio.answering[ms.freqKHz] = [(0xAB, 2), (0xCD, 3)];
    final results = await service.scan([ms, quiet]);
    expect(radio.tunedTo, [ms.freqKHz, quiet.freqKHz, usa.freqKHz]);
    final pings = radio.sent.where((f) => f[0] == cmdSendControlData);
    expect(pings, hasLength(2));
    final s = results.single;
    expect(s.target.name, 'MediumSlow');
    expect(s.packets, 2);
    expect(s.bestSnr, 5);
    expect(
      s.nodes.map((n) => n.key),
      unorderedEquals(['abababab', 'cdcdcdcd']),
    );
    expect(s.nodes.map((n) => n.type), unorderedEquals([2, 3]));
  });

  test('a quick scan names answering nodes from their adverts', () async {
    radio.answering[ms.freqKHz] = [(0xAB, 2)];
    radio.onAir[ms.freqKHz] = [advert(0xAB, 'Hilltop')];
    final s = (await service.scan([ms])).single;
    expect(s.nodes.single.name, 'Hilltop');
  });

  test('after the first finds, the default list is short', () async {
    final first = service.suggestedTargets(countryCode: 'US');
    expect(first.length, greaterThan(5));
    service.debugSeed(
      log: [
        NetworkSighting(
          target: ms,
          at: DateTime.now(),
          packets: 1,
          bestSnr: 0,
          bestRssi: -100,
        ),
      ],
    );
    final names = service
        .suggestedTargets(countryCode: 'US')
        .map((t) => t.name)
        .toList();
    // USA is the radio's own settings here, so only what was heard is left.
    expect(names, ['MediumSlow']);
    expect(service.suggestedTargets(countryCode: 'AU').map((t) => t.name), [
      'MediumSlow',
      'Australia',
    ]);
  });

  test('estimates how long a scan takes', () {
    final quick = NetworkScanService(radio);
    expect(
      quick.estimate(5, ScanMode.quick, const Duration(seconds: 45)),
      const Duration(milliseconds: 44000),
    );
    expect(
      quick.estimate(5, ScanMode.thorough, const Duration(seconds: 45)),
      const Duration(seconds: 225),
    );
    quick.dispose();
  });
}
