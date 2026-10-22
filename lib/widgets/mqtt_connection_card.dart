import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';
import '../l10n/mqtt_l10n.dart';
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
    final l10n = context.l10n;
    final username = mqtt.tokenUsername;
    final refreshAt = mqtt.tokenRefreshAt;
    return [
      Text(
        username == null
            ? l10n.mqtt_tokenSignIn
            : l10n.mqtt_tokenSignInAs(username.substring(0, 11)),
      ),
      if (!mqtt.radioCanSign && !mqtt.waitingForRadio)
        Text(
          l10n.mqtt_connectRadioToSignIn,
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        )
      else if (refreshAt != null && mqtt.status.isConnected)
        Text(
          l10n.mqtt_tokenRenewsAt(
            TimeOfDay.fromDateTime(refreshAt).format(context),
          ),
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
    final l10n = context.l10n;
    final error = mqtt.errorNotice;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.mqtt_cardTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(l10n.mqttStatus(status)),
            if (settings != null)
              Text(
                l10n.mqtt_broker(
                  settings.host,
                  settings.port,
                  settings.transportLabel,
                ),
              ),
            if (mqtt.authMode == MqttAuthMode.radioToken)
              ..._tokenLines(context, mqtt)
            else if (mqtt.hasCredentials)
              Text(l10n.mqtt_signedInAs(mqtt.username!)),
            if (mqtt.subscribedTopic != null)
              Text(l10n.mqtt_listeningOn(mqtt.subscribedTopic!)),
            if (mqtt.packetsReceived > 0)
              Text(
                l10n.mqtt_packetCounts(
                  mqtt.packetsAccepted,
                  mqtt.packetsDuplicate,
                  mqtt.packetsRejected,
                ),
              ),
            if (status == MqttConnectionStatus.reconnecting &&
                !mqtt.waitingForNetwork)
              Text(
                l10n.mqtt_retryCount(
                  mqtt.reconnectAttempt,
                  mqtt.maxReconnectAttempts,
                ),
              ),
            if (mqtt.publishSettings.enabled)
              Text(
                mqtt.publishTopic == null
                    ? l10n.mqtt_sharingWaitsForRadio
                    : status.isConnected
                    ? l10n.mqtt_sharingOn(mqtt.publishTopic!)
                    : l10n.mqtt_willShareOn(mqtt.publishTopic!),
              ),
            if (mqtt.onlineStatusTopic != null)
              Text(l10n.mqtt_onlineStatusOn(mqtt.onlineStatusTopic!)),
            if (mqtt.packetsPublished > 0 || mqtt.publishSkips.isNotEmpty)
              Text(
                l10n.mqtt_sharedCounts(
                  mqtt.packetsPublished,
                  mqtt.publishSkips.values.fold(0, (a, b) => a + b),
                ),
              ),
            if (error != null && status != MqttConnectionStatus.connected)
              Text(
                l10n.mqttNotice(error),
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            if (settings == null) Text(l10n.mqtt_addBrokerHint),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (status.isConnected || busy)
                  OutlinedButton.icon(
                    onPressed: mqtt.disconnect,
                    icon: const Icon(Icons.cloud_off),
                    label: Text(
                      busy ? l10n.common_cancel : l10n.mqtt_disconnect,
                    ),
                  )
                else if (settings != null)
                  FilledButton.icon(
                    onPressed: mqtt.canConnect ? mqtt.connect : null,
                    icon: const Icon(Icons.cloud_queue),
                    label: Text(l10n.mqtt_connect),
                  ),
                if (settings != null)
                  OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const MqttPacketFeedScreen(),
                      ),
                    ),
                    icon: const Icon(Icons.list_alt),
                    label: Text(l10n.mqtt_packetFeed),
                  ),
                OutlinedButton.icon(
                  onPressed: () => _openSettings(context, mqtt),
                  icon: const Icon(Icons.settings),
                  label: Text(
                    settings == null
                        ? l10n.mqtt_setUpBroker
                        : l10n.mqtt_brokerSettings,
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
