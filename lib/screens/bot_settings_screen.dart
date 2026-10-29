import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../models/bot_settings.dart';
import '../services/bot_service.dart';
import '../services/weather_service.dart';

/// What the newer commands do, shown under their switches.
const _commandHints = {
  '!sun': 'Sunrise and sunset at the radio\u2019s GPS position.',
  '!moon': 'Moon phase and how much is lit.',
  '!weather':
      'Current weather at the radio (Open-Meteo). Sends the position, rounded to about 1 km.',
  '!dice': 'Rolls dice: !dice, !dice 20 or !dice 2d6.',
  '!trace': 'Lists the repeaters the sender\u2019s message came through.',
};

class BotSettingsScreen extends StatelessWidget {
  const BotSettingsScreen({super.key});

  Future<void> _save(BuildContext context, BotSettings settings) async {
    try {
      await context.read<BotService>().save(settings);
    } on ArgumentError catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.message.toString())));
      }
    }
  }

  Future<void> _editText(
    BuildContext context,
    String title,
    String value,
    BotSettings Function(String) update,
  ) async {
    final controller = TextEditingController(text: value);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(
            helperText:
                'Short replies save mesh airtime. Maximum 140 bytes including bot label.',
            helperMaxLines: 3,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (isValidBotResponse(controller.text)) {
                Navigator.pop(context, controller.text.trim());
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Enter a shorter, non-empty reply.'),
                  ),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    // The route's closing animation may still reference the controller.
    await Future<void>.delayed(const Duration(milliseconds: 300));
    controller.dispose();
    if (result != null && context.mounted) {
      await _save(context, update(result));
    }
  }

  Future<void> _editRule(BuildContext context, {int? index}) async {
    final service = context.read<BotService>();
    final rule = index == null ? null : service.settings.rules[index];
    final trigger = TextEditingController(text: rule?.trigger);
    final response = TextEditingController(text: rule?.response);
    var contains = rule?.contains ?? false;
    var senderKey = rule?.senderKey;
    final contacts = context
        .read<MeshCoreConnector>()
        .contacts
        .where((c) => c.type == advTypeChat)
        .toList();
    if (senderKey != null &&
        !contacts.any((c) => c.publicKeyHex == senderKey)) {
      contacts.addAll(
        context.read<MeshCoreConnector>().allContacts.where(
          (c) => c.publicKeyHex == senderKey,
        ),
      );
    }
    final result = await showDialog<BotRule>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(index == null ? 'Add a reply rule' : 'Edit reply rule'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: trigger,
                  decoration: const InputDecoration(
                    labelText: 'Command or keyword',
                    hintText: '!club',
                  ),
                ),
                TextField(
                  controller: response,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Reply'),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Match keyword anywhere'),
                  subtitle: const Text(
                    'Off means an exact, case-insensitive match.',
                  ),
                  value: contains,
                  onChanged: (value) => setState(() => contains = value),
                ),
                DropdownButtonFormField<String>(
                  initialValue: senderKey,
                  decoration: const InputDecoration(labelText: 'From'),
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text('Any allowed contact'),
                    ),
                    if (senderKey != null &&
                        !contacts.any((c) => c.publicKeyHex == senderKey))
                      DropdownMenuItem(
                        value: senderKey,
                        child: const Text('Previously selected contact'),
                      ),
                    for (final contact in contacts)
                      DropdownMenuItem(
                        value: contact.publicKeyHex,
                        child: Text(contact.name),
                      ),
                  ],
                  onChanged: (value) => setState(() => senderKey = value),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'Enabled built-in commands take priority. Rules run in list order.',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (trigger.text.trim().isEmpty ||
                    !isValidBotResponse(response.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Enter a trigger and a short, non-empty reply.',
                      ),
                    ),
                  );
                  return;
                }
                Navigator.pop(
                  context,
                  BotRule(
                    trigger: trigger.text.trim(),
                    response: response.text.trim(),
                    contains: contains,
                    senderKey: senderKey,
                    enabled: rule?.enabled ?? true,
                  ),
                );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
    await Future<void>.delayed(const Duration(milliseconds: 300));
    trigger.dispose();
    response.dispose();
    if (result != null && context.mounted) {
      final rules = [...service.settings.rules];
      if (index == null) {
        rules.add(result);
      } else {
        rules[index] = result;
      }
      await _save(context, service.settings.copyWith(rules: rules));
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) => Consumer2<BotService, MeshCoreConnector>(
    builder: (context, service, connector, _) {
      final settings = service.settings;
      return Scaffold(
        appBar: AppBar(title: const Text('NOTORYX Bot Mode')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SwitchListTile(
              title: const Text('Bot Mode'),
              subtitle: Text(
                !service.ready
                    ? 'Loading settings…'
                    : !settings.enabled
                    ? 'Off'
                    : connector.isConnected
                    ? 'On — listening for direct messages'
                    : 'On — waiting for a radio connection',
              ),
              value: settings.enabled,
              onChanged: service.ready
                  ? (value) => _save(context, settings.copyWith(enabled: value))
                  : null,
            ),
            const Text(
              'Free and local. Runs while NOTORYX Core is running and connected to the radio. Phone sleep or app closure can stop replies. Cached messages and reconnect backlog are ignored. Replies use the normal send queue.',
            ),
            if (service.error != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  service.error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Away auto-responder'),
              value: settings.awayEnabled,
              onChanged: (value) =>
                  _save(context, settings.copyWith(awayEnabled: value)),
            ),
            ListTile(
              title: const Text('Away reply'),
              subtitle: Text(settings.awayMessage),
              onTap: () => _editText(
                context,
                'Away reply',
                settings.awayMessage,
                (v) => service.settings.copyWith(awayMessage: v),
              ),
            ),
            ListTile(
              title: const Text('Node / group information'),
              subtitle: Text(settings.info),
              onTap: () => _editText(
                context,
                'Information reply',
                settings.info,
                (v) => service.settings.copyWith(info: v),
              ),
            ),
            ListTile(
              title: const Text('Check-in reply'),
              subtitle: Text(settings.checkIn),
              onTap: () => _editText(
                context,
                'Check-in reply',
                settings.checkIn,
                (v) => service.settings.copyWith(checkIn: v),
              ),
            ),
            const Divider(),
            const Text(
              'Commands',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            for (final command in botCommands)
              SwitchListTile(
                title: Text(command),
                subtitle: _commandHints[command] == null
                    ? null
                    : Text(_commandHints[command]!),
                value: settings.commands.contains(command),
                onChanged: (value) {
                  final commands = {...settings.commands};
                  if (value) {
                    commands.add(command);
                  } else {
                    commands.remove(command);
                  }
                  _save(context, settings.copyWith(commands: commands));
                },
              ),
            SwitchListTile(
              title: const Text('Allow !where location replies'),
              subtitle: const Text(
                'Shares the radio’s advertised coordinates with allowed contacts. They may be stale. Off by default.',
              ),
              value: settings.shareLocation,
              onChanged: (value) =>
                  _save(context, settings.copyWith(shareLocation: value)),
            ),
            const Divider(),
            const _WeatherAlertsSection(),
            const Divider(),
            ListTile(
              title: const Text('Custom commands and keyword rules'),
              trailing: const Icon(Icons.add),
              onTap: () => _editRule(context),
            ),
            for (var i = 0; i < settings.rules.length; i++)
              ListTile(
                title: Text(settings.rules[i].trigger),
                subtitle: Text(settings.rules[i].response),
                onTap: () => _editRule(context, index: i),
                leading: Switch(
                  value: settings.rules[i].enabled,
                  onChanged: (value) {
                    final rules = [...settings.rules];
                    final rule = rules[i];
                    rules[i] = BotRule(
                      trigger: rule.trigger,
                      response: rule.response,
                      enabled: value,
                      contains: rule.contains,
                      senderKey: rule.senderKey,
                    );
                    _save(context, settings.copyWith(rules: rules));
                  },
                ),
                trailing: IconButton(
                  tooltip: 'Delete rule',
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    final rules = [...settings.rules]..removeAt(i);
                    _save(context, settings.copyWith(rules: rules));
                  },
                ),
              ),
            const Divider(),
            const Text(
              'Airtime controls',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<int>(
              initialValue: settings.cooldownSeconds,
              decoration: const InputDecoration(
                labelText: 'Per-contact cooldown',
              ),
              items: {60, 300, 600, 1800, 3600, settings.cooldownSeconds}
                  .map(
                    (seconds) => DropdownMenuItem(
                      value: seconds,
                      child: Text('${seconds ~/ 60} minutes'),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  _save(context, settings.copyWith(cooldownSeconds: value));
                }
              },
            ),
            DropdownButtonFormField<int>(
              initialValue: settings.repliesPerMinute,
              decoration: const InputDecoration(
                labelText: 'Maximum replies per minute (all contacts)',
              ),
              items: List.generate(
                6,
                (i) => DropdownMenuItem(value: i + 1, child: Text('${i + 1}')),
              ),
              onChanged: (value) {
                if (value != null) {
                  _save(context, settings.copyWith(repliesPerMinute: value));
                }
              },
            ),
            ExpansionTile(
              title: const Text('Allowed contacts'),
              subtitle: const Text(
                'None selected means all known chat contacts.',
              ),
              children: [
                for (final contact in connector.contacts.where(
                  (c) => c.type == advTypeChat,
                ))
                  CheckboxListTile(
                    title: Text(contact.name),
                    value: settings.allowedSenders.contains(
                      contact.publicKeyHex,
                    ),
                    onChanged: (value) {
                      final allowed = {...settings.allowedSenders};
                      if (value == true) {
                        allowed.add(contact.publicKeyHex);
                      } else {
                        allowed.remove(contact.publicKeyHex);
                      }
                      _save(
                        context,
                        settings.copyWith(allowedSenders: allowed),
                      );
                    },
                  ),
              ],
            ),
            const Divider(),
            const Text(
              'Recent activity (this session)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            if (service.activity.isEmpty)
              const ListTile(title: Text('No bot replies yet.')),
            for (final activity in service.activity)
              ListTile(title: Text(activity)),
          ],
        ),
      );
    },
  );
}

/// Posts National Weather Service warnings for the radio's area to a
/// channel. US only, since it uses the NWS feed.
class _WeatherAlertsSection extends StatelessWidget {
  const _WeatherAlertsSection();

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherService?>();
    if (weather == null) return const SizedBox.shrink();
    final connector = context.watch<MeshCoreConnector>();
    final settings = weather.settings;
    final channels = connector.channels.where((c) => !c.isEmpty).toList();
    final selected = channels.any((c) => c.index == settings.channelIndex)
        ? settings.channelIndex
        : null;
    final checked = weather.lastCheck;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          key: const ValueKey('weather-alerts'),
          title: const Text('Post weather alerts to a channel'),
          subtitle: const Text(
            'Checks the US National Weather Service every 10 minutes for '
            'severe and extreme warnings at the radio\u2019s GPS position '
            '(rounded to about 1 km), and posts each new one once. Needs '
            'phone internet.',
          ),
          value: settings.enabled,
          onChanged: (value) =>
              weather.saveSettings(settings.copyWith(enabled: value)),
        ),
        if (settings.enabled) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField<int>(
              key: const ValueKey('weather-alerts-channel'),
              isExpanded: true,
              initialValue: selected,
              decoration: const InputDecoration(labelText: 'Post to channel'),
              items: [
                for (final c in channels)
                  DropdownMenuItem(
                    value: c.index,
                    child: Text(c.name.isEmpty ? 'Channel ${c.index}' : c.name),
                  ),
              ],
              onChanged: (index) =>
                  weather.saveSettings(settings.copyWith(channelIndex: index)),
            ),
          ),
          SwitchListTile(
            title: const Text('Include moderate alerts'),
            subtitle: const Text('Advisories as well as warnings. Busier.'),
            value: settings.includeModerate,
            onChanged: (value) =>
                weather.saveSettings(settings.copyWith(includeModerate: value)),
          ),
          if (weather.lastError != null || checked != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                weather.lastError ??
                    'Last checked ${TimeOfDay.fromDateTime(checked!.toLocal()).format(context)}.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
        ],
      ],
    );
  }
}
