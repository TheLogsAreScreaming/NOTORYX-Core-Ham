import 'dart:convert';

import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../storage/prefs_manager.dart';
import '../theme/mesh_theme.dart';
import 'mesh_ui.dart';

const _key = 'notoryx_quick_messages_v1';

/// Ready-made messages for the message box. Until you change them, the
/// list is a set of defaults in your language; once you add or remove one,
/// your own list is kept.
List<String> quickMessages(BuildContext context) =>
    savedQuickMessages() ?? defaultQuickMessages(context);

List<String> defaultQuickMessages(BuildContext context) {
  final l10n = context.l10n;
  return [
    l10n.quick_ok,
    l10n.quick_onMyWay,
    l10n.quick_atCamp,
    l10n.quick_runningLate,
    l10n.quick_needHelp,
    l10n.quick_copyThat,
  ];
}

/// Your own list, or null while you're on the defaults.
List<String>? savedQuickMessages() {
  final raw = PrefsManager.instance.getString(_key);
  if (raw == null) return null;
  try {
    final data = jsonDecode(raw);
    if (data is! List) return null;
    return [
      for (final m in data)
        if (m is String && m.trim().isNotEmpty) m,
    ];
  } catch (_) {
    return null;
  }
}

Future<void> saveQuickMessages(List<String>? messages) => messages == null
    ? PrefsManager.instance.remove(_key)
    : PrefsManager.instance.setString(_key, jsonEncode(messages));

/// Lets you pick a quick message, and add, remove or reset them. Returns
/// the one picked, for the message box; it isn't sent until you send it.
Future<String?> pickQuickMessage(BuildContext context) =>
    showMeshSheet<String>(context, builder: (_) => const _QuickMessagesSheet());

class _QuickMessagesSheet extends StatefulWidget {
  const _QuickMessagesSheet();

  @override
  State<_QuickMessagesSheet> createState() => _QuickMessagesSheetState();
}

class _QuickMessagesSheetState extends State<_QuickMessagesSheet> {
  final _add = TextEditingController();
  bool _editing = false;

  @override
  void dispose() {
    _add.dispose();
    super.dispose();
  }

  Future<void> _save(List<String>? list) async {
    await saveQuickMessages(list);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final list = quickMessages(context);
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BottomSheetHeader(
              title: l10n.quick_title,
              trailing: TextButton(
                key: const ValueKey('quick-edit'),
                onPressed: () => setState(() => _editing = !_editing),
                child: Text(_editing ? l10n.common_done : l10n.common_edit),
              ),
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  if (list.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(MeshSpace.lg),
                      child: Text(
                        l10n.quick_empty,
                        style: TextStyle(color: MeshPalette.ink3),
                      ),
                    ),
                  for (final (i, m) in list.indexed)
                    ListTile(
                      key: ValueKey('quick-$i'),
                      leading: const Icon(Icons.bolt_outlined),
                      title: Text(m),
                      onTap: _editing ? null : () => Navigator.pop(context, m),
                      trailing: _editing
                          ? IconButton(
                              tooltip: l10n.common_remove,
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => _save([...list]..removeAt(i)),
                            )
                          : null,
                    ),
                ],
              ),
            ),
            if (_editing)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  MeshSpace.lg,
                  MeshSpace.sm,
                  MeshSpace.lg,
                  MeshSpace.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      key: const ValueKey('quick-add-field'),
                      controller: _add,
                      maxLength: 120,
                      decoration: InputDecoration(
                        labelText: l10n.quick_add,
                        suffixIcon: IconButton(
                          key: const ValueKey('quick-add'),
                          tooltip: l10n.common_add,
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            final text = _add.text.trim();
                            if (text.isEmpty) return;
                            _add.clear();
                            _save([...list, text]);
                          },
                        ),
                      ),
                    ),
                    if (savedQuickMessages() != null)
                      TextButton(
                        onPressed: () => _save(null),
                        child: Text(l10n.quick_reset),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
