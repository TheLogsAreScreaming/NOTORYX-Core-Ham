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

  // Regional preset configurations
  static final List<(String, RadioSettings)> presets = [
    // MeshCore's community presets, as the official app suggests them
    // (api.meshcore.nz config, suggested_radio_settings).
    (
      "Australia",
      RadioSettings(
        frequencyMHz: 915.8,
        bandwidth: LoRaBandwidth.bw250,
        spreadingFactor: LoRaSpreadingFactor.sf10,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    (
      "Australia (Narrow)",
      RadioSettings(
        frequencyMHz: 916.575,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_7,
        txPowerDbm: 20,
      ),
    ),
    (
      "Australia (Mid)",
      RadioSettings(
        frequencyMHz: 915.075,
        bandwidth: LoRaBandwidth.bw125,
        spreadingFactor: LoRaSpreadingFactor.sf9,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    (
      "Australia: SA, WA",
      RadioSettings(
        frequencyMHz: 923.125,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 20,
      ),
    ),
    (
      "Australia: QLD",
      RadioSettings(
        frequencyMHz: 923.125,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    (
      "Brazil",
      RadioSettings(
        frequencyMHz: 923.125,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 20,
      ),
    ),
    (
      "Canada",
      RadioSettings(
        frequencyMHz: 910.525,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    (
      "Costa Rica",
      RadioSettings(
        frequencyMHz: 910.525,
        bandwidth: LoRaBandwidth.bw125,
        spreadingFactor: LoRaSpreadingFactor.sf11,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    (
      "EU/UK (Narrow)",
      RadioSettings(
        frequencyMHz: 869.618,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 14,
      ),
    ),
    (
      "EU/UK (Deprecated)",
      RadioSettings(
        frequencyMHz: 869.525,
        bandwidth: LoRaBandwidth.bw250,
        spreadingFactor: LoRaSpreadingFactor.sf11,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 14,
      ),
    ),
    (
      "Czech Republic (Narrow)",
      RadioSettings(
        frequencyMHz: 869.432,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 14,
      ),
    ),
    (
      "EU 433MHz (Long Range)",
      RadioSettings(
        frequencyMHz: 433.65,
        bandwidth: LoRaBandwidth.bw250,
        spreadingFactor: LoRaSpreadingFactor.sf11,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    (
      "EU 433MHz (Narrow)",
      RadioSettings(
        frequencyMHz: 433.65,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 20,
      ),
    ),
    (
      "Hungary",
      RadioSettings(
        frequencyMHz: 869.618,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 14,
      ),
    ),
    (
      "Netherlands",
      RadioSettings(
        frequencyMHz: 869.618,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 14,
      ),
    ),
    (
      "Netherlands (Limburg)",
      RadioSettings(
        frequencyMHz: 869.618,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 14,
      ),
    ),
    (
      "New Zealand (Narrow)",
      RadioSettings(
        frequencyMHz: 917.375,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    (
      "New Zealand (Gisborne)",
      RadioSettings(
        frequencyMHz: 917.375,
        bandwidth: LoRaBandwidth.bw250,
        spreadingFactor: LoRaSpreadingFactor.sf11,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    (
      "Portugal 433",
      RadioSettings(
        frequencyMHz: 433.375,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf9,
        codingRate: LoRaCodingRate.cr4_6,
        txPowerDbm: 20,
      ),
    ),
    (
      "Portugal 868",
      RadioSettings(
        frequencyMHz: 869.618,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_6,
        txPowerDbm: 14,
      ),
    ),
    (
      "Slovakia",
      RadioSettings(
        frequencyMHz: 869.618,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 14,
      ),
    ),
    (
      "Switzerland",
      RadioSettings(
        frequencyMHz: 869.618,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 14,
      ),
    ),
    (
      "Thailand",
      RadioSettings(
        frequencyMHz: 921.0,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    (
      "USA",
      RadioSettings(
        frequencyMHz: 910.525,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    (
      "USA - Southern California",
      RadioSettings(
        frequencyMHz: 927.875,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    (
      "Vietnam (Narrow)",
      RadioSettings(
        frequencyMHz: 920.25,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    (
      "Vietnam (Deprecated)",
      RadioSettings(
        frequencyMHz: 920.25,
        bandwidth: LoRaBandwidth.bw250,
        spreadingFactor: LoRaSpreadingFactor.sf11,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    // Local meshes MeshCore's list doesn't cover.
    (
      'Russia Artyom (VVO)',
      RadioSettings(
        frequencyMHz: 864.281,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_6,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Biysk (BSK)',
      RadioSettings(
        frequencyMHz: 869.000,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Chelyabinsk (CEK)',
      RadioSettings(
        frequencyMHz: 868.731,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_6,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Cherepovets (CEE)',
      RadioSettings(
        frequencyMHz: 868.570,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Irkutsk (IKT)',
      RadioSettings(
        frequencyMHz: 868.731,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_7,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Ivanovo (IWA)',
      RadioSettings(
        frequencyMHz: 868.731,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Izhevsk (IJK)',
      RadioSettings(
        frequencyMHz: 868.732,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Kaluga (KLF)',
      RadioSettings(
        frequencyMHz: 868.731,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_7,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Kazan (KZN)',
      RadioSettings(
        frequencyMHz: 868.731,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_6,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Khabarovsk (KHV)',
      RadioSettings(
        frequencyMHz: 864.281,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_6,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Kirov (KVX)',
      RadioSettings(
        frequencyMHz: 868.731,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Lipetsk (LPK)',
      RadioSettings(
        frequencyMHz: 868.950,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf9,
        codingRate: LoRaCodingRate.cr4_7,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Moscow (MOW)',
      RadioSettings(
        frequencyMHz: 868.731,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_7,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Nizhny Novgorod (GOJ)',
      RadioSettings(
        frequencyMHz: 868.731,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_6,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Novosibirsk (OVB)',
      RadioSettings(
        frequencyMHz: 869.000,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf9,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Rostov-on-Don (ROV)',
      RadioSettings(
        frequencyMHz: 868.731,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf9,
        codingRate: LoRaCodingRate.cr4_7,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Ryazan (RZN)',
      RadioSettings(
        frequencyMHz: 868.880,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf9,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Samara (KUF)',
      RadioSettings(
        frequencyMHz: 864.281,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_7,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Saratov (GSV)',
      RadioSettings(
        frequencyMHz: 864.281,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_7,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia St. Petersburg (LED)',
      RadioSettings(
        frequencyMHz: 868.856,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_7,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Tambov (TBW)',
      RadioSettings(
        frequencyMHz: 868.950,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf10,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Tula (TYA)',
      RadioSettings(
        frequencyMHz: 868.731,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_7,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Tver (KLD)',
      RadioSettings(
        frequencyMHz: 869.169,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Ufa (UFA)',
      RadioSettings(
        frequencyMHz: 868.732,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Volgograd (VOG)',
      RadioSettings(
        frequencyMHz: 869.525,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_7,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Voronezh (VOZ)',
      RadioSettings(
        frequencyMHz: 868.731,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf8,
        codingRate: LoRaCodingRate.cr4_6,
        txPowerDbm: 20,
      ),
    ),
    (
      'Russia Yekaterinburg (SVX)',
      RadioSettings(
        frequencyMHz: 869.046,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf7,
        codingRate: LoRaCodingRate.cr4_7,
        txPowerDbm: 20,
      ),
    ),
    (
      'USA Arizona',
      RadioSettings(
        frequencyMHz: 908.205,
        bandwidth: LoRaBandwidth.bw62_5,
        spreadingFactor: LoRaSpreadingFactor.sf9,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 20,
      ),
    ),
    (
      'USA Philly',
      RadioSettings(
        frequencyMHz: 902.250,
        bandwidth: LoRaBandwidth.bw500,
        spreadingFactor: LoRaSpreadingFactor.sf11,
        codingRate: LoRaCodingRate.cr4_5,
        txPowerDbm: 20,
      ),
    ),
    // Off-grid repeat presets (valid client_repeat frequencies)
    (
      'Off-Grid 433',
      RadioSettings(
        frequencyMHz: 433.0,
        bandwidth: LoRaBandwidth.bw250,
        spreadingFactor: LoRaSpreadingFactor.sf11,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 20,
      ),
    ),
    (
      'Off-Grid 869',
      RadioSettings(
        frequencyMHz: 869.0,
        bandwidth: LoRaBandwidth.bw250,
        spreadingFactor: LoRaSpreadingFactor.sf11,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 14,
      ),
    ),
    (
      'Off-Grid 918',
      RadioSettings(
        frequencyMHz: 918.0,
        bandwidth: LoRaBandwidth.bw250,
        spreadingFactor: LoRaSpreadingFactor.sf11,
        codingRate: LoRaCodingRate.cr4_8,
        txPowerDbm: 20,
      ),
    ),
  ];

  /// The preset to suggest for a device in [countryCode] (ISO 3166, like
  /// "US"), or null when MeshCore has none for that country.
  static String? suggestedPresetFor(String? countryCode) {
    switch (countryCode?.toUpperCase()) {
      case 'US':
        return 'USA';
      case 'CA':
        return 'Canada';
      case 'AU':
        return 'Australia';
      case 'NZ':
        return 'New Zealand (Narrow)';
      case 'BR':
        return 'Brazil';
      case 'CR':
        return 'Costa Rica';
      case 'TH':
        return 'Thailand';
      case 'VN':
        return 'Vietnam (Narrow)';
      case 'CZ':
        return 'Czech Republic (Narrow)';
      case 'HU':
        return 'Hungary';
      case 'SK':
        return 'Slovakia';
      case 'NL':
        return 'Netherlands';
      case 'CH':
        return 'Switzerland';
      case 'PT':
        return 'Portugal 868';
      case 'GB' ||
          'IE' ||
          'DE' ||
          'FR' ||
          'ES' ||
          'IT' ||
          'BE' ||
          'LU' ||
          'AT' ||
          'DK' ||
          'SE' ||
          'NO' ||
          'FI' ||
          'PL' ||
          'SI' ||
          'HR' ||
          'GR' ||
          'RO' ||
          'BG' ||
          'EE' ||
          'LV' ||
          'LT' ||
          'IS':
        return 'EU/UK (Narrow)';
    }
    return null;
  }

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
