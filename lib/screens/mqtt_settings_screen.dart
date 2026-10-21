import 'package:flutter/material.dart';

import '../models/mqtt_broker_settings.dart';

/// Edits broker configuration without connecting or persisting secrets.
class MqttSettingsScreen extends StatefulWidget {
  const MqttSettingsScreen({super.key, this.initial, this.onApply});

  final MqttBrokerSettings? initial;
  final ValueChanged<MqttBrokerSettings>? onApply;

  @override
  State<MqttSettingsScreen> createState() => _MqttSettingsScreenState();
}

class _MqttSettingsScreenState extends State<MqttSettingsScreen> {
  late final TextEditingController _host;
  late final TextEditingController _port;
  late final TextEditingController _prefix;
  late final TextEditingController _wsPath;
  late bool _tls;
  late bool _webSocket;
  String? _error;

  @override
  void initState() {
    super.initState();
    final settings = widget.initial;
    _host = TextEditingController(text: settings?.host ?? '');
    _port = TextEditingController(text: '${settings?.port ?? 8883}');
    _prefix = TextEditingController(text: settings?.topicPrefix ?? 'meshcore');
    _wsPath = TextEditingController(text: settings?.webSocketPath ?? '/mqtt');
    _tls = settings?.useTls ?? true;
    _webSocket = settings?.useWebSocket ?? false;
  }

  @override
  void dispose() {
    _host.dispose();
    _port.dispose();
    _prefix.dispose();
    _wsPath.dispose();
    super.dispose();
  }

  void _apply() {
    final settings = MqttBrokerSettings(
      host: _host.text.trim(),
      port: int.tryParse(_port.text.trim()) ?? 0,
      useTls: _tls,
      useWebSocket: _webSocket,
      webSocketPath: _wsPath.text.trim(),
      topicPrefix: _prefix.text.trim(),
    );
    final error = settings.validate();
    setState(() => _error = error);
    if (error != null) return;
    widget.onApply?.call(settings);
    Navigator.of(context).pop(settings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MQTT broker settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Broker settings are not a live MQTT connection.'),
          TextField(
            controller: _host,
            decoration: const InputDecoration(labelText: 'Broker hostname'),
          ),
          TextField(
            controller: _port,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Port'),
          ),
          SwitchListTile(
            title: const Text('Use TLS'),
            value: _tls,
            onChanged: (value) => setState(() => _tls = value),
          ),
          SwitchListTile(
            title: const Text('Use WebSocket'),
            value: _webSocket,
            onChanged: (value) => setState(() => _webSocket = value),
          ),
          if (_webSocket)
            TextField(
              controller: _wsPath,
              decoration: const InputDecoration(labelText: 'WebSocket path'),
            ),
          TextField(
            controller: _prefix,
            decoration: const InputDecoration(labelText: 'Topic prefix'),
          ),
          if (_error != null)
            Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          const SizedBox(height: 16),
          FilledButton(onPressed: _apply, child: const Text('Apply settings')),
        ],
      ),
    );
  }
}
