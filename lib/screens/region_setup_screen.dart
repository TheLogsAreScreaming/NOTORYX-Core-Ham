import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../helpers/snack_bar_builder.dart';
import '../l10n/l10n.dart';
import '../models/contact.dart';
import '../models/region_setup.dart';
import '../services/repeater_command_service.dart';
import '../storage/region_store.dart';
import '../theme/mesh_theme.dart';
import '../widgets/connect_ui.dart';

enum _SendState { pending, sending, ok, failed }

/// Builds the `region put …` commands that place a repeater in a region
/// tree, to copy or (for a repeater you're logged in to) send directly.
class RegionSetupScreen extends StatefulWidget {
  const RegionSetupScreen({super.key, this.repeater, this.loadTrees});

  /// A repeater the user is logged in to as admin, or null to copy only.
  final Contact? repeater;

  /// Injected in tests; defaults to the bundled `region_trees.json`.
  final Future<String> Function()? loadTrees;

  @override
  State<RegionSetupScreen> createState() => _RegionSetupScreenState();
}

class _RegionSetupScreenState extends State<RegionSetupScreen> {
  List<RegionTree> _trees = const [];

  /// A tree id, or null for a typed chain.
  String? _treeId;
  String? _leaf;
  final _customController = TextEditingController();
  bool _setDefault = true;
  bool _legacyFirmware = false;
  bool _denyUnscoped = false;
  Map<int, _SendState> _sent = {};
  Map<int, String> _replies = {};
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    final raw =
        await (widget.loadTrees ??
            () => rootBundle.loadString('assets/region_trees.json'))();
    final trees = parseRegionTrees(raw);
    if (!mounted) return;
    setState(() {
      _trees = trees;
      _treeId = trees.isEmpty ? null : trees.first.id;
    });
  }

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  RegionTree? get _tree {
    for (final t in _trees) {
      if (t.id == _treeId) return t;
    }
    return null;
  }

  List<String> get _chain {
    final tree = _tree;
    if (tree != null) return _leaf == null ? const [] : tree.chainFor(_leaf!);
    return parseRegionChain(_customController.text);
  }

  void _changed(VoidCallback update) => setState(() {
    update();
    _sent = {};
    _replies = {};
  });

  Future<void> _send(List<String> commands) async {
    final repeater = widget.repeater!;
    final service = RepeaterCommandService(context.read<MeshCoreConnector>());
    setState(() {
      _sending = true;
      _sent = {for (var i = 0; i < commands.length; i++) i: _SendState.pending};
      _replies = {};
    });
    for (var i = 0; i < commands.length; i++) {
      if (!mounted) return;
      setState(() => _sent[i] = _SendState.sending);
      try {
        final reply = await service.sendCommand(repeater, commands[i]);
        if (!mounted) return;
        setState(() {
          _sent[i] = _SendState.ok;
          _replies[i] = reply.trim();
        });
      } catch (e) {
        if (!mounted) return;
        setState(() {
          _sent[i] = _SendState.failed;
          _replies[i] = context.l10n.regionSetup_noReply;
          _sending = false;
        });
        return;
      }
    }
    if (mounted) setState(() => _sending = false);
  }

  void _addToMyRegions(List<String> chain) {
    final store = RegionStore();
    final existing = store.loadRegions();
    store.saveRegions([...existing, ...chain]);
    showDismissibleSnackBar(
      context,
      content: Text(context.l10n.regionSetup_addedToMine(chain.length)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tree = _tree;
    final chain = _chain;
    final invalid = [
      for (final r in chain)
        if (!isValidRegionName(r)) r,
    ];
    final tooMany = chain.length > maxRegionsPerRepeater;
    final ready = chain.isNotEmpty && invalid.isEmpty && !tooMany;
    final commands = ready
        ? regionSetupCommands(
            chain,
            defaultRegion: _setDefault ? chain.last : null,
            legacyFirmware: _legacyFirmware,
            denyUnscoped: _denyUnscoped,
          )
        : const <String>[];
    final repeater = widget.repeater;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.regionSetup_title)),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            children: [
              Text(
                l10n.regionSetup_intro,
                style: TextStyle(color: MeshPalette.ink2, height: 1.4),
              ),
              const SizedBox(height: 18),
              ConsoleKicker(l10n.regionSetup_where),
              ConsolePanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String?>(
                      key: const ValueKey('region-tree'),
                      initialValue: _treeId,
                      decoration: InputDecoration(
                        labelText: l10n.regionSetup_tree,
                      ),
                      items: [
                        for (final t in _trees)
                          DropdownMenuItem(value: t.id, child: Text(t.name)),
                        DropdownMenuItem(
                          value: null,
                          child: Text(l10n.regionSetup_custom),
                        ),
                      ],
                      onChanged: (v) => _changed(() {
                        _treeId = v;
                        _leaf = null;
                      }),
                    ),
                    const SizedBox(height: 12),
                    if (tree != null) ...[
                      DropdownButtonFormField<String>(
                        key: ValueKey('region-leaf-${tree.id}'),
                        initialValue: _leaf,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: l10n.regionSetup_region,
                        ),
                        items: [
                          for (final (node, depth) in tree.ordered())
                            DropdownMenuItem(
                              value: node.name,
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: depth * 14.0,
                                ),
                                child: Text(
                                  node.label.isEmpty
                                      ? node.name
                                      : '${node.name} · ${node.label}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                        ],
                        onChanged: (v) => _changed(() => _leaf = v),
                      ),
                    ] else
                      TextField(
                        key: const ValueKey('region-custom'),
                        controller: _customController,
                        decoration: InputDecoration(
                          labelText: l10n.regionSetup_customLabel,
                          hintText: 'usa > us-ne > ct',
                          errorText: invalid.isNotEmpty
                              ? l10n.regionSetup_invalidName(invalid.first)
                              : tooMany
                              ? l10n.regionSetup_tooMany(maxRegionsPerRepeater)
                              : null,
                          errorMaxLines: 3,
                        ),
                        onChanged: (_) => _changed(() {}),
                      ),
                    if (chain.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        chain.join('  ›  '),
                        key: const ValueKey('region-chain'),
                        style: MeshTheme.mono(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: MeshPalette.accent,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 18),
              ConsoleKicker(l10n.regionSetup_options),
              ConsolePanel(
                padding: const EdgeInsets.fromLTRB(16, 6, 8, 6),
                child: Column(
                  children: [
                    _OptionRow(
                      title: l10n.regionSetup_setDefault,
                      body: l10n.regionSetup_setDefaultBody,
                      value: _setDefault,
                      onChanged: (v) => _changed(() => _setDefault = v),
                    ),
                    _OptionRow(
                      title: l10n.regionSetup_legacy,
                      body: l10n.regionSetup_legacyBody,
                      value: _legacyFirmware,
                      onChanged: (v) => _changed(() => _legacyFirmware = v),
                    ),
                    _OptionRow(
                      title: l10n.regionSetup_denyUnscoped,
                      body: l10n.regionSetup_denyUnscopedBody,
                      value: _denyUnscoped,
                      warn: true,
                      onChanged: (v) => _changed(() => _denyUnscoped = v),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              ConsoleKicker(
                l10n.regionSetup_commands,
                trailing: commands.isEmpty
                    ? null
                    : TextButton.icon(
                        onPressed: () {
                          unawaited(
                            Clipboard.setData(
                              ClipboardData(text: commands.join('\n')),
                            ),
                          );
                          showDismissibleSnackBar(
                            context,
                            content: Text(l10n.regionSetup_copied),
                          );
                        },
                        icon: const Icon(Icons.copy, size: 16),
                        label: Text(l10n.regionSetup_copyAll),
                      ),
              ),
              ConsolePanel(
                padding: const EdgeInsets.all(14),
                child: commands.isEmpty
                    ? Text(
                        l10n.regionSetup_pickFirst,
                        style: TextStyle(color: MeshPalette.ink3),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < commands.length; i++)
                            _CommandLine(
                              command: commands[i],
                              state: _sent[i],
                              reply: _replies[i],
                            ),
                        ],
                      ),
              ),
              const SizedBox(height: 14),
              if (repeater != null)
                FilledButton.icon(
                  key: const ValueKey('region-send'),
                  onPressed: commands.isEmpty || _sending
                      ? null
                      : () => unawaited(_send(commands)),
                  icon: _sending
                      ? const SizedBox.square(
                          dimension: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send),
                  label: Text(l10n.regionSetup_sendTo(repeater.name)),
                )
              else
                Text(
                  l10n.regionSetup_howToSend,
                  style: TextStyle(color: MeshPalette.ink3, fontSize: 12.5),
                ),
              if (chain.isNotEmpty && ready) ...[
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () => _addToMyRegions(chain),
                  icon: const Icon(Icons.bookmark_add_outlined),
                  label: Text(l10n.regionSetup_addToMine),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionRow extends StatelessWidget {
  const _OptionRow({
    required this.title,
    required this.body,
    required this.value,
    required this.onChanged,
    this.warn = false,
  });

  final String title;
  final String body;
  final bool value;
  final bool warn;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: MeshPalette.ink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: TextStyle(
                    color: warn && value ? MeshPalette.warn : MeshPalette.ink3,
                    fontSize: 12.5,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _CommandLine extends StatelessWidget {
  const _CommandLine({required this.command, this.state, this.reply});

  final String command;
  final _SendState? state;
  final String? reply;

  @override
  Widget build(BuildContext context) {
    final (IconData? icon, Color color) = switch (state) {
      null || _SendState.pending => (null, MeshPalette.ink3),
      _SendState.sending => (Icons.more_horiz, MeshPalette.warn),
      _SendState.ok => (Icons.check, MeshPalette.signal),
      _SendState.failed => (Icons.close, MeshPalette.alert),
    };
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
            child: icon == null ? null : Icon(icon, size: 16, color: color),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  command,
                  style: MeshTheme.mono(fontSize: 13, color: MeshPalette.ink),
                ),
                if (reply != null && reply!.isNotEmpty)
                  Text(
                    reply!,
                    style: MeshTheme.mono(fontSize: 11, color: color),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
