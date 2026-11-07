import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../helpers/snack_bar_builder.dart';
import '../l10n/l10n.dart';
import '../models/access_control.dart';
import '../models/contact.dart';
import '../services/access_control_service.dart';
import '../services/repeater_command_service.dart';
import '../theme/mesh_theme.dart';
import '../widgets/empty_state.dart';
import '../widgets/mesh_ui.dart';

/// Lets an admin see and change who can log in to a repeater or room server
/// without the password, and with which role.
class AccessControlScreen extends StatefulWidget {
  final Contact node;

  /// Overrides the service built from the connector; for tests.
  final AccessControlService? service;

  const AccessControlScreen({super.key, required this.node, this.service});

  @override
  State<AccessControlScreen> createState() => _AccessControlScreenState();
}

/// An access-list entry with whatever we know about who it is.
class _ResolvedEntry {
  final AclEntry entry;
  final Contact? contact;
  final bool isSelf;

  /// The full public key when known; `setperm` needs it for a role change.
  final Uint8List? fullKey;

  const _ResolvedEntry({
    required this.entry,
    required this.contact,
    required this.isSelf,
    required this.fullKey,
  });
}

class _AccessControlScreenState extends State<AccessControlScreen> {
  RepeaterCommandService? _ownCommands;
  late final AccessControlService _service;
  List<AclEntry>? _entries;
  bool _complete = true;
  bool _loading = false;
  bool _busy = false;
  bool _timedOut = false;

  bool get _isRoom => widget.node.type == advTypeRoom;

  /// Room servers keep and list only admins, so that is the only role offered.
  List<AclRole> get _roles => _isRoom
      ? const [AclRole.admin]
      : const [AclRole.readOnly, AclRole.readWrite, AclRole.admin];

  @override
  void initState() {
    super.initState();
    final injected = widget.service;
    if (injected != null) {
      _service = injected;
    } else {
      final connector = context.read<MeshCoreConnector>();
      _ownCommands = RepeaterCommandService(connector);
      _service = AccessControlService(connector, _ownCommands!);
    }
    unawaited(_load());
  }

  @override
  void dispose() {
    _ownCommands?.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _timedOut = false;
    });
    try {
      final result = await _service.fetch(widget.node);
      if (!mounted) return;
      setState(() {
        _entries = result.entries;
        _complete = result.complete;
      });
    } on TimeoutException {
      if (!mounted) return;
      setState(() => _timedOut = true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _roleLabel(AclRole role) {
    final l10n = context.l10n;
    switch (role) {
      case AclRole.readOnly:
        return l10n.accessControl_roleReadOnly;
      case AclRole.readWrite:
        return l10n.accessControl_roleReadWrite;
      case AclRole.admin:
        return l10n.accessControl_roleAdmin;
      case AclRole.guest:
        return l10n.accessControl_remove;
    }
  }

  List<_ResolvedEntry> _resolve(MeshCoreConnector connector) {
    final contacts = connector.allContactsUnfiltered;
    final selfKey = connector.selfPublicKey;
    return [
      for (final entry in _entries ?? const <AclEntry>[])
        () {
          final isSelf = selfKey != null && entry.matches(selfKey);
          Contact? contact;
          for (final c in contacts) {
            if (entry.matches(c.publicKey)) {
              contact = c;
              break;
            }
          }
          return _ResolvedEntry(
            entry: entry,
            contact: contact,
            isSelf: isSelf,
            fullKey: isSelf ? selfKey : contact?.publicKey,
          );
        }(),
    ];
  }

  String _nameFor(_ResolvedEntry e) {
    if (e.isSelf) return context.l10n.accessControl_you;
    return e.contact?.name ?? context.l10n.accessControl_unknownNode;
  }

  Future<void> _apply(Uint8List key, AclRole role) async {
    final l10n = context.l10n;
    setState(() => _busy = true);
    try {
      await _service.setRole(widget.node, key, role);
      if (!mounted) return;
      showDismissibleSnackBar(context, content: Text(l10n.accessControl_saved));
      await _load();
    } on AccessControlException catch (e) {
      if (!mounted) return;
      // Firmware before prefix support refuses role changes by key prefix.
      final prefixRefused = key.length < 32 && role != AclRole.guest;
      showDismissibleSnackBar(
        context,
        content: Text(
          prefixRefused
              ? l10n.accessControl_prefixUnsupported
              : l10n.accessControl_failed(e.reply),
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (e) {
      if (!mounted) return;
      showDismissibleSnackBar(
        context,
        content: Text(l10n.accessControl_failed('$e')),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _confirmRemove(_ResolvedEntry e) async {
    final l10n = context.l10n;
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.accessControl_remove),
        content: Text(
          e.isSelf
              ? l10n.accessControl_removeSelfWarning
              : l10n.accessControl_removeConfirm(_nameFor(e)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.common_cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
              foregroundColor: Theme.of(dialogContext).colorScheme.onError,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.accessControl_remove),
          ),
        ],
      ),
    );
    if (ok == true) {
      // Removal works with the 6-byte prefix when the full key is unknown.
      await _apply(e.fullKey ?? e.entry.keyPrefix, AclRole.guest);
    }
  }

  void _showEntrySheet(_ResolvedEntry e) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    // Without the full key, newer firmware still accepts the 6-byte prefix.
    final key = e.fullKey ?? e.entry.keyPrefix;
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 8),
                child: Text(
                  _nameFor(e),
                  style: Theme.of(sheetContext).textTheme.titleMedium,
                ),
              ),
              if (e.fullKey == null)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 8),
                  child: Text(
                    l10n.accessControl_unknownKeyNote,
                    style: TextStyle(color: scheme.onSurfaceVariant),
                  ),
                ),
              if (_roles.length > 1)
                for (final role in _roles)
                  ListTile(
                    minTileHeight: 56,
                    title: Text(_roleLabel(role)),
                    trailing: role == e.entry.role
                        ? Icon(Icons.check, color: scheme.primary)
                        : null,
                    selected: role == e.entry.role,
                    onTap: () {
                      Navigator.pop(sheetContext);
                      if (role != e.entry.role) _apply(key, role);
                    },
                  ),
              ListTile(
                minTileHeight: 56,
                leading: Icon(
                  Icons.person_remove_outlined,
                  color: scheme.error,
                ),
                title: Text(
                  l10n.accessControl_remove,
                  style: TextStyle(color: scheme.error),
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _confirmRemove(e);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showAddSheet(MeshCoreConnector connector) async {
    final l10n = context.l10n;
    final listed = _entries ?? const <AclEntry>[];
    final candidates =
        connector.allContactsUnfiltered
            .where((c) => c.type == advTypeChat)
            .where((c) => !listed.any((e) => e.matches(c.publicKey)))
            .toList()
          ..sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
          );

    final contact = await showModalBottomSheet<Contact>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.7,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 8),
                child: Text(
                  l10n.accessControl_pickContact,
                  style: Theme.of(sheetContext).textTheme.titleMedium,
                ),
              ),
              if (candidates.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(l10n.accessControl_noContacts),
                )
              else
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: candidates.length,
                    itemBuilder: (_, i) => ListTile(
                      minTileHeight: 56,
                      leading: AvatarCircle(name: candidates[i].name),
                      title: Text(candidates[i].name),
                      onTap: () => Navigator.pop(sheetContext, candidates[i]),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
    if (contact == null || !mounted) return;

    AclRole? role = _roles.length == 1 ? _roles.single : null;
    role ??= await showModalBottomSheet<AclRole>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final r in _roles)
              ListTile(
                minTileHeight: 56,
                title: Text(_roleLabel(r)),
                onTap: () => Navigator.pop(sheetContext, r),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (role == null || !mounted) return;
    await _apply(contact.publicKey, role);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final connector = context.watch<MeshCoreConnector>();
    final resolved = _resolve(connector);
    final entries = _entries;
    final maybeIncomplete = entries != null && !_complete;

    Widget body;
    if (entries == null && _loading) {
      body = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(l10n.accessControl_loading),
          ],
        ),
      );
    } else if (entries == null) {
      body = EmptyState(
        icon: Icons.portable_wifi_off,
        title: l10n.accessControl_timeout,
        action: FilledButton.icon(
          onPressed: _load,
          icon: const Icon(Icons.refresh),
          label: Text(l10n.accessControl_refresh),
        ),
      );
    } else {
      body = RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 96),
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 8),
              child: Text(
                _isRoom
                    ? l10n.accessControl_explainRoom
                    : l10n.accessControl_explainRepeater,
                style: TextStyle(color: scheme.onSurfaceVariant),
              ),
            ),
            if (maybeIncomplete)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: MeshPalette.warn),
                    const SizedBox(width: 8),
                    Expanded(child: Text(l10n.accessControl_maybeIncomplete)),
                  ],
                ),
              ),
            if (_timedOut)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Text(
                  l10n.accessControl_timeout,
                  style: TextStyle(color: scheme.error),
                ),
              ),
            if (resolved.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 48),
                child: EmptyState(
                  icon: Icons.admin_panel_settings_outlined,
                  title: l10n.accessControl_empty,
                  subtitle: l10n.accessControl_emptyHint,
                ),
              ),
            for (final e in resolved)
              _EntryTile(
                name: _nameFor(e),
                // Initials only mean something for a real contact name.
                icon: e.isSelf
                    ? Icons.person
                    : (e.contact == null ? Icons.help_outline : null),
                keyPrefixHex: pubKeyToHex(e.entry.keyPrefix),
                roleLabel: _roleLabel(e.entry.role),
                enabled: !_busy,
                onTap: () => _showEntrySheet(e),
              ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.accessControl_title),
        actions: [
          IconButton(
            tooltip: l10n.accessControl_refresh,
            onPressed: _loading || _busy ? null : _load,
            icon: const Icon(Icons.refresh),
          ),
        ],
        bottom: _loading || _busy
            ? const PreferredSize(
                preferredSize: Size.fromHeight(2),
                child: LinearProgressIndicator(minHeight: 2),
              )
            : null,
      ),
      body: body,
      floatingActionButton: entries == null
          ? null
          : FloatingActionButton.extended(
              onPressed: _busy ? null : () => _showAddSheet(connector),
              icon: const Icon(Icons.person_add_alt_1),
              label: Text(l10n.accessControl_add),
            ),
    );
  }
}

class _EntryTile extends StatelessWidget {
  final String name;
  final IconData? icon;
  final String keyPrefixHex;
  final String roleLabel;
  final bool enabled;
  final VoidCallback onTap;

  const _EntryTile({
    required this.name,
    required this.icon,
    required this.keyPrefixHex,
    required this.roleLabel,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: enabled ? onTap : null,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: scheme.outlineVariant)),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 68),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 10, 16, 10),
            child: Row(
              children: [
                AvatarCircle(name: name, size: 44, icon: icon),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        keyPrefixHex,
                        style: MeshTheme.mono(
                          fontSize: 12,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(MeshRadii.pill),
                  ),
                  child: Text(
                    roleLabel,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
