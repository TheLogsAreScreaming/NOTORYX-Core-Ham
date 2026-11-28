import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/utils/amateur_power.dart';

void main() {
  test('knows the supported boards by the name they report', () {
    expect(boardAmplifierFor('Station G2')!.gainDb, 20);
    expect(boardAmplifierFor('Heltec V4.3 TFT')!.gainDb, 12);
    expect(boardAmplifierFor('RAK 3401')!.gainDb, 8);
    expect(boardAmplifierFor('Seeed Tracker T1000-E')!.gainDb, 0);
    expect(boardAmplifierFor('Station G3 ESP32')!.gainDb, isNull);
    expect(boardAmplifierFor('Something Else'), isNull);
    expect(boardAmplifierFor(null), isNull);
  });

  test('estimates output and ERP', () {
    final est = PowerEstimate.of(
      chipDbm: 7,
      board: boardAmplifierFor('Station G2'),
      feedlineLossDb: 1,
      antennaGainDbi: 6,
    )!;
    expect(est.outputDbm, 27);
    expect(est.erpDbm, closeTo(27 - 1 + 6 - 2.15, 1e-9));
    expect(est.overSpreadSpectrumLimit, isFalse);
  });

  test(
    'an unknown board counts as no amplifier; a variable one gives no estimate',
    () {
      expect(PowerEstimate.of(chipDbm: 20, board: null)!.outputDbm, 20);
      expect(
        PowerEstimate.of(chipDbm: 7, board: boardAmplifierFor('Station G3')),
        isNull,
      );
    },
  );

  test('flags output above 10 W', () {
    final est = PowerEstimate.of(
      chipDbm: 19,
      board: boardAmplifierFor('Station G2'),
      externalAmpDb: 3,
    )!;
    expect(est.outputDbm, 42);
    expect(est.overSpreadSpectrumLimit, isTrue);
  });

  test('formats power in dBm and watts', () {
    expect(formatPower(27), '27 dBm (0.50 W)');
    expect(formatPower(30), '30 dBm (1.0 W)');
    expect(formatPower(40), '40 dBm (10 W)');
  });
}
