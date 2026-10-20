import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/models/firmware_capabilities.dart';

void main() {
  test('Cascade label does not automatically unlock commands', () {
    final capabilities = FirmwareCapabilities(firmwareLabel: 'Keymind Cascade');
    expect(capabilities.isCascadeCandidate, isTrue);
    expect(capabilities.supports(RadioCapability.repeaterTable), isFalse);
    expect(capabilities.supports(RadioCapability.gpsPowerControl), isFalse);
  });

  test('Only successful probes enable individual capabilities', () {
    final capabilities = FirmwareCapabilities.fromVerifiedProbes(
      firmwareLabel: 'Cascade',
      probeResults: {
        RadioCapability.repeaterTable: true,
        RadioCapability.heldMessageQueue: false,
      },
    );
    expect(capabilities.supports(RadioCapability.repeaterTable), isTrue);
    expect(capabilities.supports(RadioCapability.heldMessageQueue), isFalse);
  });

  test('Standard firmware can advertise supported capabilities', () {
    final capabilities = FirmwareCapabilities.fromVerifiedProbes(
      firmwareLabel: 'MeshCore',
      probeResults: {RadioCapability.batteryAlertControl: true},
    );
    expect(capabilities.isCascadeCandidate, isFalse);
    expect(capabilities.supports(RadioCapability.batteryAlertControl), isTrue);
  });
}
