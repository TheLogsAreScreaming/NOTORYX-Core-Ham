import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/coverage_hex.dart';

void main() {
  test('samples group into 15-minute buckets per cell', () {
    final grid = CoverageGrid();
    final t = DateTime.utc(2026, 10, 28, 9, 7);
    grid.record(cell: 'a', time: t, snr: 2, rssi: -90, repeater: '5A');
    grid.record(
      cell: 'a',
      time: t.add(const Duration(minutes: 5)),
      snr: 6,
      rssi: -80,
      repeater: '5A',
    );
    grid.record(
      cell: 'a',
      time: t.add(const Duration(minutes: 9)),
      snr: 1,
      rssi: -95,
    );
    expect(grid.samples, hasLength(2));
    final first = grid.samples.values.first;
    expect(first.bucket, DateTime.utc(2026, 10, 28, 9));
    expect(first.count, 2);
    expect(first.bestSnr, 6);
    expect(first.repeaters, {'5A': 6});
    expect(grid.bestByCell(), {'a': 6});
  });

  test('privacy delays hold samples back', () {
    final s = HexSample(cell: 'a', bucket: DateTime.utc(2026, 10, 28, 9));
    final closed = DateTime.utc(2026, 10, 28, 9, 15);
    expect(s.dueFor(CoveragePrivacy.live, closed), isTrue);
    expect(
      s.dueFor(
        CoveragePrivacy.live,
        closed.subtract(const Duration(minutes: 1)),
      ),
      isFalse,
    );
    expect(
      s.dueFor(CoveragePrivacy.delayed, closed.add(const Duration(hours: 2))),
      isFalse,
    );
    expect(
      s.dueFor(CoveragePrivacy.delayed, closed.add(const Duration(hours: 3))),
      isTrue,
    );
    expect(
      s.dueFor(
        CoveragePrivacy.anonymous,
        closed.add(const Duration(hours: 23)),
      ),
      isFalse,
    );
  });

  test('payloads never include the phone position', () {
    final s = HexSample(
      cell: '88283082a3fffff',
      bucket: DateTime.utc(2026, 10, 28, 9, 15),
    )..add(5.123, -88, '5A');
    final hex = hexagonPayload([s], CoveragePrivacy.delayed);
    final cell = (hex['cells'] as List).single as Map;
    expect(cell['cell'], '88283082a3fffff');
    expect(cell['time'], '2026-10-28T09:15:00.000Z');
    expect(cell['best_snr'], 5.12);
    expect(cell.containsKey('lat'), isFalse);

    final anon = hexagonPayload([s], CoveragePrivacy.anonymous);
    expect(
      ((anon['cells'] as List).single as Map)['time'],
      '2026-10-28T00:00:00.000Z',
    );

    final mm = meshMapperPayload(
      [s],
      CoveragePrivacy.live,
      (_) => (lat: 47.6, lon: -122.3),
    );
    final ping = (mm['data'] as List).single as Map;
    expect(ping['type'], 'RX');
    expect(ping['lat'], 47.6);
    expect(ping['heard_repeats'], '5A(5.12)');
    expect(
      ping['timestamp'],
      DateTime.utc(2026, 10, 28, 9, 15).millisecondsSinceEpoch ~/ 1000,
    );
  });

  test('only https upload URLs are accepted', () {
    expect(CoverageTarget.isValidUrl('https://map.example/upload'), isTrue);
    expect(CoverageTarget.isValidUrl('http://map.example/upload'), isFalse);
    expect(CoverageTarget.isValidUrl('nonsense'), isFalse);
  });
}
