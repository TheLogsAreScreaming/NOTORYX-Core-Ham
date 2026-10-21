import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/mqtt_broker_settings.dart';
import '../models/mqtt_connection_policy.dart';

/// What the user entered on [MqttSettingsScreen].
///
/// A null [password] means "keep the saved password".
class MqttSettingsResult {
  const MqttSettingsResult({
    required this.settings,
    required this.allowInsecureLocalBroker,
    required this.username,
    this.password,
    this.deliverChannelMessages = false,
  });

  final MqttBrokerSettings settings;
  final bool allowInsecureLocalBroker;
  final String username;
  final String? password;
  final bool deliverChannelMessages;
}

/// Edits broker configuration and credentials. Saving is delegated to
/// [onApply], which returns an error message or null on success.
class MqttSettingsScreen extends StatefulWidget {
  const MqttSettingsScreen({
    super.key,
    this.initial,
    this.initialAllowInsecureLocalBroker = false,
    this.initialUsername,
    this.hasSavedPassword = false,
    this.initialDeliverChannelMessages = false,
    this.onApply,
  });

  final MqttBrokerSettings? initial;
  final bool initialAllowInsecureLocalBroker;
  final String? initialUsername;
  final bool hasSavedPassword;
  final bool initialDeliverChannelMessages;
  final Future<String?> Function(MqttSettingsResult result)? onApply;

  @override
  State<MqttSettingsScreen> createState() => _MqttSettingsScreenState();
}

class _MqttSettingsScreenState extends State<MqttSettingsScreen> {
  late final TextEditingController _host;
  late final TextEditingController _port;
  late final TextEditingController _prefix;
  late final TextEditingController _wsPath;
  late final TextEditingController _region;
  late final TextEditingController _username;
  final TextEditingController _password = TextEditingController();
  late bool _tls;
  late bool _webSocket;
  late bool _allowInsecureLocal;
  late bool _deliverChannelMessages;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final settings = widget.initial;
    _host = TextEditingController(text: settings?.host ?? '');
    _port = TextEditingController(text: '${settings?.port ?? 8883}');
    _prefix = TextEditingController(text: settings?.topicPrefix ?? 'meshcore');
    _wsPath = TextEditingController(text: settings?.webSocketPath ?? '/mqtt');
    _region = TextEditingController(text: settings?.region ?? '');
    _username = TextEditingController(text: widget.initialUsername ?? '');
    _tls = settings?.useTls ?? true;
    _webSocket = settings?.useWebSocket ?? false;
    _allowInsecureLocal = widget.initialAllowInsecureLocalBroker;
    _deliverChannelMessages = widget.initialDeliverChannelMessages;
  }

  @override
  void dispose() {
    _host.dispose();
    _port.dispose();
    _prefix.dispose();
    _wsPath.dispose();
    _region.dispose();
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _apply() async {
    final settings = MqttBrokerSettings(
      host: _host.text.trim(),
      port: int.tryParse(_port.text.trim()) ?? 0,
      useTls: _tls,
      useWebSocket: _webSocket,
      webSocketPath: _wsPath.text.trim(),
      topicPrefix: _prefix.text.trim(),
      region: _region.text.trim().toUpperCase(),
    );
    final allowInsecure = !_tls && _allowInsecureLocal;
    var error = const MqttConnectionPolicy().validate(
      settings,
      allowInsecureLocalBroker: allowInsecure,
    );
    if (error == null && widget.onApply != null) {
      setState(() => _saving = true);
      error = await widget.onApply!(
        MqttSettingsResult(
          settings: settings,
          allowInsecureLocalBroker: allowInsecure,
          username: _username.text.trim(),
          password: _password.text.isEmpty ? null : _password.text,
          deliverChannelMessages: _deliverChannelMessages,
        ),
      );
      if (!mounted) return;
    }
    setState(() {
      _saving = false;
      _error = error;
    });
    if (error == null) Navigator.of(context).pop(settings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MQTT broker settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
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
          if (!_tls)
            SwitchListTile(
              title: const Text('Allow cleartext to a local broker'),
              subtitle: const Text(
                'Only localhost, .local and private 10.x / 192.168.x hosts.',
              ),
              value: _allowInsecureLocal,
              onChanged: (value) => setState(() => _allowInsecureLocal = value),
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
          TextField(
            controller: _region,
            textCapitalization: TextCapitalization.characters,
            autocorrect: false,
            decoration: const InputDecoration(
              labelText: 'Region (optional)',
              helperText:
                  'Observer region code such as PHL. Leave blank for all.',
            ),
          ),
          SwitchListTile(
            title: const Text('Add channel messages heard via MQTT'),
            subtitle: const Text(
              'Messages on your channels that observers heard show up in '
              'your chats. They are not sent over your radio.',
            ),
            value: _deliverChannelMessages,
            onChanged: (value) =>
                setState(() => _deliverChannelMessages = value),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _username,
            autocorrect: false,
            decoration: const InputDecoration(labelText: 'Username (optional)'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
              labelText: 'Password',
              helperText: widget.hasSavedPassword
                  ? 'Leave blank to keep the saved password.'
                  : null,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            kIsWeb
                ? 'In the browser, credentials are kept only until the page '
                      'is closed.'
                : 'Credentials are stored in the system keychain, never in '
                      'app settings or logs.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                _error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _saving ? null : _apply,
            child: const Text('Save settings'),
          ),
        ],
      ),
    );
  }
}
