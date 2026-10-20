import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meshcore_open/l10n/app_localizations_en.dart';
import 'package:meshcore_open/services/usb_connection_error.dart';

void main() {
  final l10n = AppLocalizationsEn();

  test('unknown failures never expose raw platform details', () {
    expect(
      usbConnectionErrorMessage(Exception('/private/device secret'), l10n),
      l10n.setupWizard_usbError,
    );
    expect(
      usbConnectionErrorMessage(PlatformException(code: 'unknown'), l10n),
      l10n.setupWizard_usbError,
    );
  });

  test('permission, busy and detached failures retain specific guidance', () {
    for (final entry in {
      'usb_permission_denied': l10n.usbErrorPermissionDenied,
      'usb_busy': l10n.usbErrorBusy,
      'usb_device_detached': l10n.usbErrorDeviceMissing,
    }.entries) {
      expect(
        usbConnectionErrorMessage(PlatformException(code: entry.key), l10n),
        entry.value,
      );
    }
  });

  test('timeouts and unsupported platforms retain recovery guidance', () {
    expect(
      usbConnectionErrorMessage(TimeoutException('details'), l10n),
      l10n.usbErrorConnectTimedOut,
    );
    expect(
      usbConnectionErrorMessage(UnsupportedError('details'), l10n),
      l10n.usbErrorUnsupported,
    );
  });

  test('picker cancellation is silent but permission failures are not', () {
    expect(
      isUsbSelectionCancelled(StateError('No USB serial device selected')),
      isTrue,
    );
    expect(
      isUsbSelectionCancelled(
        Exception(
          "Failed to execute 'requestPort': No port selected by the user",
        ),
      ),
      isTrue,
    );
    expect(
      isUsbSelectionCancelled(
        Exception(
          "SecurityError: Failed to execute 'requestPort': access denied",
        ),
      ),
      isFalse,
    );
  });
}
