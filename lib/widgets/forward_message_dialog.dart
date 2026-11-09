import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connector/meshcore_connector.dart';
import '../connector/meshcore_protocol.dart';
import '../helpers/snack_bar_builder.dart';
import '../l10n/l10n.dart';
import '../models/channel.dart';
import '../models/contact.dart';
import '../models/forwarded_message.dart';
import '../services/operator_profile_service.dart';

/// Lets the operator forward a message under their own call sign. Nothing is
/// sent until they choose a destination and press Send.
Future<void> showForwardMessageDialog(
  BuildContext context, {
  required String from,
  required String body,
}) => showDialog<void>(
  context: context,
  builder: (_) => _ForwardDialog(from: from, body: body),
);

class _ForwardDialog extends StatefulWidget {
  const _ForwardDialog({required this.from, required this.body});

  final String from;
  final String body;

  @override
  State<_ForwardDialog> createState() => _ForwardDialogState();
}

class _ForwardDialogState extends State<_ForwardDialog> {
  late final _body = TextEditingController(text: widget.body);

  /// A [Contact] or a [Channel].
  Object? _target;
  var _sending = false;

  @override
  void dispose() {
    _body.dispose();
    super.dispose();
  }

  Future<void> _send(MeshCoreConnector radio, String text) async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final l10n = context.l10n;
    setState(() => _sending = true);
    try {
      switch (_target) {
        case final Contact contact:
          await radio.sendMessage(contact, text);
        case final Channel channel:
          await radio.sendChannelMessage(channel, text);
      }
      messenger.showSnackBar(SnackBar(content: Text(l10n.forward_sent)));
      navigator.pop();
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(friendlyError(e))));
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final radio = context.watch<MeshCoreConnector>();
    final profile = context.watch<OperatorProfileService>().profile;
    final targets = <Object>[
      ...radio.contacts.where((c) => c.type == advTypeChat),
      ...radio.channels.where((c) => !c.isEmpty),
    ];
    final text = forwardedText(
      callsign: profile.callsign,
      from: widget.from,
      body: _body.text,
    );
    final limit = _target is Channel
        ? maxChannelMessageBytes(radio.selfName)
        : maxContactMessageBytes();
    final over = utf8.encode(text).length - limit;
    final blocked = !profile.hasValidCallsign
        ? l10n.forward_needCallsign
        : over > 0
        ? l10n.forward_tooLong(over)
        : null;
    final canSend =
        blocked == null &&
        _target != null &&
        _body.text.trim().isNotEmpty &&
        radio.isConnected &&
        !_sending;

    return AlertDialog(
      title: Text(l10n.forward_title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<Object>(
              key: const ValueKey('forward-target'),
              isExpanded: true,
              initialValue: _target,
              decoration: InputDecoration(labelText: l10n.forward_to),
              items: [
                for (final t in targets)
                  DropdownMenuItem(
                    value: t,
                    child: Text(
                      t is Contact ? t.name : (t as Channel).name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
              onChanged: (v) => setState(() => _target = v),
            ),
            const SizedBox(height: 10),
            TextField(
              key: const ValueKey('forward-body'),
              controller: _body,
              maxLines: null,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 10),
            if (profile.hasValidCallsign) SelectableText(text),
            if (blocked != null) ...[const SizedBox(height: 8), Text(blocked)],
            const SizedBox(height: 8),
            Text(l10n.forward_hint),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.common_cancel),
        ),
        FilledButton(
          key: const ValueKey('forward-send'),
          onPressed: canSend ? () => _send(radio, text) : null,
          child: Text(l10n.forward_send),
        ),
      ],
    );
  }
}
