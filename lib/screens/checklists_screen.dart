import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/checklist.dart';
import '../services/checklist_store.dart';
import '../theme/mesh_theme.dart';
import '../widgets/ember_backdrop.dart';

/// The starter checklists, in the user's language.
List<({String name, List<String> items})> starterChecklists(
  AppLocalizations l10n,
) => [
  (
    name: l10n.checklist_preTrip,
    items: [
      l10n.checklist_preTrip1,
      l10n.checklist_preTrip2,
      l10n.checklist_preTrip3,
      l10n.checklist_preTrip4,
      l10n.checklist_preTrip5,
      l10n.checklist_preTrip6,
    ],
  ),
  (
    name: l10n.checklist_deploy,
    items: [
      l10n.checklist_deploy1,
      l10n.checklist_deploy2,
      l10n.checklist_deploy3,
      l10n.checklist_deploy4,
      l10n.checklist_deploy5,
      l10n.checklist_deploy6,
    ],
  ),
];

String _when(DateTime t, String locale) =>
    DateFormat.yMMMd(locale).add_Hm().format(t.toLocal());

/// A run as plain text, for sharing.
String checklistRunText(
  AppLocalizations l10n,
  ChecklistRun run,
  String locale,
) => [
  run.name,
  l10n.checklist_startedAt(_when(run.startedAt, locale)),
  if (run.finishedAt != null)
    l10n.checklist_finishedAt(_when(run.finishedAt!, locale)),
  l10n.checklist_progress(run.doneCount, run.items.length),
  '',
  for (final i in run.items)
    i.done
        ? '[x] ${i.text} (${DateFormat.Hm(locale).format(i.doneAt!.toLocal())})'
        : '[ ] ${i.text}',
  if (run.note.isNotEmpty) ...['', '${l10n.checklist_note}: ${run.note}'],
].join('\n');

Future<void> _exportRun(
  BuildContext context,
  ChecklistRun run, {
  required bool json,
}) async {
  final l10n = context.l10n;
  final locale = Localizations.localeOf(context).toLanguageTag();
  final messenger = ScaffoldMessenger.of(context);
  try {
    if (json) {
      await SharePlus.instance.share(
        ShareParams(
          files: [
            XFile.fromData(
              utf8.encode(run.exportJson()),
              mimeType: 'application/json',
              name: 'checklist-${run.startedAt.millisecondsSinceEpoch}.json',
            ),
          ],
        ),
      );
    } else {
      await SharePlus.instance.share(
        ShareParams(text: checklistRunText(l10n, run, locale)),
      );
    }
  } catch (_) {
    messenger.showSnackBar(
      SnackBar(content: Text(l10n.checklist_exportFailed)),
    );
  }
}

Future<bool> _confirm(BuildContext context, String text, String action) async =>
    await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(ctx.l10n.common_cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(action),
          ),
        ],
      ),
    ) ==
    true;

String _listStatus(AppLocalizations l10n, ChecklistStore store, Checklist l) {
  final open = store.openRunOf(l.id);
  if (open == null) return l10n.checklist_itemCount(l.items.length);
  return '${l10n.checklist_inProgress} · '
      '${l10n.checklist_progress(open.doneCount, open.items.length)}';
}

/// Reusable checklists and the record of each time one was worked
/// through. Works with no radio and no network.
class ChecklistsScreen extends StatefulWidget {
  const ChecklistsScreen({super.key});

  @override
  State<ChecklistsScreen> createState() => _ChecklistsScreenState();
}

class _ChecklistsScreenState extends State<ChecklistsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final store = context.read<ChecklistStore>();
      if (!store.seeded) unawaited(store.seed(starterChecklists(context.l10n)));
    });
  }

  Future<void> _edit(ChecklistStore store, Checklist? existing) async {
    final result = await showDialog<Checklist>(
      context: context,
      builder: (_) => _ChecklistDialog(store: store, existing: existing),
    );
    if (result != null) await store.saveChecklist(result);
  }

  Future<void> _open(ChecklistStore store, Checklist list) async {
    final nav = Navigator.of(context);
    final run = await store.start(list);
    await nav.push(
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: store,
          child: ChecklistRunScreen(runId: run.id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final store = context.watch<ChecklistStore>();
    final locale = Localizations.localeOf(context).toLanguageTag();
    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          foregroundColor: MeshPalette.ink,
          title: Text(l10n.checklist_title),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _edit(store, null),
          icon: const Icon(Icons.add),
          label: Text(l10n.checklist_add),
        ),
        body: SafeArea(
          top: false,
          child: ListView(
            padding: const EdgeInsets.only(bottom: 96),
            children: [
              if (store.checklists.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(MeshSpace.xl),
                  child: Text(
                    l10n.checklist_empty,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: MeshPalette.ink2),
                  ),
                ),
              for (final list in store.checklists)
                ListTile(
                  leading: const Icon(Icons.checklist),
                  title: Text(list.name),
                  subtitle: Text(_listStatus(l10n, store, list)),
                  onTap: () => _open(store, list),
                  trailing: IconButton(
                    tooltip: l10n.checklist_edit,
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () => _edit(store, list),
                  ),
                ),
              Semantics(
                header: true,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    MeshSpace.lg,
                    MeshSpace.xl,
                    MeshSpace.lg,
                    MeshSpace.sm,
                  ),
                  child: Text(
                    l10n.checklist_history,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              if (!store.runs.any((r) => r.finished))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: MeshSpace.lg),
                  child: Text(
                    l10n.checklist_noRuns,
                    style: TextStyle(color: MeshPalette.ink2),
                  ),
                ),
              for (final run in store.runs.where((r) => r.finished))
                ListTile(
                  leading: Icon(
                    run.doneCount == run.items.length
                        ? Icons.task_alt
                        : Icons.rule,
                    color: run.doneCount == run.items.length
                        ? MeshPalette.signal
                        : MeshPalette.warn,
                  ),
                  title: Text(run.name),
                  subtitle: Text(
                    '${_when(run.finishedAt!, locale)} · '
                    '${l10n.checklist_progress(run.doneCount, run.items.length)}',
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider.value(
                        value: store,
                        child: ChecklistRunScreen(runId: run.id),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChecklistDialog extends StatefulWidget {
  const _ChecklistDialog({required this.store, this.existing});
  final ChecklistStore store;
  final Checklist? existing;

  @override
  State<_ChecklistDialog> createState() => _ChecklistDialogState();
}

class _ChecklistDialogState extends State<_ChecklistDialog> {
  late final _name = TextEditingController(text: widget.existing?.name);
  late final _items = TextEditingController(
    text: widget.existing?.items.join('\n'),
  );

  @override
  void dispose() {
    _name.dispose();
    _items.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final existing = widget.existing;
    final items = parseChecklistItems(_items.text);
    final valid = _name.text.trim().isNotEmpty && items.isNotEmpty;
    return AlertDialog(
      title: Text(existing == null ? l10n.checklist_add : l10n.checklist_edit),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _name,
              decoration: InputDecoration(labelText: l10n.checklist_name),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: MeshSpace.md),
            TextField(
              controller: _items,
              minLines: 4,
              maxLines: 12,
              decoration: InputDecoration(labelText: l10n.checklist_items),
              onChanged: (_) => setState(() {}),
            ),
          ],
        ),
      ),
      actions: [
        if (existing != null)
          TextButton(
            onPressed: () async {
              final nav = Navigator.of(context);
              if (!await _confirm(
                context,
                l10n.checklist_deleteConfirm(existing.name),
                l10n.common_delete,
              )) {
                return;
              }
              await widget.store.deleteChecklist(existing.id);
              nav.pop();
            },
            child: Text(l10n.common_delete),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.common_cancel),
        ),
        FilledButton(
          onPressed: !valid
              ? null
              : () => Navigator.pop(
                  context,
                  existing == null
                      ? widget.store.create(_name.text, items)
                      : existing.copyWith(
                          name: _name.text.trim(),
                          items: items,
                        ),
                ),
          child: Text(l10n.common_save),
        ),
      ],
    );
  }
}

/// Working through one run, or reading a finished one.
class ChecklistRunScreen extends StatefulWidget {
  const ChecklistRunScreen({super.key, required this.runId});
  final String runId;

  @override
  State<ChecklistRunScreen> createState() => _ChecklistRunScreenState();
}

class _ChecklistRunScreenState extends State<ChecklistRunScreen> {
  final _note = TextEditingController();

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _finish(ChecklistStore store, ChecklistRun run) async {
    final l10n = context.l10n;
    if (run.doneCount < run.items.length &&
        !await _confirm(
          context,
          l10n.checklist_unfinished,
          l10n.checklist_saveAnyway,
        )) {
      return;
    }
    await store.finish(run.id, note: _note.text);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final store = context.watch<ChecklistStore>();
    final run = store.run(widget.runId);
    if (run == null) {
      return Scaffold(appBar: AppBar(title: Text(l10n.checklist_title)));
    }
    final locale = Localizations.localeOf(context).toLanguageTag();
    final ink2 = TextStyle(color: MeshPalette.ink2);
    return Scaffold(
      appBar: AppBar(
        title: Text(run.name),
        centerTitle: true,
        actions: [
          if (run.finished)
            PopupMenuButton<String>(
              tooltip: l10n.checklist_export,
              icon: const Icon(Icons.ios_share),
              onSelected: (v) async {
                if (v == 'delete') {
                  final nav = Navigator.of(context);
                  if (await _confirm(
                    context,
                    l10n.checklist_deleteRunConfirm,
                    l10n.common_delete,
                  )) {
                    await store.deleteRun(run.id);
                    nav.pop();
                  }
                } else {
                  if (!context.mounted) return;
                  await _exportRun(context, run, json: v == 'json');
                }
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'text',
                  child: Text(l10n.checklist_exportText),
                ),
                PopupMenuItem(
                  value: 'json',
                  child: Text(l10n.checklist_exportJson),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text(l10n.checklist_deleteRun),
                ),
              ],
            ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(MeshSpace.lg),
          children: [
            Text(
              l10n.checklist_startedAt(_when(run.startedAt, locale)),
              style: ink2,
            ),
            if (run.finishedAt != null)
              Text(
                l10n.checklist_finishedAt(_when(run.finishedAt!, locale)),
                style: ink2,
              ),
            Semantics(
              liveRegion: true,
              child: Text(
                l10n.checklist_progress(run.doneCount, run.items.length),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(height: MeshSpace.xs),
            ExcludeSemantics(
              child: LinearProgressIndicator(
                value: run.items.isEmpty ? 0 : run.doneCount / run.items.length,
              ),
            ),
            const SizedBox(height: MeshSpace.md),
            for (final (i, item) in run.items.indexed)
              CheckboxListTile(
                value: item.done,
                title: Text(item.text),
                subtitle: item.done
                    ? Text(DateFormat.Hm(locale).format(item.doneAt!.toLocal()))
                    : null,
                onChanged: run.finished ? null : (_) => store.toggle(run.id, i),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            const SizedBox(height: MeshSpace.md),
            if (run.finished) ...[
              if (run.note.isNotEmpty)
                Text('${l10n.checklist_note}: ${run.note}'),
            ] else ...[
              TextField(
                controller: _note,
                minLines: 1,
                maxLines: 4,
                decoration: InputDecoration(labelText: l10n.checklist_note),
              ),
              const SizedBox(height: MeshSpace.md),
              FilledButton.icon(
                onPressed: () => _finish(store, run),
                icon: const Icon(Icons.save_alt),
                label: Text(l10n.checklist_finish),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
