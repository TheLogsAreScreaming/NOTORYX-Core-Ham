import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/mqtt_connection_status.dart';
import '../screens/mqtt_settings_screen.dart';
import '../services/mqtt_broker_service.dart';

/// Live MQTT broker status with connect, disconnect and settings controls.
class MqttConnectionCard extends StatelessWidget {
  const MqttConnectionCard({super.key});

  void _openSettings(BuildContext context, MqttBrokerService mqtt) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => MqttSettingsScreen(
          initial: mqtt.settings,
          initialAllowInsecureLocalBroker: mqtt.allowInsecureLocalBroker,
          initialUsername: mqtt.username,
          hasSavedPassword: mqtt.hasCredentials,
          onApply: (result) => mqtt.saveConfiguration(
            result.settings,
            allowInsecureLocalBroker: result.allowInsecureLocalBroker,
            username: result.username,
            password: result.password,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mqtt = context.watch<MqttBrokerService>();
    final status = mqtt.status;
    final settings = mqtt.settings;
    final busy =
        status == MqttConnectionStatus.connecting ||
        status == MqttConnectionStatus.reconnecting;
    final error = mqtt.errorMessage;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MQTT connection',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(status.label),
            if (settings != null)
              Text(
                'Broker: ${settings.host}:${settings.port} '
                '(${settings.transportLabel})',
              ),
            if (mqtt.hasCredentials) Text('Signed in as ${mqtt.username}'),
            if (status == MqttConnectionStatus.reconnecting)
              Text(
                'Retry ${mqtt.reconnectAttempt} of '
                '${mqtt.maxReconnectAttempts}',
              ),
            if (error != null && status != MqttConnectionStatus.connected)
              Text(
                error,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            if (settings == null)
              const Text(
                'Add a broker to bridge MeshCore traffic over the internet. '
                'Radio connection works independently.',
              ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (status.isConnected || busy)
                  OutlinedButton.icon(
                    onPressed: mqtt.disconnect,
                    icon: const Icon(Icons.cloud_off),
                    label: Text(busy ? 'Cancel' : 'Disconnect MQTT'),
                  )
                else if (settings != null)
                  FilledButton.icon(
                    onPressed: mqtt.canConnect ? mqtt.connect : null,
                    icon: const Icon(Icons.cloud_queue),
                    label: const Text('Connect MQTT'),
                  ),
                OutlinedButton.icon(
                  onPressed: () => _openSettings(context, mqtt),
                  icon: const Icon(Icons.settings),
                  label: Text(
                    settings == null ? 'Set up broker' : 'Broker settings',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
