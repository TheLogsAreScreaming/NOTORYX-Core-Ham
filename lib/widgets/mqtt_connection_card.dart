import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/mqtt_broker_settings.dart';
import '../models/mqtt_connection_status.dart';
import '../screens/mqtt_packet_feed_screen.dart';
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
          initialDeliverChannelMessages: mqtt.deliverChannelMessages,
          initialPublishSettings: mqtt.publishSettings,
          radioCanSign: mqtt.radioCanSign,
          onApply: (result) => mqtt.saveConfiguration(
            result.settings,
            allowInsecureLocalBroker: result.allowInsecureLocalBroker,
            username: result.username,
            password: result.password,
            deliverChannelMessages: result.deliverChannelMessages,
            publishSettings: result.publishSettings,
          ),
        ),
      ),
    );
  }

  List<Widget> _tokenLines(BuildContext context, MqttBrokerService mqtt) {
    final username = mqtt.tokenUsername;
    final refreshAt = mqtt.tokenRefreshAt;
    return [
      Text(
        username == null
            ? 'Signs in with a radio-signed token'
            : 'Signs in with a radio-signed token as '
                  '${username.substring(0, 11)}…',
      ),
      if (!mqtt.radioCanSign && !mqtt.waitingForRadio)
        Text(
          'Connect your radio to sign in',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        )
      else if (refreshAt != null && mqtt.status.isConnected)
        Text(
          'Token renews at '
          '${TimeOfDay.fromDateTime(refreshAt).format(context)}',
        ),
    ];
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
            if (mqtt.authMode == MqttAuthMode.radioToken)
              ..._tokenLines(context, mqtt)
            else if (mqtt.hasCredentials)
              Text('Signed in as ${mqtt.username}'),
            if (mqtt.subscribedTopic != null)
              Text('Listening on ${mqtt.subscribedTopic}'),
            if (mqtt.packetsReceived > 0)
              Text(
                'Packets: ${mqtt.packetsAccepted} new, '
                '${mqtt.packetsDuplicate} duplicate, '
                '${mqtt.packetsRejected} invalid',
              ),
            if (status == MqttConnectionStatus.reconnecting &&
                !mqtt.waitingForNetwork)
              Text(
                'Retry ${mqtt.reconnectAttempt} of '
                '${mqtt.maxReconnectAttempts}',
              ),
            if (mqtt.publishSettings.enabled)
              Text(
                mqtt.publishTopic == null
                    ? 'Sharing waits for a radio connection'
                    : status.isConnected
                    ? 'Sharing on ${mqtt.publishTopic}'
                    : 'Will share on ${mqtt.publishTopic}',
              ),
            if (mqtt.onlineStatusTopic != null)
              Text('Online status on ${mqtt.onlineStatusTopic}'),
            if (mqtt.packetsPublished > 0 || mqtt.publishSkips.isNotEmpty)
              Text(
                'Shared ${mqtt.packetsPublished}, held back '
                '${mqtt.publishSkips.values.fold(0, (a, b) => a + b)}',
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
                if (settings != null)
                  OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const MqttPacketFeedScreen(),
                      ),
                    ),
                    icon: const Icon(Icons.list_alt),
                    label: const Text('Packet feed'),
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
