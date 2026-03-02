const String usbRequestPortLabel = 'Choose USB Device';

String normalizeUsbPortName(String portLabel) {
  final separatorIndex = portLabel.indexOf(' - ');
  final normalized = separatorIndex >= 0
      ? portLabel.substring(0, separatorIndex)
      : portLabel;
  return normalized.trim();
}

String friendlyUsbPortName(String portLabel) {
  final separatorIndex = portLabel.indexOf(' - ');
  if (separatorIndex < 0) {
    return portLabel.trim();
  }
  final friendlyName = portLabel.substring(separatorIndex + 3).trim();
  if (friendlyName.isEmpty) {
    return normalizeUsbPortName(portLabel);
  }
  return friendlyName;
}

String describeWebUsbPort({
  required int? vendorId,
  required int? productId,
  Map<String, String> knownUsbNames = const <String, String>{},
}) {
  if (vendorId == null && productId == null) {
    return usbRequestPortLabel;
  }

  final vendorHex = vendorId?.toRadixString(16).padLeft(4, '0').toUpperCase();
  final productHex = productId?.toRadixString(16).padLeft(4, '0').toUpperCase();
  final knownName = (vendorHex != null && productHex != null)
      ? knownUsbNames['${vendorHex.toLowerCase()}:${productHex.toLowerCase()}']
      : null;

  final parts = <String>[knownName ?? 'Web Serial Device'];
  if (vendorHex != null) {
    parts.add('VID:$vendorHex');
  }
  if (productHex != null) {
    parts.add('PID:$productHex');
  }
  return '${parts.first} (${parts.skip(1).join(' ')})';
}

String buildUsbDisplayLabel({
  required String basePortLabel,
  String? deviceName,
}) {
  final trimmedName = deviceName?.trim() ?? '';
  if (trimmedName.isEmpty) {
    return basePortLabel;
  }
  return '$basePortLabel - $trimmedName';
}
