import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/station_log.dart';

void main() {
  final t0 = DateTime.utc(2026, 11, 8, 14, 5, 9);

  test('messages with one station close together are one entry', () {
    var log = logMessage(
      const [],
      call: 'kd2abc',
      at: t0,
      outgoing: true,
      freqKhz: 906875,
    );
    log = logMessage(
      log,
      call: 'KD2ABC',
      at: t0.add(const Duration(minutes: 20)),
      outgoing: false,
    );
    log = logMessage(
      log,
      call: 'KD2ABC',
      at: t0.add(const Duration(minutes: 45)),
      outgoing: false,
    );
    expect(log, hasLength(1));
    final e = log.single;
    expect(e.call, 'KD2ABC');
    expect(e.start, t0);
    expect(e.end, t0.add(const Duration(minutes: 45)));
    expect((e.sent, e.received), (1, 2));
    expect(e.band, '33cm');
  });

  test('a gap of 30 minutes or more starts a new entry', () {
    var log = logMessage(const [], call: 'W1AW', at: t0, outgoing: true);
    log = logMessage(log, call: 'N0RPT', at: t0, outgoing: false);
    log = logMessage(
      log,
      call: 'W1AW',
      at: t0.add(stationLogGap),
      outgoing: true,
    );
    expect(log.map((e) => e.call), ['W1AW', 'N0RPT', 'W1AW']);
  });

  test('the newest entry for a call moves to the top', () {
    var log = logMessage(const [], call: 'W1AW', at: t0, outgoing: true);
    log = logMessage(log, call: 'N0RPT', at: t0, outgoing: true);
    log = logMessage(
      log,
      call: 'W1AW',
      at: t0.add(const Duration(minutes: 1)),
      outgoing: false,
    );
    expect(log.map((e) => e.call), ['W1AW', 'N0RPT']);
  });

  test('keeps the newest $stationLogMax entries', () {
    var log = <StationLogEntry>[];
    for (var i = 0; i < stationLogMax + 5; i++) {
      log = logMessage(
        log,
        call: 'W1AW',
        at: t0.add(stationLogGap * i),
        outgoing: true,
      );
    }
    expect(log, hasLength(stationLogMax));
    expect(log.first.start, t0.add(stationLogGap * (stationLogMax + 4)));
  });

  test('bands are the two the ham firmware allows', () {
    expect(bandFor(433000), '70cm');
    expect(bandFor(906875), '33cm');
    expect(bandFor(869525), isNull);
    expect(bandFor(null), isNull);
  });

  test('JSON round trip, and bad rows are skipped', () {
    final e = StationLogEntry(
      call: 'W1AW',
      start: t0,
      end: t0.add(const Duration(minutes: 3)),
      freqKhz: 433000,
      sent: 2,
      received: 1,
    );
    expect(StationLogEntry.fromJson(e.toJson()), e);
    expect(StationLogEntry.fromJson({'call': 'W1AW'}), isNull);
    expect(StationLogEntry.fromJson('nope'), isNull);
  });

  test('ADIF has a header and one record per entry, oldest first', () {
    var log = logMessage(
      const [],
      call: 'W1AW',
      at: t0,
      outgoing: true,
      freqKhz: 906875,
    );
    log = logMessage(
      log,
      call: 'N0RPT',
      at: t0.add(const Duration(hours: 1)),
      outgoing: false,
    );
    final adi = stationLogAdif(
      log,
      stationCall: 'kd2abc',
      programVersion: '0.1.0-test.6',
      now: DateTime.utc(2026, 11, 8, 16),
    );
    expect(adi, contains('<ADIF_VER:5>3.1.5'));
    expect(adi, contains('<PROGRAMVERSION:12>0.1.0-test.6'));
    expect(adi, contains('<CREATED_TIMESTAMP:15>20261108 160000'));
    final records = adi.split('<EOH>').last.trim().split('\n');
    expect(records, hasLength(2));
    expect(
      records.first,
      '<CALL:4>W1AW<QSO_DATE:8>20261108<TIME_ON:6>140509'
      '<QSO_DATE_OFF:8>20261108<TIME_OFF:6>140509<BAND:4>33cm'
      '<FREQ:7>906.875<STATION_CALLSIGN:6>KD2ABC'
      '<APP_NOTORYXHAM_MODE:4>LORA'
      '<COMMENT:38>MeshCore LoRa text, 1 sent, 0 received<EOR>',
    );
    // No band or frequency known: those fields are left out, not guessed.
    expect(records.last, startsWith('<CALL:5>N0RPT'));
    expect(records.last, isNot(contains('<BAND')));
    expect(records.last, isNot(contains('<FREQ')));
    // ADIF has no LoRa mode, so MODE is never written.
    expect(adi, isNot(contains('<MODE')));
  });

  test('CSV, newest first', () {
    final log = logMessage(
      const [],
      call: 'W1AW',
      at: t0,
      outgoing: true,
      freqKhz: 433000,
    );
    expect(
      stationLogCsv(log),
      'call,start_utc,end_utc,band,frequency_mhz,sent,received\n'
      'W1AW,2026-11-08T14:05:09.000Z,2026-11-08T14:05:09.000Z,70cm,'
      '433.000,1,0\n',
    );
  });
}
