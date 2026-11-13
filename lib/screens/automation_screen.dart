import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../connector/meshcore_connector.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/automation_rule.dart';
import '../services/automation_service.dart';
import '../widgets/mesh_ui.dart';
import '../widgets/ui/mesh_states.dart';
import 'automation_rule_screen.dart';
import 'station_log_screen.dart';

/// The automation rules, the settings they share and what they did lately.
class AutomationScreen extends StatelessWidget {
  const AutomationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final automation = context.watch<AutomationService>();
    final channels = context.select<MeshCoreConnector, String>(
      (c) => c.channels.map((ch) => '${ch.index}:${ch.name}').join('|'),
    );
    final rules = automation.rules;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.automation_title), centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        key: const ValueKey('automation-add'),
        onPressed: () => _edit(context, null),
        icon: const Icon(Icons.add),
        label: Text(l10n.automation_newRule),
        tooltip: l10n.automation_newRule,
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 96),
          children: [
            MeshCard(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ExcludeSemantics(
                    child: Icon(Icons.gavel_outlined, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(l10n.automation_hamNotice)),
                ],
              ),
            ),
            if (rules.isEmpty)
              EmptyState(
                icon: Icons.bolt_outlined,
                title: l10n.automation_empty,
                subtitle: l10n.automation_emptyHint,
              )
            else
              MeshCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [for (final r in rules) _RuleTile(rule: r)],
                ),
              ),
            const SizedBox(height: 8),
            MeshCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  SwitchListTile(
                    key: const ValueKey('automation-webhooks'),
                    secondary: const Icon(Icons.public),
                    title: Text(l10n.automation_allowWebhooks),
                    subtitle: Text(l10n.automation_allowWebhooksHint),
                    value: automation.webhooksEnabled,
                    onChanged: automation.setWebhooksEnabled,
                  ),
                  ListTile(
                    key: ValueKey('automation-working-$channels'),
                    leading: const Icon(Icons.forum_outlined),
                    title: Text(l10n.automation_workingChannel),
                    subtitle: Text(
                      channelLabel(context, automation.workingChannel),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _pickWorkingChannel(context, automation),
                  ),
                  ListTile(
                    leading: const Icon(Icons.menu_book_outlined),
                    title: Text(l10n.ham_stationLog),
                    subtitle: Text(l10n.automation_stationLogHint),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const StationLogScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (automation.activity.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Semantics(
                  header: true,
                  child: Text(
                    l10n.automation_activity,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              MeshCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    for (final a in automation.activity.take(20))
                      ListTile(
                        dense: true,
                        leading: ExcludeSemantics(
                          child: Icon(
                            a.outcome == AutomationOutcome.done
                                ? Icons.check_circle_outline
                                : Icons.pause_circle_outline,
                          ),
                        ),
                        title: Text('${a.rule}: ${actionName(l10n, a.action)}'),
                        subtitle: Text(
                          '${MaterialLocalizations.of(context).formatTimeOfDay(TimeOfDay.fromDateTime(a.at.toLocal()))}'
                          ' · ${outcomeName(l10n, a.outcome)}',
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _pickWorkingChannel(
    BuildContext context,
    AutomationService automation,
  ) async {
    final l10n = context.l10n;
    final channels = context.read<MeshCoreConnector>().channels;
    final picked = await showDialog<int>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(l10n.automation_workingChannel),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, -1),
            child: Text(l10n.automation_none),
          ),
          for (final c in channels)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(ctx, c.index),
              child: Text(c.name.isEmpty ? '#${c.index}' : c.name),
            ),
        ],
      ),
    );
    if (picked == null) return;
    await automation.setWorkingChannel(picked < 0 ? null : picked);
  }

  static Future<void> _edit(BuildContext context, AutomationRule? rule) =>
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => AutomationRuleScreen(
            rule:
                rule ??
                AutomationRule(
                  id: const Uuid().v4(),
                  name: '',
                  conditions: const [
                    AutomationCondition(type: ConditionType.batteryBelow),
                  ],
                  actions: const [AutomationAction(type: ActionType.alert)],
                ),
            isNew: rule == null,
          ),
        ),
      );
}

class _RuleTile extends StatelessWidget {
  const _RuleTile({required this.rule});

  final AutomationRule rule;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final automation = context.read<AutomationService>();
    final summary = [
      rule.match == ConditionMatch.all
          ? l10n.automation_matchAllShort(rule.conditions.length)
          : l10n.automation_matchAnyShort(rule.conditions.length),
      l10n.automation_actionCount(rule.actions.length),
      if (rule.transmits) l10n.automation_transmits,
      if (!rule.isComplete) l10n.automation_incomplete,
    ].join(' · ');
    return ListTile(
      key: ValueKey('automation-rule-${rule.id}'),
      leading: ExcludeSemantics(
        child: Icon(rule.transmits ? Icons.cell_tower : Icons.bolt_outlined),
      ),
      title: Text(rule.name.isEmpty ? l10n.automation_unnamed : rule.name),
      subtitle: Text(summary),
      onTap: () => AutomationScreen._edit(context, rule),
      trailing: Semantics(
        label: l10n.automation_ruleSwitch(
          rule.name.isEmpty ? l10n.automation_unnamed : rule.name,
        ),
        child: Switch(
          value: rule.enabled,
          onChanged: rule.isComplete
              ? (on) => automation.save(rule.copyWith(enabled: on))
              : null,
        ),
      ),
    );
  }
}

/// The working channel's (or any channel's) name, or "None".
String channelLabel(BuildContext context, int? index) {
  final l10n = context.l10n;
  if (index == null) return l10n.automation_none;
  final channel = context
      .read<MeshCoreConnector>()
      .channels
      .where((c) => c.index == index)
      .firstOrNull;
  if (channel == null || channel.name.isEmpty) return '#$index';
  return channel.name;
}

String actionName(AppLocalizations l10n, ActionType t) => switch (t) {
  ActionType.sendMessage => l10n.automation_actionSend,
  ActionType.alert => l10n.automation_actionAlert,
  ActionType.changeChannel => l10n.automation_actionChangeChannel,
  ActionType.playSound => l10n.automation_actionSound,
  ActionType.webhook => l10n.automation_actionWebhook,
};

String conditionName(AppLocalizations l10n, ConditionType t) => switch (t) {
  ConditionType.batteryBelow => l10n.automation_condBattery,
  ConditionType.timeOfDay => l10n.automation_condTime,
  ConditionType.enterArea => l10n.automation_condEnter,
  ConditionType.leaveArea => l10n.automation_condLeave,
  ConditionType.messageReceived => l10n.automation_condMessage,
  ConditionType.nodeOnline => l10n.automation_condOnline,
  ConditionType.nodeOffline => l10n.automation_condOffline,
};

String outcomeName(AppLocalizations l10n, AutomationOutcome o) => switch (o) {
  AutomationOutcome.done => l10n.automation_outDone,
  AutomationOutcome.notConnected => l10n.automation_outNotConnected,
  AutomationOutcome.stationNotReady => l10n.automation_outNotReady,
  AutomationOutcome.rateLimited => l10n.automation_outRateLimited,
  AutomationOutcome.noTarget => l10n.automation_outNoTarget,
  AutomationOutcome.webhooksOff => l10n.automation_outWebhooksOff,
  AutomationOutcome.failed => l10n.automation_outFailed,
};
