import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../l10n/l10n.dart';
import '../models/node_journal.dart';
import '../services/node_journal_service.dart';
import '../theme/mesh_theme.dart';
import '../widgets/contact_table_banner.dart' show lastHeardText;
import '../widgets/ember_backdrop.dart';
import '../widgets/node_mark.dart';

String behaviourName(AppLocalizations l10n, NodeBehaviour b) => switch (b) {
  NodeBehaviour.steadyRelay => l10n.journal_bSteadyRelay,
  NodeBehaviour.regular => l10n.journal_bRegular,
  NodeBehaviour.roamer => l10n.journal_bRoamer,
  NodeBehaviour.rarelyHeard => l10n.journal_bRarelyHeard,
  NodeBehaviour.newcomer => l10n.journal_bNewcomer,
  NodeBehaviour.goneQuiet => l10n.journal_bGoneQuiet,
};

String evidenceText(AppLocalizations l10n, Evidence e) => switch (e.kind) {
  EvidenceKind.daysHeard => l10n.journal_eDaysHeard(e.a, e.b),
  EvidenceKind.firstHeardHours => l10n.journal_eFirstHeard(e.a),
  EvidenceKind.silentDays => l10n.journal_eSilent(e.a),
  EvidenceKind.places => l10n.journal_ePlaces(e.a, e.b),
  EvidenceKind.sightings => l10n.journal_eSightings(e.a),
};

String _nameOf(JournalEntry e) =>
    e.name.trim().isEmpty ? e.key.substring(0, 8).toUpperCase() : e.name;

/// Every node this radio has ever heard, with behaviour labels, tags and
/// notes.
class NodeJournalScreen extends StatefulWidget {
  const NodeJournalScreen({super.key, this.clock});

  final DateTime Function()? clock;

  @override
  State<NodeJournalScreen> createState() => _NodeJournalScreenState();
}

class _NodeJournalScreenState extends State<NodeJournalScreen> {
  String _query = '';
  NodeBehaviour? _behaviour;
  String? _tag;

  bool _matches(JournalEntry e, List<BehaviourGuess> guesses) {
    if (_behaviour != null && !guesses.any((g) => g.behaviour == _behaviour)) {
      return false;
    }
    if (_tag != null && !e.tags.contains(_tag)) return false;
    if (_query.isEmpty) return true;
    final hay = '${e.name} ${e.key} ${e.tags.join(' ')} ${e.note}'
        .toLowerCase();
    return hay.contains(_query);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final journal = context.watch<NodeJournalService?>();
    final now = (widget.clock ?? DateTime.now)();
    final rows = [
      for (final e in journal?.entries ?? const <JournalEntry>[])
        (entry: e, guesses: classifyNode(e, now)),
    ].where((r) => _matches(r.entry, r.guesses)).toList();
    final tags = journal?.allTags ?? const <String>[];
    return EmberBackdrop(
      scene: EmberScene.more,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
          foregroundColor: MeshPalette.ink,
          title: Text(l10n.journal_title),
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  MeshSpace.lg,
                  MeshSpace.sm,
                  MeshSpace.lg,
                  0,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: l10n.journal_search,
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (v) =>
                      setState(() => _query = v.trim().toLowerCase()),
                ),
              ),
              SizedBox(
                height: 56,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: MeshSpace.lg,
                    vertical: MeshSpace.sm,
                  ),
                  children: [
                    ChoiceChip(
                      label: Text(l10n.journal_filterAll),
                      selected: _behaviour == null && _tag == null,
                      onSelected: (_) => setState(() {
                        _behaviour = null;
                        _tag = null;
                      }),
                    ),
                    for (final b in NodeBehaviour.values)
                      Padding(
                        padding: const EdgeInsets.only(left: MeshSpace.sm),
                        child: ChoiceChip(
                          label: Text(behaviourName(l10n, b)),
                          selected: _behaviour == b,
                          onSelected: (on) =>
                              setState(() => _behaviour = on ? b : null),
                        ),
                      ),
                    for (final t in tags)
                      Padding(
                        padding: const EdgeInsets.only(left: MeshSpace.sm),
                        child: FilterChip(
                          avatar: const Icon(Icons.sell_outlined, size: 16),
                          label: Text(t),
                          selected: _tag == t,
                          onSelected: (on) =>
                              setState(() => _tag = on ? t : null),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: journal == null || journal.entries.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(MeshSpace.xl),
                          child: Text(
                            l10n.journal_empty,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: MeshPalette.ink2),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: rows.length,
                        itemBuilder: (context, i) {
                          final (:entry, :guesses) = rows[i];
                          final top = guesses.isEmpty ? null : guesses.first;
                          return ListTile(
                            leading: NodeMark(nodeKey: entry.key),
                            title: Text(_nameOf(entry)),
                            subtitle: Text(
                              [
                                if (top != null)
                                  '${behaviourName(l10n, top.behaviour)} · '
                                      '${l10n.journal_confidence(top.percent)}',
                                lastHeardText(context, entry.lastSeen),
                              ].join('\n'),
                            ),
                            isThreeLine: top != null,
                            trailing: entry.tags.isEmpty
                                ? null
                                : const Icon(Icons.sell_outlined, size: 18),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ChangeNotifierProvider.value(
                                  value: journal,
                                  child: NodeJournalEntryScreen(
                                    nodeKey: entry.key,
                                    clock: widget.clock,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One node's page: its mark, behaviour labels with evidence, tags and a
/// note.
class NodeJournalEntryScreen extends StatefulWidget {
  const NodeJournalEntryScreen({super.key, required this.nodeKey, this.clock});

  final String nodeKey;
  final DateTime Function()? clock;

  @override
  State<NodeJournalEntryScreen> createState() => _NodeJournalEntryScreenState();
}

class _NodeJournalEntryScreenState extends State<NodeJournalEntryScreen> {
  late final TextEditingController _note;
  final _tag = TextEditingController();

  @override
  void initState() {
    super.initState();
    _note = TextEditingController(
      text: context.read<NodeJournalService>().entry(widget.nodeKey)?.note,
    );
  }

  @override
  void dispose() {
    _note.dispose();
    _tag.dispose();
    super.dispose();
  }

  Future<void> _addTag(NodeJournalService journal, JournalEntry e) async {
    final t = _tag.text.trim();
    if (t.isEmpty) return;
    _tag.clear();
    await journal.setTags(e.key, {...e.tags, t});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final journal = context.watch<NodeJournalService>();
    final e = journal.entry(widget.nodeKey);
    if (e == null) {
      return Scaffold(appBar: AppBar(title: Text(l10n.journal_title)));
    }
    final now = (widget.clock ?? DateTime.now)();
    final guesses = classifyNode(e, now);
    final ink2 = TextStyle(color: MeshPalette.ink2);
    return Scaffold(
      appBar: AppBar(title: Text(_nameOf(e)), centerTitle: true),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(MeshSpace.lg),
          children: [
            Row(
              children: [
                NodeMark(
                  nodeKey: e.key,
                  size: 64,
                  semanticLabel: l10n.journal_markLabel(_nameOf(e)),
                ),
                const SizedBox(width: MeshSpace.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        e.key.toUpperCase(),
                        style: TextStyle(
                          fontFamily: MeshFonts.mono,
                          fontSize: 11,
                          color: MeshPalette.ink3,
                        ),
                      ),
                      Text(
                        l10n.journal_firstSeen(
                          lastHeardText(context, e.firstSeen),
                        ),
                        style: ink2,
                      ),
                      Text(
                        l10n.journal_lastSeen(
                          lastHeardText(context, e.lastSeen),
                        ),
                        style: ink2,
                      ),
                      if (e.minHops != null)
                        Text(
                          l10n.journal_hops(e.minHops!, e.maxHops!),
                          style: ink2,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: MeshSpace.lg),
            if (guesses.isEmpty) Text(l10n.journal_noLabel, style: ink2),
            for (final g in guesses)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(MeshSpace.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MergeSemantics(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                behaviourName(l10n, g.behaviour),
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            Text(l10n.journal_confidence(g.percent)),
                          ],
                        ),
                      ),
                      const SizedBox(height: MeshSpace.xs),
                      ExcludeSemantics(
                        child: LinearProgressIndicator(value: g.confidence),
                      ),
                      const SizedBox(height: MeshSpace.xs),
                      for (final ev in g.evidence)
                        Text('• ${evidenceText(l10n, ev)}', style: ink2),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: MeshSpace.lg),
            Text(
              l10n.journal_tags,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Wrap(
              spacing: MeshSpace.sm,
              children: [
                for (final t in e.tags)
                  InputChip(
                    label: Text(t),
                    deleteButtonTooltipMessage: l10n.journal_removeTag(t),
                    onDeleted: () =>
                        journal.setTags(e.key, {...e.tags}..remove(t)),
                  ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tag,
                    decoration: InputDecoration(
                      labelText: l10n.journal_addTag,
                      hintText: l10n.journal_tagHint,
                    ),
                    onSubmitted: (_) => _addTag(journal, e),
                  ),
                ),
                IconButton(
                  tooltip: l10n.journal_addTag,
                  icon: const Icon(Icons.add),
                  onPressed: () => _addTag(journal, e),
                ),
              ],
            ),
            const SizedBox(height: MeshSpace.lg),
            TextField(
              controller: _note,
              minLines: 2,
              maxLines: 6,
              decoration: InputDecoration(labelText: l10n.journal_note),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () => journal.setNote(e.key, _note.text),
                child: Text(l10n.journal_saveNote),
              ),
            ),
            const SizedBox(height: MeshSpace.lg),
            OutlinedButton.icon(
              icon: const Icon(Icons.delete_outline),
              label: Text(l10n.journal_forget),
              onPressed: () async {
                final nav = Navigator.of(context);
                final messenger = ScaffoldMessenger.of(context);
                final sure = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    content: Text(l10n.journal_forgetConfirm(_nameOf(e))),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: Text(l10n.common_cancel),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: Text(l10n.common_remove),
                      ),
                    ],
                  ),
                );
                if (sure != true) return;
                await journal.forget(e.key);
                messenger.showSnackBar(
                  SnackBar(content: Text(l10n.journal_forgotten)),
                );
                nav.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
