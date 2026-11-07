import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/platform_info.dart';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../models/saved_radio.dart';
import '../l10n/l10n.dart';
import '../services/linux_ble_error_classifier.dart';
import '../theme/mesh_theme.dart';
import '../utils/app_logger.dart';
import '../widgets/adaptive_app_bar_title.dart';
import '../widgets/auto_connect_switch.dart';
import '../widgets/connect_ui.dart';
import '../widgets/device_tile.dart';
import '../widgets/mesh_ui.dart';
import '../helpers/snack_bar_builder.dart';
import 'channels_screen.dart';
import 'tcp_screen.dart';
import 'usb_screen.dart';

/// Screen for scanning and connecting to MeshCore devices
class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool _changedNavigation = false;
  String? _connectingDeviceId;
  late final MeshCoreConnector _connector;
  late final VoidCallback _connectionListener;
  BluetoothAdapterState _bluetoothState = BluetoothAdapterState.unknown;
  late StreamSubscription<BluetoothAdapterState> _bluetoothStateSubscription;

  @override
  void initState() {
    super.initState();
    _connector = Provider.of<MeshCoreConnector>(context, listen: false);

    _connectionListener = () {
      final isCurrentRoute = ModalRoute.of(context)?.isCurrent ?? true;
      if (_connector.state == MeshCoreConnectionState.disconnected) {
        _changedNavigation = false;
      } else if (_connector.state == MeshCoreConnectionState.connected &&
          _connector.activeTransport == MeshCoreTransportType.bluetooth &&
          isCurrentRoute &&
          !_changedNavigation) {
        _changedNavigation = true;
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ChannelsScreen(hideBackButton: true),
            ),
          );
        }
      }
    };

    _connector.addListener(_connectionListener);

    _bluetoothStateSubscription = FlutterBluePlus.adapterState.listen(
      (state) {
        if (mounted) {
          setState(() {
            _bluetoothState = state;
          });
          // Cancel scan if Bluetooth turns off while scanning
          if (state != BluetoothAdapterState.on) {
            unawaited(_connector.stopScan());
          }
        }
      },
      onError: (Object e) {
        appLogger.warn('Adapter state stream error: $e', tag: 'ScannerScreen');
      },
    );
  }

  @override
  void dispose() {
    _connector.removeListener(_connectionListener);
    unawaited(_bluetoothStateSubscription.cancel());
    if (!_changedNavigation) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        unawaited(_connector.disconnect(manual: true));
      });
    }
    super.dispose();
  }

  /// Every radio seen since this screen opened, in the order first found.
  /// Kept across rescans so the list doesn't blank out and refill (the
  /// connector clears its own list each time a scan starts).
  final Map<String, ScanResult> _seen = {};

  List<ScanResult> _mergeResults(List<ScanResult> latest) {
    for (final result in latest) {
      _seen[result.device.remoteId.str] = result;
    }
    return _seen.values.toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    return Scaffold(
      appBar: AppBar(
        leading: canPop
            ? IconButton(
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  appLogger.info('Back button pressed', tag: 'ScannerScreen');
                  Navigator.of(context).maybePop();
                },
              )
            : null,
        title: AdaptiveAppBarTitle(context.l10n.scanner_title),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        top: false,
        child: Consumer<MeshCoreConnector>(
          builder: (context, connector, child) {
            final results = _mergeResults(connector.scanResults);
            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                  children: [
                    _ScanHero(
                      connector: connector,
                      bluetoothOff:
                          _bluetoothState == BluetoothAdapterState.off,
                      found: results.length,
                      onToggleScan: () {
                        HapticFeedback.lightImpact();
                        _toggleScan(connector);
                      },
                      onEnableBluetooth: PlatformInfo.isAndroid
                          ? () => FlutterBluePlus.turnOn()
                          : null,
                    ),
                    ..._savedRadioSection(context, connector, results),
                    const SizedBox(height: 22),
                    ConsoleKicker(
                      context.l10n.scanner_nearbyRadios,
                      trailing: results.isEmpty
                          ? null
                          : Text(
                              '${results.length}',
                              style: MeshTheme.mono(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: MeshPalette.ink3,
                              ),
                            ),
                    ),
                    if (results.isEmpty)
                      const _ScanTips()
                    else
                      ..._deviceTiles(context, connector, results),
                    ..._otherTransports(context),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _toggleScan(MeshCoreConnector connector) {
    if (PlatformInfo.isWeb) {
      // flutter_blue_plus has no web backend, so a BLE scan silently no-ops in
      // the browser. Tell the user instead of leaving them staring at a button.
      showDismissibleSnackBar(
        context,
        content: Text(context.l10n.scanner_bluetoothWebUnsupported),
      );
      return;
    }
    if (connector.state == MeshCoreConnectionState.scanning) {
      connector.stopScan();
    } else {
      unawaited(
        connector.startScan().catchError((e) {
          appLogger.warn('startScan error: $e', tag: 'ScannerScreen');
          if (!mounted) return;
          showDismissibleSnackBar(
            context,
            content: Text(context.l10n.setupWizard_scanError),
          );
        }),
      );
    }
  }

  /// "Last radio" card with a one-tap reconnect, for a Bluetooth radio this
  /// device has connected to before that isn't already in the scan list.
  List<Widget> _savedRadioSection(
    BuildContext context,
    MeshCoreConnector connector,
    List<ScanResult> results,
  ) {
    final saved = connector.savedRadio;
    if (saved == null ||
        saved.transport != SavedRadioTransport.bluetooth ||
        PlatformInfo.isWeb ||
        connector.isConnected ||
        results.any((r) => r.device.remoteId.str == saved.address)) {
      return const [];
    }
    final busy =
        connector.state == MeshCoreConnectionState.connecting ||
        _bluetoothState == BluetoothAdapterState.off;
    final connecting = _connectingDeviceId == saved.address;
    return [
      const SizedBox(height: 22),
      ConsoleKicker(context.l10n.scanner_lastRadio),
      ConsolePanel(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(Icons.history_rounded, color: MeshPalette.accent),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                DeviceTile.friendlyName(saved.name),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: MeshPalette.ink,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 12),
            FilledButton.tonalIcon(
              onPressed: busy ? null : () => _reconnectSaved(connector),
              icon: connecting
                  ? const SizedBox.square(
                      dimension: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.refresh_rounded, size: 18),
              label: Text(context.l10n.scanner_reconnect),
            ),
          ],
        ),
      ),
      const AutoConnectSwitch(dense: true),
    ];
  }

  Future<void> _reconnectSaved(MeshCoreConnector connector) async {
    final saved = connector.savedRadio;
    if (saved == null) return;
    setState(() => _connectingDeviceId = saved.address);
    final messenger = ScaffoldMessenger.of(context);
    final failed = context.l10n.setupWizard_bluetoothError;
    try {
      if (connector.state == MeshCoreConnectionState.scanning) {
        await connector.stopScan();
      }
      await connector.reconnectSavedRadio();
    } catch (e) {
      appLogger.warn('Reconnect failed: $e', tag: 'ScannerScreen');
      messenger.showSnackBar(meshSnackBar(content: Text(failed)));
    } finally {
      if (mounted) setState(() => _connectingDeviceId = null);
    }
  }

  List<Widget> _deviceTiles(
    BuildContext context,
    MeshCoreConnector connector,
    List<ScanResult> results,
  ) {
    final isConnecting = connector.state == MeshCoreConnectionState.connecting;
    return [
      for (var i = 0; i < results.length; i++)
        Padding(
          // Keyed by radio so a tile keeps its state (and only plays its
          // entrance once) as signal readings update.
          key: ValueKey(results[i].device.remoteId.str),
          padding: const EdgeInsets.only(bottom: 10),
          child: ListEntrance(
            index: i,
            child: DeviceTile(
              scanResult: results[i],
              isConnecting:
                  isConnecting &&
                  _connectingDeviceId == results[i].device.remoteId.str,
              onTap: isConnecting
                  ? null
                  : () => _connectToDevice(context, connector, results[i]),
            ),
          ),
        ),
    ];
  }

  /// USB and Wi-Fi alternatives, replacing the old unlabeled app-bar icons.
  List<Widget> _otherTransports(BuildContext context) {
    final l10n = context.l10n;
    final tiles = [
      if (PlatformInfo.supportsUsbSerial)
        TransportTile(
          icon: Icons.usb_rounded,
          title: l10n.connections_usbSerial,
          subtitle: l10n.setupWizard_usb,
          onTap: () {
            appLogger.info(
              'USB selected, opening UsbScreen',
              tag: 'ScannerScreen',
            );
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const UsbScreen()));
          },
        ),
      if (!PlatformInfo.isWeb)
        TransportTile(
          icon: Icons.wifi_rounded,
          title: l10n.radioStatus_tcp,
          subtitle: l10n.scanner_tcpHint,
          onTap: () =>
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const TcpScreen())),
        ),
    ];
    if (tiles.isEmpty) return const [];
    return [
      const SizedBox(height: 22),
      ConsoleKicker(l10n.scanner_otherWays),
      ResponsiveTilePair(children: tiles),
    ];
  }

  Future<void> _connectToDevice(
    BuildContext context,
    MeshCoreConnector connector,
    ScanResult result,
  ) async {
    final name = result.device.platformName.isNotEmpty
        ? result.device.platformName
        : result.advertisementData.advName;
    setState(() {
      _connectingDeviceId = result.device.remoteId.toString();
    });
    try {
      await connector.connect(
        result.device,
        displayName: name,
        linuxPairingPinProvider: PlatformInfo.isLinux
            ? () async {
                if (!context.mounted) return null;
                return _promptLinuxPairingPin(context, name);
              }
            : null,
      );
    } catch (e) {
      appLogger.warn('Connect failed: $e', tag: 'ScannerScreen');
      final errorText = e.toString();
      final suppressTransientLinuxConnectError =
          PlatformInfo.isLinux &&
          connector.isAutoReconnectScheduled &&
          isLinuxBleConnectFailureText(errorText);
      if (suppressTransientLinuxConnectError) {
        appLogger.info(
          'Suppressing transient Linux connect error while auto-reconnect is active: $e',
          tag: 'ScannerScreen',
        );
        return;
      }
      if (context.mounted) {
        showDismissibleSnackBar(
          context,
          content: Text(context.l10n.setupWizard_bluetoothError),
          backgroundColor: Theme.of(context).colorScheme.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _connectingDeviceId = null;
        });
      }
    }
  }

  Future<String?> _promptLinuxPairingPin(
    BuildContext context,
    String deviceName,
  ) async {
    final l10n = context.l10n;
    var pinValue = '';
    var obscure = true;
    appLogger.info(
      'Showing Linux BLE pairing PIN prompt for $deviceName',
      tag: 'ScannerScreen',
    );
    final pin = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              title: Text(l10n.scanner_linuxPairingPinTitle),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.scanner_linuxPairingPinPrompt(deviceName)),
                    const SizedBox(height: 12),
                    TextField(
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      obscureText: obscure,
                      enableSuggestions: false,
                      autocorrect: false,
                      onChanged: (value) {
                        pinValue = value.trim();
                      },
                      onSubmitted: (value) {
                        Navigator.of(dialogContext).pop(value.trim());
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setDialogState(() {
                              obscure = !obscure;
                            });
                          },
                          icon: Icon(
                            obscure ? Icons.visibility : Icons.visibility_off,
                          ),
                          tooltip: obscure
                              ? l10n.scanner_linuxPairingShowPin
                              : l10n.scanner_linuxPairingHidePin,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(null),
                  child: Text(l10n.common_cancel),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(dialogContext).pop(pinValue),
                  child: Text(l10n.common_connect),
                ),
              ],
            );
          },
        );
      },
    );
    if (pin == null) {
      appLogger.info(
        'Linux BLE pairing PIN prompt cancelled for $deviceName',
        tag: 'ScannerScreen',
      );
      return null;
    }
    appLogger.info(
      'Linux BLE pairing PIN prompt completed for $deviceName',
      tag: 'ScannerScreen',
    );
    return pin;
  }
}

// ── Private sub-widgets ────────────────────────────────────────────────────

/// Top of the screen: a radar that ripples while scanning, what's happening
/// in plain words, and the one button that matters right now.
class _ScanHero extends StatelessWidget {
  const _ScanHero({
    required this.connector,
    required this.bluetoothOff,
    required this.found,
    required this.onToggleScan,
    required this.onEnableBluetooth,
  });

  final MeshCoreConnector connector;
  final bool bluetoothOff;
  final int found;
  final VoidCallback onToggleScan;
  final VoidCallback? onEnableBluetooth;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = connector.state;
    final scanning = state == MeshCoreConnectionState.scanning;
    final connecting = state == MeshCoreConnectionState.connecting;

    final Color color;
    final IconData icon;
    final String title;
    if (bluetoothOff) {
      color = MeshPalette.alert;
      icon = Icons.bluetooth_disabled_rounded;
      title = l10n.scanner_bluetoothOff;
    } else if (connecting) {
      color = MeshPalette.warn;
      icon = Icons.bluetooth_connected_rounded;
      title = l10n.scanner_connecting;
    } else if (found > 0) {
      color = scanning ? MeshPalette.accent : MeshPalette.signal;
      icon = Icons.bluetooth_searching_rounded;
      title = l10n.scanner_radiosFound(found);
    } else {
      color = MeshPalette.accent;
      icon = Icons.bluetooth_searching_rounded;
      title = scanning ? l10n.scanner_searchingTitle : l10n.scanner_findTitle;
    }
    final subtitle = bluetoothOff
        ? l10n.scanner_bluetoothOffMessage
        : l10n.scanner_heroHint;

    final Widget? action;
    if (bluetoothOff) {
      action = onEnableBluetooth == null
          ? null
          : FilledButton.icon(
              onPressed: onEnableBluetooth,
              icon: const Icon(Icons.bluetooth_rounded),
              label: Text(l10n.scanner_enableBluetooth),
            );
    } else {
      action = FilledButton.icon(
        key: const ValueKey('scanner-scan-button'),
        onPressed: connecting ? null : onToggleScan,
        icon: Icon(
          scanning ? Icons.stop_rounded : Icons.bluetooth_searching_rounded,
        ),
        label: Text(scanning ? l10n.scanner_stop : l10n.scanner_scan),
      );
    }

    final radar = RadarPulse(
      active: scanning || connecting,
      icon: icon,
      color: color,
    );
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: MeshPalette.ink,
            fontWeight: FontWeight.w800,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: MeshPalette.ink2, height: 1.4),
        ),
        if (action != null) ...[
          const SizedBox(height: 14),
          SizedBox(height: MeshShape.minTouch, child: action),
        ],
      ],
    );

    return ConsolePanel(
      child: Semantics(
        liveRegion: true,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 420) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: radar),
                  const SizedBox(height: 14),
                  text,
                ],
              );
            }
            return Row(
              children: [
                radar,
                const SizedBox(width: 20),
                Expanded(child: text),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Shown when no radio has turned up yet: the usual reasons why.
class _ScanTips extends StatelessWidget {
  const _ScanTips();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    Widget tip(IconData icon, String text) => Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: MeshPalette.accent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: MeshPalette.ink2, height: 1.35),
            ),
          ),
        ],
      ),
    );
    return ConsolePanel(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.scanner_tipsTitle,
            style: Theme.of(context).textTheme.titleSmall
                ?.copyWith(color: MeshPalette.ink, fontWeight: FontWeight.w700),
          ),
          tip(Icons.power_settings_new_rounded, l10n.scanner_tipPower),
          tip(Icons.memory_rounded, l10n.scanner_tipFirmware),
          tip(Icons.phonelink_erase_rounded, l10n.scanner_tipOtherDevice),
        ],
      ),
    );
  }
}
