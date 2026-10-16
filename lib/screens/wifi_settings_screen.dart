import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../helpers/snack_bar_builder.dart';
import '../l10n/l10n.dart';
import '../theme/mesh_theme.dart';
import 'companion_cli_screen.dart';

/// WiFi settings of the connected companion, read and written through its
/// CLI (firmware v14+, boards built with WiFi). Changes apply after a reboot.
class WifiSettingsScreen extends StatefulWidget {
  /// Overrides the connector's CLI; for tests.
  final CliRunner? run;

  const WifiSettingsScreen({super.key, this.run});

  @override
  State<WifiSettingsScreen> createState() => _WifiSettingsScreenState();
}

enum _LoadState { loading, unsupported, failed, ready }

class _WifiSettingsScreenState extends State<WifiSettingsScreen> {
  final _ssid = TextEditingController();
  final _password = TextEditingController();
  _LoadState _state = _LoadState.loading;
  bool _enabled = false;
  bool _savedEnabled = false;
  String _savedSsid = '';
  bool _connected = false;
  String? _ip;
  bool _busy = false;
  bool _rebootNeeded = false;
  bool _showPassword = false;

  late final CliRunner _run;

  @override
  void initState() {
    super.initState();
    _run = widget.run ?? context.read<MeshCoreConnector>().runCliCommand;
    unawaited(_load());
  }

  @override
  void dispose() {
    _ssid.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _state = _LoadState.loading);
    try {
      final enabled = await _run('get wifi.enabled');
      if (isUnknownCliCommandReply(enabled)) {
        if (mounted) setState(() => _state = _LoadState.unsupported);
        return;
      }
      final ssid = cliReplyValue(await _run('get wifi.ssid'));
      final status = cliReplyValue(await _run('get wifi.status'));
      final connected = status == 'connected';
      final ip = connected ? cliReplyValue(await _run('get wifi.ip')) : null;
      if (!mounted) return;
      setState(() {
        _enabled = _savedEnabled = cliReplyValue(enabled) == '1';
        _savedSsid = ssid == '(not set)' ? '' : ssid;
        _ssid.text = _savedSsid;
        _connected = connected;
        _ip = ip;
        _state = _LoadState.ready;
      });
    } catch (_) {
      if (mounted) setState(() => _state = _LoadState.failed);
    }
  }

  /// Runs a setter and throws with the reply unless the radio confirmed it
  /// (wifi setters reply "> ...").
  Future<void> _set(String command) async {
    final reply = (await _run(command)).trim();
    if (!reply.startsWith('>') || isUnknownCliCommandReply(reply)) {
      throw _SaveRefused(reply);
    }
  }

  bool get _dirty =>
      _enabled != _savedEnabled ||
      _ssid.text != _savedSsid ||
      _password.text.isNotEmpty;

  Future<void> _save() async {
    final l10n = context.l10n;
    setState(() => _busy = true);
    try {
      if (_ssid.text != _savedSsid && _ssid.text.isNotEmpty) {
        await _set('set wifi.ssid ${_ssid.text}');
      }
      if (_password.text.isNotEmpty) {
        await _set('set wifi.pwd ${_password.text}');
      }
      if (_enabled != _savedEnabled) {
        await _set('set wifi.enabled ${_enabled ? 1 : 0}');
      }
      if (!mounted) return;
      setState(() {
        _savedEnabled = _enabled;
        _savedSsid = _ssid.text;
        _password.clear();
        _rebootNeeded = true;
      });
    } on _SaveRefused catch (e) {
      if (mounted) _showError(l10n.wifi_saveFailed(e.reply));
    } catch (e) {
      if (mounted) _showError(l10n.wifi_saveFailed('$e'));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _forget() async {
    final l10n = context.l10n;
    final ok = await _confirm(l10n.wifi_forget, l10n.wifi_forgetConfirm);
    if (ok != true || !mounted) return;
    setState(() => _busy = true);
    try {
      await _set('set wifi.clear');
      if (!mounted) return;
      setState(() {
        _savedSsid = '';
        _ssid.clear();
        _password.clear();
        _rebootNeeded = true;
      });
    } catch (e) {
      if (mounted) _showError(l10n.wifi_saveFailed('$e'));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _reboot() async {
    final l10n = context.l10n;
    final ok = await _confirm(l10n.wifi_rebootNow, l10n.wifi_rebootConfirm);
    if (ok != true) return;
    try {
      // The radio restarts without replying; the app then sees the disconnect.
      await _run('reboot');
    } catch (_) {}
  }

  Future<bool?> _confirm(String title, String message) => showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: Text(context.l10n.common_cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: Text(title),
        ),
      ],
    ),
  );

  void _showError(String message) {
    showDismissibleSnackBar(
      context,
      content: Text(message),
      backgroundColor: Theme.of(context).colorScheme.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;

    final Widget body;
    switch (_state) {
      case _LoadState.loading:
        body = const Center(child: CircularProgressIndicator());
      case _LoadState.unsupported:
        body = _Message(icon: Icons.wifi_off, text: l10n.wifi_unsupported);
      case _LoadState.failed:
        body = _Message(
          icon: Icons.error_outline,
          text: l10n.wifi_loadFailed,
          action: FilledButton.icon(
            onPressed: _load,
            icon: const Icon(Icons.refresh),
            label: Text(l10n.wifi_retry),
          ),
        );
      case _LoadState.ready:
        body = ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            if (_rebootNeeded)
              Card(
                color: scheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.restart_alt, color: scheme.onPrimaryContainer),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l10n.wifi_rebootNeeded,
                          style: TextStyle(color: scheme.onPrimaryContainer),
                        ),
                      ),
                      TextButton(
                        onPressed: _reboot,
                        child: Text(l10n.wifi_rebootNow),
                      ),
                    ],
                  ),
                ),
              ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.wifi_enabled),
              value: _enabled,
              onChanged: _busy ? null : (v) => setState(() => _enabled = v),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.wifi_status),
              subtitle: Text(
                _connected
                    ? (_ip != null && _ip!.isNotEmpty
                          ? l10n.wifi_connectedIp(_ip!)
                          : l10n.wifi_connected)
                    : l10n.wifi_disconnected,
              ),
              leading: Icon(
                _connected ? Icons.wifi : Icons.wifi_off,
                color: _connected
                    ? MeshPalette.signal
                    : scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _ssid,
              enabled: !_busy,
              maxLength: 32,
              autocorrect: false,
              enableSuggestions: false,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: l10n.wifi_network),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _password,
              enabled: !_busy,
              maxLength: 64,
              obscureText: !_showPassword,
              autocorrect: false,
              enableSuggestions: false,
              autofillHints: const [AutofillHints.password],
              decoration: InputDecoration(
                labelText: l10n.wifi_password,
                helperText: l10n.wifi_passwordKeep,
                suffixIcon: IconButton(
                  tooltip: l10n.wifi_password,
                  icon: Icon(
                    _showPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () =>
                      setState(() => _showPassword = !_showPassword),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
              onPressed: _busy || !_dirty ? null : _save,
              child: Text(l10n.wifi_save),
            ),
            const SizedBox(height: 8),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                foregroundColor: scheme.error,
              ),
              onPressed: _busy || _savedSsid.isEmpty ? null : _forget,
              child: Text(l10n.wifi_forget),
            ),
          ],
        );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.wifi_title),
        bottom: _busy
            ? const PreferredSize(
                preferredSize: Size.fromHeight(2),
                child: LinearProgressIndicator(minHeight: 2),
              )
            : null,
      ),
      body: SafeArea(top: false, child: body),
    );
  }
}

class _SaveRefused implements Exception {
  final String reply;

  const _SaveRefused(this.reply);
}

class _Message extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget? action;

  const _Message({required this.icon, required this.text, this.action});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: scheme.onSurfaceVariant),
            const SizedBox(height: 12),
            Text(text, textAlign: TextAlign.center),
            if (action != null) ...[const SizedBox(height: 16), action!],
          ],
        ),
      ),
    );
  }
}
