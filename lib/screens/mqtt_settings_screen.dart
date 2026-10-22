import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../l10n/mqtt_l10n.dart';
import '../models/mqtt_broker_presets.dart';
import '../models/mqtt_broker_settings.dart';
import '../models/mqtt_connection_policy.dart';
import '../models/mqtt_notice.dart';
import '../models/mqtt_publish_policy.dart';

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
    this.publishSettings = const MqttPublishSettings(),
  });

  final MqttBrokerSettings settings;
  final bool allowInsecureLocalBroker;
  final String username;
  final String? password;
  final bool deliverChannelMessages;
  final MqttPublishSettings publishSettings;
}

/// Edits broker configuration and credentials. Saving is delegated to
/// [onApply], which returns why it failed or null on success.
class MqttSettingsScreen extends StatefulWidget {
  const MqttSettingsScreen({
    super.key,
    this.initial,
    this.initialAllowInsecureLocalBroker = false,
    this.initialUsername,
    this.hasSavedPassword = false,
    this.initialDeliverChannelMessages = false,
    this.initialPublishSettings = const MqttPublishSettings(),
    this.radioCanSign = false,
    this.onApply,
  });

  final MqttBrokerSettings? initial;
  final bool initialAllowInsecureLocalBroker;
  final String? initialUsername;
  final bool hasSavedPassword;
  final bool initialDeliverChannelMessages;
  final MqttPublishSettings initialPublishSettings;

  /// Whether a connected radio can sign tokens right now.
  final bool radioCanSign;
  final Future<MqttNotice?> Function(MqttSettingsResult result)? onApply;

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
  late bool _share;
  late bool _shareDirect;
  late bool _shareOwn;
  late MqttAuthMode _authMode;
  MqttBrokerPreset? _preset;
  bool _saving = false;
  MqttNotice? _error;

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
    _share = widget.initialPublishSettings.enabled;
    _shareDirect = widget.initialPublishSettings.includeDirectTraffic;
    _shareOwn = widget.initialPublishSettings.includeOwnTraffic;
    _authMode = settings?.authMode ?? MqttAuthMode.password;
  }

  void _applyPreset(MqttBrokerPreset preset) {
    setState(() {
      _preset = preset;
      _host.text = preset.host;
      _port.text = '${preset.port}';
      _tls = preset.tls;
      _webSocket = preset.webSocket;
      _wsPath.text = preset.webSocketPath;
      _authMode = preset.authMode;
    });
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
      authMode: _authMode,
    );
    final allowInsecure = !_tls && _allowInsecureLocal;
    var error = const MqttConnectionPolicy().check(
      settings,
      allowInsecureLocalBroker: allowInsecure,
    );
    if (error == null && _share && settings.region.isEmpty) {
      error = const MqttNotice(MqttNoticeKind.regionNeededToShare);
    }
    if (error == null && widget.onApply != null) {
      setState(() => _saving = true);
      error = await widget.onApply!(
        MqttSettingsResult(
          settings: settings,
          allowInsecureLocalBroker: allowInsecure,
          username: _username.text.trim(),
          password: _password.text.isEmpty ? null : _password.text,
          deliverChannelMessages: _deliverChannelMessages,
          publishSettings: MqttPublishSettings(
            enabled: _share,
            includeDirectTraffic: _share && _shareDirect,
            includeOwnTraffic: _share && _shareOwn,
          ),
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
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.mqtt_settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<MqttBrokerPreset>(
            initialValue: _preset,
            isExpanded: true,
            decoration: InputDecoration(labelText: l10n.mqtt_presetLabel),
            items: [
              for (final preset in MqttBrokerPresets.choices)
                DropdownMenuItem(
                  value: preset,
                  child: Text(l10n.mqttPresetName(preset)),
                ),
            ],
            onChanged: (preset) {
              if (preset != null) _applyPreset(preset);
            },
          ),
          if (_preset != null && l10n.mqttPresetNote(_preset!) != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 8),
              child: Text(
                l10n.mqttPresetNote(_preset!)!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          TextField(
            controller: _host,
            decoration: InputDecoration(labelText: l10n.mqtt_hostname),
          ),
          TextField(
            controller: _port,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: l10n.mqtt_port),
          ),
          SwitchListTile(
            title: Text(l10n.mqtt_useTls),
            value: _tls,
            onChanged: (value) => setState(() => _tls = value),
          ),
          if (!_tls)
            SwitchListTile(
              title: Text(l10n.mqtt_allowCleartext),
              subtitle: Text(l10n.mqtt_allowCleartextHint),
              value: _allowInsecureLocal,
              onChanged: (value) => setState(() => _allowInsecureLocal = value),
            ),
          SwitchListTile(
            title: Text(l10n.mqtt_useWebSocket),
            value: _webSocket,
            onChanged: (value) => setState(() => _webSocket = value),
          ),
          if (_webSocket)
            TextField(
              controller: _wsPath,
              decoration: InputDecoration(labelText: l10n.mqtt_webSocketPath),
            ),
          TextField(
            controller: _prefix,
            decoration: InputDecoration(labelText: l10n.mqtt_topicPrefix),
          ),
          TextField(
            controller: _region,
            textCapitalization: TextCapitalization.characters,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: l10n.mqtt_region,
              helperText: l10n.mqtt_regionHelp,
            ),
          ),
          SwitchListTile(
            title: Text(l10n.mqtt_deliverChannel),
            subtitle: Text(l10n.mqtt_deliverChannelHint),
            value: _deliverChannelMessages,
            onChanged: (value) =>
                setState(() => _deliverChannelMessages = value),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.mqtt_sharingTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SwitchListTile(
            title: Text(l10n.mqtt_share),
            subtitle: Text(l10n.mqtt_shareHint),
            value: _share,
            onChanged: (value) => setState(() => _share = value),
          ),
          if (_share) ...[
            SwitchListTile(
              title: Text(l10n.mqtt_shareDirect),
              subtitle: Text(l10n.mqtt_shareDirectHint),
              value: _shareDirect,
              onChanged: (value) => setState(() => _shareDirect = value),
            ),
            SwitchListTile(
              title: Text(l10n.mqtt_shareOwn),
              value: _shareOwn,
              onChanged: (value) => setState(() => _shareOwn = value),
            ),
          ],
          const SizedBox(height: 16),
          Text(
            l10n.mqtt_signInTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          SegmentedButton<MqttAuthMode>(
            segments: [
              ButtonSegment(
                value: MqttAuthMode.password,
                label: Text(l10n.mqtt_authPassword),
              ),
              ButtonSegment(
                value: MqttAuthMode.radioToken,
                label: Text(l10n.mqtt_authToken),
              ),
            ],
            selected: {_authMode},
            onSelectionChanged: (selection) =>
                setState(() => _authMode = selection.first),
          ),
          const SizedBox(height: 8),
          if (_authMode == MqttAuthMode.radioToken) ...[
            Text(l10n.mqtt_tokenExplain),
            const SizedBox(height: 4),
            Text(
              widget.radioCanSign
                  ? l10n.mqtt_radioReady
                  : l10n.mqtt_radioNeeded,
              style: TextStyle(
                color: widget.radioCanSign
                    ? null
                    : Theme.of(context).colorScheme.error,
              ),
            ),
          ] else ...[
            TextField(
              controller: _username,
              autocorrect: false,
              decoration: InputDecoration(labelText: l10n.mqtt_username),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                labelText: l10n.mqtt_password,
                helperText: widget.hasSavedPassword
                    ? l10n.mqtt_keepPassword
                    : null,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              kIsWeb ? l10n.mqtt_credentialsWeb : l10n.mqtt_credentialsKeychain,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                l10n.mqttNotice(_error!),
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _saving ? null : _apply,
            child: Text(l10n.mqtt_saveSettings),
          ),
        ],
      ),
    );
  }
}
