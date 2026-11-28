enum LoRaBandwidth {
  bw7_8(7800, '7.8 kHz'),
  bw10_4(10400, '10.4 kHz'),
  bw15_6(15600, '15.6 kHz'),
  bw20_8(20800, '20.8 kHz'),
  bw31_25(31250, '31.25 kHz'),
  bw41_7(41700, '41.7 kHz'),
  bw62_5(62500, '62.5 kHz'),
  bw125(125000, '125 kHz'),
  bw250(250000, '250 kHz'),
  bw500(500000, '500 kHz');

  final int hz;
  final String label;

  const LoRaBandwidth(this.hz, this.label);
}

enum LoRaSpreadingFactor {
  sf5(5, 'SF5'),
  sf6(6, 'SF6'),
  sf7(7, 'SF7'),
  sf8(8, 'SF8'),
  sf9(9, 'SF9'),
  sf10(10, 'SF10'),
  sf11(11, 'SF11'),
  sf12(12, 'SF12');

  final int value;
  final String label;

  const LoRaSpreadingFactor(this.value, this.label);
}

enum LoRaCodingRate {
  cr4_5(5, '4/5'),
  cr4_6(6, '4/6'),
  cr4_7(7, '4/7'),
  cr4_8(8, '4/8');

  final int value;
  final String label;

  const LoRaCodingRate(this.value, this.label);
}

class RadioSettings {
  final double frequencyMHz;
  final LoRaBandwidth bandwidth;
  final LoRaSpreadingFactor spreadingFactor;
  final LoRaCodingRate codingRate;
  final int txPowerDbm;

  RadioSettings({
    required this.frequencyMHz,
    required this.bandwidth,
    required this.spreadingFactor,
    required this.codingRate,
    required this.txPowerDbm,
  });

  // US amateur band presets. NOTORYX Ham firmware only accepts 70 cm
  // (420-450 MHz) and 33 cm (902-928 MHz); 'US 33cm' is its default channel.
  // A starting point only: agree on the channel with your frequency
  // coordinator and local operators before transmitting.
  static final List<(String, RadioSettings)> presets = [
    (
      'US 33cm',
      RadioSettings(
        frequencyMHz: 906.875,
        bandwidth: LoRaBandwidth.bw250,
        spreadingFactor: LoRaSpreadingFactor.sf10,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    (
      'US 33cm Long Range',
      RadioSettings(
        frequencyMHz: 906.875,
        bandwidth: LoRaBandwidth.bw125,
        spreadingFactor: LoRaSpreadingFactor.sf11,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    (
      'US 33cm Fast',
      RadioSettings(
        frequencyMHz: 906.875,
        bandwidth: LoRaBandwidth.bw500,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    (
      'US 70cm',
      RadioSettings(
        frequencyMHz: 433.500,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf9,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    // Off-grid repeat presets (the firmware allows client repeat in the ham
    // bands only)
    (
      'Off-Grid 33cm',
      RadioSettings(
        frequencyMHz: 918.0,
        bandwidth: LoRaBandwidth.bw250,
        spreadingFactor: LoRaSpreadingFactor.sf11,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 20,
      ),
    ),
    (
      'Off-Grid 70cm',
      RadioSettings(
        frequencyMHz: 433.0,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf11,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 20,
      ),
    ),
  ];

  /// The preset to suggest for a device in [countryCode] (ISO 3166, like
  /// "US"), or null outside the US: the presets follow US band plans.
  static String? suggestedPresetFor(String? countryCode) =>
      countryCode?.toUpperCase() == 'US' ? 'US 33cm' : null;

  /// "910.525 MHz · SF 7 · BW 62.5 · CR 4/5", as a preset list shows it.
  String get summary {
    final bw = bandwidth.label.replaceAll(' kHz', '');
    return '${frequencyMHz.toStringAsFixed(3)} MHz · SF ${spreadingFactor.value}'
        ' · BW $bw · CR ${codingRate.label}';
  }

  int get frequencyHz => (frequencyMHz * 1000).round();
  int get bandwidthHz => bandwidth.hz;
  int get sf => spreadingFactor.value;
  int get cr => codingRate.value;
}
