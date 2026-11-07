import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../helpers/snack_bar_builder.dart';
import '../l10n/l10n.dart';
import '../models/contact.dart';
import '../models/contact_table_health.dart';
import '../theme/mesh_theme.dart';
import 'tactical_glass_panel.dart';

/// The radio's contact-table health for [connector], or null while the
/// radio's real limit isn't known yet.
ContactTableHealth? contactTableHealthOf(MeshCoreConnector connector) {
  if (!connector.isConnected || !connector.maxContactsReported) return null;
  return ContactTableHealth(
    used: connector.contacts.length,
    max: connector.maxContacts,
    overwriteOldest: connector.autoAddOverwriteOldest ?? false,
  );
}

/// Warns when the radio's contact list is 90% full or more, says what the
/// radio will do once it's full, and offers to free up space.
///
/// Shows nothing while the list has room or the radio's limit isn't known.
class ContactTableBanner extends StatelessWidget {
  const ContactTableBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final connector = context.watch<MeshCoreConnector>();
    final health = contactTableHealthOf(connector);
    if (health == null || !health.needsAttention) {
      return const SizedBox.shrink();
    }
    return ContactTableNotice(
      health: health,
      onFreeUp: () => showContactTableSheet(context),
    );
  }
}

/// The warning card itself, for a table that [ContactTableHealth.needsAttention].
class ContactTableNotice extends StatelessWidget {
  const ContactTableNotice({
    super.key,
    required this.health,
    required this.onFreeUp,
  });

  final ContactTableHealth health;
  final VoidCallback onFreeUp;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final isFull = health.level == ContactTableLevel.full;
    final color = isFull ? MeshPalette.alert : MeshPalette.warn;
    final title = isFull
        ? l10n.contactTable_full
        : l10n.contactTable_nearlyFull(health.percent);
    final hint = health.overwriteOldest
        ? l10n.contactTable_overwriteHint
        : l10n.contactTable_stopHint;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
      child: TacticalGlassPanel(
        padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isFull ? Icons.error_outline : Icons.warning_amber_rounded,
                  color: color,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: theme.textTheme.titleSmall),
                      Text(
                        l10n.contactTable_count(health.used, health.max),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: health.fraction,
                minHeight: 6,
                color: color,
                backgroundColor: color.withValues(alpha: 0.18),
              ),
            ),
            const SizedBox(height: 8),
            Text(hint, style: theme.textTheme.bodySmall),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton.icon(
                key: const ValueKey('contact-table-free-up'),
                onPressed: onFreeUp,
                icon: const Icon(Icons.cleaning_services_outlined),
                label: Text(l10n.contactTable_freeUp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Lists non-favorite contacts, least recently heard first, so the user can
/// pick which to remove. Nothing is removed without their confirmation.
Future<void> showContactTableSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const _ContactTableSheet(),
  );
}

class _ContactTableSheet extends StatefulWidget {
  const _ContactTableSheet();

  @override
  State<_ContactTableSheet> createState() => _ContactTableSheetState();
}

class _ContactTableSheetState extends State<_ContactTableSheet> {
  final Set<String> _selected = {};
  bool _removing = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final connector = context.watch<MeshCoreConnector>();
    final health = contactTableHealthOf(connector);
    final suggestions = contactRemovalSuggestions(connector.contacts);
    _selected.removeWhere(
      (key) => !suggestions.any((c) => c.publicKeyHex == key),
    );

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.contactTable_freeUp,
                  style: theme.textTheme.titleLarge,
                ),
                if (health != null)
                  Text(
                    l10n.contactTable_count(health.used, health.max),
                    style: theme.textTheme.bodyMedium,
                  ),
                const SizedBox(height: 4),
                Text(
                  l10n.contactTable_sheetBody,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Divider(height: 16),
          Expanded(
            child: suggestions.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        l10n.contactTable_noneToSuggest,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: scrollController,
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      final contact = suggestions[index];
                      final key = contact.publicKeyHex;
                      return CheckboxListTile(
                        key: ValueKey('contact-table-$key'),
                        value: _selected.contains(key),
                        onChanged: _removing
                            ? null
                            : (on) => setState(() {
                                if (on ?? false) {
                                  _selected.add(key);
                                } else {
                                  _selected.remove(key);
                                }
                              }),
                        title: Text(
                          contact.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          l10n.contactTable_lastHeard(
                            lastHeardText(context, contact.lastSeen),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  key: const ValueKey('contact-table-remove'),
                  onPressed: _selected.isEmpty || _removing
                      ? null
                      : () => _confirmAndRemove(connector, suggestions),
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.error,
                    foregroundColor: theme.colorScheme.onError,
                  ),
                  icon: _removing
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.delete_outline),
                  label: Text(
                    l10n.contactTable_remove(
                      _selected.isEmpty ? 1 : _selected.length,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmAndRemove(
    MeshCoreConnector connector,
    List<Contact> suggestions,
  ) async {
    final l10n = context.l10n;
    final count = _selected.length;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.contactTable_remove(count)),
        content: Text(l10n.contactTable_confirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.common_cancel),
          ),
          TextButton(
            key: const ValueKey('contact-table-remove-confirm'),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(
              l10n.common_delete,
              style: TextStyle(
                color: Theme.of(dialogContext).colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    final targets = [
      for (final c in suggestions)
        if (_selected.contains(c.publicKeyHex)) c,
    ];
    setState(() => _removing = true);
    var removed = 0;
    for (final contact in targets) {
      if (!connector.isConnected) break;
      await connector.removeContact(contact);
      removed++;
    }
    if (!mounted) return;
    setState(() {
      _removing = false;
      _selected.clear();
    });
    messenger.hideCurrentSnackBar();
    showDismissibleSnackBar(
      context,
      content: Text(l10n.contactTable_removed(removed)),
    );
  }
}

/// When a contact was last heard, in the same words the contact list uses.
String lastHeardText(BuildContext context, DateTime lastSeen) {
  final l10n = context.l10n;
  final diff = DateTime.now().difference(lastSeen);
  if (diff.isNegative || diff.inMinutes < 5) return l10n.contacts_lastSeenNow;
  if (diff.inMinutes < 60) return l10n.contacts_lastSeenMinsAgo(diff.inMinutes);
  if (diff.inHours < 24) {
    return diff.inHours == 1
        ? l10n.contacts_lastSeenHourAgo
        : l10n.contacts_lastSeenHoursAgo(diff.inHours);
  }
  return diff.inDays == 1
      ? l10n.contacts_lastSeenDayAgo
      : l10n.contacts_lastSeenDaysAgo(diff.inDays);
}
