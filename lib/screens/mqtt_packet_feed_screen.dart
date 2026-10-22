import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';
import '../l10n/mqtt_l10n.dart';
import '../models/mqtt_mesh_packet.dart';
import '../services/mqtt_broker_service.dart';

/// Recent distinct MeshCore packets heard by MQTT observers.
class MqttPacketFeedScreen extends StatelessWidget {
  const MqttPacketFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mqtt = context.watch<MqttBrokerService>();
    final packets = mqtt.recentPackets;
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.mqtt_feedTitle)),
      body: packets.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  mqtt.subscribedTopic == null
                      ? l10n.mqtt_feedConnect
                      : l10n.mqtt_feedWaiting(mqtt.subscribedTopic!),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView.separated(
              itemCount: packets.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) =>
                  _PacketTile(packet: packets[index]),
            ),
    );
  }
}

class _PacketTile extends StatelessWidget {
  const _PacketTile({required this.packet});

  final MqttMeshPacket packet;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final observer =
        packet.observerName ??
        (packet.observerKey == null
            ? l10n.mqtt_feedUnknownObserver
            : packet.observerKey!.substring(
                0,
                packet.observerKey!.length.clamp(0, 8),
              ));
    final signal = [
      if (packet.snr != null) 'SNR ${packet.snr!.toStringAsFixed(1)}',
      if (packet.rssi != null) 'RSSI ${packet.rssi}',
    ].join(' · ');
    final time = TimeOfDay.fromDateTime(packet.receivedAt).format(context);
    return ListTile(
      title: Text(
        '${l10n.mqttPacketType(packet.payloadType)} · '
        '${l10n.mqttRoute(packet.routeType)}',
      ),
      subtitle: Text(
        [
          l10n.mqtt_feedHeardBy(
            packet.region == null ? observer : '$observer (${packet.region})',
          ),
          l10n.mqtt_feedHopsBytes(packet.hopCount, packet.raw.length) +
              (signal.isEmpty ? '' : ' · $signal'),
        ].join('\n'),
      ),
      trailing: Text(time),
      isThreeLine: true,
    );
  }
}
