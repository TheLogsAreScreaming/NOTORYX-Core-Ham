import 'package:flutter/material.dart';

import '../services/field_ops_service.dart';

/// Whether check-in or SOS can be used once recipients are chosen. Only a
/// missing radio, loading, a storage problem or a send in progress truly
/// block them; missing recipients are fixed by [showQuickTripSetup].
String? hardBlockReason(FieldOpsService ops) {
  if (!ops.ready) return 'Loading your trip…';
  if (ops.error != null) return 'Resolve the Field Log storage error first.';
  if (!ops.connector.isConnected) return 'Connect your radio first.';
  if (ops.busy) return 'Sending…';
  return null;
}

/// True when every trip contact is known and there is at least one.
bool hasCheckInContacts(FieldOpsService ops) =>
    ops.trip.members.isNotEmpty &&
    ops.members.length == ops.trip.members.length;

/// True when an SOS has somewhere to go.
bool hasSosTarget(FieldOpsService ops) =>
    hasCheckInContacts(ops) || ops.sosChannel != null;

/// Asks who should get check-ins and SOS, and saves it to the trip. Returns
/// true when there is now somewhere to send ([forSos] also accepts just a
/// channel).
Future<bool> showQuickTripSetup(
  BuildContext context,
  FieldOpsService ops, {
  required bool forSos,
}) async {
  final saved = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _QuickTripSetup(ops: ops, forSos: forSos),
  );
  return saved == true;
}

class _QuickTripSetup extends StatefulWidget {
  final FieldOpsService ops;
  final bool forSos;
  const _QuickTripSetup({required this.ops, required this.forSos});

  @override
  State<_QuickTripSetup> createState() => _QuickTripSetupState();
}

class _QuickTripSetupState extends State<_QuickTripSetup> {
  late final Set<String> _chosen = {
    for (final c in widget.ops.members) c.publicKeyHex,
  };
  late int _channel = widget.ops.sosChannel?.index ?? -1;

  bool get _canSave => _chosen.isNotEmpty || (widget.forSos && _channel >= 0);

  Future<void> _save() async {
    final ops = widget.ops;
    await ops.configureTrip(
      ops.trip.copyWith(members: _chosen.toList(), sosChannel: _channel),
    );
    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final ops = widget.ops;
    final contacts = ops.eligibleContacts;
    final channels = ops.connector.channels.where((c) => !c.isEmpty).toList();
    final theme = Theme.of(context);
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.85,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Column(
            key: const ValueKey('quick-trip-setup'),
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.forSos
                    ? 'Who should get your SOS?'
                    : 'Who should get your check-ins?',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                widget.forSos
                    ? 'Pick people you trust, a channel, or both. You can change this later in Plan trip.'
                    : 'Pick up to six people. They also get your SOS. You can change this later in Plan trip.',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    if (contacts.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'No people in your contacts yet. Once someone shares their contact or you hear their advert, they appear here.',
                        ),
                      ),
                    for (final c in contacts)
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(c.name),
                        value: _chosen.contains(c.publicKeyHex),
                        onChanged: (v) => setState(() {
                          if (v == true && _chosen.length < 6) {
                            _chosen.add(c.publicKeyHex);
                          } else if (v == false) {
                            _chosen.remove(c.publicKeyHex);
                          }
                        }),
                      ),
                    if (channels.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      DropdownButtonFormField<int>(
                        initialValue: channels.any((c) => c.index == _channel)
                            ? _channel
                            : -1,
                        decoration: const InputDecoration(
                          labelText: 'SOS also goes to channel',
                          helperText:
                              'Everyone on that channel will see your SOS.',
                        ),
                        items: [
                          const DropdownMenuItem(
                            value: -1,
                            child: Text('None'),
                          ),
                          for (final c in channels)
                            DropdownMenuItem(
                              value: c.index,
                              child: Text(c.name),
                            ),
                        ],
                        onChanged: (v) => setState(() => _channel = v ?? -1),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 12),
              FilledButton(
                key: const ValueKey('quick-trip-save'),
                onPressed: _canSave ? _save : null,
                child: Text(widget.forSos ? 'Save and send SOS' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
