import 'dart:async';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';

String usbConnectionErrorMessage(Object error, AppLocalizations l10n) {
  if (error is PlatformException) {
    switch (error.code) {
      case 'usb_permission_denied':
        return l10n.usbErrorPermissionDenied;
      case 'usb_device_missing':
      case 'usb_device_detached':
        return l10n.usbErrorDeviceMissing;
      case 'usb_invalid_port':
        return l10n.usbErrorInvalidPort;
      case 'usb_busy':
        return l10n.usbErrorBusy;
      case 'usb_not_connected':
        return l10n.usbErrorNotConnected;
      case 'usb_open_failed':
      case 'usb_driver_missing':
        return l10n.usbErrorOpenFailed;
      case 'usb_connect_failed':
        return l10n.setupWizard_usbError;
    }
  }

  if (error is UnsupportedError) {
    return l10n.usbErrorUnsupported;
  }

  if (error is StateError) {
    final msg = error.message;
    if (msg.contains('already active')) return l10n.usbErrorAlreadyActive;
    if (msg.contains('No USB serial device selected')) {
      return l10n.usbErrorNoDeviceSelected;
    }
    if (msg.contains('not open') || msg.contains('closed')) {
      return l10n.usbErrorPortClosed;
    }
    if (msg.contains('Timed out')) return l10n.usbErrorConnectTimedOut;
    if (msg.contains('Failed to open')) return l10n.usbErrorOpenFailed;
  }

  if (error is TimeoutException) {
    return l10n.usbErrorConnectTimedOut;
  }

  return l10n.setupWizard_usbError;
}

/// Only explicit picker cancellation is silent; permission errors need guidance.
bool isUsbSelectionCancelled(Object error) {
  if (error is StateError && error.message == 'No USB serial device selected') {
    return true;
  }
  return error.toString().contains('No port selected by the user');
}
