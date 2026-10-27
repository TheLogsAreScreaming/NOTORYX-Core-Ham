/// Optional extensions must be confirmed by device evidence before use.
enum MeshExtension {
  telemetryHistory,
  roomMailboxes,
  dualLoraProfiles,
  programmableNotifications,
  fleetManagement,
  loraOta,
  bridgeDiagnostics,
  powerManagement,
}

enum MeshExtensionStatus { unknown, supported, unsupported }

class MeshFirmwareCapabilities {
  const MeshFirmwareCapabilities({
    this.firmwareName,
    this.firmwareVersion,
    this.extensions = const {},
  });

  final String? firmwareName;
  final String? firmwareVersion;
  final Map<MeshExtension, MeshExtensionStatus> extensions;

  MeshExtensionStatus status(MeshExtension extension) =>
      extensions[extension] ?? MeshExtensionStatus.unknown;

  /// A firmware version or name alone is never proof of extension support.
  bool supports(MeshExtension extension) =>
      status(extension) == MeshExtensionStatus.supported;

  MeshFirmwareCapabilities withVerifiedStatus(
    MeshExtension extension,
    MeshExtensionStatus status,
  ) {
    return MeshFirmwareCapabilities(
      firmwareName: firmwareName,
      firmwareVersion: firmwareVersion,
      extensions: {...extensions, extension: status},
    );
  }
}
