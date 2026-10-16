import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../helpers/share_links.dart';
import '../models/contact.dart';

/// The radio's advertised position as a map-marker message, or null when
/// the radio has none.
String? myPositionMessage(MeshCoreConnector connector) {
  final lat = connector.selfLatitude;
  final lon = connector.selfLongitude;
  if (lat == null || lon == null || (lat == 0 && lon == 0)) return null;
  final name = connector.selfName;
  return positionMarker(
    lat,
    lon,
    name == null || name.isEmpty ? 'My position' : '$name position',
  );
}

/// Lets the user pick one of their contacts and returns its share link.
Future<String?> pickContactToShare(BuildContext context) async {
  final connector = context.read<MeshCoreConnector>();
  final contacts = [...connector.contacts]
    ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  final picked = await showModalBottomSheet<Contact>(
    context: context,
    isScrollControlled: true,
    builder: (sheetContext) => SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(sheetContext).size.height * 0.7,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Text(
                'Share a contact',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                'Sends its name and public key as a link anyone can tap to add it.',
              ),
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (final c in contacts)
                    ListTile(
                      leading: Icon(_typeIcon(c.type)),
                      title: Text(c.name),
                      subtitle: Text(
                        '${ContactLink(c.name, c.publicKey, c.type).typeLabel} • ${c.publicKeyHex.substring(0, 8).toUpperCase()}',
                      ),
                      onTap: () => Navigator.pop(sheetContext, c),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
  return picked == null ? null : contactLinkFor(picked);
}

IconData _typeIcon(int type) => switch (type) {
  advTypeRepeater => Icons.cell_tower,
  advTypeRoom => Icons.meeting_room_outlined,
  advTypeSensor => Icons.sensors,
  _ => Icons.person_outline,
};

/// A shared contact in a chat bubble, with a button to add it.
class ContactLinkCard extends StatefulWidget {
  final ContactLink link;
  final Color textColor;
  const ContactLinkCard({
    super.key,
    required this.link,
    required this.textColor,
  });

  @override
  State<ContactLinkCard> createState() => _ContactLinkCardState();
}

class _ContactLinkCardState extends State<ContactLinkCard> {
  bool _adding = false;

  @override
  Widget build(BuildContext context) {
    final connector = context.watch<MeshCoreConnector>();
    final link = widget.link;
    final known = connector.contacts.any(
      (c) => c.publicKeyHex.toLowerCase() == link.publicKeyHex.toLowerCase(),
    );
    final mine =
        connector.selfPublicKeyHex.toLowerCase() ==
        link.publicKeyHex.toLowerCase();
    return Column(
      key: const ValueKey('contact-link-card'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_typeIcon(link.type), size: 20, color: widget.textColor),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                link.name,
                style: TextStyle(
                  color: widget.textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        Text(
          '${link.typeLabel} • ${link.publicKeyHex.substring(0, 8).toUpperCase()}',
          style: TextStyle(color: widget.textColor, fontSize: 12),
        ),
        const SizedBox(height: 6),
        if (mine)
          Text('This is you.', style: TextStyle(color: widget.textColor))
        else if (known)
          Text(
            'Already in your contacts.',
            style: TextStyle(color: widget.textColor),
          )
        else
          FilledButton.tonalIcon(
            onPressed: _adding || !connector.isConnected ? null : _add,
            icon: const Icon(Icons.person_add_alt_1, size: 18),
            label: Text(_adding ? 'Adding…' : 'Add contact'),
          ),
      ],
    );
  }

  Future<void> _add() async {
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _adding = true);
    try {
      await context.read<MeshCoreConnector>().addContactFromLink(widget.link);
      messenger.showSnackBar(
        SnackBar(content: Text('Added ${widget.link.name}.')),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Could not add ${widget.link.name}: $e')),
      );
    } finally {
      if (mounted) setState(() => _adding = false);
    }
  }
}
