import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/operator_profile.dart';
import 'package:meshcore_open/utils/station_readiness.dart';

void main() {
  final done = OperatorProfile(
    callsign: 'W1AW',
    licenseClass: LicenseClass.general,
    acknowledgedAt: DateTime(2026, 11, 5),
  );

  test('stock firmware comes first: no setup step fixes it', () {
    expect(
      stationReadiness(
        const OperatorProfile(callsign: 'W1AW'),
        nodeName: 'Base',
        firmwareVersion: 'v1.18.0-6aab3dd0',
      ),
      StationReadiness.stockFirmware,
    );
    expect(
      stationReadiness(
        done,
        nodeName: 'W1AW Base',
        freqKhz: 915000,
        firmwareVersion: 'v1.18.0-ham-test.2-',
      ),
      StationReadiness.ready,
    );
    // A radio that hasn't reported its firmware yet isn't held against you.
    expect(
      stationReadiness(done, nodeName: 'W1AW Base', freqKhz: 915000),
      StationReadiness.ready,
    );
  });

  test('unfinished setup comes first, whatever the radio says', () {
    expect(
      stationReadiness(
        const OperatorProfile(callsign: 'W1AW'),
        nodeName: 'Base',
        freqKhz: 915000,
      ),
      StationReadiness.setupIncomplete,
    );
  });

  test('a node name without the call sign blocks before the band', () {
    expect(
      stationReadiness(done, nodeName: 'Base', freqKhz: 868000),
      StationReadiness.nameMismatch,
    );
  });

  test('a frequency outside the ham bands', () {
    expect(
      stationReadiness(done, nodeName: 'W1AW Base', freqKhz: 868000),
      StationReadiness.outOfBand,
    );
  });

  test('ready on 33 cm and 70 cm with the call sign in the name', () {
    for (final khz in [915000, 433000]) {
      expect(
        stationReadiness(done, nodeName: 'W1AW Base', freqKhz: khz),
        StationReadiness.ready,
      );
    }
  });

  test('a radio that has not reported yet is not held against anyone', () {
    expect(stationReadiness(done), StationReadiness.ready);
  });
}
