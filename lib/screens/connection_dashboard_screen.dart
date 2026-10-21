import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../utils/platform_info.dart';
import '../widgets/mqtt_connection_card.dart';
import 'scanner_screen.dart';
import 'tcp_screen.dart';
import 'usb_screen.dart';

/// Radio and MQTT broker connections are shown and controlled separately.
class ConnectionDashboardScreen extends StatelessWidget {
  const ConnectionDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connections')),
      body: Consumer<MeshCoreConnector>(
        builder: (context, connector, _) {
          final connected = connector.isConnected;
          final transport = connector.activeTransport;
          final transportName = switch (transport) {
            MeshCoreTransportType.bluetooth => 'Bluetooth',
            MeshCoreTransportType.usb => 'USB serial',
            MeshCoreTransportType.tcp => 'TCP/IP',
          };
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Radio connection',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(connected ? 'Connected' : connector.state.name),
                      Text('Transport: $transportName'),
                      if (connected)
                        Text('Device: ${connector.deviceDisplayName}'),
                      if (connector.isAutoReconnectScheduled)
                        const Text('Bluetooth reconnect scheduled'),
                      const SizedBox(height: 12),
                      if (connected)
                        OutlinedButton.icon(
                          onPressed: () => connector.disconnect(),
                          icon: const Icon(Icons.link_off),
                          label: const Text('Disconnect radio'),
                        ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          if (!PlatformInfo.isWeb)
                            OutlinedButton.icon(
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => const ScannerScreen(),
                                ),
                              ),
                              icon: const Icon(Icons.bluetooth),
                              label: const Text('Bluetooth'),
                            ),
                          if (PlatformInfo.supportsUsbSerial)
                            OutlinedButton.icon(
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => const UsbScreen(),
                                ),
                              ),
                              icon: const Icon(Icons.usb),
                              label: const Text('USB serial'),
                            ),
                          OutlinedButton.icon(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const TcpScreen(),
                              ),
                            ),
                            icon: const Icon(Icons.lan),
                            label: const Text('TCP/IP'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const MqttConnectionCard(),
            ],
          );
        },
      ),
    );
  }
}
