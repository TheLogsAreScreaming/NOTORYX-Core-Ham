import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../models/contact.dart';
import '../models/message.dart';
import '../storage/prefs_manager.dart';
import '../theme/mesh_theme.dart';

const _dismissedKey = 'notoryx_add_first_dismissed_v1';

/// A note at the top of a direct chat until the other person has written
/// back: MeshCore direct messages are encrypted to each other's keys, so
/// they can only read and answer you once they've added you as a contact.
/// It goes away for good once they reply or you dismiss it.
class AddFirstBanner extends StatefulWidget {
  const AddFirstBanner({
    super.key,
    required this.contact,
    required this.messages,
  });

  final Contact contact;
  final List<Message> messages;

  @override
  State<AddFirstBanner> createState() => _AddFirstBannerState();
}

class _AddFirstBannerState extends State<AddFirstBanner> {
  List<String> get _dismissed =>
      PrefsManager.instance.getStringList(_dismissedKey) ?? const [];

  Future<void> _dismiss() async {
    await PrefsManager.instance.setStringList(_dismissedKey, [
      ..._dismissed,
      widget.contact.publicKeyHex,
    ]);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final heardFrom = widget.messages.any((m) => !m.isOutgoing);
    if (heardFrom || _dismissed.contains(widget.contact.publicKeyHex)) {
      return const SizedBox.shrink();
    }
    return Container(
      key: const ValueKey('add-first-banner'),
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
      decoration: BoxDecoration(
        color: MeshPalette.accentBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MeshPalette.accentLine),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: MeshPalette.accent, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              context.l10n.chat_addFirstBanner(widget.contact.name),
              style: TextStyle(color: MeshPalette.ink, fontSize: 13),
            ),
          ),
          IconButton(
            tooltip: context.l10n.common_hide,
            icon: const Icon(Icons.close, size: 18),
            onPressed: _dismiss,
          ),
        ],
      ),
    );
  }
}
