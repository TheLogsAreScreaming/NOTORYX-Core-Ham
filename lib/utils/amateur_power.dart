/// Transmit power estimates for licensed operators.
///
/// The radio reports the LoRa chip's power setting. On boards with an
/// amplifier between the chip and the antenna port, the output is higher, and
/// nothing on the radio measures it. These are estimates from the board
/// makers' and MeshCore's notes; measure to be sure.
library;

import 'dart:math' as math;

/// LoRa is a spread-spectrum emission, and Part 97.311(d) limits amateur
/// spread spectrum to 10 W PEP.
const double spreadSpectrumLimitDbm = 40.0;

/// The amplifier a board puts after the radio chip.
class BoardAmplifier {
  const BoardAmplifier(this.board, this.gainDb);

  final String board;

  /// dB added after the chip (0 for none), or null when it depends on a
  /// setting on the board.
  final double? gainDb;
}

// Matched against the radio's manufacturer name, lower-cased. Gains come from
// the board makers' and MeshCore's notes, e.g. 7 dBm on a Station G2's chip
// gives about 27 dBm, and 10 dBm on a Heltec V4's gives about 22 dBm.
const List<(String, BoardAmplifier)> _boards = [
  ('station g2', BoardAmplifier('Station G2', 20)),
  ('station g3', BoardAmplifier('Station G3', null)),
  ('heltec v4', BoardAmplifier('Heltec V4', 12)),
  ('rak 3401', BoardAmplifier('RAK WisMesh 1W Booster', 8)),
  ('heltec t114', BoardAmplifier('Heltec T114', 0)),
  ('rak 4631', BoardAmplifier('RAK4631', 0)),
  ('t1000', BoardAmplifier('SenseCAP T1000-E', 0)),
];

/// The amplifier on the board that reports [manufacturerName], or null for a
/// board this table doesn't know.
BoardAmplifier? boardAmplifierFor(String? manufacturerName) {
  final name = manufacturerName?.toLowerCase() ?? '';
  for (final (key, amp) in _boards) {
    if (name.contains(key)) return amp;
  }
  return null;
}

double dbmToWatts(double dbm) => math.pow(10, (dbm - 30) / 10).toDouble();

/// "27 dBm (0.50 W)", with watts to a sensible precision.
String formatPower(double dbm) {
  final w = dbmToWatts(dbm);
  final watts = w >= 10
      ? w.toStringAsFixed(0)
      : w >= 1
      ? w.toStringAsFixed(1)
      : w.toStringAsFixed(2);
  return '${dbm.toStringAsFixed(0)} dBm ($watts W)';
}

/// Estimated transmitter output and effective radiated power.
class PowerEstimate {
  const PowerEstimate({required this.outputDbm, required this.erpDbm});

  /// At the board's antenna port, plus any external amplifier.
  final double outputDbm;

  /// After feedline loss and antenna gain, relative to a dipole.
  final double erpDbm;

  bool get overSpreadSpectrumLimit => outputDbm > spreadSpectrumLimitDbm;

  /// [chipDbm] is the radio's TX power setting. Returns null when the board's
  /// amplifier gain isn't known.
  static PowerEstimate? of({
    required int chipDbm,
    required BoardAmplifier? board,
    double externalAmpDb = 0,
    double feedlineLossDb = 0,
    double antennaGainDbi = 0,
  }) {
    final boardGain = board == null ? 0.0 : board.gainDb;
    if (boardGain == null) return null;
    final output = chipDbm + boardGain + externalAmpDb;
    // dBd = dBi - 2.15: ERP is referenced to a half-wave dipole.
    final erp = output - feedlineLossDb + antennaGainDbi - 2.15;
    return PowerEstimate(outputDbm: output, erpDbm: erp);
  }
}
