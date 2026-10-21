import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/mqtt_mesh_packet.dart';
import '../services/mqtt_broker_service.dart';

/// Recent distinct MeshCore packets heard by MQTT observers.
class MqttPacketFeedScreen extends StatelessWidget {
  const MqttPacketFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mqtt = context.watch<MqttBrokerService>();
    final packets = mqtt.recentPackets;
    return Scaffold(
      appBar: AppBar(title: const Text('MQTT packet feed')),
      body: packets.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  mqtt.subscribedTopic == null
                      ? 'Connect to a broker to see packets from observers.'
                      : 'Waiting for packets on ${mqtt.subscribedTopic}',
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
    final observer =
        packet.observerName ??
        (packet.observerKey == null
            ? 'Unknown observer'
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
      title: Text('${packet.payloadTypeLabel} · ${packet.routeLabel}'),
      subtitle: Text(
        [
          'Heard by $observer${packet.region == null ? '' : ' (${packet.region})'}',
          '${packet.hopCount} hops · ${packet.raw.length} bytes'
              '${signal.isEmpty ? '' : ' · $signal'}',
        ].join('\n'),
      ),
      trailing: Text(time),
      isThreeLine: true,
    );
  }
}
