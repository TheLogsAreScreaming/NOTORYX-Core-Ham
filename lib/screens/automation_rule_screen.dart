import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/l10n.dart';
import '../models/automation_rule.dart';
import '../models/channel.dart';
import '../models/contact.dart';
import '../services/automation_service.dart';
import '../widgets/mesh_ui.dart';
import '../widgets/ui/mesh_states.dart';
import 'automation_screen.dart';

/// Edits one automation rule: its name, how its conditions combine, the
/// conditions and the actions.
class AutomationRuleScreen extends StatefulWidget {
  const AutomationRuleScreen({
    super.key,
    required this.rule,
    this.isNew = false,
  });

  final AutomationRule rule;
  final bool isNew;

  @override
  State<AutomationRuleScreen> createState() => _AutomationRuleScreenState();
}

class _AutomationRuleScreenState extends State<AutomationRuleScreen> {
  late AutomationRule _rule = widget.rule;
  late final _name = TextEditingController(text: widget.rule.name);

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _setCondition(int i, AutomationCondition c) => setState(
    () => _rule = _rule.copyWith(conditions: [..._rule.conditions]..[i] = c),
  );

  void _setAction(int i, AutomationAction a) => setState(
    () => _rule = _rule.copyWith(actions: [..._rule.actions]..[i] = a),
  );

  Future<void> _save() async {
    final l10n = context.l10n;
    final rule = _rule.copyWith(name: _name.text.trim());
    final automation = context.read<AutomationService>();
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    await automation.save(rule);
    if (!rule.isComplete) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.automation_savedOff)));
    }
    navigator.pop();
  }

  Future<void> _delete() async {
    final automation = context.read<AutomationService>();
    final navigator = Navigator.of(context);
    final ok = await confirmDestructive(
      context,
      message: context.l10n.automation_deleteConfirm,
    );
    if (!ok) return;
    await automation.delete(_rule.id);
    navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isNew ? l10n.automation_newRule : l10n.automation_editRule,
        ),
        centerTitle: true,
        actions: [
          if (!widget.isNew)
            IconButton(
              tooltip: l10n.common_delete,
              icon: const Icon(Icons.delete_outline),
              onPressed: _delete,
            ),
          TextButton(
            key: const ValueKey('automation-save'),
            onPressed: _save,
            child: Text(l10n.common_save),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 32),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                key: const ValueKey('automation-name'),
                controller: _name,
                decoration: InputDecoration(
                  labelText: l10n.automation_ruleName,
                ),
                textCapitalization: TextCapitalization.sentences,
                maxLength: 40,
              ),
            ),
            _Heading(l10n.automation_when),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SegmentedButton<ConditionMatch>(
                segments: [
                  ButtonSegment(
                    value: ConditionMatch.all,
                    label: Text(l10n.automation_matchAll),
                  ),
                  ButtonSegment(
                    value: ConditionMatch.any,
                    label: Text(l10n.automation_matchAny),
                  ),
                ],
                selected: {_rule.match},
                onSelectionChanged: (s) =>
                    setState(() => _rule = _rule.copyWith(match: s.first)),
              ),
            ),
            for (final (i, c) in _rule.conditions.indexed)
              _ConditionCard(
                key: ValueKey('condition-$i-${c.type.name}'),
                condition: c,
                onChanged: (v) => _setCondition(i, v),
                onRemove: () => setState(
                  () => _rule = _rule.copyWith(
                    conditions: [..._rule.conditions]..removeAt(i),
                  ),
                ),
              ),
            _AddMenu<ConditionType>(
              buttonKey: const ValueKey('automation-add-condition'),
              label: l10n.automation_addCondition,
              values: ConditionType.values,
              name: (t) => conditionName(l10n, t),
              onPicked: (t) => setState(
                () => _rule = _rule.copyWith(
                  conditions: [
                    ..._rule.conditions,
                    AutomationCondition(type: t),
                  ],
                ),
              ),
            ),
            _Heading(l10n.automation_then),
            for (final (i, a) in _rule.actions.indexed)
              _ActionCard(
                key: ValueKey('action-$i-${a.type.name}'),
                action: a,
                onChanged: (v) => _setAction(i, v),
                onRemove: () => setState(
                  () => _rule = _rule.copyWith(
                    actions: [..._rule.actions]..removeAt(i),
                  ),
                ),
              ),
            _AddMenu<ActionType>(
              buttonKey: const ValueKey('automation-add-action'),
              label: l10n.automation_addAction,
              values: ActionType.values,
              name: (t) => actionName(l10n, t),
              onPicked: (t) => setState(
                () => _rule = _rule.copyWith(
                  actions: [
                    ..._rule.actions,
                    AutomationAction(type: t),
                  ],
                ),
              ),
            ),
            if (_rule.transmits)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Text(
                  l10n.automation_transmitNotice,
                  style: theme.textTheme.bodySmall,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
    child: Semantics(
      header: true,
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    ),
  );
}

class _AddMenu<T> extends StatelessWidget {
  const _AddMenu({
    required this.buttonKey,
    required this.label,
    required this.values,
    required this.name,
    required this.onPicked,
  });

  final Key buttonKey;
  final String label;
  final List<T> values;
  final String Function(T) name;
  final ValueChanged<T> onPicked;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
    child: Align(
      alignment: AlignmentDirectional.centerStart,
      child: MenuAnchor(
        menuChildren: [
          for (final v in values)
            MenuItemButton(onPressed: () => onPicked(v), child: Text(name(v))),
        ],
        builder: (context, controller, _) => OutlinedButton.icon(
          key: buttonKey,
          onPressed: () =>
              controller.isOpen ? controller.close() : controller.open(),
          icon: const Icon(Icons.add),
          label: Text(label),
        ),
      ),
    ),
  );
}

/// A card with a title row and a remove button.
class _Part extends StatelessWidget {
  const _Part({
    required this.title,
    required this.onRemove,
    required this.children,
  });

  final String title;
  final VoidCallback onRemove;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => MeshCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(title, style: Theme.of(context).textTheme.titleSmall),
            ),
            IconButton(
              tooltip: context.l10n.automation_remove(title),
              icon: const Icon(Icons.close),
              onPressed: onRemove,
            ),
          ],
        ),
        ...children,
      ],
    ),
  );
}

class _ConditionCard extends StatelessWidget {
  const _ConditionCard({
    super.key,
    required this.condition,
    required this.onChanged,
    required this.onRemove,
  });

  final AutomationCondition condition;
  final ValueChanged<AutomationCondition> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = condition;
    final connector = context.watch<MeshCoreConnector>();
    return _Part(
      title: conditionName(l10n, c.type),
      onRemove: onRemove,
      children: switch (c.type) {
        ConditionType.batteryBelow => [
          Text(l10n.automation_batteryBelow(c.percent)),
          Slider(
            value: c.percent.toDouble(),
            min: 5,
            max: 95,
            divisions: 18,
            label: '${c.percent}%',
            semanticFormatterCallback: (v) =>
                l10n.automation_batteryBelow(v.round()),
            onChanged: (v) => onChanged(c.copyWith(percent: v.round())),
          ),
        ],
        ConditionType.timeOfDay => [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.schedule),
            title: Text(
              MaterialLocalizations.of(context).formatTimeOfDay(
                TimeOfDay(
                  hour: c.minuteOfDay ~/ 60,
                  minute: c.minuteOfDay % 60,
                ),
              ),
            ),
            subtitle: Text(l10n.automation_timeHint),
            onTap: () async {
              final t = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(
                  hour: c.minuteOfDay ~/ 60,
                  minute: c.minuteOfDay % 60,
                ),
              );
              if (t != null) {
                onChanged(c.copyWith(minuteOfDay: t.hour * 60 + t.minute));
              }
            },
          ),
        ],
        ConditionType.enterArea || ConditionType.leaveArea => [
          Row(
            children: [
              Expanded(
                child: _NumberField(
                  label: l10n.automation_latitude,
                  value: c.latitude,
                  signed: true,
                  onChanged: (v) => onChanged(c.copyWith(latitude: () => v)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _NumberField(
                  label: l10n.automation_longitude,
                  value: c.longitude,
                  signed: true,
                  onChanged: (v) => onChanged(c.copyWith(longitude: () => v)),
                ),
              ),
            ],
          ),
          _NumberField(
            label: l10n.automation_radiusMeters,
            value: c.radiusMeters.toDouble(),
            onChanged: (v) {
              if (v != null && v > 0) {
                onChanged(c.copyWith(radiusMeters: v.round()));
              }
            },
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton.icon(
              icon: const Icon(Icons.my_location),
              label: Text(l10n.automation_useRadioPosition),
              onPressed: _hasFix(connector)
                  ? () => onChanged(
                      c.copyWith(
                        latitude: () => connector.selfLatitude,
                        longitude: () => connector.selfLongitude,
                      ),
                    )
                  : null,
            ),
          ),
          Text(
            l10n.automation_areaHint,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
        ConditionType.messageReceived => [
          SegmentedButton<MessageSource>(
            segments: [
              ButtonSegment(
                value: MessageSource.any,
                label: Text(l10n.automation_sourceAny),
              ),
              ButtonSegment(
                value: MessageSource.direct,
                label: Text(l10n.automation_sourceDirect),
              ),
              ButtonSegment(
                value: MessageSource.channel,
                label: Text(l10n.automation_sourceChannel),
              ),
            ],
            selected: {c.source},
            onSelectionChanged: (s) => onChanged(c.copyWith(source: s.first)),
          ),
          if (c.source == MessageSource.channel)
            _ChannelPicker(
              label: l10n.automation_onChannel,
              channels: connector.channels,
              value: c.channelIndex,
              allowAny: true,
              onChanged: (v) => onChanged(c.copyWith(channelIndex: () => v)),
            ),
          _ContactPicker(
            label: l10n.automation_from,
            contacts: connector.contacts,
            value: c.nodeKey,
            allowAny: true,
            onChanged: (v) => onChanged(c.copyWith(nodeKey: () => v)),
          ),
          _TextField(
            label: l10n.automation_contains,
            value: c.contains,
            onChanged: (v) => onChanged(c.copyWith(contains: v)),
          ),
        ],
        ConditionType.nodeOnline || ConditionType.nodeOffline => [
          _ContactPicker(
            label: l10n.automation_node,
            contacts: connector.contacts,
            value: c.nodeKey,
            onChanged: (v) => onChanged(c.copyWith(nodeKey: () => v)),
          ),
          _NumberField(
            label: l10n.automation_heardWithinMinutes,
            value: c.minutes.toDouble(),
            onChanged: (v) {
              if (v != null && v >= 1) {
                onChanged(c.copyWith(minutes: v.round()));
              }
            },
          ),
        ],
      },
    );
  }

  static bool _hasFix(MeshCoreConnector c) {
    final lat = c.selfLatitude, lon = c.selfLongitude;
    return lat != null && lon != null && !(lat == 0 && lon == 0);
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    super.key,
    required this.action,
    required this.onChanged,
    required this.onRemove,
  });

  final AutomationAction action;
  final ValueChanged<AutomationAction> onChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final a = action;
    final connector = context.watch<MeshCoreConnector>();
    final webhooksOn = context.watch<AutomationService>().webhooksEnabled;
    final small = Theme.of(context).textTheme.bodySmall;
    return _Part(
      title: actionName(l10n, a.type),
      onRemove: onRemove,
      children: switch (a.type) {
        ActionType.sendMessage => [
          DropdownButtonFormField<SendTarget>(
            initialValue: a.target,
            decoration: InputDecoration(labelText: l10n.automation_sendTo),
            items: [
              DropdownMenuItem(
                value: SendTarget.workingChannel,
                child: Text(l10n.automation_workingChannel),
              ),
              DropdownMenuItem(
                value: SendTarget.channel,
                child: Text(l10n.automation_targetChannel),
              ),
              DropdownMenuItem(
                value: SendTarget.contact,
                child: Text(l10n.automation_targetContact),
              ),
            ],
            onChanged: (v) {
              if (v != null) onChanged(a.copyWith(target: v));
            },
          ),
          if (a.target == SendTarget.channel)
            _ChannelPicker(
              label: l10n.automation_targetChannel,
              channels: connector.channels,
              value: a.channelIndex,
              onChanged: (v) => onChanged(a.copyWith(channelIndex: () => v)),
            ),
          if (a.target == SendTarget.contact)
            _ContactPicker(
              label: l10n.automation_targetContact,
              contacts: connector.contacts,
              value: a.contactKey,
              onChanged: (v) => onChanged(a.copyWith(contactKey: () => v)),
            ),
          _TextField(
            label: l10n.automation_message,
            value: a.text,
            error: a.text.isNotEmpty && !isValidAutomationText(a.text)
                ? l10n.automation_messageTooLong
                : null,
            onChanged: (v) => onChanged(a.copyWith(text: v)),
          ),
          Text(l10n.automation_sendHint, style: small),
        ],
        ActionType.alert => [
          _TextField(
            label: l10n.automation_alertText,
            value: a.text,
            onChanged: (v) => onChanged(a.copyWith(text: v)),
          ),
        ],
        ActionType.changeChannel => [
          _ChannelPicker(
            label: l10n.automation_workingChannel,
            channels: connector.channels,
            value: a.channelIndex,
            onChanged: (v) => onChanged(a.copyWith(channelIndex: () => v)),
          ),
          Text(l10n.automation_changeChannelHint, style: small),
        ],
        ActionType.playSound => [Text(l10n.automation_soundHint, style: small)],
        ActionType.webhook => [
          _TextField(
            label: l10n.automation_webhookUrl,
            value: a.url,
            keyboardType: TextInputType.url,
            error: a.url.isNotEmpty && !isValidWebhookUrl(a.url)
                ? l10n.automation_webhookHttps
                : null,
            onChanged: (v) => onChanged(a.copyWith(url: v)),
          ),
          Row(
            children: [
              const ExcludeSemantics(child: Icon(Icons.public, size: 16)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  webhooksOn
                      ? l10n.automation_webhookNeedsInternet
                      : l10n.automation_webhookOffNotice,
                  style: small,
                ),
              ),
            ],
          ),
        ],
      },
    );
  }
}

class _TextField extends StatefulWidget {
  const _TextField({
    required this.label,
    required this.value,
    required this.onChanged,
    this.error,
    this.keyboardType,
  });

  final String label;
  final String value;
  final String? error;
  final TextInputType? keyboardType;
  final ValueChanged<String> onChanged;

  @override
  State<_TextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<_TextField> {
  late final _controller = TextEditingController(text: widget.value);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextField(
    controller: _controller,
    keyboardType: widget.keyboardType,
    decoration: InputDecoration(
      labelText: widget.label,
      errorText: widget.error,
    ),
    onChanged: widget.onChanged,
  );
}

class _NumberField extends StatefulWidget {
  const _NumberField({
    required this.label,
    required this.value,
    required this.onChanged,
    this.signed = false,
  });

  final String label;
  final double? value;
  final bool signed;
  final ValueChanged<double?> onChanged;

  @override
  State<_NumberField> createState() => _NumberFieldState();
}

class _NumberFieldState extends State<_NumberField> {
  late final _controller = TextEditingController(text: _format(widget.value));

  static String _format(double? v) {
    if (v == null) return '';
    return v == v.roundToDouble() ? v.round().toString() : v.toString();
  }

  @override
  void didUpdateWidget(_NumberField old) {
    super.didUpdateWidget(old);
    // Filled in from outside (the radio's position): show it.
    if (widget.value != double.tryParse(_controller.text)) {
      _controller.text = _format(widget.value);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextField(
    controller: _controller,
    keyboardType: TextInputType.numberWithOptions(
      decimal: true,
      signed: widget.signed,
    ),
    inputFormatters: [
      FilteringTextInputFormatter.allow(
        RegExp(widget.signed ? r'[0-9.\-]' : r'[0-9.]'),
      ),
    ],
    decoration: InputDecoration(labelText: widget.label),
    onChanged: (v) => widget.onChanged(double.tryParse(v)),
  );
}

class _ChannelPicker extends StatelessWidget {
  const _ChannelPicker({
    required this.label,
    required this.channels,
    required this.value,
    required this.onChanged,
    this.allowAny = false,
  });

  final String label;
  final List<Channel> channels;
  final int? value;
  final bool allowAny;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    final known = channels.any((c) => c.index == value);
    return DropdownButtonFormField<int?>(
      initialValue: known ? value : null,
      decoration: InputDecoration(labelText: label),
      hint: Text(
        allowAny
            ? context.l10n.automation_anyChannel
            : context.l10n.automation_none,
      ),
      items: [
        if (allowAny)
          DropdownMenuItem<int?>(
            value: null,
            child: Text(context.l10n.automation_anyChannel),
          ),
        for (final c in channels)
          DropdownMenuItem<int?>(
            value: c.index,
            child: Text(c.name.isEmpty ? '#${c.index}' : c.name),
          ),
      ],
      onChanged: onChanged,
    );
  }
}

class _ContactPicker extends StatelessWidget {
  const _ContactPicker({
    required this.label,
    required this.contacts,
    required this.value,
    required this.onChanged,
    this.allowAny = false,
  });

  final String label;
  final List<Contact> contacts;
  final String? value;
  final bool allowAny;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final known = contacts.any((c) => c.publicKeyHex == value);
    return DropdownButtonFormField<String?>(
      initialValue: known ? value : null,
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      hint: Text(
        allowAny
            ? context.l10n.automation_anyone
            : context.l10n.automation_none,
      ),
      items: [
        if (allowAny)
          DropdownMenuItem<String?>(
            value: null,
            child: Text(context.l10n.automation_anyone),
          ),
        for (final c in contacts)
          DropdownMenuItem<String?>(
            value: c.publicKeyHex,
            child: Text(c.name, overflow: TextOverflow.ellipsis),
          ),
      ],
      onChanged: onChanged,
    );
  }
}
