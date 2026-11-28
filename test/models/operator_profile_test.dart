import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/operator_profile.dart';

void main() {
  final full = OperatorProfile(
    callsign: 'W1AW',
    licenseClass: LicenseClass.general,
    acknowledgedAt: DateTime.utc(2026, 11, 5, 12),
  );

  test('is complete only with a valid call sign, class and acknowledgment', () {
    expect(full.isComplete, isTrue);
    expect(const OperatorProfile().isComplete, isFalse);
    expect(full.copyWith(callsign: 'VE3ABC').isComplete, isFalse);
    expect(
      OperatorProfile(
        callsign: 'W1AW',
        acknowledgedAt: DateTime.now(),
      ).isComplete,
      isFalse,
    );
    expect(full.copyWith(clearAcknowledgment: true).isComplete, isFalse);
  });

  test('matches node names that start with the call sign', () {
    expect(full.matchesNodeName('W1AW'), isTrue);
    expect(full.matchesNodeName('w1aw-7 Base'), isTrue);
    expect(full.matchesNodeName('W1AWX'), isFalse);
    expect(full.matchesNodeName('Base W1AW'), isFalse);
    expect(full.matchesNodeName(null), isFalse);
  });

  test('round-trips through JSON and tolerates junk', () {
    final back = OperatorProfile.fromJson(full.toJson());
    expect(back.callsign, 'W1AW');
    expect(back.licenseClass, LicenseClass.general);
    expect(back.acknowledgedAt, full.acknowledgedAt);

    final station = OperatorProfile.fromJson(
      full
          .copyWith(externalAmpDb: 10, feedlineLossDb: 1.5, antennaGainDbi: 6)
          .toJson(),
    );
    expect(station.externalAmpDb, 10);
    expect(station.feedlineLossDb, 1.5);
    expect(station.antennaGainDbi, 6);

    final junk = OperatorProfile.fromJson({
      'callsign': ' kd2abc ',
      'licenseClass': 'novice',
      'acknowledgedAt': 'yesterday',
    });
    expect(junk.callsign, 'KD2ABC');
    expect(junk.licenseClass, isNull);
    expect(junk.acknowledgedAt, isNull);
  });
}
