import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../l10n/l10n.dart';
import '../screens/companion_cli_screen.dart';

/// Turns the radio's buzzer on or off, through the companion command line
/// (`get buzzer` / `set buzzer on|off`). Only shown when the radio answers:
/// boards without a buzzer, and older firmware, reply "Unknown command".
class RadioBuzzerSwitch extends StatefulWidget {
  const RadioBuzzerSwitch({super.key, this.run});

  /// Overrides the connector's command line; for tests.
  final CliRunner? run;

  @override
  State<RadioBuzzerSwitch> createState() => _RadioBuzzerSwitchState();
}

class _RadioBuzzerSwitchState extends State<RadioBuzzerSwitch> {
  late final CliRunner _run;

  /// Null until the radio has answered, or when it has no buzzer.
  bool? _on;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _run = widget.run ?? context.read<MeshCoreConnector>().runCliCommand;
    _load();
  }

  Future<void> _load() async {
    try {
      final reply = await _run('get buzzer');
      if (!mounted || isUnknownCliCommandReply(reply)) return;
      final value = cliReplyValue(reply).toLowerCase();
      if (value != 'on' && value != 'off') return;
      setState(() => _on = value == 'on');
    } catch (_) {
      // No answer: leave the switch hidden.
    }
  }

  Future<void> _set(bool on) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    setState(() {
      _busy = true;
      _on = on;
    });
    var ok = false;
    try {
      final reply = await _run('set buzzer ${on ? 'on' : 'off'}');
      ok = cliReplyValue(reply).toUpperCase() == 'OK';
    } catch (_) {}
    if (!mounted) return;
    setState(() {
      _busy = false;
      if (!ok) _on = !on;
    });
    if (!ok) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.radioBuzzer_failed)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final on = _on;
    if (on == null) return const SizedBox.shrink();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SwitchListTile(
          key: const ValueKey('radio-buzzer'),
          secondary: const Icon(Icons.volume_up_outlined),
          title: Text(context.l10n.radioBuzzer_title),
          subtitle: Text(context.l10n.radioBuzzer_hint),
          value: on,
          onChanged: _busy ? null : _set,
        ),
        const Divider(height: 1, indent: 16),
      ],
    );
  }
}
