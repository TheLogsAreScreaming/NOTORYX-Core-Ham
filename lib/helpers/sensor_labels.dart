import '../l10n/app_localizations.dart';
import 'cayenne_lpp.dart';

/// The name of an LPP reading type, as the telemetry screen shows it.
String sensorTypeLabel(AppLocalizations l10n, int type) => switch (type) {
  CayenneLpp.lppVoltage => l10n.telemetry_voltageLabel,
  CayenneLpp.lppPercentage => l10n.telemetry_percentageLabel,
  CayenneLpp.lppTemperature => l10n.telemetry_temperatureLabel,
  CayenneLpp.lppRelativeHumidity => l10n.telemetry_humidityLabel,
  CayenneLpp.lppBarometricPressure => l10n.telemetry_pressureLabel,
  CayenneLpp.lppLuminosity => l10n.telemetry_luminosityLabel,
  CayenneLpp.lppAltitude => l10n.telemetry_altitudeLabel,
  CayenneLpp.lppCurrent => l10n.telemetry_currentLabel,
  CayenneLpp.lppPower => l10n.telemetry_powerLabel,
  CayenneLpp.lppConcentration => l10n.telemetry_concentrationLabel,
  _ => l10n.telemetry_genericLabel,
};

/// The unit an LPP reading type is reported in.
String sensorUnit(int type) => switch (type) {
  CayenneLpp.lppVoltage => 'V',
  CayenneLpp.lppPercentage || CayenneLpp.lppRelativeHumidity => '%',
  CayenneLpp.lppTemperature => '°C',
  CayenneLpp.lppBarometricPressure => 'hPa',
  CayenneLpp.lppLuminosity => 'lx',
  CayenneLpp.lppAltitude => 'm',
  CayenneLpp.lppCurrent => 'A',
  CayenneLpp.lppPower => 'W',
  CayenneLpp.lppConcentration => 'ppm',
  _ => '',
};

/// A reading with its unit, e.g. `21.5 °C`.
String formatSensorValue(int type, double value) {
  final digits = switch (type) {
    CayenneLpp.lppVoltage || CayenneLpp.lppCurrent => 2,
    CayenneLpp.lppLuminosity ||
    CayenneLpp.lppConcentration ||
    CayenneLpp.lppAltitude => 0,
    _ => 1,
  };
  final unit = sensorUnit(type);
  final text = value.toStringAsFixed(digits);
  return unit.isEmpty ? text : '$text $unit';
}
